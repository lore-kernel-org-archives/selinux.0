Subject: Re: [PATCH] Load the initial SIDs upon every policy load
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1265150181.3605.23.camel@tesla.lan>
References: <1265150181.3605.23.camel@tesla.lan>
Content-Type: text/plain
Date: Wed, 03 Feb 2010 10:58:55 -0500
Message-Id: <1265212735.12805.9.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-02 at 23:36 +0100, Guido Trentalancia wrote:
> Stephen,
> 
> attached please find the tiny patch for always loading the initial SIDs.
> Should I say "for review" ? It relies on SECINITSID_NUM which at the
> moment is statically defined in flask.h (and represents the maximum
> initial SID).

Normally you'd put [RFC] in the Subject line to indicate for review
only, not for committing yet.  No big deal though.

> 
> Author: Guido Trentalancia <guido@trentalancia.com>
> Date:   Mon Feb 02 22:11:05 2010 +0100
> 
>     Always load the initial SIDs, even in the case of a policy
>     reload and not just at the initial policy load. This comes
>     particularly handy after the introduction of a recent
>     patch for enabling runtime switching between different
>     policy types, although this patch is in theory independent
>     from that feature.
> 
>     Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> 
> ---
> 
>  security/selinux/ss/services.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> --- security-testing-2.6/security/selinux/ss/services.c	2010-01-29 02:02:47.742042805 +0100
> +++ security-testing-2.6-isids/security/selinux/ss/services.c	2010-02-02 22:09:47.809993219 +0100
> @@ -1712,9 +1718,9 @@ int security_load_policy(void *data, siz
>  	if (policydb_read(&newpolicydb, fp))
>  		return -EINVAL;
>  
> -	if (sidtab_init(&newsidtab)) {
> +	if (policydb_load_isids(&newpolicydb, &newsidtab)) {
>  		policydb_destroy(&newpolicydb);
> -		return -ENOMEM;
> +		return -EINVAL;
>  	}
>  
>  	if (selinux_set_mapping(&newpolicydb, secclass_map,

One minor nit:  Given that policydb_load_isids() may fail with either
ENOMEM (sidtab_init failure) or EINVAL, you need to save the return code
from it and return that instead of always returning EINVAL.

Otherwise, looks good - have you tested it?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
