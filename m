Message-ID: <454B8E1F.5050304@tresys.com>
Date: Fri, 03 Nov 2006 13:44:47 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: vyekkirala@TrustedCS.com
CC: Paul Moore <paul.moore@hp.com>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com
Subject: Re: SELinux Networking Enhancements
References: <001a01c6ff5a$7eb99970$cc0a010a@tcssec.com>
In-Reply-To: <001a01c6ff5a$7eb99970$cc0a010a@tcssec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>>
>> So you just pass an additional parameter to the selinux
>> module? I assume
>> you aren't going to try to use TE policy to choose.
> 
> Can you reframe your original question? I am afraid I misunderstood
> it when I answered.
> 

How do you tell it to drop on one peer label but reject another?

>> <snip>
>>>> With these
>>>> filter rules if
>>>> they aren't in place the policy becomes less restrictive
>> (right?)..
>>> We could also be restrictive or leave it up to the policy entirely.
>>>
>> So if there is no rule present it would always check against unlabeled
>> (or some initial SID)?
> 
> Yes. I think this would be the simpler approach for now.
> 
>> Can you force the selinux module to be called
>> under all circumstances?
> 
> Yes, in the proposal we are looking at here, the module will be called
> from within netfilter when there are explicit secfilter rules as well as
> when none have been found in which case there would be a check against
> unlabeled. Is this what you meant to ask?
> 

Right, would the module always be 'on', even if iptables has an accept 
policy.

>> This is starting to sound pretty reasonable. The filter rules
>> really are
>> policy
> 
> They are a really a labeling policy just like in the secmark case.
> Here we would label the filter points as opposed to packets.
> 

Maybe, if the unlabeled check is really there then it is labeling, if it 
  isn't then you are using filter rules to set up an external policy.

>> they just aren't TE policy, and they are also tightly
>> bound to a
>> particular TE policy.
> 
> If you meant the "particular" portion of the policy that would
> have the allow rules, etc., to enforce secfilter, yes.
> 

mostly types..

>> This is different from other object managers because their "policy" is
>> static, they always ask the question at some point in the codepath
>> wheras you want to implement a dynamic policy to query the security
>> server.
> 
> I am not sure I understand. This is completely analogous to how the
> filesystem
> checks work. Just like how file contexts live on the File System, secfilter
> contexts live (just like secmark labels) in the netfilter subsystem
> efficiently
> looked up by the iptables framework. Just like how the various portions of
> the
> FS code call into LSM, so would netfilter/secfilter.
> 

Same as above.. if the unlabeled check is done then fine, otherwise you 
are using iptables as an enforcer with a dynamic policy (eg., its only 
checked if there is an iptables rule present instead of every single 
time in a static code path like the filesystem).

>> I don't think there is anything wrong with it but the
>> ramifications need to be examined, synchronicity is probably
>> going to be
>> the hardest thing to solve.
> 
> Could you please eleborate on the synchronicity issues and how these are
> absent/resolved for the FS case?
> 

Mainly applying the rules at the same time as a policy update and 
keeping them synchronized. It is easier for files because you merely 
overwrite the label there, with iptables there are ordering issues so 
you have to apply them in the right order, including any rules that are 
already there. If any module has a rule that shadows another there are 
problems, you'll never know which gets put in the chain first, etc.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
