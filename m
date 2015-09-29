Subject: Re: [RFC PATCH V2] libselinux: Add selabel_digest function
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1442743518-4450-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560ADA4B.5040705@tycho.nsa.gov>
Date: Tue, 29 Sep 2015 14:36:59 -0400
MIME-Version: 1.0
In-Reply-To: <1442743518-4450-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/20/2015 06:05 AM, Richard Haines wrote:
> selabel_digest(3) if enabled by the SELABEL_OPT_DIGEST option during
> selabel_open(3) will return an SHA1 digest of the spec files, plus
> a list of the specfiles used to calculate the digest. There is a
> test utility supplied that will demonstrate the functionality.
>
> The use case for selabel_digest(3) is to implement an selinux_restorecon
> function based on the Android version that writes a hash of the
> file_contexts files to an extended attribute to enhance performance
> (see external/libselinux/src/android.c selinux_android_restorecon()).
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes:
> Minor general cleanups and updated as per comments from:
> http://marc.info/?l=selinux&m=144233357510422&w=2
>
>   libselinux/include/selinux/label.h      |  22 +++-
>   libselinux/man/man3/selabel_digest.3    |  61 +++++++++++
>   libselinux/man/man3/selabel_open.3      |   5 +
>   libselinux/src/Makefile                 |   2 +-
>   libselinux/src/label.c                  |  92 +++++++++++++++-
>   libselinux/src/label_android_property.c |   8 +-
>   libselinux/src/label_db.c               |  13 +++
>   libselinux/src/label_file.c             |  43 +++++---
>   libselinux/src/label_internal.h         |  29 ++++-
>   libselinux/src/label_media.c            |   7 +-
>   libselinux/src/label_support.c          |  81 +++++++++++++-
>   libselinux/src/label_x.c                |   7 +-
>   libselinux/utils/Makefile               |   2 +-
>   libselinux/utils/selabel_digest.c       | 183 ++++++++++++++++++++++++++++++++
>   14 files changed, 531 insertions(+), 24 deletions(-)
>   create mode 100644 libselinux/man/man3/selabel_digest.3
>   create mode 100644 libselinux/utils/selabel_digest.c
>
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
> index 14793a1..02fa05b 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -49,8 +49,10 @@ struct selabel_handle;
>   #define SELABEL_OPT_PATH	3
>   /* select a subset of the search space as an optimization (file backend) */
>   #define SELABEL_OPT_SUBSET	4
> +/* require a hash calculation on spec files */
> +#define SELABEL_OPT_DIGEST	5
>   /* total number of options */
> -#define SELABEL_NOPT		5
> +#define SELABEL_NOPT		6
>
>   /*
>    * Label operations
> @@ -106,6 +108,24 @@ int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
>   int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
>   			      const char *key, const char **aliases, int type);
>
> +/**
> + * selabel_digest - Retrieve the SHA1 digest and the list of specfiles used to
> + *		    generate the digest. The SELABEL_OPT_DIGEST option must
> + *		    be set in selabel_open() to initiate the digest generation.
> + * @handle: specifies backend instance to query
> + * @digest: returns a pointer to the SHA1 digest.
> + * @digest_len: returns DIGEST_SPECFILE_SIZE length.

Just: returns length of digest in bytes

> + * @specfiles: a list of specfiles used in the SHA1 digest generation.
> + *	       The list is NULL terminated and will hold a maximum of
> + *	       DIGEST_FILES_MAX entries.

Just: The list is NULL terminated and and will hold @num_specfiles entries.

> + * @num_specfiles: number of specfiles in the list.
> + *
> + * Return %0 on success, -%1 with @errno set on failure.
> + */
> +int selabel_digest(struct selabel_handle *rec,
> +			    unsigned char **digest, int *digest_len,
> +			    char ***specfiles, int *num_specfiles);

Should the len/num arguments be size_t or otherwise unsigned?

> +
>   enum selabel_cmp_result {
>   	SELABEL_SUBSET,
>   	SELABEL_EQUAL,

> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 222b6b3..f7c87d1 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -10,6 +10,7 @@
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <string.h>
> +#include <sys/stat.h>
>   #include <selinux/selinux.h>
>   #include "callbacks.h"
>   #include "label_internal.h"
> @@ -65,15 +66,21 @@ static char *selabel_sub(struct selabel_sub *ptr, const char *src)
>   	return NULL;
>   }
>
> -struct selabel_sub *selabel_subs_init(const char *path, struct selabel_sub *list)
> +struct selabel_sub *selabel_subs_init(const char *path,
> +					    struct selabel_sub *list,
> +					    struct selabel_digest *digest)
>   {
>   	char buf[1024];
>   	FILE *cfg = fopen(path, "r");
> -	struct selabel_sub *sub;
> +	struct selabel_sub *sub = NULL;
> +	struct stat sb;
>
>   	if (!cfg)
>   		return list;
>
> +	if (fstat(fileno(cfg), &sb) < 0)
> +		return list;
> +
>   	while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
>   		char *ptr = NULL;
>   		char *src = buf;
> @@ -115,6 +122,10 @@ struct selabel_sub *selabel_subs_init(const char *path, struct selabel_sub *list
>   		sub->next = list;
>   		list = sub;
>   	}
> +
> +	if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
> +		goto err;
> +
>   out:
>   	fclose(cfg);
>   	return list;
> @@ -125,6 +136,64 @@ err:
>   	goto out;
>   }
>
> +static inline struct selabel_digest *selabel_is_digest_set
> +				    (const struct selinux_opt *opts,
> +				    unsigned n,
> +				    struct selabel_digest *entry)
> +{
> +	struct selabel_digest *digest = NULL;
> +
> +	while (n--) {
> +		if (opts[n].type == SELABEL_OPT_DIGEST &&
> +					    opts[n].value == (char *)1) {
> +			digest = malloc(sizeof(*digest));
> +			if (!digest)
> +				goto err;
> +
> +			memset(digest, 0, sizeof(*digest));

Just use calloc().

> +
> +			digest->digest = malloc(DIGEST_SPECFILE_SIZE + 1);
> +			if (!digest->digest)
> +				goto err;

Ditto.

> +
> +			digest->specfile_list = calloc(DIGEST_FILES_MAX,
> +							    sizeof(char *));
> +			if (!digest->specfile_list)
> +				goto err;
> +
> +			entry = digest;
> +			return entry;
> +		}
> +	}
> +	return NULL;
> +
> +err:
> +	if (digest)
> +		free(digest->digest);
> +	if (digest->specfile_list)
> +		free(digest->specfile_list);

if statements unnecessary; free(NULL) is valid and a no-op.

> +	free(digest);
> +	return NULL;
> +}
> +
> +static void selabel_digest_fini(struct selabel_digest *ptr)
> +{
> +	int i;
> +
> +	if (ptr->digest)
> +		free(ptr->digest);
> +
> +	if (ptr->hashbuf)
> +		free(ptr->hashbuf);

Ditto.

> +
> +	if (ptr->specfile_list) {
> +		for (i = 0; ptr->specfile_list[i]; i++)
> +			free(ptr->specfile_list[i]);
> +		free(ptr->specfile_list);
> +	}
> +	free(ptr);
> +}
> +
>   /*
>    * Validation functions
>    */
> @@ -273,6 +342,7 @@ struct selabel_handle *selabel_open(unsigned int backend,
>
>   	rec->subs = NULL;
>   	rec->dist_subs = NULL;
> +	rec->digest = selabel_is_digest_set(opts, nopts, rec->digest);
>
>   	if ((*initfuncs[backend])(rec, opts, nopts)) {
>   		free(rec);
> @@ -378,10 +448,28 @@ enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
>   	return h1->func_cmp(h1, h2);
>   }
>
> +int selabel_digest(struct selabel_handle *rec,
> +				    unsigned char **digest, int *digest_len,
> +				    char ***specfiles, int *num_specfiles)
> +{
> +	if (!rec->digest) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +
> +	*digest = rec->digest->digest;
> +	*digest_len = DIGEST_SPECFILE_SIZE;
> +	*specfiles = rec->digest->specfile_list;
> +	*num_specfiles = rec->digest->specfile_cnt;
> +	return 0;
> +}
> +
>   void selabel_close(struct selabel_handle *rec)
>   {
>   	selabel_subs_fini(rec->subs);
>   	selabel_subs_fini(rec->dist_subs);
> +	if (rec->digest)
> +		selabel_digest_fini(rec->digest);
>   	rec->func_close(rec);
>   	free(rec->spec_file);
>   	free(rec);
> diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
> index af06c4a..1bee641 100644
> --- a/libselinux/src/label_android_property.c
> +++ b/libselinux/src/label_android_property.c
> @@ -150,7 +150,6 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>   	/* Open the specification file. */
>   	if ((fp = fopen(path, "r")) == NULL)
>   		return -1;
> -

Extraneous whitespace change.

>   	if (fstat(fileno(fp), &sb) < 0)
>   		goto finish;
>   	errno = EINVAL;
> @@ -199,7 +198,12 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>
>   	qsort(data->spec_arr, data->nspec, sizeof(struct spec), cmp);
>
> -	status = 0;
> +	status = digest_add_specfile(rec->digest, fp, NULL, sb.st_size, path);
> +	if (status)
> +		goto finish;
> +
> +	status = digest_gen_hash(rec->digest);
> +
>   finish:
>   	fclose(fp);
>   	return status;

> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
> index b3ab8ab..42b4772 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -8,6 +8,8 @@
>   #include <stdarg.h>
>   #include <ctype.h>
>   #include <string.h>
> +#include <stdio.h>
> +#include <errno.h>
>   #include "label_internal.h"
>
>   /*
> @@ -15,8 +17,6 @@
>    * replace sscanf to read entries from spec files. The file and
>    * property services now use these.
>    */
> -
> -/* Read an entry from a spec file (e.g. file_contexts) */
>   static inline int read_spec_entry(char **entry, char **ptr, int *len)
>   {
>   	*entry = NULL;
> @@ -96,3 +96,80 @@ int hidden read_spec_entries(char *line_buf, int num_args, ...)
>   	va_end(ap);
>   	return items;
>   }
> +
> +/* Once all the specfiles are in the hash_buf, generate the hash. */
> +int hidden digest_gen_hash(struct selabel_digest *digest)
> +{
> +	if (digest) {

Nicer to read as:
	if (!digest)
		return -1;

	<rest of body, with less indentation>

> +		SHA1(digest->hashbuf, digest->hashbuf_size, digest->digest);
> +		free(digest->hashbuf);
> +		digest->hashbuf = NULL;
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
> +/**
> + * digest_add_specfile - Add a specfile to the hashbuf and if gen_hash true
> + *			 then generate the hash.
> + * @digest: pointer to the selabel_digest struct
> + * @fp: file pointer for fread(3) or NULL if not.
> + * @from_addr: pointer at start of buffer for memcpy or NULL if not (used for
> + *	       mmap(3) files).
> + * @buf_len: length of buffer to copy.
> + * @path: pointer to the specfile.
> + *
> + * Return %0 on success, -%1 with @errno set on failure.
> + */
> +int hidden digest_add_specfile(struct selabel_digest *digest, FILE *fp,
> +				    char *from_addr, size_t buf_len,
> +				    const char *path)
> +{
> +	unsigned char *tmp_buf;
> +
> +	if (digest) {

Ditto.

> +		if (digest->hashbuf_size + buf_len < digest->hashbuf_size) {
> +			errno = EOVERFLOW;
> +			return -1;
> +		}
> +		digest->hashbuf_size += buf_len;
> +
> +		tmp_buf = realloc(digest->hashbuf, digest->hashbuf_size);
> +		if (!tmp_buf)
> +			return -1;
> +
> +		digest->hashbuf = tmp_buf;
> +
> +		if (fp) {
> +			rewind(fp);
> +			if (fread(digest->hashbuf +
> +					    (digest->hashbuf_size - buf_len),
> +					    1, buf_len, fp) != buf_len)
> +				return -1;
> +
> +			rewind(fp);
> +		} else if (from_addr) {
> +			tmp_buf = memcpy(digest->hashbuf +
> +					    (digest->hashbuf_size - buf_len),
> +					    from_addr, buf_len);
> +			if (!tmp_buf)
> +				return -1;
> +		} else {
> +			return -1;
> +		}
> +
> +		/* Now add path to list */
> +		digest->specfile_list[digest->specfile_cnt] = strdup(path);
> +		if (!digest->specfile_list[digest->specfile_cnt])
> +			return -1;
> +
> +		digest->specfile_cnt++;
> +		if (digest->specfile_cnt > DIGEST_FILES_MAX) {
> +			errno = EOVERFLOW;
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
