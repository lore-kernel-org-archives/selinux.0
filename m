Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7JJKTSd014277
	for <selinux@tycho.nsa.gov>; Wed, 19 Aug 2009 15:20:29 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7JJJuZv011407
	for <selinux@tycho.nsa.gov>; Wed, 19 Aug 2009 19:19:56 GMT
Message-ID: <4A8C5077.8070806@redhat.com>
Date: Wed, 19 Aug 2009 15:20:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to semanage
References: <C6B0983D.A9D92%csellers@tresys.com> <4A8B26A7.4080509@redhat.com> <4A8C03E4.7090300@manicmethod.com>
In-Reply-To: <4A8C03E4.7090300@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/19/2009 09:53 AM, Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> On 08/18/2009 05:41 PM, Chad Sellers wrote:
>>> On 8/18/09 5:35 PM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>>>
>>>> On 08/17/2009 05:45 PM, Chad Sellers wrote:
>>>>> On 7/17/09 6:10 AM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>>>>>
>>>>>> Ok lets try the patch again.
>>>>>>
>>>>>> Added equal patch (spelled correctly.)
>>>>>> Beginning to add modules support to consolidate on one management
>>>>>> command.
>>>>>> Eventually replace semodule/setsebool with semanage command.
>>>>>> Some white space fixing in seobject.py
>>>>> As I said previously, I've split this patch into the 3 separate
>>>>> patches
>>>>> (whitespace, equal, modules) for review purposes, as it was too
>>>>> difficult to
>>>>> get through with the 3 different patches interspersed. Please try
>>>>> to split
>>>>> up functional patches in the future.
>>>>>
>>>>> This message will apply to the modules patch only.
>>>>>
>>>>>> diff --git a/policycoreutils/semanage/semanage
>>>>>> b/policycoreutils/semanage/semanage
>>>>>> index 1688d85..072453d 100644
>>>>>> --- a/policycoreutils/semanage/semanage
>>>>>> +++ b/policycoreutils/semanage/semanage
>>>>>> @@ -44,7 +44,7 @@ if __name__ == '__main__':
>>>>>>                  text = _("""
>>>>>>   semanage [ -S store ] -i [ input_file | - ]
>>>>>>
>>>>>> -semanage
>>>>>> {boolean|login|user|port|interface|node|fcontext|translation}
>>>>>> -{l|D}
>>>>>> [-n]
>>>>>> +semanage
>>>>>> {module,boolean|login|user|port|interface|node|fcontext|translation}
>>>>>> -{l|D} [-n]
>>>>>>   semanage login -{a|d|m} [-sr] login_name | %groupname
>>>>>>   semanage user -{a|d|m} [-LrRP] selinux_name
>>>>>>   semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
>>>>>> @@ -53,7 +53,8 @@ semanage node -{a|d|m} [-tr] [ -p protocol ] [-M
>>>>>> netmask]
>>>>>> addr
>>>>>>   semanage fcontext -{a|d|m} [-frst] [-e path ] file_spec
>>>>>>   semanage translation -{a|d|m} [-T] level
>>>>>>   semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean |
>>>>>> boolean_file
>>>>>> -semanage permissive -{d|a} type
>>>>>> +semanage permissive -{a|d} type
>>>>>> +semanage module -{a|d|} module
>>>>>>
>>>>>>   Primary Options:
>>>>>>
>>>>>> @@ -68,6 +69,7 @@ Primary Options:
>>>>>>       -h, --help       Display this message
>>>>>>       -n, --noheading  Do not print heading when listing OBJECTS
>>>>>>           -S, --store      Select and alternate SELinux store to
>>>>>> manage
>>>>>> +        --dontaudit      Turn on or off dontaudit rules
>>>>>>
>>>>> Need to specify that this takes an integer argument (1 or 0) here.
>>>>> Also,
>>>>> need to specify which command this is valid for, which appears to
>>>>> be the
>>>>> module command. Why is this an option for the module command? It
>>>>> doesn't
>>>>> seem to have anything to do with a particular module. Should this
>>>>> just be
>>>>> its own command?
>>>>>
>>>> I think it should be just for the modules command.
>>> Care to explain why? As your usage above shows, the module command is
>>> for
>>> adding or deleting modules. This functionality has nothing to do with
>>> that.
>>> --dontaudit is for specifying globally that dontaudit's should be turned
>>> on/off. It's not an option that modifies the behavior of adding or
>>> deleting
>>> a module, it's a completely separate thing.
>>>
>> No I don't care to explain why, now that you shot down my idea. :^)
>>
>> I guess it should be a separate command
>>
>> What do you think of.
>>
>> semanage dontaudit -a
>> semanage dontaudit -d
>>
> 
> I like it being a separate command since it really is a global thing but
> the syntax above seems very confusing. Can we depart from the add/remove
> paradigm for this one and use something more appropriate, like on/off,
> enable/disable, audit/dontaudit, or something similar?
> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 

semanage dontaudit on
semanage dontaudit off

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
