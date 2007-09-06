Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l86IScYx012956
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 14:28:38 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l86ISaaK008993
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 18:28:36 GMT
Subject: Re: [PATCH] refpolicy: services_rwho changes rwho uses a log file
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022040.l72KeIGt032572@redsox.boston.devel.redhat.com>
References: <200708022040.l72KeIGt032572@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Thu, 06 Sep 2007 14:27:11 -0400
Message-Id: <1189103231.3664.27.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:40 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/rwho.fc      2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/rwho.fc   2007-08-02 11:02:02.000000000 -0400
> @@ -1,3 +1,4 @@
>  /usr/sbin/rwhod                --      gen_context(system_u:object_r:rwho_exec_t,s0)
> 
>  /var/spool/rwho(/.*)?          gen_context(system_u:object_r:rwho_spool_t,s0)
> +/var/log/rwhod(/.*)?           gen_context(system_u:object_r:rwho_log_t,s0)

Merged.

> --- nsaserefpolicy/policy/modules/services/rwho.if      2007-06-15 14:54:33.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/rwho.if   2007-08-02 11:02:02.000000000 -0400
> @@ -72,6 +72,47 @@
>                 type rwho_spool_t;
>         ')
> 
> -       manage_files_pattern($1,rwho_spool_t,rwho_spool_t)
> +       allow $1 rwho_spool_t:file manage_file_perms;
> +       allow $1 rwho_spool_t:dir rw_dir_perms;
>         files_search_spool($1)
>  ')
> +
> +########################################
> +## <summary>
> +##     Search rwho log directories.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`rwho_search_log',`
> +       gen_require(`
> +               type rwho_log_t;
> +       ')
> +
> +       allow $1 rwho_log_t:dir search_dir_perms;
> +       logging_search_logs($1)
> +')
> +
> +########################################
> +## <summary>
> +##     Read rwho log files.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`rwho_read_log_files',`
> +       gen_require(`
> +               type rwho_log_t;
> +       ')
> +
> +       allow $1 rwho_log_t:file r_file_perms;
> +       allow $1 rwho_log_t:dir list_dir_perms;
> +       logging_search_logs($1)
> +')
> +
> --- nsaserefpolicy/policy/modules/services/rwho.te      2007-07-25 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/rwho.te   2007-08-02 11:02:02.000000000 -0400
> @@ -10,10 +10,12 @@
>  type rwho_exec_t;
>  init_daemon_domain(rwho_t, rwho_exec_t)
> 
> -# var/spool files
>  type rwho_spool_t;
>  files_type(rwho_spool_t)
> 
> +type rwho_log_t;
> +files_type(rwho_log_t)
> +
>  ########################################
>  #
>  # rwho local policy
> @@ -30,6 +32,10 @@
>  allow rwho_t rwho_spool_t:file manage_file_perms;
>  files_spool_filetrans(rwho_t,rwho_spool_t, { file dir })
> 
> +allow rwho_t rwho_log_t:dir manage_dir_perms;
> +allow rwho_t rwho_log_t:file manage_file_perms;
> +logging_log_filetrans(rwho_t,rwho_log_t, { file dir })
> +
>  kernel_read_system_state(rwho_t)
> 
>  corenet_all_recvfrom_unlabeled(rwho_t)
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
