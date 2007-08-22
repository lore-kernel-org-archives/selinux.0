Message-ID: <46CC1859.6060707@redhat.com>
Date: Wed, 22 Aug 2007 07:04:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: confining the unconfined_t domain
References: <FB39F4E77226B448BC1388D3BE4E00CD0219DEFA@blums0008.bluelnk.net> <1187287622.909.72.camel@moss-spartans.epoch.ncsc.mil> <FB39F4E77226B448BC1388D3BE4E00CD0219DF30@blums0008.bluelnk.net> <1187298929.909.147.camel@moss-spartans.epoch.ncsc.mil> <FB39F4E77226B448BC1388D3BE4E00CD0219DF7C@blums0008.bluelnk.net> <46CB5374.6060808@redhat.com> <FB39F4E77226B448BC1388D3BE4E00CD0219E128@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD0219E128@blums0008.bluelnk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Clarkson, Mike R (US SSA) wrote:
>   
>> -----Original Message-----
>> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
>> Sent: Tuesday, August 21, 2007 2:05 PM
>> To: Clarkson, Mike R (US SSA)
>> Cc: Stephen Smalley; selinux@tycho.nsa.gov
>> Subject: Re: confining the unconfined_t domain
>>
>> Clarkson, Mike R (US SSA) wrote:
>>     
>>>> -----Original Message-----
>>>> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
>>>> Sent: Thursday, August 16, 2007 2:15 PM
>>>> To: Clarkson, Mike R (US SSA)
>>>> Cc: selinux@tycho.nsa.gov; Daniel J Walsh
>>>> Subject: RE: confining the unconfined_t domain
>>>>
>>>> On Thu, 2007-08-16 at 13:37 -0700, Clarkson, Mike R (US SSA) wrote:
>>>>
>>>>         
>>>>>> -----Original Message-----
>>>>>> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
>>>>>> Sent: Thursday, August 16, 2007 11:07 AM
>>>>>> To: Clarkson, Mike R (US SSA)
>>>>>> Cc: selinux@tycho.nsa.gov
>>>>>> Subject: Re: confining the unconfined_t domain
>>>>>>
>>>>>> On Thu, 2007-08-16 at 10:15 -0700, Clarkson, Mike R (US SSA)
>>>>>>
>>>>>>             
>>> wrote:
>>>
>>>       
>>>>>>> I'd like to prevent the unconfined_t domain from executing
>>>>>>>
>>>>>>>               
>>> certain
>>>
>>>       
>>>>> files
>>>>>
>>>>>           
>>>>>>> associated with domains that I've added. What is the best way to
>>>>>>>
>>>>>>>               
>>> do
>>>
>>>       
>>>>>>> this?
>>>>>>>
>>>>>>> I was trying to track down how the unconfined_t domain is given
>>>>>>>
>>>>>>>               
>>> the
>>>
>>>       
>>>>>>> executable permissions to all executable files. I assume it is
>>>>>>>
>>>>>>>               
>>>>> through
>>>>>
>>>>>           
>>>>>>> the  exec_type attribute somehow. I found the
>>>>>>> corecmd_exec_all_executables and corecmd_mmap_all_executables
>>>>>>>
>>>>>>>               
>>>>> interfaces
>>>>>
>>>>>           
>>>>>>> in corecommands.if, which both give execute privilege to
>>>>>>>
>>>>>>>               
>>> exec_type,
>>>
>>>       
>>>>> but
>>>>>
>>>>>           
>>>>>>> I don't see these being called from the unconfined module. Can
>>>>>>>
>>>>>>>               
>>>>> someone
>>>>>
>>>>>           
>>>>>>> point out how this privilege is provided to the unconfined_t
>>>>>>>
>>>>>>>               
>>> domain?
>>>
>>>       
>>>>>> Um, unconfined_t is "unconfined".  By definition.
>>>>>>
>>>>>> And removing the ability to execute another program doesn't
>>>>>>             
> change
>   
>>>>> what
>>>>>
>>>>>           
>>>>>> unconfined_t can do (i.e. its actual permissions); it can always
>>>>>>
>>>>>>             
>>>>> create
>>>>>
>>>>>           
>>>>>> its own copy of the same code and execute it in unconfined_t.
>>>>>>
>>>>>> Use a different domain if you want it to be confined.
>>>>>>
>>>>>>             
>>>>> I recognize that it would be better to use the strict policy so
>>>>>           
> that
>   
>>> we
>>>
>>>       
>>>>> didn't have an unconfined_t domain, and we plan to switch in the
>>>>>
>>>>>           
>>> future
>>>
>>>       
>>>>> before going to operations, but for now we're using the targeted
>>>>>
>>>>>           
>>> policy
>>>
>>>       
>>>>> while in a prototype phase with an upcoming demo.
>>>>>
>>>>>           
>>>> It doesn't matter what policy you use (targeted or strict); you
>>>>         
> just
>   
>>>> can't reasonably restrict unconfined_t without doing major surgery
>>>>         
> on
>   
>>>> it, and then you have the further problem of once having done major
>>>> surgery on it, you no longer have a domain from which you can do
>>>>         
> admin
>   
>>>> tasks.  Better to introduce a separate domain and use it instead.
>>>>
>>>>         
>>> I think there may be a fairly simple way to restrict the
>>>       
> unconfined_t
>   
>>> domain from having access to specified files. I added an attribute
>>>       
> to
>   
>>> files.te called always_confined_type, as well as an interface to
>>> files.if to assign this attribute to a given file type. Then I
>>>       
> modified
>   
>>> files.te as follows to use the always_confined_type attribute:
>>>
>>> ########################################
>>> #
>>> # Unconfined access to this module
>>> #
>>>
>>> # Create/access any file in a labeled filesystem;
>>> allow files_unconfined_type {file_type -always_confined_type}:{ file
>>> chr_file } ~execmod;
>>> allow files_unconfined_type {file_type -always_confined_type}:{ dir
>>> lnk_file sock_file fifo_file blk_file } *;
>>>
>>> # Mount/unmount any filesystem with the context= option.
>>> allow files_unconfined_type {file_type
>>>       
> -always_confined_type}:filesystem
>   
>>> *;
>>>
>>> ifdef(`targeted_policy',`
>>> 	tunable_policy(`allow_execmod',`
>>> 		allow files_unconfined_type {file_type
>>> -always_confined_type}:file execmod;
>>> 	')
>>> ')
>>>
>>> This denies all access to the file type given the
>>>       
> always_confined_type
>   
>>> attribute, so if you want to be able to do anything with that file
>>>       
> type,
>   
>>> you'll have to do from some domain which has been explicitly granted
>>> appropriate permissions.
>>>
>>> Do you see any problems with this approach?
>>>
>>>
>>>       
>> Well it is still fairly easily gotten around.
>>
>> setenforce 0
>> Build an rpm package that overwrites them
>> Build a policy module that gives me this privs,
>> Use fstools or other apps to write over the files.
>> ...
>> How do my backup utilities work.  Can I use them to subvert your
>> protection.
>>     
>
> I'm not sure that putting SELinux in permissive mode is playing fair.
> Does SELinux provide much if any protection against attackers who have
> the ability to do that?
>
> The backup utilities would have to be granted the specific privileges
> needed to make backup copies. In this case only read privileges would be
> provided, no write, execute, or relabel privileges. The main point is
> that for types given the always_confined_type attribute, only domains
> that have been explicitly granted privileges to the type have any access
> to it, as opposed to every unconfined domain having complete access to
> it.
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>   
I think it could, secure_mode_* booleans go some of the way towards 
doing this, They prevent the inserting of kernel modules.   The problem 
here as you probably know, is you are trying to guess all the possible 
ways a super privledged user could attack you.   SELinux is better at 
defining what a user can do, then trying to define what they can not do, 
and then plugging all the holes.
circumvent your protection, which is difficult/impossible to do.
do it in strict policy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
