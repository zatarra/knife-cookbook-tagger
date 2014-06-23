#
# Author:: Marius Ducea (<marius.ducea@gmail.com>)
# Copyright:: Copyright (c) 2013 Marius Ducea
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module ServerCookbookTagger
  class CookbookTaggerVersions < Chef::Knife

    deps do
      require 'fileutils'
      require 'chef/api_client'
      require 'chef/cookbook_loader'
      require 'chef/knife/cookbook_download'
    end

    banner "knife cookbooktagger cookbook [original] <target>"

    option :cookbook,
     :short => "-C",
     :long => "--cookbook",
     :description => "The cookbook name.",
     :boolean => false,
     :required => true
    
    option :original,
     :short => "-o",
     :long => "--original",
     :description => "The cookbook version to used as base.",
     :boolean => false,
     :required => true

    option :target,
     :short => "-t",
     :long => "--target",
     :description => "The new cookbook version to be created.",
     :boolean => false,
     :required => false,
     :default => false

    def run
      cookbooks
    end

    def cookbooks
      ui.msg "Checking current current cookbook versions"
      all_cookbooks = rest.get_rest("/cookbooks/" + cookbook + "?num_versions=all")
      
      # All cookbooks
      cbv = all_cookbooks.inject({}) do |collected, ( cookbook, versions )|
        collected[cookbook] = versions["versions"].map {|v| v['version']}
        collected
      end
      
      # Get the latest cookbooks
      latest = latest_cookbooks.inject({}) do |collected, ( cookbook, versions )|
        collected[cookbook] = versions["versions"].map {|v| v['version']}
        collected
      end
      
      latest.each_key do |cb|
        cbv[cb].delete(latest[cb][0])
      end
      
      # Let see what cookbooks we have in use in all environments
      Chef::Environment.list.each_key do |env_list|
        env = Chef::Environment.load(env_list)
        next unless !env.cookbook_versions.empty?
        env.cookbook_versions.each_key do |cb|
          cb_ver = env.cookbook_versions[cb].split(" ").last
          begin
            cbv[cb].delete(cb_ver)
          rescue
            "Skipping..."
          end
        end
      end
      
    end
    
    def FAZCENAS(cb,cb_ver,dir)
      ui.msg "\nFist backing up cookbook #{cb} version #{cb_ver}"
      FileUtils.mkdir_p(dir)
      dld = Chef::Knife::CookbookDownload.new
      dld.name_args = [cb, cb_ver]
      dld.config[:download_directory] = dir
      dld.config[:force] = true
      begin
        dld.run
      rescue
        ui.msg "Failed to download cookbook #{cb} version #{cb_ver}... Skipping"
        FileUtils.rm_r(File.join(dir, cb + "-" + cb_ver))
      end
    end
  end
end
