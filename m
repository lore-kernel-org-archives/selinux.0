Date: Mon, 14 Oct 2002 10:46:12 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: $1_cupsd_spool_t in lpr_macros.te
In-Reply-To: <200210111402.OAA16330@jazzband.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0210141045370.25372-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 11 Oct 2002, Carsten Grohmann wrote:

> The attached patch is again the actuell CVS state. It change lpd_spool_t
> and cupsd_spool_t to print_spool_t.

Thanks, merged.

> I think it is better to rename printer_port_t in lpd.te to lpd_port_t --
> it's more intuitive. Or?

Doesn't matter to me.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
