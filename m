Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA09129
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 02:17:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id GAA29548
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 06:16:07 GMT
Received: from mail.lemuria.org ([213.191.74.130])
        by jazzband.ncsc.mil  with ESMTP id GAA29544 for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 06:16:06 GMT
Received: from unicorn.lemuria.org (b067114.adsl.hansenet.de [62.109.67.114])
	by mail.lemuria.org (Postfix) with ESMTP id 695A8BB8B
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 08:10:48 +0200 (CEST)
Date: Fri, 19 Apr 2002 08:14:35 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Message-ID: <20020419081435.C11674@lemuria.org>
References: <20020418112238.A1788@lemuria.org> <20020418184739.17C063002C@lyta.coker.com.au> <20020418224956.C11358@lemuria.org> <20020418214440.887A644E3E@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020418214440.887A644E3E@lyta.coker.com.au>; from russell@coker.com.au on Thu, Apr 18, 2002 at 11:44:40PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 18, 2002 at 11:44:40PM +0200, Russell Coker wrote:
> > You have me lost here. If I allow a specific, controlled domain
> > transition, how does that open up all domains to an attacker?
> 
> If we have 10 users with 10 different domains and allow Apache to change 
> between them (forward and backward) at will, then anything which compromises 
> Apache or any of it's scripts can get any of the domains.  In which case why 
> not just save yourself the trouble and use a single domain.

I see two scenarios:

1) Apache itself is compromised. In that case, you are where you are
right now, namely that the attacker has all the rights that apache has.
Nothing gained, but nothing lost, either.

2) A single script gets compromised. In that case, the attacker is in a
tiny domain that allows access to only one user's files. That's a huge
gain, and this danger is many times higher than the other one.

There would be no transition between user domains. The transitions
allowed would be from apache to a user and from a user to apache. The
later would happen on exit. As long as your script is still doing
stuff, you are in the user domain.


> > None of which would have been possible if there had been a tight domain
> > for the PHP script to run in.
> 
> But a tight domain for PHP is impossible while PHP is essentially part of 
> Apache.  To have a tight domain for PHP then you need to run it as a cgi-bin 
> program using suexec.

All this was to find out whether it is possible with SELinux to have
the cake (module) and eat it, too (have security). Looks like it isn't.


> The problem is that the kernel doesn't know what the application is trying to 
> do with each file.

It doesn't have to. All it needs is to understand that it opens a file,
which it does understand pretty well, and that if that file has a
certain label, it needs to make a domain transition. That is apparently
the point it doesn't "get", so I'll have to look for a different way of
doing things.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
