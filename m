Subject: Re: [patch 2/2] Peersid capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, paul.moore@hp.com
In-Reply-To: <20071107205333.697495852@manicmethod.com>
References: <20071107205047.102519666@manicmethod.com>
	 <20071107205333.697495852@manicmethod.com>
Content-Type: text/plain
Date: Wed, 07 Nov 2007 16:07:14 -0500
Message-Id: <1194469634.3956.174.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-11-07 at 15:50 -0500, Joshua Brindle wrote:
> plain text document attachment (peersid_cap.patch)
> Peersid capability support, keys the peersid capability on the peer object class.

I'm uneasy about this approach, as it is similar to what we originally
tried for secmark - tying the compat_net setting to the presence of the
packet class in the policy, except there we were doing it at policy load
time.  As it turned out, we had policies that defined the packet class
well before we had usable rule sets for them, and even if we had covered
that angle, presence/absence of a class definition doesn't reflect
policy writer intent (e.g. does he want legacy network controls or
secmark irrespective of whether he is using a modern policy), so we went
back to manual setting of compat_net.

What if the base.conf / policy.conf itself had an explicit declaration
of the capabilities to be enabled?  We can certainly do sanity checks
too (e.g. if they ask for this capability but haven't defined the
requisite class, that's a bug in their policy), but that would let
someone use the latest policy flask definitions but still select what
they want to enable/disable explicitly, and no unwitting enabling of
capabilities by side effect.

> 
> ---
>  libsepol/src/polcaps.c |   26 ++++++++++++++++++++++++++
>  libsepol/src/polcaps.h |    8 ++++++++
>  libsepol/src/write.c   |    3 +++
>  3 files changed, 37 insertions(+)
> 
> --- /dev/null
> +++ trunk/libsepol/src/polcaps.c
> @@ -0,0 +1,26 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +
> +#include <sepol/policydb/policydb.h>
> +#include "polcaps.h"
> +
> +int sepol_setup_capabilities(policydb_t *pol)
> +{
> +
> +	if (!pol)
> +		return POLICYDB_ERROR;
> +
> +	/* Each capability should be keyed in some way, 
> +	 * such as the existance of an object class */
> +
> +	/* POLICYDB_CAPABILITY_NETPEER */
> +	if (hashtab_search(pol->symtab[SYM_CLASSES].table, "peer")) {
> +		if (ebitmap_set_bit(&pol->policycaps, 
> +				POLICY_CAPABILITY_NETPEER, 1))
> +			return POLICYDB_ERROR;
> +	}
> +
> +	return POLICYDB_SUCCESS;
> +
> +}
> --- /dev/null
> +++ trunk/libsepol/src/polcaps.h
> @@ -0,0 +1,8 @@
> +#ifndef _SEPOL_INTERNAL_POLCAP_H_
> +#define _SEPOL_INTERNAL_POLCAP_H_
> +
> +extern int sepol_setup_capabilities(policydb_t *pol);
> +
> +#define POLICY_CAPABILITY_NETPEER 1
> +
> +#endif
> --- trunk.orig/libsepol/src/write.c
> +++ trunk/libsepol/src/write.c
> @@ -44,6 +44,7 @@
>  #include "debug.h"
>  #include "private.h"
>  #include "mls.h"
> +#include "polcaps.h"
>  
>  struct policy_data {
>  	struct policy_file *fp;
> @@ -1577,6 +1578,8 @@ int policydb_write(policydb_t * p, struc
>  		return POLICYDB_ERROR;
>  
>  	if (p->policyvers >= POLICYDB_VERSION_POLCAP) {
> +		if (sepol_setup_capabilities(p))
> +			return POLICYDB_ERROR;
>  		if (ebitmap_write(&p->policycaps, fp) == -1)
>  			return POLICYDB_ERROR;
>  	}
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
