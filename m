Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1AG05b8007862
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2012 11:00:05 -0500
Subject: Re: SE Android release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1325884109.28294.65.camel@moss-pluto>
References: <1325884109.28294.65.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 10 Feb 2012 11:00:05 -0500
Message-ID: <1328889605.18498.47.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-01-06 at 16:08 -0500, Stephen Smalley wrote:
> Hi,
> 
> We have made an initial public release of SE Android. More information
> is available at:
> http://selinuxproject.org/page/SEAndroid

We have updated the source code repositories.  A repo sync -j1 will
refresh your copy of the source code if you already have a copy.

The major change since the last update is that there is now support for
setting file security contexts in OTA and update packages.  This
includes changes to the bootable/recovery, build, and system/extras
projects.  To test, you can build the images, reflash the recovery
partition with the new recovery image, do a 'make dist' to generate an
ota .zip file, push the .zip file to the /sdcard via adb, and then
reboot into recovery and apply the update from the .zip file.  The
resulting updated image should have security contexts set properly on
its files, as shown by ls -Z /system.

Also, for users who are unable to use the git protocol to access the
source code repositories due to firewall restrictions, we have added
instructions on the wiki and an alternate local_manifest.xml file for
downloading via http only.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
