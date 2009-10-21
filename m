Message-ID: <4ADF3009.6020506@gmail.com>
Date: Wed, 21 Oct 2009 09:00:09 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Laganowski <eric@laganowski.net>, selinux@tycho.nsa.gov
Subject: Re: 'make policy' issues
References: <4ADF2358.4050606@laganowski.net>	 <1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>	 <4ADF2663.2030105@laganowski.net> <1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2009-10-21 at 11:18 -0400, Eric Laganowski wrote:
>    
>> Stephen Smalley wrote:
>>      
>>> On Wed, 2009-10-21 at 11:06 -0400, Eric Laganowski wrote:
>>>
>>>        
>>>> Hello,
>>>>
>>>>   I was trying to build selinux userspace tools on my custom linux build.
>>>> Everything went fine until I attempted to compile reference policy.
>>>> Could you please help me in understanding what went wrong here.
>>>>
>>>> refpolicy-2.20090730
>>>>
>>>> $ make policy
>>>> Compiling refpolicy policy.24
>>>> /usr/bin/checkpolicy policy.conf -o policy.24
>>>> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
>>>> policy/modules/kernel/corenetwork.te":1715:ERROR 'syntax error' at token ':' on line 9122:
>>>> allow corenet_unconfined_type node_type:node *;
>>>>
>>>> checkpolicy:  error(s) encountered while parsing configuration
>>>> make: *** [policy.24] Error 1
>>>>
>>>>
>>>> Packages:
>>>>
>>>> checkpolicy-2.0.19
>>>> libselinux-2.0.85
>>>> libsemanage-2.0.33
>>>> libsepol-2.0.37
>>>> policycoreutils-2.0.69
>>>> sepolgen-1.0.17
>>>>
>>>> $ yacc -V
>>>> yacc - 1.9 20090221
>>>> $ flex -V
>>>> flex 2.5.35
>>>>
>>>>          
>>> Sounds similar to:
>>> http://marc.info/?l=selinux&m=117076095205821&w=2
>>>
>>> which was an upstream flex problem.  However, I also see that you are using yacc rather than bison?
>>> Default for building checkpolicy is bison -y, which could be relevant.
>>>
>>>        
>> Re bison/yacc: I tried both, byacc and 'bison -y'
>> Re flex: What is the requirement for flex from selinux perspective? Is
>> it known what build of flex is "known good"?
>>      
>
> My impression is that one of the patches carried by the distributions
> for flex is needed for checkpolicy to work, but no one has ever fully
> investigated the precise dependency - people just grab the Fedora srpm
> and apply those patches to flex, and then rebuild checkpolicy and it
> works.  I haven't seen any complaints from Debian or Gentoo so I presume
> that they also carry the same patches for flex.
>
> flex -V here also shows 2.5.35.  But there are three patches in the
> Fedora package.  Attached.
>
>    
Thanks for the patch, been hitting something similar to this
with checkpolicy(used git clean -fx to fix)

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
