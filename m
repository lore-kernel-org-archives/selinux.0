Date: Wed, 30 Oct 2002 08:23:58 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Brian May <bam@snoopy.apana.org.au>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel warning
In-Reply-To: <20021029230748.GA9936@snoopy.apana.org.au>
Message-ID: <Pine.GSO.4.33.0210300819100.26525-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 30 Oct 2002, Brian May wrote:

> It appears that with this patch, it is no longer possible to
> compile the patched kernel without SE-LINUX support.
>
> Maybe the call to selinux_init() in main.c needs
> to be wrapped with #ifdef CONFIG_SECURITY_SELINUX?

You would only apply this patch if you intend to use SELinux, so it is
implicit that SELinux is going to be enabled.  We could #ifdef it, but I'm
not sure what the point is.  Now, if a generalized form of early
initialization is added to the LSM patch, then this would go away and the
SELinux-specific code would be hidden.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
