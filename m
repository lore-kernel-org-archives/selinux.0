Date: Wed, 16 Oct 2002 10:27:17 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: initrd kernel panic
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524431@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0210161025221.14711-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 16 Oct 2002, Westerman, Mark wrote:

> When trying to use the initrd
> policy with an selinux kernel I am
> getting the following panic
>
> ss: loading policy configuration from <NULL>

This was discussed earlier on the list (see
http://marc.theaimsgroup.com/?l=selinux&m=103289179925418&w=2), and
patches were posted and committed to the sourceforge CVS tree.  It is no
longer necessary to place a policy on an initrd at all.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
