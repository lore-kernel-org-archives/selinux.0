Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2KE9WtQ005865
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2012 10:09:32 -0400
Subject: Re: SE Android release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1325884109.28294.65.camel@moss-pluto>
References: <1325884109.28294.65.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Mar 2012 10:09:32 -0400
Message-ID: <1332252572.693.56.camel@moss-pluto>
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
wiki page.  You can refresh your sources by downloading the latest
local_manifest.xml file, dropping it into your .repo subdirectory, and
running repo sync -j1. The changes since the last update are:

- Merged the latest AOSP master branch.  There are two caveats regarding
the current state of AOSP master: we had to revert the 64-bit emulator
change (c7389bd) from external/qemu in order to build, and we had to
apply https://android-review.googlesource.com/#/c/34210/ to bionic in
order to resolve a deadlock during boot.  These issues have been
reported to AOSP and are not related to SE Android in any way.

- Merged Bryan Hinton's patches for the Galaxy Nexus, along with a
cleanup by William Roberts.  Some of the policy changes were directly
integrated into the base policy, while others were left in the
per-device sepolicy.* files.  Also defined HAVE_SELINUX := true in the
tuna BoardConfig.mk so that it will be enabled by default.

- Moved the SELinux management functionality out of the Settings app and
into a new SEAndroidManager app.  The Settings app now only displays the
SELinux status under About phone.  Setting the SELinux enforcing mode
and booleans can only be done via the SEAndroidManager app.  Further,
the SEAndroidManager app now saves the enforcing status and booleans on
a (clean) shutdown and restores them at boot so that they are preserved
across a power cycle. Work is in progress to save the settings
immediately so that they will be preserved even upon a low-level reboot
(e.g. adb reboot), and work is planned to migrate more of the
functionality into the framework services so that the app can ultimately
run without the system UID.

- Added preliminary support for loading policy files from /data/system
in order to support runtime policy updates, and for notifying various
components to reload their policy files.  This is still work in
progress, but provides the first stages of the underlying infrastructure
support for runtime policy management of the device. You can exercise a
portion of this functionality by copying policy files under /data/system
and can trigger a policy reload at runtime by setting the
selinux.loadpolicy property to 1 (setprop selinux.loadpolicy 1 from
init.rc or an adb shell). There is also support for notifying installd
of an updated seapp_contexts configuration via its command socket, and
an interface in Installer.java for use by the framework services to
perform this notification when a new seapp_contexts file is installed
to /data/system.  This interface is not yet being used, but would
ultimately be leveraged by the DevicePolicyManager service.

- Added a restorecon JNI binding for use by the framework services to
restore the security context of files, and modified the
PackageManagerService and WallpaperManagerService to use it.  In the
case of the PackageManagerService, restorecon is invoked to label the
vmdl*.tmp files created when installing packages with a type
(apk_tmp_file) that is writable by the client app, and restorecon is
then invoked again when the file is renamed to the final apk file so
that the final apk file is protected against subsequent access.  This
avoids the need to allow write access to the /data/app type
(apk_data_file) by the app domains.  In the case of the
WallpaperManagerService, restorecon is invoked to label the wallpaper
file with its own type so that apps can be allowed to write to it
without being able to write to other files under com.android.settings.

- Rewrote the MLS constraints in the sepolicy to only constrain open for
app_data_file, not read/write.  This is an attempt to allow open fd
passing by apps for explicit sharing via Binder or local socket IPC
while prohibiting direct open of the app's private data files by another
app.  However, we still need to distinguish shared_prefs from files
given that the former appears to be accessed via direct open and the
latter via fd passing.

- Support for device-specific additions to policy and improved policy
support for running the Android CTS, as previously discussed on the list
and documented in the wiki.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
