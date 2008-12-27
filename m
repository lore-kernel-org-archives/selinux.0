Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBRHaglm024724
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 12:36:42 -0500
Received: from qw-out-1920.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBRHYBGg000315
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 17:34:11 GMT
Received: by qw-out-1920.google.com with SMTP id 5so1662102qwc.30
        for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 09:36:41 -0800 (PST)
Message-ID: <cadfc0e40812270936w54f46ca7naa5739d02b42719f@mail.gmail.com>
Date: Sat, 27 Dec 2008 11:36:40 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: FC10 MLS policy problems
Cc: "SELinux List" <selinux@tycho.nsa.gov>
In-Reply-To: <4956105C.3080809@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40812220816i313ec875nc2859930867253e9@mail.gmail.com>
	 <1229978593.31766.90.camel@moss-terrapins.epoch.ncsc.mil>
	 <cadfc0e40812240743w32ffc6admed19aa6f81abea15@mail.gmail.com>
	 <4956105C.3080809@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Dec 27, 2008 at 5:24 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Xavier Toth wrote:
>> On Mon, Dec 22, 2008 at 2:43 PM, David P. Quigley <dpquigl@tycho.nsa.gov> wrote:
>>> On Mon, 2008-12-22 at 10:16 -0600, Xavier Toth wrote:
>>>> I installed FC10, installed selinux-policy-mls, touched /.autorelabel
>>>> and rebooted. Here are the kernel and policy installed:
>>>>
>>>> [tedx@localhost ~]$ uname -a
>>>> Linux localhost.localdomain 2.6.27.7-134.fc10.x86_64 #1 SMP Mon Dec 1
>>>> 22:21:35 EST 2008 x86_64 x86_64 x86_64 GNU/Linux
>>>> [tedx@localhost ~]$ rpm -qa | grep selinux-policy
>>>> selinux-policy-3.5.13-34.fc10.noarch
>>>> selinux-policy-targeted-3.5.13-34.fc10.noarch
>>>> selinux-policy-mls-3.5.13-34.fc10.noarch
>>>>
>>>>
>>>> During the relabeling I saw a lot of problems like the following:
>>>>
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:userhelper_conf_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:etc_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:dnsmasq_initrc_exec_t:s0 is not valid (left
>>>> unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:kerneloops_initrc_exec_t:s0 is not valid (left
>>>> unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:portreserve_etc_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:selinux_config_t:s0 is not valid (left
>>>> unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:default_context_t:s0 is not valid (left
>>>> unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:semanage_store_t:s0 is not valid (left
>>>> unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:admin_home_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:root_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:consolekit_log_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:rpm_log_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:dnsmasq_lease_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:polkit_var_lib_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:rpm_var_lib_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:games_data_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:consolekit_var_run_t:s0 is not valid (left
>>>> unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:polkit_var_run_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:portreserve_var_run_t:s0 is not valid (left
>>>> unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:user_home_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:gnome_home_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:gnome_home_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:mozilla_home_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:execmem_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:games_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:mono_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:polkit_resolve_exec_t:s0 is not valid (left
>>>> unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:polkit_grant_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:polkit_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:polkit_auth_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:gnomeclock_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:openoffice_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:nsplugin_rw_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:nsplugin_config_exec_t:s0 is not valid (left
>>>> unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:nsplugin_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:mozilla_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:consolekit_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:dnsmasq_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:usernetctl_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:userhelper_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:kerneloops_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:lockdev_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:unconfined_notrans_exec_t:s0 is not valid (left
>>>> unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:user_tmp_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> unconfined_u:object_r:xdm_tmp_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: SELinux:  Context
>>>> system_u:object_r:portreserve_exec_t:s0 is not valid (left unmapped).
>>>> Dec 22 10:02:28 localhost kernel: __ratelimit: 81 callbacks suppressed
>>>>
>>>> Then I logged in and did a ls -laZ of my home directory:
>>>>
>>>> drwx------  tedx tedx system_u:object_r:user_home_dir_t:s0-s15:c0.c1023 .
>>>> drwxr-xr-x  root root system_u:object_r:home_root_t:s0-s15:c0.c1023 ..
>>>> -rw-------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .bash_history
>>>> -rw-r--r--  tedx tedx system_u:object_r:user_home_t:s0 .bash_logout
>>>> -rw-r--r--  tedx tedx system_u:object_r:user_home_t:s0 .bash_profile
>>>> -rw-r--r--  tedx tedx system_u:object_r:user_home_t:s0 .bashrc
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .cache
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .config
>>>> drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .dbus
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Desktop
>>>> -rw-r--r--  tedx tedx system_u:object_r:xdm_home_t:s0  .dmrc
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Documents
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Download
>>>> -rw-------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .esd_auth
>>>> drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .gconf
>>>> drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .gconfd
>>>> drwxr-xr-x  tedx tedx system_u:object_r:user_home_t:s0 .gnome2
>>>> drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .gnome2_private
>>>> drwxrwxr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .gstreamer-0.10
>>>> -rw-rw-r--  tedx tedx user_u:object_r:user_home_t:s0   .gtk-bookmarks
>>>> dr-x------  tedx tedx system_u:object_r:fusefs_t:s0    .gvfs
>>>> -rw-------  tedx tedx system_u:object_r:iceauth_home_t:s0 .ICEauthority
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .local
>>>> drwxr-xr-x  tedx tedx system_u:object_r:user_home_t:s0 .mozilla
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Music
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .nautilus
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Pictures
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Public
>>>> drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .pulse
>>>> -rw-------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .pulse-cookie
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Templates
>>>> drwxrwxr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .tomboy
>>>> -rw-rw-r--  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .tomboy.log
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Videos
>>>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .wapi
>>>> -rw-------  tedx tedx system_u:object_r:xdm_home_t:s0  .xsession-errors
>>>> -rw-------  tedx tedx system_u:object_r:xdm_home_t:s0  .xsession-errors.old
>>>>
>>>> How did these directories and files get relabel unlabeled_t:SystemHigh?
>>>>
>>>> Ted
>>>>
>>>> --
>>>> This message was distributed to subscribers of the selinux mailing list.
>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>> I believe what you are seeing here is the deferred context mapping
>>> support [1]. Essentially what is going on here is that the MLS policy
>>> doesn't have those types defined so when the kernel goes to map the
>>> contexts it will map them to unlabeled_t.
>>>
>>> Dave
>>>
>>> [1]http://lkml.org/lkml/2008/7/7/223
>>>
>>>
>>
>> Thanks now this makes sense to me. I've rebuilt my mls policy to
>> include gnome, mozilla and some other modules to get the correct
>> labeling on some vital directories like ~/.gconf.  However I am
>> concerned about some of the remaining unlabel files and directories
>> and the impact on the users experience. It seems that the main issue
>> is that since in the default targeted policy these files get labeled
>> unconfined_u:object_r:user_home_t:s0 and then when you switch to MLS
>> because the unconfined modules is not included they get relabel to
>> system_u:object_r:unlabeled_t:s15:c0.c1023. Would it be
>> possible/reasonable to only change the undefined portion of the
>> context to something else for example only change unconfined_u to
>> system_u instead of changing and losing the whole context?
>>
>>
>> -rw-------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .bash_history
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .cache
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .config
>> drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .dbus
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Desktop
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Documents
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Download
>> -rw-------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .esd_auth
>> drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .gnome2_private
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Music
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .nautilus
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Pictures
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Public
>> -rw-------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .pulse-cookie
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Templates
>> drwxrwxr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .tomboy
>> -rw-rw-r--  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .tomboy.log
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Videos
>> drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .wapi
>>
>>
>> Ted
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
> This looks like the labelling of the home directory was unsuccessful?
>
> If you run restorecon -R -v /home does this clean up the problems?
>
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAklWEFwACgkQrlYvE4MpobNuTwCgrSWz3/IuBVLGlBN2a18Lgp2k
> AjoAn0Sz6Rxf62MWSjPdrUfsLyre8Kn0
> =0Toc
> -----END PGP SIGNATURE-----
>

Not completely. There are still a number of files and diretories that
don't have file context mappings which were labeled unconfined_u in
targeted policy and relabeled system_u:object_r:unlabeled_t:SystemHigh
in mls policy because unconfined_u isn't defined. The options to deal
with this would seem to be:
a) change policy to have file context labeling for these files/directories
b) have a way to specify the mappings for undefined portions of contexts

[tedx@localhost ~]$ sudo /sbin/restorecon -R -v /home
/sbin/restorecon reset
/home/tedx/.wapi/shared_data-localhost.localdomain-Linux-x86_64-328-12-0
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.wapi/shared_fileshare-localhost.localdomain-Linux-x86_64-40-12-0
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/src2/Linux_i386/BUILD/rpmbuild/BUILD/libselinux-2.0.76/man/man8/selinuxconlist.8
context user_u:object_r:user_tmp_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/src2/Linux_i386/BUILD/rpmbuild/BUILD/libselinux-2.0.76/man/man8/selinuxdefcon.8
context user_u:object_r:user_tmp_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset /home/tedx/.recently-used.xbel context
user_u:object_r:nsplugin_home_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset /home/tedx/.nautilus/saved-session-XTPLMU
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset /home/tedx/.nautilus/saved-session-N76KMU
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.nautilus/metafiles/x-nautilus-desktop:%2F%2F%2F.xml
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.nautilus/metafiles/file:%2F%2F%2Fmedia.xml context
user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon:  unable to stat file /home/tedx/.gvfs: Permission denied
/sbin/restorecon reset /home/tedx/.tomboy/addin-db-001/host-index
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset /home/tedx/.tomboy/addin-db-001/addin-data
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset /home/tedx/.tomboy/addin-db-001/addin-data/1
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/1/Tomboy.Tomboy,0.10.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global context
user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.ExportToHtmlAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.TasqueAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.NoteOfTheDayAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.BacklinksAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.SshSyncServiceAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.InsertTimestampAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.WebDavSyncServiceAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.BugzillaAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.FixedWidthAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.StickyNoteImportAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.PrintNotesAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.EvolutionAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-data/global/Tomboy.FileSystemSyncServiceAddin,0.1.maddin
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset /home/tedx/.tomboy/addin-db-001/addin-dir-data
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-dir-data/usr_lib64_tomboy_addins_671fc10c.data
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/.tomboy/addin-db-001/addin-dir-data/usr_lib64_tomboy_5acc0d90.data
context user_u:object_r:unlabeled_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset
/home/tedx/Download/libselinux-2.0.76-5.fc10.src.rpm context
user_u:object_r:user_tmp_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset /home/tedx/.ssh context
user_u:object_r:user_home_t:s0->system_u:object_r:ssh_home_t:s0
/sbin/restorecon reset /home/tedx/.ssh/known_hosts context
user_u:object_r:user_home_t:s0->system_u:object_r:ssh_home_t:s0
/sbin/restorecon reset /home/tedx/.dmrc context
system_u:object_r:xdm_home_t:s0->system_u:object_r:user_home_t:s0
/sbin/restorecon reset /home/tedx/.fontconfig context
user_u:object_r:user_home_t:s0->system_u:object_r:fonts_config_home_t:s0
/sbin/restorecon reset
/home/tedx/.fontconfig/642ab087ea0ebabea976545ce5d710db-x86-64.cache-2
context user_u:object_r:user_home_t:s0->system_u:object_r:fonts_config_home_t:s0

[tedx@localhost ~]$ ls -laZ | grep unlabeled
-rw-------  tedx tedx system_u:object_r:unlabeled_t:SystemHigh .bash_history
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh .cache
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh .config
drwx------  tedx tedx system_u:object_r:unlabeled_t:SystemHigh .dbus
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh Desktop
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh Documents
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh Download
-rw-------  tedx tedx system_u:object_r:unlabeled_t:SystemHigh .esd_auth
drwx------  tedx tedx system_u:object_r:unlabeled_t:SystemHigh .gnome2_private
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh Music
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh .nautilus
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh Pictures
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh Public
-rw-------  tedx tedx system_u:object_r:unlabeled_t:SystemHigh .pulse-cookie
-rw-rw-r--  tedx tedx system_u:object_r:unlabeled_t:SystemHigh targeted.ls
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh Templates
drwxrwxr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh .tomboy
-rw-rw-r--  tedx tedx system_u:object_r:unlabeled_t:SystemHigh .tomboy.log
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh Videos
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:SystemHigh .wapi


Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
