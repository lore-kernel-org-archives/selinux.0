Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SeLinux@tycho.nsa.gov
Subject: Re: Java intragration
Date: Thu, 28 Mar 2002 14:54:13 +0100
References: <20020328062854.11444.qmail@web14608.mail.yahoo.com> <20020328092119.A17199@lemuria.org>
In-Reply-To: <20020328092119.A17199@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020328135414.3C93F2799D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Mar 2002 09:21, Tom wrote:
> On Wed, Mar 27, 2002 at 10:28:54PM -0800, R2-Q2 wrote:
> > Would it be a good idea to intragrate Java into the operating system.
> > Possibally it could be faster if it was. Java is known to be secure and
> > there are many open source vm's out there. Or we just could install it
> > into the OS using SUN's or IBM's version. Though probally SUN because
> > they have the latest version.
>
> I'd be careful with "known to be secure". AFAIK there's *one* computer
> system on this planet that is known to be secure. For everything else,
> we assume.

What is this one computer?

I believe that the Z80 based computer I assembled when I was 11 was secure.  
Input through a hex keypad, output on 7 segment displays (no tempest), and 
stored safely under my bed.  ;)

But presumably you have different criteria as to what makes a machine "known 
to be secure".

Regarding Java security, I'd trust SE Linux security over Java security any 
day (I'd even trust the usual Unix DAC more than Java security).

> As to integration - it already is. Select "misc" in Linux' binary file
> format support option during kernel configuration, and you can run java
> files just like ELF executables. How much more integration do you want?
> The VM as part of the kernel? I may be 80ish, but that kind of bloat
> gives me physical pain.

There have been technology demonstrations of OSs written entirely in Java.  
Never been released though AFAIK.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
