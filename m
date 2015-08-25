Subject: Re: [PATCH] libselinux: Add policy context validation to
 sefcontext_compile
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1439464140-2776-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55DCB9D0.1010500@tycho.nsa.gov>
Date: Tue, 25 Aug 2015 14:54:08 -0400
MIME-Version: 1.0
In-Reply-To: <1439464140-2776-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/13/2015 07:09 AM, Richard Haines wrote:
> Add -p option that will take a binary policy file to validate
> context entries in the text file_contexts file.
> 
> Should validation fail the binary file will not be written.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
>  libselinux/man/man8/sefcontext_compile.8 | 15 ++++++-
>  libselinux/utils/Makefile                |  2 +-
>  libselinux/utils/sefcontext_compile.c    | 72 +++++++++++++++++++++++++++-----
>  3 files changed, 75 insertions(+), 14 deletions(-)
> 
> diff --git a/libselinux/man/man8/sefcontext_compile.8 b/libselinux/man/man8/sefcontext_compile.8
> index 584c4c6..b77ff3a 100644
> --- a/libselinux/man/man8/sefcontext_compile.8
> +++ b/libselinux/man/man8/sefcontext_compile.8
> @@ -1,4 +1,4 @@
> -.TH "sefcontext_compile" "8" "12 Jun 2015" "dwalsh@redhat.com" "SELinux Command Line documentation"
> +.TH "sefcontext_compile" "8" "12 Aug 2015" "dwalsh@redhat.com" "SELinux Command Line documentation"
>  .SH "NAME"
>  sefcontext_compile \- compile file context regular expression files
>  .
> @@ -6,6 +6,8 @@ sefcontext_compile \- compile file context regular expression files
>  .B sefcontext_compile
>  .RB [ \-o
>  .IR outputfile ]
> +.RB [ \-p
> +.IR policyfile ]
>  .I inputfile
>  .
>  .SH "DESCRIPTION"
> @@ -29,7 +31,16 @@ Specify an
>  that must be a fully qualified file name as the
>  .B .bin
>  suffix is not automatically added.
> -.
> +.TP
> +.B \-p
> +Specify a binary
> +.I policyfile
> +that will be used to validate the context entries in the
> +.I inputfile
> +.br
> +If an invalid context is found the pcre formatted file will not be written and
> +an error will be returned.
> +
>  .SH "RETURN VALUE"
>  On error -1 is returned.  On success 0 is returned.
>  
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index c36761d..cac85c7 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -28,7 +28,7 @@ LDLIBS += -L../src -lselinux -L$(LIBDIR)
>  
>  TARGETS=$(patsubst %.c,%,$(wildcard *.c))
>  
> -sefcontext_compile: LDLIBS += -lpcre ../src/libselinux.a
> +sefcontext_compile: LDLIBS += -lpcre ../src/libselinux.a -lsepol
>  
>  ifeq ($(DISABLE_AVC),y)
>  	UNUSED_TARGETS+=compute_av compute_create compute_member compute_relabel
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
> index 4160632..d2578b6 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -10,11 +10,22 @@
>  #include <getopt.h>
>  #include <limits.h>
>  #include <selinux/selinux.h>
> +#include <sepol/sepol.h>
>  
>  #include "../src/label_file.h"
>  
> -static int validate_context(char __attribute__ ((unused)) **ctx)
> +const char *policy_file;
> +static int ctx_err;
> +
> +static int validate_context(char **ctxp)
>  {
> +	char *ctx = *ctxp;
> +
> +	if (policy_file && sepol_check_context(ctx) < 0) {
> +		ctx_err = -1;
> +		return ctx_err;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -38,8 +49,15 @@ static int process_file(struct selabel_handle *rec, const char *filename)
>  	rc = 0;
>  	while (getline(&line_buf, &line_len, context_file) > 0) {
>  		rc = process_line(rec, filename, prefix, line_buf, ++line_num);
> -		if (rc)
> +		if (rc || ctx_err) {
> +			/* With -p option need to check and fail if ctx err as
> +			 * process_line() context validation on Linux does not
> +			 * return an error, but does print the error line to
> +			 * stderr. Android will set both to error and print
> +			 * the error line. */
> +			rc = -1;
>  			goto out;
> +		}
>  	}
>  out:
>  	free(line_buf);
> @@ -263,13 +281,15 @@ static void free_specs(struct saved_data *data)
>  static void usage(const char *progname)
>  {
>  	fprintf(stderr,
> -		"usage: %s [-o out_file] fc_file\n"
> -		"Where:\n\t"
> -		"-o      Optional file name of the PCRE formatted binary\n\t"
> -		"        file to be output. If not specified the default\n\t"
> -		"        will be fc_file with the .bin suffix appended.\n\t"
> -		"fc_file The text based file contexts file to be processed.\n",
> -		progname);
> +	    "usage: %s [-o out_file] [-p policy_file] fc_file\n"
> +	    "Where:\n\t"
> +	    "-o       Optional file name of the PCRE formatted binary\n\t"
> +	    "         file to be output. If not specified the default\n\t"
> +	    "         will be fc_file with the .bin suffix appended.\n\t"
> +	    "-p       Optional binary policy file that will be used to\n\t"
> +	    "         validate contexts defined in the fc_file.\n\t"
> +	    "fc_file  The text based file contexts file to be processed.\n",
> +	    progname);
>  		exit(EXIT_FAILURE);
>  }
>  
> @@ -280,6 +300,7 @@ int main(int argc, char *argv[])
>  	char stack_path[PATH_MAX + 1];
>  	char *tmp = NULL;
>  	int fd, rc, opt;
> +	FILE *policy_fp = NULL;
>  	struct stat buf;
>  	struct selabel_handle *rec = NULL;
>  	struct saved_data *data = NULL;
> @@ -287,11 +308,14 @@ int main(int argc, char *argv[])
>  	if (argc < 2)
>  		usage(argv[0]);
>  
> -	while ((opt = getopt(argc, argv, "o:")) > 0) {
> +	while ((opt = getopt(argc, argv, "o:p:")) > 0) {
>  		switch (opt) {
>  		case 'o':
>  			out_file = optarg;
>  			break;
> +		case 'p':
> +			policy_file = optarg;
> +			break;
>  		default:
>  			usage(argv[0]);
>  		}
> @@ -306,10 +330,30 @@ int main(int argc, char *argv[])
>  		exit(EXIT_FAILURE);
>  	}
>  
> +	/* Open binary policy if supplied. */
> +	if (policy_file) {
> +		policy_fp = fopen(policy_file, "r");
> +
> +		if (!policy_fp) {
> +			fprintf(stderr, "Failed to open policy: %s\n",
> +							    policy_file);
> +			exit(EXIT_FAILURE);
> +		}
> +
> +		if (sepol_set_policydb_from_file(policy_fp) < 0) {
> +			fprintf(stderr, "Failed to load policy: %s\n",
> +							    policy_file);
> +			fclose(policy_fp);
> +			exit(EXIT_FAILURE);
> +		}
> +	}
> +
>  	/* Generate dummy handle for process_line() function */
>  	rec = (struct selabel_handle *)calloc(1, sizeof(*rec));
>  	if (!rec) {
>  		fprintf(stderr, "Failed to calloc handle\n");
> +		if (policy_fp)
> +			fclose(policy_fp);
>  		exit(EXIT_FAILURE);
>  	}
>  	rec->backend = SELABEL_CTX_FILE;
> @@ -318,7 +362,8 @@ int main(int argc, char *argv[])
>  	 * process_line function, however as the bin file being generated
>  	 * may not be related to the currently loaded policy (that it
>  	 * would be validated against), then set callback to ignore any
> -	 * validation. */
> +	 * validation - unless the -p option is used in which case if an
> +	 * error is detected, the process will be aborted. */
>  	rec->validating = 1;
>  	selinux_set_callback(SELINUX_CB_VALIDATE,
>  			    (union selinux_callback)&validate_context);
> @@ -327,6 +372,8 @@ int main(int argc, char *argv[])
>  	if (!data) {
>  		fprintf(stderr, "Failed to calloc saved_data\n");
>  		free(rec);
> +		if (policy_fp)
> +			fclose(policy_fp);
>  		exit(EXIT_FAILURE);
>  	}
>  
> @@ -376,6 +423,9 @@ int main(int argc, char *argv[])
>  
>  	rc = 0;
>  out:
> +	if (policy_fp)
> +		fclose(policy_fp);
> +
>  	free_specs(data);
>  	free(rec);
>  	free(data);
> 
