Message-ID: <45AFE58A.3090106@mentalrootkit.com>
Date: Thu, 18 Jan 2007 16:24:26 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [RFC] 0/4 - Hierarchal apache policy for reference policy
References: <6FE441CD9F0C0C479F2D88F959B015887B9E60@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015887B9E60@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
>>
>> On Thu, 2007-01-18 at 15:00 -0500, Joshua Brindle wrote:

<snip>

>>> The proposed solution gives the opposite effect, it builds 
>> container 
>>> types from children so the children must meet the 
>> requirements of the 
>>> parent types without knowing them.
>> No, notice that I only said that one would automatically 
>> propagate accesses from the children to the parent if they 
>> come from the same source (base policy build or within the 
>> same module).  You wouldn't automatically propagate beyond 
>> that scope, so if a type in a module is a child of a parent 
>> type in the base (or any other previously added module), it 
>> would still be constrained to whatever was explicitly 
>> specified by the base (or other module) on the parent type.  
>> It merely avoids the need to duplicate specification within 
>> the base policy or within a single module when both the 
>> parent and the child types are defined within that base or module.
>>
> 
> This implies that policy won't be added by updating pre-existing modules
> to add access and would only be added via extra modules. 
> 
> So the result would be that someone adding permissions to a child type
> in a pre-existing module would be an insertion failure because they
> weren't allowed to add permissions to the parent rather than a hierarchy
> violation error.
> 
> If one added the same rule to another module they'd get a hierarchy
> violation error, however. So the user would experience different errors
> depending on how they added the rule to the policy.

I don't follow - I thought that the typing meant that it didn't matter 
where the rule came from, only what the source and destination types 
were. If you added additional rules via the module, the target types 
should have the same type as they do in the original module.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
