Message-ID: <555A0B62.8020106@tycho.nsa.gov>
Date: Mon, 18 May 2015 11:55:14 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: Ensure selabel_lookup_best_match links NULL
 terminated
References: <1431957228-22409-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1431957228-22409-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/18/2015 09:53 AM, Richard Haines wrote:
> Ensure that the array of strings is NULL terminated to stop core
> dumps. Also cleaned up code.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
>  libselinux/utils/selabel_lookup_best_match.c | 32 +++++++++++++---------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/libselinux/utils/selabel_lookup_best_match.c b/libselinux/utils/selabel_lookup_best_match.c
> index c4e8c10..d74382f 100644
> --- a/libselinux/utils/selabel_lookup_best_match.c
> +++ b/libselinux/utils/selabel_lookup_best_match.c
> @@ -53,9 +53,8 @@ static mode_t string_to_mode(char *s)
>  
>  int main(int argc, char **argv)
>  {
> -	int raw = 0, mode = 0, rc, opt, i, num_links, string_size;
> +	int raw = 0, mode = 0, rc, opt, i, num_links, string_len;
>  	char *validate = NULL, *path = NULL, *context = NULL, *file = NULL;
> -
>  	char **links = NULL;
>  
>  	struct selabel_handle *hnd;
> @@ -93,19 +92,19 @@ int main(int argc, char **argv)
>  	for (i = optind, num_links = 0; i < argc; i++, num_links++)
>  		;
>  
> -	if (num_links != 0) {
> -		links = malloc(sizeof(char *) * num_links);
> +	if (num_links) {
> +		links = calloc(num_links + 1, sizeof(char *));
>  
> -		if (links == NULL) {
> -			fprintf(stderr, "ERROR: malloc failed.");
> +		if (!links) {
> +			fprintf(stderr, "ERROR: calloc failed.\n");
>  			exit(1);
>  		}
>  
>  		for (i = optind, num_links = 0; i < argc; i++, num_links++) {
> -			string_size = strlen(argv[i]) + 1;
> -			links[num_links] = malloc(string_size);
> -			if (links[num_links] == NULL) {
> -				fprintf(stderr, "ERROR: malloc failed.");
> +			string_len = strlen(argv[i]) + 1;
> +			links[num_links] = malloc(string_len);
> +			if (!links[num_links]) {
> +				fprintf(stderr, "ERROR: malloc failed.\n");
>  				exit(1);
>  			}
>  			strcpy(links[num_links], argv[i]);
> @@ -123,15 +122,13 @@ int main(int argc, char **argv)
>  		goto out;
>  	}
>  
> -	switch (raw) {
> -	case 1:
> +	if (raw)
>  		rc = selabel_lookup_best_match_raw(hnd, &context, path,
>  					    (const char **)links, mode);
> -		break;
> -	default:
> +	else
>  		rc = selabel_lookup_best_match(hnd, &context, path,
>  					    (const char **)links, mode);
> -	}
> +
>  	selabel_close(hnd);
>  
>  	if (rc) {
> @@ -153,9 +150,10 @@ int main(int argc, char **argv)
>  		printf("Best match context: %s\n", context);
>  		freecon(context);
>  	}
> +
>  out:
> -	if (num_links != 0) {
> -		for (i = 0; i < num_links; i++)
> +	if (links) {
> +		for (i = 0; links[i]; i++)
>  			free(links[i]);
>  		free(links);
>  	}
> 
