Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k71CHxcd020904
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 08:17:59 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k71CHnXQ026024
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 12:17:49 GMT
Message-ID: <44CF467A.5080003@tresys.com>
Date: Tue, 01 Aug 2006 08:18:02 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] Introduce symtab_datum_t
References: <1154357404.26550.79.camel@localhost.localdomain>
In-Reply-To: <1154357404.26550.79.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> This patch cleans up a cast in module_compiler.c to use the new
> symtab_datum_t.
>
> Karl
>
>  module_compiler.c |   12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
> index ec5fc89..3252bb7 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -137,15 +137,11 @@ int declare_symbol(uint32_t symbol_type,
>  	retval = symtab_insert(policydbp, symbol_type, key, datum,
>  			       SCOPE_DECL, decl->decl_id, dest_value);
>  	if (retval == 1) {
> -		/* because C has no polymorphism, make the
> -		 * [outrageous] assumption that the first field of all
> -		 * symbol table data is a uint32_t representing its
> -		 * value */
> -		uint32_t *v =
> -		    (uint32_t *) hashtab_search(policydbp->symtab[symbol_type].
> +		symtab_datum_t *s =
> +		    (symtab_datum_t *)hashtab_search(policydbp->symtab[symbol_type].
>  						table, key);
> -		assert(v != NULL);
> -		*dest_value = *v;
> +		assert(s != NULL);
> +		*dest_value = s->value;
>  	} else if (retval == -2) {
>  		return -2;
>  	} else if (retval < 0) {
>   
I think you missed one around line 498.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
