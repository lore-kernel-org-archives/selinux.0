From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: RE: [PATCH 1/2] libselinux: generalize read_spec_entries for any
 delimiter
Date: Mon, 27 Jul 2015 19:37:26 +0000
Message-ID: <90C2B82E7E29DB4ABBA49A53BDC611C00174C99E@Exchange10.columbia.tresys.com>
References: <1438003263-65455-1-git-send-email-ykhodorkovskiy@tresys.com>
 <1438003263-65455-2-git-send-email-ykhodorkovskiy@tresys.com>
 <55B659EE.2070506@tycho.nsa.gov>
In-Reply-To: <55B659EE.2070506@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



>-----Original Message-----
>From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
>Sent: Monday, July 27, 2015 12:19 PM
>To: Yuli Khodorkovskiy; selinux@tycho.nsa.gov
>Subject: Re: [PATCH 1/2] libselinux: generalize read_spec_entries for any
>delimiter
>
>On 07/27/2015 09:21 AM, Yuli Khodorkovskiy wrote:
>> This patch allows the tokenizer previously introduced for libselinux
>> to use any delimiter for tokenization. Delimiters may be squashed by
>> setting the squash_delim flag to 1. When any whitespace delimiter is
>> used,
>> isspace() allows any whitespace character to be used as the delimiter.
>>
>> Previously, read_spec_entries() trimmed whitespace and ignored
>> comments and empty lines. This functionality has been removed as is
>> now the responsiblity of the caller to implement.
>
>Doesn't yield the same output from sefcontext_compile before and after
>this change if file_contexts has any lines trailing in whitespace (old:
>trailing whitespace ignored; new: trailing whitespace included in context
>field).

Okay, I'll look into this and send out a v2.

>
>>
>> Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
>> ---
>>  libselinux/src/label_android_property.c |  11 ++-
>>  libselinux/src/label_file.h             |  10 ++-
>>  libselinux/src/label_internal.h         |   7 +-
>>  libselinux/src/label_support.c          | 129 +++++++++++++++++++------------
>-
>>  4 files changed, 97 insertions(+), 60 deletions(-)
>>
>> diff --git a/libselinux/src/label_android_property.c
>> b/libselinux/src/label_android_property.c
>> index 4af9896..5c06ed3 100644
>> --- a/libselinux/src/label_android_property.c
>> +++ b/libselinux/src/label_android_property.c
>> @@ -90,9 +90,14 @@ static int process_line(struct selabel_handle *rec,
>>  	spec_t *spec_arr = data->spec_arr;
>>  	unsigned int nspec = data->nspec;
>>
>> -	items = read_spec_entries(line_buf, 2, &prop, &context);
>> -	if (items <= 0)
>> -		return items;
>> +	trim_buf(&line_buf);
>> +
>> +	/* Skip comment lines and empty lines. */
>> +	if (*line_buf == '#' || *line_buf == '\0') {
>> +		return 0;
>> +	}
>> +
>> +	items = tokenize(line_buf, 1, ' ', 2, &prop, &context);
>>  	if (items != 2) {
>>  		selinux_log(SELINUX_WARNING,
>>  			    "%s:  line %u is missing fields, skipping\n", path,
>diff --git
>> a/libselinux/src/label_file.h b/libselinux/src/label_file.h index
>> db961ba..3499da1 100644
>> --- a/libselinux/src/label_file.h
>> +++ b/libselinux/src/label_file.h
>> @@ -387,10 +387,14 @@ static inline int process_line(struct
>selabel_handle *rec,
>>  	unsigned int nspec = data->nspec;
>>  	const char *errbuf = NULL;
>>
>> -	items = read_spec_entries(line_buf, 3, &regex, &type, &context);
>> -	if (items <= 0)
>> -		return items;
>> +	trim_buf(&line_buf);
>>
>> +	/* Skip comment lines and empty lines. */
>> +	if (*line_buf == '#' || *line_buf == '\0') {
>> +		return 0;
>> +	}
>> +
>> +	items = tokenize(line_buf, 1, ' ', 3, &regex, &type, &context);
>>  	if (items < 2) {
>>  		COMPAT_LOG(SELINUX_WARNING,
>>  			    "%s:  line %u is missing fields, skipping\n", path,
>diff --git
>> a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
>> index 861eca1..81a4f37 100644
>> --- a/libselinux/src/label_internal.h
>> +++ b/libselinux/src/label_internal.h
>> @@ -108,9 +108,10 @@ compat_validate(struct selabel_handle *rec,
>>  		const char *path, unsigned lineno) hidden;
>>
>>  /*
>> - * The read_spec_entries function may be used to
>> - * replace sscanf to read entries from spec files.
>> + * The tokenize function may be used to
>> + * replace sscanf.
>>   */
>> -extern int read_spec_entries(char *line_buf, int num_args, ...);
>> +extern int tokenize(char *line_buf, int squash_delim, char delim, int
>> +num_args, ...); extern void trim_buf(char **buf);
>>
>>  #endif				/* _SELABEL_INTERNAL_H_ */
>> diff --git a/libselinux/src/label_support.c
>> b/libselinux/src/label_support.c index b3ab8ab..08ef303 100644
>> --- a/libselinux/src/label_support.c
>> +++ b/libselinux/src/label_support.c
>> @@ -11,88 +11,115 @@
>>  #include "label_internal.h"
>>
>>  /*
>> - * The read_spec_entries and read_spec_entry functions may be used to
>> - * replace sscanf to read entries from spec files. The file and
>> - * property services now use these.
>> + * The tokenize and tokenize_str functions may be used to
>> + * replace sscanf to read tokens from buffers.
>>   */
>>
>> -/* Read an entry from a spec file (e.g. file_contexts) */ -static
>> inline int read_spec_entry(char **entry, char **ptr, int *len)
>> +/* Read a token from a buffer */
>> +static inline int tokenize_str(int squash_delim, char delim, char
>> +**str, char **ptr, int *len)
>
>Not introduced by this change, but should likely use size_t *len here.
>
>>  {
>> -	*entry = NULL;
>> -	char *tmp_buf = NULL;
>> +	char *tmp_buf = *ptr;
>> +	*str = NULL;
>> +
>> +	while (**ptr != '\0') {
>> +		if (isspace(delim) && isspace(**ptr)) {
>> +			(*ptr)++;
>> +			break;
>> +		} else if (!isspace(delim) && **ptr == delim) {
>> +			(*ptr)++;
>> +			break;
>> +		}
>
>This seems unnecessarily complicated.  First, all users within libselinux
>want squash_delim=1, delim=' ', so we might as well just make that the
>only supported case in libselinux until such a time as we have a need for
>another.  Also, can't quite see why squash_delim=1,delim=<non-space>
>would ever be desired, or squash_delim=0,delim=<space>, so it seems like
>we would simplify the interface even when supporting both cases.

The reason this was implemented to support both cases was to have consistency with the implementation in libsepol. If you think it would be easier, I can drop the patch from libselinux altogether and only support squash_delim=1,delim=<space> and squash_delim=0,delim=<non-space> in libsepol.

>
>>
>> -	while (isspace(**ptr) && **ptr != '\0')
>>  		(*ptr)++;
>> +	}
>>
>> -	tmp_buf = *ptr;
>> -	*len = 0;
>> +	*len = *ptr - tmp_buf;
>> +	/* If the end of the string has not been reached, this will ensure
>the
>> +	 * delimiter is not included when returning the token.
>> +	 */
>> +	if (**ptr != '\0') {
>> +		(*len)--;
>
>Can *len underflow here?

*ptr had to have moved by at least one character at this point, therefore len must be greater than 0.

>
>> +	}
>>
>> -	while (!isspace(**ptr) && **ptr != '\0') {
>> -		(*ptr)++;
>> -		(*len)++;
>> +	*str = strndup(tmp_buf, *len);
>
>Can *len be 0 here?

Yes len can be 0 here. If for example, "foo::bar" is provided and squash_delim is set to 0, the string would tokenize into foo, a 0 length NUL terminated string, and bar.

>
>> +	if (!*str) {
>> +		return -1;
>>  	}
>>
>> -	if (*len) {
>> -		*entry = strndup(tmp_buf, *len);
>> -		if (!*entry)
>> -			return -1;
>> +	while (**ptr != '\0' && squash_delim == 1) {
>> +		if (isspace(delim) && isspace(**ptr)) {
>> +			(*ptr)++;
>> +		} else if (!isspace(delim) && **ptr == delim) {
>> +			(*ptr)++;
>> +		} else {
>> +			break;
>> +		}
>>  	}
>>
>>  	return 0;
>>  }
>>
>>  /*
>> - * line_buf - Buffer containing the spec entries .
>> - * num_args - The number of spec parameter entries to process.
>> - * ...      - A 'char **spec_entry' for each parameter.
>> + * line_buf - Buffer containing string to tokenize.
>> + * squash_delim - Whether or not to squash repeating delimiters in
>input data.
>> + *		   Set to 1 to squash_delimiter or 0 to disable squashing
>delimiter.
>> + * delim - The delimiter used to tokenize line_buf. A whitespace
>delimiter will
>> + *	    be tokenized using isspace().
>> + * num_args - The number of parameter entries to process.
>> + * ...      - A 'char **' for each parameter.
>>   * returns  - The number of items processed.
>>   *
>> - * This function calls read_spec_entry() to do the actual string
>processing.
>> + * This function calls tokenize_str() to do the actual string
>> + processing. The
>> + * caller is responsible for calling free() on each additional
>> + argument. The
>> + * function will not tokenize more than num_args and the last
>> + argument will
>> + * contain the remaining content of line_buf.
>>   */
>> -int hidden read_spec_entries(char *line_buf, int num_args, ...)
>> +int tokenize(char *line_buf, int squash_delim, char delim, int
>> +num_args, ...)
>
>Must be hidden or it becomes part of the libselinux.so ABI.
>
>>  {
>> -	char **spec_entry, *buf_p;
>> -	int len, rc, items, entry_len = 0;
>> +	char **arg, *buf_p;
>> +	int rc, items, arg_len = 0;
>>  	va_list ap;
>>
>> -	len = strlen(line_buf);
>> -	if (line_buf[len - 1] == '\n')
>> -		line_buf[len - 1] = '\0';
>> -	else
>> -		/* Handle case if line not \n terminated by bumping
>> -		 * the len for the check below (as the line is NUL
>> -		 * terminated by getline(3)) */
>> -		len++;
>> -
>>  	buf_p = line_buf;
>> -	while (isspace(*buf_p))
>> -		buf_p++;
>>
>> -	/* Skip comment lines and empty lines. */
>> -	if (*buf_p == '#' || *buf_p == '\0')
>> -		return 0;
>> -
>> -	/* Process the spec file entries */
>> +	/* Process the arguments */
>>  	va_start(ap, num_args);
>>
>> -	items = 0;
>> -	while (items < num_args) {
>> -		spec_entry = va_arg(ap, char **);
>> +	for (items = 0; items < num_args && *buf_p != '\0'; items++) {
>> +		arg = va_arg(ap, char **);
>> +
>> +		/* Save the remainder of the string in arg */
>> +		if (items == num_args - 1) {
>> +			*arg = strdup(buf_p);
>> +			if (*arg == NULL) {
>> +				goto exit;
>> +			}
>
>Needs to prune last argument at delimiter.

I'll add this functionality to the trim_buf() function. 

>
>>
>> -		if (len - 1 == buf_p - line_buf) {
>> -			va_end(ap);
>> -			return items;
>> +			continue;
>>  		}
>>
>> -		rc = read_spec_entry(spec_entry, &buf_p, &entry_len);
>> +		rc = tokenize_str(squash_delim, delim, arg, &buf_p,
>&arg_len);
>>  		if (rc < 0) {
>> -			va_end(ap);
>> -			return rc;
>> +			goto exit;
>>  		}
>> -		if (entry_len)
>> -			items++;
>>  	}
>> +
>> +exit:
>>  	va_end(ap);
>>  	return items;
>>  }
>> +
>> +/* This function removes leading whitespace. If the buffer ends in a
>> +newline,
>> + * the newline is removed.
>> + */
>> +void trim_buf(char **buf)
>
>Must be hidden or it becomes part of the libselinux.so ABI.
>
>> +{
>> +	int len = strlen(*buf);
>
>size_t len
>
>> +	if ((*buf)[len - 1] == '\n') {
>
>Can len == 0 here?

Good catch. I'll add an error check here.

>
>> +		(*buf)[len - 1] = '\0';
>> +	}
>> +
>> +	while (isspace(**buf)) {
>> +		(*buf)++;
>> +	}
>> +}
>>
