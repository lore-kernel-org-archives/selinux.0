Subject: Re: [PATCH 3/3] libselinux: sefcontext_compile invert semantics of
 "-r" flag
To: Janis Danisevskis <jdanis@android.com>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov, jwcart2@tycho.nsa.gov, jdanis@google.com
References: <1475058512-76102-1-git-send-email-jdanis@android.com>
 <1475058512-76102-3-git-send-email-jdanis@android.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <17a8876f-8f77-f098-2d1b-8288e75644eb@tycho.nsa.gov>
Date: Wed, 28 Sep 2016 08:10:52 -0400
MIME-Version: 1.0
In-Reply-To: <1475058512-76102-3-git-send-email-jdanis@android.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/28/2016 06:28 AM, Janis Danisevskis wrote:
> The "-r" flag of sefcontext_compile now causes it to omit the
> precompiled regular expressions from the output.
> 
> Signed-off-by: Janis Danisevskis <jdanis@android.com>

Thanks, all 3 applied.

> ---
>  libselinux/utils/sefcontext_compile.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
> index 8c48d32..b2746c7 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -276,10 +276,12 @@ static void usage(const char *progname)
>  	    "         will be fc_file with the .bin suffix appended.\n\t"
>  	    "-p       Optional binary policy file that will be used to\n\t"
>  	    "         validate contexts defined in the fc_file.\n\t"
> -	    "-r       Include precompiled regular expressions in the output.\n\t"
> +	    "-r       Omit precompiled regular expressions from the output.\n\t"
>  	    "         (PCRE2 only. Compiled PCRE2 regular expressions are\n\t"
> -	    "         not portable across architectures. When linked against\n\t"
> -	    "         PCRE this flag is ignored)\n\t"
> +	    "         not portable across architectures. Use this flag\n\t"
> +	    "         if you know that you build for an incompatible\n\t"
> +	    "         architecture to save space. When linked against\n\t"
> +	    "         PCRE1 this flag is ignored.)\n\t"
>  	    "-i       Print regular expression info end exit. That is, back\n\t"
>  	    "         end version and architecture identifier.\n\t"
>  	    "         Arch identifier format (PCRE2):\n\t"
> @@ -294,7 +296,7 @@ int main(int argc, char *argv[])
>  {
>  	const char *path = NULL;
>  	const char *out_file = NULL;
> -	int do_write_precompregex = 0;
> +	int do_write_precompregex = 1;
>  	char stack_path[PATH_MAX + 1];
>  	char *tmp = NULL;
>  	int fd, rc, opt;
> @@ -315,7 +317,7 @@ int main(int argc, char *argv[])
>  			policy_file = optarg;
>  			break;
>  		case 'r':
> -			do_write_precompregex = 1;
> +			do_write_precompregex = 0;
>  			break;
>  		case 'i':
>  			printf("%s (%s)\n", regex_version(),
> 
