Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7ODuArT026396
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 09:56:10 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7ODtPMZ006925
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 13:55:25 GMT
Subject: Re: constraints and subtraction
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <412A5BD0.8050606@tresys.com>
References: <412A5BD0.8050606@tresys.com>
Content-Type: text/plain
Message-Id: <1093355682.1800.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 09:54:43 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-23 at 17:04, Joshua Brindle wrote:
> I was wondering if there was a specific reason that constraints don't 
> support subtraction but support attributes, sets, * and ~. For example 
> the following might be useful:
> 
> constrain dir_file_class_set { create relabelto relabelfrom }
>          ( u1 == u2 or t1 == { privowner -sysadm_t } );

Laziness and fear ;)  Feel free to change it, but it may be more
complicated than you expect.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
