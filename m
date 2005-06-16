Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5GGARgA002341
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 12:10:29 -0400 (EDT)
Received: from smtp-bedford.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5GG1JI8018236
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 16:01:20 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with SMTP id j5GG1oo00429
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 12:01:50 -0400
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id 45542BEFB
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 12:01:50 -0400 (EDT)
Received: from MAILHUB2 (mailhub2.mitre.org [129.83.28.8])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id j5GG1oA00381
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 12:01:50 -0400
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux?
References: <20050613220328.31770.qmail@web31602.mail.mud.yahoo.com>
From: bsniffen@mitre.org (Brian T. Sniffen)
Date: Thu, 16 Jun 2005 12:01:41 -0400
In-Reply-To: <20050613220328.31770.qmail@web31602.mail.mud.yahoo.com> (Casey
 Schaufler's message of "Mon, 13 Jun 2005 15:03:28 -0700 (PDT)")
Message-ID: <d287jguwasa.fsf@jon-strange.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> writes:

> Username mapping errors are bad, but one or the
> other of the individuals involved usually detects
> the problem quickly enough. I don't know that I'd
> expect the same to be true of policy elements.

We already see admins doing this regularly: they drop a file from Red
Hat's strict policy into the their Fedora system using Targeted
policy, or from Fedora onto a Debian system, and are surprised when it
does not work.

The average userbase will always expect user_t and httpd_t to mean the
same things everywhere, even though they will not.  It's because of
this difficulty that polgen does only structural analysis, ignoring
accidents of naming.  We're having enough trouble adapting our output
to the evolving details of policy differences (e.g., unconfined_t vs. user_t).

-Brian


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
