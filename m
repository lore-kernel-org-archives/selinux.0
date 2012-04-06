Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q36IiEmc003505
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2012 14:44:14 -0400
Subject: Re: SE Android release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1325884109.28294.65.camel@moss-pluto>
References: <1325884109.28294.65.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 06 Apr 2012 14:44:15 -0400
Message-ID: <1333737855.4996.149.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-01-06 at 16:08 -0500, Stephen Smalley wrote:
> Hi,
> 
> We have made an initial public release of SE Android. More information
> is available at:
> http://selinuxproject.org/page/SEAndroid

We have made further updates to the source code repositories and the
wiki page. You can refresh your sources by downloading the latest
local_manifest.xml file, dropping it into your .repo subdirectory, and
running repo sync -j1.  The changes since the last update are:

- Merged the latest AOSP master branch.  The emulator build and bionic
deadlock issues in AOSP that were previously mentioned have been
resolved.  The SE Android changes for system/extras and
bootable/recovery related to labeling of files in ext4 images have been
merged into the AOSP master branch.  Some of the SE Android changes have
been revised based on further feedback and re-uploaded to AOSP.

- Created seandroid-4.0.3 and seandroid-4.0.4 branches relative to
android-4.0.3_r1 and android-4.0.4_r1.1 for users who want to use a
stable release of Android as their baseline and do not wish to track
master.  The instructions on the wiki page have been updated
accordingly.

- Reverted the changes to installd and Installer.java to support
reloading of seapp_contexts via a new installd socket command.  Instead,
the init.rc was modified to restart installd in addition to ueventd when
the selinux.loadpolicy property is set.  Thus, if you drop new policy
files under /data/system and set the selinux.loadpolicy property to 1,
init will reload the kernel policy and any other policy files it uses,
and both ueventd and installd will be restarted to pick up the new
policy configurations relevant to their operation.

- Added SELinux/MAC permission checking and labeling for the init
property service.  This is the second example of a SELinux userspace
object manager for Android (the first being the zygote).  There is a new
property_contexts configuration in the policy for labeling properties,
along with an associated selabel backend in libselinux for looking up
the property contexts.  Device-specific properties may be placed in a
sepolicy.pc file under one of the device-specific directories.

- Updated the SEAndroidManager app to save settings immediately (not
just on a clean shutdown), to handle the SELinux disabled and no
booleans cases gracefully, and to remove unneeded libraries.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
