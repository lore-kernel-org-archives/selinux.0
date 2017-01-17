Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0HDmS5Q020563
 for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2017 08:48:28 -0500
Subject: Re: New Blog on how SELinux blocked Docker container escape.
To: Marko Rauhamaa <marko@pacujo.net>, Tracy Reed <treed@ultraviolet.org>
References: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>
 <20170114082311.GN12376@tracyreed.org> <87pojqj86o.fsf@elektro.pacujo.net>
Cc: Fedora SELinux Users <selinux@lists.fedoraproject.org>,
 SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <bc24daad-4944-925f-157c-3dfdc88e253e@redhat.com>
Date: Tue, 17 Jan 2017 08:48:25 -0500
MIME-Version: 1.0
In-Reply-To: <87pojqj86o.fsf@elektro.pacujo.net>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 01/14/2017 04:35 AM, Marko Rauhamaa wrote:
> Tracy Reed <treed@ultraviolet.org>:
>
>> On Fri, Jan 13, 2017 at 11:48:20AM PST, Daniel J Walsh spake thusly:
>>> http://rhelblog.redhat.com/2017/01/13/docker-0-day-stopped-cold-by-selinux/
>> I have long been of the opinion that it is this sort of thing which best
>> advocates the use of SELinux. We need more examples like this.
> The threats are obvious to anyone by now. What SELinux needs is a clear
> methodology. For example, this is *not* a methodology:
>
>    <URL: https://wiki.gentoo.org/wiki/SELinux/Tutorials/Creating_your_o
>    wn_policy_module_file>
>
>
> As a software developer, what am I expect to do wrt SELinux? Should I
> ship my product with an SELinux policy module? Or should I simply make
> it SELinux agnostic and supply information for the sysadmin so they can
> add a policy module for my product? If so, what information should I
> provide?
Either. You should definitely not advise to turn it off.  You should
either understand how SELinux would interact with
your product and tell admins with Booleans to set, Which labels to set,
andy modification of configuration required.
If you really want to push it you should ship additional policy with
your application to confine it.

In the container world this becomes much easier, since SELinux can treat
all applications as a black box and just make
sure the application stays in the box, which is what the BLOG is about,
how SELinux keeps the container processes contained.
> As a sysadmin, should I accept RedHat's policy collection or come up
> with my own? 
Yes you should most likely accept Red hat's Policy and customize it as
needed.
> If I need another boolean not supplied by RedHat, what am I
> to do? 
You most likely would just add a policy module and not another boolean. 
You can add allow rules
on the fly using semodule. This is what most admins do.  You would also
need to fix the labeling, which
is usually the problem.
> How do I make sure my policy is sound? 
Probably best to have other people more expert review it.  But Policy is
not rocket science.  You are
basically defining labels which a process label can write to, and read
from. 
> How do I find out what
> legitimate access I need to permit for a random service apart from
> monitoring the audit log?
That is the only way.  sepolicy generate does attempt to help you get
started but other the code analysys, we have
found that running an app through a test suite and collecting the logs
and processing them is the best way to figure
out what an application does.
> It's much easier to understand sandboxes, namespaces, containers,
> virtual machines and such. What happens in Vegas stays in Vegas.
I agree.  This is why we should be pushing towards containers.  90 % or
Android Cell Phones now run with SELinux (SEANdroid) in enforcing mode
and no one knows, because the applications are running in a form of
container.
> Take Daniel Walsh's link above. I didn't get any smarter reading it.
> Look at <URL: https://bugzilla.redhat.com/show_bug.cgi?id=1409531#c8>:
>
>    The proposed exploit scenario [...] is *not* possible under the
>    default SELinux configuration.
>
> Would it be possible under an SELinux configuration defined by me?
Does this help?
http://rhelblog.redhat.com/2017/01/13/docker-0-day-stopped-cold-by-selinux/

Yes it would be possible if you disabled SELinux on the host. Or if you
disabled it inside of the container, or you ran
the container privileged.  Of if you added custom policy to allow a
process running as container_t to write elsewhere on
the system.
>
> Marko
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
