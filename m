Date: Wed, 28 Aug 2002 17:26:19 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: IP Networking Support
In-Reply-To: <200208282119.RAA19417@sentry.gw.tislabs.com>
Message-ID: <Pine.GSO.4.33.0208281722160.25057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 28 Aug 2002, Carsten Grohmann wrote:

> The general README writes we should use "IP Networking Support" in the
> kernel. But I don't found this option. It is removed from the kernel? Then
> we could change the README too.

Yes, good call.  The LSM Netfilter-based IP hooks were removed, so this
Security option went away.  The SELinux module now directly registers its
NetFilter hooks.  These changes were made by James Morris, and discussed
on the linux-security-module list.  We'll update the README.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
