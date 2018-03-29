To: Yuli Khodorkovskiy <ykhodo@gmail.com>, selinux@tycho.nsa.gov
References: <20180329034003.2231-1-ykhodo@gmail.com>
 <20180329034003.2231-3-ykhodo@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bb100d0a-57d7-22cd-502c-f586f7a2b51f@tycho.nsa.gov>
Date: Thu, 29 Mar 2018 09:49:56 -0400
MIME-Version: 1.0
In-Reply-To: <20180329034003.2231-3-ykhodo@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2 2/2] libselinux: echo line number of bad label in
 selabel_fini()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/28/2018 11:40 PM, Yuli Khodorkovskiy wrote:
> Keep track of line numbers for each file context in
> selabel_handle. If an error occurs in selabel_fini(), the
> line number of an invalid file context is echoed to the user.
> 
> Signed-off-by: Yuli Khodorkovskiy <ykhodo@gmail.com>
> ---
>  libselinux/src/label.c          | 2 +-
>  libselinux/src/label_file.h     | 1 +
>  libselinux/src/label_internal.h | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index e642a97b..d9a58ce9 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -143,7 +143,7 @@ static int selabel_fini(struct selabel_handle *rec,
>  			    struct selabel_lookup_rec *lr,
>  			    int translating)
>  {
> -	if (compat_validate(rec, lr, rec->spec_file, 0))
> +	if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
>  		return -1;
>  
>  	if (translating && !lr->ctx_trans &&
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index aa576d8e..4780ae48 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -472,6 +472,7 @@ static inline int process_line(struct selabel_handle *rec,
>  	spec_arr[nspec].mode = 0;
>  
>  	spec_arr[nspec].lr.ctx_raw = context;
> +	spec_arr[nspec].lr.lineno = lineno;
>  
>  	/*
>  	 * bump data->nspecs to cause closef() to cover it in its free
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
> index c55efb75..0e020557 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -73,6 +73,7 @@ struct selabel_lookup_rec {
>  	char * ctx_raw;
>  	char * ctx_trans;
>  	int validated;
> +	unsigned lineno;
>  };
>  
>  struct selabel_handle {
> 

I think this is ok, but wanted to double check: does this work correctly when file contexts are loaded from
file_contexts.bin instead?  It looks to me as if the lineno will be left as 0 in that case and the
code will handle that correctly.

The other question is whether we correctly report the file name when the entry comes from a file other
than file_contexts itself, e.g. file_contexts.local, .homedirs, ...  Not your bug if we don't but wondered.
