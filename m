From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil>  <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil> <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> <22702.1161878644@redhat.com> <24017.1161882574@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, aviro@redhat.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
Date: Fri, 27 Oct 2006 15:41:50 +0100
Message-ID: <27450.1161960110@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> When the daemon writes the context value (a string) to the cachefiles
> module interface for a given cache, the cachefiles module would do
> something like the following:

What would such a context value look like?  I don't really know much about
configuring SELinux.  Would it just be the name of a security label?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
