Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        chrisw@sous-sol.org, jmorris@namei.org
In-Reply-To: <7319.1161970091@redhat.com>
References: <1161967078.1306.61.camel@moss-spartans.epoch.ncsc.mil>
	 <1161961415.1306.4.camel@moss-spartans.epoch.ncsc.mil>
	 <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil>
	 <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil>
	 <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil>
	 <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <8567.1161859255@redhat.com>
	 <22702.1161878644@redhat.com> <24017.1161882574@redhat.com>
	 <27450.1161960110@redhat.com> <5318.1161965576@redhat.com>
	 <7319.1161970091@redhat.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 14:10:28 -0400
Message-Id: <1161972628.1306.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 18:28 +0100, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > Yes, assuming that type is defined in policy as a file type (and assuming
> > that you keep it in this config file vs. splitting it out as below).
> 
> So those files in /etc/selinux/.../contexts/ are config files for use by
> applications to detail their security settings?

Yes, essentially (s/detail/discover/).

> > You may wish to run the context through selinux_trans_to_raw_context() before
> > feeding it to the kernel
> 
> I assume you mean a userspace function, but:
> 
> 	warthog>man selinux_trans_to_raw_context
> 	No manual entry for selinux_trans_to_raw_context

Sorry, no man page at present, but the function does exist.
#include <selinux/selinux.h>

> > so that people can specify the more human-readable form of a MLS/MCS label
> > in the config file, or even omit the :s0 altogether in the MCS case.
> 
> What is the more human-readable form?

There is a mapping of the s0:c0,c1-style notation to human-readable
labels like "Unclassified" or "NDA_IBM_01012038".  The rest of the
context isn't presently translated, just the last component.

> > and applications have been extended to either read them directly
> 
> Is there a particular format for these files?

Not a common one, no.  That's also being discussed in that other thread
I mentioned.

> > or use a libselinux interface for getting them.
> 
> Which would be what?

You'd have to introduce one for your new config, as there isn't yet a
common interface (also under discussion).  matchpathcon(3) is the
interface for obtaining the install-time file context to apply for a
given pathname.  In other cases, applications have been directly parsing
their own config files, but I think that will change (again, that other
thread).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
