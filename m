Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7IAwBrT019312
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 06:58:11 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7IAvTho006132
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 10:57:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: removed lpd.te, kept cups.te
Date: Wed, 18 Aug 2004 20:57:50 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040817113807.GO18321@lkcl.net>
In-Reply-To: <20040817113807.GO18321@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408182057.50798.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Aug 2004 21:38, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> i removed lpd.te, i kept cups.te (which reflects what i have
> set up: lpd is not enabled, lpd emulation in cups is not enabled).
>
> ... but instead i get error at line 29: unknown type printer_device_t.
>
> am i missing something?

Line 5 of cups.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
