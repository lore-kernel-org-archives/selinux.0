Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1O1W6XE024622
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 20:32:06 -0500
Message-ID: <4F46E88F.604@windriver.com>
Date: Fri, 24 Feb 2012 09:31:59 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Martin Orr <martin@martinorr.name>
CC: <qingtao.cao@windriver.com>, <selinux@tycho.nsa.gov>
Subject: Re: role_fix_callback assertion with sysadm in base - base VS loadable
 module
References: <20120209225847.969915sba4w431r4@webmail.tuffmail.net> <SNT139-W2532C1EC901A78581F23C6AB600@phx.gbl> <20120222232219.GA15452@claudius.martinorr.name> <4F46136E.6050802@windriver.com>
In-Reply-To: <4F46136E.6050802@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Martin,

Later last night I turned to realized that even the base module could 
have some exterior reference as long as they are in the optional block. 
I need some time to dive into the source code to see how symbols 
required in an optional block are handled during link & expansion and 
get back to you about how we could improve the situation here.

Thanks,
Harry

On 02/23/2012 06:22 PM, Harry Ciao wrote:
> Hi Martin,
>
> On 02/23/2012 07:22 AM, Martin Orr wrote:
>> Sorry, I failed to make it clear that the requires causing problems are
>> in optional blocks.
>>
>> Perhaps might make it clearer if I remove the refpolicy machinery.
>> Ignore everything below except the attribute_role stuff - the rest is
>> just needed to get something which compiles.
>>
>> In each case, the base module optionally requires the role attribute
>> foo.  This works if the attribute is defined in the base but not
>> otherwise.  Both examples work if foo is a type instead of an
>> attribute_role.
>
> No comments about why if foo is a type attribute then its declaration 
> could be optional (not momentarily required) in the base module. 
> Hypothetically, base module should be self-contained so that other 
> modules could add on top of it.
>
> (Perhaps this is a toolchain bug, but I am not sure, need more time to 
> understand why link_modules() failed to find this undeclared symbol)
>
>>    $ cat x.te
>> class file
>> sid kernel
>> class file {
>>          read
>> }
>>
>> optional {
>>          require {
>>                  attribute_role foo;
>>          }
>> }
>>
>> type kernel_t;
>> user system_u roles { object_r };
>> sid kernel system_u:object_r:kernel_t
>>
>>    $ checkmodule x.te
>> checkmodule:  loading policy configuration from x.te
>> checkmodule: expand.c:700: role_fix_callback: Assertion `new_role != 
>> ((void *)0)&&  new_role->flavor == 1' failed.
>> Aborted
>
> If you break above assertion into two parts, you will see that it 
> aborts at the criteria of
>
> new_role != ((void *)0)
>
>
> The reason is that during expansion any undeclared role identifiers 
> would be skipped (see role_copy_callback > is_id_enabled, which will 
> return 0 if it fails to find a SCOPE_DECL type of scope_datum_t for 
> the current identifier), resulting in the foo attribute won't even be 
> properly copied from the base module to the out module.
>
> At last the expand_module > role_fix_callback will find foo identifier 
> does not exist in out.p_roles hashtab, that's exactly how above 
> assertion is failed.
>
> Last but not least, if you want to build a loadable module, the "-m" 
> option would have to be used for checkmodule, otherwise it will try to 
> build a base module by default and then tries to call link_modules() 
> and expand_module(), which makes no sense for loadable modules.
>
> Thanks,
> Harry
>
>>    $ cat y.te
>> class file
>> sid kernel
>> class file {
>>          read
>> }
>>
>> attribute_role foo;
>> optional {
>>          require {
>>                  attribute_role foo;
>>          }
>> }
>>
>> type kernel_t;
>> user system_u roles { object_r };
>> sid kernel system_u:object_r:kernel_t
>>
>>    $ checkmodule y.te
>> checkmodule:  loading policy configuration from y.te
>> checkmodule:  policy configuration loaded
>>
>> On Sat, Feb 18, 2012 at 03:02:23PM +0000, HarryCiao wrote:
>>> So far I am not 100% sure, but I am extra sure that certain cautions
>>> must be taken when requiring a module to be built into base.pp rather
>>> than as loadable module. In particular, while building the base module
>>> the "self_contained_policy" macro is defined, exactly the same as when
>>> building a monolithic policy image, which will influence if the
>>> gen_require() macro would be properly expanded to the "require"
>>> keyword. Below is the definition of the gen_require() macro:
>>>
>>> define(`gen_require',`
>>>          ifdef(`self_contained_policy',`
>>>                  ifdef(`__in_optional_policy',`
>>>                          require {
>>>                                  $1
>>>                          } # end require
>>>                  ')
>>>          ',`
>>>                  require {
>>>                          $1
>>>                  } # end require
>>>          ')
>>> ')
>>>
>>> Where we can clearly see that if the "self_contained_policy" is
>>> defined,  ONLY WHEN the "__in_optional_policy" is also defined, would
>>> gen_require() be expaned to the require keyword. BTW,
>>> "__in_optional_policy" is defined only within an optional_policy()
>>> block.
>>>
>>> That's why I take it for granted that you would have to include the
>>> actual definition of a role attribute along with the module that
>>> requires it into the base module.
>>>
>>> Cheers,
>>> Harry
>>>
>>>
>>>> Date: Thu, 9 Feb 2012 22:58:47 +0000
>>>> From: martin@martinorr.name
>>>> To: selinux@tycho.nsa.gov
>>>> Subject: role_fix_callback assertion with sysadm in base
>>>>
>>>> I tried to build latest git refpolicy (6da98efd) using latest
>>>> checkpolicy and libsepol (339f8079) with the attached modules.conf.
>>>> In particular this puts sysadm into base.pp, and minimal other things.
>>>>    I get the following error.
>>>>
>>>> Compiling refpolicy base module
>>>> /usr/bin/checkmodule base.conf -o tmp/base.mod
>>>> /usr/bin/checkmodule:  loading policy configuration from base.conf
>>>> checkmodule: expand.c:700: role_fix_callback: Assertion `new_role !=
>>>> ((void *)0)&&  new_role->flavor == 1' failed.
>>>> make: *** [tmp/base.mod] Aborted
>>>>
>>>> -- 
>>>> Martin Orr
>>>
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
