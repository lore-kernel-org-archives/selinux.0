Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8QCc4Nk029487
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 08:38:04 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8QCc28B024495
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 12:38:02 GMT
Subject: Re: turning on optional_policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD49A291@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD49A291@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Wed, 26 Sep 2007 12:36:10 +0000
Message-Id: <1190810170.1812.9.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-25 at 22:00 -0700, Clarkson, Mike R (US SSA) wrote:
> This statement is located in domain.te, allowing all domains to
> translate contexts using the mcstrans service. 
> 
> optional_policy(`
> 	setrans_translate_context(domain)
> ')
> 
> How do I turn on optional_policy to make this statement take effect?

You would need to load the setrans module.

> Also, when I turn this on, what other side effects will I be getting?

It allows all domains to translate MLS/MCS levels, and thats it.
Interfaces shouldn't have side effects.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
