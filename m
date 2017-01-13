Message-ID: <1484322520.32375.50.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: replace all malloc + memset by calloc in
 android label backend.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sandeep Patil <sspatil@google.com>, selinux@tycho.nsa.gov
Date: Fri, 13 Jan 2017 10:48:40 -0500
In-Reply-To: <20170113052026.22069-1-sspatil@google.com>
References: <20170113052026.22069-1-sspatil@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-01-12 at 21:20 -0800, Sandeep Patil wrote:
> Signed-off-by: Sandeep Patil <sspatil@google.com>

Thanks, applied.

> ---
>  libselinux/src/label_backends_android.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/libselinux/src/label_backends_android.c
> b/libselinux/src/label_backends_android.c
> index 4d6ec86..6442104 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -200,10 +200,9 @@ static int init(struct selabel_handle *rec,
> const struct selinux_opt *opts,
>  			}
>  
>  			if (NULL == (data->spec_arr =
> -				     malloc(sizeof(spec_t) * data-
> >nspec)))
> +				     calloc(data->nspec,
> sizeof(spec_t))))
>  				goto finish;
>  
> -			memset(data->spec_arr, 0, sizeof(spec_t) *
> data->nspec);
>  			maxnspec = data->nspec;
>  			rewind(fp);
>  		}
> @@ -322,10 +321,9 @@ int selabel_property_init(struct selabel_handle
> *rec,
>  {
>  	struct saved_data *data;
>  
> -	data = (struct saved_data *)malloc(sizeof(*data));
> +	data = (struct saved_data *)calloc(1, sizeof(*data));
>  	if (!data)
>  		return -1;
> -	memset(data, 0, sizeof(*data));
>  
>  	rec->data = data;
>  	rec->func_close = &closef;
> @@ -340,10 +338,9 @@ int selabel_service_init(struct selabel_handle
> *rec,
>  {
>  	struct saved_data *data;
>  
> -	data = (struct saved_data *)malloc(sizeof(*data));
> +	data = (struct saved_data *)calloc(1, sizeof(*data));
>  	if (!data)
>  		return -1;
> -	memset(data, 0, sizeof(*data));
>  
>  	rec->data = data;
>  	rec->func_close = &closef;
