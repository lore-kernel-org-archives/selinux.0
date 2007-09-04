Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l84IpUTF027166
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 14:51:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l84IpKFK021660
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 18:51:25 GMT
Subject: Re: [PATCH] refpolicy: services_setroubleshoot changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022037.l72KbmTS032482@redsox.boston.devel.redhat.com>
References: <200708022037.l72KbmTS032482@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 04 Sep 2007 14:49:43 -0400
Message-Id: <1188931783.30065.9.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:37 -0400, dwalsh@redhat.com wrote:
> Uses nsswitch
> New interface to remove avc messages from unprivledged users try to
> connect
> Checks attributes of files

Merged.

> --- nsaserefpolicy/policy/modules/services/setroubleshoot.if
> 2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/setroubleshoot.if
> 2007-08-02 11:02:02.000000000 -0400
> @@ -19,3 +19,22 @@
>         allow $1 setroubleshoot_var_run_t:sock_file write;
>         allow $1 setroubleshootd_t:unix_stream_socket connectto;
>  ')
> +
> +########################################
> +## <summary>
> +##     Dontaudit Connect to setroubleshootd over an unix stream
> socket.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`setroubleshoot_dontaudit_stream_connect',`
> +       gen_require(`
> +               type setroubleshootd_t, setroubleshoot_var_run_t;
> +       ')
> +
> +       dontaudit $1 setroubleshoot_var_run_t:sock_file write;
> +       dontaudit $1 setroubleshootd_t:unix_stream_socket connectto;
> +')
> --- nsaserefpolicy/policy/modules/services/setroubleshoot.te
> 2007-07-25 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/setroubleshoot.te
> 2007-08-02 11:02:02.000000000 -0400
> @@ -33,7 +33,6 @@
>  allow setroubleshootd_t self:tcp_socket create_stream_socket_perms;
>  allow setroubleshootd_t self:unix_stream_socket
> { create_stream_socket_perms connectto };
>  allow setroubleshootd_t self:unix_dgram_socket create_socket_perms;
> -allow setroubleshootd_t self:netlink_route_socket
> r_netlink_socket_perms;
> 
>  # database files
>  allow setroubleshootd_t setroubleshoot_var_lib_t:dir setattr;
> @@ -51,6 +50,8 @@
>  manage_sock_files_pattern(setroubleshootd_t,setroubleshoot_var_run_t,setroubleshoot_var_run_t)
>  files_pid_filetrans(setroubleshootd_t,setroubleshoot_var_run_t,
> { file sock_file })
> 
> +auth_use_nsswitch(setroubleshootd_t)
> +
>  kernel_read_kernel_sysctls(setroubleshootd_t)
>  kernel_read_system_state(setroubleshootd_t)
>  kernel_read_network_state(setroubleshootd_t)
> @@ -76,6 +77,9 @@
>  files_getattr_all_dirs(setroubleshootd_t)
>  files_getattr_all_files(setroubleshootd_t)
> 
> +fs_getattr_all_dirs(setroubleshootd_t)
> +fs_getattr_all_files(setroubleshootd_t)
> +
>  selinux_get_enforce_mode(setroubleshootd_t)
>  selinux_validate_context(setroubleshootd_t)
> 
> @@ -108,6 +112,3 @@
>          rpm_use_script_fds(setroubleshootd_t)
>  ')
> 
> -optional_policy(`
> -       nis_use_ypbind(setroubleshootd_t)
> -')
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
