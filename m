Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA25524
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 08:20:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA20786
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 12:19:27 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id MAA20782 for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 12:19:26 GMT
Date: Tue, 23 Apr 2002 14:20:51 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
Message-ID: <20020423142051.A24878@lemuria.org>
References: <Pine.GSO.4.33.0204221825010.5657-100000@raven> <20020422224503.C7C6744A5A@lyta.coker.com.au> <20020423074322.C14880@lemuria.org> <20020423115519.83E491916@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020423115519.83E491916@lyta.coker.com.au>; from russell@coker.com.au on Tue, Apr 23, 2002 at 01:55:19PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Apr 23, 2002 at 01:55:19PM +0200, Russell Coker wrote:
> > Physical access to the hardware always means you have lost (an
> 
> Ability to disassemble the machine always means you have lost.  Ability to 
> access the keyboard, mouse, and (non-bootable) floppy drive should not cause 
> a problem.
> 
> Think of terminals in Internet Cafe's and University computer labs.

But how does a boot-password offer any protection in these settings?


> > encrypted filesystem being the exception).
> 
> An encrypted file system is not a magic bullet.  How does the machine with 
> the encrypted file system get it's unlock password?

The same way that it gets the boot password. :)


> Hosting centers that I am familiar with do not have enough security cameras, 
> and the locks on cabinet doors are easily pickable.  Someone who has 
> authorised access to one company's equipment (authorisation being arranged by 
> unencrypted and unsigned email over a public network) can do whatever they 
> like to other machines.

No security-aware hosting center will let run people around
unsupervised unless every customer has a steel-cage of his own.


> But that's beside the point.  The fact that some people choose to not use a 
> particular security method does not mean that I will choose to not support 
> it.

I agree. The point was that lilo.conf may or may not be especially
sensitive, depending on the setup. It may be, but similiar points may
be made for many other files (/etc/ppp/*.secrets, snmp config files,
quite a lot of things actually).

See my other posting - where the "line of authority" runs is a specific
question. On some systems, root=god will still (largely) be true with
SELinux installed, on other systems even two of the three admins may
not be authorized to access lilo.conf.

Difficult to generalize.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
