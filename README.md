## regfish-dynamicdns-updater

A simple windows command line batch to make dynamic updates to regfish dns hosting.

## Why this script
I'm running a small development machine on a netbook.
When doing web devlopment it is more easy to always use the same hostname when accessing the machine instead of getting the ip address within the local network.
So i created a windows command line batch script to update an AAA record at the regfish dns services.

## Setup

* Copy the file `regfish-dynamicdns-updater.cmd` to a folder on your hardrive.
* Get the 3rd party _curl.exe_ binary to actually sumbit the web request. Use your favorite search engine to find it. You may find one at [https://curl.haxx.se/download.html](https://curl.haxx.se/download.html)
* Open the `regfish-dynamicdns-updater.cmd` file in notepad, scroll down and change the setting to meet your token and hostname

The enviornment variables you need to change are:

* TOKEN: Use your token from the regfish dynamic dns configuration page
* FQDN: Use you fully qualified domain name that will be updated using the local ip.

Here an example:

    SET "TOKEN=8459845739f8e987878874934487243"
    SET "FQDN=webdevelop.mydomain.org"

## Caveats

* The script has experimental support for a proxy server but at this time cannot cope with web proxies that need authentication.
* I first tried to determine the ip address by using _ipconfig_ but got trouble parsing the output. Most notably when there is more than one network interface. Getting the ip address might not reliable work when the machine has multiple active network interfaces. i.e. wired and wireless network.

## Advice
Please keep in mind that the batch file contains your secret token used to update your dns entries. So keep the script at a safe place and limit access to it using windows filesystem security.

If you think the token has been leaked to anyone you need to change the token on the regfish configuraiton page and update it in the script (and of course other hosts using the dyndns update technique of regfish).




