MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] checkpolicy: support for permissive types
Date: Tue, 11 Mar 2008 10:36:26 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801AD2238@exchange.columbia.tresys.com>
In-Reply-To: <1205245845.5297.90.camel@localhost.localdomain>
References: <1205245845.5297.90.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Eric Paris" <eparis@redhat.com>, "selinux" <selinux@tycho.nsa.gov>
Cc: "Todd Miller" <tmiller@tresys.com>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> This patch adds support for permissive types.
> 
> A very simple module to make httpd_t a permissive domain would be:
> 
> policy_module(permissiveapache, 1.0)
> gen_require(`
> 	type httpd_t;
> ')
> permissive httpd_t;
> 
> Obviously this syntax can be used in both the base policy and
> in a policy module.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> 

Comments below, otherwise looks fine.

> ---
> 
>  policy_parse.y |   43 +++++++++++++++++++++++++++++++  policy_scan.l
>  |    4 ++ test/dismod.c  |    2 -
>  test/dispol.c  |   78
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 125 insertions(+), 2 deletions(-)
> 
> diff -up checkpolicy-2.0.10/policy_parse.y.pre.permissive
> checkpolicy-2.0.10/policy_parse.y
> --- checkpolicy-2.0.10/policy_parse.y.pre.permissive
> 2008-03-11 10:18:31.000000000 -0400
> +++ checkpolicy-2.0.10/policy_parse.y	2008-03-11
> 10:23:33.000000000 -0400
> @@ -126,6 +126,7 @@ static int define_netif_context(void);
> static int define_ipv4_node_context(void);  static int
> define_ipv6_node_context(void);  static int define_polcap(void);
> +static int define_permissive(void);
> 
>  typedef int (* require_func_t)();
> 
> @@ -201,6 +202,7 @@ typedef int (* require_func_t)();  %token
> IPV6_ADDR  %token MODULE VERSION_IDENTIFIER REQUIRE OPTIONAL %token
> POLICYCAP +%token PERMISSIVE
> 
>  %left OR
>  %left XOR
> @@ -327,6 +329,7 @@ te_decl			: attribute_def
>                          | transition_def
>                          | range_trans_def
>                          | te_avtab_def
> +			| permissive_def
>  			;
>  attribute_def           : ATTRIBUTE identifier ';'
>                          { if (define_attrib()) return -1;}
> @@ -772,6 +775,8 @@ ipv6_addr		: IPV6_ADDR
>  policycap_def		: POLICYCAP identifier ';'
>  			{if (define_polcap()) return -1;}
>  			;
> +permissive_def		: PERMISSIVE identifier ';'
> +			{if (define_permissive()) return -1;}
> 
>  /*********** module grammar below ***********/
> 
> @@ -1007,6 +1012,44 @@ static int define_polcap(void)  	return
-1;
>  }
> 
> +static int define_permissive(void)
> +{
> +	char *type = NULL;
> +	struct type_datum *t;
> +
> +	if (pass == 2) {
> +		type = queue_remove(id_queue);
> +		free(type);
> +		return 0;
> +	}
> +

I think this should be pass == 1. It doesn't need to be on pass 1 since
it won't be adding symbols needed for pass 2 and it makes it a little
more resilient to ordering issues.

> +	type = queue_remove(id_queue);
> +
> +	if (!is_id_in_scope(SYM_TYPES, type)) {
> +		yyerror2("type %s is not within scope", type);
> +		goto bad;
> +	}
> +
> +	t = hashtab_search(policydbp->p_types.table, type); +	if (!t)
{
> +		yyerror2("type is not defined: %s", type);
> +		goto bad;
> +	}
> +
> +	if (t->flavor == TYPE_ATTRIB) {
> +		yyerror2("attributes may not be permissive:
> %s\n", type);
> +		goto bad;
> +	}
> +
> +	t->flags |= TYPE_FLAGS_PERMISSIVE;
> +
> +	free(type);
> +	return 0;
> +bad:
> +	free(type);
> +	return -1;
> +}
> +
>  static int define_initial_sid(void)
>  {
>  	char *id = 0;
> diff -up checkpolicy-2.0.10/test/dispol.c.pre.permissive
> checkpolicy-2.0.10/test/dispol.c
> --- checkpolicy-2.0.10/test/dispol.c.pre.permissive
> 2008-03-11 10:18:31.000000000 -0400
> +++ checkpolicy-2.0.10/test/dispol.c	2008-03-11
> 10:19:00.000000000 -0400

This should be a separate patch

<snip>

> diff -up checkpolicy-2.0.10/policy_scan.l.pre.permissive
> checkpolicy-2.0.10/policy_scan.l
> --- checkpolicy-2.0.10/policy_scan.l.pre.permissive
> 2008-03-11 10:18:31.000000000 -0400
> +++ checkpolicy-2.0.10/policy_scan.l	2008-03-11
> 10:19:00.000000000 -0400
> @@ -202,7 +202,9 @@ H1				{ return(H1); }
>  h2 |
>  H2				{ return(H2); }
>  policycap |
> -POLICYCAP			{ return(POLICYCAP);}
> +POLICYCAP			{ return(POLICYCAP); }

Whitespace?

> +permissive |
> +PERMISSIVE			{ return(PERMISSIVE); }
>  "/"({alnum}|[_.-/])*	        { return(PATH); }
>  {letter}({alnum}|[_-])*([.]?({alnum}|[_-]))*	{ return(IDENTIFIER); }
>  {digit}+                        { return(NUMBER); }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
