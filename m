Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA29219
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 16:58:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA06716
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 21:56:18 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA06712
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 21:56:16 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Paul Loo" <PaulL@comglobal.com>, <selinux@tycho.nsa.gov>
Subject: Re: Kernet panic VFS: Unable to mount root fs
Date: Thu, 7 Nov 2002 22:57:15 +0100
References: <DB4BA538D0DA21479C610B2466EEF646162727@sjmail.global.com>
In-Reply-To: <DB4BA538D0DA21479C610B2466EEF646162727@sjmail.global.com>
MIME-Version: 1.0
Message-Id: <200211072257.15236.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Nov 2002 21:47, Paul Loo wrote:
> I installed Mandrake 9.0 with an ext3 file system. I ran the "make
> quickinstall"  for selinux and I
>
> Got these messages during boot:

If you can't mount the root file system and there are no "avc" messages then 
I'm willing to bet that the problem is nothing to do with SE Linux.

I recommend that you try installing a non-SE Linux kernel that you compiled 
yourself first, I expect you'll find that there's some error in the initrd 
creation process that affects any kernel you install regardless of whether it 
has SE Linux compiled in.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
