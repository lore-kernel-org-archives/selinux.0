Message-ID: <52658E3D.3010701@tycho.nsa.gov>
Date: Mon, 21 Oct 2013 16:27:41 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Joe MacDonald <joe@deserted.net>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] libselinux: support building on older PCRE libs
References: <1382383000-16439-1-git-send-email-joe@deserted.net> <1382383000-16439-2-git-send-email-joe@deserted.net>
In-Reply-To: <1382383000-16439-2-git-send-email-joe@deserted.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/21/2013 03:16 PM, Joe MacDonald wrote:
> Versions of PCRE prior to 8.20 did not have pcre_free_study().  In its
> absence, use pcre_free() instead.
> 
> Signed-off-by: Joe MacDonald <joe@deserted.net>
> ---
>  libselinux/src/label_file.c           |    4 ++++
>  libselinux/utils/sefcontext_compile.c |    4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 9b0d6b0..51520cf 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -561,7 +561,11 @@ static void closef(struct selabel_handle *rec)
>  		free(spec->type_str);
>  		if (spec->regcomp) {
>  			pcre_free(spec->regex);
> +#if (PCRE_MAJOR >= 8 && PCRE_MINOR >= 20)
>  			pcre_free_study(spec->sd);
> +#else
> +			pcre_free(spec->sd);

We try to avoid #if / #ifdef scattered throughout the code.
The preferred approach is to conditionally define pcre_free_study() to
pcre_free() if building with the older libpcre.


> +#endif
>  		}
>  	}
>  
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
> index 6f79dd6..b34966b 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -301,7 +301,11 @@ static int free_specs(struct saved_data *data)
>  		free(specs[i].lr.ctx_trans);
>  		free(specs[i].regex_str);
>  		pcre_free(specs[i].regex);
> +#if (PCRE_MAJOR >= 8 && PCRE_MINOR >= 20)
>  		pcre_free_study(specs[i].sd);
> +#else
> +		pcre_free(specs[i].sd);
> +#endif
>  	}
>  	free(specs);
>  
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
