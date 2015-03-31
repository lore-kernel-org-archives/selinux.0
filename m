Message-ID: <551AF368.50607@tresys.com>
Date: Tue, 31 Mar 2015 15:20:08 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: James Carter <jwcart2@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 3/3 v3] checkpolicy: Add support for generating CIL
References: <1427822281-14769-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1427822281-14769-4-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1427822281-14769-4-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/31/2015 01:18 PM, James Carter wrote:
> Add support to checkpolicy and checkmodule for generating CIL as their
> output.
> 
> Add new options "-C" and "--cil" to specify CIL as the output format.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  checkpolicy/checkmodule.c | 59 +++++++++++++++++++++--------------
>  checkpolicy/checkpolicy.c | 79 ++++++++++++++++++++++++++++++-----------------
>  2 files changed, 86 insertions(+), 52 deletions(-)
> 
> diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
> index 0255928..b1be640 100644
> --- a/checkpolicy/checkmodule.c
> +++ b/checkpolicy/checkmodule.c

[snip]

> @@ -295,10 +283,33 @@ int main(int argc, char **argv)
>  
>  	printf("%s:  policy configuration loaded\n", argv[0]);
>  
> -	if (outfile &&
> -	    write_binary_policy(&modpolicydb, outfile, argv[0]) == -1) {
> +	if (outfile) {
> +		FILE *outfp = fopen(outfile, "w");
> +
> +		if (!outfp) {
> +			perror(outfile);
> +			exit(1);
> +		}
> +
> +		if (!cil) {
> +			printf("%s:  writing binary representation (version %d) to %s\n",
> +				   argv[0], policyvers, file);
> +
> +			if (write_binary_policy(&modpolicydb, outfp) != 0) {
> +				fprintf(stderr, "%s:  error writing %s\n", argv[0], outfile);
> +				exit(1);
> +			}
> +		} else {
> +			printf("%s:  writing CIL to %s\n",argv[0], outfile);
> +			sepol_module_policydb_to_cil(outfp, &modpolicydb, 0);

Maybe add a check for the return code of sepol_module_policydb_to_cil
and fprintf an error message, like above with write_binary_policy?

> +		}
> +
> +		fclose(outfp);
> +	} else if (cil) {
> +		fprintf(stderr, "%s:  No file to write CIL was specified\n", argv[0]);
>  		exit(1);
>  	}
> +
>  	policydb_destroy(&modpolicydb);
>  
>  	return 0;
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index 61a2e89..d96399d 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c

[snip]

> @@ -602,29 +612,42 @@ int main(int argc, char **argv)
>  	printf("%s:  policy configuration loaded\n", argv[0]);
>  
>  	if (outfile) {
> -		printf
> -		    ("%s:  writing binary representation (version %d) to %s\n",
> -		     argv[0], policyvers, outfile);
>  		outfp = fopen(outfile, "w");
>  		if (!outfp) {
>  			perror(outfile);
>  			exit(1);
>  		}
>  
> -		policydb.policy_type = POLICY_KERN;
>  		policydb.policyvers = policyvers;
>  
> -		policy_file_init(&pf);
> -		pf.type = PF_USE_STDIO;
> -		pf.fp = outfp;
> -		ret = policydb_write(&policydb, &pf);
> -		if (ret) {
> -			fprintf(stderr, "%s:  error writing %s\n",
> -				argv[0], outfile);
> -			exit(1);
> +		if (!cil) {
> +			printf
> +				("%s:  writing binary representation (version %d) to %s\n",
> +				 argv[0], policyvers, outfile);
> +			policydb.policy_type = POLICY_KERN;
> +
> +			policy_file_init(&pf);
> +			pf.type = PF_USE_STDIO;
> +			pf.fp = outfp;
> +			ret = policydb_write(&policydb, &pf);
> +			if (ret) {
> +				fprintf(stderr, "%s:  error writing %s\n",
> +						argv[0], outfile);
> +				exit(1);
> +			}
> +		} else {
> +			printf("%s:  writing CIL to %s\n",argv[0], outfile);
> +			sepol_module_policydb_to_cil(outfp, policydbp, 1);

Same issue here. Add error checking/message?

> +		}
> +
> +		if (outfile) {
> +			fclose(outfp);
>  		}
> -		fclose(outfp);
> +	} else if (cil) {
> +		fprintf(stderr, "%s:  No file to write CIL was specified\n", argv[0]);
> +		exit(1);
>  	}
> +
>  	if (!debug) {
>  		policydb_destroy(&policydb);
>  		exit(0);
> 
