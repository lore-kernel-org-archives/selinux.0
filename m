Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8PCLHsJ023511
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 08:21:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8PCJWZt014791
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 12:19:33 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8PCJVM3014788
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 12:19:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: ssh policy hassles
Date: Thu, 25 Sep 2003 22:21:09 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030923150926.GG21997@vnl.com> <20030925104456.GD10234@vnl.com> <20030925121733.GF10234@vnl.com>
In-Reply-To: <20030925121733.GF10234@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309252221.09162.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 Sep 2003 22:17, Dale Amon wrote:
> On Thu, Sep 25, 2003 at 11:44:57AM +0100, Dale Amon wrote:
> > I'm starting to wonder if this has anything to do with the
> > 2.6.0 devpts filesystem?
>
> Okay, I find this, which doesn't seem right:
>
> drwxr-xr-x  root     root     (null)                           /dev/pts

It doesn't seem right, but it apparently is.  On my 2.4.21 SE2 system it has 
no label on /dev/pts and sshd works perfectly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
