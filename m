Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5KCtsrT026106
	for <selinux@tycho.nsa.gov>; Sun, 20 Jun 2004 08:55:54 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5KCtf6w018143
	for <selinux@tycho.nsa.gov>; Sun, 20 Jun 2004 12:55:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: weird issue: double reboot required with errors on multi-partition system
Date: Sun, 20 Jun 2004 22:55:45 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040620090558.GR362@lkcl.net>
In-Reply-To: <20040620090558.GR362@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406202255.45806.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 20 Jun 2004 19:05, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> 2) fsck is run but there are errors that cannot be corrected,
>    manual intervention is required.
>
>    [btw at present, i get an "access denied" avc error on login at
>     the emergency "type root password or press CONTROL-D to continue"
> 	thing!  i've had to enable forced fsck checking!]

Yes, we need some policy and/or code changes for sulogin in Debian.

> now, why would file system errors cause _unrelated_ partitions
> to not be accessible?

Without knowing the AVC messages it's impossible to know (a null-modem cable 
and serial console is good for debugging this).  But I guess that the source 
context is wrong.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
