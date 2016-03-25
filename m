Subject: Re: [PATCH 3/3] checkpolicy: Warn if module name different than
 filenames
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1458929095-25819-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1458929095-25819-4-git-send-email-jwcart2@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56F587EC.4040502@tycho.nsa.gov>
Date: Fri, 25 Mar 2016 14:48:12 -0400
MIME-Version: 1.0
In-Reply-To: <1458929095-25819-4-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/25/2016 02:04 PM, James Carter wrote:
> Since the usual convention is for the module name to be same as the
> base filename of the module, provide a warning message if they are
> different. Also warn if the output filename is different than the
> module name.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  checkpolicy/checkmodule.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
> index 5957d29..5d1e219 100644
> --- a/checkpolicy/checkmodule.c
> +++ b/checkpolicy/checkmodule.c
> @@ -258,6 +258,19 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> +	if (policy_type != POLICY_BASE) {
> +		sepol_policydb_t *module = (sepol_policydb_t *)&modpolicydb;
> +		if (sepol_module_check_name_matches_filename(module, file)) {
> +			fprintf(stderr,	"Module name %s does not match input file %s\n",
> +				sepol_module_get_name(module), file);
> +		}
> +		if (outfile) {
> +			if (sepol_module_check_name_matches_filename(module, outfile)) {
> +				fprintf(stderr,	"Module name %s does not match output file %s\n", sepol_module_get_name(module), outfile);
> +			}
> +		}
> +	}

Probably want a "Warning:" prefix here as well, and possibly some hint
as to which name is preferred or will be used by the system.

Do we actually care about the input file name?

> +
>  	if (modpolicydb.policy_type == POLICY_BASE && !cil) {
>  		/* Verify that we can successfully expand the base module. */
>  		policydb_t kernpolicydb;
> 
