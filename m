Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MGKJO8025020
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 12:20:19 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MGJHEW019404
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 16:19:19 GMT
Message-ID: <45140D34.2020001@hp.com>
Date: Fri, 22 Sep 2006 12:20:04 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: Labeled networking packets
References: <36282A1733C57546BE392885C061859201573500@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859201573500@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>>It IS FOR LABELING as far as MLS is concerned.
>>
>>Perhaps we are just overloading the term "labeling".  It kinda sounds
>>like the non-MLS folks want to be able to distinguish between "remote
>>labeling", i.e. SA or NetLabel, and "local labeling", i.e. secmark.  I
>>realize that there are certain users who don't care to make that
>>distinction because they can put a certain level of trust in the
>>physical network configuration.  However, considering the 
>>flexibility of
>>SELinux in general I think any built-in assumption is going to upset
>>someone.  I think the best idea is to arrive at some sort of policy
>>abstraction which would allow either of the behaviors listed above.
> 
> This we have attempted to do via transitions.

Yep, I got that, I think everybody got that.  However, I think this
discussion has demonstrated that not everyone believes the transitions
as they are implemented in the current secid reconciliation patches is
the right approach.  Maybe it's an issue of not understanding, maybe I'm
just confused ... (maybe I need to stop responding to email and do some
some real work <g>).

Personally, I don't have any strong feelings for any particular
implementation.  My main concern is that we arrive at a solution that
works for both the generic SELinux TE users as well as the legacy MLS users.

>>For handling incoming packets this may mean that we keep all of the
>>packet labeling mechanisms separate, allowing each to have it's own
>>permission check.
> 
> But how would you then make sure a secret cipso didn't arrive thru a
> TopSecret SA?

First, I think this is what I would call a "smack the user" problem.
However, if somebody really wanted to use both SA and NetLabel labeling
on the same connection I think the important thing is that we control
the flow of data to the socket, not the SA, as the socket is the
endpoint of the communcation channel from a users point of view.  With
this in mind, having access checks against the SA/socket and the
NetLabel/socket would ensure that the user doesn't receive any data they
shouldn't - even if the remote labels don't reconcile with each other.

>>For dealing with getpeercon() issues perhaps we only allow "remote
>>labeled" contexts to be reported by default, but if policy 
>>allows (yes,
>>we would need some sort of new allow rule or policy construct) the
>>"locally labeled" context could be used as a fallback.
>>
>>I know it's not ideal for any one scenario, but I think it may be
>>flexibile enough to deal with all of them.
> 
> That would mean you would have separate policies.

What's wrong with that?  We have that already and I suspect we will for
the foreseeable future.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
