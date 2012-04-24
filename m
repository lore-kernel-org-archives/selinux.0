Subject: RE: Success - SEAndroid on Galaxy Nexus maguro
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Palarz Thomas-DCJ738 <tom.palarz@motorolasolutions.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <535CAAB8CFB77F45B4140FC615F0F21E07804BA2@CH1PRD0410MB381.namprd04.prod.outlook.com>
References: 
	 <535CAAB8CFB77F45B4140FC615F0F21E07804B21@CH1PRD0410MB381.namprd04.prod.outlook.com>
	 ,<1335278894.32733.66.camel@moss-pluto>
	 <535CAAB8CFB77F45B4140FC615F0F21E07804BA2@CH1PRD0410MB381.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Apr 2012 16:11:25 -0400
Message-ID: <1335298285.32733.95.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-04-24 at 19:40 +0000, Palarz Thomas-DCJ738 wrote:
> Great info. Thanks.
> 
> The MDD aspects of CDS are appealing, though this is mostly for my own
> kind of experimentation at the moment. What about for MLS kind of
> solutions? Is that policy also expected to remain small?

Policy size is primarily a function of the number of domains and types
in the system, which isn't affected by MLS vs non-MLS.  And we're
already enabling the MLS engine and using categories for app isolation.
You could explicitly assign levels via a different seapp_contexts
configuration; the rest of the policy wouldn't change.

> My log file from SEAndroidManager is attached. Any help would be appreciated. This is a vanilla build with no modifications of my own. I am running ClockworkMod as the recovery image. I have tried installing su and Superuser.apk so that I can get busybox on there, but it's not in the build I am running right now. It could be just a config or build kind of thing that I did wrong, but my first guess is that it is maguro specific.

As expected, it appears you have some labeling problems:
- You have /dev/tty03 labeled with the generic device type rather than
the nfc_device type. Did you use our device/samsung/tuna project with
its sepolicy.fc file?  That includes an entry for /dev/tty03 to label it
as nfc_device, which should have been appended to your file_contexts
configuration in the root directory for your boot image when the policy
was built.

- Some process is running in the init domain rather than in its own
domain, triggering various denials when other processes try to interact
with it.  ps -Z output would be helpful.  This might just be a file
labeling problem if its binary in /system/bin is not correctly labeled.

- You have various files that are unlabeled (note the unlabeled type in
their tcontext), e.g. /system/lib/egl/libGLES_android.so.  How were
those files installed to your system image?  We have modified the
filesystem image building tools (make_ext4fs + mkyaffs2image) and the
recovery console / updater programs to correctly label files when they
are created, but if you are creating them some other way they won't get
labeled.  Probably due to you using ClockworkMod recovery, as that
wouldn't have any awareness of file xattrs.  You can fix them up by
remounting /system read-write and running restorecon on it, or just by
rebuilding the image the normal way and reflashing it.

Once you've resolved labeling problems, we can go back to adding allow
rules, but the labels need to be right first.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
