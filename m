Subject: Re: [PATCH] invalid memory allocation in policydb_index_others()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "J. Tang" <jtang@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1203436124.31208.9.camel@venom.columbia.tresys.com>
References: <1203436124.31208.9.camel@venom.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 14:42:11 -0500
Message-Id: <1203450131.9902.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-19 at 10:48 -0500, J. Tang wrote:
> There is an error in libsepol's policydb_index_others().  If a policy
> is lacking symbols of some kind (e.g., a policy with no booleans),
> then the function will attempt a calloc() of 0, which is undefined.
> The following patch checks for this condition and explicitly sets the
> field upon zero symbols.

IIUC, this doesn't manifest under glibc since it returns a non-NULL
pointer that can be later free'd without error, but could create a
problem for other C libraries (e.g. uclibc) that may instead return
NULL, producing an error return here.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> Index: libsepol/src/policydb.c
> ===================================================================
> --- libsepol/src/policydb.c	(revision 2804)
> +++ libsepol/src/policydb.c	(working copy)
> @@ -820,14 +820,16 @@
>  	cond_init_bool_indexes(p);
>  
>  	for (i = SYM_ROLES; i < SYM_NUM; i++) {
> -		if (p->sym_val_to_name[i])
> -			free(p->sym_val_to_name[i]);
> -		p->sym_val_to_name[i] = (char **)
> -		    calloc(p->symtab[i].nprim, sizeof(char *));
> -		if (!p->sym_val_to_name[i])
> -			return -1;
> -		if (hashtab_map(p->symtab[i].table, index_f[i], p))
> -			return -1;
> +		free(p->sym_val_to_name[i]);
> +		p->sym_val_to_name[i] = NULL;
> +		if (p->symtab[i].nprim) {
> +			p->sym_val_to_name[i] = (char **)
> +			    calloc(p->symtab[i].nprim, sizeof(char *));
> +			if (!p->sym_val_to_name[i])
> +				return -1;
> +			if (hashtab_map(p->symtab[i].table, index_f[i], p))
> +				return -1;
> +		}
>  	}
>  
>  	/* This pre-expands the roles and users for context validity checking */
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
