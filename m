Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PEC4n1014794
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 09:12:04 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m1PEC4s4000351
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 14:12:04 GMT
Subject: Re: [refpolicy] storage.if addition
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1203789432.2668.2.camel@vogon>
References: <1203789432.2668.2.camel@vogon>
Content-Type: text/plain
Date: Mon, 25 Feb 2008 09:09:33 -0500
Message-Id: <1203948573.32061.47.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-02-23 at 18:57 +0100, Stefan Schulze Frielinghaus wrote:
> There is already a read and write interface to access
> fixed_disk_device_t but I also need a read/write interface.
> 
> Attached patch should provide that.

I changed it to simply call the read and write interfaces rather than
duplicating their implementations.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
