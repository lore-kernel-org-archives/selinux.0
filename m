Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBCDvFRb008595
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 08:57:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBCDuTlU014217
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 13:56:29 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hBCDuCSX014138
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 13:56:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos =?iso-8859-1?q?An=EDsio=20Monteiro?= <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
Subject: Re: Information about selinuxfs
Date: Sat, 13 Dec 2003 00:55:29 +1100
References: <3FD9B8F2.7030100@ipen.br>
In-Reply-To: <3FD9B8F2.7030100@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312130055.29272.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Dec 2003 23:47, Carlos Anísio Monteiro <monteiro@ipen.br> wrote:
> A information about the selinuxfs filesystem.
> The directory name and the path to mount o selinuxfs must be alway
> /selinux. A change on this name (/selinux) only affect the sysvinit and
> initrd, what set the directory name and path, or it will cause others
> problems ?

Every program that wants to verify the validity of a security context, load 
new security policy, check the version of the policy, or do almost any other 
operation that involves SE Linux will depend on the path.  So changing the 
mount point will require recompiling libselinux.

There has been some discussion about this, but so far no decision has been 
made.

Why do you want to change it and where do you think would be the best place?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
