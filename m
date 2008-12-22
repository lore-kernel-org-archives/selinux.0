Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBMGGeKZ017200
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2008 11:16:40 -0500
Received: from qw-out-1920.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBMGEEDr000656
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2008 16:14:14 GMT
Received: by qw-out-1920.google.com with SMTP id 5so722499qwc.30
        for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2008 08:16:39 -0800 (PST)
Message-ID: <cadfc0e40812220816i313ec875nc2859930867253e9@mail.gmail.com>
Date: Mon, 22 Dec 2008 10:16:39 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: FC10 MLS policy problems
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I installed FC10, installed selinux-policy-mls, touched /.autorelabel
and rebooted. Here are the kernel and policy installed:

[tedx@localhost ~]$ uname -a
Linux localhost.localdomain 2.6.27.7-134.fc10.x86_64 #1 SMP Mon Dec 1
22:21:35 EST 2008 x86_64 x86_64 x86_64 GNU/Linux
[tedx@localhost ~]$ rpm -qa | grep selinux-policy
selinux-policy-3.5.13-34.fc10.noarch
selinux-policy-targeted-3.5.13-34.fc10.noarch
selinux-policy-mls-3.5.13-34.fc10.noarch


During the relabeling I saw a lot of problems like the following:

Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:userhelper_conf_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:etc_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:dnsmasq_initrc_exec_t:s0 is not valid (left
unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:kerneloops_initrc_exec_t:s0 is not valid (left
unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:portreserve_etc_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:selinux_config_t:s0 is not valid (left
unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:default_context_t:s0 is not valid (left
unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:semanage_store_t:s0 is not valid (left
unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:admin_home_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:root_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:consolekit_log_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:rpm_log_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:dnsmasq_lease_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:polkit_var_lib_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:rpm_var_lib_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:games_data_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:consolekit_var_run_t:s0 is not valid (left
unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:polkit_var_run_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:portreserve_var_run_t:s0 is not valid (left
unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:user_home_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:gnome_home_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:gnome_home_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:mozilla_home_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:execmem_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:games_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:mono_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:polkit_resolve_exec_t:s0 is not valid (left
unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:polkit_grant_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:polkit_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:polkit_auth_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:gnomeclock_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:openoffice_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:nsplugin_rw_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:nsplugin_config_exec_t:s0 is not valid (left
unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:nsplugin_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:mozilla_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:consolekit_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:dnsmasq_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:usernetctl_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:userhelper_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:kerneloops_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:lockdev_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:unconfined_notrans_exec_t:s0 is not valid (left
unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:user_tmp_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
unconfined_u:object_r:xdm_tmp_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: SELinux:  Context
system_u:object_r:portreserve_exec_t:s0 is not valid (left unmapped).
Dec 22 10:02:28 localhost kernel: __ratelimit: 81 callbacks suppressed

Then I logged in and did a ls -laZ of my home directory:

drwx------  tedx tedx system_u:object_r:user_home_dir_t:s0-s15:c0.c1023 .
drwxr-xr-x  root root system_u:object_r:home_root_t:s0-s15:c0.c1023 ..
-rw-------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .bash_history
-rw-r--r--  tedx tedx system_u:object_r:user_home_t:s0 .bash_logout
-rw-r--r--  tedx tedx system_u:object_r:user_home_t:s0 .bash_profile
-rw-r--r--  tedx tedx system_u:object_r:user_home_t:s0 .bashrc
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .cache
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .config
drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .dbus
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Desktop
-rw-r--r--  tedx tedx system_u:object_r:xdm_home_t:s0  .dmrc
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Documents
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Download
-rw-------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .esd_auth
drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .gconf
drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .gconfd
drwxr-xr-x  tedx tedx system_u:object_r:user_home_t:s0 .gnome2
drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .gnome2_private
drwxrwxr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .gstreamer-0.10
-rw-rw-r--  tedx tedx user_u:object_r:user_home_t:s0   .gtk-bookmarks
dr-x------  tedx tedx system_u:object_r:fusefs_t:s0    .gvfs
-rw-------  tedx tedx system_u:object_r:iceauth_home_t:s0 .ICEauthority
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .local
drwxr-xr-x  tedx tedx system_u:object_r:user_home_t:s0 .mozilla
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Music
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .nautilus
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Pictures
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Public
drwx------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .pulse
-rw-------  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .pulse-cookie
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Templates
drwxrwxr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .tomboy
-rw-rw-r--  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .tomboy.log
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 Videos
drwxr-xr-x  tedx tedx system_u:object_r:unlabeled_t:s15:c0.c1023 .wapi
-rw-------  tedx tedx system_u:object_r:xdm_home_t:s0  .xsession-errors
-rw-------  tedx tedx system_u:object_r:xdm_home_t:s0  .xsession-errors.old

How did these directories and files get relabel unlabeled_t:SystemHigh?

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
