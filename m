Message-ID: <55804F6E.5020409@tycho.nsa.gov>
Date: Tue, 16 Jun 2015 12:31:42 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH V3] libselinux: Enhance file context support
References: <1434462559-3970-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1434462559-3970-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/16/2015 09:49 AM, Richard Haines wrote:
> Update file contexts generation and loading to use common code.
> 
> Remove "status = 0; after "status = sort_specs(data);" otherwise
> the function will never indicate a failure.
> 
> The file labeling code also has minor formatting, white space
> removal etc. changes.
> 
> label_file.c - Move process_line function to label_file.h
> sefcontext_compile.c - Update to use common process_line code. Now frees
> all malloc'ed memory, checked by valgrind. Also added optional -o output
> file parameter - updated man page to reflect this change.
> 
> V2 - Revert to using compat_validate instead of selabel_validate.
> V3 - Revert to using callback for validation now the problem has been
> fixed by commit e88914849490c3fc17b0e5ed67387e47f2701d3c
> ("libselinux:  build sefcontext_compile with static libselinux")
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
>  libselinux/man/man8/sefcontext_compile.8 |  49 ++++++-
>  libselinux/src/label_file.c              | 171 +++-------------------
>  libselinux/src/label_file.h              | 151 ++++++++++++++++++-
>  libselinux/src/label_internal.h          |   2 +-
>  libselinux/utils/sefcontext_compile.c    | 244 +++++++++++++++----------------
>  5 files changed, 325 insertions(+), 292 deletions(-)
> 
> diff --git a/libselinux/man/man8/sefcontext_compile.8 b/libselinux/man/man8/sefcontext_compile.8
> index 810d22a..584c4c6 100644
> --- a/libselinux/man/man8/sefcontext_compile.8
> +++ b/libselinux/man/man8/sefcontext_compile.8
> @@ -1,15 +1,56 @@
> -.TH "sefcontext_compile" "8" "27 Jun 2013" "dwalsh@redhat.com" "SELinux Command Line documentation"
> +.TH "sefcontext_compile" "8" "12 Jun 2015" "dwalsh@redhat.com" "SELinux Command Line documentation"
>  .SH "NAME"
>  sefcontext_compile \- compile file context regular expression files
>  .
>  .SH "SYNOPSIS"
> -.B sefcontext_compile inputfile
> +.B sefcontext_compile
> +.RB [ \-o
> +.IR outputfile ]
> +.I inputfile
>  .
>  .SH "DESCRIPTION"
> -sefcontext_compile is used libsemanage to compile file context regular expressions into prce format.  sefcontext_compile writes the compiled prce file with the .bin suffix appended "inputfile".bin.  This compiled file is used by libselinux file labeling functions.
> +.B sefcontext_compile
> +is used to compile file context regular expressions into
> +.BR prce (3)
> +format.
> +.sp
> +The compiled file is used by libselinux file labeling functions.
> +.sp
> +By default
> +.B sefcontext_compile
> +writes the compiled prce file with the
> +.B .bin
> +suffix appended (e.g. \fIinputfile\fB.bin\fR).
> +.SH OPTIONS
> +.TP
> +.B \-o
> +Specify an
> +.I outputfile
> +that must be a fully qualified file name as the
> +.B .bin
> +suffix is not automatically added.
> +.
> +.SH "RETURN VALUE"
> +On error -1 is returned.  On success 0 is returned.
>  
> -.SH "EXAMPLE"
> +.SH "EXAMPLES"
> +.B Example 1:
> +.br
>  sefcontext_compile /etc/selinux/targeted/contexts/files/file_contexts
> +.sp
> +Results in the following file being generated:
> +.RS
> +/etc/selinux/targeted/contexts/files/file_contexts.bin
> +.RE
> +.sp
> +.B Example 2:
> +.br
> +sefcontext_compile -o new_fc.bin /etc/selinux/targeted/contexts/files/file_contexts
> +.sp
> +Results in the following file being generated in the cwd:
> +.RS
> +new_fc.bin
> +.RE
>  .
>  .SH AUTHOR
>  Dan Walsh, <dwalsh@redhat.com>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 60aae66..1d6c36e 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -15,13 +15,11 @@
>  #include <limits.h>
>  #include <stdint.h>
>  #include <pcre.h>
> -
> -#include <linux/limits.h>
> -
> +#include <unistd.h>
>  #include <sys/mman.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> -#include <unistd.h>
> +
>  #include "callbacks.h"
>  #include "label_internal.h"
>  #include "label_file.h"
> @@ -72,12 +70,14 @@ static int nodups_specs(struct saved_data *data, const char *path)
>  	for (ii = 0; ii < data->nspec; ii++) {
>  		curr_spec = &spec_arr[ii];
>  		for (jj = ii + 1; jj < data->nspec; jj++) {
> -			if ((!strcmp(spec_arr[jj].regex_str, curr_spec->regex_str))
> +			if ((!strcmp(spec_arr[jj].regex_str,
> +				curr_spec->regex_str))
>  			    && (!spec_arr[jj].mode || !curr_spec->mode
>  				|| spec_arr[jj].mode == curr_spec->mode)) {
>  				rc = -1;
>  				errno = EINVAL;
> -				if (strcmp(spec_arr[jj].lr.ctx_raw, curr_spec->lr.ctx_raw)) {
> +				if (strcmp(spec_arr[jj].lr.ctx_raw,
> +					    curr_spec->lr.ctx_raw)) {
>  					COMPAT_LOG
>  						(SELINUX_ERROR,
>  						 "%s: Multiple different specifications for %s  (%s and %s).\n",
> @@ -96,136 +96,8 @@ static int nodups_specs(struct saved_data *data, const char *path)
>  	return rc;
>  }
>  
> -static int compile_regex(struct saved_data *data, struct spec *spec, const char **errbuf)
> -{
> -	const char *tmperrbuf;
> -	char *reg_buf, *anchored_regex, *cp;
> -	struct stem *stem_arr = data->stem_arr;
> -	size_t len;
> -	int erroff;
> -
> -	if (spec->regcomp)
> -		return 0; /* already done */
> -
> -	/* Skip the fixed stem. */
> -	reg_buf = spec->regex_str;
> -	if (spec->stem_id >= 0)
> -		reg_buf += stem_arr[spec->stem_id].len;
> -
> -	/* Anchor the regular expression. */
> -	len = strlen(reg_buf);
> -	cp = anchored_regex = malloc(len + 3);
> -	if (!anchored_regex)
> -		return -1;
> -
> -	/* Create ^...$ regexp.  */
> -	*cp++ = '^';
> -	cp = mempcpy(cp, reg_buf, len);
> -	*cp++ = '$';
> -	*cp = '\0';
> -
> -	/* Compile the regular expression. */
> -	spec->regex = pcre_compile(anchored_regex, PCRE_DOTALL, &tmperrbuf, &erroff, NULL);
> -	free(anchored_regex);
> -	if (!spec->regex) {
> -		if (errbuf)
> -			*errbuf=tmperrbuf;
> -		return -1;
> -	}
> -
> -	spec->sd = pcre_study(spec->regex, 0, &tmperrbuf);
> -	if (!spec->sd && tmperrbuf) {
> -		if (errbuf)
> -			*errbuf=tmperrbuf;
> -		return -1;
> -	}
> -
> -	/* Done. */
> -	spec->regcomp = 1;
> -
> -	return 0;
> -}
> -
> -static int process_line(struct selabel_handle *rec,
> -			const char *path, const char *prefix,
> -			char *line_buf, unsigned lineno)
> -{
> -	int items, len, rc;
> -	char *regex = NULL, *type = NULL, *context = NULL;
> -	struct saved_data *data = (struct saved_data *)rec->data;
> -	struct spec *spec_arr;
> -	unsigned int nspec = data->nspec;
> -	const char *errbuf = NULL;
> -
> -	items = read_spec_entries(line_buf, 3, &regex, &type, &context);
> -	if (items <= 0)
> -		return items;
> -
> -	if (items < 2) {
> -		COMPAT_LOG(SELINUX_WARNING,
> -			    "%s:  line %u is missing fields, skipping\n", path,
> -			    lineno);
> -		if (items == 1)
> -			free(regex);
> -		return 0;
> -	} else if (items == 2) {
> -		/* The type field is optional. */
> -		free(context);
> -		context = type;
> -		type = 0;
> -	}
> -
> -	len = get_stem_from_spec(regex);
> -	if (len && prefix && strncmp(prefix, regex, len)) {
> -		/* Stem of regex does not match requested prefix, discard. */
> -		free(regex);
> -		free(type);
> -		free(context);
> -		return 0;
> -	}
> -
> -	rc = grow_specs(data);
> -	if (rc)
> -		return rc;
> -
> -	spec_arr = data->spec_arr;
> -
> -	/* process and store the specification in spec. */
> -	spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
> -	spec_arr[nspec].regex_str = regex;
> -	if (rec->validating && compile_regex(data, &spec_arr[nspec], &errbuf)) {
> -		COMPAT_LOG(SELINUX_WARNING, "%s:  line %u has invalid regex %s:  %s\n",
> -			   path, lineno, regex, (errbuf ? errbuf : "out of memory"));
> -	}
> -
> -	/* Convert the type string to a mode format */
> -	spec_arr[nspec].type_str = type;
> -	spec_arr[nspec].mode = 0;
> -	if (type) {
> -		mode_t mode = string_to_mode(type);
> -		if (mode == (mode_t)-1) {
> -			COMPAT_LOG(SELINUX_WARNING, "%s:  line %u has invalid file type %s\n",
> -				   path, lineno, type);
> -			mode = 0;
> -		}
> -		spec_arr[nspec].mode = mode;
> -	}
> -
> -	spec_arr[nspec].lr.ctx_raw = context;
> -
> -	/* Determine if specification has
> -	 * any meta characters in the RE */
> -	spec_hasMetaChars(&spec_arr[nspec]);
> -
> -	if (strcmp(context, "<<none>>") && rec->validating)
> -		compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
> -
> -	data->nspec = ++nspec;
> -
> -	return 0;
> -}
> -
> -static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *sb)
> +static int load_mmap(struct selabel_handle *rec, const char *path,
> +						    struct stat *sb)
>  {
>  	struct saved_data *data = (struct saved_data *)rec->data;
>  	char mmap_path[PATH_MAX + 1];
> @@ -259,12 +131,6 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>  		return -1;
>  	}
>  
> -	if (mmap_stat.st_mtime == sb->st_mtime &&
> -	    mmap_stat.st_mtim.tv_nsec < sb->st_mtim.tv_nsec) {
> -		close(mmapfd);
> -		return -1;
> -	}
> -
>  	/* ok, read it in... */
>  	len = mmap_stat.st_size;
>  	len += (sysconf(_SC_PAGE_SIZE) - 1);
> @@ -460,7 +326,7 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
>  		if (rc < 0)
>  			goto err;
>  
> -		if (stem_id < 0 || stem_id >= stem_map_len)
> +		if (stem_id < 0 || stem_id >= (int32_t)stem_map_len)
>  			spec->stem_id = -1;
>  		 else
>  			spec->stem_id = stem_map[stem_id];
> @@ -520,19 +386,21 @@ err:
>  	return rc;
>  }
>  
> -static int process_file(const char *path, const char *suffix, struct selabel_handle *rec, const char *prefix)
> +static int process_file(const char *path, const char *suffix,
> +			  struct selabel_handle *rec, const char *prefix)
>  {
>  	FILE *fp;
>  	struct stat sb;
>  	unsigned int lineno;
> -	size_t line_len;
> +	size_t line_len = 0;
>  	char *line_buf = NULL;
>  	int rc;
>  	char stack_path[PATH_MAX + 1];
>  
>  	/* append the path suffix if we have one */
>  	if (suffix) {
> -		rc = snprintf(stack_path, sizeof(stack_path), "%s.%s", path, suffix);
> +		rc = snprintf(stack_path, sizeof(stack_path),
> +					    "%s.%s", path, suffix);
>  		if (rc >= (int)sizeof(stack_path)) {
>  			errno = ENAMETOOLONG;
>  			return -1;
> @@ -563,13 +431,13 @@ static int process_file(const char *path, const char *suffix, struct selabel_han
>  	while (getline(&line_buf, &line_len, fp) > 0) {
>  		rc = process_line(rec, path, prefix, line_buf, ++lineno);
>  		if (rc)
> -			return rc;
> +			goto out;
>  	}
> +
>  out:
>  	free(line_buf);
>  	fclose(fp);
> -
> -	return 0;
> +	return rc;
>  }
>  
>  static int init(struct selabel_handle *rec, struct selinux_opt *opts,
> @@ -609,7 +477,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
>  
>  	rec->spec_file = strdup(path);
>  
> -	/* 
> +	/*
>  	 * The do detailed validation of the input and fill the spec array
>  	 */
>  	status = process_file(path, NULL, rec, prefix);
> @@ -634,7 +502,6 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
>  
>  	status = sort_specs(data);
>  
> -	status = 0;
>  finish:
>  	if (status)
>  		free(data->spec_arr);
> @@ -731,7 +598,7 @@ static struct spec *lookup_common(struct selabel_handle *rec,
>  	if (partial)
>  		pcre_options |= PCRE_PARTIAL_SOFT;
>  
> -	/* 
> +	/*
>  	 * Check for matching specifications in reverse order, so that
>  	 * the last matching specification is used.
>  	 */
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index a8d1e51..73bcbba 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -3,6 +3,7 @@
>  
>  #include <sys/stat.h>
>  
> +#include "callbacks.h"
>  #include "label_internal.h"
>  
>  #define SELINUX_MAGIC_COMPILED_FCONTEXT	0xf97cff8a
> @@ -14,7 +15,7 @@
>  
>  #define SELINUX_COMPILED_FCONTEXT_MAX_VERS	SELINUX_COMPILED_FCONTEXT_MODE
>  
> -/* Prior to verison 8.20, libpcre did not have pcre_free_study() */
> +/* Prior to version 8.20, libpcre did not have pcre_free_study() */
>  #if (PCRE_MAJOR < 8 || (PCRE_MAJOR == 8 && PCRE_MINOR < 20))
>  #define pcre_free_study  pcre_free
>  #endif
> @@ -173,7 +174,6 @@ static inline void spec_hasMetaChars(struct spec *spec)
>  		}
>  		c++;
>  	}
> -	return;
>  }
>  
>  /* Move exact pathname specifications to the end. */
> @@ -200,9 +200,9 @@ static inline int sort_specs(struct saved_data *data)
>  	}
>  
>  	/*
> -	 * now the exact pathnames are at the end, but they are in the reverse order.
> -	 * since 'front' is now the first of the 'exact' we can run that part of the
> -	 * array switching the front and back element.
> +	 * now the exact pathnames are at the end, but they are in the reverse
> +	 * order. Since 'front' is now the first of the 'exact' we can run
> +	 * that part of the array switching the front and back element.
>  	 */
>  	back = data->nspec - 1;
>  	while (front < back) {
> @@ -242,7 +242,8 @@ static inline int get_stem_from_spec(const char *const buf)
>  /*
>   * return the stemid given a string and a length
>   */
> -static inline int find_stem(struct saved_data *data, const char *buf, int stem_len)
> +static inline int find_stem(struct saved_data *data, const char *buf,
> +						    int stem_len)
>  {
>  	int i;
>  
> @@ -317,4 +318,142 @@ static inline int next_entry(void *buf, struct mmap_area *fp, size_t bytes)
>  	return 0;
>  }
>  
> +static inline int compile_regex(struct saved_data *data, struct spec *spec,
> +					    const char **errbuf)
> +{
> +	const char *tmperrbuf;
> +	char *reg_buf, *anchored_regex, *cp;
> +	struct stem *stem_arr = data->stem_arr;
> +	size_t len;
> +	int erroff;
> +
> +	if (spec->regcomp)
> +		return 0; /* already done */
> +
> +	/* Skip the fixed stem. */
> +	reg_buf = spec->regex_str;
> +	if (spec->stem_id >= 0)
> +		reg_buf += stem_arr[spec->stem_id].len;
> +
> +	/* Anchor the regular expression. */
> +	len = strlen(reg_buf);
> +	cp = anchored_regex = malloc(len + 3);
> +	if (!anchored_regex)
> +		return -1;
> +
> +	/* Create ^...$ regexp.  */
> +	*cp++ = '^';
> +	memcpy(cp, reg_buf, len);
> +	cp += len;
> +	*cp++ = '$';
> +	*cp = '\0';
> +
> +	/* Compile the regular expression. */
> +	spec->regex = pcre_compile(anchored_regex, PCRE_DOTALL, &tmperrbuf,
> +						    &erroff, NULL);
> +	free(anchored_regex);
> +	if (!spec->regex) {
> +		if (errbuf)
> +			*errbuf = tmperrbuf;
> +		return -1;
> +	}
> +
> +	spec->sd = pcre_study(spec->regex, 0, &tmperrbuf);
> +	if (!spec->sd && tmperrbuf) {
> +		if (errbuf)
> +			*errbuf = tmperrbuf;
> +		return -1;
> +	}
> +
> +	/* Done. */
> +	spec->regcomp = 1;
> +
> +	return 0;
> +}
> +
> +/* This service is used by label_file.c process_file() and
> + * utils/sefcontext_compile.c */
> +static inline int process_line(struct selabel_handle *rec,
> +			const char *path, const char *prefix,
> +			char *line_buf, unsigned lineno)
> +{
> +	int items, len, rc;
> +	char *regex = NULL, *type = NULL, *context = NULL;
> +	struct saved_data *data = (struct saved_data *)rec->data;
> +	struct spec *spec_arr;
> +	unsigned int nspec = data->nspec;
> +	const char *errbuf = NULL;
> +
> +	items = read_spec_entries(line_buf, 3, &regex, &type, &context);
> +	if (items <= 0)
> +		return items;
> +
> +	if (items < 2) {
> +		COMPAT_LOG(SELINUX_WARNING,
> +			    "%s:  line %u is missing fields, skipping\n", path,
> +			    lineno);
> +		if (items == 1)
> +			free(regex);
> +		return 0;
> +	} else if (items == 2) {
> +		/* The type field is optional. */
> +		context = type;
> +		type = 0;
> +	}
> +
> +	len = get_stem_from_spec(regex);
> +	if (len && prefix && strncmp(prefix, regex, len)) {
> +		/* Stem of regex does not match requested prefix, discard. */
> +		free(regex);
> +		free(type);
> +		free(context);
> +		return 0;
> +	}
> +
> +	rc = grow_specs(data);
> +	if (rc)
> +		return rc;
> +
> +	spec_arr = data->spec_arr;
> +
> +	/* process and store the specification in spec. */
> +	spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
> +	spec_arr[nspec].regex_str = regex;
> +	if (rec->validating &&
> +			    compile_regex(data, &spec_arr[nspec], &errbuf)) {
> +		COMPAT_LOG(SELINUX_WARNING,
> +			   "%s:  line %u has invalid regex %s:  %s\n",
> +			   path, lineno, regex,
> +			   (errbuf ? errbuf : "out of memory"));
> +	}
> +
> +	/* Convert the type string to a mode format */
> +	spec_arr[nspec].type_str = type;
> +	spec_arr[nspec].mode = 0;
> +	if (type) {
> +		mode_t mode = string_to_mode(type);
> +
> +		if (mode == (mode_t)-1) {
> +			COMPAT_LOG(SELINUX_WARNING,
> +				   "%s:  line %u has invalid file type %s\n",
> +				   path, lineno, type);
> +			mode = 0;
> +		}
> +		spec_arr[nspec].mode = mode;
> +	}
> +
> +	spec_arr[nspec].lr.ctx_raw = context;
> +
> +	/* Determine if specification has
> +	 * any meta characters in the RE */
> +	spec_hasMetaChars(&spec_arr[nspec]);
> +
> +	if (strcmp(context, "<<none>>") && rec->validating)
> +		compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
> +
> +	data->nspec = ++nspec;
> +
> +	return 0;
> +}
> +
>  #endif /* _SELABEL_FILE_H_ */
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
> index 0e582b6..5300319 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -90,7 +90,7 @@ selabel_validate(struct selabel_handle *rec,
>   */
>  extern int myprintf_compat;
>  extern void __attribute__ ((format(printf, 1, 2)))
> -(*myprintf) (const char *fmt,...);
> +(*myprintf) (const char *fmt, ...);
>  
>  #define COMPAT_LOG(type, fmt...) if (myprintf_compat)	  \
>  		myprintf(fmt);				  \
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
> index 03bc0a7..1c46af8 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -7,117 +7,43 @@
>  #include <unistd.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> -
> -#include <linux/limits.h>
> +#include <getopt.h>
> +#include <limits.h>
> +#include <selinux/selinux.h>
>  
>  #include "../src/label_file.h"
>  
> -static int process_file(struct saved_data *data, const char *filename)
> +static int validate_context(char __attribute__ ((unused)) **ctx)
> +{
> +	return 0;
> +}
> +
> +static int process_file(struct selabel_handle *rec, const char *filename)
>  {
> -	struct spec *spec;
>  	unsigned int line_num;
> +	int rc;
>  	char *line_buf = NULL;
> -	size_t line_len;
> -	ssize_t len;
> +	size_t line_len = 0;
>  	FILE *context_file;
> +	const char *prefix = NULL;
>  
>  	context_file = fopen(filename, "r");
>  	if (!context_file) {
> -		fprintf(stderr, "Error opening %s: %s\n", filename, strerror(errno));
> +		fprintf(stderr, "Error opening %s: %s\n",
> +			    filename, strerror(errno));
>  		return -1;
>  	}
>  
>  	line_num = 0;
> -	while ((len = getline(&line_buf, &line_len, context_file)) != -1) {
> -		char *context = NULL;
> -		char *mode = NULL;
> -		char *regex = NULL;
> -		char *cp, *anchored_regex;
> -		pcre *re;
> -		pcre_extra *sd;
> -		const char *err;
> -		int items, erroff, rc;
> -		size_t regex_len;
> -		int32_t stem_id;
> -
> -		line_num++;
> -
> -		items = read_spec_entries(line_buf, 3, &regex, &mode, &context);
> -		if (items < 0)
> -			return -1;
> -
> -		if (items == 0)
> -			continue;
> -		else if (items == 1) {
> -			fprintf(stderr,
> -				 "line: %u has invalid entry - skipping: %s\n",
> -				 line_num, line_buf);
> -			continue;
> -		} else if (items == 2) {
> -			context = mode;
> -			mode = NULL;
> -		}
> -
> -		rc = grow_specs(data);
> -		if (rc) {
> -			fprintf(stderr, "grow_specs failed: %s\n", strerror(errno));
> -			return rc;
> -		}
> -
> -		spec = &data->spec_arr[data->nspec];
> -
> -		spec->lr.ctx_raw = context;
> -		spec->mode = string_to_mode(mode);
> -		if (spec->mode == (mode_t)-1) {
> -			fprintf(stderr, "%s: line %u has invalid file type %s\n",
> -				regex, line_num + 1, mode);
> -			spec->mode = 0;
> -		}
> -		free(mode);
> -		spec->regex_str = regex;
> -
> -		stem_id = find_stem_from_spec(data, regex);
> -		spec->stem_id = stem_id;
> -		/* skip past the fixed stem part */
> -		if (stem_id != -1)
> -			regex += data->stem_arr[stem_id].len;
> -
> -		regex_len = strlen(regex);
> -		cp = anchored_regex = malloc(regex_len + 3);
> -		if (!cp) {
> -			fprintf(stderr, "Malloc Failed: %s\n", strerror(errno));
> -			return -1;
> -		}
> -		*cp++ = '^';
> -		memcpy(cp, regex, regex_len);
> -		cp += regex_len;
> -		*cp++ = '$';
> -		*cp = '\0';
> -
> -		spec_hasMetaChars(spec);
> -
> -		re = pcre_compile(anchored_regex, PCRE_DOTALL, &err, &erroff, NULL);
> -		if (!re) {
> -			fprintf(stderr, "PCRE compilation failed for %s at offset %d: %s\n", anchored_regex, erroff, err);
> -			return -1;
> -		}
> -		spec->regex = re;
> -
> -		sd = pcre_study(re, 0, &err);
> -		if (!sd) {
> -			fprintf(stderr, "PCRE study failed for %s: %s\n", anchored_regex, err);
> -			return -1;
> -		}
> -		free(anchored_regex);
> -		spec->sd = sd;
> -
> -		data->nspec++;
> +	while (getline(&line_buf, &line_len, context_file) > 0) {
> +		rc = process_line(rec, filename, prefix, line_buf, ++line_num);
> +		if (rc)
> +			goto out;
>  	}
> -
> +out:
>  	free(line_buf);
>  	fclose(context_file);
> -
> -	return 0;
> +	return rc;
>  }
>  
>  /*
> @@ -129,12 +55,12 @@ static int process_file(struct saved_data *data, const char *filename)
>   * char - pcre version string EXCLUDING nul
>   * u32 - number of stems
>   * ** Stems
> - * 	u32  - length of stem EXCLUDING nul
> - * 	char - stem char array INCLUDING nul
> + *	u32  - length of stem EXCLUDING nul
> + *	char - stem char array INCLUDING nul
>   * u32 - number of regexs
>   * ** Regexes
> - * 	u32  - length of upcoming context INCLUDING nul
> - * 	char - char array of the raw context
> + *	u32  - length of upcoming context INCLUDING nul
> + *	char - char array of the raw context
>   *	u32  - length of the upcoming regex_str
>   *	char - char array of the original regex string including the stem.
>   *	u32  - mode bits for >= SELINUX_COMPILED_FCONTEXT_MODE
> @@ -301,7 +227,7 @@ err:
>  	goto out;
>  }
>  
> -static int free_specs(struct saved_data *data)
> +static void free_specs(struct saved_data *data)
>  {
>  	struct spec *specs = data->spec_arr;
>  	unsigned int num_entries = data->nspec;
> @@ -311,59 +237,115 @@ static int free_specs(struct saved_data *data)
>  		free(specs[i].lr.ctx_raw);
>  		free(specs[i].lr.ctx_trans);
>  		free(specs[i].regex_str);
> +		free(specs[i].type_str);
>  		pcre_free(specs[i].regex);
>  		pcre_free_study(specs[i].sd);
>  	}
>  	free(specs);
>  
>  	num_entries = data->num_stems;
> -	for (i = 0; i < num_entries; i++) {
> +	for (i = 0; i < num_entries; i++)
>  		free(data->stem_arr[i].buf);
> -	}
>  	free(data->stem_arr);
>  
>  	memset(data, 0, sizeof(*data));
> -	return 0;
> +}
> +
> +static void usage(const char *progname)
> +{
> +	fprintf(stderr,
> +		"usage: %s [-o out_file] fc_file\n"
> +		"Where:\n\t"
> +		"-o      Optional file name of the PCRE formatted binary\n\t"
> +		"        file to be output. If not specified the default\n\t"
> +		"        will be fc_file with the .bin suffix appended.\n\t"
> +		"fc_file The text based file contexts file to be processed.\n",
> +		progname);
> +		exit(EXIT_FAILURE);
>  }
>  
>  int main(int argc, char *argv[])
>  {
> -	struct saved_data data;
> -	const char *path;
> +	const char *path = NULL;
> +	const char *out_file = NULL;
>  	char stack_path[PATH_MAX + 1];
> -	int rc;
> -	char *tmp= NULL;
> -	int fd;
> +	char *tmp = NULL;
> +	int fd, rc, opt;
>  	struct stat buf;
> -
> -	if (argc != 2) {
> -		fprintf(stderr, "usage: %s input_file\n", argv[0]);
> -		exit(EXIT_FAILURE);
> +	struct selabel_handle *rec = NULL;
> +	struct saved_data *data = NULL;
> +
> +	if (argc < 2)
> +		usage(argv[0]);
> +
> +	while ((opt = getopt(argc, argv, "o:")) > 0) {
> +		switch (opt) {
> +		case 'o':
> +			out_file = optarg;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
>  	}
>  
> -	memset(&data, 0, sizeof(data));
> -
> -	path = argv[1];
> +	if (optind >= argc)
> +		usage(argv[0]);
>  
> +	path = argv[optind];
>  	if (stat(path, &buf) < 0) {
>  		fprintf(stderr, "Can not stat: %s: %m\n", path);
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	rc = process_file(&data, path);
> +	/* Generate dummy handle for process_line() function */
> +	rec = (struct selabel_handle *)calloc(1, sizeof(*rec));
> +	if (!rec) {
> +		fprintf(stderr, "Failed to calloc handle\n");
> +		exit(EXIT_FAILURE);
> +	}
> +	rec->backend = SELABEL_CTX_FILE;
> +
> +	/* Need to set validation on to get the bin file generated by the
> +	 * process_line function, however as the bin file being generated
> +	 * may not be related to the currently loaded policy (that it
> +	 * would be validated against), then set callback to ignore any
> +	 * validation. */
> +	rec->validating = 1;
> +	selinux_set_callback(SELINUX_CB_VALIDATE,
> +			    (union selinux_callback)&validate_context);
> +
> +	data = (struct saved_data *)calloc(1, sizeof(*data));
> +	if (!data) {
> +		fprintf(stderr, "Failed to calloc saved_data\n");
> +		free(rec);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	rec->data = data;
> +
> +	rc = process_file(rec, path);
>  	if (rc < 0)
> -		return rc;
> +		goto err;
>  
> -	rc = sort_specs(&data);
> +	rc = sort_specs(data);
>  	if (rc)
> -		return rc;
> +		goto err;
> +
> +	if (out_file)
> +		rc = snprintf(stack_path, sizeof(stack_path), "%s", out_file);
> +	else
> +		rc = snprintf(stack_path, sizeof(stack_path), "%s.bin", path);
>  
> -	rc = snprintf(stack_path, sizeof(stack_path), "%s.bin", path);
>  	if (rc < 0 || rc >= (int)sizeof(stack_path))
> -		return rc;
> +		goto err;
>  
> -	if (asprintf(&tmp, "%sXXXXXX", stack_path) < 0)
> -		return -1;
> +	tmp = malloc(strlen(stack_path) + 7);
> +	if (!tmp)
> +		goto err;
> +
> +	rc = sprintf(tmp, "%sXXXXXX", stack_path);
> +	if (rc < 0)
> +		goto err;
>  
>  	fd  = mkstemp(tmp);
>  	if (fd < 0)
> @@ -372,23 +354,27 @@ int main(int argc, char *argv[])
>  	rc = fchmod(fd, buf.st_mode);
>  	if (rc < 0) {
>  		perror("fchmod failed to set permission on compiled regexs");
> -		goto err;
> +		goto err_unlink;
>  	}
>  
> -	rc = write_binary_file(&data, fd);
> -
> +	rc = write_binary_file(data, fd);
>  	if (rc < 0)
> -		goto err;
> +		goto err_unlink;
>  
> -	rename(tmp, stack_path);
> -	rc = free_specs(&data);
> +	rc = rename(tmp, stack_path);
>  	if (rc < 0)
> -		goto err;
> +		goto err_unlink;
>  
>  	rc = 0;
>  out:
> +	free_specs(data);
> +	free(rec);
> +	free(data);
>  	free(tmp);
>  	return rc;
> +
> +err_unlink:
> +	unlink(tmp);
>  err:
>  	rc = -1;
>  	goto out;
> 
