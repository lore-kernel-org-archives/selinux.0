Subject: Re: [patch 2/2] checkpolicy capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: tmiller@tresys.com
Cc: selinux@tycho.nsa.gov, method@manicmethod.com, dwalsh@redhat.com,
        paul.moore@hp.com, cpebenito@tresys.com, kmacmillan@mentalrootkit.com
In-Reply-To: <20071206213942.268925113@tresys.com>
References: <20071206213852.083412876@tresys.com>
	 <20071206213942.268925113@tresys.com>
Content-Type: text/plain
Date: Fri, 21 Dec 2007 12:30:17 -0500
Message-Id: <1198258217.2944.79.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2007-12-06 at 16:38 -0500, tmiller@tresys.com wrote:
> plain text document attachment (checkpolicy)
> This patch includes checkpolicy support for policy capabilities.  In this
> version of the patch policy capabilities are only allowed in the base
> module.  Attempted use in other modules will result in a syntax error.
> 
> Also included is dismod/dispol support for printing the capabilities.
> I chose to use the 'c' command for this in both dismod and dispol to
> keep things consistent (dismod has run out of numbered commands).
> 
> Signed-off-by: Todd C. Miller <tmiller@tresys.com>
> 
> Index: trunk/checkpolicy/policy_parse.y
> ===================================================================
> --- trunk.orig/checkpolicy/policy_parse.y
> +++ trunk/checkpolicy/policy_parse.y
> @@ -47,6 +47,7 @@
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/flask.h>
>  #include <sepol/policydb/hierarchy.h>
> +#include <sepol/policydb/polcaps.h>
>  #include "queue.h"
>  #include "checkpolicy.h"
>  #include "module_compiler.h"
> @@ -198,6 +199,7 @@ typedef int (* require_func_t)();
>  %token IPV4_ADDR
>  %token IPV6_ADDR
>  %token MODULE VERSION_IDENTIFIER REQUIRE OPTIONAL
> +%token POLICYCAP
>  
>  %left OR
>  %left XOR
> @@ -308,6 +310,7 @@ te_rbac_decl		: te_decl
>  			| rbac_decl
>                          | cond_stmt_def
>  			| optional_block
> +			| policycap_def
>  			| ';'
>                          ;
>  rbac_decl		: role_type_def
> @@ -765,6 +768,9 @@ number			: NUMBER 
>  ipv6_addr		: IPV6_ADDR
>  			{ if (insert_id(yytext,0)) return -1; }
>  			;
> +policycap_def		: POLICYCAP identifier ';'
> +			{if (define_polcap()) return -1;}
> +			;
>  
>  /*********** module grammar below ***********/
>  
> @@ -962,6 +968,44 @@ static int define_class(void)
>  	return -1;
>  }
>  
> +static int define_polcap(void)
> +{
> +	char *id = 0;
> +	int capnum;
> +
> +	if (pass == 2) {
> +		id = queue_remove(id_queue);
> +		free(id);
> +		return 0;
> +	}
> +
> +	id = (char *)queue_remove(id_queue);
> +	if (!id) {
> +		yyerror("no capability name for policycap definition?");
> +		goto bad;
> +	}
> +
> +	/* Check for valid cap name -> number mapping */
> +	capnum = sepol_polcap_getnum(id);
> +	if (capnum < 0) {
> +		yyerror2("invalid policy capability name %s", id);
> +		goto bad;
> +	}
> +
> +	/* Store it */
> +	if (ebitmap_set_bit(&policydbp->policycaps, capnum, TRUE)) {
> +		yyerror("out of memory");
> +		goto bad;
> +	}
> +
> +	free(id);
> +	return 0;
> +
> +      bad:
> +	free(id);
> +	return -1;
> +}
> +
>  static int define_initial_sid(void)
>  {
>  	char *id = 0;
> Index: trunk/checkpolicy/policy_scan.l
> ===================================================================
> --- trunk.orig/checkpolicy/policy_scan.l
> +++ trunk/checkpolicy/policy_scan.l
> @@ -201,6 +201,8 @@ h1 |
>  H1				{ return(H1); }
>  h2 |
>  H2				{ return(H2); }
> +policycap |
> +POLICYCAP			{ return(POLICYCAP);}
>  "/"({alnum}|[_.-/])*	        { return(PATH); }
>  {letter}({alnum}|[_-])*([.]?({alnum}|[_-]))*	{ return(IDENTIFIER); }
>  {digit}+                        { return(NUMBER); }
> Index: trunk/checkpolicy/test/dismod.c
> ===================================================================
> --- trunk.orig/checkpolicy/test/dismod.c
> +++ trunk/checkpolicy/test/dismod.c
> @@ -34,6 +34,7 @@
>  #include <sepol/policydb/link.h>
>  #include <sepol/policydb/module.h>
>  #include <sepol/policydb/util.h>
> +#include <sepol/policydb/polcaps.h>
>  
>  #include <byteswap.h>
>  #include <endian.h>
> @@ -765,6 +766,26 @@ static void link_module(policydb_t * bas
>  	return;
>  }
>  
> +static void display_policycaps(policydb_t * p, FILE * fp)
> +{
> +	ebitmap_node_t *node;
> +	const char *capname;
> +	char buf[64];
> +	int i;
> +
> +	fprintf(fp, "policy capabilities:\n");
> +	ebitmap_for_each_bit(&p->policycaps, node, i) {
> +		if (ebitmap_get_bit(&p->policycaps, i)) {

That should be ebitmap_node_get_bit(node, i) - no point in walking the
ebitmap twice to find the right node.

Otherwise, barring any other objections, these look good to go.

> +			capname = sepol_polcap_getname(i);
> +			if (capname == NULL) {
> +				snprintf(buf, sizeof(buf), "unknown (%d)", i);
> +				capname = buf;
> +			}
> +			fprintf(fp, "\t%s\n", capname);
> +		}
> +	}
> +}
> +
>  int menu()
>  {
>  	printf("\nSelect a command:\n");
> @@ -781,6 +802,7 @@ int menu()
>  	printf("\n");
>  	printf("a)  Display avrule requirements\n");
>  	printf("b)  Display avrule declarations\n");
> +	printf("c)  Display policy capabilities\n");
>  	printf("l)  Link in a module\n");
>  	printf("u)  Display the unknown handling setting\n");
>  	printf("\n");
> @@ -891,6 +913,9 @@ int main(int argc, char **argv)
>  			fprintf(out_fp, "avrule block declarations:\n");
>  			display_avblock(6, 0, &policydb, out_fp);
>  			break;
> +		case 'c':
> +			display_policycaps(&policydb, out_fp);
> +			break;
>  		case 'u':
>  		case 'U':
>  			display_handle_unknown(&policydb, out_fp);
> Index: trunk/checkpolicy/test/dispol.c
> ===================================================================
> --- trunk.orig/checkpolicy/test/dispol.c
> +++ trunk/checkpolicy/test/dispol.c
> @@ -23,6 +23,7 @@
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/expand.h>
>  #include <sepol/policydb/util.h>
> +#include <sepol/policydb/polcaps.h>
>  #include <getopt.h>
>  #include <assert.h>
>  #include <unistd.h>
> @@ -298,6 +299,26 @@ int change_bool(char *name, int state, p
>  	return 0;
>  }
>  
> +static void display_policycaps(policydb_t * p, FILE * fp)
> +{
> +	ebitmap_node_t *node;
> +	const char *capname;
> +	char buf[64];
> +	int i;
> +
> +	fprintf(fp, "policy capabilities:\n");
> +	ebitmap_for_each_bit(&p->policycaps, node, i) {
> +		if (ebitmap_get_bit(&p->policycaps, i)) {
> +			capname = sepol_polcap_getname(i);
> +			if (capname == NULL) {
> +				snprintf(buf, sizeof(buf), "unknown (%d)", i);
> +				capname = buf;
> +			}
> +			fprintf(fp, "\t%s\n", capname);
> +		}
> +	}
> +}
> +
>  int menu()
>  {
>  	printf("\nSelect a command:\n");
> @@ -309,6 +330,7 @@ int menu()
>  	printf("6)  display conditional expressions\n");
>  	printf("7)  change a boolean value\n");
>  	printf("\n");
> +	printf("c)  display policy capabilities\n");
>  	printf("u)  display unknown handling setting\n");
>  	printf("f)  set output file\n");
>  	printf("m)  display menu\n");
> @@ -421,6 +443,9 @@ int main(int argc, char **argv)
>  			change_bool(name, state, &policydb, out_fp);
>  			free(name);
>  			break;
> +		case 'c':
> +			display_policycaps(&policydb, out_fp);
> +			break;
>  		case 'u':
>  		case 'U':
>  			display_handle_unknown(&policydb, out_fp);
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
