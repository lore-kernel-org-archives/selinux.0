Message-ID: <557EE110.5050501@tycho.nsa.gov>
Date: Mon, 15 Jun 2015 10:28:32 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: Fix property processing and cleanup formatting
References: <1434371648-2737-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1434371648-2737-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/15/2015 08:34 AM, Richard Haines wrote:
> Fix memory issues flagged by valgrind.
> These changes bring the property service in line with Android [1]
> apart from some minor build differences.
> 
> [1] https://android-review.googlesource.com/#/c/153580/
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/src/label_android_property.c | 62 ++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 28 deletions(-)
> 
> diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
> index dadb160..1160777 100644
> --- a/libselinux/src/label_android_property.c
> +++ b/libselinux/src/label_android_property.c
> @@ -95,32 +97,35 @@ static int process_line(struct selabel_handle *rec,
>  		selinux_log(SELINUX_WARNING,
>  			    "%s:  line %u is missing fields, skipping\n", path,
>  			    lineno);
> +		free(prop);
>  		return 0;
>  	}
>  
> -	if (pass == 1) {
> +	if (pass == 0) {
> +		free(prop);
> +		free(context);
> +	} else if (pass == 1) {
>  		/* On the second pass, process and store the specification in spec. */
> -		spec_arr[nspec].property_key = strdup(prop);
> +		spec_arr[nspec].property_key = prop;
>  		if (!spec_arr[nspec].property_key) {
>  			selinux_log(SELINUX_WARNING,
> -				    "%s:  out of memory at line %u on prop %s\n",
> +				    "%s:  out of memory at line %d on prop %s\n",

No, this is wrong in Android and correct upstream; it was fixed upstream
by commit 417cb8d076a31c57710429b255aebc595613eb6b

>  				    path, lineno, prop);
> -			return -1;
> -
> +		return -1;

Likewise, fixed in commit 30900902b16c70fabe78a22aafb120443acdd53c upstream.

>  		}
>  
> -		spec_arr[nspec].lr.ctx_raw = strdup(context);
> +		spec_arr[nspec].lr.ctx_raw = context;
>  		if (!spec_arr[nspec].lr.ctx_raw) {
>  			selinux_log(SELINUX_WARNING,
> -				    "%s:  out of memory at line %u on context %s\n",
> +				    "%s:  out of memory at line %d on context %s\n",
>  				    path, lineno, context);
> -			return -1;
> +		return -1;

Ditto

>  		}
>  
>  		if (rec->validating) {
>  			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
>  				selinux_log(SELINUX_WARNING,
> -					    "%s:  line %u has invalid context %s\n",
> +					    "%s:  line %d has invalid context %s\n",
>  					    path, lineno, spec_arr[nspec].lr.ctx_raw);

Ditto
