Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA10944
	for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2001 06:48:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA10578
	for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2001 11:48:18 GMT
Received: from ecstasy.ksu.ru (ecstasy.ksu.ru [193.232.252.41])
	by jazzswing.ncsc.mil  with ESMTP id LAA10574
	for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2001 11:48:16 GMT
Message-ID: <3AAF579E.8070306@ksu.ru>
Date: Wed, 14 Mar 2001 14:35:58 +0300
From: Pedro Rosa <Pedro.Rosa@ksu.ru>
MIME-Version: 1.0
CC: Chris <smithchr@mindspring.com>, securedistros@nl.linux.org,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: Is this mail list dead?
References: <Pine.LNX.4.32.0103121443130.16938-100000@arwin.microunity.com> <3AAD5908.73A44E4C@wirex.com> <20010312154024.J13139@ultraviolet.org> <3AADA219.2C4BC605@mindspring.com> <3AAE0C68.1030404@ksu.ru> <3AAE7BC5.50DA0CB@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Casey Schaufler wrote:

> Pedro Rosa wrote:
> 
>> I would say that securing Linux in a distro structure would be the same
>> as forcing C2 to every Windows install.... Yeah try to use such an
>> install...
> 
> 
> Every commercial OS today has a C2 option. The lack
> of a C2 version of Linux has been a serious inhibitor
> to adoption in the marketplace. I would guess you're
> refering to the first NT evaluation, which supported
> no networking and no removable media. Building a C2
> (CAPP in Common Criteria jargon) Linux distribution
> is easier than getting corporate marketing types to
> see the value. Say, I bet I know what You do!
>  


Well, first you may know that NT does not have C2 implemented from 
start. However its implementation is not an easy thing and it enters in 
conflict with many third-party programs. Even such things like Internet 
Explorer or MS Office cannot live under a C2 environment. However you 
may try a good effort to implement a middle solution, depending on your 
user's requirements and an evaluation of all security issues that come 
from easing the rules of the game.

You are right about the fact that Linux does not have a C2 
implementation. However is this thing needed? Frankly I had a moment 
where I needed a hard secured NT with C2 enforced to the maximum 
possible. Due to stability issues and a few serious security holes in 
the system, I had to drop out the project. Later, I  took Linux for a 
try in the same task. By taking the same requirements, I managed to 
produce a box quite near to the one I tried with NT. I should say I 
didn't follow C2 in this case, I just went for what was required to be 
secured and created a solution to manage it. Interesting to note that 
for nearly 1,5 year there was no break  in. This is not fully a virtue 
of the security implemented in the system (well the thing is quite 
weaker than C2) but it does not allow a break in in the first try.  

The lack of C2 on Linux sounds like a serious drawback. But how many 
commercial organisations do implement this thing? I wonder that even 
those who do really need it, barely realise that they have to seriously 
configure Windows for such task...

Anyway, I would defend the existence of C2. And I do think that things 
similar to C2 should be implemented on Linux (yes, it will be very hard 
to do this). But not as to give Linux a slogan "It's C2 certified!" but 
to answer particular requirements of users that do really need such 
stuff. Not everyone needs such certifications. and note that their 
implementation carries costs. Costs may be on performance (very high 
ones), flexibility and even stability. This last one may even turn a C2 
implementation into 0 as it was my case... A few system files broke 
after a crash, and the whole thing was completly accessible to anyone 
who just pressed "Enter" in the login.

Ektanoor


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
