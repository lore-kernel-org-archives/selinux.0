Subject: Re: [patch] libsepol write.c has shadowed var
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48529591.90806@manicmethod.com>
References: <48529591.90806@manicmethod.com>
Content-Type: text/plain
Date: Fri, 13 Jun 2008 12:25:35 -0400
Message-Id: <1213374335.17842.356.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-06-13 at 11:43 -0400, Joshua Brindle wrote:
> This patch addresses a shadowed var that prevents libsepol from being built with DEBUG=1
> 
> Signed-off-by: Joshua Brindle <method@manicmethod.com>
> 
> ---
> 
> Index: libsepol/src/write.c
> ===================================================================
> --- libsepol/src/write.c	(revision 2908)
> +++ libsepol/src/write.c	(working copy)
> @@ -1625,10 +1625,10 @@
>  	if (p->policyvers < POLICYDB_VERSION_PERMISSIVE &&
>  	    p->policy_type == POLICY_KERN) {
>  		ebitmap_node_t *tnode;
> -		unsigned int i;
> +		unsigned int j;
>  
> -		ebitmap_for_each_bit(&p->permissive_map, tnode, i) {
> -			if (ebitmap_node_get_bit(tnode, i)) {
> +		ebitmap_for_each_bit(&p->permissive_map, tnode, j) {
> +			if (ebitmap_node_get_bit(tnode, j)) {
>  				WARN(fp->handle, "Warning! Policy version %d cannot "
>  				     "support permissive types, but some were defined",
>  				     p->policyvers);

Any particular reason we can't just use the local var from the outer
scope?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
