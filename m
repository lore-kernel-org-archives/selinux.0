Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kARER8YE030355
	for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2006 09:27:08 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kAREPPXA004609
	for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2006 14:25:26 GMT
Subject: Re: [RFC] Thunar filesystem manager policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Bradley Chapman <kakadu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e294b46e0611221141v650500f7v72f83ecd3573e356@mail.gmail.com>
References: <e294b46e0611221141v650500f7v72f83ecd3573e356@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 09:27:28 -0500
Message-Id: <1164637648.7490.18.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-22 at 19:41 +0000, Bradley Chapman wrote:
> I'm currently writing a policy for the Thunar filesystem manager, and
> at the moment I'm having trouble making the policy work. I feel that
> it has something to do with the following error message:
> 
> audit(1164224019.042:744): security_compute_sid:  invalid context
> staff_u:sysadm_r:thunar_t for scontext=staff_u:sysadm_r:thunar_t
> tcontext=system_u:object_r:thunar_exec_t tclass=process

Its because of this:

domain_auto_trans($2, thunar_exec_t, thunar_t)

it should be:

domain_auto_trans($2, thunar_exec_t, $1_thunar_t)

Why is there a thunar_t and $1_thunar_t?  

> Also, I'm having trouble getting the D-BUS daemons to transition into
> my new policy domain when they start Thunar; how does one configure a
> new policy to allow domain transitions of this type?
> 
> The policy files at the end of this message contain the policy I've
> managed to create to date. It partially works, but until i fgiure out
> the above issues I doubt I can make it work correctly. Criticism is
> VERY welcome!

There are several types that look like they aren't needed, since they
don't have any rules, especially thunar_lib_t.  Also, I wouldn't think
the thunar_etc_t would be writable.

What you've done with the policy is good for the most part, but I'm not
sure the policy itself is actually needed.  It seems to me that a file
manager should be running in the user domain, rather than a derived
domain.

> template(`thunar_per_role_template',`
> 	gen_require(`
> 		type thunar_t;
> 	')
> 
> 	##############################
> 	#
> 	# Declarations
> 	#
> 
> 	# Type for program
> 	type $1_thunar_t;
> 	domain_type($1_thunar_t)
> 	domain_entry_file($1_thunar_t,thunar_exec_t)
> 	domain_interactive_fd($1_thunar_t)
> 	role $3 types $1_thunar_t;
> 
> 	type $1_thunar_home_t alias $1_thunar_rw_t;
> 	files_poly_member($1_thunar_home_t)
> 	userdom_user_home_content($1,$1_thunar_home_t)
> 
> 	corecmd_search_bin($1_thunar_t)
>         domain_auto_trans($2, thunar_exec_t, thunar_t)
> 
> 	##############################
> 	#
> 	# $1_thunar_t local policy
> 	#
> 
> 	allow $1_thunar_t self:fifo_file { read write getattr };
> 	allow $1_thunar_t self:unix_stream_socket { connectto
> create_stream_socket_perms };
> 	allow $1_thunar_t self:shm create_shm_perms;
> 	allow $1_thunar_t self:sem create_sem_perms;
> 	allow $1_thunar_t self:process signal_perms;
> 	allow $1_thunar_t self:netlink_route_socket r_netlink_socket_perms;
> 	allow $1_thunar_t self:unix_dgram_socket create_socket_perms;
> 	allow $1_thunar_t self:tcp_socket create_stream_socket_perms;
> 	allow $1_thunar_t self:udp_socket create_socket_perms;
> 	allow $1_thunar_t self:socket create_socket_perms;
> 
> 	allow thunar_t thunar_etc_t:dir rw_dir_perms;
> 	allow thunar_t thunar_etc_t:file create_file_perms;

thunar_t vs $1_thunar_t?

> 	auth_dontaudit_read_shadow(thunar_t)
> 	auth_dontaudit_exec_utempter(thunar_t)
> 
> 	can_exec(thunar_t,thunar_exec_t)
> 
> 	dev_read_sysfs(thunar_t)
> 	dev_read_urand(thunar_t)
> 	dev_read_rand(thunar_t)
> 
> 	files_read_all_files(thunar_t)
> 	files_read_all_symlinks(thunar_t)
> 	files_getattr_all_pipes(thunar_t)
> 	files_getattr_all_sockets(thunar_t)
> 	files_search_tmp(thunar_t)
> 	files_search_home(thunar_t)
> 
> 	fs_getattr_all_fs(thunar_t)
> 	fs_list_all(thunar_t)
> 	fs_search_auto_mountpoints(thunar_t)
> 
> 	# Write to utmp.
> 	init_rw_utmp(thunar_t)
> 
> 	libs_use_ld_so(thunar_t)
> 	libs_use_shared_libs(thunar_t)
> 	libs_exec_lib_files(thunar_t)
> 
> 	miscfiles_read_localization(thunar_t)
> 	miscfiles_read_fonts(thunar_t)
> ')
> 

> interface(`thunar_run',`
> 	gen_require(`
> 		type loadkeys_t;
> 	')

Wrong require.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
