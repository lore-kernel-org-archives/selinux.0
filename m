Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26GAhY8004344
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 11:10:43 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l26GC63C009464
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 16:12:06 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: setroubleshoot changes for policy
Date: Tue, 6 Mar 2007 11:11:55 -0500
Message-ID: <1173197515.917.3.camel@sgc>
In-Reply-To: <200702261742.l1QHgOWm030713@localhost.localdomain>
References: <200702261742.l1QHgOWm030713@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:42 -0500, dwalsh@localhost.localdomain wrote:
> setroubleshoot has a plugin that checks the file context on disk versus a matchpathcon.  So needs additional privs

Merged.

> ===File /tmp/patches/done/nsaserefpolicy_policy_modules_services_setroubleshoot.patch===
> --- nsaserefpolicy/policy/modules/services/setroubleshoot.te	2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/services/setroubleshoot.te	2007-02-26 11:02:34.000000000 -0500
> @@ -74,8 +74,10 @@
>  files_read_usr_files(setroubleshootd_t)
>  files_read_etc_files(setroubleshootd_t)
>  files_getattr_all_dirs(setroubleshootd_t)
> +files_getattr_all_files(setroubleshootd_t)
>  
>  selinux_get_enforce_mode(setroubleshootd_t)
> +selinux_validate_context(setroubleshootd_t)
>  
>  term_dontaudit_use_console(setroubleshootd_t)
>  term_dontaudit_use_all_user_ptys(setroubleshootd_t)
> @@ -97,8 +99,10 @@
>  logging_stream_connect_auditd(setroubleshootd_t)
>  
>  seutil_read_config(setroubleshootd_t)
> +seutil_read_file_contexts(setroubleshootd_t)
>  
>  sysnet_read_config(setroubleshootd_t)
> +userdom_dontaudit_read_sysadm_home_content_files(setroubleshootd_t)
>  
>  ifdef(`targeted_policy',`
>  	term_dontaudit_use_generic_ptys(setroubleshootd_t)
> ============================================================
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
