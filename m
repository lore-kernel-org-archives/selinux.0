Message-ID: <45AFD0A4.6020308@mentalrootkit.com>
Date: Thu, 18 Jan 2007 14:55:16 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [RFC] 0/4 - Hierarchal apache policy for reference policy
References: <45AFA08F.9080602@tresys.com>	 <45AFABC8.2050101@mentalrootkit.com> <45AFB433.1010309@tresys.com>	 <45AFBF18.3080004@mentalrootkit.com> <1169149203.22731.358.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1169149203.22731.358.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-01-18 at 13:40 -0500, Karl MacMillan wrote:
>> Joshua Brindle wrote:
>>> Karl MacMillan wrote:
>>>> Joshua Brindle wrote:

<snip>

>>>> I think the biggest hurdle to this gaining widespread use is the 
>>>> length of the meta-policy, especially since it essentially repeats the 
>>>> policy for the sub-types. Any ideas about how to shorten this policy?
>>>>
>>> nit: the meta-policy is short (5 lines). The policy itself is longer due 
>>> to the propagation of rules to children types.
>>>
>> Fine - but that answer the question. Having to define container types 
>> with a superset of the rules results in a much longer policy. I think 
>> that it is going to be hard to convince people to add that policy.
> 
> Policy build could automatically generate the rules for the container
> types from the child type rules, as long as they come from the same
> source (e.g. all part of the base policy build, or all within the same
> module).  Then you only need to explicitly state rules for the container
> types for accesses that you wish to permit to externally defined
> children.
> 

That's probably a good solution. Wouldn't be too hard to make a tool to 
do this from selgen / sepolgen / madison.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
