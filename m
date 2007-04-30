Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UHYpVE009692
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 13:34:51 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3UHYpj8002887
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 17:34:51 GMT
Subject: Re: rwho patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46251F6B.10101@redhat.com>
References: <46251F6B.10101@redhat.com>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 17:34:30 +0000
Message-Id: <1177954471.3570.130.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-17 at 15:26 -0400, Daniel J Walsh wrote:
> Created by Nalin Dahyabhai

Merged with some cleanup.

> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (rwho.patch)
> 
> --- nsaserefpolicy/policy/modules/services/rwho.fc      1969-12-31 19:00:00.000000000 -0500
> +++ serefpolicy-2.5.12/policy/modules/services/rwho.fc  2007-04-17 15:22:46.000000000 -0400
> @@ -0,0 +1,3 @@
> +
> +/usr/sbin/rwhod                --      gen_context(system_u:object_r:rwho_exec_t,s0)
> +/var/spool/rwho(/.*)?          gen_context(system_u:object_r:rwho_spool_t,s0)
> --- nsaserefpolicy/policy/modules/services/rwho.if      1969-12-31 19:00:00.000000000 -0500
> +++ serefpolicy-2.5.12/policy/modules/services/rwho.if  2007-04-17 15:09:15.000000000 -0400
> @@ -0,0 +1,84 @@
> +
> +## <summary>policy for rwho</summary>
> +
> +########################################
> +## <summary>
> +##     Execute a domain transition to run rwho.
> +## </summary>
> +## <param name="domain">
> +## <summary>
> +##     Domain allowed to transition.
> +## </summary>
> +## </param>
> +#
> +interface(`rwho_domtrans',`
> +       gen_require(`
> +               type rwho_t, rwho_exec_t;
> +       ')
> +
> +       domain_auto_trans($1,rwho_exec_t,rwho_t)
> +
> +       allow rwho_t $1:fd use;
> +       allow rwho_t $1:fifo_file rw_file_perms;
> +       allow rwho_t $1:process sigchld;
> +')
> +
> +########################################
> +## <summary>
> +##     Search rwho spool directories.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`rwho_search_spool',`
> +       gen_require(`
> +               type rwho_spool_t;
> +       ')
> +
> +       allow $1 rwho_spool_t:dir search_dir_perms;
> +       files_search_spool($1)
> +')
> +
> +########################################
> +## <summary>
> +##     Read rwho spool files.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`rwho_read_spool_files',`
> +       gen_require(`
> +               type rwho_spool_t;
> +       ')
> +
> +       allow $1 rwho_spool_t:file r_file_perms;
> +       allow $1 rwho_spool_t:dir list_dir_perms;
> +       files_search_spool($1)
> +')
> +
> +########################################
> +## <summary>
> +##     Create, read, write, and delete
> +##     rwho spool files.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`rwho_manage_spool_files',`
> +       gen_require(`
> +               type rwho_spool_t;
> +       ')
> +
> +       allow $1 rwho_spool_t:file manage_file_perms;
> +       allow $1 rwho_spool_t:dir rw_dir_perms;
> +       files_search_spool($1)
> +')
> --- nsaserefpolicy/policy/modules/services/rwho.te      1969-12-31 19:00:00.000000000 -0500
> +++ serefpolicy-2.5.12/policy/modules/services/rwho.te  2007-04-17 15:21:00.000000000 -0400
> @@ -0,0 +1,65 @@
> +policy_module(rwho,1.0.0)
> +
> +########################################
> +#
> +# Declarations
> +#
> +
> +type rwho_t;
> +type rwho_exec_t;
> +domain_type(rwho_t)
> +init_daemon_domain(rwho_t, rwho_exec_t)
> +
> +# var/spool files
> +type rwho_spool_t;
> +files_type(rwho_spool_t)
> +
> +########################################
> +#
> +# rwho local policy
> +#
> +
> +#============= rwho_t ==============
> +allow rwho_t self:capability sys_chroot;
> +allow rwho_t self:unix_dgram_socket create;
> +allow rwho_t self:fifo_file rw_file_perms;
> +allow rwho_t self:unix_stream_socket create_stream_socket_perms;
> +allow rwho_t self:udp_socket create_socket_perms;
> +
> +# var/spool files for rwho
> +allow rwho_t rwho_spool_t:dir manage_dir_perms;
> +allow rwho_t rwho_spool_t:file manage_file_perms;
> +files_spool_filetrans(rwho_t,rwho_spool_t, { file dir })
> +
> +domain_use_interactive_fds(rwho_t)
> +
> +files_read_etc_files(rwho_t)
> +
> +init_read_utmp(rwho_t)
> +init_dontaudit_write_utmp(rwho_t)
> +init_use_fds(rwho_t)
> +init_use_script_ptys(rwho_t)
> +
> +kernel_read_system_state(rwho_t)
> +
> +libs_use_ld_so(rwho_t)
> +libs_use_shared_libs(rwho_t)
> +
> +miscfiles_read_localization(rwho_t)
> +
> +# Default Networking
> +corenet_non_ipsec_sendrecv(rwho_t)
> +corenet_udp_sendrecv_all_if(rwho_t)
> +corenet_udp_sendrecv_all_nodes(rwho_t)
> +corenet_udp_sendrecv_all_ports(rwho_t)
> +corenet_udp_bind_all_nodes(rwho_t)
> +corenet_udp_bind_rwho_port(rwho_t)
> +
> +sysnet_dns_name_resolve(rwho_t)
> +
> +ifdef(`targeted_policy',`
> +       term_dontaudit_use_unallocated_ttys(rwho_t)
> +       term_dontaudit_use_generic_ptys(rwho_t)
> +')
> +
> +
> --- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in      2007-04-11 15:52:53.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/kernel/corenetwork.te.in  2007-04-17 15:19:50.000000000 -0400
> @@ -132,6 +138,7 @@
>  network_port(router, udp,520,s0)
>  network_port(rsh, tcp,514,s0)
>  network_port(rsync, tcp,873,s0, udp,873,s0)
> +network_port(rwho, udp,513,s0)
>  network_port(smbd, tcp,139,s0, tcp,445,s0)
>  network_port(smtp, tcp,25,s0, tcp,465,s0, tcp,587,s0)
>  network_port(snmp, udp,161,s0, udp,162,s0, tcp,199,s0)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
