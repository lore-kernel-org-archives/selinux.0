Subject: Re: [PATCH] read_spec_entry: fail on non-ascii
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov
References: <1455055186-14474-1-git-send-email-william.c.roberts@intel.com>
 <1455055186-14474-2-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56C38D58.9050701@tycho.nsa.gov>
Date: Tue, 16 Feb 2016 15:58:00 -0500
MIME-Version: 1.0
In-Reply-To: <1455055186-14474-2-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/09/2016 04:59 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> Inserting non-ascii characters into the following files:
>   * file_contexts
>   * property_contexts
>   * service_contexts
> can cause a failure on labeling but still result in a successful
> build.
>
> Hard error on non-ascii characters with:
> <path>:  line 229 error due to: Non-ASCII characters found
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libselinux/src/label_android_property.c | 15 +++++++++++++--
>   libselinux/src/label_file.h             | 16 ++++++++++++++--
>   libselinux/src/label_internal.h         |  2 +-
>   libselinux/src/label_support.c          | 29 ++++++++++++++++++++++-------
>   4 files changed, 50 insertions(+), 12 deletions(-)
>
> diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
> index fea1f8f..290b438 100644
> --- a/libselinux/src/label_android_property.c
> +++ b/libselinux/src/label_android_property.c
> @@ -89,10 +89,21 @@ static int process_line(struct selabel_handle *rec,
>   	struct saved_data *data = (struct saved_data *)rec->data;
>   	spec_t *spec_arr = data->spec_arr;
>   	unsigned int nspec = data->nspec;
> +	const char *errbuf = NULL;
>
> -	items = read_spec_entries(line_buf, 2, &prop, &context);
> -	if (items <= 0)
> +	items = read_spec_entries(line_buf, &errbuf, 2, &prop, &context);
> +	if (items < 0) {
> +		items = errno;
> +		selinux_log(SELINUX_ERROR,
> +			"%s:  line %u error due to: %s\n", path,
> +			lineno, errbuf ?: strerror(errno));
> +		errno = items;
> +		return -1;
> +	}
> +
> +	if (items == 0)
>   		return items;
> +
>   	if (items != 2) {
>   		selinux_log(SELINUX_ERROR,
>   			    "%s:  line %u is missing fields\n", path,
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index beb1fc2..72fed1f 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -1,6 +1,9 @@
>   #ifndef _SELABEL_FILE_H_
>   #define _SELABEL_FILE_H_
>
> +#include <errno.h>
> +#include <string.h>
> +
>   #include <sys/stat.h>
>
>   #include "callbacks.h"
> @@ -390,8 +393,17 @@ static inline int process_line(struct selabel_handle *rec,
>   	unsigned int nspec = data->nspec;
>   	const char *errbuf = NULL;
>
> -	items = read_spec_entries(line_buf, 3, &regex, &type, &context);
> -	if (items <= 0)
> +	items = read_spec_entries(line_buf, &errbuf, 3, &regex, &type, &context);
> +	if (items < 0) {
> +		rc = errno;
> +		selinux_log(SELINUX_ERROR,
> +			"%s:  line %u error due to: %s\n", path,
> +			lineno, errbuf ?: strerror(errno));
> +		errno = rc;
> +		return -1;
> +	}
> +
> +	if (items == 0)
>   		return items;
>
>   	if (items < 2) {
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
> index cefa80b..aa48fff 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -140,6 +140,6 @@ compat_validate(struct selabel_handle *rec,
>    * The read_spec_entries function may be used to
>    * replace sscanf to read entries from spec files.
>    */
> -extern int read_spec_entries(char *line_buf, int num_args, ...);
> +extern int read_spec_entries(char *line_buf, const char **errbuf, int num_args, ...);
>
>   #endif				/* _SELABEL_INTERNAL_H_ */
> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
> index 324dc51..26f9ef1 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -10,14 +10,19 @@
>   #include <string.h>
>   #include <stdio.h>
>   #include <errno.h>
> +#include <errno.h>
>   #include "label_internal.h"
>
>   /*
> - * The read_spec_entries and read_spec_entry functions may be used to
> - * replace sscanf to read entries from spec files. The file and
> - * property services now use these.
> + * Read an entry from a spec file (e.g. file_contexts)
> + * entry - Buffer to allocate for the entry.
> + * ptr - current location of the line to be processed.
> + * returns  - 0 on success and *entry is set to be a null
> + *            terminated value. On Error it returns -1 and
> + *            errno will be set.
> + *
>    */
> -static inline int read_spec_entry(char **entry, char **ptr, int *len)
> +static inline int read_spec_entry(char **entry, char **ptr, int *len, const char **errbuf)
>   {
>   	*entry = NULL;
>   	char *tmp_buf = NULL;
> @@ -29,6 +34,11 @@ static inline int read_spec_entry(char **entry, char **ptr, int *len)
>   	*len = 0;
>
>   	while (!isspace(**ptr) && **ptr != '\0') {
> +		if (!isascii(**ptr)) {
> +			errno = EINVAL;
> +			*errbuf = "Non-ASCII characters found";
> +			return -1;
> +		}
>   		(*ptr)++;
>   		(*len)++;
>   	}
> @@ -44,18 +54,23 @@ static inline int read_spec_entry(char **entry, char **ptr, int *len)
>
>   /*
>    * line_buf - Buffer containing the spec entries .
> + * errbuf   - Double pointer used for passing back specific error messages.
>    * num_args - The number of spec parameter entries to process.
>    * ...      - A 'char **spec_entry' for each parameter.
> - * returns  - The number of items processed.
> + * returns  - The number of items processed. On error, it returns -1 with errno
> + *            set and may set errbuf to a specific error message.
>    *
>    * This function calls read_spec_entry() to do the actual string processing.
> + * As such, can return anything from that function as well.
>    */
> -int hidden read_spec_entries(char *line_buf, int num_args, ...)
> +int hidden read_spec_entries(char *line_buf, const char **errbuf, int num_args, ...)
>   {
>   	char **spec_entry, *buf_p;
>   	int len, rc, items, entry_len = 0;
>   	va_list ap;
>
> +	*errbuf = NULL;
> +
>   	len = strlen(line_buf);
>   	if (line_buf[len - 1] == '\n')
>   		line_buf[len - 1] = '\0';
> @@ -85,7 +100,7 @@ int hidden read_spec_entries(char *line_buf, int num_args, ...)
>   			return items;
>   		}
>
> -		rc = read_spec_entry(spec_entry, &buf_p, &entry_len);
> +		rc = read_spec_entry(spec_entry, &buf_p, &entry_len, errbuf);
>   		if (rc < 0) {
>   			va_end(ap);
>   			return rc;
>
