Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5OGacxV002168
 for <selinux@tycho.nsa.gov>; Wed, 24 Jun 2015 12:36:38 -0400
Message-ID: <558ADC86.8090108@tresys.com>
Date: Wed, 24 Jun 2015 12:36:22 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Allow to use compressed modules without a compression
 extension
References: <1435162011-598-1-git-send-email-plautrba@redhat.com>
In-Reply-To: <1435162011-598-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/24/2015 12:06 PM, Petr Lautrbach wrote:
> When a compressed module doesn't have two extensions with lang and
> compression, 'semodule -i <module>.<lang>' fails. This changes the
> language detection to allow to use modules only with .<lang>
> extension.
> 
> Fixes:
> libsemanage.semanage_direct_install_file: Module does not have a valid
> extension. (No such file or directory).
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Ack-by: Steve Lawrence <slawrence@tresys.com>

Thanks and applied.

> ---
>  libsemanage/src/direct_api.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index e4f168e..d57f934 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1435,7 +1435,7 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
>  	int in_fd = -1;
>  	char *path = NULL;
>  	char *filename;
> -	char *lang_ext;
> +	char *lang_ext = NULL;
>  	char *separator;
>  
>  	if ((in_fd = open(install_filename, O_RDONLY)) == -1) {
> @@ -1467,17 +1467,20 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
>  			goto cleanup;
>  		}
>  		*separator = '\0';
> +		lang_ext = separator + 1;
>  	}
>  
>  	separator = strrchr(filename, '.');
>  	if (separator == NULL) {
> -		ERR(sh, "Module does not have a valid extension.");
> -		retval = -1;
> -		goto cleanup;
> +		if (lang_ext == NULL) {
> +			ERR(sh, "Module does not have a valid extension.");
> +			retval = -1;
> +			goto cleanup;
> +		}
> +	} else {
> +		*separator = '\0';
> +		lang_ext = separator + 1;
>  	}
> -	*separator = '\0';
> -
> -	lang_ext = separator + 1;
>  
>  	retval = semanage_direct_install(sh, data, data_len, filename, lang_ext);
>  
> 
