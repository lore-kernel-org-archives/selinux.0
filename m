Subject: Re: [RFC PATCH] libselinux: Add selabel_digest function
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1441720255-5389-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55F84245.40702@tycho.nsa.gov>
Date: Tue, 15 Sep 2015 12:07:33 -0400
MIME-Version: 1.0
In-Reply-To: <1441720255-5389-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/08/2015 09:50 AM, Richard Haines wrote:
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
>  libselinux/include/selinux/label.h      |  24 ++++-
>  libselinux/man/man3/selabel_digest.3    |  57 ++++++++++
>  libselinux/man/man3/selabel_open.3      |   5 +
>  libselinux/src/Makefile                 |   2 +-
>  libselinux/src/label.c                  |  90 +++++++++++++++-
>  libselinux/src/label_android_property.c |   6 +-
>  libselinux/src/label_db.c               |  11 ++
>  libselinux/src/label_file.c             |  43 +++++---
>  libselinux/src/label_internal.h         |  25 ++++-
>  libselinux/src/label_media.c            |   5 +
>  libselinux/src/label_support.c          |  92 +++++++++++++++-
>  libselinux/src/label_x.c                |   5 +
>  libselinux/utils/Makefile               |   2 +-
>  libselinux/utils/selabel_digest.c       | 182 ++++++++++++++++++++++++++++++++
>  14 files changed, 528 insertions(+), 21 deletions(-)
>  create mode 100644 libselinux/man/man3/selabel_digest.3
>  create mode 100644 libselinux/utils/selabel_digest.c
> 
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
> index 14793a1..8424f31 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -8,6 +8,7 @@
>  
>  #include <stdbool.h>
>  #include <sys/types.h>
> +#include <openssl/sha.h>

Shouldn't really expose this; it is an implementation detail.  See below.

>  #include <selinux/selinux.h>
>  
>  #ifdef __cplusplus
> @@ -49,8 +50,10 @@ struct selabel_handle;
>  #define SELABEL_OPT_PATH	3
>  /* select a subset of the search space as an optimization (file backend) */
>  #define SELABEL_OPT_SUBSET	4
> +/* require a hash calculation on spec files */
> +#define SELABEL_OPT_DIGEST	5
>  /* total number of options */
> -#define SELABEL_NOPT		5
> +#define SELABEL_NOPT		6
>  
>  /*
>   * Label operations
> @@ -106,6 +109,25 @@ int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
>  int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
>  			      const char *key, const char **aliases, int type);
>  
> +/**
> + * selabel_digest - Retrieve the SH1 digest and the list of spcfiles used to

Lost a couple of characters above.

> + *		    generate the digest. The SELABEL_OPT_DIGEST option must
> + *		    be set in selabel_open() to initiate the digest generation.
> + * @handle: specifies backend instance to query
> + * @digest: returns a pointer to the SHA1 digest that will be
> + *	    DIGEST_SPECFILE_SIZE length.
> + * @path_list: a list of specfiles used in the SHA1 digest generation.
> + *	       The list is NULL terminated and will hold a maximum of
> + *	       DIGEST_FILES_MAX entries.
> + * @type: numeric input to the lookup operation
> + *
> + * Return %0 on success, -%1 with @errno set on failure.
> + */
> +#define DIGEST_SPECFILE_SIZE SHA_DIGEST_LENGTH
> +#define DIGEST_FILES_MAX 8

It would be better to return the digest size and number of files rather
than hardcoding them in the library API/ABI.  In the Android case, we
don't expose the digest size/algorithm outside of libselinux except for
the fact that it is stored in the xattr (but nothing else uses that).

> +int selabel_digest(struct selabel_handle *rec, unsigned char **digest,
> +			      char ***path_list);
> +
>  enum selabel_cmp_result {
>  	SELABEL_SUBSET,
>  	SELABEL_EQUAL,

> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 222b6b3..c36e3e3 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -378,10 +449,25 @@ enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
>  	return h1->func_cmp(h1, h2);
>  }
>  
> +int selabel_digest(struct selabel_handle *rec, unsigned char **digest,
> +						    char ***path_list)
> +{
> +	if (!rec->digest) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +
> +	*digest = rec->digest->digest;
> +	*path_list = rec->digest->specfile_list;
> +	return 0;
> +}

So the result of selabel_digest() must not be used after
selabel_close(); probably needs to be noted in man page.

> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
> index b3ab8ab..cf0b421 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -96,3 +96,91 @@ int hidden read_spec_entries(char *line_buf, int num_args, ...)
>  	va_end(ap);
>  	return items;
>  }
> +
> +/* Once all the specfiles are in the hash_buf, generate the hash. */
> +int digest_gen_hash(struct selabel_digest *digest)

hidden

> +{
> +	unsigned char *sha1_digest;
> +	int rc = 0;
> +
> +	if (digest) {
> +		sha1_digest = SHA1(digest->hashbuf, digest->hashbuf_size,
> +							    digest->digest);
> +		if (!sha1_digest) {

Is this possible?

> +			errno = ENODATA;
> +			rc = -1;
> +		}
> +
> +		free(digest->hashbuf);
> +		digest->hashbuf = NULL;
> +		return rc;
> +	}
> +
> +	return rc;
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
> + * @gen_hash: if true generate the hash. This should only be used if there is
> + *	      only one specfile involved.

Should we just omit this argument (i.e. always false), and just require
all callers to separately call digest_gen_hash()?  Simplifies the interface.

> + *
> + * Return %0 on success, -%1 with @errno set on failure.
> + */
> +int digest_add_specfile(struct selabel_digest *digest, FILE *fp,
> +				    char *from_addr, size_t buf_len,
> +				    const char *path, bool gen_hash)

hidden

> +{
> +	unsigned char *tmp_buf;
> +
> +	if (digest) {
> +		digest->hashbuf_size += buf_len;

overflow possible?

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

Assumes that fp won't be read by the caller after calling this function.
 True of all current callers but might be fragile.  Maybe rewind(fp);
here too?

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
> +
> +		/* Check if required to generate the hash */
> +		if (gen_hash) {
> +			if (digest_gen_hash(digest) < 0)
> +				return -1;
> +		}
> +	}
> +
> +	return 0;
> +}


> diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
> new file mode 100644
> index 0000000..bbbeb72
> --- /dev/null
> +++ b/libselinux/utils/selabel_digest.c
> @@ -0,0 +1,182 @@
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
> +		"usage: %s -b backend [-d] [-v] [-B] [-f file]\n\n"
> +		"Where:\n\t"
> +		"-b  The backend - \"file\", \"media\", \"x\", \"db\" or "
> +			"\"prop\"\n\t"
> +		"-d  Generate specfile digest then display the SHA1 digest\n\t"
> +		"    plus list of specfiles used in the calculation.\n\t"

Should this one be implicit (always enabled) for this program?

> +		"-v  Run \"cat <specfile_list> | openssl dgst -sha1 -hex\"\n\t"
> +		"    on the list of specfiles to compare the SHA1 digests.\n\t"
> +		"-B  Use base specfiles only (valid for \"-b file\" only).\n\t"
> +		"-f  Optional file containing the specs (defaults to\n\t"
> +		"    those used by loaded policy).\n\n",
> +		progname);
> +	exit(1);
> +}
> +
> +static int run_check_digest(char *cmd, char *selabel_digest)
> +{
> +	FILE *fp;
> +	char files_digest[128];
> +	char *files_p;
> +
> +	fp = popen(cmd, "r");
> +	if (fp == NULL)
> +		return -1;
> +
> +	/* Only expect one line "(stdin)= x.." so read and find first space */
> +	while (fgets(files_digest, sizeof(files_digest) - 1, fp) != NULL)
> +		;
> +
> +	files_p = strstr(files_digest, " ");
> +
> +	if (strncmp(selabel_digest, files_p + 1,
> +				    DIGEST_SPECFILE_SIZE * 2) != 0)
> +		printf("Failed validation:\n\tselabel_digest: %s\n\t"
> +				    "files_digest:   %s\n",
> +				    selabel_digest, files_p + 1);
> +	else
> +		printf("Passed validation - digest: %s\n", selabel_digest);
> +
> +	pclose(fp);
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int backend = 0, rc, opt, i, validate = 0;
> +	char *baseonly = NULL, *digest = NULL, *file = NULL;
> +	char **path_list = NULL;
> +	unsigned char *sha1_digest = NULL;
> +
> +	char val_buf[4096];
> +	char *ptr;
> +	char sha1_buf[DIGEST_SPECFILE_SIZE * 2 + 1];
> +
> +	struct selabel_handle *hnd;
> +	struct selinux_opt selabel_option[] = {
> +		{ SELABEL_OPT_PATH, file },
> +		{ SELABEL_OPT_BASEONLY, baseonly },
> +		{ SELABEL_OPT_DIGEST, digest }
> +	};
> +
> +	if (argc < 3)
> +		usage(argv[0]);
> +
> +	while ((opt = getopt(argc, argv, "b:Bdvf:")) > 0) {
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
> +		case 'B':
> +			baseonly = (char *)1;
> +			break;
> +		case 'd':
> +			digest = (char *)1;
> +			break;
> +		case 'v':
> +			validate = 1;
> +			break;
> +		case 'f':
> +			file = optarg;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	memset(val_buf, 0, sizeof(val_buf));
> +
> +	selabel_option[0].value = file;
> +	selabel_option[1].value = baseonly;
> +	selabel_option[2].value = digest;
> +
> +	hnd = selabel_open(backend, selabel_option, 3);
> +	if (!hnd) {
> +		switch (errno) {
> +		case ENODATA:
> +			fprintf(stderr, "ERROR computing specfiles digest.\n");
> +			break;
> +		case EOVERFLOW:
> +			fprintf(stderr, "ERROR Max number of specfiles. "
> +				  "Currently set to %d.\n", DIGEST_FILES_MAX);
> +			break;
> +		default:
> +			fprintf(stderr, "ERROR: selabel_open: %s\n",
> +						    strerror(errno));
> +		}
> +		return -1;
> +	}
> +
> +	rc = selabel_digest(hnd, &sha1_digest, &path_list);
> +
> +	if (rc) {
> +		switch (errno) {
> +		case EINVAL:
> +			fprintf(stderr, "No digest available (is "
> +				    "SELABEL_OPT_DIGEST option enabled).\n");
> +			break;
> +		default:
> +			fprintf(stderr, "selabel_digest ERROR: %s\n",
> +						    strerror(errno));
> +		}
> +	}
> +
> +	if (sha1_digest == NULL) {
> +		selabel_close(hnd);
> +		return -1;
> +	}
> +
> +	printf("SHA1 digest: ");
> +	for (i = 0; i < DIGEST_SPECFILE_SIZE; i++)
> +		sprintf(&(sha1_buf[i * 2]), "%02x", sha1_digest[i]);
> +
> +	printf("%s\n", sha1_buf);
> +	printf("calculated using the following specfile(s):\n");
> +
> +	if (path_list) {
> +		ptr = &val_buf[0];
> +		sprintf(ptr, "/usr/bin/cat ");
> +		ptr = &val_buf[0] + strlen(val_buf);
> +
> +		for (i = 0; path_list[i]; i++) {
> +			sprintf(ptr, "%s ", path_list[i]);
> +			ptr += strlen(path_list[i]) + 1;
> +			printf("%s\n", path_list[i]);
> +		}
> +		sprintf(ptr, "| /usr/bin/openssl dgst -sha1 -hex");
> +
> +		if (validate) {
> +			rc = run_check_digest(val_buf, sha1_buf);
> +			if (rc)
> +				printf("Failed to run command line\n");
> +		}
> +	}
> +
> +	selabel_close(hnd);
> +	return 0;
> +}
> 
