Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8DGMqLa002417
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 12:22:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8DGMpmw025940
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 16:22:51 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8DGMn9d025937 for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 16:22:50 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Debian package: how to relabel
Date: Sun, 14 Sep 2003 02:22:39 +1000
Cc: Dale Amon <amon@vnl.com>, Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030913160546.GD16830@vnl.com>
In-Reply-To: <20030913160546.GD16830@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309140222.39823.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 14 Sep 2003 02:05, Dale Amon wrote:
> Question for either one of you. How do I do the equiv
> of a make relabel with the debian package install? I
> have a man page for setfiles but can't seem to find
> the command itself...

make -C /etc/selinux relabel

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
