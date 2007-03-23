Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NIr8FI003986
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 14:53:08 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NIr4sr027769
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 18:53:04 GMT
Message-ID: <460421ED.4010708@redhat.com>
Date: Fri, 23 Mar 2007 14:52:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Elimination of disable_trans boolean ramifications
References: <46041166.8010102@redhat.com>
In-Reply-To: <46041166.8010102@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070005010501030402060800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070005010501030402060800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel J Walsh wrote:
> I have removed the disable_trans booleans from Rawhide, and FC7 
> Test3.  I wanted to remove these booleans because they cause as many 
> problems as they solve.    If you turn off certain domains, it can 
> change the labeling on the system and cause other confined domains to 
> blow up.
>
> If you syslog_disable_trans, the devlog_t context is wrong and any 
> confined app that tries to syslog will no longer work.
>
> The best thing to do when confronted with an AVC would be to figure 
> out if this is expected behavior, if yes then report it as a bug to 
> upstream or to the distribution and create a loadable policy module 
> that handles the problem.
>
> If there are so many problems or a user just does not want to deal 
> with it I figured we could just load a policy that sets the domain as 
> an unconfined_domain.
>
> If you wanted to run samba as an unconfined domain  you would build a 
> policy module
>
> policy_module(mysamba, 1.0)
>
> require {
>        type smbd_t;
> }
>
> unconfined_domain(smbd_t)
>
>
> Compile it
>
> make -f /usr/share/selinux/devel/Makefile
>
> And load it
>
> semodule -i mysamba.pp
>
> Only problem...
>
> semodule -i mysamba.pp
> libsepol.permission_copy_callback: Module mysamba depends on 
> permission * in class capability, not satisfied
> libsemanage.semanage_link_sandbox: Link packages failed
> semodule:  Failed!
>
> But once we fix the interface this should work.
>
> I think this is a better solution, we could even instrument 
> system-config-selinux or audit2allow to  generate this policy module 
> on the fly.  I think this is better than disable_trans or setting up a 
> boolean for all confined domains to go to unconfined.
>
>
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
Attached patch fixes the semodule problem although it makes changing the 
policy to add editing access_vectors more complicated. 






--------------070005010501030402060800
Content-Type: text/plain;
 name="unconfined_diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unconfined_diff"

--- nsaserefpolicy/policy/modules/system/unconfined.if	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/system/unconfined.if	2007-03-23 14:33:51.000000000 -0400
@@ -18,7 +18,7 @@
 	')
 
 	# Use any Linux capability.
-	allow $1 self:capability *;
+	allow $1 self:capability all_capabilities;
 	allow $1 self:fifo_file manage_fifo_file_perms;
 
 	# Transition to myself, to make get_ordered_context_list happy.
@@ -28,10 +28,10 @@
 	allow $1 self:file rw_file_perms;
 
 	# Userland object managers
-	allow $1 self:nscd *;
-	allow $1 self:dbus *;
-	allow $1 self:passwd *;
-	allow $1 self:association *;
+	allow $1 self:nscd all_nscd;
+	allow $1 self:dbus all_dbus;
+	allow $1 self:passwd all_passwd;
+	allow $1 self:association all_association;
 
 	kernel_unconfined($1)
 	corenet_unconfined($1)
--- nsaserefpolicy/policy/support/obj_perm_sets.spt	2007-01-02 12:57:51.000000000 -0500
+++ serefpolicy-2.5.10/policy/support/obj_perm_sets.spt	2007-03-23 14:34:29.000000000 -0400
@@ -215,7 +215,7 @@
 define(`getattr_file_perms',`{ getattr }')
 define(`setattr_file_perms',`{ setattr }')
 define(`read_file_perms',`{ getattr read lock ioctl }')
-define(`mmap_file_perms',`{ getattr read execute }')
+define(`mmap_file_perms',`{ getattr read execute ioctl }')
 define(`exec_file_perms',`{ getattr read execute execute_no_trans }')
 define(`append_file_perms',`{ getattr append lock ioctl }')
 define(`write_file_perms',`{ getattr write append lock ioctl }')
@@ -324,3 +324,13 @@
 #
 define(`client_stream_socket_perms', `{ create ioctl read getattr write setattr append bind getopt setopt shutdown }')
 define(`server_stream_socket_perms', `{ client_stream_socket_perms listen accept }')
+
+define(`all_capabilities', `{ chown dac_override dac_read_search fowner fsetid kill setgid setuid setpcap linux_immutable net_bind_service net_broadcast net_admin net_raw ipc_lock ipc_owner sys_module sys_rawio sys_chroot sys_ptrace sys_pacct sys_admin sys_boot sys_nice sys_resource sys_time sys_tty_config mknod lease audit_write audit_control }
+')
+
+define(`all_nscd', `{ getpwd getgrp gethost getstat admin shmempwd shmemgrp shmemhost } ')
+define(`all_dbus', `{ acquire_svc send_msg } ')
+define(`all_passwd', `{ passwd chfn chsh rootok crontab } ')
+define(`all_association', `{ sendto recvfrom setcontext polmatch } ')
+
+

--------------070005010501030402060800--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
