Subject: Re: [PATCH] Change semantic of -r in sefcontext_compile
To: Janis Danisevskis <jdanis@android.com>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov, jwcart2@tycho.nsa.gov
References: <1474031328-29743-1-git-send-email-jdanis@android.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1fa3c006-bfa9-357e-7f88-1c8dfa50a0d2@tycho.nsa.gov>
Date: Fri, 16 Sep 2016 10:41:59 -0400
MIME-Version: 1.0
In-Reply-To: <1474031328-29743-1-git-send-email-jdanis@android.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/16/2016 09:08 AM, Janis Danisevskis wrote:
> This patch reestablishes the default behavior of sefcontext_compile
> to include precompiled regular expressions in the output. If linked
> against PCRE2 the flag "-r" now causes the precompiled regular
> expressions to be omitted from the output.

I thought your original rationale was more compelling.  If we add
detection of the relevant arch properties, then we can do this.
Otherwise, I don't think we should.

> ---
>  libselinux/utils/sefcontext_compile.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
> index 770ec4c..c1284d5 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -263,12 +263,10 @@ static void usage(const char *progname)
>  	    "         will be fc_file with the .bin suffix appended.\n\t"
>  	    "-p       Optional binary policy file that will be used to\n\t"
>  	    "         validate contexts defined in the fc_file.\n\t"
> -	    "-r       Include precompiled regular expressions in the output.\n\t"
> +	    "-r       Omit precompiled regular expressions in the output.\n\t"
>  	    "         (PCRE2 only. Compiled PCRE2 regular expressions are\n\t"
>  	    "         not portable across architectures. When linked against\n\t"
>  	    "         PCRE this flag is ignored)\n\t"
> -	    "         Omit precompiled regular expressions (only meaningful\n\t"
> -	    "         when using PCRE2 regular expression back-end).\n\t"
>  	    "fc_file  The text based file contexts file to be processed.\n",
>  	    progname);
>  		exit(EXIT_FAILURE);
> @@ -278,7 +276,7 @@ int main(int argc, char *argv[])
>  {
>  	const char *path = NULL;
>  	const char *out_file = NULL;
> -	int do_write_precompregex = 0;
> +	int do_write_precompregex = 1;
>  	char stack_path[PATH_MAX + 1];
>  	char *tmp = NULL;
>  	int fd, rc, opt;
> @@ -299,7 +297,7 @@ int main(int argc, char *argv[])
>  			policy_file = optarg;
>  			break;
>  		case 'r':
> -			do_write_precompregex = 1;
> +			do_write_precompregex = 0;
>  			break;
>  		default:
>  			usage(argv[0]);
> 
