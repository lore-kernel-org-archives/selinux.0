From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161961415.1306.4.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161961415.1306.4.camel@moss-spartans.epoch.ncsc.mil>  <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil> <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil> <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> <22702.1161878644@redhat.com> <24017.1161882574@redhat.com> <27450.1161960110@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov, chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
Date: Fri, 27 Oct 2006 17:12:56 +0100
Message-ID: <5318.1161965576@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > What would such a context value look like?  I don't really know much about
> > configuring SELinux.  Would it just be the name of a security label?
> 
> Yes, just a string.  Same kinds of values that you would see from ls -Z
> output.

So I would have something like this?:

	[/etc/cachefilesd.conf]
	dir /var/fscache
	uid 123
	gid 456
	seclabel system_u:object_r:cachefiles_t:s0
	tag mycache
	brun 17%
	bcull 13%
	bstop 3%
	frun 10%
	fcull 7%
	fstop 3%

> Now, the particular values would be policy-dependent, so you might want
> to push those definitions into a separate config file maintained in the
> policy, similar to /etc/selinux/$SELINUXTYPE/contexts/dbus_contexts and
> the like.

I'm not sure how to do that or how it works:-/

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
