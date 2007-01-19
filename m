Message-ID: <45B0F7FA.1000506@mentalrootkit.com>
Date: Fri, 19 Jan 2007 11:55:22 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [RFC] 0/4 - Hierarchal apache policy for reference policy
References: <6FE441CD9F0C0C479F2D88F959B015887B9E64@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015887B9E64@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
>>
>> Joshua Brindle wrote:
>>> If one added the same rule to another module they'd get a hierarchy 
>>> violation error, however. So the user would experience different 
>>> errors depending on how they added the rule to the policy.
>> I don't follow - I thought that the typing meant that it 
>> didn't matter where the rule came from, only what the source 
>> and destination types were. If you added additional rules via 
>> the module, the target types should have the same type as 
>> they do in the original module.
>>
> 
> What I was saying was how it would behave differently if you generated
> rules for all the parents of a child at build time within a single
> module. If you automatically did that then adding a rule to a child
> would get propagated to the parent which would result in an access
> violation at insert time. If you added the rule from another module it
> would show up as a hierarchy violation instead.

Ah - I see what you are saying. I was assuming that this would be a 
development tool manually invoked to aid policy developers. Not 
something that would always happen as part of the build.

Also, I assume that for the most part the container types will be given 
very broad privileges rather than the fine-grained approach taken with 
the apache policy. Otherwise chances are that most updates will fail 
from hierarchy violations because you forgot one small access. In other 
words, the closer the container type policy to the subtypes the less 
useful it actually is (because you would just not delegate access to 
someone else to update it).

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
