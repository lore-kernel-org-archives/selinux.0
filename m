Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5D0ThrT011932
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 20:29:44 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5D0TZP2000811
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 20:29:36 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: SELinux on Debian (Sid)
Date: Sun, 13 Jun 2004 10:29:35 +1000
Cc: selinux@tycho.nsa.gov
References: <20040609144404.GJ5477@philips.com> <200406121819.57709.russell@coker.com.au> <20040612143714.GA28996@yggdrasil.localdomain>
In-Reply-To: <20040612143714.GA28996@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406131029.35825.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 13 Jun 2004 00:37, Greg Norris <haphazard@kc.rr.com> wrote:
> On Sat, Jun 12, 2004 at 06:19:57PM +1000, Russell Coker wrote:
> > What version of the policy package?  I think I've fixed that in recent
> > versions...
>
> adric@sasami[~]$ dpkg -l selinux-policy-default | tail -1
> iF  selinux-policy 1.12-3         Policy config files and management for

When you upgraded the policy and you were asked for replacing policy files, 
did you say "Ignore" or "Always ignore" to the new files?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
