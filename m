Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA16229
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 12:28:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA21476
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 17:25:48 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id RAA21472
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 17:25:47 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <blacknet@simplyaquatics.com>, "Selinux" <selinux@tycho.nsa.gov>
Subject: Re: Freeswan breaks lsm kernel build
Date: Sun, 22 Dec 2002 18:28:03 +0100
References: <000201c2a9dc$6fb3d170$0a01a8c0@simplyaquatics.com>
In-Reply-To: <000201c2a9dc$6fb3d170$0a01a8c0@simplyaquatics.com>
MIME-Version: 1.0
Message-Id: <200212221828.03290.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 22 Dec 2002 18:06, Ed Street wrote:
> I am working with 2.4.20 kernel and applying lm_sensors, i2c, freeswan
> v1.99 and lsm.  After installing freeswan and I attempt to apply lsm
> (lsm_2002.12.12-2_all.deb) it does not apply cleanly.
>
> Testing whether LSM Support for Linux patch for 2.4.20 applies (dry
> run):
> 1 out of 2 hunks FAILED -- saving rejects to file
> arch/i386/defconfig.rej
> LSM Support for Linux patch for 2.4.20 does not apply cleanly

The defconfig file is not something that matters.  I never had problems with 
freeswan, but I guess that was because I usually dumped the defconfig part 
from my kernel patch packages.

Of course your kernel may still fail to compile, I've never tried compiling 
freeswan and lsm with 2.4.20...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
