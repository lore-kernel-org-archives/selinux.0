Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAC2ejSf011165
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2003 21:40:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAC2eKBb027227
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 02:40:20 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAC2eI4o027224
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 02:40:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Authentication failure
Date: Wed, 12 Nov 2003 13:40:20 +1100
Cc: selinux@tycho.nsa.gov
References: <20031112010929.GY23277@vnl.com>
In-Reply-To: <20031112010929.GY23277@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311121340.20835.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 12 Nov 2003 12:09, Dale Amon wrote:
> I'm getting 'Authentication Failure' when I go to login.
> This is a freshly installed system (disk image built
> elsewhere and rolled in). I can log in if I boot
> single user; that way I was able to label the file
> system and then reboot via the initrd... but the
> full selinux boot also gives 'Authentication failure'.
>
> Could it be there is still some conflict in packages
> between Coker, Walters and sid?

Recently I have been working on changes to pam and policy to lock down access 
to /etc/shadow.  These changes are inter-dependent, so if you change one 
without the other then the result is a broken system.

I guess that you are either not running my pam packages or you are not running 
the latest policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
