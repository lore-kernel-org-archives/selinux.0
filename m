Message-ID: <554A3AAE.9030908@tycho.nsa.gov>
Date: Wed, 06 May 2015 12:00:46 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: Add selabel partial and best match APIs
References: <1430925063-9248-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1430925063-9248-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/06/2015 11:11 AM, Richard Haines wrote:
> Add support for new API functions selabel_partial_match and
> selabel_lookup_best_match ported from the Android libselinux
> fork.
> 
> Add supporting man(3) pages and test utilities: selabel_lookup,
> selabel_lookup_best_match and selabel_partial_match.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
>  libselinux/include/selinux/label.h                 |   8 +
>  libselinux/man/man3/selabel_lookup_best_match.3    | 100 +++++++++++
>  .../man/man3/selabel_lookup_best_match_raw.3       |   1 +
>  libselinux/man/man3/selabel_partial_match.3        |  34 ++++
>  libselinux/src/label.c                             | 182 +++++++++++++++++----
>  libselinux/src/label_file.c                        | 109 ++++++++++--
>  libselinux/src/label_file.h                        |   1 +
>  libselinux/src/label_internal.h                    |   6 +
>  libselinux/utils/selabel_lookup.c                  | 126 ++++++++++++++
>  libselinux/utils/selabel_lookup_best_match.c       | 164 +++++++++++++++++++
>  libselinux/utils/selabel_partial_match.c           |  75 +++++++++
>  11 files changed, 760 insertions(+), 46 deletions(-)
>  create mode 100644 libselinux/man/man3/selabel_lookup_best_match.3
>  create mode 100644 libselinux/man/man3/selabel_lookup_best_match_raw.3
>  create mode 100644 libselinux/man/man3/selabel_partial_match.3
>  create mode 100644 libselinux/utils/selabel_lookup.c
>  create mode 100644 libselinux/utils/selabel_lookup_best_match.c
>  create mode 100644 libselinux/utils/selabel_partial_match.c
> 
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
> index 672a7c2..7a94a92 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -6,6 +6,7 @@
>  #ifndef _SELABEL_H_
>  #define _SELABEL_H_
>  
> +#include <stdbool.h>
>  #include <sys/types.h>
>  #include <selinux/selinux.h>
>  
> @@ -97,6 +98,13 @@ int selabel_lookup(struct selabel_handle *handle, char **con,
>  int selabel_lookup_raw(struct selabel_handle *handle, char **con,
>  		       const char *key, int type);
>  
> +bool selabel_partial_match(struct selabel_handle *handle, const char *key);
> +
> +int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
> +			      const char *key, const char **aliases, int type);
> +int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
> +			      const char *key, const char **aliases, int type);
> +
>  /**
>   * selabel_stats - log labeling operation statistics.
>   * @handle: specifies backend instance to query
> diff --git a/libselinux/man/man3/selabel_lookup_best_match.3 b/libselinux/man/man3/selabel_lookup_best_match.3
> new file mode 100644
> index 0000000..ef2efb4
> --- /dev/null
> +++ b/libselinux/man/man3/selabel_lookup_best_match.3
> @@ -0,0 +1,100 @@
> +.TH "selabel_lookup_best_match" "3" "05 May 2015" "Security Enhanced Linux" "SELinux API documentation"
> +
> +.SH "NAME"
> +selabel_lookup_best_match \- obtain a best match SELinux security
> +context \- Only supported on file backend.
> +.
> +.SH "SYNOPSIS"
> +.B #include <selinux/selinux.h>
> +.br
> +.B #include <selinux/label.h>
> +.sp
> +.BI "int selabel_lookup_best_match(struct selabel_handle *" hnd ,
> +.in +\w'int selabel_lookup_best_match('u
> +.BI "char **" context ,
> +.br
> +.BI "const char *" key ,
> +.br
> +.BI "const char **" links ,
> +.br
> +.BI "int " type ");"
> +.in
> +.sp
> +.BI "int selabel_lookup_best_match_raw(struct selabel_handle *" hnd ,
> +.in +\w'int selabel_lookup_best_match_raw('u
> +.BI "char **" context ,
> +.br
> +.BI "const char *" key ,
> +.br
> +.BI "const char **" links ,
> +.br
> +.BI "int " type ");"
> +.in
> +.
> +.SH "DESCRIPTION"
> +.BR selabel_lookup_best_match ()
> +performs a best match lookup operation on the handle
> +.IR hnd ,
> +returning the result in the memory pointed to by
> +.IR context ,
> +which must be freed by the caller using
> +.BR freecon (3).
> +The \fIkey\fR parameter is a file path to check for best match using zero or
> +more \fIlink\fR (aliases) parameters. The order of precedence for best match is:
> +.RS
> +.IP "1." 4
> +An exact match for the real path (\fIkey\fR) or
> +.IP "2." 4
> +An exact match for any of the \fIlink\fRs (aliases), or
> +.IP "3." 4
> +The longest fixed prefix match.
> +.RE
> +.sp
> +The \fItype\fR parameter is an optional file \fImode\fR argument that should
> +be set to the mode bits of the file, as determined by \fBlstat\fR(2).
> +\fImode\fR may be zero, however full matching may not occur.
> +
> +.BR selabel_lookup_best_match_raw ()
> +behaves identically to
> +.BR selabel_lookup_best_match ()
> +but does not perform context translation.
> +.
> +.SH "RETURN VALUE"
> +On success, zero is returned.  On error, \-1 is returned and
> +.I errno
> +is set appropriately.
> +.
> +.SH "ERRORS"
> +.TP
> +.B ENOENT
> +No context corresponding to the input
> +.I key
> +and
> +.I type
> +was found.
> +.TP
> +.B EINVAL
> +The
> +.I key
> +and/or
> +.I type
> +inputs are invalid, or the context being returned failed validation.
> +.TP
> +.B ENOMEM
> +An attempt to allocate memory failed.
> +.sp
> +.SH "NOTES"
> +Example usage - When a service creates a device node, it may also create one
> +or more symlinks to the device node.  These symlinks may be the only stable
> +name for the device, e.g. if the partition is dynamically assigned.
> +The file label backend supports this by looking up the "best match"
> +for a device node based on its real path (\fIkey\fR) and any \fIlink\fRs to it
> +(aliases). The order of precedence for best match is described above.
> +.sp
> +.SH "SEE ALSO"
> +.BR selabel_open (3),
> +.BR selabel_stats (3),
> +.BR selinux_set_callback (3),
> +.BR selinux (8),
> +.BR lstat (2),
> +.BR selabel_file (5)
> diff --git a/libselinux/man/man3/selabel_lookup_best_match_raw.3 b/libselinux/man/man3/selabel_lookup_best_match_raw.3
> new file mode 100644
> index 0000000..8982f17
> --- /dev/null
> +++ b/libselinux/man/man3/selabel_lookup_best_match_raw.3
> @@ -0,0 +1 @@
> +.so man3/selabel_lookup_best_match.3
> diff --git a/libselinux/man/man3/selabel_partial_match.3 b/libselinux/man/man3/selabel_partial_match.3
> new file mode 100644
> index 0000000..4cd46f7
> --- /dev/null
> +++ b/libselinux/man/man3/selabel_partial_match.3
> @@ -0,0 +1,34 @@
> +.TH "selabel_partial_match" "3" "05 May 2015" "Security Enhanced Linux" "SELinux API documentation"
> +
> +.SH "NAME"
> +selabel_partial_match \- determine whether a direct or partial match is
> +possible on a file path \- Only supported on file backend.
> +.
> +.SH "SYNOPSIS"
> +.B #include <stdbool.h>
> +.br
> +.B #include <selinux/selinux.h>
> +.br
> +.B #include <selinux/label.h>
> +.sp
> +.BI "bool selabel_partial_match(struct selabel_handle *" hnd ,
> +.in +\w'int selabel_partial_match('u
> +.BI "const char *" key ");"
> +.in
> +.
> +.SH "DESCRIPTION"
> +.BR selabel_partial_match ()
> +performs a partial match operation on the handle
> +.IR hnd ,
> +returning TRUE or FALSE.
> +The \fIkey\fR parameter is a file path to check for a direct or partial match.
> +.sp
> +.SH "RETURN VALUE"
> +TRUE is returned if a direct or partial match is found, FALSE if not.
> +.sp
> +.SH "SEE ALSO"
> +.BR selabel_open (3),
> +.BR selabel_stats (3),
> +.BR selinux_set_callback (3),
> +.BR selinux (8),
> +.BR selabel_file (5)
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index c3c099e..759a3fa 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -154,6 +154,98 @@ out:
>  	return rc;
>  }
>  
> +/* Public API helpers */
> +static char *selabel_sub_key(struct selabel_handle *rec, const char *key)
> +{
> +	char *ptr = NULL;
> +	char *dptr = NULL;
> +
> +	ptr = selabel_sub(rec->subs, key);
> +	if (ptr) {
> +		dptr = selabel_sub(rec->dist_subs, ptr);
> +		if (dptr) {
> +			free(ptr);
> +			ptr = dptr;
> +		}
> +	} else {
> +		ptr = selabel_sub(rec->dist_subs, key);
> +	}
> +	if (ptr)
> +		return ptr;
> +
> +	return NULL;
> +}
> +
> +static int selabel_fini(struct selabel_handle *rec,
> +			    struct selabel_lookup_rec *lr,
> +			    int translating)
> +{
> +	if (compat_validate(rec, lr, rec->spec_file, 0))
> +		return -1;
> +
> +	if (translating && !lr->ctx_trans &&
> +	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static struct selabel_lookup_rec *
> +selabel_lookup_common(struct selabel_handle *rec, int translating,
> +		      const char *key, int type)
> +{
> +	struct selabel_lookup_rec *lr;
> +	char *ptr = NULL;
> +
> +	if (key == NULL) {
> +		errno = EINVAL;
> +		return NULL;
> +	}
> +
> +	ptr = selabel_sub_key(rec, key);
> +	if (ptr) {
> +		lr = rec->func_lookup(rec, ptr, type);
> +		free(ptr);
> +	} else {
> +		lr = rec->func_lookup(rec, key, type);
> +	}
> +	if (!lr)
> +		return NULL;
> +
> +	if (selabel_fini(rec, lr, translating))
> +		return NULL;
> +
> +	return lr;
> +}
> +
> +static struct selabel_lookup_rec *
> +selabel_lookup_bm_common(struct selabel_handle *rec, int translating,
> +		      const char *key, int type, const char **aliases)
> +{
> +	struct selabel_lookup_rec *lr;
> +	char *ptr = NULL;
> +
> +	if (key == NULL) {
> +		errno = EINVAL;
> +		return NULL;
> +	}
> +
> +	ptr = selabel_sub_key(rec, key);
> +	if (ptr) {
> +		lr = rec->func_lookup_best_match(rec, ptr, aliases, type);
> +		free(ptr);
> +	} else {
> +		lr = rec->func_lookup_best_match(rec, key, aliases, type);
> +	}
> +	if (!lr)
> +		return NULL;
> +
> +	if (selabel_fini(rec, lr, translating))
> +		return NULL;
> +
> +	return lr;
> +}
> +
>  /*
>   * Public API
>   */
> @@ -188,54 +280,67 @@ out:
>  	return rec;
>  }
>  
> -static struct selabel_lookup_rec *
> -selabel_lookup_common(struct selabel_handle *rec, int translating,
> -		      const char *key, int type)
> +int selabel_lookup(struct selabel_handle *rec, char **con,
> +		   const char *key, int type)
>  {
>  	struct selabel_lookup_rec *lr;
> -	char *ptr = NULL;
> -	char *dptr = NULL;
>  
> -	if (key == NULL) {
> -		errno = EINVAL;
> -		return NULL;
> -	}
> +	lr = selabel_lookup_common(rec, 1, key, type);
> +	if (!lr)
> +		return -1;
>  
> -	ptr = selabel_sub(rec->subs, key);
> -	if (ptr) {
> -		dptr = selabel_sub(rec->dist_subs, ptr);
> -		if (dptr) {
> -			free(ptr);
> -			ptr = dptr;
> -		}
> -	} else {
> -		ptr = selabel_sub(rec->dist_subs, key);
> +	*con = strdup(lr->ctx_trans);
> +	return *con ? 0 : -1;
> +}
> +
> +int selabel_lookup_raw(struct selabel_handle *rec, char **con,
> +		       const char *key, int type)
> +{
> +	struct selabel_lookup_rec *lr;
> +
> +	lr = selabel_lookup_common(rec, 0, key, type);
> +	if (!lr)
> +		return -1;
> +
> +	*con = strdup(lr->ctx_raw);
> +	return *con ? 0 : -1;
> +}
> +
> +bool selabel_partial_match(struct selabel_handle *rec, const char *key)
> +{
> +	char *ptr;
> +	bool ret;
> +
> +	if (!rec->func_partial_match) {
> +		/*
> +		 * If the label backend does not support partial matching,
> +		 * then assume a match is possible.
> +		 */
> +		return true;
>  	}
> +
> +	ptr = selabel_sub_key(rec, key);
>  	if (ptr) {
> -		lr = rec->func_lookup(rec, ptr, type); 
> +		ret = rec->func_partial_match(rec, ptr);
>  		free(ptr);
>  	} else {
> -		lr = rec->func_lookup(rec, key, type); 
> +		ret = rec->func_partial_match(rec, key);
>  	}
> -	if (!lr)
> -		return NULL;
> -
> -	if (compat_validate(rec, lr, rec->spec_file, 0))
> -		return NULL;
>  
> -	if (translating && !lr->ctx_trans &&
> -	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
> -		return NULL;
> -
> -	return lr;
> +	return ret;
>  }
>  
> -int selabel_lookup(struct selabel_handle *rec, char **con,
> -		   const char *key, int type)
> +int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
> +			      const char *key, const char **aliases, int type)
>  {
>  	struct selabel_lookup_rec *lr;
>  
> -	lr = selabel_lookup_common(rec, 1, key, type);
> +	if (!rec->func_lookup_best_match) {
> +		errno = ENOTSUP;
> +		return -1;
> +	}
> +
> +	lr = selabel_lookup_bm_common(rec, 1, key, type, aliases);
>  	if (!lr)
>  		return -1;
>  
> @@ -243,12 +348,17 @@ int selabel_lookup(struct selabel_handle *rec, char **con,
>  	return *con ? 0 : -1;
>  }
>  
> -int selabel_lookup_raw(struct selabel_handle *rec, char **con,
> -		       const char *key, int type)
> +int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
> +			      const char *key, const char **aliases, int type)
>  {
>  	struct selabel_lookup_rec *lr;
>  
> -	lr = selabel_lookup_common(rec, 0, key, type);
> +	if (!rec->func_lookup_best_match) {
> +		errno = ENOTSUP;
> +		return -1;
> +	}
> +
> +	lr = selabel_lookup_bm_common(rec, 0, key, type, aliases);
>  	if (!lr)
>  		return -1;
>  
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 4563015..b3e5671 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -601,15 +601,17 @@ static void closef(struct selabel_handle *rec)
>  	free(data);
>  }
>  
> -static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
> -					 const char *key, int type)
> +static struct spec *lookup_common(struct selabel_handle *rec,
> +					     const char *key,
> +					     int type,
> +					     bool partial)
>  {
>  	struct saved_data *data = (struct saved_data *)rec->data;
>  	struct spec *spec_arr = data->spec_arr;
> -	int i, rc, file_stem;
> +	int i, rc, file_stem, pcre_options = 0;
>  	mode_t mode = (mode_t)type;
>  	const char *buf;
> -	struct selabel_lookup_rec *ret = NULL;
> +	struct spec *ret = NULL;
>  	char *clean_key = NULL;
>  	const char *prev_slash, *next_slash;
>  	unsigned int sofar = 0;
> @@ -621,7 +623,7 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
>  
>  	/* Remove duplicate slashes */
>  	if ((next_slash = strstr(key, "//"))) {
> -		clean_key = malloc(strlen(key) + 1);
> +		clean_key = (char *) malloc(strlen(key) + 1);
>  		if (!clean_key)
>  			goto finish;
>  		prev_slash = key;
> @@ -639,6 +641,9 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
>  	file_stem = find_stem_from_file(data, &buf);
>  	mode &= S_IFMT;
>  
> +	if (partial)
> +		pcre_options |= PCRE_PARTIAL_SOFT;
> +
>  	/* 
>  	 * Check for matching specifications in reverse order, so that
>  	 * the last matching specification is used.
> @@ -654,14 +659,22 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
>  			if (compile_regex(data, spec, NULL) < 0)
>  				goto finish;
>  			if (spec->stem_id == -1)
> -				rc = pcre_exec(spec->regex, get_pcre_extra(spec), key, strlen(key), 0, 0, NULL, 0);
> +				rc = pcre_exec(spec->regex,
> +						    get_pcre_extra(spec),
> +						    key, strlen(key), 0,
> +						    pcre_options, NULL, 0);
>  			else
> -				rc = pcre_exec(spec->regex, get_pcre_extra(spec), buf, strlen(buf), 0, 0, NULL, 0);
> -
> +				rc = pcre_exec(spec->regex,
> +						    get_pcre_extra(spec),
> +						    buf, strlen(buf), 0,
> +						    pcre_options, NULL, 0);
>  			if (rc == 0) {
>  				spec->matches++;
>  				break;
> -			} else if (rc == PCRE_ERROR_NOMATCH)
> +			} else if (partial && rc == PCRE_ERROR_PARTIAL)
> +				break;
> +
> +			if (rc == PCRE_ERROR_NOMATCH)
>  				continue;
>  
>  			errno = ENOENT;
> @@ -677,13 +690,87 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
>  	}
>  
>  	errno = 0;
> -	ret = &spec_arr[i].lr;
> +	ret = &spec_arr[i];
>  
>  finish:
>  	free(clean_key);
>  	return ret;
>  }
>  
> +static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
> +					 const char *key, int type)
> +{
> +	struct spec *spec;
> +
> +	spec = lookup_common(rec, key, type, false);
> +	if (spec)
> +		return &spec->lr;
> +	return NULL;
> +}
> +
> +static bool partial_match(struct selabel_handle *rec, const char *key)
> +{
> +	return lookup_common(rec, key, 0, true) ? true : false;
> +}
> +
> +static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
> +						    const char *key,
> +						    const char **aliases,
> +						    int type)
> +{
> +	size_t n, i;
> +	int best = -1;
> +	struct spec **specs;
> +	size_t prefix_len = 0;
> +	struct selabel_lookup_rec *lr = NULL;
> +
> +	if (!aliases || !aliases[0])
> +		return lookup(rec, key, type);
> +
> +	for (n = 0; aliases[n]; n++)
> +		;
> +
> +	specs = calloc(n+1, sizeof(struct spec *));
> +	if (!specs)
> +		return NULL;
> +	specs[0] = lookup_common(rec, key, type, false);
> +	if (specs[0]) {
> +		if (!specs[0]->hasMetaChars) {
> +			/* exact match on key */
> +			lr = &specs[0]->lr;
> +			goto out;
> +		}
> +		best = 0;
> +		prefix_len = specs[0]->prefix_len;
> +	}
> +	for (i = 1; i <= n; i++) {
> +		specs[i] = lookup_common(rec, aliases[i-1], type, false);
> +		if (specs[i]) {
> +			if (!specs[i]->hasMetaChars) {
> +				/* exact match on alias */
> +				lr = &specs[i]->lr;
> +				goto out;
> +			}
> +			if (specs[i]->prefix_len > prefix_len) {
> +				best = i;
> +				prefix_len = specs[i]->prefix_len;
> +			}
> +		}
> +	}
> +
> +	if (best >= 0) {
> +		/* longest fixed prefix match on key or alias */
> +		lr = &specs[best]->lr;
> +	} else {
> +		errno = ENOENT;
> +	}
> +
> +out:
> +	free(specs);
> +	return lr;
> +}
> +
> +
>  static void stats(struct selabel_handle *rec)
>  {
>  	struct saved_data *data = (struct saved_data *)rec->data;
> @@ -722,6 +809,8 @@ int selabel_file_init(struct selabel_handle *rec, struct selinux_opt *opts,
>  	rec->func_close = &closef;
>  	rec->func_stats = &stats;
>  	rec->func_lookup = &lookup;
> +	rec->func_partial_match = &partial_match;
> +	rec->func_lookup_best_match = &lookup_best_match;
>  
>  	return init(rec, opts, nopts);
>  }
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index e3a0445..d37008f 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -31,6 +31,7 @@ struct spec {
>  	char hasMetaChars;	/* regular expression has meta-chars */
>  	char regcomp;		/* regex_str has been compiled to regex */
>  	char from_mmap;		/* this spec is from an mmap of the data */
> +	size_t prefix_len;      /* length of fixed path prefix */
>  };
>  
>  /* A regular expression stem */
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
> index a1fa4fd..ef6ad26 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -57,6 +57,12 @@ struct selabel_handle {
>  						   const char *key, int type);
>  	void (*func_close) (struct selabel_handle *h);
>  	void (*func_stats) (struct selabel_handle *h);
> +	bool (*func_partial_match) (struct selabel_handle *h, const char *key);
> +	struct selabel_lookup_rec *(*func_lookup_best_match)
> +						    (struct selabel_handle *h,
> +						    const char *key,
> +						    const char **aliases,
> +						    int type);
>  
>  	/* supports backend-specific state information */
>  	void *data;
> diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selabel_lookup.c
> new file mode 100644
> index 0000000..d0b1457
> --- /dev/null
> +++ b/libselinux/utils/selabel_lookup.c
> @@ -0,0 +1,126 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <selinux/selinux.h>
> +#include <selinux/label.h>
> +
> +static void usage(const char *progname)
> +{
> +	fprintf(stderr,
> +		"usage: %s -b backend [-v] [-r] -k key [-t type] [-f file]\n\n"
> +		"Where:\n\t"
> +		"-b  The backend - \"file\", \"media\", \"x\", \"db\" or "
> +			"\"prop\"\n\t"
> +		"-v  Validate entries against loaded policy.\n\t"
> +		"-r  Use \"raw\" function.\n\t"
> +		"-k  Lookup key - Depends on backend.\n\t"
> +		"-t  Lookup type - Optional as depends on backend.\n\t"
> +		"-f  Optional file containing the specs (defaults to\n\t"
> +		"    those used by loaded policy).\n\n"
> +		"Examples:\n\t"
> +		"%s -v -b file -k /run -t 0\n\t"
> +		"   lookup with validation against the loaded policy, the\n\t"
> +		"   \"file\" backend for path \"/run\" with mode = 0\n\t"
> +		"%s -r -b x -t 4 -k X11:ButtonPress\n\t"
> +		"   lookup_raw the \"X\" backend for type SELABEL_X_EVENT\n\t"
> +		"   using key \"X11:ButtonPress\"\n\n",
> +		progname, progname, progname);
> +	exit(1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int raw = 0, type = 0, backend = 0, rc, opt;
> +	char *validate = NULL, *key = NULL, *context = NULL, *file = NULL;
> +
> +	struct selabel_handle *hnd;
> +	struct selinux_opt selabel_option[] = {
> +		{ SELABEL_OPT_PATH, file },
> +		{ SELABEL_OPT_VALIDATE, validate }
> +	};
> +
> +	if (argc < 3)
> +		usage(argv[0]);
> +
> +	while ((opt = getopt(argc, argv, "b:f:vrk:t:")) > 0) {
> +		switch (opt) {
> +		case 'b':
> +			if (!strcasecmp(optarg, "file")) {
> +				backend = SELABEL_CTX_FILE;
> +			} else if (!strcmp(optarg, "media")) {
> +				backend = SELABEL_CTX_MEDIA;
> +			} else if (!strcmp(optarg, "x")) {
> +				backend = SELABEL_CTX_X;
> +			} else if (!strcmp(optarg, "db")) {
> +				backend = SELABEL_CTX_DB;
> +			} else if (!strcmp(optarg, "prop")) {
> +				backend = SELABEL_CTX_ANDROID_PROP;
> +			} else {
> +				fprintf(stderr, "Unknown backend: %s\n",
> +								    optarg);
> +				usage(argv[0]);
> +			}
> +			break;
> +		case 'f':
> +			file = optarg;
> +			break;
> +		case 'v':
> +			validate = (char *)1;
> +			break;
> +		case 'r':
> +			raw = 1;
> +			break;
> +		case 'k':
> +			key = optarg;
> +			break;
> +		case 't':
> +			type = atoi(optarg);
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	selabel_option[0].value = file;
> +	selabel_option[1].value = validate;
> +
> +	hnd = selabel_open(backend, selabel_option, 2);
> +	if (!hnd) {
> +		fprintf(stderr, "ERROR: selabel_open - Could not obtain "
> +							     "handle.\n");
> +		return -1;
> +	}
> +
> +	switch (raw) {
> +	case 1:
> +		rc = selabel_lookup_raw(hnd, &context, key, type);
> +		break;
> +	default:
> +		rc = selabel_lookup(hnd, &context, key, type);
> +	}
> +	selabel_close(hnd);
> +
> +	if (rc) {
> +		switch (errno) {
> +		case ENOENT:
> +			fprintf(stderr, "ERROR: selabel_lookup failed to "
> +					    "find a valid context.\n");
> +			break;
> +		case EINVAL:
> +			fprintf(stderr, "ERROR: selabel_lookup failed to "
> +				    "validate context, or key / type are "
> +				    "invalid.\n");
> +			break;
> +		default:
> +			fprintf(stderr, "selabel_lookup ERROR: %s\n",
> +						    strerror(errno));
> +		}
> +	} else {
> +		printf("Default context: %s\n", context);
> +		freecon(context);
> +	}
> +
> +	return rc;
> +}
> diff --git a/libselinux/utils/selabel_lookup_best_match.c b/libselinux/utils/selabel_lookup_best_match.c
> new file mode 100644
> index 0000000..c4e8c10
> --- /dev/null
> +++ b/libselinux/utils/selabel_lookup_best_match.c
> @@ -0,0 +1,164 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +#include <selinux/selinux.h>
> +#include <selinux/label.h>
> +
> +static void usage(const char *progname)
> +{
> +	fprintf(stderr,
> +		"usage: %s [-v] [-r] -p path [-m mode] [-f file] [link...]\n\n"
> +		"Where:\n\t"
> +		"-v     Validate file_contxts entries against loaded policy.\n\t"
> +		"-r     Use \"raw\" function.\n\t"
> +		"-p     Path to check for best match using the link(s) provided.\n\t"
> +		"-m     Optional mode (b, c, d, p, l, s or f) Defaults to 0.\n\t"
> +		"-f     Optional file containing the specs (defaults to\n\t"
> +		"       those used by loaded policy).\n\t"
> +		"link   Zero or more links to check against, the order of\n\t"
> +		"       precedence for best match is:\n\t\t"
> +		"   1) An exact match for the real path (if no links), or\n\t\t"
> +		"   2) An exact match for any of the links (aliases), or\n\t\t"
> +		"   3) The longest fixed prefix match.\n\n"
> +		"Example:\n\t"
> +		"%s -p /dev/initctl /run/systemd/initctl/fifo\n\t"
> +		"   Find best matching context for the specified path using one link.\n\n",
> +		progname, progname);
> +	exit(1);
> +}
> +
> +static mode_t string_to_mode(char *s)
> +{
> +	switch (s[0]) {
> +	case 'b':
> +		return S_IFBLK;
> +	case 'c':
> +		return S_IFCHR;
> +	case 'd':
> +		return S_IFDIR;
> +	case 'p':
> +		return S_IFIFO;
> +	case 'l':
> +		return S_IFLNK;
> +	case 's':
> +		return S_IFSOCK;
> +	case 'f':
> +		return S_IFREG;
> +	};
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int raw = 0, mode = 0, rc, opt, i, num_links, string_size;
> +	char *validate = NULL, *path = NULL, *context = NULL, *file = NULL;
> +
> +	char **links = NULL;
> +
> +	struct selabel_handle *hnd;
> +	struct selinux_opt options[] = {
> +		{ SELABEL_OPT_PATH, file },
> +		{ SELABEL_OPT_VALIDATE, validate }
> +	};
> +
> +	if (argc < 3)
> +		usage(argv[0]);
> +
> +	while ((opt = getopt(argc, argv, "f:vrp:m:")) > 0) {
> +		switch (opt) {
> +		case 'f':
> +			file = optarg;
> +			break;
> +		case 'v':
> +			validate = (char *)1;
> +			break;
> +		case 'r':
> +			raw = 1;
> +			break;
> +		case 'p':
> +			path = optarg;
> +			break;
> +		case 'm':
> +			mode = string_to_mode(optarg);
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	/* Count links */
> +	for (i = optind, num_links = 0; i < argc; i++, num_links++)
> +		;
> +
> +	if (num_links != 0) {
> +		links = malloc(sizeof(char *) * num_links);
> +
> +		if (links == NULL) {
> +			fprintf(stderr, "ERROR: malloc failed.");
> +			exit(1);
> +		}
> +
> +		for (i = optind, num_links = 0; i < argc; i++, num_links++) {
> +			string_size = strlen(argv[i]) + 1;
> +			links[num_links] = malloc(string_size);
> +			if (links[num_links] == NULL) {
> +				fprintf(stderr, "ERROR: malloc failed.");
> +				exit(1);
> +			}
> +			strcpy(links[num_links], argv[i]);
> +		}
> +	}
> +
> +	options[0].value = file;
> +	options[1].value = validate;
> +
> +	hnd = selabel_open(SELABEL_CTX_FILE, options, 2);
> +	if (!hnd) {
> +		fprintf(stderr, "ERROR: selabel_open - Could not obtain "
> +							     "handle.\n");
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	switch (raw) {
> +	case 1:
> +		rc = selabel_lookup_best_match_raw(hnd, &context, path,
> +					    (const char **)links, mode);
> +		break;
> +	default:
> +		rc = selabel_lookup_best_match(hnd, &context, path,
> +					    (const char **)links, mode);
> +	}
> +	selabel_close(hnd);
> +
> +	if (rc) {
> +		switch (errno) {
> +		case ENOENT:
> +			fprintf(stderr, "ERROR: selabel_lookup_best_match "
> +				    "failed to find a valid context.\n");
> +			break;
> +		case EINVAL:
> +			fprintf(stderr, "ERROR: selabel_lookup_best_match "
> +				"failed to validate context, or path / mode "
> +				"are invalid.\n");
> +			break;
> +		default:
> +			fprintf(stderr, "selabel_lookup_best_match ERROR: "
> +					    "%s\n", strerror(errno));
> +		}
> +	} else {
> +		printf("Best match context: %s\n", context);
> +		freecon(context);
> +	}
> +out:
> +	if (num_links != 0) {
> +		for (i = 0; i < num_links; i++)
> +			free(links[i]);
> +		free(links);
> +	}
> +
> +	return rc;
> +}
> diff --git a/libselinux/utils/selabel_partial_match.c b/libselinux/utils/selabel_partial_match.c
> new file mode 100644
> index 0000000..017702d
> --- /dev/null
> +++ b/libselinux/utils/selabel_partial_match.c
> @@ -0,0 +1,75 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <selinux/selinux.h>
> +#include <selinux/label.h>
> +
> +static void usage(const char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-v] -p <path> [-f file]\n\n"
> +		"Where:\n\t"
> +		"-v  Validate file_contxts entries against loaded policy.\n\t"
> +		"-p  Path to check if a match or partial match is possible\n\t"
> +		"    against a regex entry in the file_contexts file.\n\t"
> +		"-f  Optional file_contexts file (defaults to current policy).\n\n"
> +		"Example:\n\t"
> +		"%s -p /sys/devices/system/cpu/online\n\t"
> +		"   Check if a match or partial match is possible against\n\t"
> +		"   the path \"/sys/devices/system/cpu/online\", returning\n\t"
> +		"   TRUE or FALSE.\n\n", progname, progname);
> +	exit(1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int opt;
> +	bool partial_match;
> +	char *validate = NULL, *path = NULL, *file = NULL;
> +
> +	struct selabel_handle *hnd;
> +	struct selinux_opt selabel_option[] = {
> +		{ SELABEL_OPT_PATH, file },
> +		{ SELABEL_OPT_VALIDATE, validate }
> +	};
> +
> +	if (argc < 2)
> +		usage(argv[0]);
> +
> +	while ((opt = getopt(argc, argv, "f:vp:")) > 0) {
> +		switch (opt) {
> +		case 'f':
> +			file = optarg;
> +			break;
> +		case 'v':
> +			validate = (char *)1;
> +			break;
> +		case 'p':
> +			path = optarg;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	selabel_option[0].value = file;
> +	selabel_option[1].value = validate;
> +
> +	hnd = selabel_open(SELABEL_CTX_FILE, selabel_option, 2);
> +	if (!hnd) {
> +		fprintf(stderr, "ERROR: selabel_open - Could not obtain "
> +							     "handle.\n");
> +		return -1;
> +	}
> +
> +	partial_match = selabel_partial_match(hnd, path);
> +
> +	printf("Match or Partial match: %s\n",
> +		    partial_match == 1 ? "TRUE" : "FALSE");
> +
> +	selabel_close(hnd);
> +	return partial_match;
> +}
> 
