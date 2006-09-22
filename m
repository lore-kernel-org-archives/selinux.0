Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8ML7wH7002414
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 17:07:58 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8ML6uEW011138
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 21:06:58 GMT
Message-ID: <451450A8.2030109@hp.com>
Date: Fri, 22 Sep 2006 17:07:52 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: Labeled networking packets
References: <36282A1733C57546BE392885C061859201573525@chaos.tcs.tcs-sec.com> <451421C6.5050003@hp.com> <Pine.LNX.4.64.0609221640590.10058@d.namei>
In-Reply-To: <Pine.LNX.4.64.0609221640590.10058@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Fri, 22 Sep 2006, Paul Moore wrote:
>>Venkat Yekkirala wrote:
>>
>>>OK, here's what we will do:
>>>
>>>1. We will have getpeercon() fail if there's no labeled-SA.
>>
>>... or NetLabel :)  What do you propose we do if there is both a SA and
>>NetLabel label, bearing in mind that NetLabel may be a full context?
> 
> I don't think we should have both of these possible for the same packet.  
> It's too complicated. 

That makes sense, what should we do in the case that we receive a packet
 on a labeled SA with a CIPSO option - drop it and send an ICMP error?
That seems like the logical solution, but I'm not sure that is one that
everyone will like.

> Remember: CIPSO is just a legacy technology which is useful for talking to 
> existing CIPSO systems.  We should not be making the rest of the code jump 
> through hoops to accomodate things it was never intended for, such as 
> integrated IPsec protection.
>
> The preferred & recommended means to implement labeled networking is via 
> the new xfrm labeling.  If you want to talk to legacy CIPSO systems the 
> way they already talk to each other, fine, but don't expect anything more 
> than that.

I stil think there may be some advantages to decoupling the labeling
from IPsec/XFRM, but following this idea right now starts getting away
from the current subject which I don't is right.  Also, since NetLabel
carrying more than a MLS label is all conjecture at this point I don't
think it's worth discussing any more than what has already been said.

The point I have been trying to make with all of this is that I think we
can find a solution where it doesn't matter if it is a full context or a
MLS-only context.  However, if we can't accomplish that, then we need to
find something that at least allows the different systems to exist on
the same machine, not necessarily the same connection.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
