Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6HDcVrT004536
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 09:38:31 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6HDc6IR019849
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 13:38:07 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: installing openoffice.org-mimelnk gives access error to /tmp
Date: Sat, 17 Jul 2004 23:38:24 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040717124804.GG8887@lkcl.net>
In-Reply-To: <20040717124804.GG8887@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407172338.24553.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 17 Jul 2004 22:48, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> this is with the 1.12 debian policy (with a few hacks).

1.14 has significant changes.

But the problem is with coreutils.  I plan to compile the latest coreutils 
with SE Linux support soon and hopefully that will fix it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
