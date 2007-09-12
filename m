Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8CEkfMG031145
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 10:46:41 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l8CEka11026178
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 14:46:38 GMT
Subject: Re: [PATCH] refpolicy: services_procmail changes - Minor procmail
	fixes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022044.l72Ki5eY032692@redsox.boston.devel.redhat.com>
References: <200708022044.l72Ki5eY032692@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 12 Sep 2007 10:45:07 -0400
Message-Id: <1189608307.7512.33.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:44 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/procmail.te  2007-07-25
> 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/procmail.te
> 2007-08-02 11:02:02.000000000 -0400
> @@ -30,6 +30,8 @@
>  allow procmail_t procmail_tmp_t:file manage_file_perms;
>  files_tmp_filetrans(procmail_t, procmail_tmp_t, file)
> 
> +can_exec(procmail_t,procmail_exec_t)
> +
>  kernel_read_system_state(procmail_t)
>  kernel_read_kernel_sysctls(procmail_t)
> 
> @@ -108,6 +110,9 @@
>         # for a bug in the postfix local program
>         postfix_dontaudit_rw_local_tcp_sockets(procmail_t)
>         postfix_dontaudit_use_fds(procmail_t)
> +       postfix_read_spool_files(procmail_t)
> +       postfix_read_local_state(procmail_t)
> +       postfix_read_master_state(procmail_t)
>  ')
> 
>  optional_policy(`

Merged.

> @@ -129,3 +134,7 @@
>         spamassassin_exec_client(procmail_t)
>         spamassassin_read_lib_files(procmail_t)
>  ')
> +
> +optional_policy(`
> +       mailscanner_read_spool(procmail_t)
> +')

dropped since the mailscanner policy looked incomplete.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
