Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h541blI4020155
	for <selinux@tycho.nsa.gov>; Tue, 3 Jun 2003 21:37:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h541Zrss023127
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 01:35:53 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h541ZZhY023118
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 01:35:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: John Wolff <jrwolff@comcast.net>, Brian May <bam@snoopy.apana.org.au>
Subject: Re: Compaq DL-360
Date: Wed, 4 Jun 2003 11:35:09 +1000
Cc: selinux@tycho.nsa.gov
References: <3ED7C88A.7060209@comcast.net> <20030601223130.GA29681@snoopy.apana.org.au> <3EDD2991.5050609@comcast.net>
In-Reply-To: <3EDD2991.5050609@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306041135.09286.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Jun 2003 09:04, John Wolff wrote:
> Kmod:  failed to exec /sbin/modprobe -s -k block-major-72, errno=2
>  VFS:   Cannot open root device "4802" or 48:02
>  Please append a correct "root=" boot option
>  Kernel panic:  VFS:  Unable tomount root fs on 48:02

It seems that you are using a Compaq Intelligent Drive Array and you failed to 
either compile the driver into the kernel or put it on the initrd.

It's probably easiest for you to just compile the driver into the kernel.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
