Cc: James Carter <jwcart2@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Message-Id: <8E785FE8-8DEA-43C0-BEDE-20BA551FA9D2@nall.com>
From: Joe Nall <joe@nall.com>
To: Alexey S <selinux@udmvt.ru>
In-Reply-To: <1239367506.16752.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Policy infrastructure problems and improvement
Date: Fri, 10 Apr 2009 09:28:12 -0500
References: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil> <20090410124318.GM9889@ruber.office.udmvt.ru> <1239367506.16752.3.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Apr 10, 2009, at 7:45 AM, Stephen Smalley wrote:

> On Fri, 2009-04-10 at 17:43 +0500, Alexey S wrote:
>> On Thu, Apr 09, 2009 at 11:28:03AM -0400, James Carter wrote:
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
>>
>> May I put my 5cents?
>> It would be great if mapping of domain attributes to numbers be  
>> preserved
>> somewhere during linking/expanding of modules into binary policy.
>> And if libqpol-based tools would be able to use that mapping when  
>> displaying
>> their results.
>> Otherwise it is too confusing to see @ttr0121 instead of  
>> domain_type during policy
>> analysis, especially when numbers change after module (re|un|)load.
>
> policy.24 already makes this change (preservation of attribute names  
> in
> the types symtab in the final kernel policy).
>
> You can however already see the attribute names with policy < 24 by
> running apol and friends on the modular policy rather than the final
> kernel policy.

like this

seinfo -x -t$1 /etc/selinux/mls/modules/active/base.pp /etc/selinux/ 
mls/modules/active/modules/*pp

This can be very slow (hours) - all in the reading of the pp files.  
Replace $1 and mls as appropriate.

joe

>
>> PS: Could binary policy have 'debug' segments, that are not loaded  
>> into kernel,
>> but persist in a file?
>> PPS: Have I missed something somewhere? It is so obviously  
>> inconvenient, so
>> I don't believe it's only me requesting this thing.
>
> -- 
> Stephen Smalley
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
