Date: Wed, 20 Feb 2002 08:55:52 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Metrix <metrix007@yahoo.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: 2.2 kernel series
In-Reply-To: <20020220005027.31760.qmail@web20602.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0202200838370.9757-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 19 Feb 2002, Metrix wrote:

> why develop 2.4, 2.5 even? 2.4 has had quite a lot of
> problems, most people are sticking with 2.2 in a
> production enviroment, it would seem that the 2.2
> selinux patches are not being updated, which is a
> shame. also, does selinux audit there code ala openbsd?

I don't want to get into a 2.2 vs. 2.4 debate, and it really isn't
relevant.  SELinux is focused on technology transfer to the mainstream
Linux kernel.  In that context, maintaining a 2.2-based SELinux would not
be a good use of our limited resources.  If you want to create a LSM-like
framework for the 2.2 series and back port the current SELinux kernel
module, then feel free.

No, SELinux is not about auditing Linux code.  Please read the overview
and the FAQ on the NSA SELinux web site.  SELinux is more like TrustedBSD
than OpenBSD.  This has come up previously on the list - please refer to
the mailing list archives.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
