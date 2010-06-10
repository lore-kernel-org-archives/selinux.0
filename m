Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5AHwqhs021280
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 13:58:52 -0400
Received: from house.lunarmania.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5AHw44I006711
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 17:58:04 GMT
Message-ID: <4C1127D1.3030801@rubix.com>
Date: Fri, 11 Jun 2010 01:58:41 +0800
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: mcs_systemhigh use
References: <4C10AD2B.9080802@rubix.com>	 <1276168170.809.219.camel@gorn.columbia.tresys.com>	 <4C10C88A.90501@rubix.com>	 <1276168883.809.223.camel@gorn.columbia.tresys.com>	 <4C11175B.7010000@rubix.com> <1276192237.809.229.camel@gorn.columbia.tresys.com>
In-Reply-To: <1276192237.809.229.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On 6/11/2010 1:50 AM, Christopher J. PeBenito wrote:
> On Fri, 2010-06-11 at 00:48 +0800, Andy Warner wrote:
>    
>> On 6/10/2010 7:21 PM, Christopher J. PeBenito wrote:
>>      
>>> On Thu, 2010-06-10 at 19:12 +0800, Andy Warner wrote:
>>>
>>>        
>>>> On 6/10/2010 7:09 PM, Christopher J. PeBenito wrote:
>>>>
>>>>          
>>>>> On Thu, 2010-06-10 at 17:15 +0800, Andy Warner wrote:
>>>>>
>>>>>
>>>>>            
>>>>>> In the policy for the Trusted RUBIX DBMS, we assign file contexts
>>>>>> using the following (only one representative dir, 'backups', shown):
>>>>>>
>>>>>> ifdef(`enable_mls',`
>>>>>> /var/lib/RUBIXdbms/backups(/.*)?
>>>>>> gen_context(system_u:object_r:rubix_backup_t,mls_systemhigh)
>>>>>> ')
>>>>>> ifdef(`enable_mcs',`
>>>>>> /var/lib/RUBIXdbms/backups(/.*)?
>>>>>> gen_context(system_u:object_r:rubix_backup_t,mcs_systemhigh)
>>>>>> ')
>>>>>>
>>>>>> When using the mls policy, I get the expected level of mls_systemhigh
>>>>>> (s15:c0.c1023). But when using the targeted policy, I get an
>>>>>> unexpected value for mcs_systemhigh. I would expect to get
>>>>>> s0:c0.c1023, but get s0. I have verified this behavior on Fedora 9 and
>>>>>> 12. Is my assumption wrong about what mcs_systemhigh should be or am I
>>>>>> missing something?
>>>>>>
>>>>>> Relevant output from 'semanage fcontext -l'
>>>>>> /var/lib/RUBIXdbms/backups(/.*)?                   all files
>>>>>> system_u:object_r:rubix_backup_t:s0
>>>>>>
>>>>>>
>>>>>>              
>>>>> Actually, you shouldn't need any of those ifdefs.  The gen_context()
>>>>> macro is sensitive to if MLS or MCS is enabled.  The first parameter is
>>>>> the first three fields of the context.  The second parameter is the MLS
>>>>> label, and there is a third optional parameter to specify the MCS
>>>>> categories for the file (there are no examples in refpolicy).  So this
>>>>> is sufficient:
>>>>>
>>>>> /var/lib/RUBIXdbms/backups(/.*)?     gen_context(system_u:object_r:rubix_backup_t,mls_systemhigh,mcs_allcats)
>>>>>
>>>>> The thing to note is that gen_context() abstracts away the sensitivity
>>>>> (s0) portion of the label, so there is an mcs_allcats macro.
>>>>>
>>>>>
>>>>>            
>>>> Thanks for the reply. So, then is the mcs_systemhigh basically meaningless?
>>>>
>>>>          
>>> Its useful for range transitions, eg:
>>>
>>> range_transition foo_t bar_t s0-mcs_systemhigh;
>>>
>>>        
>> In this case, whill mcs_systemhigh evaluate to s0 or s0:c0.c1023?
>>      
> The latter.
>
>    
>> We use the following to allow a transition to system high, expecting for
>> mcs that to be s0:c0.c1023. Should we expect that behavior or should we
>> use mcs_allcats here as well?
>>
>> ifdef(`enable_mls',`
>>       range_transition $1 $2:process mls_systemhigh;
>> ')
>> ifdef(`enable_mcs',`
>>       range_transition $1 $2:process mcs_systemhigh;
>> ')
>>      
> These are valid.
>
>    
>>> Perhaps we should consider changing the gen_context() macro to accept
>>> mcs_systemhigh instead of mcs_allcats, for consistency.
>>>
>>>        
>> At first glance it would sure seem mcs_systemhigh and mcs_allcats would
>> (should?) evaluate to the same thing.
>>      
> They don't.
>
> mcs_systemhigh = s0:c0.c1024
> mcs_allcats = c0.c1024
>
> Which is why I'm saying we should probably get rid of mcs_allcats and
> fix gen_context() to not add in the "s0:" for MCS.  Then we wouldn't
> have this confusion.
>    
Ok, I get it now, and agree with you. Thanks for your help.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
