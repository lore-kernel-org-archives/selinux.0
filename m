Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7RKmj9G011594
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 16:48:45 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n7RKmB63009471
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 20:48:11 GMT
Date: Thu, 27 Aug 2009 16:48:42 -0400
Subject: Re: Patch to semanage
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C6BC696A.AA1D4%csellers@tresys.com>
In-Reply-To: <4A8C5EC7.20300@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/19/09 4:21 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> On 08/19/2009 03:35 PM, Chad Sellers wrote:
>> On 8/19/09 3:20 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
>> 
>>> On 08/19/2009 09:53 AM, Joshua Brindle wrote:
>>>> Daniel J Walsh wrote:
>>>>> On 08/18/2009 05:41 PM, Chad Sellers wrote:
>>>>>> On 8/18/09 5:35 PM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>>>>>> 
>>>>>>> On 08/17/2009 05:45 PM, Chad Sellers wrote:
>>>>>>>> On 7/17/09 6:10 AM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>>>>>>>> 
>>>>>>>>> Ok lets try the patch again.
>>>>>>>>> 
>>>>>>>>> Added equal patch (spelled correctly.)
>>>>>>>>> Beginning to add modules support to consolidate on one management
>>>>>>>>> command.
>>>>>>>>> Eventually replace semodule/setsebool with semanage command.
>>>>>>>>> Some white space fixing in seobject.py
>>>>>>>> As I said previously, I've split this patch into the 3 separate
>>>>>>>> patches
>>>>>>>> (whitespace, equal, modules) for review purposes, as it was too
>>>>>>>> difficult to
>>>>>>>> get through with the 3 different patches interspersed. Please try
>>>>>>>> to split
>>>>>>>> up functional patches in the future.
>>>>>>>> 
>>>>>>>> This message will apply to the modules patch only.
>>>>>>>> 
>>>>>>>>> diff --git a/policycoreutils/semanage/semanage
>>>>>>>>> b/policycoreutils/semanage/semanage
>>>>>>>>> index 1688d85..072453d 100644
>>>>>>>>> --- a/policycoreutils/semanage/semanage
>>>>>>>>> +++ b/policycoreutils/semanage/semanage
>>>>>>>>> @@ -44,7 +44,7 @@ if __name__ == '__main__':
>>>>>>>>>                  text = _("""
>>>>>>>>>   semanage [ -S store ] -i [ input_file | - ]
>>>>>>>>> 
>>>>>>>>> -semanage
>>>>>>>>> {boolean|login|user|port|interface|node|fcontext|translation}
>>>>>>>>> -{l|D}
>>>>>>>>> [-n]
>>>>>>>>> +semanage
>>>>>>>>> {module,boolean|login|user|port|interface|node|fcontext|translation}
>>>>>>>>> -{l|D} [-n]
>>>>>>>>>   semanage login -{a|d|m} [-sr] login_name | %groupname
>>>>>>>>>   semanage user -{a|d|m} [-LrRP] selinux_name
>>>>>>>>>   semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
>>>>>>>>> @@ -53,7 +53,8 @@ semanage node -{a|d|m} [-tr] [ -p protocol ] [-M
>>>>>>>>> netmask]
>>>>>>>>> addr
>>>>>>>>>   semanage fcontext -{a|d|m} [-frst] [-e path ] file_spec
>>>>>>>>>   semanage translation -{a|d|m} [-T] level
>>>>>>>>>   semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean |
>>>>>>>>> boolean_file
>>>>>>>>> -semanage permissive -{d|a} type
>>>>>>>>> +semanage permissive -{a|d} type
>>>>>>>>> +semanage module -{a|d|} module
>>>>>>>>> 
>>>>>>>>>   Primary Options:
>>>>>>>>> 
>>>>>>>>> @@ -68,6 +69,7 @@ Primary Options:
>>>>>>>>>       -h, --help       Display this message
>>>>>>>>>       -n, --noheading  Do not print heading when listing OBJECTS
>>>>>>>>>           -S, --store      Select and alternate SELinux store to
>>>>>>>>> manage
>>>>>>>>> +        --dontaudit      Turn on or off dontaudit rules
>>>>>>>>> 
>>>>>>>> Need to specify that this takes an integer argument (1 or 0) here.
>>>>>>>> Also,
>>>>>>>> need to specify which command this is valid for, which appears to
>>>>>>>> be the
>>>>>>>> module command. Why is this an option for the module command? It
>>>>>>>> doesn't
>>>>>>>> seem to have anything to do with a particular module. Should this
>>>>>>>> just be
>>>>>>>> its own command?
>>>>>>>> 
>>>>>>> I think it should be just for the modules command.
>>>>>> Care to explain why? As your usage above shows, the module command is
>>>>>> for
>>>>>> adding or deleting modules. This functionality has nothing to do with
>>>>>> that.
>>>>>> --dontaudit is for specifying globally that dontaudit's should be turned
>>>>>> on/off. It's not an option that modifies the behavior of adding or
>>>>>> deleting
>>>>>> a module, it's a completely separate thing.
>>>>>> 
>>>>> No I don't care to explain why, now that you shot down my idea. :^)
>>>>> 
>>>>> I guess it should be a separate command
>>>>> 
>>>>> What do you think of.
>>>>> 
>>>>> semanage dontaudit -a
>>>>> semanage dontaudit -d
>>>>> 
>>>> 
>>>> I like it being a separate command since it really is a global thing but
>>>> the syntax above seems very confusing. Can we depart from the add/remove
>>>> paradigm for this one and use something more appropriate, like on/off,
>>>> enable/disable, audit/dontaudit, or something similar?
>>>> 
>>>> 
>>>> -- 
>>>> This message was distributed to subscribers of the selinux mailing list.
>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>>> with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>>> 
>>>> 
>>> 
>>> semanage dontaudit on
>>> semanage dontaudit off
>> 
>> Sounds great to me.
>> 
>> Chad
>> 
> How about this patch.
>
It doesn't actually work, but that's primarily due to a problem in
libsemanage, rather than here. libsemanage doesn't notice that the
disable_dontaudit flag is set so it does not rebuild the policy. semodule
got around this by calling semanage_set_rebuild() explicitly, but
libsemanage should really notice that this has changed and rebuild
appropriately. I'm sending a separate patch to fix libsemanage.

There are a couple of issues with this as well, which I've highlighted
below.

<snip>
> diff --git a/policycoreutils/semanage/semanage.8
> b/policycoreutils/semanage/semanage.8
> index d0726cf..d83e94e 100644
> --- a/policycoreutils/semanage/semanage.8
> +++ b/policycoreutils/semanage/semanage.8
> @@ -21,6 +21,8 @@ semanage \- SELinux Policy Management tool
>  .br
>  .B semanage permissive \-{a|d} type
>  .br
> +.B semanage dontaudit [ on | off ]
> +.br
>  .B semanage translation \-{a|d|m} [\-T] level
>  .P
>  
> @@ -117,6 +119,8 @@ $ semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
>  $ semanage port -a -t http_port_t -p tcp 81
>  # Change apache to a permissive domain
>  $ semanage permissive -a httpd_t
> +# Turn off dontaudit rules
> +$ semanage dontaudit off
>  .fi
>  
>  .SH "AUTHOR"
> diff --git a/policycoreutils/semanage/seobject.py
> b/policycoreutils/semanage/seobject.py
> index 20bd205..9c5d2ec 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -314,6 +314,18 @@ class semanageRecords:
>                 self.transaction = False
>                 self.commit()
>  
> +class dontauditClass(semanageRecords):
> +    def __init__(self, store):
> +               semanageRecords.__init__(self, store)
> +
> +    def toggle(self, dontaudit):
> +               if dontaudit not in [ "on", "off" ]:
> +                      raise ValueError(_("dontaudit requires either 'on' or
> 'off'"))
> +               self.begin()
> +               rc = semanage_set_disable_dontaudit(self.sh, dontaudit ==
> "on")

This is the opposite logic of what you put in the man page. The man page
says dontaudit off means disable_dontaudit. This does the opposite. I think
the man page makes more sense than this.

Also, there is no return code from semanage_set_disable_dontaudit().

> +               self.commit()
> +               rc = semanage_reload_policy(self.sh)

You shouldn't call semanage_reload_policy here, as semanage_commit() will do
it.

Thanks,
Chad




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
