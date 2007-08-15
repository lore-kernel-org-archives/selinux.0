Subject: RE: [patch 0/4] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Todd Miller <tmiller@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil>
References: <20070815204411.705994826@tresys.com>
	 <1187190639.2674.51.camel@localhost.localdomain>
	 <46C31BD0.5060200@tresys.com>
	 <1187192832.2674.74.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com>
	 <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 15 Aug 2007 15:16:18 -0400
Message-Id: <1187205378.2838.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-15 at 13:22 -0400, Stephen Smalley wrote:
> On Wed, 2007-08-15 at 11:57 -0400, Joshua Brindle wrote:
> > Karl MacMillan wrote:
[...]
> > > Perhaps it would be better to set it explicitly rather than
> > > based on the user. Either by giving people a way to set MLS
> > > file contexts separately from the type (which might help with
> > > MLS customization in general) or just doing a chcon on the
> > > containing home directory and having that be inherited (and
> > > not set on relabel for home directories).
> > > 
> > 
> > So... Right now its based on the policy because the home directory
> > contexts are regenerated when the policy changes, you are suggesting
> > making it more difficult to use? Right now you can change someones level
> > with semanage and restorecon -R their home directory which is fairly
> > easy. Setting the contexts explicitly seems like much more burden on the
> > local admin.
> 
> I thought genhomedircon wasn't setting the level at all (just using
> whatever is in the template, i.e. s0), and then they were using
> pam_namespace to instantiate per-level subdirs.
> 

Which sounds better (and safer - relabeling the level would be
questionable). However, having a mechanism to set levels separate from
type (and potentially user) sounds helpful. That way an admin could
specify, for example, that a log file should be Secret without having to
specify the type.

> I'm trying to understand whether the issue here is limited in scope to
> home directory labels or actually extends to the entire notion of
> per-role types (tmp files, ttys, derived program domains, etc).  I know
> that has long been an area of concern, not only for file relabeling but
> also for e.g. modules (requires templating that would go beyond even
> simple interfaces).
> 

I wonder too. I think that we need a means to create limited-privilege
login sessions and control movement between privileged domains (and
related domains through transitions). This can be done with much of the
current role infrastructure (see Dan's work on guest_t and xguest_t). We
can keep the process domains without instantiating corresponding file
types.

However, the problem with the current per-role templates is that they
are instantiated for _every_ role, which is clearly wrong for certain
types of locked-down roles. If I want a git-role that only allows a user
to login to a bash shell, execute git, and read / write certain file
types having a git_firefox_t is not desirable.

> genhomedircon does serve another purpose, btw - setting the SELinux user
> identity for the user's home directory.  So if you want to do separation
> based on SELinux user via constraints, you still need a mechanism for
> getting the user home directories to have the right SELinux user
> identity.
>   

I have two suggestions (which may be totally off-base):

1) Remove the selinux user concept entirely and merge it with the DAC
user identities. We would simply preserve the role authorizations and
allow constraints on the dac users (there are some interesting details
in there I know). The constraints could be limited to user equality /
inequality and not refer to specific users to simplify things.

2) The above separated file contexts that allow mapping of only the user
portion to a regex. This would allow us to have admin specified mappings
of users, but default to the same user. I'm hesitant about this one -
remember part of the problem is that we don't want to enumerate every
user in an LDAP database to do file system labeling.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
