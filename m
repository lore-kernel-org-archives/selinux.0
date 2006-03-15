Message-ID: <441842C2.8070706@tresys.com>
Date: Wed, 15 Mar 2006 11:37:22 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Russell Coker <rcoker@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Problem with semodule mls policy
References: <44182410.1030003@redhat.com>	 <1142434901.29737.63.camel@moss-spartans.epoch.ncsc.mil>	 <44183A48.7010005@tresys.com> <1142440539.4933.6.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1142440539.4933.6.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-03-15 at 11:01 -0500, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Wed, 2006-03-15 at 09:26 -0500, Daniel J Walsh wrote:
>>>> How do I get semodule to create policy.20 at SystemHigh and everything 
>>>> other files at SystemLow?
>> Why do we want policy.20 at SystemHigh again? The only scenerio I can 
>> think of is the user->role mappings but who will be using those rather 
>> than seuser mappings? For that matter, seuser file should probably be at 
>> SystemHigh...
> 
> Possibly local customizations are in view here, e.g. the contents of
> interfaces.local, that are then fed into the final policy.20 emitted by
> libsemanage?  seusers is the more likely concern, as you note, and it is
> harder to transparently label it separately since it doesn't live in its
> own dedicated subdirectory (so range_transition wouldn't help with it;
> you'd need libsemanage code modification).
>  
The entire module store (/etc/selinux/<type>/modules/*) should be 
entirely inaccessible except by an semanage_t domain (and policy server 
later) via type enforcement, so those shouldn't be a concern. The 
policy.20 shouldn't really contain any sensitive information so I think 
the only necessary modification is to label seusers differently, correct?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
