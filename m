Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2A9trRb017598
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 04:55:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2A9sC6Q028179
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 09:54:12 GMT
Received: from mta06-svc.ntlworld.com (mta06-svc.ntlworld.com [62.253.162.46])
	by jazzswing.ncsc.mil  with ESMTP id i2A9sB5t028176
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 09:54:11 GMT
Received: from hotmail.com ([62.253.144.49]) by mta06-svc.ntlworld.com
          (InterMail vM.4.01.03.37 201-229-121-137-20020806) with ESMTP
          id <20040310095551.WJLH19383.mta06-svc.ntlworld.com@hotmail.com>
          for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 09:55:51 +0000
Message-ID: <404EE624.7010901@hotmail.com>
Date: Wed, 10 Mar 2004 09:55:48 +0000
From: James de Lurker <jtl2nospamMUNGIEjump@hotmail.com>
Reply-To: see.the.sig.2.reply.by.email.offlist@hotmail.com
MIME-Version: 1.0
CC: selinux@tycho.nsa.gov
Subject: Re: grsecurity / LSM issue
References: <20040308043522.GA4760@coker.com.au>
In-Reply-To: <20040308043522.GA4760@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 8 Mar 2004 15:35:22 +1100  Russell Coker wrote:

> Brad Spender of the GR Security project has claimed that my Debian SE Linux
> play machine was cracked.  A quick inspection didn't show any evidence of a
> crack [..]

Would it be possible to make a snapshot clone of the disk and make that
available to people experienced with forensics? I was thinking of the 
honeypot/net project folks and the competition to analyse a rooted system a
few years back. Some of those guys could tear into it effectively, if they 
have the time. The economics of that exercise are interesting; when one
compares the costs of building secure by default machines against simply
reloading less secure setups that become compromised ( the latter being
all too common a "standard procedure" in commercial environments ).

But first it will be necessary to verify the claim of compromise, difficult
if the perpetrator wishes to retain control over a 0day crack.


> Brad states that he will provide evidence within 24 hours, I am eagerly looking
> forward to this.

Anyone calling "time" on this? I read the claims on the grsecurity page
with interest - about LSM being used as means to stealth backdoors more
effectively on cracked machines in the future:

   http://www.grsecurity.net/lsm.php

Here are the assertions that I find interesting:

( Starts Verbatim extract from URL )

Why LSM will harm the security of all Linux systems:
  Though LSM can be disabled in the vanilla kernel to allow the system to 
work functionally as it did in 2.4, all linux distributions will most 
likely be enabling it in their kernels. The mere existence of a security 
framework is not going to urge more users to use Trusted OS components in 
their kernels.
  Because LSM is compiled and enabled in the kernel, its symbols are 
exported. Thus, every rootkit and backdoor writer will have every hook he 
ever wanted in the kernel. This will allow for a new generation of 
sophisticated backdoors and rootkits that will be nearly impossible to detect.
			
Why I personally dislike LSM
I believe LSM entered the kernel, not because of its technical merit or 
usefulness, but because of apathy from people involved in kernel 
development who are able to make a difference in such decisions.
I do not appreciate that the original intention of those backing LSM was to 
allow for the existence of proprietary security modules that used the 
kernel's GPL'd interfaces. This is no longer an issue, however I believe 
that such an intention may have affected the design of LSM greatly to allow 
for such a thing, instead of designing LSM for actual usefulness.
	
( Ends verbatim extract from http://www.grsecurity.net/lsm.php )


I like to keep an open mind even in areas where peers consider my own
competence to be high.

Adversarial processes with substance could be beneficial to both 
grsecurity's approach _and_ LSM; but it is the substance that is of 
interest here. Anything else is just PR maneuvering.

Comments from those with detailed knowledge of working with both systems
would be of considerable interest. I shall probably also have a play with
Adamantix, next month, when I can find the time to do it justice.
   http://www.trusteddebian.org/


> In any case I may put the Debian machine off-line for a while.  Most of my
> work is on Fedora now and I don't think that two play machines offers any
> significant benefit over one.

A known compromised one neutered against doing anything harmful
could also be of _considerable_ interest for educational purposes!

This begs the question: Is LSM as implemented in Russell's build being
exploited as suggested by the webpage?

-- 

   -- James

 From and Reply To are INVALID.

All public postings use munged headers[1]- To contact me off list:
   1) Remove "M U N G I E j u m p" ONLY: leave that "nospam" in there!
   2) change "hotmail" 2 "myrealbox" after the @



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
