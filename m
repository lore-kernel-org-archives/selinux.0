Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BFabZw021695
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 11:36:37 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BFabDE028374
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 15:36:37 GMT
Subject: Re: iptables reads etc runtime files, execed out of failto ban
	with terminal redirected
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301417.l4UEHQRW007726@localhost.localdomain>
References: <200705301417.l4UEHQRW007726@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 11:35:11 -0400
Message-Id: <1181576111.16029.36.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:17 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/system/iptables.te	2007-05-29 14:10:58.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/system/iptables.te	2007-05-30 09:22:02.000000000 -0400
> @@ -56,6 +56,7 @@
>  domain_use_interactive_fds(iptables_t)
>  
>  files_read_etc_files(iptables_t)
> +files_read_etc_runtime_files(iptables_t)
>  
>  init_use_fds(iptables_t)
>  init_use_script_ptys(iptables_t)
> @@ -77,6 +78,10 @@
>  userdom_use_all_users_fds(iptables_t)
>  
>  optional_policy(`
> +	fail2ban_append_log(iptables_t)
> +')
> +
> +optional_policy(`
>  	firstboot_use_fds(iptables_t)
>  	firstboot_rw_pipes(iptables_t)
>  ')

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
