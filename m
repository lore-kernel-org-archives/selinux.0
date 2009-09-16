Message-ID: <4AB12072.3060004@redhat.com>
Date: Wed, 16 Sep 2009 13:29:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: policycoreutils, sepolgen (sepolgen-ifgen) issues on Debian
References: <87d46y1lwd.fsf@anzu.internal.golden-gryphon.com>	<878whm1gr5.fsf@anzu.internal.golden-gryphon.com> <87fxbq30u5.fsf@anzu.internal.golden-gryphon.com> <4AB0FDBD.8030200@manicmethod.com> <4AB11C0D.5040909@redhat.com> <4AB11CF5.7020604@manicmethod.com>
In-Reply-To: <4AB11CF5.7020604@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/16/2009 01:14 PM, Joshua Brindle wrote:
> 
> 
> Daniel J Walsh wrote:
>> On 09/16/2009 11:01 AM, Joshua Brindle wrote:
>>   
>>> Manoj Srivastava wrote:
>>>     
>>>> On Mon, Aug 17 2009, Christopher J. PeBenito wrote:
>>>>
>>>>
>>>>       
>>>>> On Fri, 2009-08-14 at 11:50 -0500, Manoj Srivastava wrote:
>>>>>
>>>>>         
>>>>>> On Fri, Aug 14 2009, Manoj Srivastava wrote:
>>>>>>
>>>>>>
>>>>>>           
>>>>>>>           I am running into an issue with sepolgen on Debian. Debian
>>>>>>> ships
>>>>>>>    more than one  version of the refpolicy, a default one, and a
>>>>>>>    MLS enabled one. So, the include files live in either
>>>>>>>    /usr/share/selinux/{default,mls}/include
>>>>>>>
>>>>>>>           sepolgen (in src/sepolgen/defaults.py) sets
>>>>>>> refpolicy_devel() to
>>>>>>>    a single location -- and thus, only one version of the security
>>>>>>> policy
>>>>>>>    may be supported. So, sepolgen-ifgen from policycoreutils can
>>>>>>> only work
>>>>>>>    with one policy, which may not be the one installed on the target
>>>>>>>    machine. Could this be made configurable, somehow? As far as I
>>>>>>> can
>>>>>>>    see, sepolgen's python library does not offer any way to set the
>>>>>>> value.
>>>>>>>
>>>>>>>           It would be nice if the location of the include directory
>>>>>>> could
>>>>>>>    be looked for from a PATH like variable setting, to make it
>>>>>>> easier for
>>>>>>>    distributions to ship more than one policy, or for end users to
>>>>>>>    experiment with other policies without have to overwrite the
>>>>>>> single
>>>>>>>    default.
>>>>>>>
>>>>>>>              
>>>>>>           Well, here is a kind of proof-of-concept patch (python is
>>>>>> not my
>>>>>>    strong suit), and I have only tested in that it allows the
>>>>>> package to
>>>>>>    compile, and the following code works:
>>>>>>
>>>>>>            
>>>>> [...]
>>>>>
>>>>>         
>>>>>>    def refpolicy_makefile():
>>>>>> -    return refpolicy_devel() + "/Makefile"
>>>>>> +    chooser = PathChoooser("/etc/selinux/sepolgen.conf")
>>>>>> +    return chooser("Makefile")
>>>>>>
>>>>>>    def headers():
>>>>>> -    return refpolicy_devel() + "/include"
>>>>>> -
>>>>>> +    chooser = PathChoooser("/etc/selinux/sepolgen.conf")
>>>>>> +    return chooser("include")
>>>>>> +
>>>>>>
>>>>>>            
>>>>> Why are you making another config file rather than just get the policy
>>>>> name from /etc/selinux/config via selinux_getpolicytype()?
>>>>>
>>>>>          
>>>>           This will work well for Debian, since the development
>>>> files are
>>>>    installed under "/usr/share/selinux/" in a subdirectory named
>>>> after the
>>>>    policy. I was not sure that this convention was followed in other
>>>>    distributions, though. While I am not certain, google implies
>>>> that in
>>>>    fedora policy type is targeted, but the devel files do not live in
>>>>    /usr/share/selinux/targeted.[0]. Given that, perhaps it is better to
>>>>    let the user provide guidance about how to map the policy type to a
>>>>    directory?
>>>>
>>>>           Also, I must confess I had forgotten about this call.
>>>>
>>>>           However, a patch with this is trivial, so an alternate patch
>>>>    follows. (Not sure this will work for fedora, so caveat emptor)
>>>>
>>>>           manoj
>>>> [0]
>>>> http://docs.fedoraproject.org/selinux-user-guide/f11/en-US/chap-Security-Enhanced_Linux-Working_with_SELinux.html
>>>>
>>>>
>>>>
>>>> --8<---------------cut here---------------start------------->8---
>>>>
>>>> If the user installs a policy whose development files do not live under
>>>> /usr/share/selinux/devel/include, sepolgen wqould not work. Debian, for
>>>> instance, installs under:
>>>> /usr/share/selinux/{default,mls}/include
>>>>
>>>> This patch uses selinux_getpolicytype() to determine the policy
>>>> type, and
>>>> assumes that there is one-on-one correspondence between policytype and
>>>> the directory the development files live in.
>>>>
>>>> Signed-off-by: Manoj Srivastava<srivasta@debian.org>
>>>> ---
>>>>    src/sepolgen/defaults.py |    4 +++-
>>>>    src/sepolgen/module.py   |    2 +-
>>>>    2 files changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/src/sepolgen/defaults.py b/src/sepolgen/defaults.py
>>>> index 45ce61a..85e5fb0 100644
>>>> --- a/src/sepolgen/defaults.py
>>>> +++ b/src/sepolgen/defaults.py
>>>> @@ -21,6 +21,8 @@
>>>>    Various default settings, including file and directory locations.
>>>>    """
>>>>
>>>> +import selinux
>>>> +
>>>>    def data_dir():
>>>>        return "/var/lib/sepolgen"
>>>>
>>>> @@ -31,7 +33,7 @@ def interface_info():
>>>>        return data_dir() + "/interface_info"
>>>>
>>>>    def refpolicy_devel():
>>>> -    return "/usr/share/selinux/devel"
>>>> +    return "/usr/share/selinux/" + selinux.selinux_getpolicytype()[1]
>>>>
>>>>    def refpolicy_makefile():
>>>>        return refpolicy_devel() + "/Makefile"
>>>> diff --git a/src/sepolgen/module.py b/src/sepolgen/module.py
>>>> index edd24c6..355c9b8 100644
>>>> --- a/src/sepolgen/module.py
>>>> +++ b/src/sepolgen/module.py
>>>> @@ -120,7 +120,7 @@ class ModuleCompiler:
>>>>            self.semodule_package = "/usr/bin/semodule_package"
>>>>            self.output = output
>>>>            self.last_output = ""
>>>> -        self.refpol_makefile = "/usr/share/selinux/devel/Makefile"
>>>> +        self.refpol_makefile = "/usr/share/selinux/" +
>>>> selinux.selinux_getpolicytype()[1]  + "/Makefile"
>>>>            self.make = "/usr/bin/make"
>>>>
>>>>        def o(self, str):
>>>>
>>>>        
>>> This will break Fedora/RHEL AFAIK. I don't necessarily like that RH has
>>> interface files in /usr/share/selinux/devel rather than
>>> /usr/share/selinux/<policy>/devel or similar but we can't break them.
>>>
>>> Dan, any chance you could change the location of the interface files?
>>>
>>>
>>>      
>> We could carry a patch although I don't think anyone is  shipping
>> different interfaces for different policies.
>>
>>    
> 
> I'm not willing to break upstream behavior and force you to carry a
> patch for something that previously worked.
> 
> Perhaps not for distro shipped policies but for custom policies I know
> interfaces are changed and if the developers on those end systems want
> to use sepolgen for interface matching they have to over write the
> distro shipped interface files.
> 
>> We could add a link in each policy types back to the devel environment.
>> Or do /usr/share/selinux/POLICYTYPE/devel/Makefile and on RHEL and
>> Fedora systems
>>   have /usr/share/selinux/POLICYTYPE/devel ->  /usr/share/selinux/devel/
>>
>>    
> 
> wasn't this done in the past? I remember a symlink being there but can't
> remember why it was removed (unless I'm misremembering)
> 
It was there in the past, but "devel" was a separate package and in some cases we ended up with a dangling link.
devel has since been moved into the selinux-policy package so it would not be a problem any longer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
