Subject: Re: [PATCH] checkpolicy: Remove use of REJECT and trailing context
	in lex rules; make ipv4 address processing like ipv6
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1193859825.19140.50.camel@moss-lions.epoch.ncsc.mil>
References: <1193859825.19140.50.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 01 Nov 2007 16:11:15 -0400
Message-Id: <1193947875.12018.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-10-31 at 15:43 -0400, James Carter wrote:
> This is a patch to remove the use of REJECT and trailing context in the
> lex rules.  To help accomplish this, it also makes ipv4 address
> processing like ipv6 address processing.
> 
> It improves policy compile times on my laptop from ~95sec to ~85sec.  
> 
> REJECT was used to reject an identifier if it had two consecutive "."s
> or one at the end.  The new rule should prevent both of these conditions
> without the use of REJECT and the is_valid_identifier function.
> 
> Trailing context was used in the rule to identify the module version.
> Without the trailing context, the rule would match ipv4 addresses.  A
> rule for ipv4 addresses was added to eliminate the need for the use of
> trailing context and to allow ipv4 addresses to be handled in a manner
> similar to ipv6 addresses.
> 
> Finally, the alnum character class was defined and some minor cleanup
> was done.
> 
> I am, by the way, surprised by the rule to match the module version.
> It is "[0-9]+(\.[A-Za-z0-9_.]*)?" when I would have expected something
> like "[0-9]+(\.[0-9]+){0,2}".  I assumed that there is a reason why it
> is like this and left it alone.
> 
> 
> Signed off by: James Carter <jwcart2@tycho.nsa.gov>

Thanks, merged.

> ---
> 
>  policy_parse.y |   79
> ++++++++++++++++++++++++++++++++++++++-------------------
>  policy_scan.l  |   34 +++++-------------------
>  2 files changed, 62 insertions(+), 51 deletions(-)
> 
> 
> Index: checkpolicy/policy_scan.l
> ===================================================================
> --- checkpolicy/policy_scan.l	(revision 2662)
> +++ checkpolicy/policy_scan.l	(working copy)
> @@ -31,7 +31,6 @@
>  static char linebuf[2][255];
>  static unsigned int lno = 0;
>  int yywarn(char *msg);
> -static int is_valid_identifier(char *id);
>  
>  char source_file[255];
>  unsigned long source_lineno = 1;
> @@ -46,8 +45,8 @@
>  %array
>  letter  [A-Za-z]
>  digit   [0-9]
> +alnum   [a-zA-Z0-9]
>  hexval	[0-9A-Fa-f]
> -version [0-9]+(\.[A-Za-z0-9_.]*)?
>  
>  %%
>  \n.*				{ strncpy(linebuf[lno], yytext+1, 255);
> @@ -199,17 +198,14 @@
>  H1				{ return(H1); }
>  h2 |
>  H2				{ return(H2); }
> -"/"({letter}|{digit}|_|"."|"-"|"/")*	{ return(PATH); }
> -{letter}({letter}|{digit}|_|"."|"-")*	{ if (is_valid_identifier(yytext)) 
> -						return(IDENTIFIER); 
> -					  else 
> -					  	REJECT;
> -					}
> -{digit}{digit}*                 { return(NUMBER); }
> -{hexval}{0,4}":"{hexval}{0,4}":"({hexval}|":"|".")*	{ return(IPV6_ADDR); }
> -{version}/([ \t\f]*;)           { return(VERSION_IDENTIFIER); }
> +"/"({alnum}|[_.-/])*	        { return(PATH); }
> +{letter}({alnum}|[_-])*([.]?({alnum}|[_-]))*	{ return(IDENTIFIER); }
> +{digit}+                        { return(NUMBER); }
> +{digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
> +{hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
> +{digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
>  #line[ ]1[ ]\"[^\n]*\"		{ source_lineno = 1; strncpy(source_file, yytext+9, 255); source_file[strlen(source_file)-1] = '\0'; }
> -#line[ ]{digit}{digit}*		{ source_lineno = atoi(yytext+6)-1; }
> +#line[ ]{digit}+	        { source_lineno = atoi(yytext+6)-1; }
>  #[^\n]*                         { /* delete comments */ }
>  [ \t\f]+			{ /* delete whitespace */ }
>  "==" 				{ return(EQUALS); }
> @@ -263,17 +259,3 @@
>  			linebuf[0], linebuf[1]);
>  	return 0;
>  }
> -
> -static int is_valid_identifier(char *id) {
> -        if ((strrchr(id, '.')) != NULL) {
> -                if (strstr(id, "..") != NULL) {
> -                        /* identifier has consecutive '.' */
> -                        return 0;
> -                }
> -		if (id[strlen(id) - 1] == '.') {
> -			/* identifier ends in '.' */
> -			return 0;
> -		}
> -        }
> -        return 1;
> -}
> Index: checkpolicy/policy_parse.y
> ===================================================================
> --- checkpolicy/policy_parse.y	(revision 2662)
> +++ checkpolicy/policy_parse.y	(working copy)
> @@ -122,7 +122,7 @@
>  static int define_fs_context(unsigned int major, unsigned int minor);
>  static int define_port_context(unsigned int low, unsigned int high);
>  static int define_netif_context(void);
> -static int define_ipv4_node_context(unsigned int addr, unsigned int mask);
> +static int define_ipv4_node_context(void);
>  static int define_ipv6_node_context(void);
>  
>  typedef int (* require_func_t)();
> @@ -195,6 +195,7 @@
>  %token NUMBER
>  %token EQUALS
>  %token NOTEQUAL
> +%token IPV4_ADDR
>  %token IPV6_ADDR
>  %token MODULE VERSION_IDENTIFIER REQUIRE OPTIONAL
>  
> @@ -654,7 +655,7 @@
>  			| node_contexts node_context_def
>  			;
>  node_context_def	: NODECON ipv4_addr_def ipv4_addr_def security_context_def
> -			{if (define_ipv4_node_context($2,$3)) return -1;}
> +			{if (define_ipv4_node_context()) return -1;}
>  			| NODECON ipv6_addr ipv6_addr security_context_def
>  			{if (define_ipv6_node_context()) return -1;}
>  			;
> @@ -684,18 +685,9 @@
>                          | GENFSCON identifier path security_context_def
>  			{if (define_genfs_context(0)) return -1;}
>  			;
> -ipv4_addr_def		: number '.' number '.' number '.' number
> -			{ 
> -			  unsigned int addr;
> -	  		  unsigned char *p = ((unsigned char *)&addr);
> -
> -			  p[0] = $1 & 0xff;				
> -			  p[1] = $3 & 0xff;
> -			  p[2] = $5 & 0xff;
> -			  p[3] = $7 & 0xff;
> -			  $$ = addr;
> -			}
> -    			;
> +ipv4_addr_def		: IPV4_ADDR
> +			{ if (insert_id(yytext,0)) return -1; }
> +			;
>  security_context_def	: identifier ':' identifier ':' identifier opt_mls_range_def
>  	                ;
>  opt_mls_range_def	: ':' mls_range_def
> @@ -4184,27 +4176,63 @@
>  	return 0;
>  }
>  
> -static int define_ipv4_node_context(unsigned int addr, unsigned int mask)
> -{
> +static int define_ipv4_node_context()
> +{	
> +	char *id;
> +	int rc = 0;
> +	struct in_addr addr, mask;
>  	ocontext_t *newc, *c, *l, *head;
>  
>  	if (pass == 1) {
> +		free(queue_remove(id_queue));
> +		free(queue_remove(id_queue));
>  		parse_security_context(NULL);
> -		if (mlspol)
> -			free(queue_remove(id_queue));
> -		return 0;
> +		goto out;
>  	}
>  
> +	id = queue_remove(id_queue);
> +	if (!id) {
> +		yyerror("failed to read ipv4 address");
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	rc = inet_pton(AF_INET, id, &addr);
> +	free(id);
> +	if (rc < 1) {
> +		yyerror("failed to parse ipv4 address");
> +		if (rc == 0)
> +			rc = -1;
> +		goto out;
> +	}
> +
> +	id = queue_remove(id_queue);
> +	if (!id) {
> +		yyerror("failed to read ipv4 address");
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	rc = inet_pton(AF_INET, id, &mask);
> +	free(id);
> +	if (rc < 1) {
> +		yyerror("failed to parse ipv4 mask");
> +		if (rc == 0)
> +			rc = -1;
> +		goto out;
> +	}
> +
>  	newc = malloc(sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
> -		return -1;
> +		rc = -1;
> +		goto out;
>  	}
> +
>  	memset(newc, 0, sizeof(ocontext_t));
> +	newc->u.node.addr = addr.s_addr;
> +	newc->u.node.mask = mask.s_addr;
>  
> -	newc->u.node.addr = addr;
> -	newc->u.node.mask = mask;
> -
>  	if (parse_security_context(&newc->context[0])) {
>  		free(newc);
>  		return -1;
> @@ -4224,8 +4252,9 @@
>  		l->next = newc;
>  	else
>  		policydbp->ocontexts[OCON_NODE] = newc;
> -
> -	return 0;
> +	rc = 0;
> +out:
> +	return rc;
>  }
>  
>  static int define_ipv6_node_context(void)
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
