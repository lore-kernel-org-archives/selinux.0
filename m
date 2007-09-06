Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l86ISc7H012959
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 14:28:38 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l86ISaaM008993
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 18:28:38 GMT
Subject: Re: [PATCH] refpolicy: services_spamassassin changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022034.l72KYTej032378@redsox.boston.devel.redhat.com>
References: <200708022034.l72KYTej032378@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Thu, 06 Sep 2007 14:27:12 -0400
Message-Id: <1189103232.3664.28.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:34 -0400, dwalsh@redhat.com wrote:
> More spool/run directories

Merged.

> --- nsaserefpolicy/policy/modules/services/spamassassin.fc
> 2007-06-11 16:05:30.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/spamassassin.fc
> 2007-08-02 11:02:02.000000000 -0400
> @@ -10,3 +10,9 @@
>  /var/lib/spamassassin(/.*)?
> gen_context(system_u:object_r:spamd_var_lib_t,s0)
> 
>  /var/spool/spamassassin(/.*)?
> gen_context(system_u:object_r:spamd_spool_t,s0)
> +/var/spool/spamd(/.*)?
> gen_context(system_u:object_r:spamd_spool_t,s0)
> +
> +/var/run/spamassassin(/.*)?
> gen_context(system_u:object_r:spamd_var_run_t,s0)
> +/var/run/spamass-milter(/.*)?
> gen_context(system_u:object_r:spamd_var_run_t,s0)
> +
> +
> --- nsaserefpolicy/policy/modules/services/spamassassin.te
> 2007-08-02 08:17:27.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/spamassassin.te
> 2007-08-02 11:02:02.000000000 -0400
> @@ -83,8 +83,9 @@
>  allow spamd_t spamd_var_lib_t:dir list_dir_perms;
>  read_files_pattern(spamd_t,spamd_var_lib_t,spamd_var_lib_t)
> 
> +manage_dirs_pattern(spamd_t,spamd_var_run_t,spamd_var_run_t)
>  manage_files_pattern(spamd_t,spamd_var_run_t,spamd_var_run_t)
> -files_pid_filetrans(spamd_t,spamd_var_run_t,file)
> +files_pid_filetrans(spamd_t,spamd_var_run_t,{ file dir })
> 
>  kernel_read_all_sysctls(spamd_t)
>  kernel_read_system_state(spamd_t)
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
