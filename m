Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l98F2Hob021238
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2007 11:02:17 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l98F2G4K001815
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2007 15:02:16 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: policyd module
Date: Mon, 8 Oct 2007 10:57:55 -0400
Message-ID: <1191855475.13098.37.camel@gorn>
In-Reply-To: <20071005234757.GA4249@lc4eb8045376502.ibm.com>
References: <20070929231049.GA14665@lc4eb8045376502.ibm.com> <1191243135.4282.42.camel@gorn> <20071003125323.GA15070@lc4eb8045376502.ibm.com> <1191416728.5843.6.camel@gorn> <20071003150600.GA16964@lc4eb8045376502.ibm.com> <1191606242.13098.4.camel@gorn.columbia.tresys.com> <20071005234757.GA4249@lc4eb8045376502.ibm.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Jan-Frode Myklebust" <janfrode@tanso.net>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-10-06 at 01:47 +0200, Jan-Frode Myklebust wrote:
> diff -ruN refpolicy.old/policy/modules/services/policyd.te refpolicy/policy/modules/services/policyd.te
> --- refpolicy.old/policy/modules/services/policyd.te    1970-01-01 01:00:00.000000000 +0100
> +++ refpolicy/policy/modules/services/policyd.te        2007-10-06 01:46:26.000000000 +0200
> @@ -0,0 +1,56 @@
> +
> +policy_module(policyd, 1.0.0)
> +
> +########################################
> +#
> +# Declarations
> +#
> +
> +type policyd_t;
> +type policyd_exec_t;
> +init_daemon_domain(policyd_t, policyd_exec_t)
> +
> +type policyd_conf_t;
> +files_config_file(policyd_conf_t)
> +
> +type policyd_var_run_t;
> +files_pid_file(policyd_var_run_t)
> +
> +########################################
> +#
> +# Local Policy
> +#
> +
> +allow policyd_t self:tcp_socket create_stream_socket_perms;
> +allow policyd_t self:capability { sys_resource sys_chroot setgid setuid };
> +allow policyd_t self:process setrlimit;
> +allow policyd_t self:unix_dgram_socket { connect create write};
> +
> +allow policyd_t policyd_conf_t:dir r_dir_perms;
> +allow policyd_t policyd_conf_t:file r_file_perms;
> +allow policyd_t policyd_conf_t:lnk_file { getattr read };
> +
> +allow policyd_t policyd_var_run_t:dir rw_dir_perms;
> +allow policyd_t policyd_var_run_t:file create_file_perms;
> +files_pid_filetrans(policyd_t, policyd_var_run_t, file)
> +
> +corenet_tcp_sendrecv_all_if(policyd_t)
> +corenet_tcp_sendrecv_all_nodes(policyd_t)
> +corenet_tcp_sendrecv_all_ports(policyd_t)
> +corenet_all_recvfrom_unlabeled(policyd_t)
> +corenet_tcp_bind_all_nodes(policyd_t)
> +corenet_tcp_bind_policyd_port(policyd_t)
> +corenet_tcp_bind_mysqld_port(policyd_t)
> +
> +corenet_tcp_connect_policyd_port(postfix_smtpd_t)

This line needs to be moved to the postfix module, as postfix_smtpd_t
isn't owned by this module.

> +sysnet_dns_name_resolve(policyd_t)
> +
> +libs_use_ld_so(policyd_t)
> +libs_use_shared_libs(policyd_t)
> +term_use_generic_ptys(policyd_t)
> +files_read_etc_files(policyd_t)
> +logging_send_syslog_msg(policyd_t)
> +
> +miscfiles_read_localization(policyd_t)
> +files_read_usr_files(policyd_t)

I didn't notice this before, but you are missing a .if file.  Even if
there aren't currently any interfaces, there needs to be a .if file with
at least the XML summary.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
