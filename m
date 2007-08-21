Subject: Re: [PATCH] checkpolicy: add options to set handle_unknown
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1185983745.3673.26.camel@localhost.localdomain>
References: <1185983745.3673.26.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 15:41:40 -0400
Message-Id: <1187725300.1451.214.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 11:55 -0400, Eric Paris wrote:
> Add a new command line options, -U (0-2), to checkmodule and checkpolicy
> which sets the handle_unknown config flag.  Default to 0, which means
> deny unknowns.  
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

dispol/dismod should display the flag setting (preferably in
human-readable form).

> 
> diff -Naupr checkpolicy-2.0.3.old/checkmodule.c checkpolicy-2.0.3/checkmodule.c
> --- checkpolicy-2.0.3.old/checkmodule.c	2007-07-26 19:03:19.000000000 -0400
> +++ checkpolicy-2.0.3/checkmodule.c	2007-07-31 17:08:11.000000000 -0400
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
> +	printf("  -U 0-2     How the kernel should handle unknown classes and permissions\n");
> +	printf("               0: Deny unknown kernel checks\n");
> +	printf("               1: Reject loading of policy with unknowns\n");
> +	printf("               2: Allow unknown kernel checks\n");
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
> @@ -171,6 +177,22 @@ int main(int argc, char **argv)
>  		case 'V':
>  			show_version = 1;
>  			break;
> +		case 'U':
> +			handle_unknown = strtol(optarg, (char **) NULL, 10);
> +			switch (handle_unknown){
> +			case 0:
> +				handle_unknown = DENY_UNKNOWN;
> +				break;
> +			case 1:
> +				handle_unknown = REJECT_UNKNOWN;
> +				break;
> +			case 2:
> +				handle_unknown = ALLOW_UNKNOWN;
> +				break;
> +			default:
> +				usage(argv[0]);
> +			}
> +			break;
>  		case 'm':
>  			policy_type = POLICY_MOD;
>  			policyvers = MOD_POLICYDB_VERSION_MAX;
> @@ -189,6 +211,12 @@ int main(int argc, char **argv)
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
> @@ -214,6 +242,7 @@ int main(int argc, char **argv)
>  
>  		modpolicydb.policy_type = policy_type;
>  		modpolicydb.mls = mlspol;
> +		modpolicydb.handle_unknown = handle_unknown;
>  
>  		if (read_source_policy(&modpolicydb, file, argv[0]) == -1) {
>  			exit(1);
> diff -Naupr checkpolicy-2.0.3.old/checkpolicy.c checkpolicy-2.0.3/checkpolicy.c
> --- checkpolicy-2.0.3.old/checkpolicy.c	2007-07-26 19:03:19.000000000 -0400
> +++ checkpolicy-2.0.3/checkpolicy.c	2007-07-31 17:18:38.000000000 -0400
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
> +	    ("usage:  %s [-b] [-d] [-U handle unknown (0-2) [-M] [-c policyvers (%d-%d)] [-o output_file] [input_file]\n",
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
> @@ -405,6 +406,22 @@ int main(int argc, char **argv)
>  		case 'V':
>  			show_version = 1;
>  			break;
> +		case 'U':
> +			handle_unknown = strtol(optarg, (char **) NULL, 10);
> +			switch (handle_unknown) {
> +			case 0:
> +				handle_unknown = DENY_UNKNOWN;
> +				break;
> +			case 1:
> +				handle_unknown = REJECT_UNKNOWN;
> +				break;
> +			case 2:
> +				handle_unknown = ALLOW_UNKNOWN;
> +				break;
> +			default:
> +				usage(argv[0]);
> +			}
> +			break;
>  		case 'M':
>  			mlspol = 1;
>  			break;
> @@ -515,6 +532,7 @@ int main(int argc, char **argv)
>  
>  		/* Let sepol know if we are dealing with MLS support */
>  		parse_policy.mls = mlspol;
> +		parse_policy.handle_unknown = handle_unknown;
>  
>  		policydbp = &parse_policy;
>  
> diff -Naupr checkpolicy-2.0.3.old/policy_parse.y checkpolicy-2.0.3/policy_parse.y
> --- checkpolicy-2.0.3.old/policy_parse.y	2007-07-26 19:03:19.000000000 -0400
> +++ checkpolicy-2.0.3/policy_parse.y	2007-07-26 21:11:36.000000000 -0400
> @@ -67,6 +67,7 @@ queue_t id_queue = 0;
>  static unsigned int pass;
>  char *curfile = 0;
>  int mlspol = 0;
> +int handle_unknown = 0;
>  
>  extern unsigned long policydb_lineno;
>  extern unsigned long source_lineno;
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
