Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA04014
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 08:24:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA07891
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 12:23:24 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id MAA07887 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 12:23:24 GMT
Date: Thu, 18 Apr 2002 14:25:18 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Message-ID: <20020418142518.A5613@lemuria.org>
References: <20020418112238.A1788@lemuria.org> <20020418104424.B714A44C1C@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020418104424.B714A44C1C@lyta.coker.com.au>; from russell@coker.com.au on Thu, Apr 18, 2002 at 12:44:24PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 18, 2002 at 12:44:24PM +0200, Russell Coker wrote:
> > Scenario: Webhosting with PHP, multiple users (possibly many)
> > Danger: PHP runs as a module, i.e. with apache's user and permissions.
> 
> Here's the problem, not just for SE Linux but also for regular Unix 
> permissions models and every other security system I know of.

Absolutely. The problem is that you have a unified frontend with
diversification at the backend. This is the same issue you have for
ssh, except that ssh (and other remote login tools) have a method for
changing to a specific user, based on user/password data.


> Trying to give access to only code from a certain shared object inside a 
> program is never going to work.  Anything Apache can do to get access, some 
> malicious code can also potentially do.

That is not what I want to do. I want to regulate access to certain
FILES. I don't care about apache itself at this point. The scenario I
want to avoid is this:

/var/www/user1/script.php
/var/www/user2/script.php

where user2's script contains something like:
<? $f=fopen("../user1/script.php"); read($f); ?>




-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
