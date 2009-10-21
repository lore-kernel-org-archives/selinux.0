Date: Wed, 21 Oct 2009 13:10:47 -0400
From: Eric Laganowski <eric@laganowski.net>
Subject: Re: 'make policy' issues
In-reply-to: <1256145071.4061.224.camel@moss-pluto.epoch.ncsc.mil>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Message-id: <4ADF4097.5060702@laganowski.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <4ADF2358.4050606@laganowski.net>
 <1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>
 <4ADF2663.2030105@laganowski.net>
 <1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>
 <87hbtsvhru.fsf@anzu.internal.golden-gryphon.com>
 <4ADF3D2C.2030408@laganowski.net>
 <1256144567.4061.223.camel@moss-pluto.epoch.ncsc.mil>
 <4ADF3FBD.3010306@laganowski.net>
 <1256145071.4061.224.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2009-10-21 at 13:07 -0400, Eric Laganowski wrote:
>   
>> Stephen Smalley wrote:
>>     
>>>>>>   
>>>>>>         
>>>>>>             
>>>>>        Debian currently carries 13 (though 3 of them need to be
>>>>>  squashed together) patches against 2.5.35. I can make them available if
>>>>>  there is interest.
>>>>>
>>>>>         manoj
>>>>>   
>>>>>       
>>>>>           
>>>> Yes please. Patches would be welcome.
>>>>     
>>>>         
>>> Did you try the three patches that I attached to my email for flex?
>>>
>>>   
>>>       
>> Yes I did: applied patches and rebuilt checkpolicy-2.0.19, which did not 
>> resolve the issue.
>>     
>
> Curious.  gcc -v?
>
>   
$ gcc -v
Using built-in specs.
Target: i686-pc-linux-gnu
Configured with: ../gcc-4.4.1/configure --prefix=/usr 
--libexecdir=/usr/lib --enable-shared --enable-threads=posix 
--enable-__cxa_atexit --enable-c99 --enable-long-long 
--enable-clocale=gnu --enable-languages=c,c++ --disable-multilib 
--disable-libstdcxx-pch
Thread model: posix
gcc version 4.4.1 (GCC for Cross-LFS 4.4.1.20090722)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
