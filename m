MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH-v2] checkpolicy: support for permissive types
Date: Tue, 11 Mar 2008 11:17:56 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801AD2256@exchange.columbia.tresys.com>
In-Reply-To: <1205248565.5297.98.camel@localhost.localdomain>
References: <1205248565.5297.98.camel@localhost.localdomain>
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

Looks good to me, assuming the kernel part gets acked:
Acked-by: Joshua Brindle <method@manicmethod.com>

> 
> ---
> 
> - drop support for displaying all types in dispol
> - do the define_permissive() work on pass 2
> - leave the whitespace fix  :)
> 
> 
>  policy_parse.y |   43 +++++++++++++++++++++++++++++++++++++++++++ 
>  policy_scan.l  |    4 +++- test/dismod.c  |    2 +-
>  test/dispol.c  |   26 ++++++++++++++++++++++++++
>  4 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff -up checkpolicy-2.0.10/policy_parse.y.pre.permissive
> checkpolicy-2.0.10/policy_parse.y
> --- checkpolicy-2.0.10/policy_parse.y.pre.permissive
> 2008-03-11 11:05:36.000000000 -0400
> +++ checkpolicy-2.0.10/policy_parse.y	2008-03-11
> 11:05:54.000000000 -0400
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
> +	if (pass == 1) {
> +		type = queue_remove(id_queue);
> +		free(type);
> +		return 0;
> +	}
> +
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
> diff -up checkpolicy-2.0.10/policy_scan.l.pre.permissive
> checkpolicy-2.0.10/policy_scan.l
> --- checkpolicy-2.0.10/policy_scan.l.pre.permissive
> 2008-03-11 11:05:36.000000000 -0400
> +++ checkpolicy-2.0.10/policy_scan.l	2008-03-11
> 11:05:54.000000000 -0400
> @@ -202,7 +202,9 @@ H1				{ return(H1); }
>  h2 |
>  H2				{ return(H2); }
>  policycap |
> -POLICYCAP			{ return(POLICYCAP);}
> +POLICYCAP			{ return(POLICYCAP); }
> +permissive |
> +PERMISSIVE			{ return(PERMISSIVE); }
>  "/"({alnum}|[_.-/])*	        { return(PATH); }
>  {letter}({alnum}|[_-])*([.]?({alnum}|[_-]))*	{ return(IDENTIFIER); }
>  {digit}+                        { return(NUMBER); }
> diff -up checkpolicy-2.0.10/test/dispol.c.pre.permissive
> checkpolicy-2.0.10/test/dispol.c
> --- checkpolicy-2.0.10/test/dispol.c.pre.permissive
> 2008-03-11 11:05:36.000000000 -0400
> +++ checkpolicy-2.0.10/test/dispol.c	2008-03-11
> 11:09:17.000000000 -0400
> @@ -319,6 +319,28 @@ static void display_policycaps(policydb_
}
>  }
> 
> +static void display_id(policydb_t *p, FILE *fp, uint32_t symbol_type,
> +		       uint32_t symbol_value, char *prefix) {
> +	char *id = p->sym_val_to_name[symbol_type][symbol_value];
> +	fprintf(fp, " %s%s", prefix, id);
> +}
> +
> +static void display_permissive(policydb_t *p, FILE *fp) {
> +	ebitmap_node_t *node; +	int i;
> +
> +	fprintf(fp, "permissive sids:\n");
> +	ebitmap_for_each_bit(&p->permissive_map, node, i) {
> +		if (ebitmap_node_get_bit(node, i)) {
> +			fprintf(fp, "\t");
> +			display_id(p, fp, SYM_TYPES, i - 1, "");
> +			fprintf(fp, "\n");
> +		}
> +	}
> +}
> +
>  int menu()
>  {
>  	printf("\nSelect a command:\n");
> @@ -331,6 +353,7 @@ int menu()
>  	printf("7)  change a boolean value\n");
>  	printf("\n");
>  	printf("c)  display policy capabilities\n");
> +	printf("p)  display the list of permissive types\n");
>  	printf("u)  display unknown handling setting\n");
>  	printf("f)  set output file\n");
>  	printf("m)  display menu\n");
> @@ -446,6 +469,9 @@ int main(int argc, char **argv)  		case
'c':
>  			display_policycaps(&policydb, out_fp);
>  			break;
> +		case 'p':
> +			display_permissive(&policydb, out_fp);
> +			break;
>  		case 'u':
>  		case 'U':
>  			display_handle_unknown(&policydb,
> out_fp); diff -up
> checkpolicy-2.0.10/test/dismod.c.pre.permissive
> checkpolicy-2.0.10/test/dismod.c
> --- checkpolicy-2.0.10/test/dismod.c.pre.permissive
> 2008-03-11 11:05:36.000000000 -0400
> +++ checkpolicy-2.0.10/test/dismod.c	2008-03-11
> 11:05:54.000000000 -0400
> @@ -323,7 +323,7 @@ int display_type_callback(hashtab_key_t
>  		fprintf(fp, "alias for type");
>  		display_id(&policydb, fp, SYM_TYPES,
> type->s.value - 1, "");
>  	}
> -	fprintf(fp, "\n");
> +	fprintf(fp, " flags:%x\n", type->flags);
> 
>  	return 0;
>  }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
