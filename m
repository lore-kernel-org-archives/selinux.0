Message-ID: <48517032.6070805@windriver.com>
Date: Thu, 12 Jun 2008 14:51:30 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>,
        Caleb Case <ccase@tresys.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: libsemanage.semanage_install_active: error during semodule -n
 -v -b base.pp -s refpolicy
References: <4851361E.3030305@windriver.com>	 <1213288802.17842.195.camel@moss-spartans.epoch.ncsc.mil>	 <48515E78.40400@windriver.com>	 <1213293329.17842.246.camel@moss-spartans.epoch.ncsc.mil>	 <48516379.80609@windriver.com> <1213294846.17842.261.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1213294846.17842.261.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2008-06-12 at 13:57 -0400, Vikram Ambrose wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> On Thu, 2008-06-12 at 13:35 -0400, Vikram Ambrose wrote:
>>>   
>>>       
>>>> Stephen Smalley wrote:
>>>>     
>>>>         
>>>>> On Thu, 2008-06-12 at 10:43 -0400, Vikram Ambrose wrote:
>>>>>   
>>>>>       
>>>>>           
>>>>>> During the "make load" procedure with refpolicy, the semodule command 
>>>>>> fails, so I tried it manually and I see this error.
>>>>>>
>>>>>> root@ubuntu:/home/vikram/refpolicy-ac# semodule -b 
>>>>>> /usr/share/selinux/refpolicy/base.pp -s refpolicy -v -n
>>>>>> Attempting to install base module '/usr/share/selinux/refpolicy/base.pp':
>>>>>> Ok: return value of 0.
>>>>>> Committing changes:
>>>>>> libsemanage.semanage_install_active: setfiles returned error code 1. (No 
>>>>>> such file or directory).
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> whereis setfiles
>>>>>
>>>>>   
>>>>>       
>>>>>           
>>>> setfiles and the rest of the SELinux "toolchain" was all built from svn 
>>>> and placed into /hone/testing/root
>>>> root's environment has PATH that contains /home/testing/root/bin
>>>> as well as LD_LIBRARY_PATH to /home/testing/root/lib
>>>>
>>>> Does libsemanage have a hard coded path to setfiles?
>>>>     
>>>>         
>>> Yes, although it can be overridden via /etc/selinux/semanage.conf.
>>> Add something like:
>>> [setfiles]
>>> path = /path/to/setfiles
>>> [end]
>>>
>>>   
>>>       
>> I just noticed the hard coded path in conf-parser.y
>> Is there a way of doing the above with a generic rule to all of the 
>> selinux toolchain and not specifically to "setfiles" as shown above?
>>     
>
> Not presently; it wasn't really intended for an alternate root mechanism
> (and apparently doesn't work for it anyway, as you have found).
>
>   
And specifying each and every tool individual is not possible i suppose?
>> ...
>> Adding that to semanage.conf produce an almost obvious error " error 
>> while loading shared libraries: libsepol.so.0: cannot open shared object 
>> file: No such file or directory"
>>
>> what sort of environment is libsemanage using to execute setfiles? 
>> libsepol and friends are in LD_LIBRARY_PATH
>>     
>
> Ah, semanage_exec_prog() passes a NULL environ to execve().
>
>   
Can this be rectified?
> I think this takes us to the "run it in a chroot environment" scenario
> if you don't want to install the libraries and programs to your system
> directories.  I'm not entirely sure what your goal is here though - you
> seem ok with installing the policy files to system directories.
>   
Your last remark there is rather confusing to me. You seem to suggest 
that "installing the policy files to system directories" is an option I 
have been given, and as such chosen to do so. To my knowledge the entire 
toolchain is hard coded to /etc/selinux and as such not possible to 
provide a /different/syconfig/path. How is it that I go about installing 
selinux and its configuration to a non "system directory", yet "system 
wide" path such as /security or /selinux or /seconfig etc..?
>   
>>> Or you could run semodule in a chroot environment if you've set one up.
>>>
>>>   
>>>       
>>>>> What versions are you using?  Is this with the packages included in
>>>>> Hardy Heron?
>>>>>
>>>>>   
>>>>>       
>>>>>           
>>>> svn from yesterday.
>>>>     
>>>>         
>>> I see.  Are you aware that Ubuntu 8.04 has SELinux support (apt-get
>>> install selinux)?  Although you may still want to build a custom policy,
>>> as their initial default policy was minimal.
>>>
>>>   
>>>       
>> Yes I am, this was a usability exercise of the SELinux toolchain and 
>> refpolicy, therefore distribution packages were not employed.
>>     
>
> Not sure what you mean by usability exercise, but I'd generally
> recommend using the distribution-provided packages for the toolchain
> unless you have specific needs that are not met by them.  The upstream
> is primarily oriented at developers and packagers rather than end users.
>
>   
Consider me as a "packager".

Thanks again Stephen for your prompt response to my questions. Your help 
is appreciated.

-- 
Vikram Ambrose | Linux Products Division | WindRiver Corporation


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
