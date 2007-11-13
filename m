Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lADJQMVv000809
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2007 14:26:22 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lADJQLKY004889
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2007 19:26:21 GMT
Subject: Re: pcscd and serial readers
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Steven Harp <steven.harp@adventiumlabs.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200711131027.14488.steven.harp@adventiumlabs.org>
References: <200711131027.14488.steven.harp@adventiumlabs.org>
Content-Type: text/plain
Date: Tue, 13 Nov 2007 14:25:52 -0500
Message-Id: <1194981952.13737.8.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-11-13 at 10:27 -0600, Steven Harp wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> The pcscd policy (daemon for smart card readers) handles USB 
> readers fine, but balks--for me--when a serial port reader is 
> configured (the daemon quietly dies).  
> 
> Module rev 1.1.0 includes a line:
>  term_dontaudit_use_unallocated_ttys(pcscd_t)
> 
> Should this perhaps be:
>  term_use_unallocated_ttys(pcscd_t)
> ?

Sounds like it.  Did the serial reader start working when you allowed
the access?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
