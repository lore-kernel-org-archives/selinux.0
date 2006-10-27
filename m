From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161967078.1306.61.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161967078.1306.61.camel@moss-spartans.epoch.ncsc.mil>  <1161961415.1306.4.camel@moss-spartans.epoch.ncsc.mil> <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil> <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil> <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> <22702.1161878644@redhat.com> <24017.1161882574@redhat.com> <27450.1161960110@redhat.com> <5318.1161965576@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov, chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
Date: Fri, 27 Oct 2006 18:28:11 +0100
Message-ID: <7319.1161970091@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Yes, assuming that type is defined in policy as a file type (and assuming
> that you keep it in this config file vs. splitting it out as below).

So those files in /etc/selinux/.../contexts/ are config files for use by
applications to detail their security settings?

> You may wish to run the context through selinux_trans_to_raw_context() before
> feeding it to the kernel

I assume you mean a userspace function, but:

	warthog>man selinux_trans_to_raw_context
	No manual entry for selinux_trans_to_raw_context

> so that people can specify the more human-readable form of a MLS/MCS label
> in the config file, or even omit the :s0 altogether in the MCS case.

What is the more human-readable form?

> > > Now, the particular values would be policy-dependent, so you might want
> > > to push those definitions into a separate config file maintained in the
> > > policy, similar to /etc/selinux/$SELINUXTYPE/contexts/dbus_contexts and
> > > the like.
> > 
> > I'm not sure how to do that or how it works:-/
> 
> The issue with directly encoding the context in your /etc/cachefilesd.conf
> file is that the context may vary depending on your security policy.

Okay; that seems reasonable.

> ... Various config files have been created under
> /etc/selinux/$SELINUXTYPE/contexts with these kinds of contexts,

I see how it works.

> and applications have been extended to either read them directly

Is there a particular format for these files?

> or use a libselinux interface for getting them.

Which would be what?

> On the other hand, creating a separate config file makes adding/removing
> cache definitions more involved, as you then have to update multiple
> config files.

Yeah, but we can probably live with that.  It might be worth using the cache
tag name or the cache directory as a key to look up the security rather than
the location of the config file.

> I also assume that if you ran multiple instances of the daemon, you
> would run each with its own conf file?

That's the current plan, yes.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
