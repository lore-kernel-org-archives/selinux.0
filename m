Message-ID: <45DE10D4.3030107@mentalrootkit.com>
Date: Thu, 22 Feb 2007 16:53:24 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [RFC] Drop setlocaldefs support from trunk (2.x series)
References: <1172162502.14363.446.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172162502.14363.446.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Hi,
> 
> With the migration to libsemanage and managed policy, the setlocaldefs
> support in libselinux and underlying support in libsepol for parsing
> local booleans and users files is obsolete in modern SELinux
> distributions.  Ideally, I'd like to drop it out entirely from the trunk
> (2.x series), while preserving it on the stable branch (1.x series).
> Specifically, this would mean:
> - Removing setlocaldefs support from libselinux,
> - Removing sepol_genusers and sepol_genbools and their internal logic
> from libsepol, including the legacy config file parsers there.
> sepol_genbools_array() would remain due to its use for preserving
> actives booleans upon policy reload, but it doesn't require the config
> file parser.
> 

That's fine with me, though I question whether the config parsers might 
not be better in libsepol than in libsemanage.

> We have different options for handling the libsepol changes, e.g.:
> - We could retain stub functions for the interfaces that call WARN() and
> return an error immediately, and possibly version the map file so that
> they are only exported to legacy binaries.  In this case, legacy
> binaries should already have logic to fall back to the original policy
> image as these calls can fail for other reasons, so you'd just end up
> with the base policy without any local boolean or user definitions
> applied.
> - We could remove the interfaces altogether, requiring a change to the
> shared library version.
> 
> This would affect e.g. the ability to install the trunk versions on an
> older distribution like RHEL 4, which predates libsemanage and managed
> policy support.
> 

Either way we are breaking binary compatibility in a way. Even though 
the stubs allow the existing binaries to work, the behavior is certainly 
changed.

I understood that we were going to try to maintain binary compatibility, 
but that seems like it is going to be difficult to do while making 
needed cleanups. I'm not opposed to bumping the library version, but I 
think that we should think about how to do this cleanly. If nothing 
else, we should have a plan so that we get all of the symbol removals / 
renames done in a single user visible version update.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
