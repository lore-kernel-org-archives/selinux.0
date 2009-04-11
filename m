Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3B2kUn3009017
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 22:46:30 -0400
Received: from smtp104.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n3B2kSPe029259
	for <selinux@tycho.nsa.gov>; Sat, 11 Apr 2009 02:46:29 GMT
Message-ID: <49E00466.4090702@schaufler-ca.com>
Date: Fri, 10 Apr 2009 19:45:58 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Policy infrastructure problems and improvement
References: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil>	 <49DEC8D0.2060105@schaufler-ca.com> <1239366882.27413.24.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1239366882.27413.24.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:
> On Thu, 2009-04-09 at 21:19 -0700, Casey Schaufler wrote:
>   
>> James Carter wrote:
>>     
>>> I am looking at improving the policy infrastructure.  The ultimate goal
>>> is to make SELinux policy writing, policy customization, policy
>>> management, and administration easier and less confusing. My focus will
>>> be on the userspace parts of SELinux. 
>>>
>>> My plan to do this is as follows:
>>> (1) Determine and enumerate the existing problems of the current
>>> infrastructure.
>>> (2) Determine the desired capabilities and architecture of the ideal
>>> infrastructure.
>>> (3) Determine the changes needed to the current architecture to fix the
>>> current problems and to provide the desired capabilities.
>>> (4) Make the policy infrastructure as close to the ideal as possible
>>> while providing some kind of backwards compatibility and taking other
>>> practicalities into consideration.
>>>
>>> I have had some informal discussions with others internally and at
>>> Tresys, and the five emails to follow have my summary of the problems
>>> that have been identified in those discussions.
>>>
>>> My hope is that there will be a good discussion and that others on the
>>> list will identify other problems and provide more details or examples
>>> to the problems already identified.
>>>   
>>>       
>> I will throw my traditional comment on the pile as I didn't see that
>> you had it on your list anywhere. The policy required to describe a
>> system is too large.
>>
>>     
>
> That's easy to fix.  Make the system smaller. ;)
>   

Or kick off all those stoopid users, if that's easier (smiley here).

> I think that this would fit under complexity of SElinux policies.
>   

Perhaps.

> Again, better layering is needed.  

Here I disagree. Obscuring the size behind layers or modularity
does not actually make it smaller.

> It would be nice if I could just
> write policy for the particular domains and resources that I cared about
> without having to worry about the policy for the rest of the system.
>   

The fact that you are willing to accept the behavior of "policy you
don't care about" also does not make the policy smaller.


> Unfortunately, policy writing differs from program writing in that while
> different programs that run on a system *share* resources and so it
> doesn't matter what the other programs do (for the most part) as long as
> my program gets to use those resources at some point, all of the
> policies work together to *control* resources.  In the end, you must
> have one policy.  

Yes. Interdependencies. That is why, in this context, size matters.

> The question is how to write the policies in a more
> layered way and have the policy infrastructure merge the layers
> together.  
>   

Ignoring the bulk of the policy and attending to a part of the policy
also does not make the rest of the policy go away. Because the SELinux
implementation is so granular you can't layer without losing value.

But that could just be me. It may be time for a grain of salt.

Thank you.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
