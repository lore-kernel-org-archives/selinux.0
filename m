Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2SI8mgg024505
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 14:08:48 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2SI8lCe021673
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 18:08:47 GMT
Subject: Re: Elimination of disable_trans boolean ramifications
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <460421ED.4010708@redhat.com>
References: <46041166.8010102@redhat.com>  <460421ED.4010708@redhat.com>
Content-Type: text/plain
Date: Wed, 28 Mar 2007 14:09:24 -0400
Message-Id: <1175105364.29300.105.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 14:52 -0400, Daniel J Walsh wrote:
> Daniel J Walsh wrote:
> > If you wanted to run samba as an unconfined domain  you would build
> a
> > policy module
> >
> > policy_module(mysamba, 1.0)
> >
> > require {
> >        type smbd_t;
> > }
> >
> > unconfined_domain(smbd_t)
> >
> >
> > Compile it
> >
> > make -f /usr/share/selinux/devel/Makefile
> >
> > And load it
> >
> > semodule -i mysamba.pp
> >
> > Only problem...
> >
> > semodule -i mysamba.pp
> > libsepol.permission_copy_callback: Module mysamba depends on
> > permission * in class capability, not satisfied
> > libsemanage.semanage_link_sandbox: Link packages failed
> > semodule:  Failed!
> >
> > But once we fix the interface this should work.

I'm not sure why you are hitting this.  The policy_module statement
already requires all kernel object classes and their perms.  It might be
interesting to look at the final source file to see whats going on.

> 
> plain text document attachment (unconfined_diff), "unconfined_diff"
> --- nsaserefpolicy/policy/modules/system/unconfined.if	2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/system/unconfined.if	2007-03-23 14:33:51.000000000 -0400
> @@ -18,7 +18,7 @@
>  	')
>  
>  	# Use any Linux capability.
> -	allow $1 self:capability *;
> +	allow $1 self:capability all_capabilities;
>  	allow $1 self:fifo_file manage_fifo_file_perms;
>  
>  	# Transition to myself, to make get_ordered_context_list happy.
> @@ -28,10 +28,10 @@
>  	allow $1 self:file rw_file_perms;
>  
>  	# Userland object managers
> -	allow $1 self:nscd *;
> -	allow $1 self:dbus *;
> -	allow $1 self:passwd *;
> -	allow $1 self:association *;
> +	allow $1 self:nscd all_nscd;
> +	allow $1 self:dbus all_dbus;
> +	allow $1 self:passwd all_passwd;
> +	allow $1 self:association all_association;
>  
>  	kernel_unconfined($1)
>  	corenet_unconfined($1)
> --- nsaserefpolicy/policy/support/obj_perm_sets.spt	2007-01-02 12:57:51.000000000 -0500
> +++ serefpolicy-2.5.10/policy/support/obj_perm_sets.spt	2007-03-23 14:34:29.000000000 -0400
> @@ -215,7 +215,7 @@
>  define(`getattr_file_perms',`{ getattr }')
>  define(`setattr_file_perms',`{ setattr }')
>  define(`read_file_perms',`{ getattr read lock ioctl }')
> -define(`mmap_file_perms',`{ getattr read execute }')
> +define(`mmap_file_perms',`{ getattr read execute ioctl }')
>  define(`exec_file_perms',`{ getattr read execute execute_no_trans }')
>  define(`append_file_perms',`{ getattr append lock ioctl }')
>  define(`write_file_perms',`{ getattr write append lock ioctl }')
> @@ -324,3 +324,13 @@
>  #
>  define(`client_stream_socket_perms', `{ create ioctl read getattr write setattr append bind getopt setopt shutdown }')
>  define(`server_stream_socket_perms', `{ client_stream_socket_perms listen accept }')
> +
> +define(`all_capabilities', `{ chown dac_override dac_read_search fowner fsetid kill setgid setuid setpcap linux_immutable net_bind_service net_broadcast net_admin net_raw ipc_lock ipc_owner sys_module sys_rawio sys_chroot sys_ptrace sys_pacct sys_admin sys_boot sys_nice sys_resource sys_time sys_tty_config mknod lease audit_write audit_control }
> +')
> +
> +define(`all_nscd', `{ getpwd getgrp gethost getstat admin shmempwd shmemgrp shmemhost } ')
> +define(`all_dbus', `{ acquire_svc send_msg } ')
> +define(`all_passwd', `{ passwd chfn chsh rootok crontab } ')
> +define(`all_association', `{ sendto recvfrom setcontext polmatch } ')
> +
> +
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
