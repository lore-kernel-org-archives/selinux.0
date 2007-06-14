Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <Line.LNX.4.64.0706141250100.18953@localhost.localdomain>
References: <C296D9C6.23423%csellers@tresys.com>
	 <1181836512.17547.640.camel@moss-spartans.epoch.ncsc.mil>
	 <1181836985.17547.645.camel@moss-spartans.epoch.ncsc.mil>
	 <Line.LNX.4.64.0706141250100.18953@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 13:46:17 -0400
Message-Id: <1181843177.17547.667.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-14 at 12:52 -0400, James Morris wrote:
> On Thu, 14 Jun 2007, Stephen Smalley wrote:
> 
> > +	if (selinux_enforcing) {
> > +		rc = avc_has_perm_noaudit(sid, sid, SECCLASS_CAP_OVERRIDE,
> > +					  CAP_TO_MASK(cap), AVC_STRICT, NULL);
> > +		if (!rc)
> > +			goto out;
> 
> I wonder if this will break applications now -- if their suid bit is 
> removed, and SELinux authoritatively grants capabilities, they'll just 
> stop working in permissive mode.

True.  A similar issue arises of course in the selinux=0 case, although
there at least we could have some sort of install-time logic to decide
whether to strip suid bits or not based on whether selinux was enabled
w/suitable policy or disabled.  But I suppose it is more crucial for
permissive mode due to its use as a temporary state for policy
generation or recovery.  Of course, our ultimate goal is to get to the
point where permissive mode is completely unnecessary, i.e. adequate
tools exist that users can always recover or generate policy without
needing to go permissive.  Or possibly per-process or per-domain
permissive mode becomes more attractive in light of these kinds of
concerns.

In the short term though, I don't expect distros to make a wholesale
removal of suid bits, whether for this support or for file capabilities
support.  It would tend to get used incrementally by newer developments,
and possibly retroactively applied by security-oriented specialized
distros and custom built ones (which tend to disable permissive mode and
selinux=disabled altogether in their kernel configs).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
