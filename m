Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA25367
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 07:55:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA22883
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 11:53:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA22879
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 11:53:48 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
Date: Tue, 23 Apr 2002 13:55:19 +0200
References: <Pine.GSO.4.33.0204221825010.5657-100000@raven> <20020422224503.C7C6744A5A@lyta.coker.com.au> <20020423074322.C14880@lemuria.org>
In-Reply-To: <20020423074322.C14880@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020423115519.83E491916@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Apr 2002 07:43, Tom wrote:
> On Tue, Apr 23, 2002 at 12:45:03AM +0200, Russell Coker wrote:
> > /etc/lilo.conf will (on any properly configured system) contain a boot
> > password for the system, which is the best way of taking over a system
> > entirely without disassembling the hardware.  I think that this deserves
> > a different type to world-readable files such as /etc/passwd!
> >
> > I think that the situation is similar for other boot loaders.
>
> Physical access to the hardware always means you have lost (an

Ability to disassemble the machine always means you have lost.  Ability to 
access the keyboard, mouse, and (non-bootable) floppy drive should not cause 
a problem.

Think of terminals in Internet Cafe's and University computer labs.

> encrypted filesystem being the exception).

An encrypted file system is not a magic bullet.  How does the machine with 
the encrypted file system get it's unlock password?

> Moreover, a lot of properly
> configured systems do NOT have a boot password. If they are located in
> a physical secure location, then coming up again after a crash or power
> failure is more important than the off-chance that someone breaks into
> the hosting center just to reboot and take over your machine.

Hosting centers that I am familiar with do not have enough security cameras, 
and the locks on cabinet doors are easily pickable.  Someone who has 
authorised access to one company's equipment (authorisation being arranged by 
unencrypted and unsigned email over a public network) can do whatever they 
like to other machines.

But that's beside the point.  The fact that some people choose to not use a 
particular security method does not mean that I will choose to not support it.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
