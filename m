Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IDpdRb001454
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:51:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IDpbAR020431
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:51:37 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4IDpVHn020340 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:51:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: [latest cvs]: build error on printer_device_t not recognised
Date: Tue, 18 May 2004 23:50:20 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040518094837.GA24333@lkcl.net>
In-Reply-To: <20040518094837.GA24333@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405182350.20921.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 May 2004 19:48, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> 	allow cupsd_t printer_device_t:chr_file { ioctl read getattr lock write
> 	append };
> 	/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
>
> i find the printer_device_t definition to be in
> domains/program/unused/lpd.te
>
> is this error something to do with me having cups installed but not
> lpd?

Yes.  cups.te depends on lpd.te, see the Depends line in cups.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
