Message-ID: <1505939283.31597.11.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Cashman <dcashman@android.com>, selinux@tycho.nsa.gov
Cc: jwcart2@tycho.nsa.gov, dcashman@google.com
Date: Wed, 20 Sep 2017 16:28:03 -0400
In-Reply-To: <20170911180439.26437-1-dcashman@android.com>
References: <20170911180439.26437-1-dcashman@android.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux: libselinux: Enable multiple input files to
 selabel_open.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-09-11 at 11:04 -0700, Daniel Cashman wrote:
> From: Dan Cashman <dcashman@google.com>
> 
> The file_contexts labeling backend, specified in label_file.c,
> currently assumes
> that only one path will be specified as an option to
> selabel_open().  The split
> of platform and non-platform policy on device, however, will
> necessitate the
> loading of two disparate policy files.  Rather than combining the
> files and then
> calling the existing API on a newly-formed file, just add the ability
> to specify
> multiple files to use.  Order of opt specification to selabel_open
> matters.
> 
> This corresponds to AOSP commit
> 50400d38203e4db08314168e60c281cc61a717a8, which
> lead to a fork with upstream, which we'd like to correct.

We need to update the other label backends as well, at least
sufficiently to still build, even if they only support a single path.

> 
> Signed-off-by: Dan Cashman <dcashman@android.com>
> ---
>  libselinux/src/label.c          |  21 +++++---
>  libselinux/src/label_file.c     | 104 +++++++++++++++++++++++++++++-
> ----------
>  libselinux/src/label_internal.h |   5 +-
>  3 files changed, 94 insertions(+), 36 deletions(-)
> 
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 48f4d2d6..0dfa054c 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -143,7 +143,11 @@ static int selabel_fini(struct selabel_handle
> *rec,
>  			    struct selabel_lookup_rec *lr,
>  			    int translating)
>  {
> -	if (compat_validate(rec, lr, rec->spec_file, 0))
> +	char *path = NULL;
> +
> +	if (rec->spec_files)
> +		path = rec->spec_files[0];
> +	if (compat_validate(rec, lr, path, 0))
>  		return -1;
>  
>  	if (translating && !lr->ctx_trans &&
> @@ -226,11 +230,9 @@ struct selabel_handle *selabel_open(unsigned int
> backend,
>  	rec->digest = selabel_is_digest_set(opts, nopts, rec-
> >digest);
>  
>  	if ((*initfuncs[backend])(rec, opts, nopts)) {
> -		free(rec->spec_file);
> -		free(rec);
> +		selabel_close(rec);
>  		rec = NULL;
>  	}
> -
>  out:
>  	return rec;
>  }
> @@ -337,10 +339,17 @@ int selabel_digest(struct selabel_handle *rec,
>  
>  void selabel_close(struct selabel_handle *rec)
>  {
> +	size_t i;
> +
> +	if (rec->spec_files) {
> +		for (i = 0; i < rec->spec_files_len; i++)
> +			free(rec->spec_files[i]);
> +		free(rec->spec_files);
> +	}
>  	if (rec->digest)
>  		selabel_digest_fini(rec->digest);
> -	rec->func_close(rec);
> -	free(rec->spec_file);
> +	if (rec->func_close)
> +		rec->func_close(rec);
>  	free(rec);
>  }
>  
> diff --git a/libselinux/src/label_file.c
> b/libselinux/src/label_file.c
> index 560d8c3d..b3b36bc2 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -709,28 +709,61 @@ static int init(struct selabel_handle *rec,
> const struct selinux_opt *opts,
>  		unsigned n)
>  {
>  	struct saved_data *data = (struct saved_data *)rec->data;
> -	const char *path = NULL;
> +	size_t num_paths = 0;
> +	char **path = NULL;
>  	const char *prefix = NULL;
> -	int status = -1, baseonly = 0;
> +	int status = -1;
> +	size_t i;
> +	bool baseonly = false;
> +	bool path_provided;
>  
>  	/* Process arguments */
> -	while (n--)
> -		switch(opts[n].type) {
> +	i = n;
> +	while (i--)
> +		switch(opts[i].type) {
>  		case SELABEL_OPT_PATH:
> -			path = opts[n].value;
> +			num_paths++;
>  			break;
>  		case SELABEL_OPT_SUBSET:
> -			prefix = opts[n].value;
> +			prefix = opts[i].value;
>  			break;
>  		case SELABEL_OPT_BASEONLY:
> -			baseonly = !!opts[n].value;
> +			baseonly = !!opts[i].value;
>  			break;
>  		}
>  
> +	if (!num_paths) {
> +		num_paths = 1;
> +		path_provided = false;
> +	} else {
> +		path_provided = true;
> +	}
> +
> +	path = calloc(num_paths, sizeof(*path));
> +	if (path == NULL) {
> +		goto finish;
> +	}
> +	rec->spec_files = path;
> +	rec->spec_files_len = num_paths;
> +
> +	if (path_provided) {
> +		for (i = 0; i < n; i++) {
> +			switch(opts[i].type) {
> +			case SELABEL_OPT_PATH:
> +				*path = strdup(opts[i].value);
> +				if (*path == NULL)
> +					goto finish;
> +				path++;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
>  #if !defined(BUILD_HOST) && !defined(ANDROID)
>  	char subs_file[PATH_MAX + 1];
>  	/* Process local and distribution substitution files */
> -	if (!path) {
> +	if (!path_provided) {
>  		status = selabel_subs_init(
>  			selinux_file_context_subs_dist_path(),
>  			rec->digest, &data->dist_subs);
> @@ -740,43 +773,52 @@ static int init(struct selabel_handle *rec,
> const struct selinux_opt *opts,
>  			rec->digest, &data->subs);
>  		if (status)
>  			goto finish;
> -		path = selinux_file_context_path();
> +		rec->spec_files[0] =
> strdup(selinux_file_context_path());
> +		if (rec->spec_files[0] == NULL)
> +			goto finish;
>  	} else {
> -		snprintf(subs_file, sizeof(subs_file),
> "%s.subs_dist", path);
> -		status = selabel_subs_init(subs_file, rec->digest,
> +		for (i = 0; i < num_paths; i++) {
> +			snprintf(subs_file, sizeof(subs_file),
> "%s.subs_dist", rec->spec_files[i]);
> +			status = selabel_subs_init(subs_file, rec-
> >digest,
>  					   &data->dist_subs);
> -		if (status)
> -			goto finish;
> -		snprintf(subs_file, sizeof(subs_file), "%s.subs",
> path);
> -		status = selabel_subs_init(subs_file, rec->digest,
> +			if (status)
> +				goto finish;
> +			snprintf(subs_file, sizeof(subs_file),
> "%s.subs", rec->spec_files[i]);
> +			status = selabel_subs_init(subs_file, rec-
> >digest,
>  					   &data->subs);
> -		if (status)
> -			goto finish;
> +			if (status)
> +				goto finish;
> +		}
> +	}
> +#else
> +	if (!path_provided) {
> +		selinux_log(SELINUX_ERROR, "No path given to file
> labeling backend\n");
> +		goto finish;
>  	}
> -
>  #endif
> -	rec->spec_file = strdup(path);
>  
>  	/*
> -	 * The do detailed validation of the input and fill the spec
> array
> +	 * Do detailed validation of the input and fill the spec
> array
>  	 */
> -	status = process_file(path, NULL, rec, prefix, rec->digest);
> -	if (status)
> -		goto finish;
> -
> -	if (rec->validating) {
> -		status = nodups_specs(data, path);
> +	for (i = 0; i < num_paths; i++) {
> +		status = process_file(rec->spec_files[i], NULL, rec,
> prefix, rec->digest);
>  		if (status)
>  			goto finish;
> +
> +		if (rec->validating) {
> +			status = nodups_specs(data, rec-
> >spec_files[i]);
> +			if (status)
> +				goto finish;
> +		}
>  	}
>  
>  	if (!baseonly) {
> -		status = process_file(path, "homedirs", rec, prefix,
> +		status = process_file(rec->spec_files[0],
> "homedirs", rec, prefix,
>  							    rec-
> >digest);
>  		if (status && errno != ENOENT)
>  			goto finish;
>  
> -		status = process_file(path, "local", rec, prefix,
> +		status = process_file(rec->spec_files[0], "local",
> rec, prefix,
>  							    rec-
> >digest);
>  		if (status && errno != ENOENT)
>  			goto finish;
> @@ -804,6 +846,12 @@ static void closef(struct selabel_handle *rec)
>  	struct stem *stem;
>  	unsigned int i;
>  
> +	if (!data)
> +		return;
> +
> +	/* make sure successive ->func_close() calls are harmless */
> +	rec->data = NULL;
> +
>  	selabel_subs_fini(data->subs);
>  	selabel_subs_fini(data->dist_subs);
>  
> diff --git a/libselinux/src/label_internal.h
> b/libselinux/src/label_internal.h
> index c55efb75..43b63513 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -98,10 +98,11 @@ struct selabel_handle {
>  	void *data;
>  
>  	/*
> -	 * The main spec file used. Note for file contexts the local
> and/or
> +	 * The main spec file(s) used. Note for file contexts the
> local and/or
>  	 * homedirs could also have been used to resolve a context.
>  	 */
> -	char *spec_file;
> +	size_t spec_files_len;
> +	char **spec_files;
>  
>  	/* ptr to SHA1 hash information if SELABEL_OPT_DIGEST set */
>  	struct selabel_digest *digest;
