Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JK05vm015231
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 16:00:05 -0400
Subject: Re: [PATCH] avc_internal.c needs #include <linux/types.h> for rhel4
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmill@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588A71731@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588A71731@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 16:00:04 -0400
Message-Id: <1177012804.27654.254.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 13:56 -0400, Joshua Brindle wrote:
> Apparently RHEL4 needs #include <linux/types.h> in avc_internal.c in
> order to compile. This should be applied to trunk and stable.
> 
> ===================================================================
> --- libselinux/src/avc_internal.c       (revision 2357)
> +++ libselinux/src/avc_internal.c       (working copy)
> @@ -17,6 +17,7 @@
>  #include <string.h>
>  #include <sys/types.h>
>  #include <sys/socket.h>
> +#include <linux/types.h>
>  #include <linux/netlink.h>
>  #include "selinux_netlink.h"
>  #include "avc_internal.h"

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
