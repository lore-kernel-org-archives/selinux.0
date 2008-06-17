Message-ID: <4857F158.8030109@manicmethod.com>
Date: Tue, 17 Jun 2008 13:16:08 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [rfc] refpolicy user based separation
References: <48528E71.3000301@manicmethod.com>	 <1213715072.2875.57.camel@moss-lions.epoch.ncsc.mil>	 <4857D67B.8050606@manicmethod.com> <1213722208.2875.97.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1213722208.2875.97.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:
> On Tue, 2008-06-17 at 11:21 -0400, Joshua Brindle wrote:
>> James Carter wrote:
>>> On Fri, 2008-06-13 at 11:12 -0400, Joshua Brindle wrote:
>>>> With the role based separation work being done an alternate idea was brought up here. Rather than going through the pain required for role based separation (kernel patches, policy format changes, incompatibility with older distros, long term refpolicy branch) we could do user based separation.
>>>>
>>>> The work done on refpolicy to merge derived types is still necessary, and much of that work has been done. It just means that rather than separating user home dirs and user processes based on the role field it will be done on the user field. We believe that no kernel patches or format changes are necessary to do this.
>>>>
>>>> Some advantages include less work, ofcourse. No incompatibility with older distros (eg., trunk refpolicy will still be usable on RHEL4/5). Some disadvantages are less flexibility, more difficult to separate roles given to the same user (TE policy with derived types would be necessary). It would be easy to use roles and users in a 1:1 mapping and force people to log out and back in to assume a new role, or to use sudo with context setting support (although that requires the selinux user identity to be non-immutable, which some have objected to)
>>>>
>>> It does seem like the user-based separation would work and be easier to
>>> implement, but it would be really nice to have the increased flexibility
>>> in policy writing that the role-based separation changes would bring.
>>> The goal of the Flask architecture is to provide policy flexibility, so
>>> these changes would help us to better meet that goal.
>>>
>>> It could be argued that if someone wants to add role-based separation
>>> later, then the support could be added then, but considering that
>>> changes are needed in both the policy toolchain and kernel, and there
>>> are only a limited number of people that could probably make the
>>> changes, it seems likely that no one would even attempt to write a
>>> policy using role-based separation unless it was already supported in
>>> the toolchain and kernel.
>>>
>>> I think that policy flexibility is important enough to pursue the
>>> role-based separation in refpolicy not only to make the mechanisms
>>> available, but also to provide an example of how to use them.
>>>
>>>> Some work would still need to be done in userspace, such as user attribute support in the module format and libsemanage, to be able to exempt separation for specific users.
>>>>
>>> I think that user attributes are a good idea regardless -- more
>>> flexibility.
>>>
>>> Wouldn't a change in module format mean incompatibilities with older
>>> distros?  They would need the newer toochain.  Or are you just talking
>>> about compatibility with older kernels?
>>>
>> The main objection to role based separation is that the kernel changes and policy changes which requires a long term reference policy branch to support the older distros. Toolchain changes are fine internally (eg., CLIP already has backported toolchain features), Dan has his own refpolicy branches for rhel4/5 so it won't matter to him.
>>
>>>> Opinions?
>>>>
>>> Flexibility is good.
>> I couldn't disagree more. Flexibility for the sake of flexibility creates insane systems that noone can/wants to use (see: xml, sendmail, emacs)
> 
> I like emacs.  Even more importantly, Steve likes emacs. ;)
> 

And I'm sure you using it for emailing, webbrowsing, and as a general purpose OS too ;)

> Sure, I agree that flexibility can be taken to an extreme, but, on the
> other hand, the Flask security architecture is about system support for
> diverse security policies, not system support for refpolicy.
> 

Note that we are not removing any kind of functionality that any other policy might want to implement, and if refpolicy is going to be the primary user of the new functionality why would we add something that is not necessary for refpolicy? I think we should be very careful with the 'lets add this just incase anyone wants it' kind of ideas, they've gotten us in trouble in the past.

>> One thing that occurred to me while talking about this is that neither 'user separation' or 'role separation' are real security goals. What are we _actually_ trying to accomplish here and which solution meets the requirements. 
> 
> I think that user separation is a real security goal.  Even normal Linux
> cares about user separation.
> 

Not really. "I want to separate users" is not a security goal. "I want to prevent low integrity users from tampering with high integrity environments" is. 

> Since roles are only defined in the security policy, they are not a
> security goal themselves, they are used as an abstraction to make it
> easier to specify security goals.  It is easier to say that the user
> Josh gets the code-monkey and karl-lackey roles, than to specify all the
> types and permissions that those roles would involve.
> 

That is fine, that is using roles for domain reachability which certainly won't be going away. It has nothing to do with separating those roles.

> It is true that the goals of refpolicy can probably be met using user
> separation, but we should provide the right mechanisms to write security
> policy.
> 

What policy? For what end? 

>> Further, does the added flexibility of role based separation outweigh the its cost?
> 
> That is a valid question.  We want the maximum amount of flexibility for
> the least amount of pain.
> 
>>  These are the questions we need to answer I think.
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
