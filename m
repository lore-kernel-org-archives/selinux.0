Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JK1xRb013714
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 16:02:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4JJxXB2015299
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 19:59:34 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4JJxWwi015224
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 19:59:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Steve Greenland <steveg@moregruel.net>
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Date: Thu, 20 May 2004 06:00:46 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, 193644@bugs.debian.org,
   Stephen Smalley <sds@epoch.ncsc.mil>
References: <20040519091454.GL7348@lkcl.net> <20040519140239.GF4221@lkcl.net> <20040519181120.GA6115@moregruel.net>
In-Reply-To: <20040519181120.GA6115@moregruel.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405200600.46881.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 May 2004 04:11, Steve Greenland <steveg@moregruel.net> wrote:
> It feels very misleading and confusing to overload it that way, and I
> don't see the difference between checking for "system_u" and "*system*".
>
> Except that "system_u" *is* a valid username, therefore raising the
> possiblity of conflict between /etc/crontab and the crontab of user
> system_u.

If you are using SE Linux then a user name of "system_u" is not going to 
work, /bin/login etc can't launch shells with system_u as the identity.

I guess we can have the SE Linux code in crond know that "*system*" means that 
the identity of "system_u" should be used.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
