Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0E9ZLhr014776
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 04:35:21 -0500
From: Marko Rauhamaa <marko@pacujo.net>
To: Tracy Reed <treed@ultraviolet.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
 Fedora SELinux Users <selinux@lists.fedoraproject.org>
Subject: Re: New Blog on how SELinux blocked Docker container escape.
References: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>
 <20170114082311.GN12376@tracyreed.org>
Date: Sat, 14 Jan 2017 11:35:11 +0200
In-Reply-To: <20170114082311.GN12376@tracyreed.org> (Tracy Reed's message of
 "Sat, 14 Jan 2017 00:23:12 -0800")
Message-ID: <87pojqj86o.fsf@elektro.pacujo.net>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tracy Reed <treed@ultraviolet.org>:

> On Fri, Jan 13, 2017 at 11:48:20AM PST, Daniel J Walsh spake thusly:
>> http://rhelblog.redhat.com/2017/01/13/docker-0-day-stopped-cold-by-selinux/
>
> I have long been of the opinion that it is this sort of thing which best
> advocates the use of SELinux. We need more examples like this.

The threats are obvious to anyone by now. What SELinux needs is a clear
methodology. For example, this is *not* a methodology:

   <URL: https://wiki.gentoo.org/wiki/SELinux/Tutorials/Creating_your_o
   wn_policy_module_file>


As a software developer, what am I expect to do wrt SELinux? Should I
ship my product with an SELinux policy module? Or should I simply make
it SELinux agnostic and supply information for the sysadmin so they can
add a policy module for my product? If so, what information should I
provide?

As a sysadmin, should I accept RedHat's policy collection or come up
with my own? If I need another boolean not supplied by RedHat, what am I
to do? How do I make sure my policy is sound? How do I find out what
legitimate access I need to permit for a random service apart from
monitoring the audit log?

It's much easier to understand sandboxes, namespaces, containers,
virtual machines and such. What happens in Vegas stays in Vegas.

Take Daniel Walsh's link above. I didn't get any smarter reading it.
Look at <URL: https://bugzilla.redhat.com/show_bug.cgi?id=1409531#c8>:

   The proposed exploit scenario [...] is *not* possible under the
   default SELinux configuration.

Would it be possible under an SELinux configuration defined by me?


Marko
