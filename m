Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91ExgrT001837
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 10:59:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i91ExeEZ003040
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 14:59:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: /usr/sbin/fstab-sync from HAL
Date: Sat, 2 Oct 2004 00:59:31 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040926195755.GH28076@lkcl.net>
In-Reply-To: <20040926195755.GH28076@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410020059.31398.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 27 Sep 2004 05:57, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> anyone got any good ideas about what domain fstab-sync should be in?
>
> it's run by HAL on-demand from /etc/hal/device.d/50-fstab-sync.hal as
> a symlink.

updfstab_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
