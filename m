Date: Mon, 30 Sep 2002 08:16:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: $1_cupsd_spool_t in lpr_macros.te
In-Reply-To: <200209301021.48501.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209300814270.15004-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 30 Sep 2002, Russell Coker wrote:

> I've added such a change to my tree to make it use $1_lpr_spool_t.  Although
> it has occurred to me that perhaps the best thing to do is to remove
> cupsd_spool_t and replace it with lpd_spool_t instead.  What do you think?

Do you mean $1_lpd_spool_t?  There is no $1_lpr_spool_t in my policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
