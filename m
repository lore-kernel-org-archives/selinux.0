Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3Q3hARb018857
	for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 23:43:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3Q3exW3011913
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2004 03:41:00 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i3Q3ewIx011892
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2004 03:40:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ed Street" <edstreet@street-tek.com>
Subject: Re: sshd, devpts, unix_chkpwd
Date: Mon, 26 Apr 2004 13:41:38 +1000
Cc: <selinux@tycho.nsa.gov>
References: <20040425145703.6C4ED3A404F@abyss.simplyaquatics.com>
In-Reply-To: <20040425145703.6C4ED3A404F@abyss.simplyaquatics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <200404261341.38667.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Apr 2004 00:57, "Ed Street" <edstreet@street-tek.com> wrote:
> How about some type of wrapper that would force passwd (and other programs)
> to run in a specific domain instead of doing mods to the programs itself?

We had that, but decided that modifying PAM was better than having wrapper 
programs.

> As for ssh 3.8 under debian I had to add the following line for user logins
> to occur correctly.
>
> #ssh 3.8 stuff
> allow staff_t sshd_devpts_t:chr_file { read write ioctl };

This is due to a bug, the pty is not getting correctly relabeled.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
