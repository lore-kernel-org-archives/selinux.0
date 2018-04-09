Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w39DbMIM032642
 for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2018 09:37:22 -0400
To: selinux@tycho.nsa.gov
References: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
 <20180409075523.GA2087@julius.enp8s0.d30>
 <20180409084124.GB2087@julius.enp8s0.d30>
 <d72be794-a882-a7ff-381b-fd1ffb78d0c8@redhat.com>
 <20180409120712.GC2087@julius.enp8s0.d30>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <f1e5241e-36d2-c71b-ba7c-e64a1db09a98@tycho.nsa.gov>
Date: Mon, 9 Apr 2018 09:38:55 -0400
MIME-Version: 1.0
In-Reply-To: <20180409120712.GC2087@julius.enp8s0.d30>
Content-Type: text/plain; charset=windows-1252; format=flowed
Subject: Re: CIL namespaces and blockinheritfilter keyword.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/09/2018 08:07 AM, Dominick Grift wrote:
> On Mon, Apr 09, 2018 at 01:41:12PM +0200, Lukas Vrabec wrote:
>> On 04/09/2018 10:41 AM, Dominick Grift wrote:
>>> On Mon, Apr 09, 2018 at 09:55:23AM +0200, Dominick Grift wrote:
>>>> On Sun, Apr 08, 2018 at 11:00:53PM +0200, Lukas Vrabec wrote:
>>>>> Hi All,
>>>>>
>>>>> I'm reading "SELINUX COMMON INTERMEDIATE LANGUAGE MOTIVATION AND DESIGN"
>>>>> wiki page [1] and I'm interested in CIL namespaces. I tried several
>>>>> examples related to blockinheritence and all works just great!
>>>>>
>>>>> However, in following example I see keyword "blockinheritfilter":
>>>>>
>>>>> (block logger
>>>>> 	(blockabstract logger)
>>>>> 	(type process)
>>>>> 	(type log)
>>>>> 	(allow process log (file (getattr append write))))
>>>>>
>>>>> (block myapp
>>>>> 	(blockinherit logger)
>>>>> 	(blockinheritfilter myapp logger
>>>>> 		(allow process log (file (write)))))
>>>>>
>>>>
>>>> The example above actually demonstrates that you do not need blockinheritfilter (and should not use it for this example), instead you can just append rules to blocks.
>>>>
>>>> loggers should not open the log file for write and so the main template should not include that permission in the first place:
>>>>
>>>> (block logger
>>>>         (blockabstract logger)
>>>>         (type process)
>>>>         (type log)
>>>>         (allow process log (file (getattr append))))
>>>>
>>>> Then if you have a misbehaving logger you can just append the bad rule to that block:
>>>>
>>>> (block badlogger
>>>>         (blockinherit logger)
>>>>         (allow process log (file (write)))))
>>>
>>> Or even:
>>>
>>> (block logger
>>>         (blockabstract logger)
>>>         (type process)
>>>         (type log)
>>>         (allow process log (file (getattr append))))
>>>
>>> (block badlogger
>>>         (blockabstract badlogger)
>>>         (blockinherit logger)
>>>         (allow process log (file (write))))
>>>
>>> (block yourlogger
>>>         (blockinherit badlogger))
>>>
>>
>> Hi Dominick,
>>
>> Yes, This is one of the options to create hierarchy when the block on
>> top will have just minimum rules and every child block will append new
>> rules.
>>
>> Unfortunately, this probably won't work in real world. Let's say that I
>> have this hierarchy and badlogger block contains several allow rules and
>> I want to inherit all of them except one, *BUT* I'm not SELinux policy
>> expert and don't know how hierarchy looks like. That's the reason why
>> I'm looking for blockinheritfilter.
> 
> I forgot the reason for dropping this functionality (I do recall me asking about this as well in the past but it seems that Google has no record of that) and so I will leave it to others to respond to this part of the question.
> 

It was never implemented.

Inheritance is done in CIL by copying the inherited rules. This is not 
complicated in the case where no rules are removed. A different approach would 
be necessary to allow rules to be removed because we do not normally evaluate 
things like attributes and attribute sets until after all of the copying is 
done. We would have to evaluate as much of the policy as we could and then keep 
cycling through all of the inheritance rules evaluating what we could with each 
pass until we had evaluated all of the rules.

This is why we punted and decided to leave things like removing rules to a 
higher-level language.

>>
>> However, we should go via creating block namespaces hierarchy as you
>> described if there are no plans to implement this feature.
>>

Sorry, but there are currently no plans to implement this feature.

Jim

>> Thanks,
>> Lukas.
>>
>>>>
>>>> Appending instead of filtering probably just the better approach also if you consider that blocks might have macros or nested blocks
>>>> You probably would not be able to filter any of those.
>>>>
>>>>
>>>>>
>>>>> If I understand it correctly, it should "remove" rule:
>>>>> allow myapp.process log:file write;
>>>>>
>>>>> So process type in myapp should have allowed:
>>>>> allow myapp.process log:file {getattr append};
>>>>>
>>>>> And process type in logger should have allowed:
>>>>> allow logger.process log:file {getattr append write};
>>>>>
>>>>> Which could be very cool feature, but I don't see any code in secilc
>>>>> related to "blockinheritfilter". Are there any plans to implement also
>>>>> this in CIL namespaces or is there any other way how to handle this
>>>>> (DELETE statement is also not implemented) ?
>>>>>
>>>>> Thanks for any help.
>>>>> Lukas.
>>>>>
>>>>>
>>>>> [1] https://github.com/SELinuxProject/cil/wiki
>>>>>
>>>>> -- 
>>>>> Lukas Vrabec
>>>>> Software Engineer, Security Technologies
>>>>> Red Hat, Inc.
>>>>>
>>>>
>>>>
>>>>
>>>>
>>>> -- 
>>>> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
>>>> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
>>>> Dominick Grift
>>>
>>>
>>>
>>
>>
>> -- 
>> Lukas Vrabec
>> Software Engineer, Security Technologies
>> Red Hat, Inc.
>>
> 
> 
> 
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
