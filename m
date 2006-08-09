Subject: Re: [RFC 3/3] expander support for hooks
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Josh Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <1154433128.23513.10.camel@twoface.columbia.tresys.com>
References: <1154433128.23513.10.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 17:59:09 -0400
Message-Id: <1155160749.942.117.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 07:52 -0400, Josh Brindle wrote:
> These are the expander changes, some hooks aren't implemented yet so it
> is marked with an XXX comment where I think the enforcement needs to
> go. 

> diff -pruN -xhooks.c trunk-old/libsepol/include/sepol/policydb/policydb.h trunk/libsepol/include/sepol/policydb/policydb.h
> --- trunk-old/libsepol/include/sepol/policydb/policydb.h	2006-08-01 07:27:29.000000000 -0400
> +++ trunk/libsepol/include/sepol/policydb/policydb.h	2006-08-01 07:17:00.000000000 -0400
> @@ -115,6 +115,8 @@ typedef struct role_datum {
>  	ebitmap_t dominates;	/* set of roles dominated by this role */
>  	type_set_t types;	/* set of authorized types for role */
>  	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
> +	type_set_t all_types;	/* used during policy access control check */
> +	ebitmap_t all_doms;	/* used during policy access control check */
>  } role_datum_t;
>  
>  typedef struct role_trans {
> @@ -139,6 +141,7 @@ typedef struct type_datum {
>  #define TYPE_ALIAS 2		/* alias in modular policy */
>  	uint32_t flavor;
>  	ebitmap_t types;	/* types with this attribute */
> +	ebitmap_t all_types;	/* used during policy access control check */
>  } type_datum_t;
>  
>  /* User attributes */
> @@ -148,6 +151,7 @@ typedef struct user_datum {
>  	mls_range_t range;	/* MLS range (min. - max.) for user */
>  	mls_level_t dfltlevel;	/* default login MLS level for user */
>  	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
> +	role_set_t all_roles;	/* used during policy access control check */
>  } user_datum_t;
>  

These changes are what I am most concerned about and I don't think that
they are necessary. For the "other" policy expand all can simply expand
into the existing fields (e.g., role_datum->types can hold all of the
authorized types even those for disabled optionals).

For the current policy, you can make the expander walk all of the
optional blocks calling the hooks but _not_ storing the results for the
non-active options.

The downside is that some hooks will be called multiple times, but I
think that the reduction in changes is worth it.

Any reason this won't work?

>  /* Sensitivity attributes */
> @@ -374,6 +378,12 @@ typedef struct policydb {
>  	/* Whether this policydb is mls, should always be set */
>  	int mls;
>  
> +	/* Whether this is an invalid policy, currently set when EXPAND_ALL
> +	 * is passed to the expander to prevent this policy from being written
> +	 * to disk. 
> +	 */
> +	int invalid;
> +

No comment :)

I'll leave any more specific comments until I hear back about my general
comments.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
