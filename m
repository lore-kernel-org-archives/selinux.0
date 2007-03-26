Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QJgiuS023235
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 15:42:44 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2QJggRM022417
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 19:42:43 GMT
Subject: Re: system-config-service of iptables needs this patch to work in
	targeted policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F021D7.4060401@redhat.com>
References: <45F021D7.4060401@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 19:43:18 +0000
Message-Id: <1174938199.28830.72.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 09:46 -0500, Daniel J Walsh wrote:
> Basically iptables needs to be able to output to the terminal and
> talk 
> to unconfined_pipes from the tool.
> 
> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (nsaserefpolicy_policy_modules_system_iptables.patch)
> 
> --- nsaserefpolicy/policy/modules/system/iptables.te    2007-02-19
> 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/system/iptables.te 2007-03-08
> 08:42:37.000000000 -0500
> @@ -77,9 +77,10 @@
>  userdom_use_all_users_fds(iptables_t)
>  
>  ifdef(`targeted_policy', `
> -       term_dontaudit_use_unallocated_ttys(iptables_t)
> -       term_dontaudit_use_generic_ptys(iptables_t)
> +       term_use_unallocated_ttys(iptables_t)
> +       term_use_generic_ptys(iptables_t)
>         files_dontaudit_read_root_files(iptables_t)
> +       unconfined_rw_pipes(iptables_t)
>  ')
>  
>  optional_policy(`

Merged this part.

> @@ -111,3 +112,7 @@
>  optional_policy(`
>         udev_read_db(iptables_t)
>  ')
> +
> +optional_policy(`
> +       fail2ban_append_log(iptables_t)
> +')
> 

But not this one since it doesn't seem relevant.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
