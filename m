Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA08053
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 17:44:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA17242
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 21:43:11 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA17238
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 21:43:10 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Date: Thu, 18 Apr 2002 23:44:40 +0200
References: <20020418112238.A1788@lemuria.org> <20020418184739.17C063002C@lyta.coker.com.au> <20020418224956.C11358@lemuria.org>
In-Reply-To: <20020418224956.C11358@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020418214440.887A644E3E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Apr 2002 22:49, Tom wrote:
> On Thu, Apr 18, 2002 at 08:47:38PM +0200, Russell Coker wrote:
> > > That would make sense, but I also
> > > see reasons for doing transitions during other file access operations
> > > (e.g. maybe you want to get a higher protection level while certain
> > > files are open).
> >
> > Allowing domain transitions on the fly does not help much, if the process
> > gets exploited then the attacker gets access to all domains.
>
> You have me lost here. If I allow a specific, controlled domain
> transition, how does that open up all domains to an attacker?

If we have 10 users with 10 different domains and allow Apache to change 
between them (forward and backward) at will, then anything which compromises 
Apache or any of it's scripts can get any of the domains.  In which case why 
not just save yourself the trouble and use a single domain.

> I have successfully attacked virtually all aspects of our companies
> mass webhosting servers using nothing but a 10 line .php script. The
> only thing between me and root was the fact that I didn't have the
> specific exploit for this specific platform. With better connections
> to the underground, I'd have scored yet another point at CTF.
>
> None of which would have been possible if there had been a tight domain
> for the PHP script to run in.

But a tight domain for PHP is impossible while PHP is essentially part of 
Apache.  To have a tight domain for PHP then you need to run it as a cgi-bin 
program using suexec.

> > > Maybe apache can initiate the domain transition itself? A singular
> > > patch in the URL parsing instance ("read target file's domain and make
> > > a transition to it") should be feasable. As you pointed out, this would
> > > be similiar to what suexec does.
> >
> > No.  When you run suexec you can only do what it allows, suexec is
> > designed to be small and well audited.  Apache is large and impossible to
> > be audited.
>
> Which is exactly why I don't want to mess with apache if it can be
> avoided and instead put the access controls and enforcement into the
> kernel.

The problem is that the kernel doesn't know what the application is trying to 
do with each file.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
