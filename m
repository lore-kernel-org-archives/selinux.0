Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49FxLNu019639
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 11:59:22 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49FxLa2006877
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 15:59:21 GMT
Message-ID: <4460BC57.5020608@hp.com>
Date: Tue, 09 May 2006 11:59:19 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Brian Sniffen <bsniffen@mitre.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: Network access controls (resolving xfrm, secmark, and NetLabel)
References: <445B7CEC.1020106@hp.com> <m24pzz6zb1.fsf@raven-king.mitre.org>	<4460B0CD.30500@hp.com> <m2zmhr5i6o.fsf@raven-king.mitre.org>
In-Reply-To: <m2zmhr5i6o.fsf@raven-king.mitre.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Brian Sniffen wrote:
> Paul Moore <paul.moore@hp.com> writes:
>>If we could do everything in netfilter then I agree with you
>>completely. 
> 
> Agree with me?  I didn't think I was making a point yet.

Then perhaps I simply read too much into your mail, although I suspect it 
doesn't matter too much for the discussion at hand.

> I'm just curious how many degrees of freedom NetLabel has, and what costs will
> be borne elsewhere in the system.  From this sort of answer, should I
> assume that the costs will be high---but necessary for CIPSO and
> similar complexities?

I'm assuming when you say "cost" you are talking about the amount of time and 
effort needed to understand the implementation so that a certain level of 
assurance can be reached?  If that is the case, then yes, I believe there is a 
relatively higher cost involved with something like CIPSO due to it's very 
nature.  To some extent NetLabel may inherit some of this cost as a framework 
designed to handle more complex labeling mechanisms.

As for the cost itself, I can only speak in relative terms and only from a 
developer's point of view.  Based on your email address and your presentations I 
suspect you have quite a bit of background in this area; I encourage you to not 
assume to much from my answers here but to look at the patch itself.  Any 
comments you may have about how to increase the ease at which higher levels of 
assurance might be achieved would be very welcome.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
