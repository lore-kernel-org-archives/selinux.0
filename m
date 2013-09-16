Message-ID: <523723AF.4090106@tresys.com>
Date: Mon, 16 Sep 2013 11:28:47 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: RFC policycoreutils packaging
References: <1379166860.4313.21.camel@d30> <5236F48B.7080407@tycho.nsa.gov>  <1379334768.6787.48.camel@d30> <52371696.2050509@redhat.com> <1379343250.6787.64.camel@d30>
In-Reply-To: <1379343250.6787.64.camel@d30>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/16/2013 10:54 AM, Dominick Grift wrote:
> On Mon, 2013-09-16 at 10:32 -0400, Daniel J Walsh wrote:
>> On 09/16/2013 08:32 AM, Dominick Grift wrote:
>>> On Mon, 2013-09-16 at 08:07 -0400, Stephen Smalley wrote:
>>>> On 09/14/2013 09:54 AM, Dominick Grift wrote:
>>>>> We were discussing policycoreutils packaging and there are some things 
>>>>> unclear to me:
>>>>>
>>>>> 1. if one wants to run a monotlitic policy on a embedded system, then, 
>>>>> besides fixfiles and checkpolicy, which tools from policycoreutils are 
>>>>> needed?
>>>>
>>>> If you want a truly minimalist SELinux userspace, consider our port to 
>>>> Android in the SE for Android project.  Policy is built monolithically on
>>>> the build host, with only the final binary policy installed to the 
>>>> device, so you don't even need libsepol or checkpolicy on the device, and
>>>> you don't need libsemanage, semodule, or semanage at all.  We also have a
>>>> minimalist port of libselinux with glibc dependencies removed, and a port
>>>> of the SELinux utilities to the Android toolbox, although I suspect you
>>>> are using busybox and thus picking up its SELinux support instead.
>>>>
>>>>> 1.a How are home dir contexts generated with monolithic policy (  or 
>>>>> should they be created manually ? ), i ask this because in Fedora the 
>>>>> genhomedircon is just a script that calls semodule, but i think
>>>>> semodule does not work with monolithic policy. If true, how then is
>>>>> someone expected to generate home dir contexts?

Speaking as someone who still implements some monolithic policies, we don't typically use genhomedircon, since a modular policy typically goes on a pretty static system.  But I'm fine having refpolicy still support its use for monolithic policy.

>>>> Originally IIRC, genhomedircon was a python script that didn't use 
>>>> semodule or libsemanage at all.  That's how it used to work in the 
>>>> pre-modular/managed policy days.  Should be able to find it the 
>>>> selinux-historical git repo.
[...]
>> genhomedircon script disappeared into libsemanage/semodule many years ago, but
>> no one has complained or replaced the script within something that would work
>> on monolithic.
> 
> Agreed, this goes back a long time indeed, and just identified the issue
> recently in my quest to optimize efficiency.
> 
> Some how this made it into upstream policycoreutils, which i guess, it
> should have

There is an old old copy of genhomedircon in the top level support dir of refpolicy.  I kept a copy of it while we were supporting RHEL4.  Now that RHEL4 is EOL, we can remove the RHEL4 parts in the policy, and also update the copy in refpolicy to the last version before it was replaced with the C libsemanage version.

An alternative would be for semodule_expand to emit file contexts (actually I think it should emit all possible files).  Then refpolicy build process would simply build all policies in a modular fashion and use semodule_link and semodule_expand to create policy.2x and file_contexts* for monolithic policies.  The added benefit is that it would reduce some of the workarounds in the policy made to support checkpolicy-compiled monolithic policy.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
