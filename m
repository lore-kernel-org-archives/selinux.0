Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8DHR9La002717
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 13:27:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8DHPULY018413
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 17:25:30 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8DHPSsG018405
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 17:25:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Debian package: how to relabel
Date: Sun, 14 Sep 2003 03:26:59 +1000
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030913160546.GD16830@vnl.com> <20030913163259.GE16830@vnl.com> <20030913164219.GF16830@vnl.com>
In-Reply-To: <20030913164219.GF16830@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309140326.59834.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 14 Sep 2003 02:42, Dale Amon wrote:
> On Sat, Sep 13, 2003 at 05:32:59PM +0100, Dale Amon wrote:
> > On Sun, Sep 14, 2003 at 02:22:39AM +1000, Russell Coker wrote:
> > > make -C /etc/selinux relabel
> >
> > Close but no cigar. I'm missing /usr/sbin/setfiles.
> > What package should have installed it? I've got
> > a man page for it but no binary.
>
> In answer to my own question, it appears to be part of the
> policycoreutils package, but is not installed for some
> reason... I think a forced reinstall is in order!

I guess there are problems with the dependencies for Debian packages.  
Reinstall is not necessary, just install policycoreutils (or is that what you 
meant?).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
