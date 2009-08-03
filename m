Message-ID: <4A776096.8080903@gmail.com>
Date: Mon, 03 Aug 2009 15:11:34 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Dennis Wronka <linuxweb@gmx.net>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: best way to comile userspace to use lib64 for x86_64
References: <4A770542.3050103@gmail.com>	 <200908040117.41723.linuxweb@gmx.net>  <4A772A98.6050303@gmail.com> <1249324175.9193.22.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1249324175.9193.22.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2009-08-03 at 11:21 -0700, Justin P. Mattock wrote:
>    
>> Dennis Wronka wrote:
>>      
>>> This can be quite hard at times. For most packages you can use --libdir with
>>> configure, but some packages still want to put their stuff into /lib or /usr/lib
>>> OpenSSL for example seems to require quite a few edits in the Makefiles.
>>>
>>> Here's what I have to "rape" OpenSSL into installing into /usr/lib64
>>>
>>> if [ "$(uname -a | grep x86_64)" != "" ]; then
>>> 	for FILE in $(find . -name Makefile); do
>>> 		sed -i 's@$(INSTALLTOP)/lib@&64@g' ${FILE}
>>> 		sed -i 's@$${exec_prefix}/lib@&64@g' ${FILE}
>>> 	done
>>> fi
>>>
>>> Btw, if you compile a pure 64-bit system I suggest simply linking /lib to
>>> /lib64 and /usr/lib to /usr/lib64
>>> Saves you lots of headaches with misplaced stuff...
>>>
>>>
>>>
>>>        
>>>> As an experimanet I'm building an x86_64 system, in doing so
>>>> I'm noticing I need to have the libs point to /lib64 and /usr/lib64
>>>> what is the easiest way to do this for the
>>>> userspace from git. looking at the Makefiles seems a bit confusing,
>>>> using LIBDIR=/lib64 does make /usr/lib64 but does not  make /lib64.
>>>>
>>>> any ideas?
>>>>
>>>> Justin P. Mattock
>>>>
>>>> --
>>>> This message was distributed to subscribers of the selinux mailing list.
>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>>> with the words "unsubscribe selinux" without quotes as the message.
>>>>
>>>>          
>>>
>>>        
>> Cool thanks,
>> The linking to lib like what you had said
>> is probably the best bet(noticed ubuntu does that,
>> but fedora does not) especially with the file relabeling.
>> (unless the file relabeling is already aware of lib64's).
>>      
>
> The file contexts configuration already includes patterns that cover
> lib64 or lib variants.
>
>    
Cool, glad to hear that..

At the moment SELinux userspace tools/libs should be
in its appropriate location. Now its a matter of just building
the rest of the libs/apps to make the system boot(hopefully).

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
