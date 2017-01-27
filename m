Message-ID: <1485528933.12027.5.camel@tycho.nsa.gov>
Subject: Re: [PATCH] setfiles: Fix setfiles progress indicator
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov,
 alan.christopher.jenkins@gmail.com
Date: Fri, 27 Jan 2017 09:55:33 -0500
In-Reply-To: <20170127124749.7527-1-richard_c_haines@btinternet.com>
References: <20170127124749.7527-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-01-27 at 12:47 +0000, Richard Haines wrote:
> This fixes the following bug:
> UX regression: setfiles progress indicator is now misleading and
> confusing in fixfiles.
> 
> The outputting of * is replaced by the number of files in 1k
> increments
> as the previous versions. If "/" is specified on the pathname, then
> this
> will indicate a mass relabel, an example output will be:
> restorecon -nRp /etc /tmp /boot /
> /etc 100.0%
> /tmp 100.0%
> /boot 100.0%
> 3.2%
> 
> Also setfiles(8) and restorecon(8) versions that are implemented
> using
> the selinux_restorecon(3) function do not support the [-o filename]
> option as this was deprecated. This has now been made clear by
> displaying
> a message to stderr.
> 
> The documentation has also been updated to reflect these changes.
> 
> Reported-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
>  libselinux/include/selinux/restorecon.h  | 11 +++++++---
>  libselinux/man/man3/selinux_restorecon.3 | 12 +++++++++--
>  libselinux/src/selinux_restorecon.c      | 37 ++++++++------------
> ------------
>  policycoreutils/setfiles/.gitignore      |  1 -
>  policycoreutils/setfiles/Makefile        |  7 ++----
>  policycoreutils/setfiles/restore.c       |  3 ++-
>  policycoreutils/setfiles/restore.h       |  9 +-------
>  policycoreutils/setfiles/restorecon.8    |  4 ++--
>  policycoreutils/setfiles/setfiles.8      |  6 +++---
>  policycoreutils/setfiles/setfiles.c      | 27 +++++++---------------
> -
>  10 files changed, 45 insertions(+), 72 deletions(-)
> 
> diff --git a/libselinux/include/selinux/restorecon.h
> b/libselinux/include/selinux/restorecon.h
> index 7cfdee1..de694cd 100644
> --- a/libselinux/include/selinux/restorecon.h
> +++ b/libselinux/include/selinux/restorecon.h
> @@ -50,9 +50,9 @@ extern int selinux_restorecon(const char *pathname,
>   */
>  #define SELINUX_RESTORECON_VERBOSE			0x0010
>  /*
> - * Show progress by printing * to stdout every 1000 files, unless
> - * relabeling the entire OS, that will then show the approximate
> - * percentage complete.
> + * If SELINUX_RESTORECON_PROGRESS is true and
> + * SELINUX_RESTORECON_MASS_RELABEL is true, then output approx %
> complete,
> + * else output the number of files in 1k blocks processed to stdout.
>   */
>  #define SELINUX_RESTORECON_PROGRESS			0x0020
>  /*
> @@ -91,6 +91,11 @@ extern int selinux_restorecon(const char
> *pathname,
>   * mounts to be excluded from relabeling checks.
>   */
>  #define SELINUX_RESTORECON_IGNORE_MOUNTS		0x2000
> +/*
> + * Set if there is a mass relabel required.
> + * See SELINUX_RESTORECON_PROGRESS flag for details.
> + */
> +#define SELINUX_RESTORECON_MASS_RELABEL			0x400
> 0
>  
>  /**
>   * selinux_restorecon_set_sehandle - Set the global fc handle.
> diff --git a/libselinux/man/man3/selinux_restorecon.3
> b/libselinux/man/man3/selinux_restorecon.3
> index d698818..1eac6ed 100644
> --- a/libselinux/man/man3/selinux_restorecon.3
> +++ b/libselinux/man/man3/selinux_restorecon.3
> @@ -88,8 +88,16 @@ will take precedence.
>  .RE
>  .sp
>  .B SELINUX_RESTORECON_PROGRESS
> -show progress by printing * to stdout every 1000 files unless
> relabeling the
> -entire OS, that will then show the approximate percentage complete.
> +show progress by outputting the number of files in 1k blocks
> processed
> +to stdout. If the
> +.B SELINUX_RESTORECON_MASS_RELABEL
> +flag is also set then the approximate percentage complete will be
> shown.
> +.sp
> +.B SELINUX_RESTORECON_MASS_RELABEL
> +generally set when relabeling the entire OS, that will then show the
> +approximate percentage complete. The
> +.B SELINUX_RESTORECON_PROGRESS
> +flag must also be set.
>  .sp
>  .B SELINUX_RESTORECON_REALPATH
>  convert passed-in
> diff --git a/libselinux/src/selinux_restorecon.c
> b/libselinux/src/selinux_restorecon.c
> index 38acbd2..9fdafea 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -41,7 +41,7 @@
>  #define SYS_PATH "/sys"
>  #define SYS_PREFIX SYS_PATH "/"
>  
> -#define STAR_COUNT 1000
> +#define STAR_COUNT 1024
>  
>  static struct selabel_handle *fc_sehandle = NULL;
>  static unsigned char *fc_digest = NULL;
> @@ -68,18 +68,12 @@ static uint64_t efile_count;	/* Estimated
> total number of files */
>  struct dir_xattr *dir_xattr_list;
>  static struct dir_xattr *dir_xattr_last;
>  
> -/*
> - * If SELINUX_RESTORECON_PROGRESS is set and mass_relabel = true,
> then
> - * output approx % complete, else output * for every STAR_COUNT
> files
> - * processed to stdout.
> - */
> -static bool mass_relabel;
> -
>  /* restorecon_flags for passing to restorecon_sb() */
>  struct rest_flags {
>  	bool nochange;
>  	bool verbose;
>  	bool progress;
> +	bool mass_relabel;
>  	bool set_specctx;
>  	bool add_assoc;
>  	bool ignore_digest;
> @@ -631,14 +625,14 @@ static int restorecon_sb(const char *pathname,
> const struct stat *sb,
>  	if (flags->progress) {
>  		fc_count++;
>  		if (fc_count % STAR_COUNT == 0) {
> -			if (mass_relabel && efile_count > 0) {
> +			if (flags->mass_relabel && efile_count > 0)
> {
>  				pc = (fc_count < efile_count) ?
> (100.0 *
>  					     fc_count / efile_count)
> : 100;
>  				fprintf(stdout, "\r%-.1f%%",
> (double)pc);
>  			} else {
> -				fprintf(stdout, "*");
> +				fprintf(stdout, "\r%luk", fc_count /
> STAR_COUNT);
>  			}
> -		fflush(stdout);
> +			fflush(stdout);
>  		}
>  	}
>  
> @@ -750,6 +744,8 @@ int selinux_restorecon(const char *pathname_orig,
>  		    SELINUX_RESTORECON_VERBOSE) ? true : false;
>  	flags.progress = (restorecon_flags &
>  		    SELINUX_RESTORECON_PROGRESS) ? true : false;
> +	flags.mass_relabel = (restorecon_flags &
> +		    SELINUX_RESTORECON_MASS_RELABEL) ? true : false;
>  	flags.recurse = (restorecon_flags &
>  		    SELINUX_RESTORECON_RECURSE) ? true : false;
>  	flags.set_specctx = (restorecon_flags &
> @@ -904,17 +900,6 @@ int selinux_restorecon(const char
> *pathname_orig,
>  		}
>  	}
>  
> -	mass_relabel = false;
> -	if (!strcmp(pathname, "/")) {
> -		mass_relabel = true;
> -		if (flags.set_xdev && flags.progress)
> -			/*
> -			 * Need to recalculate to get accurate %
> complete
> -			 * as only root device id will be processed.
> -			 */
> -			efile_count = file_system_count(pathname);
> -	}
> -
>  	if (flags.set_xdev)
>  		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR | FTS_XDEV;
>  	else
> @@ -1009,12 +994,8 @@ int selinux_restorecon(const char
> *pathname_orig,
>  	}
>  
>  out:
> -	if (flags.progress) {
> -		if (mass_relabel)
> -			fprintf(stdout, "\r100.0%%\n");
> -		else
> -			fprintf(stdout, "\n");
> -	}
> +	if (flags.progress && flags.mass_relabel)
> +		fprintf(stdout, "\r%s 100.0%%\n", pathname);
>  
>  	sverrno = errno;
>  	(void) fts_close(fts);
> diff --git a/policycoreutils/setfiles/.gitignore
> b/policycoreutils/setfiles/.gitignore
> index 583eb6c..5e899c9 100644
> --- a/policycoreutils/setfiles/.gitignore
> +++ b/policycoreutils/setfiles/.gitignore
> @@ -1,2 +1 @@
> -restorecon.8.man
>  setfiles.8.man
> diff --git a/policycoreutils/setfiles/Makefile
> b/policycoreutils/setfiles/Makefile
> index 43364f9..92300c9 100644
> --- a/policycoreutils/setfiles/Makefile
> +++ b/policycoreutils/setfiles/Makefile
> @@ -5,7 +5,6 @@ MANDIR = $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
>  AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
>  
> -PROGRESS_STEP=$(shell grep "^\#define STAR_COUNT" restore.h | awk -S
> '{ print $$3 }')
>  ABORT_ON_ERRORS=$(shell grep "^\#define ABORT_ON_ERRORS" setfiles.c
> | awk -S '{ print $$3 }')
>  
>  CFLAGS ?= -g -Werror -Wall -W
> @@ -28,8 +27,6 @@ restorecon_xattr:  restorecon_xattr.o restore.o
>  
>  man:
>  	@cp -af setfiles.8 setfiles.8.man
> -	@cp -af restorecon.8 restorecon.8.man
> -	@sed -i "s/STAR_COUNT/$(PROGRESS_STEP)/g" setfiles.8.man
> restorecon.8.man
>  	@sed -i "s/ABORT_ON_ERRORS/$(ABORT_ON_ERRORS)/g"
> setfiles.8.man
>  
>  install: all
> @@ -39,11 +36,11 @@ install: all
>  	(cd $(SBINDIR) && ln -sf setfiles restorecon)
>  	install -m 755 restorecon_xattr $(SBINDIR)
>  	install -m 644 setfiles.8.man $(MANDIR)/man8/setfiles.8
> -	install -m 644 restorecon.8.man $(MANDIR)/man8/restorecon.8
> +	install -m 644 restorecon.8 $(MANDIR)/man8/restorecon.8
>  	install -m 644 restorecon_xattr.8
> $(MANDIR)/man8/restorecon_xattr.8
>  
>  clean:
> -	rm -f setfiles restorecon restorecon_xattr *.o
> setfiles.8.man restorecon.8.man
> +	rm -f setfiles restorecon restorecon_xattr *.o
> setfiles.8.man
>  
>  indent:
>  	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/policycoreutils/setfiles/restore.c
> b/policycoreutils/setfiles/restore.c
> index cf04e96..50d192a 100644
> --- a/policycoreutils/setfiles/restore.c
> +++ b/policycoreutils/setfiles/restore.c
> @@ -35,7 +35,8 @@ void restore_init(struct restore_opts *opts)
>  			   r_opts->recurse | r_opts->userealpath |
>  			   r_opts->xdev | r_opts->abort_on_error |
>  			   r_opts->syslog_changes | r_opts-
> >log_matches |
> -			   r_opts->ignore_noent | r_opts-
> >ignore_mounts;
> +			   r_opts->ignore_noent | r_opts-
> >ignore_mounts |
> +			   r_opts->mass_relabel;
>  
>  	/* Use setfiles, restorecon and restorecond own handles */
>  	selinux_restorecon_set_sehandle(r_opts->hnd);
> diff --git a/policycoreutils/setfiles/restore.h
> b/policycoreutils/setfiles/restore.h
> index 97fbdf4..b64042a 100644
> --- a/policycoreutils/setfiles/restore.h
> +++ b/policycoreutils/setfiles/restore.h
> @@ -17,18 +17,12 @@
>  #include <limits.h>
>  #include <stdint.h>
>  
> -/*
> - * STAR_COUNT is also defined in libselinux/src/selinux_restorecon.c
> where it
> - * is used to output "*" for each number of files processed. Defined
> here for
> - * inclusion in man pages.
> -*/
> -#define STAR_COUNT 1000
> -
>  /* Things that need to be init'd */
>  struct restore_opts {
>  	unsigned int nochange;
>  	unsigned int verbose;
>  	unsigned int progress;
> +	unsigned int mass_relabel;
>  	unsigned int set_specctx;
>  	unsigned int add_assoc;
>  	unsigned int ignore_digest;
> @@ -49,7 +43,6 @@ struct restore_opts {
>  	const char *selabel_opt_path;
>  	const char *selabel_opt_digest;
>  	int debug;
> -	FILE *outfile;
>  };
>  
>  void restore_init(struct restore_opts *opts);
> diff --git a/policycoreutils/setfiles/restorecon.8
> b/policycoreutils/setfiles/restorecon.8
> index bd27113..0f81db4 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -115,10 +115,10 @@ don't change any file labels (passive
> check).  To display the files whose labels
>  .BR \-v .
>  .TP
>  .BI \-o \ outfilename
> -Deprecated, SELinux policy will probably block this access.  Use
> shell redirection to save list of files with incorrect context in
> filename.
> +Deprecated - This option is no longer supported.
>  .TP
>  .B \-p
> -show progress by printing * every STAR_COUNT files unless relabeling
> the entire
> +show progress by printing the number of files in 1k blocks unless
> relabeling the entire
>  OS, that will then show the approximate percentage complete. Note
> that the
>  .B \-p
>  and
> diff --git a/policycoreutils/setfiles/setfiles.8
> b/policycoreutils/setfiles/setfiles.8
> index 6901e13..9501845 100644
> --- a/policycoreutils/setfiles/setfiles.8
> +++ b/policycoreutils/setfiles/setfiles.8
> @@ -106,11 +106,11 @@ seclabel fs mounted on a directory below this.
>  .B \-n
>  don't change any file labels (passive check).
>  .TP
> -.BI \-o \ filename
> -Deprecated, SELinux policy will probably block this access.  Use
> shell redirection to save list of files with incorrect context in
> filename.
> +.BI \-o \ outfilename
> +Deprecated - This option is no longer supported.
>  .TP
>  .B \-p
> -show progress by printing * every STAR_COUNT files unless relabeling
> the entire
> +show progress by printing the number of files in 1k blocks unless
> relabeling the entire
>  OS, that will then show the approximate percentage complete. Note
> that the
>  .B \-p
>  and
> diff --git a/policycoreutils/setfiles/setfiles.c
> b/policycoreutils/setfiles/setfiles.c
> index d767131..e3df212 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -160,7 +160,7 @@ int main(int argc, char **argv)
>  	char *buf = NULL;
>  	size_t buf_len;
>  	const char *base;
> -	int mass_relabel = 0, errors = 0;
> +	int errors = 0;
>  	const char *ropts = "e:f:hiIDlmno:pqrsvFRW0";
>  	const char *sopts = "c:de:f:hiIDlmno:pqr:svFR:W0";
>  	const char *opts;
> @@ -318,19 +318,8 @@ int main(int argc, char **argv)
>  			r_opts.nochange =
> SELINUX_RESTORECON_NOCHANGE;
>  			break;
>  		case 'o': /* Deprecated */
> -			if (strcmp(optarg, "-") == 0) {
> -				r_opts.outfile = stdout;
> -				break;
> -			}
> -
> -			r_opts.outfile = fopen(optarg, "w");
> -			if (!r_opts.outfile) {
> -				fprintf(stderr, "Error opening %s:
> %s\n",
> -					optarg, strerror(errno));
> -
> -				usage(argv[0]);
> -			}
> -			__fsetlocking(r_opts.outfile,
> FSETLOCKING_BYCALLER);
> +			fprintf(stderr, "%s: -o option no longer
> supported\n",
> +				r_opts.progname);
>  			break;
>  		case 'q':
>  			/* Deprecated - Was only used to say whether
> print
> @@ -394,7 +383,7 @@ int main(int argc, char **argv)
>  
>  	for (i = optind; i < argc; i++) {
>  		if (!strcmp(argv[i], "/"))
> -			mass_relabel = 1;
> +			r_opts.mass_relabel =
> SELINUX_RESTORECON_MASS_RELABEL;
>  	}
>  
>  	cb.func_log = log_callback;
> @@ -466,7 +455,7 @@ int main(int argc, char **argv)
>  		while ((len = getdelim(&buf, &buf_len, delim, f)) >
> 0) {
>  			buf[len - 1] = 0;
>  			if (!strcmp(buf, "/"))
> -				mass_relabel = 1;
> +				r_opts.mass_relabel =
> SELINUX_RESTORECON_MASS_RELABEL;
>  			errors |= process_glob(buf, &r_opts) < 0;
>  		}
>  		if (strcmp(input_filename, "-") != 0)
> @@ -476,7 +465,7 @@ int main(int argc, char **argv)
>  			errors |= process_glob(argv[i], &r_opts) <
> 0;
>  	}
>  
> -	maybe_audit_mass_relabel(mass_relabel, errors);
> +	maybe_audit_mass_relabel(r_opts.mass_relabel, errors);
>  
>  	if (warn_no_match)
>  		selabel_stats(r_opts.hnd);
> @@ -484,8 +473,8 @@ int main(int argc, char **argv)
>  	selabel_close(r_opts.hnd);
>  	restore_finish();
>  
> -	if (r_opts.outfile)
> -		fclose(r_opts.outfile);
> +	if (r_opts.progress)
> +		fprintf(stdout, "\n");
>  
>  	exit(errors ? -1 : 0);
>  }
