Subject: RE: [patch 0/4] libsemanage: genhomedircon replacement
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Todd Miller <tmiller@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com>
References: <20070815204411.705994826@tresys.com>
	 <1187190639.2674.51.camel@localhost.localdomain>
	 <46C31BD0.5060200@tresys.com>
	 <1187192832.2674.74.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 15 Aug 2007 13:22:40 -0400
Message-Id: <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-15 at 11:57 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Wed, 2007-08-15 at 11:29 -0400, Joshua Brindle wrote:
> >> Karl MacMillan wrote:
> >>> On Wed, 2007-08-15 at 16:44 -0400, tmiller@tresys.com wrote:
> >>>> This replaces genhomedircon with equivalent functionality in
> >>>> libsemanage. The homedir_template is also no longer installed, this
> >>>> leaves some unused path functions in libselinux but
> > removing those would break the ABI.
> >>>> 
> >>> 
> >>> On a higher level, perhaps we should stop doing per-role home
> >>> directory labeling at all and therefore remove genhomedircon
> >>> entirely. I've been thinking about how to work this on a LDAP based
> >>> network with remote home directories and I think the basic
> >>> conclusion is that role-based labeling will simply not work
> >>> (especially if we start assigning different primary roles to the
> >>> same user on different systems with the same remote home
> >>> directories). 
> >>> 
> >>> I suggest that we rely on either DAC or separate namespaces to
> >>> separate user access to home directories and have one set of types
> >>> for all home directories. On systems where you really want SELinux
> >>> to do the separation you can use user constraints (which could
> >>> either acheive the current role-level separation or user-level
> >>> separation based on how you map your SELinux users).
> >>> 
> >>> (BTW - most of the above was suggested to me by Dan and Steve in
> >>> private concersations). 
> >>> 
> >>> Thoughts?
> >> 
> >> Without genhomedircon how do you expect to be able to label home
> >> directories with the appropriate MLS levels for the LSPP version of
> >> RH? 
> >> 
> > 
> > Perhaps it would be better to set it explicitly rather than
> > based on the user. Either by giving people a way to set MLS
> > file contexts separately from the type (which might help with
> > MLS customization in general) or just doing a chcon on the
> > containing home directory and having that be inherited (and
> > not set on relabel for home directories).
> > 
> 
> So... Right now its based on the policy because the home directory
> contexts are regenerated when the policy changes, you are suggesting
> making it more difficult to use? Right now you can change someones level
> with semanage and restorecon -R their home directory which is fairly
> easy. Setting the contexts explicitly seems like much more burden on the
> local admin.

I thought genhomedircon wasn't setting the level at all (just using
whatever is in the template, i.e. s0), and then they were using
pam_namespace to instantiate per-level subdirs.

I'm trying to understand whether the issue here is limited in scope to
home directory labels or actually extends to the entire notion of
per-role types (tmp files, ttys, derived program domains, etc).  I know
that has long been an area of concern, not only for file relabeling but
also for e.g. modules (requires templating that would go beyond even
simple interfaces).

genhomedircon does serve another purpose, btw - setting the SELinux user
identity for the user's home directory.  So if you want to do separation
based on SELinux user via constraints, you still need a mechanism for
getting the user home directories to have the right SELinux user
identity.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
