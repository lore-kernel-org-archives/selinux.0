Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        chrisw@sous-sol.org, jmorris@namei.org
In-Reply-To: <27450.1161960110@redhat.com>
References: <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil>
	 <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil>
	 <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil>
	 <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <8567.1161859255@redhat.com>
	 <22702.1161878644@redhat.com> <24017.1161882574@redhat.com>
	 <27450.1161960110@redhat.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 11:03:35 -0400
Message-Id: <1161961415.1306.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 15:41 +0100, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > When the daemon writes the context value (a string) to the cachefiles
> > module interface for a given cache, the cachefiles module would do
> > something like the following:
> 
> What would such a context value look like?  I don't really know much about
> configuring SELinux.  Would it just be the name of a security label?

Yes, just a string.  Same kinds of values that you would see from ls -Z
output.

Now, the particular values would be policy-dependent, so you might want
to push those definitions into a separate config file maintained in the
policy, similar to /etc/selinux/$SELINUXTYPE/contexts/dbus_contexts and
the like.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
