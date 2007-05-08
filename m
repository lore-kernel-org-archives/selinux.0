Subject: Re: [RFC][PATCH] Coalesce setfiles and restorecon into a single
	program
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1178306387.677.14.camel@moss-spartans.epoch.ncsc.mil>
References: <1178306387.677.14.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 08 May 2007 11:13:58 -0400
Message-Id: <1178637238.25354.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-04 at 15:19 -0400, Stephen Smalley wrote:
> restorecon started life as a much simpler program, but has gradually
> grown to being largely a duplicate of setfiles, only differing in its
> interface and default behaviors.  Meanwhile, people keep adding features
> and options to both programs, leading to inconsistencies.
> 
> This patch coalesces setfiles and restorecon into a single program
> presenting different interfaces and default behaviors depending on
> basename(argv[0]), making restorecon a symlink to setfiles.
> 
> Unresolved issue: Current policy defines separate domains for the two
> programs.  We need to either coalesce the domains as well, or if there
> is legitimate reason for separating them, restorecon could remain a
> separate binary (either a complete separate copy or a wrapper) even if
> the sources are coalesced.
> 
> Comments?
> 

I'm fine with this change (and the associated bug fix).

Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

Karl

> ---
> 
>  policycoreutils/Makefile                |    2 
>  policycoreutils/restorecon/Makefile     |   28 -
>  policycoreutils/restorecon/restorecon.8 |   68 ---
>  policycoreutils/restorecon/restorecon.c |  456 -----------------------
>  policycoreutils/setfiles/Makefile       |   10 
>  policycoreutils/setfiles/restorecon.8   |   68 +++
>  policycoreutils/setfiles/setfiles.c     |  614 +++++++++++++++++++-------------
>  7 files changed, 441 insertions(+), 805 deletions(-)
> 
> Index: trunk/policycoreutils/restorecon/restorecon.c
> ===================================================================
> --- trunk/policycoreutils/restorecon/restorecon.c	(revision 2429)
> +++ trunk/policycoreutils/restorecon/restorecon.c	(working copy)
> @@ -1,456 +0,0 @@
> -/* 
> - * restorecon
> - *
> - * AUTHOR:  Dan Walsh <dwalsh@redhat.com>
> - *
> - * PURPOSE:
> - * This program takes a list of files and sets their security context
> - * to match the specification returned by matchpathcon.
> - *
> - * USAGE:
> - * restorecon [-Rnv] pathname...
> - * 
> - * -e   Specify directory to exclude
> - * -i   Ignore error if file does not exist
> - * -n	Do not change any file labels.
> - * -v	Show changes in file labels.  
> - * -o	filename save list of files with incorrect context
> - * -F	Force reset of context to match file_context for customizable files
> - *
> - * pathname...	The file(s) to label 
> - *
> - * EXAMPLE USAGE:
> - * restorecon /dev/tty*
> - *
> - */
> -
> -#define _GNU_SOURCE
> -#include <stdio.h>
> -#include <stdio_ext.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <limits.h>
> -#include <selinux/selinux.h>
> -#include <getopt.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <stdio.h>
> -#define __USE_XOPEN_EXTENDED 1	/* nftw */
> -#include <ftw.h>
> -
> -static int change = 1;
> -static int verbose = 0;
> -static int progress = 0;
> -static FILE *outfile = NULL;
> -static char *progname;
> -static int errors = 0;
> -static int recurse = 0;
> -static int file_exist = 1;
> -static int force = 0;
> -#define STAT_BLOCK_SIZE 1
> -static int pipe_fds[2] = { -1, -1 };
> -static unsigned long long count = 0;
> -
> -#define MAX_EXCLUDES 100
> -static int excludeCtr = 0;
> -struct edir {
> -	char *directory;
> -	size_t size;
> -};
> -static struct edir excludeArray[MAX_EXCLUDES];
> -static int add_exclude(const char *directory)
> -{
> -	struct stat sb;
> -	size_t len = 0;
> -	if (directory == NULL || directory[0] != '/') {
> -		fprintf(stderr, "Full path required for exclude: %s.\n",
> -			directory);
> -		return 1;
> -	}
> -	if (lstat(directory, &sb)) {
> -		fprintf(stderr, "Directory \"%s\" not found, ignoring.\n",
> -			directory);
> -		return 0;
> -	}
> -	if ((sb.st_mode & S_IFDIR) == 0) {
> -		fprintf(stderr,
> -			"\"%s\" is not a Directory: mode %o, ignoring\n",
> -			directory, sb.st_mode);
> -		return 0;
> -	}
> -
> -	if (excludeCtr == MAX_EXCLUDES) {
> -		fprintf(stderr, "Maximum excludes %d exceeded.\n",
> -			MAX_EXCLUDES);
> -		return 1;
> -	}
> -
> -	len = strlen(directory);
> -	while (len > 1 && directory[len - 1] == '/') {
> -		len--;
> -	}
> -	excludeArray[excludeCtr].directory = strndup(directory, len);
> -
> -	if (excludeArray[excludeCtr].directory == NULL) {
> -		fprintf(stderr, "Out of memory.\n");
> -		return 1;
> -	}
> -	excludeArray[excludeCtr++].size = len;
> -
> -	return 0;
> -}
> -static int exclude(const char *file)
> -{
> -	int i = 0;
> -	for (i = 0; i < excludeCtr; i++) {
> -		if (strncmp
> -		    (file, excludeArray[i].directory,
> -		     excludeArray[i].size) == 0) {
> -			if (file[excludeArray[i].size] == 0
> -			    || file[excludeArray[i].size] == '/') {
> -				return 1;
> -			}
> -		}
> -	}
> -	return 0;
> -}
> -
> -/* Compare two contexts to see if their differences are "significant",
> - * or whether the only difference is in the user. */
> -static int only_changed_user(const char *a, const char *b)
> -{
> -	char *rest_a, *rest_b;	/* Rest of the context after the user */
> -	if (force)
> -		return 0;
> -	if (!a || !b)
> -		return 0;
> -	rest_a = strchr(a, ':');
> -	rest_b = strchr(b, ':');
> -	if (!rest_a || !rest_b)
> -		return 0;
> -	return (strcmp(rest_a, rest_b) == 0);
> -}
> -
> -void usage(const char *const name)
> -{
> -	fprintf(stderr,
> -		"usage:  %s [-iFnrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
> -		name);
> -	exit(1);
> -}
> -
> -/* filename has trailing '/' removed by nftw or other calling code */
> -int restore(const char *filename)
> -{
> -	int retcontext = 0;
> -	security_context_t scontext = NULL;
> -	security_context_t prev_context = NULL;
> -	struct stat st;
> -	char path[PATH_MAX + 1];
> -
> -	if (progress) {
> -		count++;
> -		if (count % 80000 == 0) {
> -			fprintf(stdout, "\n");
> -			fflush(stdout);
> -		}
> -		if (count % 1000 == 0) {
> -			fprintf(stdout, "*");
> -			fflush(stdout);
> -		}
> -	}
> -
> -	if (excludeCtr > 0 && exclude(filename)) {
> -		return 0;
> -	}
> -
> -	if (lstat(filename, &st) != 0) {
> -		if (!file_exist && errno == ENOENT)
> -			return 0;
> -		fprintf(stderr, "lstat(%s) failed: %s\n", filename,
> -			strerror(errno));
> -		return 1;
> -	}
> -	if (S_ISLNK(st.st_mode)) {
> -		if (verbose > 1)
> -			fprintf(stderr,
> -				"Warning! %s refers to a symbolic link, not following last component.\n",
> -				filename);
> -		char *p = NULL, *file_sep;
> -		char *tmp_path = strdupa(filename);
> -		size_t len = 0;
> -		if (!tmp_path) {
> -			fprintf(stderr, "strdupa on %s failed:  %s\n", filename,
> -				strerror(errno));
> -			return 1;
> -		}
> -		file_sep = strrchr(tmp_path, '/');
> -		if (file_sep == tmp_path) {
> -			file_sep++;
> -			p = strcpy(path, "");
> -		} else if (file_sep) {
> -			*file_sep = 0;
> -			file_sep++;
> -			p = realpath(tmp_path, path);
> -		} else {
> -			file_sep = tmp_path;
> -			p = realpath("./", path);
> -		}
> -		if (p)
> -			len = strlen(p);
> -		if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
> -			fprintf(stderr, "realpath(%s) failed %s\n", filename,
> -				strerror(errno));
> -			return 1;
> -		}
> -		p += len;
> -		/* ensure trailing slash of directory name */
> -		if (len == 0 || *(p - 1) != '/') {
> -			*p = '/';
> -			p++;
> -		}
> -		strcpy(p, file_sep);
> -		filename = path;
> -	} else {
> -		char *p;
> -		p = realpath(filename, path);
> -		if (!p) {
> -			fprintf(stderr, "realpath(%s) failed %s\n", filename,
> -				strerror(errno));
> -			return 1;
> -		}
> -		filename = p;
> -	}
> -	if (excludeCtr > 0 && exclude(filename)) {
> -		return 0;
> -	}
> -	if (matchpathcon(filename, st.st_mode, &scontext) < 0) {
> -		if (errno == ENOENT)
> -			return 0;
> -		fprintf(stderr, "matchpathcon(%s) failed %s\n", filename,
> -			strerror(errno));
> -		return 1;
> -	}
> -	retcontext = lgetfilecon_raw(filename, &prev_context);
> -
> -	if (retcontext >= 0 || errno == ENODATA) {
> -		int customizable = 0;
> -		if (retcontext < 0)
> -			prev_context = NULL;
> -		if (retcontext < 0 || force ||
> -		    (strcmp(prev_context, scontext) != 0 &&
> -		     !(customizable =
> -		       is_context_customizable(prev_context) > 0))) {
> -			if (only_changed_user(scontext, prev_context) == 0) {
> -				if (outfile)
> -					fprintf(outfile, "%s\n", filename);
> -				if (change) {
> -					if (lsetfilecon(filename, scontext) < 0) {
> -						fprintf(stderr,
> -							"%s set context %s->%s failed:'%s'\n",
> -							progname, filename,
> -							scontext,
> -							strerror(errno));
> -						if (retcontext >= 0)
> -							freecon(prev_context);
> -						freecon(scontext);
> -						return 1;
> -					}
> -				} 
> -
> -				if (verbose)
> -					printf("%s reset %s context %s->%s\n",
> -					       progname, filename,
> -					       (retcontext >=
> -						0 ? prev_context : ""),
> -					       scontext);
> -			}
> -		}
> -		if (verbose > 1 && !force && customizable > 0) {
> -			printf("%s: %s not reset customized by admin to %s\n",
> -			       progname, filename, prev_context);
> -		}
> -
> -		if (retcontext >= 0)
> -			freecon(prev_context);
> -	} else {
> -		errors++;
> -		fprintf(stderr, "%s get context on %s failed: '%s'\n",
> -			progname, filename, strerror(errno));
> -	}
> -	freecon(scontext);
> -	return errors;
> -}
> -
> -static int pre_stat(const char *file_unused __attribute__ ((unused)),
> -		    const struct stat *sb_unused __attribute__ ((unused)),
> -		    int flag_unused __attribute__ ((unused)),
> -		    struct FTW *s_unused __attribute__ ((unused)))
> -{
> -	char buf[STAT_BLOCK_SIZE];
> -	if (write(pipe_fds[1], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE) {
> -		fprintf(stderr, "Error writing to stat pipe, child exiting.\n");
> -		exit(1);
> -	}
> -	return 0;
> -}
> -
> -static int apply_spec(const char *file,
> -		      const struct stat *sb_unused __attribute__ ((unused)),
> -		      int flag, struct FTW *s_unused __attribute__ ((unused)))
> -{
> -	char buf[STAT_BLOCK_SIZE];
> -	if (pipe_fds[0] != -1
> -	    && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE) {
> -		fprintf(stderr, "Read error on pipe.\n");
> -		pipe_fds[0] = -1;
> -	}
> -	if (flag == FTW_DNR) {
> -		fprintf(stderr, "%s:  unable to read directory %s\n",
> -			progname, file);
> -		return 0;
> -	}
> -	errors = errors + restore(file);
> -	return 0;
> -}
> -void process(char *buf)
> -{
> -	int rc;
> -	if (recurse) {
> -		if (pipe(pipe_fds) == -1)
> -			rc = -1;
> -		else
> -			rc = fork();
> -		if (rc == 0) {
> -			close(pipe_fds[0]);
> -			nftw(buf, pre_stat, 1024, FTW_PHYS);
> -			exit(1);
> -		}
> -		if (rc > 0)
> -			close(pipe_fds[1]);
> -		if (rc == -1 || rc > 0) {
> -			if (nftw(buf, apply_spec, 1024, FTW_PHYS)) {
> -				if (!file_exist && errno == ENOENT)
> -					return;
> -				fprintf(stderr,
> -					"%s: error while traversing %s: %s\n",
> -					progname, buf, strerror(errno));
> -				errors++;
> -			}
> -		}
> -	} else {
> -		/* Eliminate trailing / */
> -		size_t len = strlen(buf);
> -		if (len > 1 && buf[len - 1] == '/') {
> -			buf[len - 1] = 0;
> -		}
> -		errors = errors + restore(buf);
> -	}
> -}
> -int main(int argc, char **argv)
> -{
> -	int i = 0;
> -	char *file_name = NULL;
> -	int file = 0;
> -	int opt;
> -	char *buf = NULL;
> -	size_t buf_len;
> -
> -	memset(excludeArray, 0, sizeof(excludeArray));
> -
> -	progname = argv[0];
> -	if (is_selinux_enabled() <= 0)
> -		exit(0);
> -
> -	set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
> -
> -	while ((opt = getopt(argc, argv, "ipFrRnvf:o:e:")) > 0) {
> -		switch (opt) {
> -		case 'n':
> -			change = 0;
> -			break;
> -		case 'i':
> -			file_exist = 0;
> -			break;
> -		case 'r':
> -		case 'R':
> -			recurse = 1;
> -			break;
> -		case 'F':
> -			force = 1;
> -			break;
> -		case 'e':
> -			if (add_exclude(optarg))
> -				exit(1);
> -			break;
> -		case 'o':
> -			if (strcmp(optarg, "-") == 0)
> -				outfile = stdout;
> -			else {
> -				outfile = fopen(optarg, "w");
> -				if (!outfile) {
> -					fprintf(stderr,
> -						"Error opening %s: %s\n",
> -						optarg, strerror(errno));
> -					usage(argv[0]);
> -				}
> -				__fsetlocking(outfile, FSETLOCKING_BYCALLER);
> -			}
> -			break;
> -		case 'v':
> -			if (progress) {
> -				fprintf(stderr,
> -					"Progress and Verbose mutually exclusive\n");
> -				usage(argv[0]);
> -			}
> -
> -			verbose++;
> -			break;
> -		case 'p':
> -			if (verbose) {
> -				fprintf(stderr,
> -					"Progress and Verbose mutually exclusive\n");
> -				usage(argv[0]);
> -			}
> -			progress = 1;
> -			break;
> -		case 'f':
> -			file = 1;
> -			file_name = optarg;
> -			break;
> -		case '?':
> -			usage(argv[0]);
> -		}
> -	}
> -	if (file) {
> -		FILE *f = stdin;
> -		ssize_t len;
> -		if (strcmp(file_name, "-") != 0)
> -			f = fopen(file_name, "r");
> -		if (f == NULL) {
> -			fprintf(stderr, "Unable to open %s: %s\n", file_name,
> -				strerror(errno));
> -			usage(argv[0]);
> -		}
> -		__fsetlocking(f, FSETLOCKING_BYCALLER);
> -		while ((len = getline(&buf, &buf_len, f)) != -1) {
> -			buf[len - 1] = 0;
> -			process(buf);
> -		}
> -		if (strcmp(file_name, "-") != 0)
> -			fclose(f);
> -	} else {
> -		if (optind >= argc)
> -			usage(argv[0]);
> -		for (i = optind; i < argc; i++) {
> -			process(argv[i]);
> -		}
> -	}
> -	if (outfile)
> -		fclose(outfile);
> -
> -	return errors;
> -}
> Index: trunk/policycoreutils/restorecon/restorecon.8
> ===================================================================
> --- trunk/policycoreutils/restorecon/restorecon.8	(revision 2429)
> +++ trunk/policycoreutils/restorecon/restorecon.8	(working copy)
> @@ -1,68 +0,0 @@
> -.TH "restorecon" "8" "2002031409" "" ""
> -.SH "NAME"
> -restorecon \- restore file(s) default SELinux security contexts.
> -
> -.SH "SYNOPSIS"
> -.B restorecon
> -.I [\-o outfilename ] [\-R] [\-n] [\-v] [\-e directory ] pathname...
> -.P
> -.B restorecon
> -.I \-f infilename [\-o outfilename ] [\-e directory ] [\-R] [\-n] [\-v] [\-F]
> -
> -.SH "DESCRIPTION"
> -This manual page describes the
> -.BR restorecon
> -program.
> -.P
> -This program is primarily used to set the security context
> -(extended attributes) on one or more files. 
> -.P
> -It can be run at any time to correct errors, to add support for
> -new policy, or with the \-n option it can just check whether the file
> -contexts are all as you expect.
> -
> -.SH "OPTIONS"
> -.TP 
> -.B \-i
> -ignore files that do not exist
> -.TP 
> -.B \-f infilename
> -infilename contains a list of files to be processed by application. Use \- for stdin.
> -.TP 
> -.B \-e directory
> -directory to exclude (repeat option for more than one directory.)
> -.TP 
> -.B \-R \-r
> -change files and directories file labels recursively
> -.TP 
> -.B \-n
> -don't change any file labels.
> -.TP 
> -.B \-o outfilename
> -save list of files with incorrect context in outfilename.
> -.TP 
> -.B \-v
> -show changes in file labels.
> -.TP 
> -.B \-vv
> -show changes in file labels, if type, role, or user are changing.
> -.TP 
> -.B \-F
> -Force reset of context to match file_context for customizable files, or the user section, if it has changed. 
> -.TP 
> -.SH "ARGUMENTS"
> -.B pathname...
> -The pathname for the file(s) to be relabeled. 
> -.SH NOTE
> -restorecon does not follow symbolic links.
> -
> -.SH "AUTHOR"
> -This man page was written by Dan Walsh <dwalsh@redhat.com>.
> -Some of the content of this man page was taken from the setfiles 
> -man page written by Russell Coker <russell@coker.com.au>.
> -The program was written by Dan Walsh <dwalsh@redhat.com>.
> -
> -.SH "SEE ALSO"
> -.BR load_policy (8),
> -.BR checkpolicy (8)
> -.BR setfiles (8)
> Index: trunk/policycoreutils/restorecon/Makefile
> ===================================================================
> --- trunk/policycoreutils/restorecon/Makefile	(revision 2429)
> +++ trunk/policycoreutils/restorecon/Makefile	(working copy)
> @@ -1,28 +0,0 @@
> -# Installation directories.
> -PREFIX ?= ${DESTDIR}/usr
> -SBINDIR ?= $(DESTDIR)/sbin
> -MANDIR = $(PREFIX)/share/man
> -
> -CFLAGS ?= -Werror -Wall -W
> -override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
> -LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
> -
> -all: restorecon
> -
> -restorecon:  restorecon.o 
> -	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> -
> -install: all
> -	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
> -	-mkdir -p $(SBINDIR)
> -	install -m 755 restorecon $(SBINDIR)
> -	install -m 644 restorecon.8 $(MANDIR)/man8
> -
> -clean:
> -	-rm -f restorecon *.o 
> -
> -indent:
> -	../../scripts/Lindent $(wildcard *.[ch])
> -
> -relabel: install
> -	/sbin/restorecon $(SBINDIR)/restorecon
> Index: trunk/policycoreutils/Makefile
> ===================================================================
> --- trunk/policycoreutils/Makefile	(revision 2429)
> +++ trunk/policycoreutils/Makefile	(working copy)
> @@ -1,4 +1,4 @@
> -SUBDIRS=setfiles semanage load_policy newrole run_init restorecon restorecond secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
> +SUBDIRS=setfiles semanage load_policy newrole run_init restorecond secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
>  
>  all install relabel clean indent:
>  	@for subdir in $(SUBDIRS); do \
> Index: trunk/policycoreutils/setfiles/setfiles.c
> ===================================================================
> --- trunk/policycoreutils/setfiles/setfiles.c	(revision 2429)
> +++ trunk/policycoreutils/setfiles/setfiles.c	(working copy)
> @@ -1,64 +1,6 @@
> -/* 
> - * setfiles
> - *
> - * AUTHOR:  Stephen Smalley <sds@epoch.ncsc.mil>
> - * This program was derived in part from the setfiles.pl script
> - * developed by Secure Computing Corporation.
> - *
> - * PURPOSE:
> - * This program reads a set of file security context specifications
> - * based on pathname regular expressions and labels files
> - * accordingly, traversing a set of file systems specified by
> - * the user.  The program does not cross file system boundaries.
> - *
> - * USAGE:
> - * setfiles [-dnpqsvW] [-e directory ] [-c policy] [-o filename ] spec_file pathname...
> - * 
> - * -e   Specify directory to exclude
> - * -F	Force reset of context to match file_context for customizable files
> - * -c   Verify the specification file using a binary policy
> - * -d   Show what specification matched each file.
> - * -l   Log changes in files labels to syslog.
> - * -n	Do not change any file labels.
> - * -p   Show progress.  Prints * for every 1000 files
> - * -q   Be quiet (suppress non-error output).
> - * -r   Use an alternate root path
> - * -s   Use stdin for a list of files instead of searching a partition.
> - * -v	Show changes in file labels.  
> - * -W   Warn about entries that have no matching file.
> - * -o filename write out file names with wrong context.
> - *
> - * spec_file	The specification file.
> - * pathname...	The file systems to label (omit if using -s).	
> - *
> - * EXAMPLE USAGE:
> - * ./setfiles -v file_contexts `mount | awk '/ext3/{print $3}'`
> - *
> - * SPECIFICATION FILE:
> - * Each specification has the form:
> - *       regexp [ -type ] ( context | <<none>> )
> - *
> - * By default, the regexp is an anchored match on both ends (i.e. a 
> - * caret (^) is prepended and a dollar sign ($) is appended automatically).
> - * This default may be overridden by using .* at the beginning and/or
> - * end of the regular expression.  
> - *
> - * The optional type field specifies the file type as shown in the mode
> - * field by ls, e.g. use -d to match only directories or -- to match only
> - * regular files.
> - * 
> - * The value of <<none> may be used to indicate that matching files
> - * should not be relabeled.
> - *
> - * The last matching specification is used.
> - *
> - * If there are multiple hard links to a file that match 
> - * different specifications and those specifications indicate
> - * different security contexts, then a warning is displayed
> - * but the file is still labeled based on the last matching
> - * specification other than <<none>>.
> - */
> -
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <fcntl.h>
> @@ -83,8 +25,9 @@
>  #define AUDIT_FS_RELABEL 2309
>  #endif
>  #endif
> +static int mass_relabel;
> +static int mass_relabel_errs;
>  
> -static int add_assoc = 1;
>  static FILE *outfile = NULL;
>  static int force = 0;
>  #define STAT_BLOCK_SIZE 1
> @@ -107,15 +50,28 @@
>  static int debug = 0;
>  static int change = 1;
>  static int quiet = 0;
> -static int use_stdin = 0;
> +static int ignore_enoent;
>  static int verbose = 0;
>  static int log = 0;
>  static int warn_no_match = 0;
>  static char *rootpath = NULL;
>  static int rootpathlen = 0;
> +static int recurse; /* Recursive descent. */
> +static int errors;
>  
>  static char *progname;
>  
> +#define SETFILES "setfiles"
> +#define RESTORECON "restorecon"
> +static int iamrestorecon;
> +
> +/* Behavior flags determined based on setfiles vs. restorecon */
> +static int expand_realpath;  /* Expand paths via realpath. */
> +static int abort_on_error; /* Abort the file tree walk upon an error. */
> +static int add_assoc; /* Track inode associations for conflict detection. */
> +static int nftw_flags; /* Flags to nftw, e.g. follow links, follow mounts */
> +static int matchpathcon_flags; /* Flags to matchpathcon */
> +
>  static void
>  #ifdef __GNUC__
>      __attribute__ ((format(printf, 1, 2)))
> @@ -132,6 +88,7 @@
>  static int add_exclude(const char *directory)
>  {
>  	struct stat sb;
> +	size_t len = 0;
>  	if (directory == NULL || directory[0] != '/') {
>  		fprintf(stderr, "Full path required for exclude: %s.\n",
>  			directory);
> @@ -155,12 +112,17 @@
>  		return 1;
>  	}
>  
> -	excludeArray[excludeCtr].directory = strdup(directory);
> -	if (!excludeArray[excludeCtr].directory) {
> +	len = strlen(directory);
> +	while (len > 1 && directory[len - 1] == '/') {
> +		len--;
> +	}
> +	excludeArray[excludeCtr].directory = strndup(directory, len);
> +
> +	if (excludeArray[excludeCtr].directory == NULL) {
>  		fprintf(stderr, "Out of memory.\n");
>  		return 1;
>  	}
> -	excludeArray[excludeCtr++].size = strlen(directory);
> +	excludeArray[excludeCtr++].size = len;
>  
>  	return 0;
>  }
> @@ -185,7 +147,79 @@
>  {
>  	int ret;
>  	const char *fullname = name;
> +	char path[PATH_MAX + 1];
>  
> +	if (excludeCtr > 0) {
> +		if (exclude(fullname)) {
> +			return -1;
> +		}
> +	}
> +	ret = lstat(fullname, sb);
> +	if (ret) {
> +		if (ignore_enoent && errno == ENOENT)
> +			return 0;
> +		fprintf(stderr, "%s:  unable to stat file %s: %s\n", progname,
> +			fullname, strerror(errno));
> +		return -1;
> +	}
> +
> +	if (expand_realpath) {
> +		if (S_ISLNK(sb->st_mode)) {
> +			if (verbose > 1)
> +				fprintf(stderr,
> +					"Warning! %s refers to a symbolic link, not following last component.\n",
> +					fullname);
> +			char *p = NULL, *file_sep;
> +			char *tmp_path = strdupa(fullname);
> +			size_t len = 0;
> +			if (!tmp_path) {
> +				fprintf(stderr, "strdupa on %s failed:  %s\n", fullname,
> +					strerror(errno));
> +				return -1;
> +			}
> +			file_sep = strrchr(tmp_path, '/');
> +			if (file_sep == tmp_path) {
> +				file_sep++;
> +				p = strcpy(path, "");
> +			} else if (file_sep) {
> +				*file_sep = 0;
> +				file_sep++;
> +				p = realpath(tmp_path, path);
> +			} else {
> +				file_sep = tmp_path;
> +				p = realpath("./", path);
> +			}
> +			if (p)
> +				len = strlen(p);
> +			if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
> +				fprintf(stderr, "realpath(%s) failed %s\n", fullname,
> +					strerror(errno));
> +				return -1;
> +			}
> +			p += len;
> +			/* ensure trailing slash of directory name */
> +			if (len == 0 || *(p - 1) != '/') {
> +				*p = '/';
> +				p++;
> +			}
> +			strcpy(p, file_sep);
> +			fullname = path;
> +			if (excludeCtr > 0 && exclude(fullname))
> +				return -1;
> +		} else {
> +			char *p;
> +			p = realpath(fullname, path);
> +			if (!p) {
> +				fprintf(stderr, "realpath(%s) failed %s\n", fullname,
> +					strerror(errno));
> +				return -1;
> +			}
> +			fullname = p;
> +			if (excludeCtr > 0 && exclude(fullname))
> +				return -1;
> +		}
> +	}
> +
>  	/* fullname will be the real file that gets labeled
>  	 * name will be what is matched in the policy */
>  	if (NULL != rootpath) {
> @@ -197,18 +231,6 @@
>  		name += rootpathlen;
>  	}
>  
> -	if (excludeCtr > 0) {
> -		if (exclude(fullname)) {
> -			return -1;
> -		}
> -	}
> -	ret = lstat(fullname, sb);
> -	if (ret) {
> -		fprintf(stderr, "%s:  unable to stat file %s\n", progname,
> -			fullname);
> -		return -1;
> -	}
> -
>  	if (rootpath != NULL && name[0] == '\0')
>  		/* this is actually the root dir of the alt root */
>  		return matchpathcon_index("/", sb->st_mode, con);
> @@ -218,11 +240,17 @@
>  
>  void usage(const char *const name)
>  {
> -	fprintf(stderr,
> -		"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
> -		"usage:  %s -c policyfile spec_file\n"
> -		"usage:  %s -s [-dnqvW] [-o filename ] spec_file\n", name, name,
> -		name);
> +	if (iamrestorecon) {
> +		fprintf(stderr,
> +			"usage:  %s [-iFnrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
> +			name);
> +	} else {
> +		fprintf(stderr,
> +			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
> +			"usage:  %s -c policyfile spec_file\n"
> +			"usage:  %s -s [-dnqvW] [-o filename ] spec_file\n", name, name,
> +			name);
> +	}
>  	exit(1);
>  }
>  
> @@ -253,39 +281,21 @@
>  	return (strcmp(rest_a, rest_b) == 0);
>  }
>  
> -/*
> - * Apply the last matching specification to a file.
> - * This function is called by nftw on each file during
> - * the directory traversal.
> - */
> -static int apply_spec(const char *file,
> -		      const struct stat *sb_unused __attribute__ ((unused)),
> -		      int flag, struct FTW *s_unused __attribute__ ((unused)))
> +static int restore(const char *file)
>  {
> -	const char *my_file;
> +	char *my_file = strdupa(file);
>  	struct stat my_sb;
>  	int i, j, ret;
>  	char *context, *newcon;
>  	int user_only_changed = 0;
> -	char buf[STAT_BLOCK_SIZE];
> -	if (pipe_fds[0] != -1
> -	    && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE) {
> -		fprintf(stderr, "Read error on pipe.\n");
> -		pipe_fds[0] = -1;
> -	}
> +	size_t len = strlen(my_file);
>  
> -	/* Skip the extra slash at the beginning, if present. */
> +	/* Skip the extra slashes at the beginning and end, if present. */
>  	if (file[0] == '/' && file[1] == '/')
> -		my_file = &file[1];
> -	else
> -		my_file = file;
> +		my_file++;
> +	if (len > 1 && my_file[len - 1] == '/')
> +		my_file[len - 1] = 0;
>  
> -	if (flag == FTW_DNR) {
> -		fprintf(stderr, "%s:  unable to read directory %s\n",
> -			progname, my_file);
> -		return 0;
> -	}
> -
>  	i = match(my_file, &my_sb, &newcon);
>  	if (i < 0)
>  		/* No matching specification. */
> @@ -330,10 +340,8 @@
>  		if (errno == ENODATA) {
>  			context = NULL;
>  		} else {
> -			perror(my_file);
> -			fprintf(stderr,
> -				"%s:  unable to obtain attribute for file %s\n",
> -				progname, my_file);
> +			fprintf(stderr, "%s get context on %s failed: '%s'\n",
> +				progname, my_file, strerror(errno));
>  			goto err;
>  		}
>  		user_only_changed = 0;
> @@ -346,7 +354,7 @@
>  	 * specification.
>  	 */
>  	if ((strcmp(newcon, "<<none>>") == 0) ||
> -	    (context && (strcmp(context, newcon) == 0))) {
> +	    (context && (strcmp(context, newcon) == 0) && !force)) {
>  		freecon(context);
>  		goto out;
>  	}
> @@ -366,12 +374,8 @@
>  		 * the user has changed but the role and type are the
>  		 * same.  For "-vv", emit everything. */
>  		if (verbose > 1 || !user_only_changed) {
> -			if (context)
> -				printf("%s:  relabeling %s from %s to %s\n",
> -				       progname, my_file, context, newcon);
> -			else
> -				printf("%s:  labeling %s to %s\n", progname,
> -				       my_file, newcon);
> +			printf("%s reset %s context %s->%s\n",
> +			       progname, my_file, context ?: "", newcon);
>  		}
>  	}
>  
> @@ -401,9 +405,8 @@
>  	 */
>  	ret = lsetfilecon(my_file, newcon);
>  	if (ret) {
> -		perror(my_file);
> -		fprintf(stderr, "%s:  unable to relabel %s to %s\n",
> -			progname, my_file, newcon);
> +		fprintf(stderr, "%s set context %s->%s failed:'%s'\n",
> +			progname, my_file, newcon, strerror(errno));
>  		goto out;
>  	}
>        out:
> @@ -414,6 +417,34 @@
>  	return -1;
>  }
>  
> +/*
> + * Apply the last matching specification to a file.
> + * This function is called by nftw on each file during
> + * the directory traversal.
> + */
> +static int apply_spec(const char *file,
> +		      const struct stat *sb_unused __attribute__ ((unused)),
> +		      int flag, struct FTW *s_unused __attribute__ ((unused)))
> +{
> +	char buf[STAT_BLOCK_SIZE];
> +	if (pipe_fds[0] != -1
> +	    && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE) {
> +		fprintf(stderr, "Read error on pipe.\n");
> +		pipe_fds[0] = -1;
> +	}
> +
> +	if (flag == FTW_DNR) {
> +		fprintf(stderr, "%s:  unable to read directory %s\n",
> +			progname, file);
> +		return 0;
> +	}
> +
> +	errors |= restore(file);
> +	if (abort_on_error && errors)
> +		return -1;
> +	return 0;
> +}
> +
>  void set_rootpath(const char *arg)
>  {
>  	int len;
> @@ -474,17 +505,85 @@
>  	return 0;
>  }
>  
> +static int process_one(char *name)
> +{
> +	struct stat sb;
> +	int rc;
> +
> +	if (!strcmp(name, "/"))
> +		mass_relabel = 1;
> +
> +	rc = lstat(name, &sb);
> +	if (rc < 0) {
> +		if (ignore_enoent && errno == ENOENT)
> +			return 0;
> +		fprintf(stderr, "%s:  stat error on %s:  %s\n",
> +			progname, name, strerror(errno));
> +		goto err;
> +	}
> +
> +	if (S_ISDIR(sb.st_mode) && recurse) {
> +		if (pipe(pipe_fds) < 0) {
> +			fprintf(stderr, "%s:  pipe error on %s:  %s\n",
> +				progname, name, strerror(errno));
> +			goto err;
> +		}
> +		rc = fork();
> +		if (rc < 0) {
> +			fprintf(stderr, "%s:  fork error on %s:  %s\n",
> +				progname, name, strerror(errno));
> +			goto err;
> +		}
> +		if (rc == 0) {
> +			/* Child:  pre-stat the files. */
> +			close(pipe_fds[0]);
> +			nftw(name, pre_stat, 1024, nftw_flags);
> +			exit(0);
> +		}
> +		/* Parent:  Check and label the files. */
> +		close(pipe_fds[1]);
> +		if (nftw(name, apply_spec, 1024, nftw_flags)) {
> +			fprintf(stderr,
> +				"%s:  error while labeling %s:  %s\n",
> +				progname, name, strerror(errno));
> +			goto err;
> +		}
> +	} else {
> +		rc = restore(name);
> +		if (rc)
> +			goto err;
> +	}
> +
> +	if (!strcmp(name, "/"))
> +		mass_relabel_errs = 0;
> +
> +out:
> +	if (add_assoc) {
> +		set_matchpathcon_printf(&qprintf);
> +		matchpathcon_filespec_eval();
> +		set_matchpathcon_printf(NULL);
> +		matchpathcon_filespec_destroy();
> +	}
> +
> +	return rc;
> +
> +err:
> +	if (!strcmp(name, "/"))
> +		mass_relabel_errs = 1;
> +	rc = -1;
> +	goto out;
> +}
> +
>  #ifndef USE_AUDIT
> -static void maybe_audit_mass_relabel(int done_root __attribute__ ((unused)),
> -				     int err __attribute__ ((unused)))
> +static void maybe_audit_mass_relabel(void)
>  {
>  #else
> -static void maybe_audit_mass_relabel(int done_root, int errs)
> +static void maybe_audit_mass_relabel(void)
>  {
>  	int audit_fd = -1;
>  	int rc = 0;
>  
> -	if (!done_root)		/* only audit a forced full relabel */
> +	if (!mass_relabel)		/* only audit a forced full relabel */
>  		return;
>  
>  	audit_fd = audit_open();
> @@ -495,7 +594,7 @@
>  	}
>  
>  	rc = audit_log_user_message(audit_fd, AUDIT_FS_RELABEL,
> -				    "op=mass relabel", NULL, NULL, NULL, !errs);
> +				    "op=mass relabel", NULL, NULL, NULL, !mass_relabel_errs);
>  	if (rc <= 0) {
>  		fprintf(stderr, "Error sending audit message: %s.\n",
>  			strerror(errno));
> @@ -508,21 +607,77 @@
>  int main(int argc, char **argv)
>  {
>  	struct stat sb;
> -	int opt, rc, i;
> -	int done_root = 0;	/* have we processed the / directory as an arg */
> +	int opt, rc, i = 0;
> +	char *input_filename = NULL;
> +	int use_input_file = 0;
> +	char *buf = NULL;
> +	size_t buf_len;
> +	char *base;
>  
>  	memset(excludeArray, 0, sizeof(excludeArray));
>  
> -	/* Validate all file contexts during matchpathcon_init. */
> -	set_matchpathcon_flags(MATCHPATHCON_VALIDATE | MATCHPATHCON_NOTRANS);
> +	progname = strdup(argv[0]);
> +	if (!progname) {
> +		fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
> +		exit(1);
> +	}
> +	base = basename(progname);
> +	
> +	if (!strcmp(base, SETFILES)) {
> +		/* 
> +		 * setfiles:  
> +		 * Recursive descent,
> +		 * Does not expand paths via realpath, 
> +		 * Aborts on errors during the file tree walk, 
> +		 * Try to track inode associations for conflict detection,
> +		 * Does not follow mounts,
> +		 * Validates all file contexts at init time. 
> +		 */
> +		iamrestorecon = 0;
> +		recurse = 1;
> +		expand_realpath = 0;
> +		abort_on_error = 1;
> +		add_assoc = 1;
> +		nftw_flags = FTW_PHYS | FTW_MOUNT;
> +		matchpathcon_flags = MATCHPATHCON_VALIDATE | MATCHPATHCON_NOTRANS;
> +	} else {
> +		/*
> +		 * restorecon:  
> +		 * No recursive descent unless -r/-R,
> +		 * Expands paths via realpath, 
> +		 * Do not abort on errors during the file tree walk,
> +		 * Do not try to track inode associations for conflict detection,
> +		 * Follows mounts,
> +		 * Does lazy validation of contexts upon use. 
> +		 */
> +		if (strcmp(base, RESTORECON)) 
> +			qprintf("Executed with an unrecognized name (%s), defaulting to %s behavior.\n", base, RESTORECON);
> +		iamrestorecon = 1;
> +		recurse = 0;
> +		expand_realpath = 1;
> +		abort_on_error = 0;
> +		add_assoc = 0;
> +		nftw_flags = FTW_PHYS;
> +		matchpathcon_flags = MATCHPATHCON_NOTRANS;
>  
> +		/* restorecon only:  silent exit if no SELinux.
> +		   Allows unconditional execution by scripts. */
> +		if (is_selinux_enabled() <= 0)
> +			exit(0);
> +	}
> +
> +	set_matchpathcon_flags(matchpathcon_flags);
> +
>  	/* Process any options. */
> -	while ((opt = getopt(argc, argv, "Fc:dlnpqrsvWe:o:")) > 0) {
> +	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW")) > 0) {
>  		switch (opt) {
>  		case 'c':
>  			{
>  				FILE *policystream;
>  
> +				if (iamrestorecon)
> +					usage(argv[0]);
> +
>  				policyfile = optarg;
>  
>  				policystream = fopen(policyfile, "r");
> @@ -557,10 +712,16 @@
>  			if (add_exclude(optarg))
>  				exit(1);
>  			break;
> -
> +		case 'f':
> +			use_input_file = 1;
> +			input_filename = optarg;
> +			break;			
>  		case 'd':
>  			debug = 1;
>  			break;
> +		case 'i':
> +			ignore_enoent = 1;
> +			break;
>  		case 'l':
>  			log = 1;
>  			break;
> @@ -571,6 +732,11 @@
>  			change = 0;
>  			break;
>  		case 'o':
> +			if (strcmp(optarg, "-") == 0) {
> +				outfile = stdout;
> +				break;
> +			}
> +
>  			outfile = fopen(optarg, "w");
>  			if (!outfile) {
>  				fprintf(stderr, "Error opening %s: %s\n",
> @@ -583,7 +749,12 @@
>  		case 'q':
>  			quiet = 1;
>  			break;
> +		case 'R':
>  		case 'r':
> +			if (iamrestorecon) {
> +				recurse = 1;
> +				break;
> +			}
>  			if (optind + 1 >= argc) {
>  				fprintf(stderr, "usage:  %s -r rootpath\n",
>  					argv[0]);
> @@ -598,7 +769,8 @@
>  			set_rootpath(argv[optind++]);
>  			break;
>  		case 's':
> -			use_stdin = 1;
> +			use_input_file = 1;
> +			input_filename = "-";
>  			add_assoc = 0;
>  			break;
>  		case 'v':
> @@ -625,128 +797,74 @@
>  		}
>  	}
>  
> -	if (policyfile) {
> -		if (optind != (argc - 1))
> -			usage(argv[0]);
> -	} else if (use_stdin) {
> -		if (optind != (argc - 1)) {
> -			/* Cannot mix with pathname arguments. */
> -			usage(argv[0]);
> +	if (!iamrestorecon) {
> +		if (policyfile) {
> +			if (optind != (argc - 1))
> +				usage(argv[0]);
> +		} else if (use_input_file) {
> +			if (optind != (argc - 1)) {
> +				/* Cannot mix with pathname arguments. */
> +				usage(argv[0]);
> +			}
> +		} else {
> +			if (optind > (argc - 2))
> +				usage(argv[0]);
>  		}
> -	} else {
> -		if (optind > (argc - 2))
> -			usage(argv[0]);
> -	}
>  
> -	/* Use our own invalid context checking function so that
> -	   we can support either checking against the active policy or
> -	   checking against a binary policy file. */
> -	set_matchpathcon_canoncon(&canoncon);
> +		/* Use our own invalid context checking function so that
> +		   we can support either checking against the active policy or
> +		   checking against a binary policy file. */
> +		set_matchpathcon_canoncon(&canoncon);
>  
> -	if (stat(argv[optind], &sb) < 0) {
> -		perror(argv[optind]);
> -		exit(1);
> -	}
> -	if (!S_ISREG(sb.st_mode)) {
> -		fprintf(stderr, "%s:  spec file %s is not a regular file.\n",
> -			argv[0], argv[optind]);
> -		exit(1);
> -	}
> +		if (stat(argv[optind], &sb) < 0) {
> +			perror(argv[optind]);
> +			exit(1);
> +		}
> +		if (!S_ISREG(sb.st_mode)) {
> +			fprintf(stderr, "%s:  spec file %s is not a regular file.\n",
> +				argv[0], argv[optind]);
> +			exit(1);
> +		}
>  
> -	/* Load the file contexts configuration and check it. */
> -	rc = matchpathcon_init(argv[optind]);
> -	if (rc < 0) {
> -		perror(argv[optind]);
> -		exit(1);
> -	}
> -
> -	optind++;
> -
> -	if (nerr)
> -		exit(1);
> -
> -	/*
> -	 * Apply the specifications to the file systems.
> -	 */
> -	progname = argv[0];
> -	if (use_stdin) {
> -		char buf[PATH_MAX];
> -		while (fgets(buf, sizeof(buf), stdin)) {
> -			struct stat sb;
> -			strtok(buf, "\n");
> -			if (buf[0] != '\n') {
> -				if (lstat(buf, &sb))
> -					fprintf(stderr,
> -						"File \"%s\" not found.\n",
> -						buf);
> -				else {
> -					int flag;
> -					switch (sb.st_mode) {
> -					case S_IFDIR:
> -						flag = FTW_D;
> -						break;
> -					case S_IFLNK:
> -						flag = FTW_SL;
> -						break;
> -					default:
> -						flag = FTW_F;
> -					}
> -					apply_spec(buf, &sb, flag, NULL);
> -				}
> -			}
> +		/* Load the file contexts configuration and check it. */
> +		rc = matchpathcon_init(argv[optind]);
> +		if (rc < 0) {
> +			perror(argv[optind]);
> +			exit(1);
>  		}
> -	} else
> -		for (; optind < argc; optind++) {
> -			done_root |= !strcmp(argv[optind], "/");
>  
> -			if (NULL != rootpath) {
> -				qprintf
> -				    ("%s:  labeling files, pretending %s is /\n",
> -				     argv[0], rootpath);
> -			}
> +		optind++;
>  
> -			qprintf("%s:  labeling files under %s\n", argv[0],
> -				argv[optind]);
> +		if (nerr)
> +			exit(1);
> +	}
>  
> -			int rc;
> -			if (pipe(pipe_fds) == -1)
> -				rc = -1;
> -			else
> -				rc = fork();
> -			if (rc == 0) {
> -				close(pipe_fds[0]);
> -				nftw(argv[optind], pre_stat, 1024, FTW_PHYS);
> -				exit(1);
> -			}
> -			if (rc > 0)
> -				close(pipe_fds[1]);
> -			if (rc == -1 || rc > 0) {
> -
> -				/* Walk the file tree, calling apply_spec on each file. */
> -				if (nftw
> -				    (argv[optind], apply_spec, 1024,
> -				     FTW_PHYS | FTW_MOUNT)) {
> -					fprintf(stderr,
> -						"%s:  error while labeling files under %s\n",
> -						argv[0], argv[optind]);
> -					maybe_audit_mass_relabel(done_root, 1);
> -					exit(1);
> -				}
> -			}
> -
> -			/*
> -			 * Evaluate the association hash table distribution for the
> -			 * directory tree just traversed.
> -			 */
> -			set_matchpathcon_printf(&qprintf);
> -			matchpathcon_filespec_eval();
> -			set_matchpathcon_printf(NULL);
> -
> -			/* Reset the association hash table for the next directory tree. */
> -			matchpathcon_filespec_destroy();
> +	if (use_input_file) {
> +		FILE *f = stdin;
> +		ssize_t len;
> +		if (strcmp(input_filename, "-") != 0)
> +			f = fopen(input_filename, "r");
> +		if (f == NULL) {
> +			fprintf(stderr, "Unable to open %s: %s\n", input_filename,
> +				strerror(errno));
> +			usage(argv[0]);
>  		}
> +		__fsetlocking(f, FSETLOCKING_BYCALLER);
> +		while ((len = getline(&buf, &buf_len, f)) > 0) {
> +			buf[len - 1] = 0;
> +			errors |= process_one(buf);
> +		}
> +		if (strcmp(input_filename, "-") != 0)
> +			fclose(f);
> +	} else {
> +		if (optind >= argc)
> +			usage(argv[0]);
> +		for (i = optind; i < argc; i++) {
> +			errors |= process_one(argv[i]);
> +		}
> +	}
>  
> -	maybe_audit_mass_relabel(done_root, 0);
> +	maybe_audit_mass_relabel();
>  
>  	if (warn_no_match)
>  		matchpathcon_checkmatches(argv[0]);
> @@ -758,7 +876,5 @@
>  		free(excludeArray[i].directory);
>  	}
>  
> -	qprintf("%s:  Done.\n", argv[0]);
> -
> -	exit(0);
> +	exit(errors);
>  }
> Index: trunk/policycoreutils/setfiles/restorecon.8
> ===================================================================
> --- trunk/policycoreutils/setfiles/restorecon.8	(revision 0)
> +++ trunk/policycoreutils/setfiles/restorecon.8	(revision 0)
> @@ -0,0 +1,68 @@
> +.TH "restorecon" "8" "2002031409" "" ""
> +.SH "NAME"
> +restorecon \- restore file(s) default SELinux security contexts.
> +
> +.SH "SYNOPSIS"
> +.B restorecon
> +.I [\-o outfilename ] [\-R] [\-n] [\-v] [\-e directory ] pathname...
> +.P
> +.B restorecon
> +.I \-f infilename [\-o outfilename ] [\-e directory ] [\-R] [\-n] [\-v] [\-F]
> +
> +.SH "DESCRIPTION"
> +This manual page describes the
> +.BR restorecon
> +program.
> +.P
> +This program is primarily used to set the security context
> +(extended attributes) on one or more files. 
> +.P
> +It can be run at any time to correct errors, to add support for
> +new policy, or with the \-n option it can just check whether the file
> +contexts are all as you expect.
> +
> +.SH "OPTIONS"
> +.TP 
> +.B \-i
> +ignore files that do not exist
> +.TP 
> +.B \-f infilename
> +infilename contains a list of files to be processed by application. Use \- for stdin.
> +.TP 
> +.B \-e directory
> +directory to exclude (repeat option for more than one directory.)
> +.TP 
> +.B \-R \-r
> +change files and directories file labels recursively
> +.TP 
> +.B \-n
> +don't change any file labels.
> +.TP 
> +.B \-o outfilename
> +save list of files with incorrect context in outfilename.
> +.TP 
> +.B \-v
> +show changes in file labels.
> +.TP 
> +.B \-vv
> +show changes in file labels, if type, role, or user are changing.
> +.TP 
> +.B \-F
> +Force reset of context to match file_context for customizable files, or the user section, if it has changed. 
> +.TP 
> +.SH "ARGUMENTS"
> +.B pathname...
> +The pathname for the file(s) to be relabeled. 
> +.SH NOTE
> +restorecon does not follow symbolic links.
> +
> +.SH "AUTHOR"
> +This man page was written by Dan Walsh <dwalsh@redhat.com>.
> +Some of the content of this man page was taken from the setfiles 
> +man page written by Russell Coker <russell@coker.com.au>.
> +The program was written by Dan Walsh <dwalsh@redhat.com>.
> +
> +.SH "SEE ALSO"
> +.BR load_policy (8),
> +.BR checkpolicy (8)
> +.BR setfiles (8)
> Index: trunk/policycoreutils/setfiles/Makefile
> ===================================================================
> --- trunk/policycoreutils/setfiles/Makefile	(revision 2429)
> +++ trunk/policycoreutils/setfiles/Makefile	(working copy)
> @@ -15,18 +15,22 @@
>  	LDLIBS += -laudit
>  endif
>  
> -all: setfiles
> +all: setfiles restorecon
>  
>  setfiles:  setfiles.o 
>  
> +restorecon: setfiles
> +	ln -sf setfiles restorecon
> +
>  install: all
>  	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
>  	-mkdir -p $(SBINDIR)
>  	install -m 755 setfiles $(SBINDIR)
> -	install -m 644 setfiles.8 $(MANDIR)/man8
> +	(cd $(SBINDIR) && ln -sf setfiles restorecon)
> +	install -m 644 setfiles.8 restorecon.8 $(MANDIR)/man8
>  
>  clean:
> -	rm -f setfiles *.o 
> +	rm -f setfiles restorecon *.o 
>  
>  indent:
>  	../../scripts/Lindent $(wildcard *.[ch])
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
