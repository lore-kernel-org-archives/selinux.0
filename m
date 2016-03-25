Subject: Re: [PATCH 2/3] policycoreutils/hll/pp: Warn if module name different
 from filenames
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1458929095-25819-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1458929095-25819-3-git-send-email-jwcart2@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56F58767.9050707@tycho.nsa.gov>
Date: Fri, 25 Mar 2016 14:45:59 -0400
MIME-Version: 1.0
In-Reply-To: <1458929095-25819-3-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/25/2016 02:04 PM, James Carter wrote:
> Since CIL treats files as modules and does not have a separate
> module statement it can cause confusion when a Refpolicy module
> has a name that is not the same as its base filename because
> older SELinux userspaces will refer to the module by its module
> name, but CIL will refer to the module by its filename.
> 
> When converting a policy package to CIL warn if the module name is
> different from the pp filename or the CIL filename.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  policycoreutils/hll/pp/pp.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
> index 866734f..22cef0d 100644
> --- a/policycoreutils/hll/pp/pp.c
> +++ b/policycoreutils/hll/pp/pp.c
> @@ -28,6 +28,7 @@
>  
>  #include <sepol/module.h>
>  #include <sepol/module_to_cil.h>
> +#include <sepol/policydb/module.h>
>  
>  char *progname;
>  
> @@ -68,6 +69,8 @@ int main(int argc, char **argv)
>  		{ NULL, 0, NULL, 0 }
>  	};
>  	struct sepol_module_package *mod_pkg = NULL;
> +	char *ifile = NULL;
> +	char *ofile = NULL;
>  	FILE *in = NULL;
>  	FILE *out = NULL;
>  	int outfd = -1;
> @@ -89,9 +92,10 @@ int main(int argc, char **argv)
>  	}
>  
>  	if (argc >= optind + 1 && strcmp(argv[1], "-") != 0) {
> -		in = fopen(argv[1], "rb");
> +		ifile = argv[1];
> +		in = fopen(ifile, "rb");
>  		if (in == NULL) {
> -			log_err("Failed to open %s: %s", argv[1], strerror(errno));
> +			log_err("Failed to open %s: %s", ifile, strerror(errno));
>  			rc = -1;
>  			goto exit;
>  		}
> @@ -100,9 +104,10 @@ int main(int argc, char **argv)
>  	}
>  
>  	if (argc >= optind + 2 && strcmp(argv[2], "-") != 0) {
> -		out = fopen(argv[2], "w");
> +		ofile = argv[2];
> +		out = fopen(ofile, "w");
>  		if (out == NULL) {
> -			log_err("Failed to open %s: %s", argv[2], strerror(errno));
> +			log_err("Failed to open %s: %s", ofile, strerror(errno));
>  			rc = -1;
>  			goto exit;
>  		}
> @@ -122,6 +127,22 @@ int main(int argc, char **argv)
>  	fclose(in);
>  	in = NULL;
>  
> +	if (ifile) {
> +		rc = sepol_module_check_name_matches_filename(mod_pkg->policy, ifile);
> +		if (rc != 0) {
> +			fprintf(stderr,	"Module name %s does not match pp file %s\n",
> +				sepol_module_get_name(mod_pkg->policy), ifile);
> +		}
> +	}
> +
> +	if (ofile) {
> +		rc = sepol_module_check_name_matches_filename(mod_pkg->policy, ofile);
> +		if (rc != 0) {
> +			fprintf(stderr,	"Module name %s does not match cil file %s\n",
> +				sepol_module_get_name(mod_pkg->policy), ofile);
> +		}
> +	}

So what, if anything, should the user take away from such warnings?  We
likely ought to prefix them with "Warning:" or similar to indicate that
it is non-fatal.  And perhaps tell them which name will need to be used
for subsequent commands.

> +
>  	rc = sepol_module_package_to_cil(out, mod_pkg);
>  	if (rc != 0) {
>  		goto exit;
> 
