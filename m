Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9ALJIM9029043
 for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2017 17:19:18 -0400
Received: by mail-pf0-f173.google.com with SMTP id x7so8262035pfa.1
 for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2017 14:19:02 -0700 (PDT)
To: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Cc: jwcart2@tycho.nsa.gov, Dan Cashman <dcashman@google.com>
References: <1505939283.31597.11.camel@tycho.nsa.gov>
 <20171010211257.18474-1-dcashman@android.com>
From: Dan Cashman <dcashman@android.com>
Message-ID: <7126d75f-f70d-cf20-d703-2f974b2b6c3b@android.com>
Date: Tue, 10 Oct 2017 14:19:00 -0700
MIME-Version: 1.0
In-Reply-To: <20171010211257.18474-1-dcashman@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] selinux: libselinux: Enable multiple input
 files to selabel_open.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/10/2017 02:12 PM, Daniel Cashman wrote:
> From: Dan Cashman <dcashman@google.com>
> 
> The file_contexts labeling backend, specified in label_file.c, currently assumes
> that only one path will be specified as an option to selabel_open().  The split
> of platform and non-platform policy on device, however, will necessitate the
> loading of two disparate policy files.  Rather than combining the files and then
> calling the existing API on a newly-formed file, just add the ability to specify
> multiple files to use.  Order of opt specification to selabel_open matters.
> 
> This corresponds to AOSP commit 50400d38203e4db08314168e60c281cc61a717a8, which
> lead to a fork with upstream, which we'd like to correct.
> 
> Signed-off-by: Dan Cashman <dcashman@android.com>
> ---
>   libselinux/src/label.c          |  21 +++++---
>   libselinux/src/label_db.c       |   4 +-
>   libselinux/src/label_file.c     | 104 +++++++++++++++++++++++++++++-----------
>   libselinux/src/label_internal.h |   5 +-
>   libselinux/src/label_media.c    |   4 +-
>   libselinux/src/label_x.c        |   4 +-
>   6 files changed, 103 insertions(+), 39 deletions(-)
> 
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 48f4d2d6..0dfa054c 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -143,7 +143,11 @@ static int selabel_fini(struct selabel_handle *rec,
>   			    struct selabel_lookup_rec *lr,
>   			    int translating)
>   {
> -	if (compat_validate(rec, lr, rec->spec_file, 0))
> +	char *path = NULL;
> +
> +	if (rec->spec_files)
> +		path = rec->spec_files[0];
> +	if (compat_validate(rec, lr, path, 0))
>   		return -1;
>   
>   	if (translating && !lr->ctx_trans &&
> @@ -226,11 +230,9 @@ struct selabel_handle *selabel_open(unsigned int backend,
>   	rec->digest = selabel_is_digest_set(opts, nopts, rec->digest);
>   
>   	if ((*initfuncs[backend])(rec, opts, nopts)) {
> -		free(rec->spec_file);
> -		free(rec);
> +		selabel_close(rec);
>   		rec = NULL;
>   	}
> -
>   out:
>   	return rec;
>   }
> @@ -337,10 +339,17 @@ int selabel_digest(struct selabel_handle *rec,
>   
>   void selabel_close(struct selabel_handle *rec)
>   {
> +	size_t i;
> +
> +	if (rec->spec_files) {
> +		for (i = 0; i < rec->spec_files_len; i++)
> +			free(rec->spec_files[i]);
> +		free(rec->spec_files);
> +	}
>   	if (rec->digest)
>   		selabel_digest_fini(rec->digest);
> -	rec->func_close(rec);
> -	free(rec->spec_file);
> +	if (rec->func_close)
> +		rec->func_close(rec);
>   	free(rec);
>   }
>   
> diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> index c46d0a1d..205ff5f4 100644
> --- a/libselinux/src/label_db.c
> +++ b/libselinux/src/label_db.c
> @@ -290,7 +290,9 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
>   		errno = EINVAL;
>   		return NULL;
>   	}
> -	rec->spec_file = strdup(path);
> +	rec->spec_files_len = 1;
> +	rec->spec_files = calloc(rec->spec_files_len, sizeof(path))
> +	rec->spec_files[0] = strdup(path);
>   
>   	/*
>   	 * Parse for each lines
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 560d8c3d..b3b36bc2 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -709,28 +709,61 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>   		unsigned n)
>   {
>   	struct saved_data *data = (struct saved_data *)rec->data;
> -	const char *path = NULL;
> +	size_t num_paths = 0;
> +	char **path = NULL;
>   	const char *prefix = NULL;
> -	int status = -1, baseonly = 0;
> +	int status = -1;
> +	size_t i;
> +	bool baseonly = false;
> +	bool path_provided;
>   
>   	/* Process arguments */
> -	while (n--)
> -		switch(opts[n].type) {
> +	i = n;
> +	while (i--)
> +		switch(opts[i].type) {
>   		case SELABEL_OPT_PATH:
> -			path = opts[n].value;
> +			num_paths++;
>   			break;
>   		case SELABEL_OPT_SUBSET:
> -			prefix = opts[n].value;
> +			prefix = opts[i].value;
>   			break;
>   		case SELABEL_OPT_BASEONLY:
> -			baseonly = !!opts[n].value;
> +			baseonly = !!opts[i].value;
>   			break;
>   		}
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
>   #if !defined(BUILD_HOST) && !defined(ANDROID)
>   	char subs_file[PATH_MAX + 1];
>   	/* Process local and distribution substitution files */
> -	if (!path) {
> +	if (!path_provided) {
>   		status = selabel_subs_init(
>   			selinux_file_context_subs_dist_path(),
>   			rec->digest, &data->dist_subs);
> @@ -740,43 +773,52 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>   			rec->digest, &data->subs);
>   		if (status)
>   			goto finish;
> -		path = selinux_file_context_path();
> +		rec->spec_files[0] = strdup(selinux_file_context_path());
> +		if (rec->spec_files[0] == NULL)
> +			goto finish;
>   	} else {
> -		snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", path);
> -		status = selabel_subs_init(subs_file, rec->digest,
> +		for (i = 0; i < num_paths; i++) {
> +			snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", rec->spec_files[i]);
> +			status = selabel_subs_init(subs_file, rec->digest,
>   					   &data->dist_subs);
> -		if (status)
> -			goto finish;
> -		snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
> -		status = selabel_subs_init(subs_file, rec->digest,
> +			if (status)
> +				goto finish;
> +			snprintf(subs_file, sizeof(subs_file), "%s.subs", rec->spec_files[i]);
> +			status = selabel_subs_init(subs_file, rec->digest,
>   					   &data->subs);
> -		if (status)
> -			goto finish;
> +			if (status)
> +				goto finish;
> +		}
> +	}
> +#else
> +	if (!path_provided) {
> +		selinux_log(SELINUX_ERROR, "No path given to file labeling backend\n");
> +		goto finish;
>   	}
> -
>   #endif
> -	rec->spec_file = strdup(path);
>   
>   	/*
> -	 * The do detailed validation of the input and fill the spec array
> +	 * Do detailed validation of the input and fill the spec array
>   	 */
> -	status = process_file(path, NULL, rec, prefix, rec->digest);
> -	if (status)
> -		goto finish;
> -
> -	if (rec->validating) {
> -		status = nodups_specs(data, path);
> +	for (i = 0; i < num_paths; i++) {
> +		status = process_file(rec->spec_files[i], NULL, rec, prefix, rec->digest);
>   		if (status)
>   			goto finish;
> +
> +		if (rec->validating) {
> +			status = nodups_specs(data, rec->spec_files[i]);
> +			if (status)
> +				goto finish;
> +		}
>   	}
>   
>   	if (!baseonly) {
> -		status = process_file(path, "homedirs", rec, prefix,
> +		status = process_file(rec->spec_files[0], "homedirs", rec, prefix,
>   							    rec->digest);
>   		if (status && errno != ENOENT)
>   			goto finish;
>   
> -		status = process_file(path, "local", rec, prefix,
> +		status = process_file(rec->spec_files[0], "local", rec, prefix,
>   							    rec->digest);
>   		if (status && errno != ENOENT)
>   			goto finish;
> @@ -804,6 +846,12 @@ static void closef(struct selabel_handle *rec)
>   	struct stem *stem;
>   	unsigned int i;
>   
> +	if (!data)
> +		return;
> +
> +	/* make sure successive ->func_close() calls are harmless */
> +	rec->data = NULL;
> +
>   	selabel_subs_fini(data->subs);
>   	selabel_subs_fini(data->dist_subs);
>   
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
> index c55efb75..43b63513 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -98,10 +98,11 @@ struct selabel_handle {
>   	void *data;
>   
>   	/*
> -	 * The main spec file used. Note for file contexts the local and/or
> +	 * The main spec file(s) used. Note for file contexts the local and/or
>   	 * homedirs could also have been used to resolve a context.
>   	 */
> -	char *spec_file;
> +	size_t spec_files_len;
> +	char **spec_files;
>   
>   	/* ptr to SHA1 hash information if SELABEL_OPT_DIGEST set */
>   	struct selabel_digest *digest;
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index d202e5d5..f4a46ffe 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -100,7 +100,9 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>   		errno = EINVAL;
>   		return -1;
>   	}
> -	rec->spec_file = strdup(path);
> +	rec->spec_files_len = 1;
> +	rec->spec_files = calloc(rec->spec_files_len, sizeof(path))
> +	rec->spec_files[0] = strdup(path);
>   
>   	/*
>   	 * Perform two passes over the specification file.
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index 96745299..54ebd2eb 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -127,7 +127,9 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>   		errno = EINVAL;
>   		return -1;
>   	}
> -	rec->spec_file = strdup(path);
> +	rec->spec_files_len = 1;
> +	rec->spec_files = calloc(rec->spec_files_len, sizeof(path))
> +	rec->spec_files[0] = strdup(path);
>   
>   	/*
>   	 * Perform two passes over the specification file.
> 

Sorry, I completely overlooked the non-compilation of the other 
backends. I actually would like to see us integrate the upstream
tests and build so that we're not just flying by the android build 
system, but for now I think this is all that is required.  I'll be 
sending a follow-up patch for the android backends that is basically
AOSP commit: c75d01302f68d7714235600bd5b237bae2e8b893.

Thanks,
Dan
