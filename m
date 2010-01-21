Subject: Re: What is refpolicy [strict or targeted]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: AlannY <m@alanny.ru>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20100121131207.GA29762@alanny-pc.lcl.starlink.ru>
References: <20100121131207.GA29762@alanny-pc.lcl.starlink.ru>
Content-Type: text/plain
Date: Thu, 21 Jan 2010 08:49:42 -0500
Message-Id: <1264081782.11002.49.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-01-21 at 16:12 +0300, AlannY wrote:
> Hi there. I'm newbie in SELinux, so I have a lame question.
> 
> I know, that SELinux are now not supported all application,
> so there are 2 different kinds of policy available: strict
> and targeted.
> 
> First one: strict checking. Applications allows only what policy
> can allow.
> 
> Second one (and more intresting for me) is targeted policy:
> policy will work only on targeted applications.
> 
> I'm using Fedora and using targeted policy. But now, I'm trying
> to setup SELinux on different OS on different machine. So, I'm
> using raw refpolicy (as is).
> 
> But what is refpolicy: strict or targeted. If strict, can I change
> it to targeted? And how?
> 
> Thanks for patience.

Strict vs. targeted was really just a matter of:
- the set of applications that were confined (originally a much larger
set in strict),
- whether or not users were confined (originally only in strict),
- the existence of unconfined domains (originally only in targeted)

So strict vs. targeted were just different configurations of the same
policy source tree - you could build either one from refpolicy via the
TYPE= setting in build.conf, and by selecting the set of policy modules
via modules.conf.

Over time, the set of applications that were confined under targeted
kept growing, converging toward strict, and there was increasing
interest in being able to confine users under targeted.  That led to a
merging of targeted and strict into a single policy, which Fedora still
calls targeted, where you can select strict behavior by:
- mapping specific users to confined user roles using semanage login,
- optionally removing all support for unconfined users by removing the
unconfineduser policy module,
- optionally removing all support for any unconfined domains by removing
the unconfined policy module (but this will be disruptive to any running
processes in unconfined_t and requires care to make the transition).

There is no longer a separate strict policy.

Fedora targeted policy is built with:
TYPE=mcs
DISTRO=redhat
UNK_PERMS=allow
DIRECT_INITRC=y
MONOLITHIC=n
UBAC=n
MCS_CATS=1024

You can see how it gets built from the selinux-policy.spec file.
http://cvs.fedoraproject.org/viewvc/rpms/selinux-policy/devel/selinux-policy.spec?revision=1.959&view=markup&pathrev=HEAD

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
