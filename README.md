##regfish-dynamicdns-updater

A simple windows command line batch to make dynamic updates to regfish dns hosting.

##Why this script
I'm running a small development machine on a netbook.
When doin gweb devlopment it is more easy to always use the same hostname when accessing the machine.
So i created a windows command line bacth script to update an AAA record at the regfish dns services.

##Setup

* Copy the file `xxx.cmd` to a location on your hardrive.
* Get the 3rd party curl.exe binaries to actually sumbit the web request.
* Open the `xxx.cmd` file in notepad and change the setting to meet your token and hostname

The script has experimental support for a proxy server but at this time cannot cope with web proxies that need authentication.

