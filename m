Message-ID: <1495112341.5475.1.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] libselinux: propagate selabel_subs_init() errors
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Thu, 18 May 2017 08:59:01 -0400
In-Reply-To: <20170517205146.18315-2-nicolas.iooss@m4x.org>
References: <20170517205146.18315-1-nicolas.iooss@m4x.org>
 <20170517205146.18315-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-05-17 at 22:51 +0200, Nicolas Iooss wrote:
> Memory allocation failures in selabel_subs_init() should be fatal,
> contrary to failures which come from the non-existence of the
> substitution files (subs or subs_dist).
> 
> Modify selabel_subs_init()'s prototype in order to return the error
> state. This forces the pointer to the created substitution list to be
> moved to an output function argument.

Thanks, applied both.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libselinux/src/label.c          | 18 ++++++++++++------
>  libselinux/src/label_file.c     | 24 +++++++++++++++++-------
>  libselinux/src/label_internal.h |  4 ++--
>  3 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 70f6809ead2f..b27c103a95fc 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -91,16 +91,20 @@ static char *selabel_sub(struct selabel_sub *ptr,
> const char *src)
>  	return NULL;
>  }
>  
> -struct selabel_sub *selabel_subs_init(const char *path,
> -				      struct selabel_digest *digest)
> +int selabel_subs_init(const char *path, struct selabel_digest
> *digest,
> +		       struct selabel_sub **out_subs)
>  {
>  	char buf[1024];
>  	FILE *cfg = fopen(path, "re");
>  	struct selabel_sub *list = NULL, *sub = NULL;
>  	struct stat sb;
> +	int status = -1;
>  
> -	if (!cfg)
> -		return list;
> +	*out_subs = NULL;
> +	if (!cfg) {
> +		/* If the file does not exist, it is not fatal */
> +		return (errno == ENOENT) ? 0 : -1;
> +	}
>  
>  	if (fstat(fileno(cfg), &sb) < 0)
>  		goto out;
> @@ -151,9 +155,12 @@ struct selabel_sub *selabel_subs_init(const char
> *path,
>  	if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path)
> < 0)
>  		goto err;
>  
> +	*out_subs = list;
> +	status = 0;
> +
>  out:
>  	fclose(cfg);
> -	return list;
> +	return status;
>  err:
>  	if (sub)
>  		free(sub->src);
> @@ -165,7 +172,6 @@ err:
>  		free(list);
>  		list = sub;
>  	}
> -	list = NULL;
>  	goto out;
>  }
>  
> diff --git a/libselinux/src/label_file.c
> b/libselinux/src/label_file.c
> index 3ff759032cc1..c05b37a56efe 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -587,17 +587,27 @@ static int init(struct selabel_handle *rec,
> const struct selinux_opt *opts,
>  	char subs_file[PATH_MAX + 1];
>  	/* Process local and distribution substitution files */
>  	if (!path) {
> -		rec->dist_subs =
> -		    selabel_subs_init(selinux_file_context_subs_dist
> _path(),
> -		    rec->digest);
> -		rec->subs =
> selabel_subs_init(selinux_file_context_subs_path(),
> -		    rec->digest);
> +		status = selabel_subs_init(
> +			selinux_file_context_subs_dist_path(),
> +			rec->digest, &rec->dist_subs);
> +		if (status)
> +			goto finish;
> +		status =
> selabel_subs_init(selinux_file_context_subs_path(),
> +			rec->digest, &rec->subs);
> +		if (status)
> +			goto finish;
>  		path = selinux_file_context_path();
>  	} else {
>  		snprintf(subs_file, sizeof(subs_file),
> "%s.subs_dist", path);
> -		rec->dist_subs = selabel_subs_init(subs_file, rec-
> >digest);
> +		status = selabel_subs_init(subs_file, rec->digest,
> +					   &rec->dist_subs);
> +		if (status)
> +			goto finish;
>  		snprintf(subs_file, sizeof(subs_file), "%s.subs",
> path);
> -		rec->subs = selabel_subs_init(subs_file, rec-
> >digest);
> +		status = selabel_subs_init(subs_file, rec->digest,
> +					   &rec->subs);
> +		if (status)
> +			goto finish;
>  	}
>  
>  #endif
> diff --git a/libselinux/src/label_internal.h
> b/libselinux/src/label_internal.h
> index b03652ebc477..10f1e57850e1 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -75,8 +75,8 @@ extern int digest_add_specfile(struct
> selabel_digest *digest, FILE *fp,
>  						    const char
> *path);
>  extern void digest_gen_hash(struct selabel_digest *digest);
>  
> -extern struct selabel_sub *selabel_subs_init(const char *path,
> -				    struct selabel_digest *digest);
> +extern int selabel_subs_init(const char *path, struct selabel_digest
> *digest,
> +			     struct selabel_sub **out_subs);
>  
>  struct selabel_lookup_rec {
>  	char * ctx_raw;
