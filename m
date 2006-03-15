Message-ID: <44185659.3050403@tresys.com>
Date: Wed, 15 Mar 2006 13:00:57 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Russell Coker <rcoker@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Problem with semodule mls policy
References: <44182410.1030003@redhat.com>	 <1142434901.29737.63.camel@moss-spartans.epoch.ncsc.mil>	 <44183A48.7010005@tresys.com>	 <1142440539.4933.6.camel@moss-spartans.epoch.ncsc.mil>	 <441842C2.8070706@tresys.com> <1142441886.4933.13.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1142441886.4933.13.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-03-15 at 11:37 -0500, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> Possibly local customizations are in view here, e.g. the contents of
>>> interfaces.local, that are then fed into the final policy.20 emitted by
>>> libsemanage?  seusers is the more likely concern, as you note, and it is
>>> harder to transparently label it separately since it doesn't live in its
>>> own dedicated subdirectory (so range_transition wouldn't help with it;
>>> you'd need libsemanage code modification).
>>>  
>> The entire module store (/etc/selinux/<type>/modules/*) should be 
>> entirely inaccessible except by an semanage_t domain (and policy server 
>> later) via type enforcement, so those shouldn't be a concern. The 
>> policy.20 shouldn't really contain any sensitive information so I think 
>> the only necessary modification is to label seusers differently, correct?
> 
> I wasn't sure whether the fact that e.g. netif eth0 is assigned
> SystemHigh and netif eth1 is assigned SystemLow in interfaces.local
> (which is then compiled into policy.20) might be considered sensitive.
> If so, that would make the final policy.20 sensitive as well.
> 

I can buy this, as well as nodecons having different levels. The strange 
thing is that you don't know what the levels are exactly, you just know 
their relationships to each other. ie: eth0 is s1 and eth1 is s5 so eth1 
is higher sensitivity even though I don't know what that sensitivity 
means. How big of an issue is this? Chad?

writing down files of different levels from within libsemanage means any 
libsemanage client must be mls trusted, which may or may not be an 
issue, I'm not sure.

So, if this is an issue then both seusers and policy.20 need to be 
labeled differently.. should this be done through libsemanage config or 
some appconfig in the policy?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
