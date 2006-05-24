Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremy Katz <katzj@redhat.com>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
        Paul Nasrat <pnasrat@redhat.com>
In-Reply-To: <1148491493.16558.42.camel@orodruin.boston.redhat.com>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <20060517075435.GB7665@thorium.jmh.mhn.de>
	 <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
	 <20060518181452.GA4935@thorium2.jmh.mhn.de>
	 <1148043593.25168.71.camel@moss-spartans.epoch.ncsc.mil>
	 <1148044725.8647.35.camel@jackjack.columbia.tresys.com>
	 <1148404514.24463.176.camel@moss-spartans.epoch.ncsc.mil>
	 <4473531C.2010802@redhat.com>
	 <1148410219.24463.234.camel@moss-spartans.epoch.ncsc.mil>
	 <1148491493.16558.42.camel@orodruin.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 14:01:01 -0400
Message-Id: <1148493661.24463.492.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-24 at 13:24 -0400, Jeremy Katz wrote:
> On Tue, 2006-05-23 at 14:50 -0400, Stephen Smalley wrote:
> > I don't think that is really a viable option.  It is undesirable from
> > both a robustness POV and a security POV.  rpm shouldn't leave the
> > filesystem littered with files that have invalid contexts (which could
> > later be turned into valid contexts by another package's policy module,
> > suddenly granting access to those files or permissions to those
> > executables unexpectedly), nor should it leave the system littered with
> > packages whose policy couldn't be installed, as the package software may
> > then run with the wrong permissions.
> 
> So the thing not covered in my other mail is "policy couldn't be
> installed" -- but what would cause that to be the case?  I'd rather make
> it so that we don't hit that (via dependencies, as I'm guessing that's
> the likely culprit) rather than trying to hack around it.

I don't think you can prevent it in general; there are many possible
failure points here, from dependency issues to policy denials to
conflicts with local policy modules created by users or third party
policy modules to resource failures (inadequate disk space for the new
policy module to be installed).  It isn't within the distro's control to
really guarantee that it will work.  I suppose a somewhat parallel
question might be how rpm handles other kinds of failures, not just from
the post scriptlets, but in setting down the files and establishing
their ownerships and modes normally.  However, that may not be a good
example, as there is no current attempt to provide a spectrum of trust
vs. an all-or-nothing situation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
