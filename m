Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71ESarT007210
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 10:28:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i71ESX0x021645
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 14:28:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: selinux-policy-default 1.14 is missing _stacks_ of stuff
Date: Mon, 2 Aug 2004 00:28:28 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040801103252.GC7384@lkcl.net> <200408012254.15553.russell@coker.com.au> <20040801135421.GE15205@lkcl.net>
In-Reply-To: <20040801135421.GE15205@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408020028.28909.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 1 Aug 2004 23:54, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > Your /etc/selinux/config file should have the following line:
> > SELINUXTYPE=.
>
>  ah... there isn't an /etc/selinux/config file...
>
>  perhaps that is the cause of the problem?

selinux-policy-default version 1.14-1 has the file, you can verify this with 
"dpkg -c".

# dpkg -c /var/cache/apt/archives/selinux-policy-default_1%3a1.14-1_all.deb |
grep /etc/selinux/config
-rw-r--r-- root/root       120 2004-07-13 19:33:09 ./etc/selinux/config

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
