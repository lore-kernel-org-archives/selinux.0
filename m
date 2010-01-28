Subject: Re: Allowing MLS->non-MLS and vice versa upon policy reload (Was:
 Re: Building MLS/MCS policy)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <201001272247.o0RMl6hD014615@vivaldi26.register.it>
References: <201001272247.o0RMl6hD014615@vivaldi26.register.it>
Content-Type: text/plain
Date: Thu, 28 Jan 2010 08:11:36 -0500
Message-Id: <1264684296.6232.27.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-01-27 at 23:47 +0100, Guido Trentalancia wrote:
> Hello Stephen !
> 
> On Tue, 2010-01-26 at 12:52 -0500, Stephen Smalley wrote:
> >> Alternatively to spending time on documenting the current limitation, it
> >> might be more interesting to try removing the restriction from the
> >> SELinux kernel code and investigating what needs to be done within the
> >> kernel to enable it to be done safely.  Primarily this would mean:
> >> - pushing the selinux_mls_enabled flag inside the policydb so that it
> >> could be per-policydb (this is already the case in libsepol),
> >> - in the non-MLS to MLS case, ensuring that the MLS fields of the
> >> context for all existing entries in the sidtab are filled in with a
> >> suitable default value, likely taken from one of the initial SIDs,
> >> - in the MLS to non-MLS case, freeing any storage used by the MLS fields
> >> in the context for all existing entries in the sidtab.
> 
> > FYI, both of the latter two items would be handled inside
> > of ss/services.c:convert_context().
> 
> First of all, I am sorry for the late reply.
> 
> The idea seems very attractive: allowing the transition between MLS/MCS and non-MLS/non-MCS policies (and viceversa) at the kernel level can be considered a new feature and it is certainly better than writing piece of documentation about current limitation of the code.
> 
> I am not very familiar with the kernel code, but before discussing it further, I have noticed that the code at lines 1740-1744 of policydb.c (in the latest released kernel, within policydb_read()) never gets executed, even though the switch from MLS/MCS to standard policy does not take place. It's a minor issue, but it's probably worth of consideration because there must be some wrong assumption in the if statements there. Similarly I don't understand why at line 1730 selinux_mls_enabled is set to 1, even though we don't have a MLS/MCS policy loaded and we are not switching to a MLS/MCS policy either...
> 
> And at the moment I am also not able to get lines 1725-1729 executed, by trying to switch from a non-MLS/MCS policy to a MLS/MCS policy.
> 
> To do the switch I am just using "make load" in the two respective policies that I have compiled (and installed in different stores) beforehand. I believe "make load" just executes semodule (without "-n").
> 
> What do you say ? I must admit, when a few days ago I was trying to install the MCS policy with the same name of the currently loaded standard policy, lines 1725-1729 were getting executed and I use to get the error message from the kernel...
> 
> Have you had any other idea about a possible implementation of this new feature ? I will try to look at the kernel code more closely...

First, if you are going to do SELinux kernel development, then develop
patches against the #next branch of the security-testing-2.6 tree.  See:
http://selinuxproject.org/page/Developers#Kernel_developers
http://security.wiki.kernel.org/index.php/Kernel_Repository

To exercise the restriction on MLS->non-MLS or vice versa, build and
install two policies on your system under different names, one MLS or
MCS and one standard.  Boot with /etc/selinux/config pointing to one of
the policies, and then switch /etc/selinux/config to point to the other
and attempt to run load_policy.  That should fail with the error message
logged to /var/log/messages and your dmesg output.  Then reboot with the
new policy, and switch /etc/selinux/config to point to the other policy
and try running load_policy again.  This should also fail similarly.
That should exercise both cases.

The condition: ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS))
tests whether or not the policy being loaded was built with MLS enabled.
The condition: (ss_initialized && !selinux_mls_enabled)
tests whether policy has ever been loaded (ss_initialized) and if so,
whether it was previously MLS-disabled.
The condition: (ss_initialized && selinux_mls_enabled)
tests whether policy has ever been loaded (ss_initialized) and if so,
whether it was previously MLS-enabled.
Note that we "goto bad" in the error paths and thus never reach setting
of selinux_mls_enabled to 1 in the error case.

To support switching, we must change selinux_mls_enabled from a global
flag to one that is part of the policydb state, so that we can have a
currently active policydb that has one value of MLS enabled and a
policydb that is being loaded that has a different value (up to the
point where we switch from the old to the new).  That will be the most
painful part of the patch - you'll have to track down all uses of
selinux_mls_enabled and replace them with e.g. policydb.mls_enabled
(when referencing the active policydb) or p->mls_enabled (when
referencing a particular policydb, like the one that is being loaded).
Then you need convert_context() to correctly deal with the MLS fields of
the context when switching, and then you can finally safely remove the
restriction from policydb_read().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
