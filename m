Subject: Re: PATCH: print module magic in hex, not decimal on mismatch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200711292203.lATM3PBv024990@cadmus.columbia.tresys.com>
References: <200711292203.lATM3PBv024990@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 30 Nov 2007 09:56:44 -0500
Message-Id: <1196434604.10720.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-29 at 17:03 -0500, Todd C. Miller wrote:
> Print the module magic number in hex, not decimal if there is a mismatch,
> just like we do for policydb magic number.  Since the magic defines are
> in hex the output should be as well for easier debugging.
> 
> Signed-off-by: Todd C. Miller <tmiller@tresys.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will (want to be added to the committers?).

> 
> --
> 
> Index: trunk/libsepol/src/module.c
> ===================================================================
> --- trunk/libsepol/src/module.c	(revision 2690)
> +++ trunk/libsepol/src/module.c	(working copy)
> @@ -371,7 +371,7 @@
>  	}
>  	if (le32_to_cpu(buf[0]) != SEPOL_MODULE_PACKAGE_MAGIC) {
>  		ERR(file->handle,
> -		    "wrong magic number for module package:  expected %u, got %u",
> +		    "wrong magic number for module package:  expected %#08x, got %#08x",
>  		    SEPOL_MODULE_PACKAGE_MAGIC, le32_to_cpu(buf[0]));
>  		goto err;
>  	}
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
