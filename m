Cc: Casey Schaufler <casey@schaufler-ca.com>, SELinux <selinux@tycho.nsa.gov>
Message-Id: <E92B8263-9FF8-4AD8-83C9-97113864D8E2@nall.com>
From: Joe Nall <joe@nall.com>
To: jwcart2@tycho.nsa.gov
In-Reply-To: <1239366882.27413.24.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Policy infrastructure problems and improvement
Date: Fri, 10 Apr 2009 09:51:46 -0500
References: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil> <49DEC8D0.2060105@schaufler-ca.com> <1239366882.27413.24.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Apr 10, 2009, at 7:34 AM, James Carter wrote:

> On Thu, 2009-04-09 at 21:19 -0700, Casey Schaufler wrote:
>> James Carter wrote:
>>> I am looking at improving the policy infrastructure.  The ultimate  
>>> goal
>>> is to make SELinux policy writing, policy customization, policy
>>> management, and administration easier and less confusing. My focus  
>>> will
>>> be on the userspace parts of SELinux.
>>>
>>> My plan to do this is as follows:
>>> (1) Determine and enumerate the existing problems of the current
>>> infrastructure.
>>> (2) Determine the desired capabilities and architecture of the ideal
>>> infrastructure.
>>> (3) Determine the changes needed to the current architecture to  
>>> fix the
>>> current problems and to provide the desired capabilities.
>>> (4) Make the policy infrastructure as close to the ideal as possible
>>> while providing some kind of backwards compatibility and taking  
>>> other
>>> practicalities into consideration.
>>>
>>> I have had some informal discussions with others internally and at
>>> Tresys, and the five emails to follow have my summary of the  
>>> problems
>>> that have been identified in those discussions.
>>>
>>> My hope is that there will be a good discussion and that others on  
>>> the
>>> list will identify other problems and provide more details or  
>>> examples
>>> to the problems already identified.
>>>
>>
>> I will throw my traditional comment on the pile as I didn't see that
>> you had it on your list anywhere. The policy required to describe a
>> system is too large.
>>
>
> That's easy to fix.  Make the system smaller. ;)
>
> I think that this would fit under complexity of SElinux policies.
>
> Again, better layering is needed.  It would be nice if I could just
> write policy for the particular domains and resources that I cared  
> about
> without having to worry about the policy for the rest of the system.
> Unfortunately, policy writing differs from program writing in that  
> while
> different programs that run on a system *share* resources and so it
> doesn't matter what the other programs do (for the most part) as  
> long as
> my program gets to use those resources at some point, all of the
> policies work together to *control* resources.  In the end, you must
> have one policy.  The question is how to write the policies in a more
> layered way and have the policy infrastructure merge the layers
> together.

audit2allow needs to understand your layers of abstraction or they  
won't be very useful. I've watched a number of developers in our group  
stall at the audit2allow policy writing level and never really get the  
need to understand the system macros and the 'why' of it all.

Some of these same developers never get that some avcs are inevitable  
and blithely grant privilege until they don't have any avcs - granting  
user_t enormous new privs along the way. We use seinfo to look for  
attribute diffs and source inspection, but we need better command line  
tools to look for these issues in an automated way.

If Chris and Dan maintained and distributed policy as modules and not  
as monolithic entities, the impetus and understanding to improve the  
tool chain would be much stronger.

joe


>
>> Thank you.
>>
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing  
>> list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>>  with
>> the words "unsubscribe selinux" without quotes as the message.
> -- 
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing  
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>  with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
