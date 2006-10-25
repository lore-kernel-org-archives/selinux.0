Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <james.antill@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, "GeorgeC.Wilson" <ltcgcw@us.ibm.com>,
        selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <1161620097.667.10.camel@code.and.org>
	 <1161722236.667.20.camel@code.and.org>
	 <1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 08:22:17 -0400
Message-Id: <1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-25 at 07:48 -0400, Stephen Smalley wrote:
> On Tue, 2006-10-24 at 16:37 -0400, James Antill wrote:
> > On Mon, 2006-10-23 at 12:14 -0400, James Antill wrote:
> > > On Thu, 2006-10-19 at 09:30 -0400, Stephen Smalley wrote:
> > > > pam_selinux used to have support to let the user pick from the list of
> > > > reachable contexts for the user.  So you could just restore that
> > > > support.
> > >
> > >  So, in summary of the discussion, having pam_selinux let the user pick
> > > the TE and Sensitivity separately (much as it does now if
> > > get_ordered_context_list_with_level() fails) is the valid approach?
> > 
> >  Ok, I've done a patch to PAM which which adds a config_role option to
> > the pam_selinux module ... which if turned on takes the users default
> > context and allows them to change the role and/or level (if mls is
> > enabled). Entering a blank line sticks with the default.
> > 
> >  It's available from:
> > 
> > http://people.redhat.com/jantill/pam-config_role/
> > 
> > ...the rpms there have been built on FC5.
> 
> Doesn't this provide a way of bypassing the per-Linux-user level
> restrictions defined by the seusers mapping (vs. per-SELinux-user)?

To elaborate, as I understood it, seusers (managed via semanage login)
was to provide per-Linux-user authorizations for MLS/MCS ranges, while
multiple such Linux users might be mapped to a single SELinux user that
was authorized for the full system range.  The login-style programs
would then ensure that the range in the initial security context for the
Linux user's session was limited by the value defined in seusers, and
SELinux policy would subsequently ensure that processes in that session
can not escalate outside of that range via newrole -l (or other
mechanism).

It isn't sufficient to check the validity of the context with the
user-supplied level, because from the kernel's POV, any level might be
authorized for the underlying SELinux user identity, whereas seusers
might have defined a more restricted range for the Linux user identity.
You need a check between the user-supplied level and the seusers-defined
value (more generally, this could be an avc_has_perm or
security_compute_av check between contexts containing those levels, and
the underlying policy could define a mlsconstrain on the corresponding
permission). 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
