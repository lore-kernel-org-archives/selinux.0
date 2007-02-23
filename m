Subject: Re: [RFC] Drop setlocaldefs support from trunk (2.x series)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <45DE10D4.3030107@mentalrootkit.com>
References: <1172162502.14363.446.camel@moss-spartans.epoch.ncsc.mil>
	 <45DE10D4.3030107@mentalrootkit.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 08:28:55 -0500
Message-Id: <1172237335.19041.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-22 at 16:53 -0500, Karl MacMillan wrote:
> Stephen Smalley wrote:
> > Hi,
> > 
> > With the migration to libsemanage and managed policy, the setlocaldefs
> > support in libselinux and underlying support in libsepol for parsing
> > local booleans and users files is obsolete in modern SELinux
> > distributions.  Ideally, I'd like to drop it out entirely from the trunk
> > (2.x series), while preserving it on the stable branch (1.x series).
> > Specifically, this would mean:
> > - Removing setlocaldefs support from libselinux,
> > - Removing sepol_genusers and sepol_genbools and their internal logic
> > from libsepol, including the legacy config file parsers there.
> > sepol_genbools_array() would remain due to its use for preserving
> > actives booleans upon policy reload, but it doesn't require the config
> > file parser.
> > 
> 
> That's fine with me, though I question whether the config parsers might 
> not be better in libsepol than in libsemanage.

Here we are talking about config parsers for the local booleans file and
local user definitions, all of which now live in libsemanage and are
private to it.  Not config parsers for the base policy per se.

Also, in addition to libsepol interfaces, this would also affect the
following libselinux interfaces:
- security_set_boolean_list() - the interface would remain, but the
permanent=1 flag would no longer be supported since the only correct way
to set permanent booleans going forward would be via managed policy,
- security_load_booleans() - AFAICS, this interface hasn't been used for
a long time, ever since we introduced support for patching the boolean
values into the binary policy image at load time, so I think it can be
removed altogether.
Thus, the local booleans file manipulation in libselinux would also go
away, and it would only deal with the /selinux/booleans manipulation.

> > We have different options for handling the libsepol changes, e.g.:
> > - We could retain stub functions for the interfaces that call WARN() and
> > return an error immediately, and possibly version the map file so that
> > they are only exported to legacy binaries.  In this case, legacy
> > binaries should already have logic to fall back to the original policy
> > image as these calls can fail for other reasons, so you'd just end up
> > with the base policy without any local boolean or user definitions
> > applied.
> > - We could remove the interfaces altogether, requiring a change to the
> > shared library version.
> > 
> > This would affect e.g. the ability to install the trunk versions on an
> > older distribution like RHEL 4, which predates libsemanage and managed
> > policy support.
> > 
> 
> Either way we are breaking binary compatibility in a way. Even though 
> the stubs allow the existing binaries to work, the behavior is certainly 
> changed.
> 
> I understood that we were going to try to maintain binary compatibility, 
> but that seems like it is going to be difficult to do while making 
> needed cleanups. I'm not opposed to bumping the library version, but I 
> think that we should think about how to do this cleanly. If nothing 
> else, we should have a plan so that we get all of the symbol removals / 
> renames done in a single user visible version update.

Yes, this is just the first of many RFCs.  The actual patches can wait a
bit.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
