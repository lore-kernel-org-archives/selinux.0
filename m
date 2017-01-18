Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0I55f3d009477
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 00:05:41 -0500
Received: by mail-it0-f43.google.com with SMTP id c7so110636121itd.1
 for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2017 21:05:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bc24daad-4944-925f-157c-3dfdc88e253e@redhat.com>
References: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>
 <20170114082311.GN12376@tracyreed.org> <87pojqj86o.fsf@elektro.pacujo.net>
 <bc24daad-4944-925f-157c-3dfdc88e253e@redhat.com>
From: =?UTF-8?B?6Z2i5ZKM5q+F?= <ka-omo@sios.com>
Date: Wed, 18 Jan 2017 14:05:31 +0900
Message-ID: <CAEKGoSHqxmHMyFVNTvLZcHC4unpONu2O2cq+Y3EZ5=z6=7Ld0A@mail.gmail.com>
Subject: Re: New Blog on how SELinux blocked Docker container escape.
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Marko Rauhamaa <marko@pacujo.net>, Tracy Reed <treed@ultraviolet.org>,
 SELinux <selinux@tycho.nsa.gov>,
 Fedora SELinux Users <selinux@lists.fedoraproject.org>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dear Sir,

I'm member of Japan-SOSS SIG(Secure OSS Special
Interest Group).
We love SELinux(12years user) and we are promoting SELinux in Japan.

>From technical interesting(we are promoting Docker
with SELinux), we did PoC for CVE-2016-9962 on Fedora25.

Then we found current SELinux(maybe policy) does not
mitigate that vulnerability.

We could reproduce that vulnerability with
- add CAP_SYS_PTRACE to container
- modified runc because there’s not so much race window on runc.
then we think it's not so easy in usual situation.
Also we couldn't reproduce it on CentOS7(latest).

We posted that PoC result on our community blog.
https://jsosug.github.io/post/omok-selinux-docker-20170118/

Also we wish to argue how can we protect this kind of
vulnerability by using SELinux.

Kind Regards,

OMO
-- 
Kazuki Omo: ka-omo@sios.com
OSS &Security Evangelist
Secure OSS SIG
https://jsosug.github.io/
CISSP #366942
Tel: +81364015149

2017-01-17 22:48 GMT+09:00 Daniel J Walsh <dwalsh@redhat.com>:
>
>
> On 01/14/2017 04:35 AM, Marko Rauhamaa wrote:
>> Tracy Reed <treed@ultraviolet.org>:
>>
>>> On Fri, Jan 13, 2017 at 11:48:20AM PST, Daniel J Walsh spake thusly:
>>>> http://rhelblog.redhat.com/2017/01/13/docker-0-day-stopped-cold-by-selinux/
>>> I have long been of the opinion that it is this sort of thing which best
>>> advocates the use of SELinux. We need more examples like this.
>> The threats are obvious to anyone by now. What SELinux needs is a clear
>> methodology. For example, this is *not* a methodology:
>>
>>    <URL: https://wiki.gentoo.org/wiki/SELinux/Tutorials/Creating_your_o
>>    wn_policy_module_file>
>>
>>
>> As a software developer, what am I expect to do wrt SELinux? Should I
>> ship my product with an SELinux policy module? Or should I simply make
>> it SELinux agnostic and supply information for the sysadmin so they can
>> add a policy module for my product? If so, what information should I
>> provide?
> Either. You should definitely not advise to turn it off.  You should
> either understand how SELinux would interact with
> your product and tell admins with Booleans to set, Which labels to set,
> andy modification of configuration required.
> If you really want to push it you should ship additional policy with
> your application to confine it.
>
> In the container world this becomes much easier, since SELinux can treat
> all applications as a black box and just make
> sure the application stays in the box, which is what the BLOG is about,
> how SELinux keeps the container processes contained.
>> As a sysadmin, should I accept RedHat's policy collection or come up
>> with my own?
> Yes you should most likely accept Red hat's Policy and customize it as
> needed.
>> If I need another boolean not supplied by RedHat, what am I
>> to do?
> You most likely would just add a policy module and not another boolean.
> You can add allow rules
> on the fly using semodule. This is what most admins do.  You would also
> need to fix the labeling, which
> is usually the problem.
>> How do I make sure my policy is sound?
> Probably best to have other people more expert review it.  But Policy is
> not rocket science.  You are
> basically defining labels which a process label can write to, and read
> from.
>> How do I find out what
>> legitimate access I need to permit for a random service apart from
>> monitoring the audit log?
> That is the only way.  sepolicy generate does attempt to help you get
> started but other the code analysys, we have
> found that running an app through a test suite and collecting the logs
> and processing them is the best way to figure
> out what an application does.
>> It's much easier to understand sandboxes, namespaces, containers,
>> virtual machines and such. What happens in Vegas stays in Vegas.
> I agree.  This is why we should be pushing towards containers.  90 % or
> Android Cell Phones now run with SELinux (SEANdroid) in enforcing mode
> and no one knows, because the applications are running in a form of
> container.
>> Take Daniel Walsh's link above. I didn't get any smarter reading it.
>> Look at <URL: https://bugzilla.redhat.com/show_bug.cgi?id=1409531#c8>:
>>
>>    The proposed exploit scenario [...] is *not* possible under the
>>    default SELinux configuration.
>>
>> Would it be possible under an SELinux configuration defined by me?
> Does this help?
> http://rhelblog.redhat.com/2017/01/13/docker-0-day-stopped-cold-by-selinux/
>
> Yes it would be possible if you disabled SELinux on the host. Or if you
> disabled it inside of the container, or you ran
> the container privileged.  Of if you added custom policy to allow a
> process running as container_t to write elsewhere on
> the system.
>>
>> Marko
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Kazuki Omo: ka-omo@sios.com
OSS &Security Evangelist
OSS Business Planning Dept.
CISSP #366942
Tel: +81364015149
