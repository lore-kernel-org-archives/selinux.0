Date: Thu, 28 Mar 2002 09:21:19 +0100
From: Tom <tom@lemuria.org>
To: SeLinux@tycho.nsa.gov
Subject: Re: Java intragration
Message-ID: <20020328092119.A17199@lemuria.org>
References: <20020328062854.11444.qmail@web14608.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020328062854.11444.qmail@web14608.mail.yahoo.com>; from r2q2@rocketmail.com on Wed, Mar 27, 2002 at 10:28:54PM -0800
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 27, 2002 at 10:28:54PM -0800, R2-Q2 wrote:
> Would it be a good idea to intragrate Java into the operating system.
> Possibally it could be faster if it was. Java is known to be secure and
> there are many open source vm's out there. Or we just could install it
> into the OS using SUN's or IBM's version. Though probally SUN because
> they have the latest version.

I'd be careful with "known to be secure". AFAIK there's *one* computer
system on this planet that is known to be secure. For everything else,
we assume.

As to integration - it already is. Select "misc" in Linux' binary file
format support option during kernel configuration, and you can run java
files just like ELF executables. How much more integration do you want?
The VM as part of the kernel? I may be 80ish, but that kind of bloat
gives me physical pain.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
