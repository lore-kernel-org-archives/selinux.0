Message-ID: <49763499.2070702@cs.purdue.edu>
Date: Tue, 20 Jan 2009 15:31:21 -0500
From: Jacques Thomas <jthomas@cs.purdue.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joe Nall <joe@nall.com>, domg472@gmail.com,
        Cheyenne Solo <ayla.cheyenne@gmail.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Murray McAllister <mmcallis@redhat.com>
Subject: Re: Base module, modules.conf
References: <5ab9a20b0901160943o14c1d47csbc763ae31564b97b@mail.gmail.com>	 <1232132620.13917.109.camel@localhost.localdomain>	 <1232133792.8594.4.camel@localhost.localdomain>	 <1232135544.13917.140.camel@localhost.localdomain>	 <4974E82F.2030806@cs.purdue.edu>	 <1232461572.4166.47.camel@localhost.localdomain>	 <9B58C618-F5D7-4A16-969C-B1AA6307FEEC@nall.com> <1232479544.4166.84.camel@localhost.localdomain>
In-Reply-To: <1232479544.4166.84.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2009-01-20 at 09:58 -0600, Joe Nall wrote:
>   
>> On Jan 20, 2009, at 8:26 AM, Stephen Smalley wrote:
>>
>>     
>>> On Mon, 2009-01-19 at 15:53 -0500, Jacques Thomas wrote:
>>>       
>>>> Stephen Smalley wrote:
>>>>         
>>>>> On Fri, 2009-01-16 at 20:23 +0100, Dominick Grift wrote:
>>>>>
>>>>>           
>>>>>> On Fri, 2009-01-16 at 14:03 -0500, Stephen Smalley wrote:
>>>>>>
>>>>>>
>>>>>>             
>>>>>>> You need to first obtain a policy source tree as your starting  
>>>>>>> point.
>>>>>>> If you want to minimize your divergence from the distro-shipped  
>>>>>>> policy,
>>>>>>> then download the selinux-policy source RPM (.src.rpm) for your  
>>>>>>> distro,
>>>>>>> expand it, and then customize as desired and rebuild it (Dan -  
>>>>>>> is there
>>>>>>> a recipe documented somewhere for doing that?).
>>>>>>>
>>>>>>>               
>>>>>> I have created a screen cast that focuses on just that. However,  
>>>>>> the
>>>>>> file is 200MB and i do not have the ability to host it.
>>>>>>
>>>>>>             
>>>>> I just meant writing down the sequence of commands to set up a  
>>>>> buildable
>>>>> policy source tree from the .src.rpm.  Screencast seems a bit  
>>>>> overkill
>>>>> for that - it really ought to just be part of the Fedora SELinux  
>>>>> FAQ or
>>>>> Guide IMHO.
>>>>>
>>>>>
>>>>>           
>>>> Here's what works for me to tweak the policy on a Fedora 8 system.
>>>>
>>>> Make sure you have the latest policy package (otherwise, you might  
>>>> not
>>>> be able to get it in source version):
>>>>   yum update
>>>>   yum install selinux-policy-targeted
>>>>
>>>> Figure out the version of the rpm:
>>>>   rpm -qa | grep selinux-policy-targeted
>>>>
>>>> Get the corresponding source rpm:
>>>>   yumdownloader --source `rpm -qa | grep policy-targeted`
>>>>
>>>> Voila! The source rpm is in your current directory.
>>>>
>>>> From there on, regular instructions for rebuilding rpms apply. The
>>>> following is a short tutorial.
>>>>   http://www.hacktux.com/fedora/source/rpm
>>>>         
>>> I think we need something more specific to the policy, similar to the
>>> instructions for building a custom kernel at
>>> http://fedoraproject.org/wiki/Docs/CustomKernel
>>>
>>> Getting a buildable policy tree that matches the Fedora shipped policy
>>> configuration isn't as straightforward as one might like, since the  
>>> spec
>>> file defers most of the real work to the %install target and specifies
>>> different build.conf settings (via command-line override to make) and
>>> different modules.conf configurations based on the particular policy
>>> type.  The question does seem to keep arising on fedora-selinux-list  
>>> and
>>> selinux list, so it would be helpful to have it documented somewhere.
>>>       
>> I'm sure Dan has better mojo, but I:
>>   - install the src rpm
>>   - add patches to SOURCE directory
>>   - patch spec file to incorporate patches in SOURCE
>>   - build policy rpms using patched spec file
>>     
>
> Yes, that works if you have your changes in the form of a patch and want
> to do things the rpm way.  But not so much if you'd just like to create
> a buildable source tree that matches the Fedora configuration that you
> can then edit at will and build manually (which you might later use as
> the basis for creating a patch that you would then be able to add to
> the .src.rpm for distribution purposes).  The "add patch file to spec
> and rebuild with rpm" is fine for packaging but not so much for
> initially developing one's changes, at least in my view.
>
> For many (simpler) packages, you can just do a rpmbuild -bp on the spec
> file and you'll have a buildable source tree that you can edit and build
> manually.  But not in the case of selinux-policy, where it is building N
> different variants of policy during %install and pulling in different
> conf files accordingly.
>
> I've done it by hand before in order to make custom changes to a base
> module (e.g. defining new kernel classes/perms) for testing purposes,
> but it would be nice if the process were captured and maintained as a
> recipe somewhere w/o requiring people to reverse engineer it from
> the .spec file.
>   

This would help me too. :-)
(I am not done reverse-engineering the package build process)

Best,
Jacques

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
