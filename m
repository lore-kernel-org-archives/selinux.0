Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA06931
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 14:47:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA07832
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 18:46:09 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA07817
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 18:46:08 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Date: Thu, 18 Apr 2002 20:47:38 +0200
References: <20020418112238.A1788@lemuria.org> <20020418160829.1AF9F44D90@lyta.coker.com.au> <20020418183258.B7029@lemuria.org>
In-Reply-To: <20020418183258.B7029@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020418184739.17C063002C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Apr 2002 18:32, Tom wrote:
> > Which means that they can't be given a different UID and therefore they
> > can't be given a different domain because domain transition can only
> > occur at exec time (just like for SUID programs).
>
> If that is so, then my question is answered. Is execution really the
> only point for a domain transition?

Apparently, and the NSA people don't seem to like the idea of changing it.

> That would make sense, but I also
> see reasons for doing transitions during other file access operations
> (e.g. maybe you want to get a higher protection level while certain
> files are open).

Allowing domain transitions on the fly does not help much, if the process 
gets exploited then the attacker gets access to all domains.

> I see that this may not be possible with the current SELinux code. I'm
> trying to point out that it may be useful. PHP is not the only thing
> coming to mind.

Reducing security can always be "useful" by adding functionality...  ;)

> Maybe apache can initiate the domain transition itself? A singular
> patch in the URL parsing instance ("read target file's domain and make a
> transition to it") should be feasable. As you pointed out, this would
> be similiar to what suexec does.

No.  When you run suexec you can only do what it allows, suexec is designed 
to be small and well audited.  Apache is large and impossible to be audited.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
