Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA04895
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 10:51:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA15626
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 14:50:06 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA15622 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 14:50:03 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Date: Thu, 18 Apr 2002 16:51:01 +0200
References: <20020418112238.A1788@lemuria.org> <20020418104424.B714A44C1C@lyta.coker.com.au> <20020418142518.A5613@lemuria.org>
In-Reply-To: <20020418142518.A5613@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020418145101.D31F444CB8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Apr 2002 14:25, Tom wrote:
> > > Scenario: Webhosting with PHP, multiple users (possibly many)
> > > Danger: PHP runs as a module, i.e. with apache's user and permissions.
> >
> > Here's the problem, not just for SE Linux but also for regular Unix
> > permissions models and every other security system I know of.
>
> Absolutely. The problem is that you have a unified frontend with
> diversification at the backend. This is the same issue you have for
> ssh, except that ssh (and other remote login tools) have a method for
> changing to a specific user, based on user/password data.

Ssh solves it by forking a new process and changing UID BEFORE doing any work.

> > Trying to give access to only code from a certain shared object inside a
> > program is never going to work.  Anything Apache can do to get access,
> > some malicious code can also potentially do.
>
> That is not what I want to do. I want to regulate access to certain
> FILES. I don't care about apache itself at this point. The scenario I
> want to avoid is this:
>
> /var/www/user1/script.php
> /var/www/user2/script.php
>
> where user2's script contains something like:
> <? $f=fopen("../user1/script.php"); read($f); ?>

What you could do is to have a unix domain socket named /var/www/socket/user1 
which the Apache process creates and then forks off a child process to run 
all PHP code for user1 under the UID of that user, and then pass back the 
data to Apache through the socket for retransmission to the client.

In concept this is reasonably simple, and the performance impact shouldn't be 
that great (a site with lots of static content and a small amount of PHP 
won't be hit much - a site with lots of PHP will take so much CPU time that 
it won't make much difference ;).

An Apache module should be able to handle this.


Also while we're talking about such things.  I think we need to split gpg 
into at least two parts.  We need a separate program to read the secret key 
file so it can trigger a domain_auto_trans rule and thus prevent a hostile 
script from doing "gpg -e ~/.gnupg/secring.gpg".

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
