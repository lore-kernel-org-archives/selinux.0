Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA07811
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 16:52:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA07453
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 20:51:24 GMT
Received: from mail.lemuria.org ([213.191.74.130])
        by jazzband.ncsc.mil  with ESMTP id UAA07449 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 20:51:23 GMT
Received: from unicorn.lemuria.org (b067114.adsl.hansenet.de [62.109.67.114])
	by mail.lemuria.org (Postfix) with ESMTP id 5680FBB8B
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 22:46:10 +0200 (CEST)
Date: Thu, 18 Apr 2002 22:49:57 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Message-ID: <20020418224956.C11358@lemuria.org>
References: <20020418112238.A1788@lemuria.org> <20020418160829.1AF9F44D90@lyta.coker.com.au> <20020418183258.B7029@lemuria.org> <20020418184739.17C063002C@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020418184739.17C063002C@lyta.coker.com.au>; from russell@coker.com.au on Thu, Apr 18, 2002 at 08:47:38PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 18, 2002 at 08:47:38PM +0200, Russell Coker wrote:
> > That would make sense, but I also
> > see reasons for doing transitions during other file access operations
> > (e.g. maybe you want to get a higher protection level while certain
> > files are open).
> 
> Allowing domain transitions on the fly does not help much, if the process 
> gets exploited then the attacker gets access to all domains.

You have me lost here. If I allow a specific, controlled domain
transition, how does that open up all domains to an attacker?


> > I see that this may not be possible with the current SELinux code. I'm
> > trying to point out that it may be useful. PHP is not the only thing
> > coming to mind.
> 
> Reducing security can always be "useful" by adding functionality...  ;)

I don't think that what essentially amounts to world-readability could
seriously be called security. A tighter handling of user files is
definitely good, if not necessary.

I have successfully attacked virtually all aspects of our companies
mass webhosting servers using nothing but a 10 line .php script. The
only thing between me and root was the fact that I didn't have the 
specific exploit for this specific platform. With better connections 
to the underground, I'd have scored yet another point at CTF.

None of which would have been possible if there had been a tight domain
for the PHP script to run in.


> > Maybe apache can initiate the domain transition itself? A singular
> > patch in the URL parsing instance ("read target file's domain and make a
> > transition to it") should be feasable. As you pointed out, this would
> > be similiar to what suexec does.
> 
> No.  When you run suexec you can only do what it allows, suexec is designed 
> to be small and well audited.  Apache is large and impossible to be audited.

Which is exactly why I don't want to mess with apache if it can be
avoided and instead put the access controls and enforcement into the
kernel.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
