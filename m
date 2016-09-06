Subject: Re: [PATCH] [RFC] nodups_specs: speedup
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
References: <1472487768-4104-1-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2030c403-fde5-8538-d282-cc8a3b423945@tycho.nsa.gov>
Date: Tue, 6 Sep 2016 14:57:36 -0400
MIME-Version: 1.0
In-Reply-To: <1472487768-4104-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/29/2016 12:22 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> I noticed, via gprof, that the time spent in nodups_specs()
> accounts for 100% of the label_open() call.
> 
> It seems as though the N^2 comparison using strcmp is very
> slow.
> 
> Do two major things:
> 1. move the rec->validating check to the left, check the simple
>    thing first before runnning the expensive strcmp(). strcmp()
>    is used to check string equality, check lengths first.
> 2. strlen() is used all over to calculate lengths, just store
>    it in a struct with the string so its usable elsewhere, rather
>    than recalculating it.
> 
> text 21.4% speedup:
> before text: 248
> after text: 195
> 
> binary 24.6% speedup:
> before bin: 236
> after bin: 178
> 
> Some things to ponder:
> 1. We can use C ABI safe pointer instead of len_str structure
>    https://bitbucket.org/billcroberts/twist
>    There are pros and cons to this approach, namely if someone
>    calls free(x) instead of twist_free(x)
>    It also currently has 0 support for stack based strings (simple
>    enough to add). I think this approach is overkill here.

Agreed.

> 
> 2. The location of the str_len struct and routines should likely
>    move elsewhere.

Agreed.

> 
> 3. The impact on Android is currently unmeasured, that's next.
>    Also, bionic uses something from label_file.h for processing
>    property_contexts for the Android property subsystem... so
>    need to ensure that all works as advertised still.
> 
> Things to do:
> 1. Cleanup the code locations, likely a util.h or a len_str.h,
>    a better name would be nice.
> 2. Spell check this commit message

Seems a bit prone to the str and len fields getting out of sync since
they are both directly manipulated.

> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libselinux/src/label.c                  |  8 ++--
>  libselinux/src/label_android_property.c | 44 +++++++++----------
>  libselinux/src/label_db.c               |  7 +--
>  libselinux/src/label_file.c             | 63 ++++++++++++++------------
>  libselinux/src/label_file.h             | 78 +++++++++++++++++++--------------
>  libselinux/src/label_internal.h         | 22 +++++++++-
>  libselinux/src/label_media.c            |  5 ++-
>  libselinux/src/label_support.c          | 32 ++++++++------
>  libselinux/src/label_x.c                |  5 ++-
>  libselinux/src/matchpathcon.c           |  2 +-
>  10 files changed, 159 insertions(+), 107 deletions(-)
> 
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 963bfcb..11324ea 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -209,7 +209,7 @@ int selabel_validate(struct selabel_handle *rec,
>  	if (!rec->validating || contexts->validated)
>  		goto out;
>  
> -	rc = selinux_validate(&contexts->ctx_raw);
> +	rc = selinux_validate(&contexts->ctx_raw.str);
>  	if (rc < 0)
>  		goto out;
>  
> @@ -248,7 +248,7 @@ static int selabel_fini(struct selabel_handle *rec,
>  		return -1;
>  
>  	if (translating && !lr->ctx_trans &&
> -	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
> +	    selinux_raw_to_trans_context(lr->ctx_raw.str, &lr->ctx_trans))
>  		return -1;
>  
>  	return 0;
> @@ -369,7 +369,7 @@ int selabel_lookup_raw(struct selabel_handle *rec, char **con,
>  	if (!lr)
>  		return -1;
>  
> -	*con = strdup(lr->ctx_raw);
> +	*con = strdup(lr->ctx_raw.str);
>  	return *con ? 0 : -1;
>  }
>  
> @@ -429,7 +429,7 @@ int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
>  	if (!lr)
>  		return -1;
>  
> -	*con = strdup(lr->ctx_raw);
> +	*con = strdup(lr->ctx_raw.str);
>  	return *con ? 0 : -1;
>  }
>  
> diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
> index 290b438..af0b9a8 100644
> --- a/libselinux/src/label_android_property.c
> +++ b/libselinux/src/label_android_property.c
> @@ -16,7 +16,7 @@
>  /* A property security context specification. */
>  typedef struct spec {
>  	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
> -	char *property_key;		/* property key string */
> +	struct len_str property_key;		/* property key string */
>  } spec_t;
>  
>  /* Our stored configuration */
> @@ -33,13 +33,13 @@ static int cmp(const void *A, const void *B)
>  {
>  	const struct spec *sp1 = A, *sp2 = B;
>  
> -	if (strncmp(sp1->property_key, "*", 1) == 0)
> +	if (strncmp(sp1->property_key.str, "*", 1) == 0)
>  		return 1;
> -	if (strncmp(sp2->property_key, "*", 1) == 0)
> +	if (strncmp(sp2->property_key.str, "*", 1) == 0)
>  		return -1;
>  
> -	size_t L1 = strlen(sp1->property_key);
> -	size_t L2 = strlen(sp2->property_key);
> +	size_t L1 = sp1->property_key.len;
> +	size_t L2 = sp2->property_key.len;
>  
>  	return (L1 < L2) - (L1 > L2);
>  }
> @@ -56,23 +56,23 @@ static int nodups_specs(struct saved_data *data, const char *path)
>  	for (ii = 0; ii < data->nspec; ii++) {
>  		curr_spec = &spec_arr[ii];
>  		for (jj = ii + 1; jj < data->nspec; jj++) {
> -			if (!strcmp(spec_arr[jj].property_key,
> -					    curr_spec->property_key)) {
> +			if (len_str_eq(&spec_arr[jj].property_key,
> +					    &curr_spec->property_key)) {
>  				rc = -1;
>  				errno = EINVAL;
> -				if (strcmp(spec_arr[jj].lr.ctx_raw,
> -						    curr_spec->lr.ctx_raw)) {
> +				if (!len_str_eq(&spec_arr[jj].lr.ctx_raw,
> +						    &curr_spec->lr.ctx_raw)) {
>  					selinux_log
>  						(SELINUX_ERROR,
>  						 "%s: Multiple different specifications for %s  (%s and %s).\n",
> -						 path, curr_spec->property_key,
> -						 spec_arr[jj].lr.ctx_raw,
> -						 curr_spec->lr.ctx_raw);
> +						 path, curr_spec->property_key.str,
> +						 spec_arr[jj].lr.ctx_raw.str,
> +						 curr_spec->lr.ctx_raw.str);
>  				} else {
>  					selinux_log
>  						(SELINUX_ERROR,
>  						 "%s: Multiple same specifications for %s.\n",
> -						 path, curr_spec->property_key);
> +						 path, curr_spec->property_key.str);
>  				}
>  			}
>  		}
> @@ -85,7 +85,7 @@ static int process_line(struct selabel_handle *rec,
>  			int pass, unsigned lineno)
>  {
>  	int items;
> -	char *prop = NULL, *context = NULL;
> +	struct len_str *prop = { 0 }, *context = { 0 };
>  	struct saved_data *data = (struct saved_data *)rec->data;
>  	spec_t *spec_arr = data->spec_arr;
>  	unsigned int nspec = data->nspec;
> @@ -118,14 +118,14 @@ static int process_line(struct selabel_handle *rec,
>  		free(context);
>  	} else if (pass == 1) {
>  		/* On the second pass, process and store the specification in spec. */
> -		spec_arr[nspec].property_key = prop;
> -		spec_arr[nspec].lr.ctx_raw = context;
> +		memcpy(&spec_arr[nspec].property_key, prop, sizeof(*prop));
> +		memcpy(&spec_arr[nspec].lr.ctx_raw, context, sizeof(*context));
>  
>  		if (rec->validating) {
>  			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
>  				selinux_log(SELINUX_ERROR,
>  					    "%s:  line %u has invalid context %s\n",
> -					    path, lineno, spec_arr[nspec].lr.ctx_raw);
> +					    path, lineno, spec_arr[nspec].lr.ctx_raw.str);
>  				errno = EINVAL;
>  				return -1;
>  			}
> @@ -233,8 +233,8 @@ static void closef(struct selabel_handle *rec)
>  
>  	for (i = 0; i < data->nspec; i++) {
>  		spec = &data->spec_arr[i];
> -		free(spec->property_key);
> -		free(spec->lr.ctx_raw);
> +		free(spec->property_key.str);
> +		free(spec->lr.ctx_raw.str);
>  		free(spec->lr.ctx_trans);
>  	}
>  
> @@ -259,11 +259,11 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
>  	}
>  
>  	for (i = 0; i < data->nspec; i++) {
> -		if (strncmp(spec_arr[i].property_key, key,
> -			    strlen(spec_arr[i].property_key)) == 0) {
> +		if (strncmp(spec_arr[i].property_key.str, key,
> +			    spec_arr[i].property_key.len) == 0) {
>  			break;
>  		}
> -		if (strncmp(spec_arr[i].property_key, "*", 1) == 0)
> +		if (strncmp(spec_arr[i].property_key.str, "*", 1) == 0)
>  			break;
>  	}
>  
> diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> index 1155bcc..c700aca 100644
> --- a/libselinux/src/label_db.c
> +++ b/libselinux/src/label_db.c
> @@ -153,7 +153,8 @@ process_line(const char *path, char *line_buf, unsigned int line_num,
>  
>  	free(type);
>  	spec->key = key;
> -	spec->lr.ctx_raw = context;
> +	spec->lr.ctx_raw.str = context;
> +	spec->lr.ctx_raw.len = strlen(context);
>  
>  	catalog->nspec++;
>  
> @@ -181,7 +182,7 @@ db_close(struct selabel_handle *rec)
>  	for (i = 0; i < catalog->nspec; i++) {
>  		spec = &catalog->specs[i];
>  		free(spec->key);
> -		free(spec->lr.ctx_raw);
> +		free(spec->lr.ctx_raw.str);
>  		free(spec->lr.ctx_trans);
>  	}
>  	free(catalog);
> @@ -333,7 +334,7 @@ out_error:
>  		spec_t	       *spec = &catalog->specs[i];
>  
>  		free(spec->key);
> -		free(spec->lr.ctx_raw);
> +		free(spec->lr.ctx_raw.str);
>  		free(spec->lr.ctx_trans);
>  	}
>  	free(catalog);
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 68c566b..ade07d8 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -71,25 +71,24 @@ static int nodups_specs(struct saved_data *data, const char *path)
>  	for (ii = 0; ii < data->nspec; ii++) {
>  		curr_spec = &spec_arr[ii];
>  		for (jj = ii + 1; jj < data->nspec; jj++) {
> -			if ((!strcmp(spec_arr[jj].regex_str,
> -				curr_spec->regex_str))
> +			if (len_str_eq(&spec_arr[jj].regex_str, &curr_spec->regex_str)
>  			    && (!spec_arr[jj].mode || !curr_spec->mode
>  				|| spec_arr[jj].mode == curr_spec->mode)) {
>  				rc = -1;
>  				errno = EINVAL;
> -				if (strcmp(spec_arr[jj].lr.ctx_raw,
> -					    curr_spec->lr.ctx_raw)) {
> +				if (!len_str_eq(&spec_arr[jj].lr.ctx_raw,
> +					    &curr_spec->lr.ctx_raw)) {
>  					COMPAT_LOG
>  						(SELINUX_ERROR,
>  						 "%s: Multiple different specifications for %s  (%s and %s).\n",
> -						 path, curr_spec->regex_str,
> -						 spec_arr[jj].lr.ctx_raw,
> -						 curr_spec->lr.ctx_raw);
> +						 path, curr_spec->regex_str.str,
> +						 spec_arr[jj].lr.ctx_raw.str,
> +						 curr_spec->lr.ctx_raw.str);
>  				} else {
>  					COMPAT_LOG
>  						(SELINUX_ERROR,
>  						 "%s: Multiple same specifications for %s.\n",
> -						 path, curr_spec->regex_str);
> +						 path, curr_spec->regex_str.str);
>  				}
>  			}
>  		}
> @@ -475,12 +474,13 @@ static int read_binary_file(struct selabel_handle *rec)
>  			goto out;
>  		}
>  
> -		spec->lr.ctx_raw = str_buf;
> +		spec->lr.ctx_raw.str = str_buf;
> +		spec->lr.ctx_raw.len = entry_len -1;
>  
> -		if (strcmp(spec->lr.ctx_raw, "<<none>>") && rec->validating) {
> +		if (rec->validating && strcmp(spec->lr.ctx_raw.str, "<<none>>")) {
>  			if (selabel_validate(rec, &spec->lr) < 0) {
>  				selinux_log(SELINUX_ERROR, "%s: context %s is invalid\n",
> -						data->path, spec->lr.ctx_raw);
> +						data->path, spec->lr.ctx_raw.str);
>  				errno = EINVAL;
>  				free(str_buf);
>  				goto out;
> @@ -492,14 +492,16 @@ static int read_binary_file(struct selabel_handle *rec)
>  		if (err < 0 || !entry_len)
>  			goto out;
>  
> -		spec->regex_str = (char *) map_area->next_addr;
> +		spec->regex_str.str = (char *) map_area->next_addr;
>  		err = next_entry(NULL, map_area, entry_len);
>  		if (err < 0)
>  			goto out;
>  
> -		if (spec->regex_str[entry_len - 1] != '\0')
> +		if (spec->regex_str.str[entry_len - 1] != '\0')
>  			goto out;
>  
> +		spec->regex_str.len = entry_len - 1;
> +
>  		/* Process mode */
>  		if (version >= SELINUX_COMPILED_FCONTEXT_MODE)
>  			err = next_entry(&mode, map_area, sizeof(mode));
> @@ -715,11 +717,13 @@ static void closef(struct selabel_handle *rec)
>  	for (i = 0; i < data->nspec; i++) {
>  		spec = &data->spec_arr[i];
>  		free(spec->lr.ctx_trans);
> -		free(spec->lr.ctx_raw);
> +		free(spec->lr.ctx_raw.str);
>  		if (spec->from_mmap)
>  			continue;
> -		free(spec->regex_str);
> -		free(spec->type_str);
> +
> +		free(spec->regex_str.str);
> +		free(spec->type_str.str);
> +
>  		if (spec->regcomp) {
>  			pcre_free(spec->regex);
>  			pcre_free_study(spec->sd);
> @@ -767,6 +771,11 @@ static struct spec *lookup_common(struct selabel_handle *rec,
>  	const char *prev_slash, *next_slash;
>  	unsigned int sofar = 0;
>  
> +	struct len_str none = {
> +			.str = (char *)"<<none>>",
> +			.len = 8
> +	};
> +
>  	if (!data->nspec) {
>  		errno = ENOENT;
>  		goto finish;
> @@ -834,7 +843,7 @@ static struct spec *lookup_common(struct selabel_handle *rec,
>  		}
>  	}
>  
> -	if (i < 0 || strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
> +	if (i < 0 || len_str_eq(&spec_arr[i].lr.ctx_raw, &none)) {
>  		/* No matching specification. */
>  		errno = ENOENT;
>  		goto finish;
> @@ -926,8 +935,8 @@ static enum selabel_cmp_result incomp(struct spec *spec1, struct spec *spec2, co
>  	selinux_log(SELINUX_INFO,
>  		    "selabel_cmp: mismatched %s on entry %d: (%s, %x, %s) vs entry %d: (%s, %x, %s)\n",
>  		    reason,
> -		    i, spec1->regex_str, spec1->mode, spec1->lr.ctx_raw,
> -		    j, spec2->regex_str, spec2->mode, spec2->lr.ctx_raw);
> +		    i, spec1->regex_str.str, spec1->mode, spec1->lr.ctx_raw.str,
> +		    j, spec2->regex_str.str, spec2->mode, spec2->lr.ctx_raw.str);
>  	return SELABEL_INCOMPARABLE;
>  }
>  
> @@ -976,7 +985,7 @@ static enum selabel_cmp_result cmp(struct selabel_handle *h1,
>  			    memcmp(spec1->regex, spec2->regex, len1))
>  				return incomp(spec1, spec2, "regex", i, j);
>  		} else {
> -			if (strcmp(spec1->regex_str, spec2->regex_str))
> +			if (strcmp(spec1->regex_str.str, spec2->regex_str.str))
>  				return incomp(spec1, spec2, "regex_str", i, j);
>  		}
>  
> @@ -995,7 +1004,7 @@ static enum selabel_cmp_result cmp(struct selabel_handle *h1,
>  				return incomp(spec1, spec2, "stem", i, j);
>  		}
>  
> -		if (strcmp(spec1->lr.ctx_raw, spec2->lr.ctx_raw))
> +		if (!len_str_eq(&spec1->lr.ctx_raw, &spec2->lr.ctx_raw))
>  			return incomp(spec1, spec2, "ctx_raw", i, j);
>  
>  		i++;
> @@ -1020,17 +1029,17 @@ static void stats(struct selabel_handle *rec)
>  
>  	for (i = 0; i < nspec; i++) {
>  		if (spec_arr[i].matches == 0) {
> -			if (spec_arr[i].type_str) {
> +			if (spec_arr[i].type_str.str) {
>  				COMPAT_LOG(SELINUX_WARNING,
>  				    "Warning!  No matches for (%s, %s, %s)\n",
> -				    spec_arr[i].regex_str,
> -				    spec_arr[i].type_str,
> -				    spec_arr[i].lr.ctx_raw);
> +				    spec_arr[i].regex_str.str,
> +				    spec_arr[i].type_str.str,
> +				    spec_arr[i].lr.ctx_raw.str);
>  			} else {
>  				COMPAT_LOG(SELINUX_WARNING,
>  				    "Warning!  No matches for (%s, %s)\n",
> -				    spec_arr[i].regex_str,
> -				    spec_arr[i].lr.ctx_raw);
> +				    spec_arr[i].regex_str.str,
> +				    spec_arr[i].lr.ctx_raw.str);
>  			}
>  		}
>  	}
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index da06164..cd021f4 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -26,10 +26,10 @@
>  
>  /* A file security context specification. */
>  struct spec {
> -	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
> -	char *regex_str;	/* regular expession string for diagnostics */
> -	char *type_str;		/* type string for diagnostic messages */
> -	pcre *regex;		/* compiled regular expression */
> +	struct selabel_lookup_rec lr; /* holds contexts for lookup result */
> +	struct len_str regex_str;     /* regular expession string for diagnostics */
> +	struct len_str type_str;     /* type string for diagnostic messages */
> +	pcre *regex;                  /* compiled regular expression */
>  	union {
>  		pcre_extra *sd;	/* pointer to extra compiled stuff */
>  		pcre_extra lsd;	/* used to hold the mmap'd version */
> @@ -90,16 +90,19 @@ static inline pcre_extra *get_pcre_extra(struct spec *spec)
>  		return spec->sd;
>  }
>  
> -static inline mode_t string_to_mode(char *mode)
> +static inline mode_t string_to_mode(struct len_str *mode)
>  {
>  	size_t len;
>  
>  	if (!mode)
>  		return 0;
> -	len = strlen(mode);
> -	if (mode[0] != '-' || len != 2)
> +
> +	len = mode->len;
> +
> +	if (mode->str[0] != '-' || len != 2)
>  		return -1;
> -	switch (mode[1]) {
> +
> +	switch (mode->str[1]) {
>  	case 'b':
>  		return S_IFBLK;
>  	case 'c':
> @@ -153,8 +156,8 @@ static inline void spec_hasMetaChars(struct spec *spec)
>  	int len;
>  	char *end;
>  
> -	c = spec->regex_str;
> -	len = strlen(spec->regex_str);
> +	c = spec->regex_str.str;
> +	len = spec->regex_str.len;
>  	end = c + len;
>  
>  	spec->hasMetaChars = 0;
> @@ -175,7 +178,7 @@ static inline void spec_hasMetaChars(struct spec *spec)
>  		case '(':
>  		case '{':
>  			spec->hasMetaChars = 1;
> -			spec->prefix_len = c - spec->regex_str;
> +			spec->prefix_len = c - spec->regex_str.str;
>  			return;
>  		case '\\':	/* skip the next character */
>  			c++;
> @@ -327,13 +330,16 @@ static inline int compile_regex(struct saved_data *data, struct spec *spec,
>  	if (spec->regcomp)
>  		return 0; /* already done */
>  
> +	len = spec->regex_str.len;
> +	reg_buf = spec->regex_str.str;
> +
>  	/* Skip the fixed stem. */
> -	reg_buf = spec->regex_str;
> -	if (spec->stem_id >= 0)
> +	if (spec->stem_id >= 0) {
>  		reg_buf += stem_arr[spec->stem_id].len;
> +		len -= stem_arr[spec->stem_id].len;
> +	}
>  
>  	/* Anchor the regular expression. */
> -	len = strlen(reg_buf);
>  	cp = anchored_regex = malloc(len + 3);
>  	if (!anchored_regex)
>  		return -1;
> @@ -375,7 +381,15 @@ static inline int process_line(struct selabel_handle *rec,
>  			char *line_buf, unsigned lineno)
>  {
>  	int items, len, rc;
> -	char *regex = NULL, *type = NULL, *context = NULL;
> +
> +	struct len_str regex = { 0 } , type = { 0 }, context  = { 0 };
> +
> +	/* XXX Export this as a const */
> +	struct len_str none = {
> +			.str = (char *)"<<none>>",
> +			.len = 8
> +	};
> +
>  	struct saved_data *data = (struct saved_data *)rec->data;
>  	struct spec *spec_arr;
>  	unsigned int nspec = data->nspec;
> @@ -399,21 +413,21 @@ static inline int process_line(struct selabel_handle *rec,
>  			    "%s:  line %u is missing fields\n", path,
>  			    lineno);
>  		if (items == 1)
> -			free(regex);
> +			free(regex.str);
>  		errno = EINVAL;
>  		return -1;
>  	} else if (items == 2) {
>  		/* The type field is optional. */
>  		context = type;
> -		type = 0;
> +		memset(&type, 0, sizeof(type));
>  	}
>  
> -	len = get_stem_from_spec(regex);
> -	if (len && prefix && strncmp(prefix, regex, len)) {
> +	len = get_stem_from_spec(regex.str);
> +	if (len && prefix && strncmp(prefix, regex.str, len)) {
>  		/* Stem of regex does not match requested prefix, discard. */
> -		free(regex);
> -		free(type);
> -		free(context);
> +		free(regex.str);
> +		free(type.str);
> +		free(context.str);
>  		return 0;
>  	}
>  
> @@ -424,13 +438,13 @@ static inline int process_line(struct selabel_handle *rec,
>  	spec_arr = data->spec_arr;
>  
>  	/* process and store the specification in spec. */
> -	spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
> -	spec_arr[nspec].regex_str = regex;
> -
> -	spec_arr[nspec].type_str = type;
> +	spec_arr[nspec].stem_id = find_stem_from_spec(data, regex.str);
> +	memcpy(&spec_arr[nspec].regex_str, &regex, sizeof(regex));
> +	memcpy(&spec_arr[nspec].lr.ctx_raw, &context, sizeof(context));
>  	spec_arr[nspec].mode = 0;
>  
> -	spec_arr[nspec].lr.ctx_raw = context;
> +	if (type.str)
> +		memcpy(&spec_arr[nspec].type_str, &type, sizeof(type));
>  
>  	/*
>  	 * bump data->nspecs to cause closef() to cover it in its free
> @@ -442,19 +456,19 @@ static inline int process_line(struct selabel_handle *rec,
>  			    compile_regex(data, &spec_arr[nspec], &errbuf)) {
>  		COMPAT_LOG(SELINUX_ERROR,
>  			   "%s:  line %u has invalid regex %s:  %s\n",
> -			   path, lineno, regex,
> +			   path, lineno, regex.str,
>  			   (errbuf ? errbuf : "out of memory"));
>  		errno = EINVAL;
>  		return -1;
>  	}
>  
> -	if (type) {
> -		mode_t mode = string_to_mode(type);
> +	if (type.str) {
> +		mode_t mode = string_to_mode(&type);
>  
>  		if (mode == (mode_t)-1) {
>  			COMPAT_LOG(SELINUX_ERROR,
>  				   "%s:  line %u has invalid file type %s\n",
> -				   path, lineno, type);
> +				   path, lineno, type.str);
>  			errno = EINVAL;
>  			return -1;
>  		}
> @@ -465,7 +479,7 @@ static inline int process_line(struct selabel_handle *rec,
>  	 * any meta characters in the RE */
>  	spec_hasMetaChars(&spec_arr[nspec]);
>  
> -	if (strcmp(context, "<<none>>") && rec->validating)
> +	if (rec->validating && !len_str_eq(&context, &none))
>  		compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
>  
>  	return 0;
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
> index aa48fff..51aa33d 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -71,8 +71,28 @@ extern struct selabel_sub *selabel_subs_init(const char *path,
>  				    struct selabel_sub *list,
>  				    struct selabel_digest *digest);
>  
> +/*
> + * A simple struct for tracking string lengths
> + * with strings.
> + */
> +struct len_str {
> +	size_t len;
> +	char *str;
> +};
> +
> +static inline bool len_str_eq(struct len_str *a, struct len_str *b)
> +{
> +	if (a->len != b->len)
> +		return false;
> +
> +	if (a->str == b->str)
> +		return true;
> +
> +	return !strcmp(a->str, b->str);
> +}
> +
>  struct selabel_lookup_rec {
> -	char * ctx_raw;
> +	struct len_str ctx_raw;
>  	char * ctx_trans;
>  	int validated;
>  };
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index 622741b..e85e973 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -56,7 +56,8 @@ static int process_line(const char *path, char *line_buf, int pass,
>  
>  	if (pass == 1) {
>  		data->spec_arr[data->nspec].key = key;
> -		data->spec_arr[data->nspec].lr.ctx_raw = context;
> +		data->spec_arr[data->nspec].lr.ctx_raw.str = context;
> +		data->spec_arr[data->nspec].lr.ctx_raw.len = strlen(context);
>  	}
>  
>  	data->nspec++;
> @@ -159,7 +160,7 @@ static void close(struct selabel_handle *rec)
>  	for (i = 0; i < data->nspec; i++) {
>  		spec = &spec_arr[i];
>  		free(spec->key);
> -		free(spec->lr.ctx_raw);
> +		free(spec->lr.ctx_raw.str);
>  		free(spec->lr.ctx_trans);
>  	}
>  
> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
> index 26f9ef1..e9b842f 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -22,16 +22,17 @@
>   *            errno will be set.
>   *
>   */
> -static inline int read_spec_entry(char **entry, char **ptr, int *len, const char **errbuf)
> +static inline int read_spec_entry(struct len_str *entry, char **ptr, const char **errbuf)
>  {
> -	*entry = NULL;
> +	size_t len = 0;
>  	char *tmp_buf = NULL;
>  
> +	memset(entry, 0, sizeof(*entry));
> +
>  	while (isspace(**ptr) && **ptr != '\0')
>  		(*ptr)++;
>  
>  	tmp_buf = *ptr;
> -	*len = 0;
>  
>  	while (!isspace(**ptr) && **ptr != '\0') {
>  		if (!isascii(**ptr)) {
> @@ -40,13 +41,15 @@ static inline int read_spec_entry(char **entry, char **ptr, int *len, const char
>  			return -1;
>  		}
>  		(*ptr)++;
> -		(*len)++;
> +		len++;
>  	}
>  
> -	if (*len) {
> -		*entry = strndup(tmp_buf, *len);
> -		if (!*entry)
> +	if (len) {
> +		entry->str = strndup(tmp_buf, len);
> +		if (!entry->str)
>  			return -1;
> +
> +		entry->len = len;
>  	}
>  
>  	return 0;
> @@ -56,7 +59,7 @@ static inline int read_spec_entry(char **entry, char **ptr, int *len, const char
>   * line_buf - Buffer containing the spec entries .
>   * errbuf   - Double pointer used for passing back specific error messages.
>   * num_args - The number of spec parameter entries to process.
> - * ...      - A 'char **spec_entry' for each parameter.
> + * ...      - A 'struct len_str **spec_entry' for each parameter.
>   * returns  - The number of items processed. On error, it returns -1 with errno
>   *            set and may set errbuf to a specific error message.
>   *
> @@ -65,8 +68,9 @@ static inline int read_spec_entry(char **entry, char **ptr, int *len, const char
>   */
>  int hidden read_spec_entries(char *line_buf, const char **errbuf, int num_args, ...)
>  {
> -	char **spec_entry, *buf_p;
> -	int len, rc, items, entry_len = 0;
> +	struct len_str *spec_entry;
> +	char *buf_p;
> +	int len, rc, items;
>  	va_list ap;
>  
>  	*errbuf = NULL;
> @@ -93,20 +97,22 @@ int hidden read_spec_entries(char *line_buf, const char **errbuf, int num_args,
>  
>  	items = 0;
>  	while (items < num_args) {
> -		spec_entry = va_arg(ap, char **);
> +		spec_entry = va_arg(ap, struct len_str *);
>  
>  		if (len - 1 == buf_p - line_buf) {
>  			va_end(ap);
>  			return items;
>  		}
>  
> -		rc = read_spec_entry(spec_entry, &buf_p, &entry_len, errbuf);
> +		rc = read_spec_entry(spec_entry, &buf_p, errbuf);
>  		if (rc < 0) {
>  			va_end(ap);
>  			return rc;
>  		}
> -		if (entry_len)
> +
> +		if (spec_entry->len) {
>  			items++;
> +		}
>  	}
>  	va_end(ap);
>  	return items;
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index 700def1..cdbac8c 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -81,7 +81,8 @@ static int process_line(const char *path, char *line_buf, int pass,
>  			return 0;
>  		}
>  		data->spec_arr[data->nspec].key = key;
> -		data->spec_arr[data->nspec].lr.ctx_raw = context;
> +		data->spec_arr[data->nspec].lr.ctx_raw.str = context;
> +		data->spec_arr[data->nspec].lr.ctx_raw.len = strlen(context);
>  		free(type);
>  	}
>  
> @@ -186,7 +187,7 @@ static void close(struct selabel_handle *rec)
>  	for (i = 0; i < data->nspec; i++) {
>  		spec = &spec_arr[i];
>  		free(spec->key);
> -		free(spec->lr.ctx_raw);
> +		free(spec->lr.ctx_raw.str);
>  		free(spec->lr.ctx_trans);
>  	}
>  
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
> index 4764ab7..96c39b4 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -541,7 +541,7 @@ int compat_validate(struct selabel_handle *rec,
>  		    const char *path, unsigned lineno)
>  {
>  	int rc;
> -	char **ctx = &contexts->ctx_raw;
> +	char **ctx = &contexts->ctx_raw.str;
>  
>  	if (myinvalidcon)
>  		rc = myinvalidcon(path, lineno, *ctx);
> 
