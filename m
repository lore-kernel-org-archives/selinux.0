Date: Wed, 30 Oct 2002 14:54:24 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Kerry Thompson <kerry@crypt.gen.nz>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: kernel warning
In-Reply-To: <55267.202.6.84.11.1036007034.squirrel@www.crypt.gen.nz>
Message-ID: <Pine.GSO.4.33.0210301450010.12970-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 31 Oct 2002, Kerry Thompson wrote:

> The 'Everything in one Part' download at
> http://www.nsa.gov/selinux/archives/lsm-2.4-selinux-2002102211.tgz doesn't
> seem to have this patch included, and the NSA site isn't very clear that
> the patch is required. Could we please have the patch added to the next
> all-in-one snapshot?

The separate SELinux-specific patch is in that archive.  If you expand the
archive, you'll find it in selinux/module/selinux-2.4.patch.  If you
follow the installation instructions in selinux/README, that patch will be
applied to the lsm-2.4 tree prior to building the kernel.  The only change
from the prior release with regard to this issue was that the patch file
was renamed from lsm-2.4.patch to selinux-2.4.patch for clarity and the
set of changes within the patch have increased.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
