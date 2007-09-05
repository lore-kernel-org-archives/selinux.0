Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l85EexBQ031156
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 10:40:59 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l85EevJV009581
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 14:40:58 GMT
Subject: Re: [PATCH] refpolicy: services_clamav changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022057.l72Kvkpx000688@redsox.boston.devel.redhat.com>
References: <200708022057.l72Kvkpx000688@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 05 Sep 2007 14:39:39 +0000
Message-Id: <1189003179.30065.19.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:57 -0400, dwalsh@redhat.com wrote:
> Clam run paths changing,
> Clamd creates directories
> Add mailscanner

Merged.

> --- nsaserefpolicy/policy/modules/services/clamav.fc    2007-05-29
> 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/clamav.fc 2007-08-02
> 11:02:02.000000000 -0400
> @@ -9,6 +9,8 @@
> 
>  /var/run/amavis(d)?/clamd\.pid --
> gen_context(system_u:object_r:clamd_var_run_t,s0)
>  /var/run/clamav(/.*)?
> gen_context(system_u:object_r:clamd_var_run_t,s0)
> +/var/run/clamd\..*
> gen_context(system_u:object_r:clamd_var_run_t,s0)
> +/var/run/clamav\..*
> gen_context(system_u:object_r:clamd_var_run_t,s0)
>  /var/lib/clamav(/.*)?
> gen_context(system_u:object_r:clamd_var_lib_t,s0)
>  /var/log/clamav                        -d
> gen_context(system_u:object_r:clamd_var_log_t,s0)
>  /var/log/clamav/clamav.*       --
> gen_context(system_u:object_r:clamd_var_log_t,s0)
> --- nsaserefpolicy/policy/modules/services/clamav.te    2007-07-25
> 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/clamav.te 2007-08-02
> 11:02:02.000000000 -0400
> @@ -74,17 +74,19 @@
>  manage_files_pattern(clamd_t,clamd_var_lib_t,clamd_var_lib_t)
> 
>  # log files
> -allow clamd_t clamd_var_log_t:dir setattr;
> +manage_dirs_pattern(clamd_t,clamd_var_log_t,clamd_var_log_t)
>  manage_files_pattern(clamd_t,clamd_var_log_t,clamd_var_log_t)
> -logging_log_filetrans(clamd_t,clamd_var_log_t,file)
> +logging_log_filetrans(clamd_t,clamd_var_log_t,{ dir file })
> 
>  # pid file
> +manage_dirs_pattern(clamd_t,clamd_var_log_t,clamd_var_log_t)
>  manage_files_pattern(clamd_t,clamd_var_run_t,clamd_var_run_t)
>  manage_sock_files_pattern(clamd_t,clamd_var_run_t,clamd_var_run_t)
> -files_pid_filetrans(clamd_t,clamd_var_run_t,file)
> +files_pid_filetrans(clamd_t,clamd_var_run_t,{ file dir })
> 
>  kernel_dontaudit_list_proc(clamd_t)
>  kernel_read_sysctl(clamd_t)
> +kernel_read_kernel_sysctls(clamd_t)
> 
>  corenet_all_recvfrom_unlabeled(clamd_t)
>  corenet_all_recvfrom_netlabel(clamd_t)
> @@ -208,9 +210,12 @@
>  files_tmp_filetrans(clamscan_t,clamscan_tmp_t,{ file dir })
> 
>  # var/lib files together with clamd
> -read_files_pattern(clamscan_t,clamd_var_lib_t,clamd_var_lib_t)
> +manage_files_pattern(clamscan_t,clamd_var_lib_t,clamd_var_lib_t)
>  allow clamscan_t clamd_var_lib_t:dir list_dir_perms;
> 
> +init_read_utmp(clamscan_t)
> +init_dontaudit_write_utmp(clamscan_t)
> +
>  kernel_read_kernel_sysctls(clamscan_t)
> 
>  files_read_etc_files(clamscan_t)
> @@ -228,3 +233,7 @@
>  optional_policy(`
>         apache_read_sys_content(clamscan_t)
>  ')
> +
> +optional_policy(`
> +       mailscanner_manage_spool(clamscan_t)
> +')
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
