Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7CJwpWU015171
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 15:58:51 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m7CJwcd8003852
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 19:58:38 GMT
Subject: Re: [patch 23/35] iptables policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123738.402815931@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123738.402815931@hardeman.nu>
Content-Type: text/plain
Date: Tue, 12 Aug 2008 15:57:46 -0400
Message-Id: <1218571066.8095.21.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_system_iptables.patch)
> Trivial changes from the RH patchset to the iptables module...

Merged.

> Index: refpolicy/policy/modules/system/iptables.te
> ===================================================================
> --- refpolicy.orig/policy/modules/system/iptables.te	2008-07-19 19:15:43.000000000 +0200
> +++ refpolicy/policy/modules/system/iptables.te	2008-08-03 20:38:53.000000000 +0200
> @@ -48,6 +48,7 @@
>  
>  fs_getattr_xattr_fs(iptables_t)
>  fs_search_auto_mountpoints(iptables_t)
> +fs_list_inotifyfs(iptables_t)
>  
>  mls_file_read_all_levels(iptables_t)
>  
> @@ -70,8 +71,6 @@
>  libs_use_shared_libs(iptables_t)
>  
>  logging_send_syslog_msg(iptables_t)
> -# system-config-network appends to /var/log
> -#logging_append_system_logs(iptables_t)
>  
>  miscfiles_read_localization(iptables_t)
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
