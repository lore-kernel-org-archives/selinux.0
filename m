Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7CJQRrT019293
	for <selinux@tycho.nsa.gov>; Thu, 12 Aug 2004 15:26:27 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7CJQQBo020480
	for <selinux@tycho.nsa.gov>; Thu, 12 Aug 2004 19:26:26 GMT
Subject: Re: net_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <20040812164944.64756.qmail@web51507.mail.yahoo.com>
References: <20040812164944.64756.qmail@web51507.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1092338711.16219.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 15:25:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-08-12 at 12:49, Park Lee wrote:
> Mon, 9 Aug 2004 18:09.  Russell Coker wrote:
>  
> >Some parts of the file are order sensitive, net_contexts is one of
> them.
>  
> Then, would you please tell us what others are?

The language grammar is defined in checkpolicy/policy_parse.y, and
documented in the Configuring the SELinux Policy report (although it is
not entirely up to date).  It doesn't allow for mixing other elements of
the language (like context specifications) with the TE and RBAC
statements.  Note that the context specifications come after all
components of a context have been defined (i.e. all types, roles, and
users have been declared).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
