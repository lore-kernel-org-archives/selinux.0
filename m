Subject: Re: [PATCH] checkpolicy: implement handling of unknown classes and
	permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1189103186.3418.35.camel@localhost.localdomain>
References: <1189103186.3418.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 15:48:06 -0400
Message-Id: <1190144886.14037.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-06 at 14:26 -0400, Eric Paris wrote:
> Add a new command line options, -U (allow,reject,deny), to checkmodule
> and checkpolicy which sets the handle_unknown config flag.  Default to
> deny unknowns which is how things have been in the past.  Also add
> dismod and dispol support.
> 
> -Eric

Thanks, merged as of checkpolicy 2.0.4.

Chris/Dan:  we need some way to select the flag setting for the policy
build.  The -U {allow,reject,deny} setting needs to be passed to
checkmodule _only_ when building the base module, or to checkpolicy when
building a monolithic policy.

Then Dan needs to start building policies with -U allow if you want to
allow kernel permissions that are not defined in the policy by default
in Fedora (i.e. so that the next time we add a new permission and Fedora
ships an updated kernel to an existing release, nothing breaks).  The
flag setting should be ignored by the kernel until the kernel patch goes
into the kernel, so it should have no affect until then.

> 
> diff -Naupr checkpolicy-2.0.3.orig/checkmodule.c checkpolicy-2.0.3/checkmodule.c
> --- checkpolicy-2.0.3.orig/checkmodule.c	2007-06-04 15:04:17.000000000 -0400
> +++ checkpolicy-2.0.3/checkmodule.c	2007-09-08 04:05:01.000000000 -0400
> @@ -39,6 +39,7 @@ extern int optind;
>  static sidtab_t sidtab;
>  
>  extern int mlspol;
> +extern int handle_unknown;
>  
>  static char *txtfile = "policy.conf";
>  static char *binfile = "policy";
> @@ -121,6 +122,7 @@ static int write_binary_policy(policydb_
>  
>  	p->policy_type = policy_type;
>  	p->policyvers = policyvers;
> +	p->handle_unknown = handle_unknown;
>  
>  	pf.type = PF_USE_STDIO;
>  	pf.fp = outfp;
> @@ -135,13 +137,17 @@ static int write_binary_policy(policydb_
>  
>  static void usage(char *progname)
>  {
> -	printf("usage:  %s [-V] [-b] [-m] [-M] [-o FILE] [INPUT]\n", progname);
> +	printf("usage:  %s [-V] [-b] [-U handle_unknown] [-m] [-M] [-o FILE] [INPUT]\n", progname);
>  	printf("Build base and policy modules.\n");
>  	printf("Options:\n");
>  	printf("  INPUT      build module from INPUT (else read from \"%s\")\n",
>  	       txtfile);
>  	printf("  -V         show policy versions created by this program\n");
>  	printf("  -b         treat input as a binary policy file\n");
> +	printf("  -U OPTION  How to handle unknown classes and permissions\n");
> +	printf("               deny: Deny unknown kernel checks\n");
> +	printf("               reject: Reject loading of policy with unknowns\n");
> +	printf("               allow: Allow unknown kernel checks\n");
>  	printf("  -m         build a policy module instead of a base module\n");
>  	printf("  -M         enable MLS policy\n");
>  	printf("  -o FILE    write module to FILE (else just check syntax)\n");
> @@ -156,7 +162,7 @@ int main(int argc, char **argv)
>  	int show_version = 0;
>  	policydb_t modpolicydb;
>  
> -	while ((ch = getopt(argc, argv, "ho:dbVmM")) != EOF) {
> +	while ((ch = getopt(argc, argv, "ho:dbVU:mM")) != EOF) {
>  		switch (ch) {
>  		case 'h':
>  			usage(argv[0]);
> @@ -171,6 +177,20 @@ int main(int argc, char **argv)
>  		case 'V':
>  			show_version = 1;
>  			break;
> +		case 'U':
> +			if (!strcasecmp(optarg, "deny")) {
> +				handle_unknown = DENY_UNKNOWN;
> +				break;
> +			}
> +			if (!strcasecmp(optarg, "reject")) {
> +				handle_unknown = REJECT_UNKNOWN;
> +				break;
> +			}
> +			if (!strcasecmp(optarg, "allow")) {
> +				handle_unknown = ALLOW_UNKNOWN;
> +				break;
> +			}
> +			usage(argv[0]);
>  		case 'm':
>  			policy_type = POLICY_MOD;
>  			policyvers = MOD_POLICYDB_VERSION_MAX;
> @@ -189,6 +209,12 @@ int main(int argc, char **argv)
>  		exit(0);
>  	}
>  
> +	if (handle_unknown && (policy_type != POLICY_BASE)) {
> +		printf("Handling of unknown classes and permissions is only ");
> +		printf("valid in the base module\n");
> +		exit(1);
> +	}
> +
>  	if (optind != argc) {
>  		file = argv[optind++];
>  		if (optind != argc)
> @@ -214,6 +240,7 @@ int main(int argc, char **argv)
>  
>  		modpolicydb.policy_type = policy_type;
>  		modpolicydb.mls = mlspol;
> +		modpolicydb.handle_unknown = handle_unknown;
>  
>  		if (read_source_policy(&modpolicydb, file, argv[0]) == -1) {
>  			exit(1);
> diff -Naupr checkpolicy-2.0.3.orig/checkpolicy.c checkpolicy-2.0.3/checkpolicy.c
> --- checkpolicy-2.0.3.orig/checkpolicy.c	2007-06-04 15:04:16.000000000 -0400
> +++ checkpolicy-2.0.3/checkpolicy.c	2007-09-08 04:05:01.000000000 -0400
> @@ -90,6 +90,7 @@ static sidtab_t sidtab;
>  
>  extern policydb_t *policydbp;
>  extern int mlspol;
> +extern int handle_unknown;
>  
>  static char *txtfile = "policy.conf";
>  static char *binfile = "policy";
> @@ -99,7 +100,7 @@ unsigned int policyvers = POLICYDB_VERSI
>  void usage(char *progname)
>  {
>  	printf
> -	    ("usage:  %s [-b] [-d] [-M] [-c policyvers (%d-%d)] [-o output_file] [input_file]\n",
> +	    ("usage:  %s [-b] [-d] [-U handle_unknown (allow,deny,reject) [-M] [-c policyvers (%d-%d)] [-o output_file] [input_file]\n",
>  	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
>  	exit(1);
>  }
> @@ -390,7 +391,7 @@ int main(int argc, char **argv)
>  	int show_version = 0;
>  	struct policy_file pf;
>  
> -	while ((ch = getopt(argc, argv, "o:dbMVc:")) != EOF) {
> +	while ((ch = getopt(argc, argv, "o:dbU:MVc:")) != EOF) {
>  		switch (ch) {
>  		case 'o':
>  			outfile = optarg;
> @@ -405,6 +406,20 @@ int main(int argc, char **argv)
>  		case 'V':
>  			show_version = 1;
>  			break;
> +		case 'U':
> +			if (!strcasecmp(optarg, "deny")) {
> +				handle_unknown = DENY_UNKNOWN;
> +				break;
> +			}
> +			if (!strcasecmp(optarg, "allow")) {
> +				handle_unknown = ALLOW_UNKNOWN;
> +				break;
> +			}
> +			if (!strcasecmp(optarg, "reject")) {
> +				handle_unknown = REJECT_UNKNOWN;
> +				break;
> +			}
> +			usage(argv[0]);
>  		case 'M':
>  			mlspol = 1;
>  			break;
> @@ -515,6 +530,7 @@ int main(int argc, char **argv)
>  
>  		/* Let sepol know if we are dealing with MLS support */
>  		parse_policy.mls = mlspol;
> +		parse_policy.handle_unknown = handle_unknown;
>  
>  		policydbp = &parse_policy;
>  
> diff -Naupr checkpolicy-2.0.3.orig/policy_parse.y checkpolicy-2.0.3/policy_parse.y
> --- checkpolicy-2.0.3.orig/policy_parse.y	2007-06-04 15:04:17.000000000 -0400
> +++ checkpolicy-2.0.3/policy_parse.y	2007-09-08 04:05:01.000000000 -0400
> @@ -67,6 +67,7 @@ queue_t id_queue = 0;
>  static unsigned int pass;
>  char *curfile = 0;
>  int mlspol = 0;
> +int handle_unknown = 0;
>  
>  extern unsigned long policydb_lineno;
>  extern unsigned long source_lineno;
> diff -Naupr checkpolicy-2.0.3.orig/test/dismod.c checkpolicy-2.0.3/test/dismod.c
> --- checkpolicy-2.0.3.orig/test/dismod.c	2007-06-04 15:04:17.000000000 -0400
> +++ checkpolicy-2.0.3/test/dismod.c	2007-09-08 04:05:01.000000000 -0400
> @@ -665,6 +665,17 @@ int display_avblock(int field, uint32_t 
>  	return 0;
>  }
>  
> +int display_handle_unknown(policydb_t * policydb, FILE * out_fp)
> +{
> +	if (policydb->handle_unknown == ALLOW_UNKNOWN)
> +		fprintf(out_fp, "Allow unknown classes and perms\n");
> +	else if (policydb->handle_unknown == DENY_UNKNOWN)
> +		fprintf(out_fp, "Deny unknown classes and perms\n");
> +	else if (policydb->handle_unknown == REJECT_UNKNOWN)
> +		fprintf(out_fp, "Reject unknown classes and perms\n");
> +	return 0;
> +}
> +
>  static int read_policy(char *filename, policydb_t * policy)
>  {
>  	FILE *in_fp;
> @@ -771,6 +782,7 @@ int menu()
>  	printf("a)  Display avrule requirements\n");
>  	printf("b)  Display avrule declarations\n");
>  	printf("l)  Link in a module\n");
> +	printf("u)  Display the unknown handling setting\n");
>  	printf("\n");
>  	printf("f)  set output file\n");
>  	printf("m)  display menu\n");
> @@ -879,6 +891,10 @@ int main(int argc, char **argv)
>  			fprintf(out_fp, "avrule block declarations:\n");
>  			display_avblock(6, 0, &policydb, out_fp);
>  			break;
> +		case 'u':
> +		case 'U':
> +			display_handle_unknown(&policydb, out_fp);
> +			break;
>  		case 'f':
>  			printf
>  			    ("\nFilename for output (<CR> for screen output): ");
> diff -Naupr checkpolicy-2.0.3.orig/test/dispol.c checkpolicy-2.0.3/test/dispol.c
> --- checkpolicy-2.0.3.orig/test/dispol.c	2007-06-04 15:04:17.000000000 -0400
> +++ checkpolicy-2.0.3/test/dispol.c	2007-09-06 15:20:39.000000000 -0400
> @@ -273,6 +273,17 @@ int display_cond_expressions(policydb_t 
>  	return 1;
>  }
>  
> +int display_handle_unknown(policydb_t * policydb, FILE * out_fp)
> +{
> +	if (policydb->handle_unknown == ALLOW_UNKNOWN)
> +		fprintf(out_fp, "Allow unknown classes and permisions\n");
> +	else if (policydb->handle_unknown == DENY_UNKNOWN)
> +		fprintf(out_fp, "Deny unknown classes and permisions\n");
> +	else if (policydb->handle_unknown == REJECT_UNKNOWN)
> +		fprintf(out_fp, "Reject unknown classes and permisions\n");
> +	return 0;
> +}
> +
>  int change_bool(char *name, int state, policydb_t * p, FILE * fp)
>  {
>  	cond_bool_datum_t *bool;
> @@ -298,6 +309,7 @@ int menu()
>  	printf("6)  display conditional expressions\n");
>  	printf("7)  change a boolean value\n");
>  	printf("\n");
> +	printf("u)  display unknown handling setting\n");
>  	printf("f)  set output file\n");
>  	printf("m)  display menu\n");
>  	printf("q)  quit\n");
> @@ -409,6 +421,10 @@ int main(int argc, char **argv)
>  			change_bool(name, state, &policydb, out_fp);
>  			free(name);
>  			break;
> +		case 'u':
> +		case 'U':
> +			display_handle_unknown(&policydb, out_fp);
> +			break;
>  		case 'f':
>  			printf
>  			    ("\nFilename for output (<CR> for screen output): ");
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
