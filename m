Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l95Hl0Mq031235
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2007 13:47:00 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l95HkxT0029420
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2007 17:46:59 GMT
Subject: Re: policyd module
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Jan-Frode Myklebust <janfrode@tanso.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20071003150600.GA16964@lc4eb8045376502.ibm.com>
References: <20070929231049.GA14665@lc4eb8045376502.ibm.com>
	 <1191243135.4282.42.camel@gorn>
	 <20071003125323.GA15070@lc4eb8045376502.ibm.com>
	 <1191416728.5843.6.camel@gorn>
	 <20071003150600.GA16964@lc4eb8045376502.ibm.com>
Content-Type: text/plain
Date: Fri, 05 Oct 2007 13:44:02 -0400
Message-Id: <1191606242.13098.4.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-10-03 at 11:06 -0400, Jan-Frode Myklebust wrote:
> On Wed, Oct 03, 2007 at 09:05:28AM -0400, Christopher J. PeBenito wrote:
> >
> > I haven't looked at the module closely but right away I see you need to
> > follow the commenting style like in all of the other modules.  Also
> > everything under the "analyzed avc denials" comment needs to be fixed to
> > call interfaces except for the self ones.  For the last line, you would
> > need a patch for corenetwork to define the port and to add the tcp
> > connect to policyd port (these two changes can be in the same patch).
> >
> 
> Here you go :-) Diffed against refpolicy-20070928.tar.bz2.

Its not a problem in this case, since that version just went out, but in
the future, the preference would be against svn HEAD.

> I haven't tested this module after these changes, other than seeing that
> it builds. But the replacement of allow rules with interfaces seemed
> straight forward enough.

Other comments:

> 
> 
> 
> 
> 
> 
> plain text
> document
> attachment
> (policyd.patch),
> "policyd.patch"
> 
> +
> +allow policyd_t policyd_conf_t:dir r_dir_perms;
> +allow policyd_t policyd_conf_t:file r_file_perms;
> +allow policyd_t policyd_conf_t:lnk_file { getattr read };
> +
> +allow policyd_t policyd_var_run_t:dir rw_dir_perms;
> +allow policyd_t policyd_var_run_t:file create_file_perms;
> +files_pid_filetrans(policyd_t, policyd_var_run_t, file)
> +
> +allow policyd_t self:tcp_socket create_stream_socket_perms;
> +allow policyd_t self:capability { sys_resource sys_chroot setgid setuid };
> +allow policyd_t self:process setrlimit;
> +allow policyd_t self:unix_dgram_socket { connect create write};

This set of self lines should go at the top of this section

> +corenet_tcp_sendrecv_all_if(policyd_t)
> +corenet_tcp_sendrecv_all_nodes(policyd_t)
> +corenet_tcp_sendrecv_all_ports(policyd_t)
> +corenet_all_recvfrom_unlabeled(policyd_t)
> +corenet_tcp_bind_all_nodes(policyd_t)
> +corenet_tcp_bind_policyd_port(policyd_t)
> +corenet_tcp_bind_mysqld_port(policyd_t)
> +
> +corenet_tcp_connect_policyd_port(postfix_smtpd_t)
> +
> +sysnet_dns_name_resolve(policyd_t)
> +
> +libs_use_ld_so(policyd_t)
> +libs_use_shared_libs(policyd_t)
> +term_use_generic_ptys(policyd_t)
> +files_read_etc_files(policyd_t)
> +logging_send_syslog_msg(policyd_t)
> +
> +
> +# No existing interface for these:

They do exist:

> +allow policyd_t locale_t:file { getattr read };

This one is is miscfiles.

> +allow policyd_t usr_t:file { getattr read };

this one is in files.


> diff -ruN refpolicy.old/policy/modules.conf refpolicy/policy/modules.conf
> --- refpolicy.old/policy/modules.conf   2007-09-28 15:57:26.000000000 +0200
> +++ refpolicy/policy/modules.conf       2007-10-03 16:06:52.000000000 +0200
> @@ -1137,6 +1137,13 @@
>  perdition = module
>  
>  # Layer: services
> +# Module: policyd
> +#
> +# Postfix policy server
> +# 
> +policyd = module
> +
> +# Layer: services
>  # Module: portmap
>  #
>  # RPC port mapping service.

This isn't needed.  A modules.conf is included in the release tarball so
that users can just configure it and build it, but is not in the
repository as it is a generated file.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
