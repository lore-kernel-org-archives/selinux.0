Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5QGCggA018575
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 12:12:51 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5QGBhqP009342
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 16:11:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Karl MacMillan" <kmacmillan@tresys.com>
Subject: Re: Alternative user management approach
Date: Mon, 27 Jun 2005 02:11:39 +1000
Cc: selinux@tycho.nsa.gov
References: <200506241841.j5OIfiqc018618@gotham.columbia.tresys.com>
In-Reply-To: <200506241841.j5OIfiqc018618@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506270211.43875.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 25 June 2005 04:41, "Karl MacMillan" <kmacmillan@tresys.com> 
wrote:
> > Is the user info used for anything besides rbac?
> > I don't think it is...
>
> It can be used for constraints. There have been some suggested uses for
> this, but none are currently implemented in real policies. User separation
> seems better left to DAC.

Currently the identity is only really used for constraints on file relabeling.

Some people were talking on #selinux about using constraints to restrict the 
ability to see processes in "ps" output based on role, if that was 
implemented then it seems a natural extension to add an identity check at the 
same time.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
