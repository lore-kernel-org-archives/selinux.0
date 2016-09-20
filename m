Subject: Re: [RFC] mmap file_contexts and property_contexts:
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "jdanis@google.com" <jdanis@google.com>
References: <1474321526-26208-1-git-send-email-william.c.roberts@intel.com>
 <476DC76E7D1DF2438D32BFADF679FC561CD0B1D9@ORSMSX103.amr.corp.intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6891e2bf-ef16-d10a-d789-36f6576efacb@tycho.nsa.gov>
Date: Tue, 20 Sep 2016 09:17:33 -0400
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC561CD0B1D9@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/19/2016 05:51 PM, Roberts, William C wrote:
> FYI I only tested this with checkfc...

Evidently.  matchpathcon and sefcontext_compile both report calls to
free() on invalid pointers and abort.

> 
>> -----Original Message-----
>> From: Roberts, William C
>> Sent: Monday, September 19, 2016 2:45 PM
>> To: selinux@tycho.nsa.gov; seandroid-list@tycho.nsa.gov; sds@tycho.nsa.gov;
>> jdanis@google.com
>> Cc: Roberts, William C <william.c.roberts@intel.com>
>> Subject: [RFC] mmap file_contexts and property_contexts:
>>
>> From: William Roberts <william.c.roberts@intel.com>
>>
>> THIS IS WIP...
>>
>> Rather than using stdio and making copies, just mmap the files and use the
>> pointers in place. The affect of this change, is that text file load time is now faster
>> than binary load time by 4.7% when testing with a file_contexts file from the
>> Android tree. Note that the Android doesn't use monstrous regexs.
>>
>> Times are the average of 3 runs.
>>
>> BEFORE:
>> Text file allocs: 114803
>> Text file load time: 0.266101
>> Bin file allocs: 93073
>> Bin file load time: 0.248757667
>>
>> AFTER:
>> Text file allocs: 103933
>> Text file load time: 0.236192667
>> Bin file allocs: 87645
>> Bin file load time: .247607333
>>
>> THINGS TO DO:
>> 1. What's arm performance like?
>> 2. What interfaces to backends are busted by this (if any)?
>> 3. Test Android Properties
>> 4. Im pretty sure this breaks sefcontext_compile, fix.
>> 5. Test with PCRE2 enabled.
>> 6. Spell check this message!
>> 7. Run checkpatch
>>
>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> ---
>>  libselinux/src/label.c                  |   2 -
>>  libselinux/src/label_android_property.c |  22 ++---
>>  libselinux/src/label_file.c             | 140 +++++++++++++++++++-------------
>>  libselinux/src/label_file.h             |  66 +++++++++------
>>  libselinux/src/label_internal.h         |   3 +-
>>  libselinux/src/label_support.c          |  79 ++++++++----------
>>  6 files changed, 172 insertions(+), 140 deletions(-)
>>
>> diff --git a/libselinux/src/label.c b/libselinux/src/label.c index 963bfcb..d767b49
>> 100644
>> --- a/libselinux/src/label.c
>> +++ b/libselinux/src/label.c
>> @@ -15,8 +15,6 @@
>>  #include "callbacks.h"
>>  #include "label_internal.h"
>>
>> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>> -
>>  typedef int (*selabel_initfunc)(struct selabel_handle *rec,
>>  				const struct selinux_opt *opts,
>>  				unsigned nopts);
>> diff --git a/libselinux/src/label_android_property.c
>> b/libselinux/src/label_android_property.c
>> index 290b438..2aac394 100644
>> --- a/libselinux/src/label_android_property.c
>> +++ b/libselinux/src/label_android_property.c
>> @@ -85,13 +85,19 @@ static int process_line(struct selabel_handle *rec,
>>  			int pass, unsigned lineno)
>>  {
>>  	int items;
>> -	char *prop = NULL, *context = NULL;
>> +	union {
>> +		struct {
>> +			char *prop;
>> +			char *context;
>> +		};
>> +		char *array[2];
>> +	} found = { .array = { 0 } };
>>  	struct saved_data *data = (struct saved_data *)rec->data;
>>  	spec_t *spec_arr = data->spec_arr;
>>  	unsigned int nspec = data->nspec;
>>  	const char *errbuf = NULL;
>>
>> -	items = read_spec_entries(line_buf, &errbuf, 2, &prop, &context);
>> +	items = read_spec_entries(line_buf, &errbuf, ARRAY_SIZE(found.array),
>> +found.array);
>>  	if (items < 0) {
>>  		items = errno;
>>  		selinux_log(SELINUX_ERROR,
>> @@ -108,18 +114,14 @@ static int process_line(struct selabel_handle *rec,
>>  		selinux_log(SELINUX_ERROR,
>>  			    "%s:  line %u is missing fields\n", path,
>>  			    lineno);
>> -		free(prop);
>>  		errno = EINVAL;
>>  		return -1;
>>  	}
>>
>> -	if (pass == 0) {
>> -		free(prop);
>> -		free(context);
>> -	} else if (pass == 1) {
>> +	if (pass == 1) {
>>  		/* On the second pass, process and store the specification in
>> spec. */
>> -		spec_arr[nspec].property_key = prop;
>> -		spec_arr[nspec].lr.ctx_raw = context;
>> +		spec_arr[nspec].property_key = found.prop;
>> +		spec_arr[nspec].lr.ctx_raw = found.context;
>>
>>  		if (rec->validating) {
>>  			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) { @@ -
>> 234,7 +236,7 @@ static void closef(struct selabel_handle *rec)
>>  	for (i = 0; i < data->nspec; i++) {
>>  		spec = &data->spec_arr[i];
>>  		free(spec->property_key);
>> -		free(spec->lr.ctx_raw);
>> +		//free(spec->lr.ctx_raw);
>>  		free(spec->lr.ctx_trans);
>>  	}
>>
>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c index
>> 7156825..4dc440e 100644
>> --- a/libselinux/src/label_file.c
>> +++ b/libselinux/src/label_file.c
>> @@ -96,43 +96,64 @@ static int nodups_specs(struct saved_data *data, const
>> char *path)
>>  	return rc;
>>  }
>>
>> -static int process_text_file(FILE *fp, const char *prefix,
>> -			     struct selabel_handle *rec, const char *path)
>> +static inline struct saved_data *rec_to_data(struct selabel_handle
>> +*rec) {
>> +	return (struct saved_data *)rec->data; }
>> +
>> +static char *mmap_area_get_line(struct mmap_area *area) {
>> +	size_t len = area->next_len;
>> +	if (!len)
>> +		return NULL;
>> +
>> +	char *start = area->next_addr;
>> +	char *end = memchr(start, '\n', len);
>> +
>> +	/* the file may not end with a newline */
>> +	if (!end)
>> +		end = (char *)area->next_addr + len - 1;
>> +
>> +	*end = '\0';
>> +	/* len includes null byte */
>> +	len = end - start;
>> +
>> +	area->next_len -= len + 1;
>> +	area->next_addr = ++end;
>> +	return start;
>> +}
>> +
>> +static int process_text_file(const char *path, const char *prefix,
>> +		struct selabel_handle *rec)
>>  {
>>  	int rc;
>> -	size_t line_len;
>>  	unsigned int lineno = 0;
>> -	char *line_buf = NULL;
>> +	char *line_buf;
>> +	struct mmap_area *areas = rec_to_data(rec)->mmap_areas;
>> +
>> +	/* mmap_area_get_line() and process_line() require mutable string
>> pointers */
>> +	rc = mprotect(areas->addr, areas->len, PROT_READ | PROT_WRITE);
>> +	if (rc < 0)
>> +		goto out;
>>
>> -	while (getline(&line_buf, &line_len, fp) > 0) {
>> +	while ( (line_buf = mmap_area_get_line(areas)) ) {
>>  		rc = process_line(rec, path, prefix, line_buf, ++lineno);
>>  		if (rc)
>>  			goto out;
>>  	}
>>  	rc = 0;
>>  out:
>> -	free(line_buf);
>>  	return rc;
>>  }
>>
>> -static int load_mmap(FILE *fp, size_t len, struct selabel_handle *rec,
>> -		     const char *path)
>> +static int mmap_file(FILE *fp, size_t len, struct saved_data *data)
>>  {
>> -	struct saved_data *data = (struct saved_data *)rec->data;
>> -	int rc;
>> -	char *addr, *str_buf;
>> -	int *stem_map;
>> -	struct mmap_area *mmap_area;
>> -	uint32_t i, magic, version;
>> -	uint32_t entry_len, stem_map_len, regex_array_len;
>> -	const char *reg_version;
>> -
>> -	mmap_area = malloc(sizeof(*mmap_area));
>> +	struct mmap_area *mmap_area = malloc(sizeof(*mmap_area));
>>  	if (!mmap_area) {
>>  		return -1;
>>  	}
>>
>> -	addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fileno(fp), 0);
>> +	void *addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fileno(fp), 0);
>>  	if (addr == MAP_FAILED) {
>>  		free(mmap_area);
>>  		perror("mmap");
>> @@ -145,17 +166,26 @@ static int load_mmap(FILE *fp, size_t len, struct
>> selabel_handle *rec,
>>  	mmap_area->next = data->mmap_areas;
>>  	data->mmap_areas = mmap_area;
>>
>> -	/* check if this looks like an fcontext file */
>> -	rc = next_entry(&magic, mmap_area, sizeof(uint32_t));
>> -	if (rc < 0 || magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
>> -		return -1;
>> +	return 0;
>> +}
>> +
>> +static int process_binary_file(const char *path, struct selabel_handle
>> +*rec) {
>> +	struct saved_data *data = (struct saved_data *)rec->data;
>> +	int rc;
>> +	char *str_buf;
>> +	int *stem_map;
>> +	struct mmap_area *mmap_area = data->mmap_areas;
>> +	uint32_t i, version;
>> +	uint32_t entry_len, stem_map_len, regex_array_len;
>> +	size_t len;
>>
>>  	/* check if this version is higher than we understand */
>>  	rc = next_entry(&version, mmap_area, sizeof(uint32_t));
>>  	if (rc < 0 || version > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
>>  		return -1;
>>
>> -	reg_version = regex_version();
>> +	const char *reg_version = regex_version();
>>  	if (!reg_version)
>>  		return -1;
>>
>> @@ -235,12 +265,11 @@ static int load_mmap(FILE *fp, size_t len, struct
>> selabel_handle *rec,
>>  		/* store the mapping between old and new */
>>  		newid = find_stem(data, buf, stem_len);
>>  		if (newid < 0) {
>> -			newid = store_stem(data, buf, stem_len);
>> +			newid = store_stem(data, buf, stem_len, true);
>>  			if (newid < 0) {
>>  				rc = newid;
>>  				goto out;
>>  			}
>> -			data->stem_arr[newid].from_mmap = 1;
>>  		}
>>  		stem_map[i] = newid;
>>  	}
>> @@ -262,7 +291,6 @@ static int load_mmap(FILE *fp, size_t len, struct
>> selabel_handle *rec,
>>  			goto out;
>>
>>  		spec = &data->spec_arr[data->nspec];
>> -		spec->from_mmap = 1;
>>
>>  		/* Process context */
>>  		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t)); @@ -
>> 271,22 +299,10 @@ static int load_mmap(FILE *fp, size_t len, struct
>> selabel_handle *rec,
>>  			goto out;
>>  		}
>>
>> -		str_buf = malloc(entry_len);
>> -		if (!str_buf) {
>> -			rc = -1;
>> -			goto out;
>> -		}
>> -		rc = next_entry(str_buf, mmap_area, entry_len);
>> +		rc = next_pstr(&spec->lr.ctx_raw, mmap_area, entry_len);
>>  		if (rc < 0)
>>  			goto out;
>>
>> -		if (str_buf[entry_len - 1] != '\0') {
>> -			free(str_buf);
>> -			rc = -1;
>> -			goto out;
>> -		}
>> -		spec->lr.ctx_raw = str_buf;
>> -
>>  		if (strcmp(spec->lr.ctx_raw, "<<none>>") && rec->validating) {
>>  			if (selabel_validate(rec, &spec->lr) < 0) {
>>  				selinux_log(SELINUX_ERROR,
>> @@ -401,17 +417,29 @@ static char *rolling_append(char *current, const char
>> *suffix, size_t max)
>>  	return current;
>>  }
>>
>> -static bool fcontext_is_binary(FILE *fp)
>> +static inline int mmap_area_rewind(struct mmap_area *area, size_t
>> +bytes) {
>> +	if (area->next_len + bytes > area->len)
>> +		return -1;
>> +
>> +	area->next_addr = (char *) area->next_addr - bytes;
>> +	area->next_len += bytes;
>> +	return 0;
>> +}
>> +
>> +static bool fcontext_is_binary(struct mmap_area *area)
>>  {
>>  	uint32_t magic;
>> +	bool is_binary = false;
>>
>> -	size_t len = fread(&magic, sizeof(magic), 1, fp);
>> -	rewind(fp);
>> +	int rc = next_entry(&magic, area, sizeof(magic));
>>
>> -	return (len && (magic == SELINUX_MAGIC_COMPILED_FCONTEXT));
>> -}
>> +	is_binary = (!rc && (magic == SELINUX_MAGIC_COMPILED_FCONTEXT));
>> +	if (!is_binary)
>> +		mmap_area_rewind(area, sizeof(magic));
>>
>> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>> +	return is_binary;
>> +}
>>
>>  static FILE *open_file(const char *path, const char *suffix,
>>  	       char *save_path, size_t len, struct stat *sb, bool open_oldest) @@ -
>> 504,12 +532,17 @@ static int process_file(const char *path, const char *suffix,
>>  		if (fp == NULL)
>>  			return -1;
>>
>> -		rc = fcontext_is_binary(fp) ?
>> -				load_mmap(fp, sb.st_size, rec, found_path) :
>> -				process_text_file(fp, prefix, rec, found_path);
>> +		rc = mmap_file(fp, sb.st_size, rec_to_data(rec));
>> +		if (rc < 0) {
>> +			fclose(fp);
>> +			return -1;
>> +		}
>> +
>> +		rc = fcontext_is_binary(rec_to_data(rec)->mmap_areas) ?
>> +				process_binary_file(found_path, rec) :
>> +				process_text_file(found_path, prefix, rec);
>>  		if (!rc)
>> -			rc = digest_add_specfile(digest, fp, NULL, sb.st_size,
>> -				found_path);
>> +			rc = digest_add_specfile(digest, fp, NULL, sb.st_size,
>> found_path);
>>
>>  		fclose(fp);
>>
>> @@ -613,12 +646,7 @@ static void closef(struct selabel_handle *rec)
>>  	for (i = 0; i < data->nspec; i++) {
>>  		spec = &data->spec_arr[i];
>>  		free(spec->lr.ctx_trans);
>> -		free(spec->lr.ctx_raw);
>>  		regex_data_free(spec->regex);
>> -		if (spec->from_mmap)
>> -			continue;
>> -		free(spec->regex_str);
>> -		free(spec->type_str);
>>  	}
>>
>>  	for (i = 0; i < (unsigned int)data->num_stems; i++) { diff --git
>> a/libselinux/src/label_file.h b/libselinux/src/label_file.h index 88f4294..2704906
>> 100644
>> --- a/libselinux/src/label_file.h
>> +++ b/libselinux/src/label_file.h
>> @@ -37,7 +37,6 @@ struct spec {
>>  	int matches;		/* number of matching pathnames */
>>  	int stem_id;		/* indicates which stem-compression item */
>>  	char hasMetaChars;	/* regular expression has meta-chars */
>> -	char from_mmap;		/* this spec is from an mmap of the data
>> */
>>  	size_t prefix_len;      /* length of fixed path prefix */
>>  };
>>
>> @@ -255,7 +254,7 @@ static inline int find_stem(struct saved_data *data, const
>> char *buf,  }
>>
>>  /* returns the index of the new stored object */ -static inline int
>> store_stem(struct saved_data *data, char *buf, int stem_len)
>> +static inline int store_stem(struct saved_data *data, char *buf, int
>> +stem_len, bool from_mmap)
>>  {
>>  	int num = data->num_stems;
>>
>> @@ -271,7 +270,7 @@ static inline int store_stem(struct saved_data *data, char
>> *buf, int stem_len)
>>  	}
>>  	data->stem_arr[num].len = stem_len;
>>  	data->stem_arr[num].buf = buf;
>> -	data->stem_arr[num].from_mmap = 0;
>> +	data->stem_arr[num].from_mmap = from_mmap;
>>  	data->num_stems++;
>>
>>  	return num;
>> @@ -298,7 +297,7 @@ static inline int find_stem_from_spec(struct saved_data
>> *data, const char *buf)
>>  	if (!stem)
>>  		return -1;
>>
>> -	return store_stem(data, stem, stem_len);
>> +	return store_stem(data, stem, stem_len, false);
>>  }
>>
>>  /* This will always check for buffer over-runs and either read the next entry @@
>> -317,6 +316,22 @@ static inline int next_entry(void *buf, struct mmap_area *fp,
>> size_t bytes)
>>  	return 0;
>>  }
>>
>> +static inline int next_pstr(char **str, struct mmap_area *fp, size_t
>> +len) {
>> +	if (len > fp->next_len)
>> +		return -1;
>> +
>> +	char *tmp = (char *)fp->next_addr;
>> +	if (tmp[len-1] != '\0')
>> +		return -1;
>> +
>> +	*str = tmp;
>> +
>> +	fp->next_addr = (char *)fp->next_addr + len;
>> +	fp->next_len -= len;
>> +	return 0;
>> +}
>> +
>>  static inline int compile_regex(struct saved_data *data, struct spec *spec,
>>  					    const char **errbuf)
>>  {
>> @@ -375,13 +390,21 @@ static inline int process_line(struct selabel_handle *rec,
>>  			char *line_buf, unsigned lineno)
>>  {
>>  	int items, len, rc;
>> -	char *regex = NULL, *type = NULL, *context = NULL;
>> +	union {
>> +		struct {
>> +			char *regex;
>> +			char *type;
>> +			char *context;
>> +		};
>> +		char *array[3];
>> +	} found = { .array = { 0 } };
>> +
>>  	struct saved_data *data = (struct saved_data *)rec->data;
>>  	struct spec *spec_arr;
>>  	unsigned int nspec = data->nspec;
>>  	const char *errbuf = NULL;
>>
>> -	items = read_spec_entries(line_buf, &errbuf, 3, &regex, &type,
>> &context);
>> +	items = read_spec_entries(line_buf, &errbuf, ARRAY_SIZE(found.array),
>> +found.array);
>>  	if (items < 0) {
>>  		rc = errno;
>>  		selinux_log(SELINUX_ERROR,
>> @@ -398,22 +421,17 @@ static inline int process_line(struct selabel_handle *rec,
>>  		COMPAT_LOG(SELINUX_ERROR,
>>  			    "%s:  line %u is missing fields\n", path,
>>  			    lineno);
>> -		if (items == 1)
>> -			free(regex);
>>  		errno = EINVAL;
>>  		return -1;
>>  	} else if (items == 2) {
>>  		/* The type field is optional. */
>> -		context = type;
>> -		type = 0;
>> +		found.context = found.type;
>> +		found.type = NULL;
>>  	}
>>
>> -	len = get_stem_from_spec(regex);
>> -	if (len && prefix && strncmp(prefix, regex, len)) {
>> +	len = get_stem_from_spec(found.regex);
>> +	if (len && prefix && strncmp(prefix, found.regex, len)) {
>>  		/* Stem of regex does not match requested prefix, discard. */
>> -		free(regex);
>> -		free(type);
>> -		free(context);
>>  		return 0;
>>  	}
>>
>> @@ -424,13 +442,13 @@ static inline int process_line(struct selabel_handle *rec,
>>  	spec_arr = data->spec_arr;
>>
>>  	/* process and store the specification in spec. */
>> -	spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
>> -	spec_arr[nspec].regex_str = regex;
>> +	spec_arr[nspec].stem_id = find_stem_from_spec(data, found.regex);
>> +	spec_arr[nspec].regex_str = found.regex;
>>
>> -	spec_arr[nspec].type_str = type;
>> +	spec_arr[nspec].type_str = found.type;
>>  	spec_arr[nspec].mode = 0;
>>
>> -	spec_arr[nspec].lr.ctx_raw = context;
>> +	spec_arr[nspec].lr.ctx_raw = found.context;
>>
>>  	/*
>>  	 * bump data->nspecs to cause closef() to cover it in its free @@ -442,18
>> +460,18 @@ static inline int process_line(struct selabel_handle *rec,
>>  			&& compile_regex(data, &spec_arr[nspec], &errbuf)) {
>>  		COMPAT_LOG(SELINUX_ERROR,
>>  			   "%s:  line %u has invalid regex %s:  %s\n",
>> -			   path, lineno, regex, errbuf);
>> +			   path, lineno, found.regex, errbuf);
>>  		errno = EINVAL;
>>  		return -1;
>>  	}
>>
>> -	if (type) {
>> -		mode_t mode = string_to_mode(type);
>> +	if (found.type) {
>> +		mode_t mode = string_to_mode(found.type);
>>
>>  		if (mode == (mode_t)-1) {
>>  			COMPAT_LOG(SELINUX_ERROR,
>>  				   "%s:  line %u has invalid file type %s\n",
>> -				   path, lineno, type);
>> +				   path, lineno, found.type);
>>  			errno = EINVAL;
>>  			return -1;
>>  		}
>> @@ -464,7 +482,7 @@ static inline int process_line(struct selabel_handle *rec,
>>  	 * any meta characters in the RE */
>>  	spec_hasMetaChars(&spec_arr[nspec]);
>>
>> -	if (strcmp(context, "<<none>>") && rec->validating)
>> +	if (strcmp(found.context, "<<none>>") && rec->validating)
>>  		compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
>>
>>  	return 0;
>> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h index
>> aa48fff..e40d68b 100644
>> --- a/libselinux/src/label_internal.h
>> +++ b/libselinux/src/label_internal.h
>> @@ -136,10 +136,11 @@ compat_validate(struct selabel_handle *rec,
>>  		struct selabel_lookup_rec *contexts,
>>  		const char *path, unsigned lineno) hidden;
>>
>> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>>  /*
>>   * The read_spec_entries function may be used to
>>   * replace sscanf to read entries from spec files.
>>   */
>> -extern int read_spec_entries(char *line_buf, const char **errbuf, int num_args,
>> ...);
>> +extern int hidden read_spec_entries(char *line_buf, const char
>> +**errbuf, unsigned int num, char *found[]);
>>
>>  #endif				/* _SELABEL_INTERNAL_H_ */
>> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c index
>> 26f9ef1..3f5728d 100644
>> --- a/libselinux/src/label_support.c
>> +++ b/libselinux/src/label_support.c
>> @@ -17,39 +17,40 @@
>>   * Read an entry from a spec file (e.g. file_contexts)
>>   * entry - Buffer to allocate for the entry.
>>   * ptr - current location of the line to be processed.
>> - * returns  - 0 on success and *entry is set to be a null
>> - *            terminated value. On Error it returns -1 and
>> - *            errno will be set.
>> + * returns  - a pointer to the begining of the string.
>> + *            that is the
>>   *
>>   */
>> -static inline int read_spec_entry(char **entry, char **ptr, int *len, const char
>> **errbuf)
>> +static inline char *read_spec_entry(char **current, const char
>> +**errbuf)
>>  {
>> -	*entry = NULL;
>> -	char *tmp_buf = NULL;
>> -
>> -	while (isspace(**ptr) && **ptr != '\0')
>> -		(*ptr)++;
>> +	if(!**current) {
>> +		(*current)++;
>> +		return NULL;
>> +	}
>>
>> -	tmp_buf = *ptr;
>> -	*len = 0;
>> +	while (isspace(**current) && **current != '\0')
>> +		(*current)++;
>>
>> -	while (!isspace(**ptr) && **ptr != '\0') {
>> -		if (!isascii(**ptr)) {
>> +	char *start = *current;
>> +	while (!isspace(**current) && **current != '\0') {
>> +		if (!isascii(**current)) {
>>  			errno = EINVAL;
>>  			*errbuf = "Non-ASCII characters found";
>> -			return -1;
>> +			return NULL;
>>  		}
>> -		(*ptr)++;
>> -		(*len)++;
>> +		(*current)++;
>>  	}
>>
>> -	if (*len) {
>> -		*entry = strndup(tmp_buf, *len);
>> -		if (!*entry)
>> -			return -1;
>> -	}
>> +	char *end = *current;
>>
>> -	return 0;
>> +	if (start == end)
>> +		return NULL;
>> +
>> +	if (*end != '\0') {
>> +		*end = '\0';
>> +		(*current)++;
>> +	}
>> +	return start;
>>  }
>>
>>  /*
>> @@ -63,15 +64,13 @@ static inline int read_spec_entry(char **entry, char **ptr,
>> int *len, const char
>>   * This function calls read_spec_entry() to do the actual string processing.
>>   * As such, can return anything from that function as well.
>>   */
>> -int hidden read_spec_entries(char *line_buf, const char **errbuf, int num_args,
>> ...)
>> +int hidden read_spec_entries(char *line_buf, const char **errbuf,
>> +unsigned int num, char *found[])
>>  {
>> -	char **spec_entry, *buf_p;
>> -	int len, rc, items, entry_len = 0;
>> -	va_list ap;
>> -
>> +	char*buf_p;
>> +	unsigned int items = 0;
>>  	*errbuf = NULL;
>>
>> -	len = strlen(line_buf);
>> +	size_t len = strlen(line_buf);
>>  	if (line_buf[len - 1] == '\n')
>>  		line_buf[len - 1] = '\0';
>>  	else
>> @@ -89,26 +88,12 @@ int hidden read_spec_entries(char *line_buf, const char
>> **errbuf, int num_args,
>>  		return 0;
>>
>>  	/* Process the spec file entries */
>> -	va_start(ap, num_args);
>> -
>> -	items = 0;
>> -	while (items < num_args) {
>> -		spec_entry = va_arg(ap, char **);
>> -
>> -		if (len - 1 == buf_p - line_buf) {
>> -			va_end(ap);
>> -			return items;
>> -		}
>> -
>> -		rc = read_spec_entry(spec_entry, &buf_p, &entry_len, errbuf);
>> -		if (rc < 0) {
>> -			va_end(ap);
>> -			return rc;
>> -		}
>> -		if (entry_len)
>> -			items++;
>> +	while (items < num) {
>> +		found[items] = read_spec_entry(&buf_p, errbuf);
>> +		if (!found[items])
>> +			break;
>> +		items++;
>>  	}
>> -	va_end(ap);
>>  	return items;
>>  }
>>
>> --
>> 1.9.1
> 
> 
