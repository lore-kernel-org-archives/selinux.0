Subject: Re: [RFC][SECMARK 05/08] Add new packet controls to SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux-dev@tresys.com, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20060510221146.GG8937@thorium.jmh.mhn.de>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
	 <Pine.LNX.4.64.0605071136100.8588@d.namei>
	 <1147106449.23640.102.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0605081947400.19850@d.namei>
	 <1147174138.32651.5.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0605091146350.25693@d.namei>
	 <20060510221146.GG8937@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Thu, 11 May 2006 08:52:25 -0400
Message-Id: <1147351945.8341.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-11 at 00:11 +0200, Thomas Bleher wrote:
> I'd prefer a config option because it makes it possible to load old
> policy without changing things beyond the kernel. It also alerts people
> that they will need to upgrade their userland before they switch to the
> next kernel.

I agree with the first point.  I'm not sure a config option helps much
with the latter point - most people likely would just re-use an
existing .config and not notice that introduction of a new option.

> Remember: Not all people use distro kernels (or have selinux userland
> provided by their distro). It's not nice to break compatibility without
> a proper notice in advance.
> 
> I think there is a tendency here to break backwards compatibility[1]
> because "RedHat will fix it". This gives SELinux a reputation of "breaks
> regularly, maintainers don't care for their users". We should avoid this
> if at all possible.

In truth, the introduction of new checks and new policy binary formats
has actually caused problems in Fedora as well, as the kernel, patched
userland components, and core SELinux components are maintained by
different people, so they aren't always properly synchronized.

> (Possibly crazy idea: Would it be possible to change the module format
> so that the kernel recognizes permissions which are not defined in the
> loaded policy at all and automatically allows them? This would allow us
> to define new permissions (e.g. for decomposing CAP_SYS_ADMIN) without
> needing comlex compatibility code or breaking systems.)

Changing the module format isn't sufficient for that, as the kernel
doesn't see the module format.  You'd have to change the kernel binary
policy format, if a format change is truly required.

It isn't as simple as just allowing undefined permissions; there is the
issue of how one maps the intent of a policy written against one set of
permission checks into a different set of permission checks.  One
example was the past introduction of fine-grained netlink classes and
checks (which did bump the binary policy version, but that was a hack),
where you needed to map the finer-grained netlink classes to the old
single netlink class when using an older policy.  In the packet controls
case, we have two different sets of per-packet permission checks, and
automatically mapping the intent of a policy written in terms of one set
to another is not really feasible, particularly as the newer checks rely
on separate netfilter labeling of the packets based on iptables rules.

I'm also a bit uneasy about the implications for reasoning about /
making assurance arguments about the actual enforcement if we have such
conditional checking and it becomes pervasive as we continue to add new
checks / replace old checks.

We further have to consider the implications for userspace.  At present,
we always generate policy in the latest version supported by the
toolchain (unless otherwise configured in semanage.conf), and then
downgrade it at load time if necessary to the version supported by the
kernel.  Introducing incompatible policy versions that cannot be
downgraded will require some rethinking there.

> [1]: "Breaking backwards compatibility" happened in the past when
> name_connect and the various exec* checks were introduced, because after
> updating the kernel the system didn't work anymore, because the new
> permissions weren't granted in the policy.

Yes, people have complained about that, but I'm not sure we can avoid
the tight coupling between kernel and policy; it is inherent.  Possibly
it would be better to just make it explicit; e.g. policy-2.6.16,
policy-2.6.15.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
