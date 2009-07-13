Subject: RE: [RFC] Install SELinux policies from rpm package header
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
        Paul Howarth <paul@city-fan.org>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E012CD8FB@exchange2.columbia.tresys.com>
References: <C67BD5B0.A89C1%csellers@tresys.com>
	 <4A575664.4040805@manicmethod.com>
	 <1247241489.30551.86.camel@moss-lions.epoch.ncsc.mil>
	 <06A6610D4F464D4EBEAFBF2C5F86911E012CD8FB@exchange2.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 13 Jul 2009 10:55:19 -0400
Message-Id: <1247496919.2588.91.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-07-10 at 16:26 -0400, Joshua Brindle wrote:
> > From: James Carter [mailto:jwcart2@tycho.nsa.gov] 
> > 
> > > Its alot worse than that. What about files on backup 
> > drives? Offline drives? 
> > > transient files that will get relabeled to something inappropriate? 
> > > I'm not confortable relabeling databases with potentially sensitive 
> > > data to var_lib_t because mysql was uninstalled.
> > > 
> > 
> > The argument seems to be for removing the ability to remove modules.
> > It would be the roach motel style of policy management.
> > 
> 
> I like it, policies check in but don't check out. I haven't heard an
> argument about 1) how I'm crazy and wrong or 2) how to keep systems
> running as expected otherwise though.
> 
1)
I'll let your co-workers comment on your insanity or lack thereof.

You're not wrong.

The general problem here is how two systems using different policies
interoperate.  For one of the systems to access a resource labeled under
the second system's policy, the request must be translated in a way that
is consistent with the overall security goals of the two systems.  There
is no way to automatically do this for arbitrary policies.

Anytime the system policy is changed (loading or unloading modules,
updating policy, etc) we have two systems (past and present) using
different policies.  The labels of the old policy must be translated so
that the overall security goals are met with the new policy.  

Often the reason for the change is that the old policy was found to be
more restrictive than the overall security goals, so the new policy is
more permissive and no labels are required to be changed.  No
translation is usually necessary in this case, just load the new
policy.  

When making more radical changes, more elaborate translation steps are
needed.  As an example, to remove the unconfined module one needs to
switch the system to permissive mode, set the system up to relabel on
the next reboot, remove the unconfined module, and reboot.  In this
example, the translation between the two policies is done by rebooting
the system and relabeling the filesystem.  This example also shows that
temporary policy changes (setting permissive mode) might be necessary
during the period of translation.

2)
So to keep systems running, there needs to be a way to do the steps
required to translate between the two policies.  That could require
loading additional policy, switching the system to permissive mode,
setting the system up to relabel the filesystem, and requesting that the
user reboots the system.

Again, this is not a problem specific to policy packages.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
