Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k48EGbG6020080
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 10:16:37 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k48EGaEL008994
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 14:16:36 GMT
Subject: Re: policy for clockspeed
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Petre Rodan <kaiowas@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20060508072034.GA6138@peter.avira.local>
References: <20060508072034.GA6138@peter.avira.local>
Content-Type: text/plain
Date: Mon, 08 May 2006 10:17:08 -0400
Message-Id: <1147097828.21489.2.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-08 at 10:20 +0300, Petre Rodan wrote:
> attached you'll find a clockspeed policy.
> 
> 'clockspeed uses a hardware tick counter to compensate for a persistently fast or slow system clock. given a few time measurements from a reliable source, it computes and then eliminates the clock skew.'
> http://cr.yp.to/clockspeed.html

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
