Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hASBArRb026800
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 06:10:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hASBAHp5007599
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 11:10:17 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hASBAFt0007596
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 11:10:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: More mkinitrd setup script problems
Date: Fri, 28 Nov 2003 22:10:39 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20031128110536.GE12418@vnl.com>
In-Reply-To: <20031128110536.GE12418@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311282210.39268.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Nov 2003 22:05, Dale Amon <amon@vnl.com> wrote:
> You'll need to add these two lines, or something like them,
> to /etc/mkinitrd/scripts/selinux
>
> 	cp -aL /lib/libselinux.so.1 "$INITRDDIR/lib/"
> 	cp -aL /lib/libattr.so.1 "$INITRDDIR/lib/"
>
> to allow load_policy to run. I'm wondering if something
> major happened to load_policy recently. It worked without
> this until a few days ago.

Strange, I would have expected libselinux.so.1 to be needed for quite a while.

I've added it to my package and will have a new version online shortly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
