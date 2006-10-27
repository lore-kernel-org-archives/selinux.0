Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        chrisw@sous-sol.org, jmorris@namei.org
In-Reply-To: <5318.1161965576@redhat.com>
References: <1161961415.1306.4.camel@moss-spartans.epoch.ncsc.mil>
	 <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil>
	 <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil>
	 <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil>
	 <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <8567.1161859255@redhat.com>
	 <22702.1161878644@redhat.com> <24017.1161882574@redhat.com>
	 <27450.1161960110@redhat.com>   <5318.1161965576@redhat.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 12:37:58 -0400
Message-Id: <1161967078.1306.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 17:12 +0100, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > > What would such a context value look like?  I don't really know much about
> > > configuring SELinux.  Would it just be the name of a security label?
> > 
> > Yes, just a string.  Same kinds of values that you would see from ls -Z
> > output.
> 
> So I would have something like this?:
> 
> 	[/etc/cachefilesd.conf]
> 	dir /var/fscache
> 	uid 123
> 	gid 456
> 	seclabel system_u:object_r:cachefiles_t:s0

Yes, assuming that type is defined in policy as a file type (and
assuming that you keep it in this config file vs. splitting it out as
below).  You may wish to run the context through
selinux_trans_to_raw_context() before feeding it to the kernel so that
people can specify the more human-readable form of a MLS/MCS label in
the config file, or even omit the :s0 altogether in the MCS case.

> > Now, the particular values would be policy-dependent, so you might want
> > to push those definitions into a separate config file maintained in the
> > policy, similar to /etc/selinux/$SELINUXTYPE/contexts/dbus_contexts and
> > the like.
> 
> I'm not sure how to do that or how it works:-/

The issue with directly encoding the context in
your /etc/cachefilesd.conf file is that the context may vary depending
on your security policy.  For example, the default targeted policy in
Fedora may use one context, while the optional strict or mls policies
may use a different context, and even the format of the context may vary
(e.g. MCS/MLS enables the last field).  Putting it directly in your
config file also makes it harder to easily see (and thus analyze) all
policy-related data together.  Various config files have been created
under /etc/selinux/$SELINUXTYPE/contexts with these kinds of contexts,
and applications have been extended to either read them directly or use
a libselinux interface for getting them.  This directly ties in with the
recent and ongoing separate thread on "User object manager context
location" on selinux list.

On the other hand, creating a separate config file makes adding/removing
cache definitions more involved, as you then have to update multiple
config files.

I also assume that if you ran multiple instances of the daemon, you
would run each with its own conf file?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
