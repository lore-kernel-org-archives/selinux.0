Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA03713
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 06:44:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA04214
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 10:43:39 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA04210 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 10:43:37 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Date: Thu, 18 Apr 2002 12:44:24 +0200
References: <20020418112238.A1788@lemuria.org>
In-Reply-To: <20020418112238.A1788@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020418104424.B714A44C1C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Apr 2002 11:22, Tom wrote:
> Scenario: Webhosting with PHP, multiple users (possibly many)
> Danger: PHP runs as a module, i.e. with apache's user and permissions.

Here's the problem, not just for SE Linux but also for regular Unix 
permissions models and every other security system I know of.

Trying to give access to only code from a certain shared object inside a 
program is never going to work.  Anything Apache can do to get access, some 
malicious code can also potentially do.

> Solution: domain transition to individual user's domain when reading a
> file of that user. something like
> domain_auto_trans(httpd_t, user_webdata_t, user_t)
> should do the trick (I say "something like" because this macro expands
> to include only execution, but I see no reason why the same can't be
> done for file open or read).

It could, but that't not the security model that the NSA people want.  It 
would just open too many security issues.

Even having a system call to allow a process to change domain (much less 
risky) is something that they don't want.

> The tricky part is that the apache will have to revert BACK to its
> original domain once the operation is done, i.e. something like "on
> socket close, domain transition to httpd_t". however, the user_t domain
> should not have the general ability to make a transition to httpd_t.
>
> Am I making any sense? Or do I need to read the papers again? :)

To do this type of thing you need to have the php code run from a separate 
program.  PHP has some support for this, but I could never get it to work 
properly.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
