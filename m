Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NKNxvR029631
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 15:23:59 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1NKPI0Z014983
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 20:25:18 GMT
Subject: Re: IPTables needs to be able to talk to the terminal
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB25B4.70201@redhat.com>
References: <45DB25B4.70201@redhat.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 20:25:26 +0000
Message-Id: <1172262326.15371.100.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 11:45 -0500, Daniel J Walsh wrote:
> service iptables status  needs to be able to work.

Notes inline:

> --- nsaserefpolicy/policy/modules/system/iptables.te    2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.4/policy/modules/system/iptables.te 2007-02-19 16:08:20.000000000 -0500
> @@ -51,7 +51,7 @@
>  
>  mls_file_read_up(iptables_t)
>  
> -term_dontaudit_use_console(iptables_t)
> +term_use_console(iptables_t)
>  
>  domain_use_interactive_fds(iptables_t)

Since "service iptables status" is interactive, this doesn't seem to
fit.

> @@ -77,9 +77,11 @@
>  userdom_use_all_users_fds(iptables_t)
>  
>  ifdef(`targeted_policy', `
> -       term_dontaudit_use_unallocated_ttys(iptables_t)
> -       term_dontaudit_use_generic_ptys(iptables_t)
> +       term_use_unallocated_ttys(iptables_t)
> +       term_use_generic_ptys(iptables_t)
> +       term_use_all_user_ptys(iptables_t)

This last line doesn't fit since not all users can run iptables; this
type of thing is what run interfaces are for.

>         files_dontaudit_read_root_files(iptables_t)
> +       unconfined_rw_pipes(iptables_t)

What is this for?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
