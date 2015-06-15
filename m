Message-ID: <557F28FA.9050608@tycho.nsa.gov>
Date: Mon, 15 Jun 2015 15:35:22 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH V2] libselinux: Enhance file context support
References: <1434385465-3182-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1434385465-3182-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/15/2015 12:24 PM, Richard Haines wrote:
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
> V2:
> Revert back to using compat_validate instead of selabel_validate.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---

> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index a8d1e51..5c1f17b 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -200,9 +200,9 @@ static inline int sort_specs(struct saved_data *data)
>  	}
>  
>  	/*
> -	 * now the exact pathnames are at the end, but they are in the reverse order.
> -	 * since 'front' is now the first of the 'exact' we can run that part of the
> -	 * array switching the front and back element.
> +	 * now the exact pathnames are at the end, but they are in the reverse
> +	* order. Since 'front' is now the first of the 'exact' we can run
> +	* that part of the array switching the front and back element.
>  	 */

Inconsistent indentation.

> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
> index 03bc0a7..69137f7 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -7,117 +7,71 @@
>  #include <unistd.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> -
> -#include <linux/limits.h>
> +#include <getopt.h>
> +#include <limits.h>
>  
>  #include "../src/label_file.h"
>  
> -static int process_file(struct saved_data *data, const char *filename)
> +/*
> + * These three functions are here as process_line() is common code defined
> + * in label_file.h that make these calls.
> + *
> + * The selinux_log functions are used to display any errors such as invalid
> + * regex or file type (mode).
> + *
> + * As validation is not performed for sefcontext_compile, compat_validate()
> + * returns success. Also see comment in main() regarding validation.
> + */
> +static int __attribute__((format(printf, 2, 3)))
> +default_selinux_log(int type __attribute__((unused)), const char *fmt, ...)
> +{
> +	int rc;
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	rc = vfprintf(stderr, fmt, ap);
> +	va_end(ap);
> +	return rc;
> +}
> +
> +int __attribute__((format(printf, 2, 3)))
> +(*selinux_log)(int, const char *, ...) =
> +	default_selinux_log;
> +
> +int compat_validate(struct selabel_handle __attribute__((unused)) *rec,
> +	    struct selabel_lookup_rec  __attribute__((unused)) *contexts,
> +	    const char  __attribute__((unused)) *path,
> +	    unsigned  __attribute__((unused)) lineno)
> +{
> +	return 0;
> +}

Looked into why you couldn't just use the original approach here, and
realized that we are linking sefcontext_compile with static libselinux
in Android, shared libselinux upstream.  Also realized that your
read_spec_entries function was being accidentally exported to shared
library users, and that also is relied upon by sefcontext_compile.
Given that sefcontext_compile depends on libselinux internal structures,
I can't see a reason to not have it link with the static libselinux, so
I just switched it upstream to do so (and hid read_spec_entries).  So
now you ought to be able to go back to the prior approach, which seemed
cleaner.

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

And then this comment can be true again.
