Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h42G2HI4017314
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 12:02:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h42G26Vf015573
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 16:02:06 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
	by jazzswing.ncsc.mil  with ESMTP id h42G254D015570
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 16:02:05 GMT
Date: Fri, 2 May 2003 12:02:09 -0400
From: forrest whitcher <fw@fwsystems.com>
To: "Petty, Clint E" <clint.e.petty@lmco.com>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: Trusted Operating System?
Message-Id: <20030502120209.688e3b7a.fw@fwsystems.com>
In-Reply-To: <AED99F3E5CF6C749B320E3B51B0D14B217B52F@EMSS01M10.us.lmco.com>
References: <AED99F3E5CF6C749B320E3B51B0D14B217B52F@EMSS01M10.us.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Clint,

As I've read NSA's intent and statements, SELinux (and the Flask 
implementation that's been ported to TrustedBSD) is an R&D project
intended to demonstrate how to build assurance that is wired into
a low-level of the operating system, with an efficient implementation
and with policy implementation which is reasonably understandable 
and flexible.

For instance (Please don't rely on this statement) as near as I 
have been able to determine, the lsm/SEL kernel prevents the recent
ptrace local-root exploit from gaining privilege. 

If one objective of a 'Trusted' OS is that the user gains some 
breathing space in terms of choosing when to apply security patches
then SEL and other linux/BSD security implementations are making
significant strides. E.g. the Ptrace patch has some functionality 
issues and has been reported to cause stability problems (which I 
can vouch for).

All other linux implementations I've seen can potentially be subverted
by an attacker who might be able to run code below the level of the
policy implementation.

As others have indicated, It's not an evaluated system. Thus it may
never be something you can use in classified work at Lockheed/Martin.

On the other hand, most of the 'Trusted' systems I've been exposed 
to (including systems evaluated at the "B" MLS level) are indeed
providing excellent protection of data, however might be fully
compromised by a stack-smash of a priveleged process.

While it's true that at least some of the unixes on which evaluated
systems are based are known to always report segfaults, so at least
you'd know that something had happened, from the respect of the
integrity of the operating system itself to my knowlege SEL is 
the best game in town at this time for the objective of attaining
a level of trust in the OS and userspace policy enforcement.


Forrest


On Thu, 01 May 2003 11:30:56 -0700 
"Petty, Clint E" <clint.e.petty@lmco.com> did inscribe thusly:

> When do you anticipate you will have made SELinux a Trusted Operating
> System?  Any forcasts?
> Thanks,
> Clint
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
