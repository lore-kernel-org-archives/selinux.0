Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
Message-Id: <EEBBC902-36C7-4A69-998A-B5ACA17E2E70@a61.nl>
From: Ronald van den Blink <selinux@a61.nl>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1204810640.3994.7.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Unreserved portnumbers in corenetwork
Date: Fri, 7 Mar 2008 14:13:37 +0100
References: <37866.80.95.164.250.1204712494.squirrel@www.a61.nl> <1204730645.14217.39.camel@gorn> <1204732314.1397.58.camel@moss-spartans.epoch.ncsc.mil> <1204810640.3994.7.camel@gorn.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mar 6, 2008, at 2:37 PM, Christopher J. PeBenito wrote:

> On Wed, 2008-03-05 at 10:51 -0500, Stephen Smalley wrote:
>> On Wed, 2008-03-05 at 10:24 -0500, Christopher J. PeBenito wrote:
>>> On Wed, 2008-03-05 at 11:21 +0100, selinux@a61.nl wrote:
>>>> We're building a policy for JBoss. Jboss uses atleast port 8080  
>>>> and 8083.
>>>> Besides this, the application we use on JBoss also opens port  
>>>> 8443 (https)
>>>>
>>>> While building the jboss-module we ofcourse want to claim these  
>>>> ports and
>>>> patch corenetwork. However, this is where our problem arises;  
>>>> HTTP has
>>>> claimed some of the ports we need and http-cache has claimed 8080
>>>> allready.
>>>>
>>>> But http and http-cache allow to open more ports (80, 443, 488,  
>>>> 8008,
>>>> 8009) than we really need. We think this is against the SElinux  
>>>> policy of
>>>> least privilege.
>>>>
>>>> So how do we deal with these kinds of port conflicts? Maybe  
>>>> corenetwork
>>>> isn't the best place to define unreserved (> 1024) ports?
>>>
>>> Unfortunately there are 3 forces at work.  The first is that for the
>>> most part, ports should always be labeled, because, for example,  
>>> port 80
>>> is always going to be regarded as the http port.  The second is that
>>> thats not always the case for non well-defined ports (your  
>>> situation).
>>> The third is that portcons (the port labeling statements) only  
>>> work in
>>> the base module.  So, though we want to make a happy medium  
>>> between the
>>> first two, we can't overcome the final one within the constraints  
>>> of the
>>> current toolchain.
>>
>> Perhaps all port context definitions should be moved to being handled
>> via semanage port?
>
> I don't think we actually need to move anything, we just have to allow
> semanage to delete port labelings, since it can already add and modify
> them.

Can I take the fast-lane by saying that we agree on the fact that  
something needs to be done to make it more flexible? And if the answer  
is yes, what is the consensus right now? Is it likely to assume that  
semanage is being allowed to delete port labelings?

And if we take that approach, aren't we still seeing the issue that  
someone has to decide which port-number is assigned to which  
applications for starters? Because I can see a issue here when new  
policy writers are creating policies and choosing "just to use  
http_cache because my port-number is in that range" and opening up to  
many ports.

Just to make the discussion a little bit bigger, if we speak of least  
privileged, why are we making general lib_t, usr_t etc.? Aren't we  
making a hole in our security model right then, because of giving to  
much read privileges by saying that everyone has to be able to read in  
lib_t? So actually giving app X read rights to the lib_t's of app Y?  
Of course you have to give access to lib_t first, but after that every  
lib_t labeled file is free to read. Or are we seeing things wrong.

If we are right, why aren't we just creating appX_lib_t and appY_lib_t  
(the way we are doing in our jboss policy)?





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
