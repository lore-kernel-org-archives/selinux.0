Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j31KYvDo015282
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2005 15:34:57 -0500 (EST)
Subject: Re: [patch] tighten fetchmail policy
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Greg Norris <haphazard@kc.rr.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050330014646.GA19610@yggdrasil.localdomain>
References: <20050330014646.GA19610@yggdrasil.localdomain>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 15:34:36 -0500
Message-Id: <1112387676.9437.31.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged, except for this little bit.
Better to use r_file_perms and allow the lock permission, unless there
is a good reason not to allow lock.

On Tue, 2005-03-29 at 19:46 -0600, Greg Norris wrote:
>  
>  # file access
> -allow fetchmail_t etc_t:file r_file_perms;
> -allow fetchmail_t fetchmail_etc_t:file r_file_perms;
> +allow fetchmail_t etc_t:file { read getattr ioctl };
> +allow fetchmail_t fetchmail_etc_t:file { read getattr ioctl };
>  allow fetchmail_t mail_spool_t:dir search;
>  file_type_auto_trans(fetchmail_t, mail_spool_t,
> fetchmail_uidl_cache_t, file)
> 
> 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
