Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8RMP10I022180
 for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2015 18:25:01 -0400
Received: by wicgb1 with SMTP id gb1so80903678wic.1
 for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2015 15:24:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443355590-14467-1-git-send-email-richard_c_haines@btinternet.com>
References: <1443355590-14467-1-git-send-email-richard_c_haines@btinternet.com>
Date: Mon, 28 Sep 2015 01:24:55 +0300
Message-ID: <CAMRbyysbJh9jRzoZT=my1vAJYy6PnR3k3dk15PmhT=FVNJHcAw@mail.gmail.com>
Subject: Re: [RFC PATCH V2] libselinux: Add selinux_restorecon function
From: Nir Soffer <nsoffer@redhat.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7ba982d4de1b4f0520c20cd2
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7ba982d4de1b4f0520c20cd2
Content-Type: text/plain; charset=UTF-8

On Sun, Sep 27, 2015 at 3:06 PM, Richard Haines <
richard_c_haines@btinternet.com> wrote:

> The selinux_restorecon(3) man page details this function that relies
> on the selabel_digest(3) function available from [1] (as not yet
> part of upstream libselinux).
>
> It has been built using the work from Android where an SHA1 hash
> of the specfiles is held in an extended attribute to enhance
> performance. Also contains components from policycoreutils/setfiles.
>
> The utils/selinux_restorecon.c utility demonstrates the functionality.
>
> [1] http://marc.info/?l=selinux&m=144274383217343&w=2
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes:
> Added exclude_list to function, updated util to test and man page
> Fixed xdev to use fts correctly.
>
>  libselinux/include/selinux/selinux.h     |  28 ++
>  libselinux/man/man3/selinux_restorecon.3 | 200 ++++++++++++++
>  libselinux/src/Makefile                  |   2 +-
>  libselinux/src/selinux_restorecon.c      | 443
> +++++++++++++++++++++++++++++++
>  libselinux/utils/Makefile                |   2 +
>  libselinux/utils/selinux_restorecon.c    | 215 +++++++++++++++
>  6 files changed, 889 insertions(+), 1 deletion(-)
>  create mode 100644 libselinux/man/man3/selinux_restorecon.3
>  create mode 100644 libselinux/src/selinux_restorecon.c
>  create mode 100644 libselinux/utils/selinux_restorecon.c
>
> diff --git a/libselinux/include/selinux/selinux.h
> b/libselinux/include/selinux/selinux.h
> index 4beb170..c5228a6 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -663,6 +663,34 @@ extern int selinux_lsetfilecon_default(const char
> *path);
>   */
>  extern void selinux_reset_config(void);
>
> +
> +/* Force the checking of labels even if the stored SHA1
> + * digest matches the specfiles SHA1 digest. */
> +#define SELINUX_RESTORECON_FORCE_CHECK         1
> +/* Do not change file labels */
> +#define SELINUX_RESTORECON_NOCHANGE                    2
> +/* If set change the files label to that in spec file.
> + * If not set only change the type component to that in spec file. */
> +#define SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL    4
> +/* Reset customizable types */
> +#define SELINUX_RESTORECON_CHANGE_CUSTOMIZABLE         8
> +/* Recurse through the directory path */
> +#define SELINUX_RESTORECON_RECURSE                     16
> +/* Log changes and show specfiles SHA1 digest */
> +#define SELINUX_RESTORECON_VERBOSE                     32
> +/* Set selabel_open(3) option SELABEL_OPT_VALIDATE */
> +#define SELINUX_RESTORECON_VALIDATE                    64
> +/* Convert passed-in pathname to canonical pathname */
> +#define SELINUX_RESTORECON_REALPATH                    128
> +/* Prevent descending into directories that have a different
> + * device number than the pathname from which the descent began */
> +#define SELINUX_RESTORECON_XDEV                                256
> +
> +extern int selinux_restorecon(const char **pathname_list,
> +                                   const char **exclude_list,
> +                                   const char *fc_path,
> +                                   unsigned int restorecon_flags);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/libselinux/man/man3/selinux_restorecon.3
> b/libselinux/man/man3/selinux_restorecon.3
> new file mode 100644
> index 0000000..3dfdbd3
> --- /dev/null
> +++ b/libselinux/man/man3/selinux_restorecon.3
> @@ -0,0 +1,200 @@
> +.TH "selinux_restorecon" "3" "22 Sept 2015" "Security Enhanced Linux"
> "SELinux API documentation"
> +
> +.SH "NAME"
> +selinux_restorecon \- restore file(s) default SELinux security contexts
> +.
> +.SH "SYNOPSIS"
> +.B #include <selinux/selinux.h>
> +.sp
> +.BI "int selinux_restorecon(const char **" pathname_list ,
> +.in +\w'int selinux_restorecon('u
> +.BI "const char **" exclude_list ,
> +.br
> +.BI "const char *" fc_path ,
> +.br
> +.BI "unsigned int " restorecon_flags ");"
> +.in
> +.
> +.SH "DESCRIPTION"
> +.BR selinux_restorecon ()
> +restores file default security contexts based on:
> +.sp
> +.RS
> +.IR pathname_list
> +containing a
> +.B NULL
> +terminated list of one or more directories or files to be relabeled.
> +.br
> +If the
> +.IR restorecon_flags
> +.B SELINUX_RESTORECON_RECURSE
> +has been set (for decending through directories), then for each
> +.IR pathname_list
> +entry specified
> +.BR selinux_restorecon ()
> +will write an SHA1 digest of the combined specfiles (see the
> +.B NOTES
> +section for details) to an extended attribute of
> +.IR security.restorecon_last
> +once the relabeling has been completed successfully. This digest will be
> +checked should
> +.BR selinux_restorecon ()
> +be rerun
> +with the
> +.IR restorecon_flags
> +.B SELINUX_RESTORECON_RECURSE
> +flag set. If any of the specfiles had been updated, the digest
> +will also be updated. However if the digest is the same, no relabeling
> checks
> +will take place unless the
> +.IR restorecon_flags
> +.B SELINUX_ANDROID_RESTORECON_FORCE_CHECK
> +flag is also set.
> +.sp
> +.IR exclude_list
> +containing a
> +.B NULL
> +terminated list of zero or more directories or files that are not to be
> +relabeled.
> +.sp
> +.IR fc_path
> +containing an optional specfile to provide the file labeling
> +details (see
> +.BR selabel_file (5)
> +for details of the file format).
> +.br
> +If set to
> +.B NULL
> +then the currently loaded policy specfiles will be used.
> +.sp
> +.IR restorecon_flags
> +contains the labeling option/rules as follows:
> +.sp
> +.RS
> +.B SELINUX_ANDROID_RESTORECON_FORCE_CHECK
> +force the checking of labels even if the stored SHA1 digest matches the
> +specfiles SHA1 digest.
> +.sp
> +.B SELINUX_RESTORECON_NOCHANGE
> +don't change any file labels (passive check).
> +.sp
> +.B SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL
> +if set, reset the files label to match the default specfile context
> +(i.e. change user, role, type and range).
> +.br
> +If not set, then only reset the files "type" component of the context to
> +match the default specfile context.
> +.sp
> +.B SELINUX_RESTORECON_CHANGE_CUSTOMIZABLE
> +reset customized file labels (see
> +.BR is_context_customizable (3))
> +to match the default specfile context. Use the
> +.B SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL
> +flag to determine the components to change.
> +.sp
> +.B SELINUX_RESTORECON_VERBOSE
> +show changes in file labels and display the SHA1 digests in hex format.
> +.sp
> +.B SELINUX_RESTORECON_RECURSE
> +change file and directory labels recursively (descend directories)
> +and if successful write an SHA1 digest of the combined specfiles to an
> +extended attribute as described in the
> +.B NOTES
> +section.
> +.sp
> +.B SELINUX_RESTORECON_VALIDATE
> +set the global
> +.B SELABEL_OPT_VALIDATE
> +option that will cause the security contexts in the specfiles to be
> +validated against policy as described in
> +.BR selabel_open (3).
> +.br
> +Note that if custom context validation is required, the caller is
> responsible
> +for setting this up as described in
> +.BR selinux_set_callback (3).
> +.sp
> +.B SELINUX_RESTORECON_REALPATH
> +convert passed-in pathnames from
> +.IR pathname_list
> +to canonical pathnames using
> +.BR realpath (3).
> +.sp
> +.B SELINUX_RESTORECON_XDEV
> +prevent descending into directories that have a different device number
> than
> +the
> +.IR pathname_list
> +entry from which the descent began.
> +.RE
> +.RE
> +.
> +.SH "RETURN VALUE"
> +On success, zero is returned.  On error, \-1 is returned and
> +.I errno
> +is set appropriately.
> +.
> +.SH "NOTES"
> +To improve performance when relabeling file systems recursively (e.g. the
> +.IR restorecon_flags
> +.B SELINUX_RESTORECON_RECURSE
> +flag is set)
> +.BR selinux_restorecon ()
> +will write an SHA1 digest of the specfiles that are processed by
> +.BR selabel_open (3)
> +to an extended attribute named
> +.IR security.restorecon_last
> +for each entry in the
> +.IR pathname_list
> +(these are normally top level directories). Note that if an entry is a
> file,
> +then this would also have this extended attribute added (it is therefore
> +recomended that setting
> +.B SELINUX_RESTORECON_RECURSE
> +when relabeling a specific file should be avoided).
> +.sp
> +To check the extended attribute entry use
> +.BR getfattr (1) ,
> +for example:
> +.sp
> +.RS
> +getfattr -e hex -n security.restorecon_last /
> +.RE
> +.sp
> +The SHA1 digest is calculated by
> +.BR selabel_open (3)
> +concatenating the specfiles it reads during initialisation with the
> +resulting digest and list of specfiles being retrieved by
> +.BR selabel_digest (3).
> +.sp
> +The specfiles consist of the mandatory
> +.I file_contexts
> +file plus any subs, subs_dist, local and homedir entries (text or binary
> versions)
> +as determined by any
> +.BR selabel_open (3)
> +options e.g.
> +.BR SELABEL_OPT_BASEONLY .
> +.sp
> +Should any of the specfiles have changed, then when
> +.BR selinux_restorecon ()
> +is run again with the
> +.B SELINUX_RESTORECON_RECURSE
> +flag set, a new SHA1 digest will be calculated and all files will be
> automatically
> +relabeled depending on the settings of the
> +.B SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL
> +and
> +.B SELINUX_RESTORECON_CHANGE_CUSTOMIZABLE
> +flags (provided
> +.B SELINUX_RESTORECON_NOCHANGE
> +is not set).
> +.sp
> +.B /sys
> +and in-memory filesystems do not support the
> +.IR security.restorecon_last
> +extended attribute.
> +.sp
> +.BR selinux_restorecon ()
> +does not check whether the mounted filesystems support the
> +.B seclabel
> +option. These should be set by the caller in the
> +.IR exclude_list .
> +.
> +.SH "SEE ALSO"
> +.BR restorecon (8),
> +.BR setfiles (8)
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 2a0e889..e07c6bd 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -72,7 +72,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k
> -Wformat-security -Winit-self -Wmissi
>            -fipa-pure-const -Wno-suggest-attribute=pure
> -Wno-suggest-attribute=const \
>            -Werror -Wno-aggregate-return -Wno-redundant-decls
>
> -override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
> +override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(EMFLAGS)
>
>  SWIG_CFLAGS += -Wno-error -Wno-unused-variable
> -Wno-unused-but-set-variable -Wno-unused-parameter \
>                 -Wno-shadow -Wno-uninitialized -Wno-missing-prototypes
> -Wno-missing-declarations
> diff --git a/libselinux/src/selinux_restorecon.c
> b/libselinux/src/selinux_restorecon.c
> new file mode 100644
> index 0000000..653572e
> --- /dev/null
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -0,0 +1,443 @@
> +/*
> + * The majority of this code is from Android's
> + * external/libselinux/src/android.c and upstream
> + * selinux/policycoreutils/setfiles/restorecon.c
> + *
> + * See selinux_restorecon(3) for details.
> + */
> +
> +#include <unistd.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <ctype.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <fts.h>
> +#include <limits.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/xattr.h>
> +#include <sys/vfs.h>
> +#include <linux/magic.h>
> +#include <selinux/selinux.h>
> +#include <selinux/context.h>
> +#include <selinux/label.h>
> +
> +#include "callbacks.h"
> +#include "selinux_internal.h"
> +
> +#define RESTORECON_LAST "security.restorecon_last"
> +
> +#define SYS_PATH "/sys"
> +#define SYS_PREFIX SYS_PATH "/"
> +
> +static struct selabel_handle *fc_sehandle;
> +
> +#define NUM_SELABEL_OPTS 4
> +static struct selinux_opt fc_opts[] = {
> +       { SELABEL_OPT_PATH, NULL },
> +       { SELABEL_OPT_BASEONLY, NULL },
> +       { SELABEL_OPT_VALIDATE, NULL },
> +       { SELABEL_OPT_DIGEST, NULL } };
> +
> +/*
> + * This is called if SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL is not
> set
> + * to check if the type components differ, updating newtypecon if so.
> + */
> +static int compare_types(char *curcon, char *newcon, char **newtypecon)
> +{
> +       int types_differ = 0;
> +       context_t cona;
> +       context_t conb;
> +       int rc = 0;
> +
> +       cona = context_new(curcon);
> +       if (!cona) {
> +               rc = -1;
> +               goto out;
> +       }
> +       conb = context_new(newcon);
> +       if (!conb) {
> +               context_free(cona);
> +               rc = -1;
> +               goto out;
> +       }
> +
> +       types_differ = strcmp(context_type_get(cona),
> context_type_get(conb));
> +       if (types_differ) {
> +               rc |= context_user_set(conb, context_user_get(cona));
> +               rc |= context_role_set(conb, context_role_get(cona));
> +               rc |= context_range_set(conb, context_range_get(cona));
> +               if (!rc) {
> +                       *newtypecon = strdup(context_str(conb));
> +                       if (!*newtypecon) {
> +                               rc = -1;
> +                               goto err;
> +                       }
> +               }
> +       }
> +
> +err:
> +       context_free(cona);
> +       context_free(conb);
> +out:
> +       return rc;
> +}
> +
> +static int restorecon_sb(const char *pathname, const struct stat *sb,
> +                                   bool nochange, bool verbose,
> +                                   bool customizable, bool changecontext)
> +{
> +       char *newcon = NULL;
> +       char *curcon = NULL;
> +       char *newtypecon = NULL;
> +       int rc = 0;
> +       bool updated = false;
> +
> +       if (selabel_lookup_raw(fc_sehandle, &newcon, pathname,
> sb->st_mode) < 0)
> +               return 0; /* no match, but not an error */
> +
> +       if (lgetfilecon_raw(pathname, &curcon) < 0)
> +               goto err;
>
+
> +       if (strcmp(curcon, newcon) != 0) {
> +               if (!customizable && (is_context_customizable(curcon) >
> 0)) {
> +                       if (verbose) {
> +                               selinux_log(SELINUX_INFO,
> +                                "%s not reset as customized by admin to
> %s\n",
> +                                                           pathname,
> curcon);
> +                                       goto out;
> +                       }
> +               }
> +
> +               if (!nochange && changecontext) {
> +                       if (lsetfilecon(pathname, newcon) < 0)
> +                               goto err;
> +                       updated = true;
> +               } else if (nochange && changecontext) {
> +                       updated = true;
> +               } else if (!changecontext) {
> +                       /* If types different then update newcon. */
> +                       rc = compare_types(curcon, newcon, &newtypecon);
> +                       if (rc)
> +                               goto err;
> +
> +                       if (newtypecon) {
> +                               freecon(newcon);
> +                               newcon = newtypecon;
> +                               if (!nochange) {
> +                                       if (lsetfilecon(pathname, newcon)
> < 0)
> +                                               goto err;
> +                               }
> +                               updated = true;
> +                       }
> +               }
>
+
> +               if (verbose && updated)
> +                       selinux_log(SELINUX_INFO,
> +                                   "%s %s from %s to %s.\n",
> +                                   nochange ? "Would relabel" :
> "Relabeled",
> +                                   pathname, curcon, newcon);
> +       }
> +
> +out:
> +       rc = 0;
> +out1:
> +       freecon(curcon);
> +       freecon(newcon);
> +       return rc;
> +err:
> +       selinux_log(SELINUX_ERROR,
> +                   "Could not set context for %s:  %s\n",
> +                   pathname, strerror(errno));
> +       rc = -1;
> +       goto out1;
> +}
> +
> +static int check_excluded(const char *file, const char **exclude_list)
> +{
> +       int i;
> +
> +       for (i = 0; exclude_list[i]; i++) {
> +               if (strcmp(file, exclude_list[i]) == 0)
> +                               return 1;
> +       }
> +       return 0;
> +}
> +
> +int selinux_restorecon(const char **pathname_list, const char
> **exclude_list,
> +                                           const char *fc_path,
> +                                           unsigned int restorecon_flags)
> +{
> +       bool force = (restorecon_flags &
> +                  SELINUX_RESTORECON_FORCE_CHECK) ? true : false;
> +       bool nochange = (restorecon_flags &
> +                  SELINUX_RESTORECON_NOCHANGE) ? true : false;
> +       bool customizable = (restorecon_flags &
> +                  SELINUX_RESTORECON_CHANGE_CUSTOMIZABLE) ? true : false;
> +       /* true = change file label to specfile entry,
> +        * false = only change type component. */
> +       bool changecontext = (restorecon_flags &
> +                  SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL) ? true :
> false;
> +       bool verbose = (restorecon_flags &
> +                  SELINUX_RESTORECON_VERBOSE) ? true : false;
> +       bool recurse = (restorecon_flags &
> +                  SELINUX_RESTORECON_RECURSE) ? true : false;
> +       bool validate = (restorecon_flags &
> +                  SELINUX_RESTORECON_VALIDATE) ? true : false;
> +       bool userealpath = (restorecon_flags &
> +                  SELINUX_RESTORECON_REALPATH) ? true : false;
> +       bool xdev = (restorecon_flags &
> +                  SELINUX_RESTORECON_XDEV) ? true : false;
> +       bool issys;
> +       bool setrestoreconlast = true;
> +       struct stat sb;
> +       struct statfs sfsb;
> +       FTS *fts = NULL;
> +       FTSENT *ftsent;
> +       char *pathname = NULL;
> +       char *paths[2] = { NULL , NULL };
> +       int fts_flags = 0, error = 0, i;
> +       char **specfiles = NULL;
> +       unsigned char *digest = NULL;
> +       int digest_len, num_specfiles;
> +       unsigned char *xattr_value = NULL;
> +       char *sha1_buf = NULL;
> +       ssize_t size, entry;
> +
> +       if (!pathname_list) {
> +               selinux_log(SELINUX_INFO, "No pathnames given.\n");
> +               errno = EINVAL;
> +               return -1;
> +       }
> +
> +       if (is_selinux_enabled() <= 0)
> +               return 0;
>

Why fake a success when the function did nothing?

It seems that no other function (e.g. lsetfilecon) check if selinux is
enabled. Why it is ok to
set some selinux context using lsetfilecon, and not ok to get the default
context and set it
using restorecon?


> +
> +       i = NUM_SELABEL_OPTS;
> +       while (i--) {
> +               switch (fc_opts[i].type) {
> +               case SELABEL_OPT_PATH:
> +                       fc_opts[i].value = fc_path;
> +                       break;
> +               case SELABEL_OPT_BASEONLY:
> +                       fc_opts[i].value = NULL;
> +                       break;
> +               case SELABEL_OPT_VALIDATE:
> +                       fc_opts[i].value = (validate ? (char *)1 : NULL);
> +                       break;
> +               case SELABEL_OPT_DIGEST:
> +                       fc_opts[i].value = (char *)1; /* Must request
> digest */
> +                       break;
> +               }
> +       }
> +
> +       fc_sehandle = selabel_open(SELABEL_CTX_FILE, fc_opts,
> NUM_SELABEL_OPTS);
> +       if (!fc_sehandle) {
> +               selinux_log(SELINUX_ERROR,
> +                           "Error obtaining file context handle: %s\n",
> +                                                   strerror(errno));
> +               return -1;
> +       }
> +
> +       if (selabel_digest(fc_sehandle, &digest, &digest_len,
> +                                   &specfiles, &num_specfiles) < 0) {
> +               selinux_log(SELINUX_ERROR,
> +                           "Error reading specfiles digest: %s\n",
> +                                                   strerror(errno));
> +               selabel_close(fc_sehandle);
> +               return -1;
> +       }
> +
> +       xattr_value = malloc(digest_len);
> +       if (!xattr_value)
> +               return -1;
> +
> +       if (verbose) {
> +               sha1_buf = malloc(digest_len * 2 + 1);
> +               if (!sha1_buf)
> +                       return -1;
> +
> +               for (i = 0; i < digest_len; i++)
> +                       sprintf((&sha1_buf[i * 2]), "%02x", digest[i]);
> +
> +               selinux_log(SELINUX_INFO,
> +                           "specfiles SHA1 digest: %s\n", sha1_buf);
> +               selinux_log(SELINUX_INFO,
> +                           "calculated using the following
> specfile(s):\n");
> +               if (specfiles) {
> +                       for (i = 0; i < num_specfiles; i++)
> +                               selinux_log(SELINUX_INFO,
> +                                           "%s\n", specfiles[i]);
> +               }
> +       }
> +
> +       if (xdev)
> +               fts_flags = FTS_PHYSICAL | FTS_XDEV;
> +       else
> +               fts_flags = FTS_PHYSICAL;
> +
> +       for (entry = 0; pathname_list[entry]; entry++) {
> +               /* Need to reset as could have been set false */
> +               setrestoreconlast = true;
> +
> +               /* Convert passed-in pathname to canonical form if
> required. */
> +               if (userealpath == true) {
> +                       pathname = realpath(pathname_list[entry], NULL);
> +                       if (!pathname) {
> +                               selinux_log(SELINUX_ERROR,
> +                                   "Could not get canonical path %s:
> %s.\n",
> +                                   pathname_list[entry], strerror(errno));
> +                               error = -1;
> +                               goto cleanup;
> +                       }
> +               } else {
> +                       pathname = strdup(pathname_list[entry]);
> +                       if (lstat(pathname, &sb) < 0) {
> +                               selinux_log(SELINUX_ERROR,
> +                                   "Could not stat: %s %s.\n",
> +                                   pathname_list[entry], strerror(errno));
> +                               error = -1;
> +                               goto cleanup;
> +                       }
> +               }
> +
> +               paths[0] = pathname;
> +               issys = (!strcmp(pathname, SYS_PATH)
> +                           || !strncmp(pathname, SYS_PREFIX,
> +                           sizeof(SYS_PREFIX) - 1)) ? true : false;
> +
> +               if (!recurse) {
> +                       error = restorecon_sb(pathname, &sb, nochange,
> +                                           verbose, customizable,
> +                                           changecontext);
> +                       goto cleanup;
> +               }
> +
> +               /* Ignore /sys since it is regenerated on each boot. */
> +               if (issys)
> +                       setrestoreconlast = false;
> +
> +               /* Ignore files on in-memory filesystems */
> +               if (statfs(pathname, &sfsb) == 0) {
> +                       if (sfsb.f_type == RAMFS_MAGIC ||
> +                                           sfsb.f_type == TMPFS_MAGIC)
> +                               setrestoreconlast = false;
> +               }
> +
> +               if (setrestoreconlast) {
> +                       size = getxattr(pathname, RESTORECON_LAST,
> xattr_value,
> +
> digest_len);
> +
> +                       if (size < 0 && errno == ENOTSUP)
> +                               continue;
> +
> +                       if (verbose && size == digest_len) {
> +                               for (i = 0; i < digest_len; i++)
> +                                       sprintf(&(sha1_buf[i * 2]), "%02x",
> +
>  xattr_value[i]);
> +                               selinux_log(SELINUX_INFO,
> +                                           "Entry: %s has SHA1 digest:
> %s\n",
> +                                                  pathname, sha1_buf);
> +                       } else if (verbose && size != digest_len) {
> +                               selinux_log(SELINUX_INFO,
> +                                   "Entry: %s has no valid SHA1 digest\n",
> +
>  pathname);
> +                       }
> +
> +                       if (!force && size == digest_len &&
> +                                          memcmp(digest, xattr_value,
> +                                          digest_len) == 0) {
> +                               selinux_log(SELINUX_INFO,
> +                                          "Skipping recursive entry:
> %s\n",
> +                                          pathname);
> +                               error = 0;
> +                               goto cleanup;
> +                       }
> +               }
> +
> +               fts = fts_open(paths, fts_flags, NULL);
> +               if (!fts) {
> +                       selinux_log(SELINUX_ERROR,
> +                                   "FTS open error: %s.\n",
> strerror(errno));
> +                       error = -1;
> +                       goto cleanup;
> +               }
> +
> +               error = 0;
> +               while ((ftsent = fts_read(fts)) != NULL) {
> +                       switch (ftsent->fts_info) {
> +                       case FTS_DC:
> +                               selinux_log(SELINUX_ERROR,
> +                                       "Directory cycle on %s.\n",
> +
>  ftsent->fts_path);
> +                               errno = ELOOP;
> +                               error = -1;
> +                               (void) fts_close(fts);
> +                               goto cleanup;
> +                       case FTS_DP:
> +                               continue;
> +                       case FTS_DNR:
> +                               selinux_log(SELINUX_ERROR,
> +                                       "Could not read %s: %s.\n",
> +                                           ftsent->fts_path,
> strerror(errno));
> +                               fts_set(fts, ftsent, FTS_SKIP);
> +                               continue;
> +                       case FTS_NS:
> +                               selinux_log(SELINUX_ERROR,
> +                                       "Could not stat %s: %s.\n",
> +                                           ftsent->fts_path,
> strerror(errno));
> +                               fts_set(fts, ftsent, FTS_SKIP);
> +                               continue;
> +                       case FTS_ERR:
> +                               selinux_log(SELINUX_ERROR,
> +                                       "Error on %s: %s.\n",
> +                                           ftsent->fts_path,
> strerror(errno));
> +                               fts_set(fts, ftsent, FTS_SKIP);
> +                               continue;
> +                       case FTS_D:
> +                               if (issys && !selabel_partial_match
> +                                           (fc_sehandle,
> ftsent->fts_path)) {
> +                                       fts_set(fts, ftsent, FTS_SKIP);
> +                                       continue;
> +                               }
> +                               /* fall through */
> +                       default:
> +                               if (exclude_list) {
> +                                       if
> (check_excluded(ftsent->fts_path,
> +                                                           exclude_list))
> {
> +                                               fts_set(fts, ftsent,
> FTS_SKIP);
> +                                               continue;
> +                                       }
> +                               }
> +                               error |= restorecon_sb(ftsent->fts_path,
> +                                           ftsent->fts_statp, nochange,
> +                                           verbose, customizable,
> +                                           changecontext);
> +                               break;
> +                       }
> +               }
> +
> +               fts_close(fts);
> +
> +               /* Labeling successful. Mark top level directory
> completed. */
> +               if (setrestoreconlast && !nochange && !error) {
> +                       error = setxattr(pathname, RESTORECON_LAST, digest,
> +                                                           digest_len, 0);
> +                       if (!error && verbose)
> +                               selinux_log(SELINUX_INFO,
> +                                          "Updated SHA1 digest for: %s\n",
> +                                                            pathname);
> +               }
> +       }
> +
> +cleanup:
> +       selabel_close(fc_sehandle);
> +       free(pathname);
> +       free(xattr_value);
> +       if (verbose)
> +               free(sha1_buf);
> +       return error;
> +}
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 5dda66e..8068291 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -30,6 +30,8 @@ TARGETS=$(patsubst %.c,%,$(wildcard *.c))
>
>  sefcontext_compile: LDLIBS += -lpcre -lcrypto ../src/libselinux.a -lsepol
>
> +selinux_restorecon: LDLIBS += -lsepol
> +
>  ifeq ($(DISABLE_AVC),y)
>         UNUSED_TARGETS+=compute_av compute_create compute_member
> compute_relabel
>  endif
> diff --git a/libselinux/utils/selinux_restorecon.c
> b/libselinux/utils/selinux_restorecon.c
> new file mode 100644
> index 0000000..35ad81f
> --- /dev/null
> +++ b/libselinux/utils/selinux_restorecon.c
> @@ -0,0 +1,215 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <sepol/sepol.h>
> +#include <selinux/selinux.h>
> +
> +static char *policyfile;
> +
> +static char **exclude_list;
> +static int exclude_count;
> +
> +static int validate_context(char **contextp)
> +{
> +       char *context = *contextp, *tmpcon;
> +
> +       if (policyfile) {
> +               if (sepol_check_context(context) < 0) {
> +                       fprintf(stderr, "Invalid context %s\n", context);
> +                       exit(-1);
> +               }
> +       } else if (security_canonicalize_context_raw(context, &tmpcon) ==
> 0) {
> +               free(context);
> +               *contextp = tmpcon;
> +       } else if (errno != ENOENT) {
> +               fprintf(stderr, "Validate context error: %s\n",
> +                                                   strerror(errno));
> +               exit(-1);
> +       }
> +
> +       return 0;
> +}
> +
> +static void usage(const char *progname)
> +{
> +       fprintf(stderr,
> +               "\nusage: %s [-FnclRvrde] [-p policy] [-f specfile] "
> +               "pathname ...\n"
> +               "Where:\n\t"
> +               "-F  Force the checking of labels even if the stored
> SHA1\n\t"
> +               "    digest matches the specfiles SHA1 digest.\n\t"
> +               "-n  Don't change any file labels (passive check).\n\t"
> +               "-c  Reset customizable file label to match specfile.\n\t"
> +               "-l  Reset file label to that in spec file. If this
> option\n\t"
> +               "    is NOT set the default operation is to only reset
> the\n\t"
> +               "    \"type\" component of the label to that in the "
> +               "specfile.\n\t"
> +               "-R  Recursively change files and directory labels.\n\t"
> +               "-v  Show changes in file labels, Also specfiles used to
> calc\n\t"
> +               "    SHA1 digest plus digest.\n\t"
> +               "-r  Use realpath(3) to convert pathnames to canonical
> form.\n\t"
> +               "-d  Prevent descending into directories that have a "
> +               "different\n\t    device number than the pathname from
> which "
> +               "the descent began.\n\t"
> +               "-e  Exclude this file/directory (add multiple -e
> entries).\n\t"
> +               "-p  Optional binary policy file (also sets the
> validate\n\t"
> +               "    context option).\n\t"
> +               "-f  Optional file contexts file (defaults to those used
> by\n\t"
> +               "    loaded policy).\n\t"
> +               "pathname  One or more paths to relabel.\n\n",
> +               progname);
> +       exit(-1);
> +}
> +
> +static void add_exclude(const char *directory)
> +{
> +       char **tmp_list;
> +
> +       if (directory == NULL || directory[0] != '/') {
> +               fprintf(stderr, "Full path required for exclude: %s.\n",
> +                       directory);
> +               exit(-1);
> +       }
> +
> +       /* Add another two entries, one for directory, and the other to
> +        * terminate the list */
> +       tmp_list = realloc(exclude_list, sizeof(char *) * (exclude_count +
> 2));
> +       if (!tmp_list) {
> +               fprintf(stderr, "ERROR: realloc failed.\n");
> +               exit(-1);
> +       }
> +       exclude_list = tmp_list;
> +
> +       exclude_list[exclude_count] = strdup(directory);
> +       if (!exclude_list[exclude_count]) {
> +               fprintf(stderr, "ERROR: strdup failed.\n");
> +               exit(-1);
> +       }
> +       exclude_count++;
> +       exclude_list[exclude_count] = NULL;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       int rc, opt, i, num_paths, string_len;
> +       char **paths = NULL;
> +       unsigned int restorecon_flags = 0;
> +       char *fc_name = NULL;
> +       FILE *policystream;
> +
> +       if (argc < 2)
> +               usage(argv[0]);
> +
> +       exclude_list = NULL;
> +       exclude_count = 0;
> +
> +       while ((opt = getopt(argc, argv, "FnclRvrde:f:p:")) > 0) {
> +               switch (opt) {
> +               case 'F':
> +                       restorecon_flags |=
> +                                   SELINUX_RESTORECON_FORCE_CHECK;
> +                       break;
> +               case 'n':
> +                       restorecon_flags |= SELINUX_RESTORECON_NOCHANGE;
> +                       break;
> +               case 'c':
> +                       restorecon_flags |=
> +                                  SELINUX_RESTORECON_CHANGE_CUSTOMIZABLE;
> +                       break;
> +               case 'l':
> +                       restorecon_flags |=
> +
> SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL;
> +                       break;
> +               case 'R':
> +                       restorecon_flags |= SELINUX_RESTORECON_RECURSE;
> +                       break;
> +               case 'v':
> +                       restorecon_flags |=  SELINUX_RESTORECON_VERBOSE;
> +                       break;
> +               case 'r':
> +                       restorecon_flags |= SELINUX_RESTORECON_REALPATH;
> +                       break;
> +               case 'd':
> +                       restorecon_flags |= SELINUX_RESTORECON_XDEV;
> +                       break;
> +               case 'e':
> +                       add_exclude(optarg);
> +                       break;
> +               case 'p':
> +                       policyfile = optarg;
> +
> +                       policystream = fopen(policyfile, "r");
> +                       if (!policystream) {
> +                               fprintf(stderr,
> +                                       "Error opening %s: %s\n",
> +                                       policyfile, strerror(errno));
> +                               exit(-1);
> +                       }
> +
> +                       if (sepol_set_policydb_from_file(policystream) <
> 0) {
> +                               fprintf(stderr,
> +                                       "Error reading policy %s: %s\n",
> +                                       policyfile, strerror(errno));
> +                               exit(-1);
> +                       }
> +                       fclose(policystream);
> +                       restorecon_flags |= SELINUX_RESTORECON_VALIDATE;
> +                       selinux_set_callback(SELINUX_CB_VALIDATE,
> +                                   (union
> selinux_callback)&validate_context);
> +                       break;
> +               case 'f':
> +                       fc_name = optarg;
> +                       break;
> +               default:
> +                       usage(argv[0]);
> +               }
> +       }
> +
> +       /* Count paths */
> +       for (i = optind, num_paths = 0; i < argc; i++, num_paths++)
> +               ;
> +
> +       if (num_paths) {
> +               paths = calloc(num_paths + 1, sizeof(char *));
> +
> +               if (!paths) {
> +                       fprintf(stderr, "ERROR: calloc failed.\n");
> +                       exit(-1);
> +               }
> +
> +               for (i = optind, num_paths = 0; i < argc; i++,
> num_paths++) {
> +                       string_len = strlen(argv[i]) + 1;
> +                       paths[num_paths] = malloc(string_len);
> +                       if (!paths[num_paths]) {
> +                               fprintf(stderr, "ERROR: malloc failed.\n");
> +                               exit(-1);
> +                       }
> +                       strcpy(paths[num_paths], argv[i]);
> +               }
> +       }
> +
> +       rc = selinux_restorecon((const char **)paths,
> +                                           (const char **)exclude_list,
> +                                           fc_name,
> +                                           restorecon_flags);
> +
> +       if (rc)
> +               fprintf(stderr, "selinux_restorecon error: %s\n",
> +                                                   strerror(errno));
> +
> +       if (paths) {
> +               for (i = 0; paths[i]; i++)
> +                       free(paths[i]);
> +               free(paths);
> +       }
> +
> +       if (exclude_list) {
> +               for (i = 0; exclude_list[i]; i++)
> +                       free(exclude_list[i]);
> +               free(exclude_list);
> +       }
> +
> +       return rc;
> +}
> --
> 2.4.3
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--047d7ba982d4de1b4f0520c20cd2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiBTdW4sIFNlcCAyNywgMjAxNSBhdCAzOjA2IFBNLCBSaWNoYXJkIEhhaW5lcyA8
c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkX2NfaGFpbmVzQGJ0aW50
ZXJuZXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+cmljaGFyZF9jX2hhaW5lc0BidGludGVybmV0LmNv
bTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDti
b3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPlRoZSBzZWxpbnV4X3Jlc3RvcmVjb24oMykgbWFuIHBhZ2UgZGV0
YWlscyB0aGlzIGZ1bmN0aW9uIHRoYXQgcmVsaWVzPGJyPg0Kb24gdGhlIHNlbGFiZWxfZGlnZXN0
KDMpIGZ1bmN0aW9uIGF2YWlsYWJsZSBmcm9tIFsxXSAoYXMgbm90IHlldDxicj4NCnBhcnQgb2Yg
dXBzdHJlYW0gbGlic2VsaW51eCkuPGJyPg0KPGJyPg0KSXQgaGFzIGJlZW4gYnVpbHQgdXNpbmcg
dGhlIHdvcmsgZnJvbSBBbmRyb2lkIHdoZXJlIGFuIFNIQTEgaGFzaDxicj4NCm9mIHRoZSBzcGVj
ZmlsZXMgaXMgaGVsZCBpbiBhbiBleHRlbmRlZCBhdHRyaWJ1dGUgdG8gZW5oYW5jZTxicj4NCnBl
cmZvcm1hbmNlLiBBbHNvIGNvbnRhaW5zIGNvbXBvbmVudHMgZnJvbSBwb2xpY3ljb3JldXRpbHMv
c2V0ZmlsZXMuPGJyPg0KPGJyPg0KVGhlIHV0aWxzL3NlbGludXhfcmVzdG9yZWNvbi5jIHV0aWxp
dHkgZGVtb25zdHJhdGVzIHRoZSBmdW5jdGlvbmFsaXR5Ljxicj4NCjxicj4NClsxXSA8YSBocmVm
PSJodHRwOi8vbWFyYy5pbmZvLz9sPXNlbGludXgmYW1wO209MTQ0Mjc0MzgzMjE3MzQzJmFtcDt3
PTIiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9tYXJjLmluZm8vP2w9
c2VsaW51eCZhbXA7bT0xNDQyNzQzODMyMTczNDMmYW1wO3c9MjwvYT48YnI+DQo8YnI+DQpTaWdu
ZWQtb2ZmLWJ5OiBSaWNoYXJkIEhhaW5lcyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJpY2hhcmRfY19o
YWluZXNAYnRpbnRlcm5ldC5jb20iPnJpY2hhcmRfY19oYWluZXNAYnRpbnRlcm5ldC5jb208L2E+
Jmd0Ozxicj4NCi0tLTxicj4NClYyIENoYW5nZXM6PGJyPg0KQWRkZWQgZXhjbHVkZV9saXN0IHRv
IGZ1bmN0aW9uLCB1cGRhdGVkIHV0aWwgdG8gdGVzdCBhbmQgbWFuIHBhZ2U8YnI+DQpGaXhlZCB4
ZGV2IHRvIHVzZSBmdHMgY29ycmVjdGx5Ljxicj4NCjxicj4NCsKgbGlic2VsaW51eC9pbmNsdWRl
L3NlbGludXgvc2VsaW51eC5owqAgwqAgwqB8wqAgMjggKys8YnI+DQrCoGxpYnNlbGludXgvbWFu
L21hbjMvc2VsaW51eF9yZXN0b3JlY29uLjMgfCAyMDAgKysrKysrKysrKysrKys8YnI+DQrCoGxp
YnNlbGludXgvc3JjL01ha2VmaWxlwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMiAr
LTxicj4NCsKgbGlic2VsaW51eC9zcmMvc2VsaW51eF9yZXN0b3JlY29uLmPCoCDCoCDCoCB8IDQ0
MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyPg0KwqBsaWJzZWxpbnV4L3V0aWxz
L01ha2VmaWxlwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMiArPGJyPg0KwqBsaWJzZWxp
bnV4L3V0aWxzL3NlbGludXhfcmVzdG9yZWNvbi5jwqAgwqAgfCAyMTUgKysrKysrKysrKysrKysr
PGJyPg0KwqA2IGZpbGVzIGNoYW5nZWQsIDg4OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
PGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgbGlic2VsaW51eC9tYW4vbWFuMy9zZWxpbnV4X3Jl
c3RvcmVjb24uMzxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYnNlbGludXgvc3JjL3NlbGlu
dXhfcmVzdG9yZWNvbi5jPGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgbGlic2VsaW51eC91dGls
cy9zZWxpbnV4X3Jlc3RvcmVjb24uYzxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9saWJzZWxpbnV4
L2luY2x1ZGUvc2VsaW51eC9zZWxpbnV4LmggYi9saWJzZWxpbnV4L2luY2x1ZGUvc2VsaW51eC9z
ZWxpbnV4Lmg8YnI+DQppbmRleCA0YmViMTcwLi5jNTIyOGE2IDEwMDY0NDxicj4NCi0tLSBhL2xp
YnNlbGludXgvaW5jbHVkZS9zZWxpbnV4L3NlbGludXguaDxicj4NCisrKyBiL2xpYnNlbGludXgv
aW5jbHVkZS9zZWxpbnV4L3NlbGludXguaDxicj4NCkBAIC02NjMsNiArNjYzLDM0IEBAIGV4dGVy
biBpbnQgc2VsaW51eF9sc2V0ZmlsZWNvbl9kZWZhdWx0KGNvbnN0IGNoYXIgKnBhdGgpOzxicj4N
CsKgICovPGJyPg0KwqBleHRlcm4gdm9pZCBzZWxpbnV4X3Jlc2V0X2NvbmZpZyh2b2lkKTs8YnI+
DQo8YnI+DQorPGJyPg0KKy8qIEZvcmNlIHRoZSBjaGVja2luZyBvZiBsYWJlbHMgZXZlbiBpZiB0
aGUgc3RvcmVkIFNIQTE8YnI+DQorICogZGlnZXN0IG1hdGNoZXMgdGhlIHNwZWNmaWxlcyBTSEEx
IGRpZ2VzdC4gKi88YnI+DQorI2RlZmluZSBTRUxJTlVYX1JFU1RPUkVDT05fRk9SQ0VfQ0hFQ0vC
oCDCoCDCoCDCoCDCoDE8YnI+DQorLyogRG8gbm90IGNoYW5nZSBmaWxlIGxhYmVscyAqLzxicj4N
CisjZGVmaW5lIFNFTElOVVhfUkVTVE9SRUNPTl9OT0NIQU5HRcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIDI8YnI+DQorLyogSWYgc2V0IGNoYW5nZSB0aGUgZmlsZXMgbGFiZWwgdG8gdGhh
dCBpbiBzcGVjIGZpbGUuPGJyPg0KKyAqIElmIG5vdCBzZXQgb25seSBjaGFuZ2UgdGhlIHR5cGUg
Y29tcG9uZW50IHRvIHRoYXQgaW4gc3BlYyBmaWxlLiAqLzxicj4NCisjZGVmaW5lIFNFTElOVVhf
UkVTVE9SRUNPTl9DSEFOR0VfVVNFUlJPTEVUWVBFTEVWRUzCoCDCoCA0PGJyPg0KKy8qIFJlc2V0
IGN1c3RvbWl6YWJsZSB0eXBlcyAqLzxicj4NCisjZGVmaW5lIFNFTElOVVhfUkVTVE9SRUNPTl9D
SEFOR0VfQ1VTVE9NSVpBQkxFwqAgwqAgwqAgwqAgwqA4PGJyPg0KKy8qIFJlY3Vyc2UgdGhyb3Vn
aCB0aGUgZGlyZWN0b3J5IHBhdGggKi88YnI+DQorI2RlZmluZSBTRUxJTlVYX1JFU1RPUkVDT05f
UkVDVVJTRcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMTY8YnI+DQorLyogTG9nIGNo
YW5nZXMgYW5kIHNob3cgc3BlY2ZpbGVzIFNIQTEgZGlnZXN0ICovPGJyPg0KKyNkZWZpbmUgU0VM
SU5VWF9SRVNUT1JFQ09OX1ZFUkJPU0XCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDMy
PGJyPg0KKy8qIFNldCBzZWxhYmVsX29wZW4oMykgb3B0aW9uIFNFTEFCRUxfT1BUX1ZBTElEQVRF
ICovPGJyPg0KKyNkZWZpbmUgU0VMSU5VWF9SRVNUT1JFQ09OX1ZBTElEQVRFwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgNjQ8YnI+DQorLyogQ29udmVydCBwYXNzZWQtaW4gcGF0aG5hbWUg
dG8gY2Fub25pY2FsIHBhdGhuYW1lICovPGJyPg0KKyNkZWZpbmUgU0VMSU5VWF9SRVNUT1JFQ09O
X1JFQUxQQVRIwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTI4PGJyPg0KKy8qIFByZXZl
bnQgZGVzY2VuZGluZyBpbnRvIGRpcmVjdG9yaWVzIHRoYXQgaGF2ZSBhIGRpZmZlcmVudDxicj4N
CisgKiBkZXZpY2UgbnVtYmVyIHRoYW4gdGhlIHBhdGhuYW1lIGZyb20gd2hpY2ggdGhlIGRlc2Nl
bnQgYmVnYW4gKi88YnI+DQorI2RlZmluZSBTRUxJTlVYX1JFU1RPUkVDT05fWERFVsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDI1Njxicj4NCis8YnI+DQor
ZXh0ZXJuIGludCBzZWxpbnV4X3Jlc3RvcmVjb24oY29uc3QgY2hhciAqKnBhdGhuYW1lX2xpc3Qs
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgY29uc3QgY2hhciAqKmV4Y2x1ZGVfbGlzdCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBjaGFyICpmY19wYXRoLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVu
c2lnbmVkIGludCByZXN0b3JlY29uX2ZsYWdzKTs8YnI+DQorPGJyPg0KwqAjaWZkZWYgX19jcGx1
c3BsdXM8YnI+DQrCoH08YnI+DQrCoCNlbmRpZjxicj4NCmRpZmYgLS1naXQgYS9saWJzZWxpbnV4
L21hbi9tYW4zL3NlbGludXhfcmVzdG9yZWNvbi4zIGIvbGlic2VsaW51eC9tYW4vbWFuMy9zZWxp
bnV4X3Jlc3RvcmVjb24uMzxicj4NCm5ldyBmaWxlIG1vZGUgMTAwNjQ0PGJyPg0KaW5kZXggMDAw
MDAwMC4uM2RmZGJkMzxicj4NCi0tLSAvZGV2L251bGw8YnI+DQorKysgYi9saWJzZWxpbnV4L21h
bi9tYW4zL3NlbGludXhfcmVzdG9yZWNvbi4zPGJyPg0KQEAgLTAsMCArMSwyMDAgQEA8YnI+DQor
LlRIICZxdW90O3NlbGludXhfcmVzdG9yZWNvbiZxdW90OyAmcXVvdDszJnF1b3Q7ICZxdW90OzIy
IFNlcHQgMjAxNSZxdW90OyAmcXVvdDtTZWN1cml0eSBFbmhhbmNlZCBMaW51eCZxdW90OyAmcXVv
dDtTRUxpbnV4IEFQSSBkb2N1bWVudGF0aW9uJnF1b3Q7PGJyPg0KKzxicj4NCisuU0ggJnF1b3Q7
TkFNRSZxdW90Ozxicj4NCitzZWxpbnV4X3Jlc3RvcmVjb24gXC0gcmVzdG9yZSBmaWxlKHMpIGRl
ZmF1bHQgU0VMaW51eCBzZWN1cml0eSBjb250ZXh0czxicj4NCisuPGJyPg0KKy5TSCAmcXVvdDtT
WU5PUFNJUyZxdW90Ozxicj4NCisuQiAjaW5jbHVkZSAmbHQ7c2VsaW51eC9zZWxpbnV4LmgmZ3Q7
PGJyPg0KKy5zcDxicj4NCisuQkkgJnF1b3Q7aW50IHNlbGludXhfcmVzdG9yZWNvbihjb25zdCBj
aGFyICoqJnF1b3Q7IHBhdGhuYW1lX2xpc3QgLDxicj4NCisuaW4gK1x3JiMzOTtpbnQgc2VsaW51
eF9yZXN0b3JlY29uKCYjMzk7dTxicj4NCisuQkkgJnF1b3Q7Y29uc3QgY2hhciAqKiZxdW90OyBl
eGNsdWRlX2xpc3QgLDxicj4NCisuYnI8YnI+DQorLkJJICZxdW90O2NvbnN0IGNoYXIgKiZxdW90
OyBmY19wYXRoICw8YnI+DQorLmJyPGJyPg0KKy5CSSAmcXVvdDt1bnNpZ25lZCBpbnQgJnF1b3Q7
IHJlc3RvcmVjb25fZmxhZ3MgJnF1b3Q7KTsmcXVvdDs8YnI+DQorLmluPGJyPg0KKy48YnI+DQor
LlNIICZxdW90O0RFU0NSSVBUSU9OJnF1b3Q7PGJyPg0KKy5CUiBzZWxpbnV4X3Jlc3RvcmVjb24g
KCk8YnI+DQorcmVzdG9yZXMgZmlsZSBkZWZhdWx0IHNlY3VyaXR5IGNvbnRleHRzIGJhc2VkIG9u
Ojxicj4NCisuc3A8YnI+DQorLlJTPGJyPg0KKy5JUiBwYXRobmFtZV9saXN0PGJyPg0KK2NvbnRh
aW5pbmcgYTxicj4NCisuQiBOVUxMPGJyPg0KK3Rlcm1pbmF0ZWQgbGlzdCBvZiBvbmUgb3IgbW9y
ZSBkaXJlY3RvcmllcyBvciBmaWxlcyB0byBiZSByZWxhYmVsZWQuPGJyPg0KKy5icjxicj4NCitJ
ZiB0aGU8YnI+DQorLklSIHJlc3RvcmVjb25fZmxhZ3M8YnI+DQorLkIgU0VMSU5VWF9SRVNUT1JF
Q09OX1JFQ1VSU0U8YnI+DQoraGFzIGJlZW4gc2V0IChmb3IgZGVjZW5kaW5nIHRocm91Z2ggZGly
ZWN0b3JpZXMpLCB0aGVuIGZvciBlYWNoPGJyPg0KKy5JUiBwYXRobmFtZV9saXN0PGJyPg0KK2Vu
dHJ5IHNwZWNpZmllZDxicj4NCisuQlIgc2VsaW51eF9yZXN0b3JlY29uICgpPGJyPg0KK3dpbGwg
d3JpdGUgYW4gU0hBMSBkaWdlc3Qgb2YgdGhlIGNvbWJpbmVkIHNwZWNmaWxlcyAoc2VlIHRoZTxi
cj4NCisuQiBOT1RFUzxicj4NCitzZWN0aW9uIGZvciBkZXRhaWxzKSB0byBhbiBleHRlbmRlZCBh
dHRyaWJ1dGUgb2Y8YnI+DQorLklSIHNlY3VyaXR5LnJlc3RvcmVjb25fbGFzdDxicj4NCitvbmNl
IHRoZSByZWxhYmVsaW5nIGhhcyBiZWVuIGNvbXBsZXRlZCBzdWNjZXNzZnVsbHkuIFRoaXMgZGln
ZXN0IHdpbGwgYmU8YnI+DQorY2hlY2tlZCBzaG91bGQ8YnI+DQorLkJSIHNlbGludXhfcmVzdG9y
ZWNvbiAoKTxicj4NCitiZSByZXJ1bjxicj4NCit3aXRoIHRoZTxicj4NCisuSVIgcmVzdG9yZWNv
bl9mbGFnczxicj4NCisuQiBTRUxJTlVYX1JFU1RPUkVDT05fUkVDVVJTRTxicj4NCitmbGFnIHNl
dC4gSWYgYW55IG9mIHRoZSBzcGVjZmlsZXMgaGFkIGJlZW4gdXBkYXRlZCwgdGhlIGRpZ2VzdDxi
cj4NCit3aWxsIGFsc28gYmUgdXBkYXRlZC4gSG93ZXZlciBpZiB0aGUgZGlnZXN0IGlzIHRoZSBz
YW1lLCBubyByZWxhYmVsaW5nIGNoZWNrczxicj4NCit3aWxsIHRha2UgcGxhY2UgdW5sZXNzIHRo
ZTxicj4NCisuSVIgcmVzdG9yZWNvbl9mbGFnczxicj4NCisuQiBTRUxJTlVYX0FORFJPSURfUkVT
VE9SRUNPTl9GT1JDRV9DSEVDSzxicj4NCitmbGFnIGlzIGFsc28gc2V0Ljxicj4NCisuc3A8YnI+
DQorLklSIGV4Y2x1ZGVfbGlzdDxicj4NCitjb250YWluaW5nIGE8YnI+DQorLkIgTlVMTDxicj4N
Cit0ZXJtaW5hdGVkIGxpc3Qgb2YgemVybyBvciBtb3JlIGRpcmVjdG9yaWVzIG9yIGZpbGVzIHRo
YXQgYXJlIG5vdCB0byBiZTxicj4NCityZWxhYmVsZWQuPGJyPg0KKy5zcDxicj4NCisuSVIgZmNf
cGF0aDxicj4NCitjb250YWluaW5nIGFuIG9wdGlvbmFsIHNwZWNmaWxlIHRvIHByb3ZpZGUgdGhl
IGZpbGUgbGFiZWxpbmc8YnI+DQorZGV0YWlscyAoc2VlPGJyPg0KKy5CUiBzZWxhYmVsX2ZpbGUg
KDUpPGJyPg0KK2ZvciBkZXRhaWxzIG9mIHRoZSBmaWxlIGZvcm1hdCkuPGJyPg0KKy5icjxicj4N
CitJZiBzZXQgdG88YnI+DQorLkIgTlVMTDxicj4NCit0aGVuIHRoZSBjdXJyZW50bHkgbG9hZGVk
IHBvbGljeSBzcGVjZmlsZXMgd2lsbCBiZSB1c2VkLjxicj4NCisuc3A8YnI+DQorLklSIHJlc3Rv
cmVjb25fZmxhZ3M8YnI+DQorY29udGFpbnMgdGhlIGxhYmVsaW5nIG9wdGlvbi9ydWxlcyBhcyBm
b2xsb3dzOjxicj4NCisuc3A8YnI+DQorLlJTPGJyPg0KKy5CIFNFTElOVVhfQU5EUk9JRF9SRVNU
T1JFQ09OX0ZPUkNFX0NIRUNLPGJyPg0KK2ZvcmNlIHRoZSBjaGVja2luZyBvZiBsYWJlbHMgZXZl
biBpZiB0aGUgc3RvcmVkIFNIQTEgZGlnZXN0IG1hdGNoZXMgdGhlPGJyPg0KK3NwZWNmaWxlcyBT
SEExIGRpZ2VzdC48YnI+DQorLnNwPGJyPg0KKy5CIFNFTElOVVhfUkVTVE9SRUNPTl9OT0NIQU5H
RTxicj4NCitkb24mIzM5O3QgY2hhbmdlIGFueSBmaWxlIGxhYmVscyAocGFzc2l2ZSBjaGVjayku
PGJyPg0KKy5zcDxicj4NCisuQiBTRUxJTlVYX1JFU1RPUkVDT05fQ0hBTkdFX1VTRVJST0xFVFlQ
RUxFVkVMPGJyPg0KK2lmIHNldCwgcmVzZXQgdGhlIGZpbGVzIGxhYmVsIHRvIG1hdGNoIHRoZSBk
ZWZhdWx0IHNwZWNmaWxlIGNvbnRleHQ8YnI+DQorKGkuZS4gY2hhbmdlIHVzZXIsIHJvbGUsIHR5
cGUgYW5kIHJhbmdlKS48YnI+DQorLmJyPGJyPg0KK0lmIG5vdCBzZXQsIHRoZW4gb25seSByZXNl
dCB0aGUgZmlsZXMgJnF1b3Q7dHlwZSZxdW90OyBjb21wb25lbnQgb2YgdGhlIGNvbnRleHQgdG88
YnI+DQorbWF0Y2ggdGhlIGRlZmF1bHQgc3BlY2ZpbGUgY29udGV4dC48YnI+DQorLnNwPGJyPg0K
Ky5CIFNFTElOVVhfUkVTVE9SRUNPTl9DSEFOR0VfQ1VTVE9NSVpBQkxFPGJyPg0KK3Jlc2V0IGN1
c3RvbWl6ZWQgZmlsZSBsYWJlbHMgKHNlZTxicj4NCisuQlIgaXNfY29udGV4dF9jdXN0b21pemFi
bGUgKDMpKTxicj4NCit0byBtYXRjaCB0aGUgZGVmYXVsdCBzcGVjZmlsZSBjb250ZXh0LiBVc2Ug
dGhlPGJyPg0KKy5CIFNFTElOVVhfUkVTVE9SRUNPTl9DSEFOR0VfVVNFUlJPTEVUWVBFTEVWRUw8
YnI+DQorZmxhZyB0byBkZXRlcm1pbmUgdGhlIGNvbXBvbmVudHMgdG8gY2hhbmdlLjxicj4NCisu
c3A8YnI+DQorLkIgU0VMSU5VWF9SRVNUT1JFQ09OX1ZFUkJPU0U8YnI+DQorc2hvdyBjaGFuZ2Vz
IGluIGZpbGUgbGFiZWxzIGFuZCBkaXNwbGF5IHRoZSBTSEExIGRpZ2VzdHMgaW4gaGV4IGZvcm1h
dC48YnI+DQorLnNwPGJyPg0KKy5CIFNFTElOVVhfUkVTVE9SRUNPTl9SRUNVUlNFPGJyPg0KK2No
YW5nZSBmaWxlIGFuZCBkaXJlY3RvcnkgbGFiZWxzIHJlY3Vyc2l2ZWx5IChkZXNjZW5kIGRpcmVj
dG9yaWVzKTxicj4NCithbmQgaWYgc3VjY2Vzc2Z1bCB3cml0ZSBhbiBTSEExIGRpZ2VzdCBvZiB0
aGUgY29tYmluZWQgc3BlY2ZpbGVzIHRvIGFuPGJyPg0KK2V4dGVuZGVkIGF0dHJpYnV0ZSBhcyBk
ZXNjcmliZWQgaW4gdGhlPGJyPg0KKy5CIE5PVEVTPGJyPg0KK3NlY3Rpb24uPGJyPg0KKy5zcDxi
cj4NCisuQiBTRUxJTlVYX1JFU1RPUkVDT05fVkFMSURBVEU8YnI+DQorc2V0IHRoZSBnbG9iYWw8
YnI+DQorLkIgU0VMQUJFTF9PUFRfVkFMSURBVEU8YnI+DQorb3B0aW9uIHRoYXQgd2lsbCBjYXVz
ZSB0aGUgc2VjdXJpdHkgY29udGV4dHMgaW4gdGhlIHNwZWNmaWxlcyB0byBiZTxicj4NCit2YWxp
ZGF0ZWQgYWdhaW5zdCBwb2xpY3kgYXMgZGVzY3JpYmVkIGluPGJyPg0KKy5CUiBzZWxhYmVsX29w
ZW4gKDMpLjxicj4NCisuYnI8YnI+DQorTm90ZSB0aGF0IGlmIGN1c3RvbSBjb250ZXh0IHZhbGlk
YXRpb24gaXMgcmVxdWlyZWQsIHRoZSBjYWxsZXIgaXMgcmVzcG9uc2libGU8YnI+DQorZm9yIHNl
dHRpbmcgdGhpcyB1cCBhcyBkZXNjcmliZWQgaW48YnI+DQorLkJSIHNlbGludXhfc2V0X2NhbGxi
YWNrICgzKS48YnI+DQorLnNwPGJyPg0KKy5CIFNFTElOVVhfUkVTVE9SRUNPTl9SRUFMUEFUSDxi
cj4NCitjb252ZXJ0IHBhc3NlZC1pbiBwYXRobmFtZXMgZnJvbTxicj4NCisuSVIgcGF0aG5hbWVf
bGlzdDxicj4NCit0byBjYW5vbmljYWwgcGF0aG5hbWVzIHVzaW5nPGJyPg0KKy5CUiByZWFscGF0
aCAoMykuPGJyPg0KKy5zcDxicj4NCisuQiBTRUxJTlVYX1JFU1RPUkVDT05fWERFVjxicj4NCitw
cmV2ZW50IGRlc2NlbmRpbmcgaW50byBkaXJlY3RvcmllcyB0aGF0IGhhdmUgYSBkaWZmZXJlbnQg
ZGV2aWNlIG51bWJlciB0aGFuPGJyPg0KK3RoZTxicj4NCisuSVIgcGF0aG5hbWVfbGlzdDxicj4N
CitlbnRyeSBmcm9tIHdoaWNoIHRoZSBkZXNjZW50IGJlZ2FuLjxicj4NCisuUkU8YnI+DQorLlJF
PGJyPg0KKy48YnI+DQorLlNIICZxdW90O1JFVFVSTiBWQUxVRSZxdW90Ozxicj4NCitPbiBzdWNj
ZXNzLCB6ZXJvIGlzIHJldHVybmVkLsKgIE9uIGVycm9yLCBcLTEgaXMgcmV0dXJuZWQgYW5kPGJy
Pg0KKy5JIGVycm5vPGJyPg0KK2lzIHNldCBhcHByb3ByaWF0ZWx5Ljxicj4NCisuPGJyPg0KKy5T
SCAmcXVvdDtOT1RFUyZxdW90Ozxicj4NCitUbyBpbXByb3ZlIHBlcmZvcm1hbmNlIHdoZW4gcmVs
YWJlbGluZyBmaWxlIHN5c3RlbXMgcmVjdXJzaXZlbHkgKGUuZy4gdGhlPGJyPg0KKy5JUiByZXN0
b3JlY29uX2ZsYWdzPGJyPg0KKy5CIFNFTElOVVhfUkVTVE9SRUNPTl9SRUNVUlNFPGJyPg0KK2Zs
YWcgaXMgc2V0KTxicj4NCisuQlIgc2VsaW51eF9yZXN0b3JlY29uICgpPGJyPg0KK3dpbGwgd3Jp
dGUgYW4gU0hBMSBkaWdlc3Qgb2YgdGhlIHNwZWNmaWxlcyB0aGF0IGFyZSBwcm9jZXNzZWQgYnk8
YnI+DQorLkJSIHNlbGFiZWxfb3BlbiAoMyk8YnI+DQordG8gYW4gZXh0ZW5kZWQgYXR0cmlidXRl
IG5hbWVkPGJyPg0KKy5JUiBzZWN1cml0eS5yZXN0b3JlY29uX2xhc3Q8YnI+DQorZm9yIGVhY2gg
ZW50cnkgaW4gdGhlPGJyPg0KKy5JUiBwYXRobmFtZV9saXN0PGJyPg0KKyh0aGVzZSBhcmUgbm9y
bWFsbHkgdG9wIGxldmVsIGRpcmVjdG9yaWVzKS4gTm90ZSB0aGF0IGlmIGFuIGVudHJ5IGlzIGEg
ZmlsZSw8YnI+DQordGhlbiB0aGlzIHdvdWxkIGFsc28gaGF2ZSB0aGlzIGV4dGVuZGVkIGF0dHJp
YnV0ZSBhZGRlZCAoaXQgaXMgdGhlcmVmb3JlPGJyPg0KK3JlY29tZW5kZWQgdGhhdCBzZXR0aW5n
PGJyPg0KKy5CIFNFTElOVVhfUkVTVE9SRUNPTl9SRUNVUlNFPGJyPg0KK3doZW4gcmVsYWJlbGlu
ZyBhIHNwZWNpZmljIGZpbGUgc2hvdWxkIGJlIGF2b2lkZWQpLjxicj4NCisuc3A8YnI+DQorVG8g
Y2hlY2sgdGhlIGV4dGVuZGVkIGF0dHJpYnV0ZSBlbnRyeSB1c2U8YnI+DQorLkJSIGdldGZhdHRy
ICgxKSAsPGJyPg0KK2ZvciBleGFtcGxlOjxicj4NCisuc3A8YnI+DQorLlJTPGJyPg0KK2dldGZh
dHRyIC1lIGhleCAtbiBzZWN1cml0eS5yZXN0b3JlY29uX2xhc3QgLzxicj4NCisuUkU8YnI+DQor
LnNwPGJyPg0KK1RoZSBTSEExIGRpZ2VzdCBpcyBjYWxjdWxhdGVkIGJ5PGJyPg0KKy5CUiBzZWxh
YmVsX29wZW4gKDMpPGJyPg0KK2NvbmNhdGVuYXRpbmcgdGhlIHNwZWNmaWxlcyBpdCByZWFkcyBk
dXJpbmcgaW5pdGlhbGlzYXRpb24gd2l0aCB0aGU8YnI+DQorcmVzdWx0aW5nIGRpZ2VzdCBhbmQg
bGlzdCBvZiBzcGVjZmlsZXMgYmVpbmcgcmV0cmlldmVkIGJ5PGJyPg0KKy5CUiBzZWxhYmVsX2Rp
Z2VzdCAoMykuPGJyPg0KKy5zcDxicj4NCitUaGUgc3BlY2ZpbGVzIGNvbnNpc3Qgb2YgdGhlIG1h
bmRhdG9yeTxicj4NCisuSSBmaWxlX2NvbnRleHRzPGJyPg0KK2ZpbGUgcGx1cyBhbnkgc3Vicywg
c3Vic19kaXN0LCBsb2NhbCBhbmQgaG9tZWRpciBlbnRyaWVzICh0ZXh0IG9yIGJpbmFyeSB2ZXJz
aW9ucyk8YnI+DQorYXMgZGV0ZXJtaW5lZCBieSBhbnk8YnI+DQorLkJSIHNlbGFiZWxfb3BlbiAo
Myk8YnI+DQorb3B0aW9ucyBlLmcuPGJyPg0KKy5CUiBTRUxBQkVMX09QVF9CQVNFT05MWSAuPGJy
Pg0KKy5zcDxicj4NCitTaG91bGQgYW55IG9mIHRoZSBzcGVjZmlsZXMgaGF2ZSBjaGFuZ2VkLCB0
aGVuIHdoZW48YnI+DQorLkJSIHNlbGludXhfcmVzdG9yZWNvbiAoKTxicj4NCitpcyBydW4gYWdh
aW4gd2l0aCB0aGU8YnI+DQorLkIgU0VMSU5VWF9SRVNUT1JFQ09OX1JFQ1VSU0U8YnI+DQorZmxh
ZyBzZXQsIGEgbmV3IFNIQTEgZGlnZXN0IHdpbGwgYmUgY2FsY3VsYXRlZCBhbmQgYWxsIGZpbGVz
IHdpbGwgYmUgYXV0b21hdGljYWxseTxicj4NCityZWxhYmVsZWQgZGVwZW5kaW5nIG9uIHRoZSBz
ZXR0aW5ncyBvZiB0aGU8YnI+DQorLkIgU0VMSU5VWF9SRVNUT1JFQ09OX0NIQU5HRV9VU0VSUk9M
RVRZUEVMRVZFTDxicj4NCithbmQ8YnI+DQorLkIgU0VMSU5VWF9SRVNUT1JFQ09OX0NIQU5HRV9D
VVNUT01JWkFCTEU8YnI+DQorZmxhZ3MgKHByb3ZpZGVkPGJyPg0KKy5CIFNFTElOVVhfUkVTVE9S
RUNPTl9OT0NIQU5HRTxicj4NCitpcyBub3Qgc2V0KS48YnI+DQorLnNwPGJyPg0KKy5CIC9zeXM8
YnI+DQorYW5kIGluLW1lbW9yeSBmaWxlc3lzdGVtcyBkbyBub3Qgc3VwcG9ydCB0aGU8YnI+DQor
LklSIHNlY3VyaXR5LnJlc3RvcmVjb25fbGFzdDxicj4NCitleHRlbmRlZCBhdHRyaWJ1dGUuPGJy
Pg0KKy5zcDxicj4NCisuQlIgc2VsaW51eF9yZXN0b3JlY29uICgpPGJyPg0KK2RvZXMgbm90IGNo
ZWNrIHdoZXRoZXIgdGhlIG1vdW50ZWQgZmlsZXN5c3RlbXMgc3VwcG9ydCB0aGU8YnI+DQorLkIg
c2VjbGFiZWw8YnI+DQorb3B0aW9uLiBUaGVzZSBzaG91bGQgYmUgc2V0IGJ5IHRoZSBjYWxsZXIg
aW4gdGhlPGJyPg0KKy5JUiBleGNsdWRlX2xpc3QgLjxicj4NCisuPGJyPg0KKy5TSCAmcXVvdDtT
RUUgQUxTTyZxdW90Ozxicj4NCisuQlIgcmVzdG9yZWNvbiAoOCksPGJyPg0KKy5CUiBzZXRmaWxl
cyAoOCk8YnI+DQpkaWZmIC0tZ2l0IGEvbGlic2VsaW51eC9zcmMvTWFrZWZpbGUgYi9saWJzZWxp
bnV4L3NyYy9NYWtlZmlsZTxicj4NCmluZGV4IDJhMGU4ODkuLmUwN2M2YmQgMTAwNjQ0PGJyPg0K
LS0tIGEvbGlic2VsaW51eC9zcmMvTWFrZWZpbGU8YnI+DQorKysgYi9saWJzZWxpbnV4L3NyYy9N
YWtlZmlsZTxicj4NCkBAIC03Miw3ICs3Miw3IEBAIENGTEFHUyA/PSAtTyAtV2FsbCAtVyAtV3Vu
ZGVmIC1XZm9ybWF0LXkyayAtV2Zvcm1hdC1zZWN1cml0eSAtV2luaXQtc2VsZiAtV21pc3NpPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAtZmlwYS1wdXJlLWNvbnN0IC1Xbm8tc3VnZ2VzdC1hdHRyaWJ1
dGU9cHVyZSAtV25vLXN1Z2dlc3QtYXR0cmlidXRlPWNvbnN0IFw8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoC1XZXJyb3IgLVduby1hZ2dyZWdhdGUtcmV0dXJuIC1Xbm8tcmVkdW5kYW50LWRlY2xzPGJy
Pg0KPGJyPg0KLW92ZXJyaWRlIENGTEFHUyArPSAtSS4uL2luY2x1ZGUgLUkkKElOQ0xVREVESVIp
IC1EX0dOVV9TT1VSQ0UgLURfRklMRV9PRkZTRVRfQklUUz02NCAkKEVNRkxBR1MpPGJyPg0KK292
ZXJyaWRlIENGTEFHUyArPSAtSS4uL2luY2x1ZGUgLUkkKElOQ0xVREVESVIpIC1EX0dOVV9TT1VS
Q0UgJChFTUZMQUdTKTxicj4NCjxicj4NCsKgU1dJR19DRkxBR1MgKz0gLVduby1lcnJvciAtV25v
LXVudXNlZC12YXJpYWJsZSAtV25vLXVudXNlZC1idXQtc2V0LXZhcmlhYmxlIC1Xbm8tdW51c2Vk
LXBhcmFtZXRlciBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLVduby1zaGFkb3cgLVdu
by11bmluaXRpYWxpemVkIC1Xbm8tbWlzc2luZy1wcm90b3R5cGVzIC1Xbm8tbWlzc2luZy1kZWNs
YXJhdGlvbnM8YnI+DQpkaWZmIC0tZ2l0IGEvbGlic2VsaW51eC9zcmMvc2VsaW51eF9yZXN0b3Jl
Y29uLmMgYi9saWJzZWxpbnV4L3NyYy9zZWxpbnV4X3Jlc3RvcmVjb24uYzxicj4NCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0PGJyPg0KaW5kZXggMDAwMDAwMC4uNjUzNTcyZTxicj4NCi0tLSAvZGV2L251
bGw8YnI+DQorKysgYi9saWJzZWxpbnV4L3NyYy9zZWxpbnV4X3Jlc3RvcmVjb24uYzxicj4NCkBA
IC0wLDAgKzEsNDQzIEBAPGJyPg0KKy8qPGJyPg0KKyAqIFRoZSBtYWpvcml0eSBvZiB0aGlzIGNv
ZGUgaXMgZnJvbSBBbmRyb2lkJiMzOTtzPGJyPg0KKyAqIGV4dGVybmFsL2xpYnNlbGludXgvc3Jj
L2FuZHJvaWQuYyBhbmQgdXBzdHJlYW08YnI+DQorICogc2VsaW51eC9wb2xpY3ljb3JldXRpbHMv
c2V0ZmlsZXMvcmVzdG9yZWNvbi5jPGJyPg0KKyAqPGJyPg0KKyAqIFNlZSBzZWxpbnV4X3Jlc3Rv
cmVjb24oMykgZm9yIGRldGFpbHMuPGJyPg0KKyAqLzxicj4NCis8YnI+DQorI2luY2x1ZGUgJmx0
O3VuaXN0ZC5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7c3RyaW5nLmgmZ3Q7PGJyPg0KKyNpbmNs
dWRlICZsdDtzdGRpby5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7c3RkbGliLmgmZ3Q7PGJyPg0K
KyNpbmNsdWRlICZsdDtzdGRib29sLmgmZ3Q7PGJyPg0KKyNpbmNsdWRlICZsdDtjdHlwZS5oJmd0
Ozxicj4NCisjaW5jbHVkZSAmbHQ7ZXJybm8uaCZndDs8YnI+DQorI2luY2x1ZGUgJmx0O2ZjbnRs
LmgmZ3Q7PGJyPg0KKyNpbmNsdWRlICZsdDtmdHMuaCZndDs8YnI+DQorI2luY2x1ZGUgJmx0O2xp
bWl0cy5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7c3lzL3R5cGVzLmgmZ3Q7PGJyPg0KKyNpbmNs
dWRlICZsdDtzeXMvc3RhdC5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7c3lzL3hhdHRyLmgmZ3Q7
PGJyPg0KKyNpbmNsdWRlICZsdDtzeXMvdmZzLmgmZ3Q7PGJyPg0KKyNpbmNsdWRlICZsdDtsaW51
eC9tYWdpYy5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7c2VsaW51eC9zZWxpbnV4LmgmZ3Q7PGJy
Pg0KKyNpbmNsdWRlICZsdDtzZWxpbnV4L2NvbnRleHQuaCZndDs8YnI+DQorI2luY2x1ZGUgJmx0
O3NlbGludXgvbGFiZWwuaCZndDs8YnI+DQorPGJyPg0KKyNpbmNsdWRlICZxdW90O2NhbGxiYWNr
cy5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRlICZxdW90O3NlbGludXhfaW50ZXJuYWwuaCZxdW90Ozxi
cj4NCis8YnI+DQorI2RlZmluZSBSRVNUT1JFQ09OX0xBU1QgJnF1b3Q7c2VjdXJpdHkucmVzdG9y
ZWNvbl9sYXN0JnF1b3Q7PGJyPg0KKzxicj4NCisjZGVmaW5lIFNZU19QQVRIICZxdW90Oy9zeXMm
cXVvdDs8YnI+DQorI2RlZmluZSBTWVNfUFJFRklYIFNZU19QQVRIICZxdW90Oy8mcXVvdDs8YnI+
DQorPGJyPg0KK3N0YXRpYyBzdHJ1Y3Qgc2VsYWJlbF9oYW5kbGUgKmZjX3NlaGFuZGxlOzxicj4N
Cis8YnI+DQorI2RlZmluZSBOVU1fU0VMQUJFTF9PUFRTIDQ8YnI+DQorc3RhdGljIHN0cnVjdCBz
ZWxpbnV4X29wdCBmY19vcHRzW10gPSB7PGJyPg0KK8KgIMKgIMKgIMKgeyBTRUxBQkVMX09QVF9Q
QVRILCBOVUxMIH0sPGJyPg0KK8KgIMKgIMKgIMKgeyBTRUxBQkVMX09QVF9CQVNFT05MWSwgTlVM
TCB9LDxicj4NCivCoCDCoCDCoCDCoHsgU0VMQUJFTF9PUFRfVkFMSURBVEUsIE5VTEwgfSw8YnI+
DQorwqAgwqAgwqAgwqB7IFNFTEFCRUxfT1BUX0RJR0VTVCwgTlVMTCB9IH07PGJyPg0KKzxicj4N
CisvKjxicj4NCisgKiBUaGlzIGlzIGNhbGxlZCBpZiBTRUxJTlVYX1JFU1RPUkVDT05fQ0hBTkdF
X1VTRVJST0xFVFlQRUxFVkVMIGlzIG5vdCBzZXQ8YnI+DQorICogdG8gY2hlY2sgaWYgdGhlIHR5
cGUgY29tcG9uZW50cyBkaWZmZXIsIHVwZGF0aW5nIG5ld3R5cGVjb24gaWYgc28uPGJyPg0KKyAq
Lzxicj4NCitzdGF0aWMgaW50IGNvbXBhcmVfdHlwZXMoY2hhciAqY3VyY29uLCBjaGFyICpuZXdj
b24sIGNoYXIgKipuZXd0eXBlY29uKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgaW50IHR5cGVz
X2RpZmZlciA9IDA7PGJyPg0KK8KgIMKgIMKgIMKgY29udGV4dF90IGNvbmE7PGJyPg0KK8KgIMKg
IMKgIMKgY29udGV4dF90IGNvbmI7PGJyPg0KK8KgIMKgIMKgIMKgaW50IHJjID0gMDs8YnI+DQor
PGJyPg0KK8KgIMKgIMKgIMKgY29uYSA9IGNvbnRleHRfbmV3KGN1cmNvbik7PGJyPg0KK8KgIMKg
IMKgIMKgaWYgKCFjb25hKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmMgPSAtMTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIG91dDs8YnI+DQorwqAgwqAgwqAgwqB9
PGJyPg0KK8KgIMKgIMKgIMKgY29uYiA9IGNvbnRleHRfbmV3KG5ld2Nvbik7PGJyPg0KK8KgIMKg
IMKgIMKgaWYgKCFjb25iKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGV4dF9m
cmVlKGNvbmEpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJjID0gLTE7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBvdXQ7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqB0eXBlc19kaWZmZXIgPSBzdHJjbXAoY29udGV4dF90eXBlX2dldChj
b25hKSwgY29udGV4dF90eXBlX2dldChjb25iKSk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHR5cGVz
X2RpZmZlcikgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJjIHw9IGNvbnRleHRfdXNl
cl9zZXQoY29uYiwgY29udGV4dF91c2VyX2dldChjb25hKSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmMgfD0gY29udGV4dF9yb2xlX3NldChjb25iLCBjb250ZXh0X3JvbGVfZ2V0KGNv
bmEpKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYyB8PSBjb250ZXh0X3JhbmdlX3Nl
dChjb25iLCBjb250ZXh0X3JhbmdlX2dldChjb25hKSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaWYgKCFyYykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCpuZXd0eXBlY29uID0gc3RyZHVwKGNvbnRleHRfc3RyKGNvbmIpKTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoISpuZXd0eXBlY29uKSB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmMgPSAtMTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVycjs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK2Vycjo8YnI+
DQorwqAgwqAgwqAgwqBjb250ZXh0X2ZyZWUoY29uYSk7PGJyPg0KK8KgIMKgIMKgIMKgY29udGV4
dF9mcmVlKGNvbmIpOzxicj4NCitvdXQ6PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIHJjOzxicj4N
Cit9PGJyPg0KKzxicj4NCitzdGF0aWMgaW50IHJlc3RvcmVjb25fc2IoY29uc3QgY2hhciAqcGF0
aG5hbWUsIGNvbnN0IHN0cnVjdCBzdGF0ICpzYiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBib29sIG5vY2hhbmdlLCBib29sIHZlcmJv
c2UsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgYm9vbCBjdXN0b21pemFibGUsIGJvb2wgY2hhbmdlY29udGV4dCk8YnI+DQorezxicj4N
CivCoCDCoCDCoCDCoGNoYXIgKm5ld2NvbiA9IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgY2hhciAq
Y3VyY29uID0gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqBjaGFyICpuZXd0eXBlY29uID0gTlVMTDs8
YnI+DQorwqAgwqAgwqAgwqBpbnQgcmMgPSAwOzxicj4NCivCoCDCoCDCoCDCoGJvb2wgdXBkYXRl
ZCA9IGZhbHNlOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoc2VsYWJlbF9sb29rdXBfcmF3
KGZjX3NlaGFuZGxlLCAmYW1wO25ld2NvbiwgcGF0aG5hbWUsIHNiLSZndDtzdF9tb2RlKSAmbHQ7
IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIDA7IC8qIG5vIG1hdGNoLCBi
dXQgbm90IGFuIGVycm9yICovPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChsZ2V0ZmlsZWNv
bl9yYXcocGF0aG5hbWUsICZhbXA7Y3VyY29uKSAmbHQ7IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZ290byBlcnI7PGJyPjwvYmxvY2txdW90ZT48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQtd2lk
dGg6MXB4O2JvcmRlci1sZWZ0LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7Ym9yZGVyLWxlZnQtc3R5
bGU6c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+Kzxicj4NCivCoCDCoCDCoCDCoGlmIChzdHJjbXAo
Y3VyY29uLCBuZXdjb24pICE9IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
IWN1c3RvbWl6YWJsZSAmYW1wOyZhbXA7IChpc19jb250ZXh0X2N1c3RvbWl6YWJsZShjdXJjb24p
ICZndDsgMCkpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
dmVyYm9zZSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHNlbGludXhfbG9nKFNFTElOVVhfSU5GTyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7JXMgbm90IHJlc2V0IGFzIGN1c3Rv
bWl6ZWQgYnkgYWRtaW4gdG8gJXNcbiZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBwYXRobmFtZSwgY3VyY29uKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIG91dDs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIW5vY2hhbmdl
ICZhbXA7JmFtcDsgY2hhbmdlY29udGV4dCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChsc2V0ZmlsZWNvbihwYXRobmFtZSwgbmV3Y29uKSAmbHQ7IDApPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBl
cnI7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdXBkYXRlZCA9IHRy
dWU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlIGlmIChub2NoYW5nZSAmYW1w
OyZhbXA7IGNoYW5nZWNvbnRleHQpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB1cGRhdGVkID0gdHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9IGVs
c2UgaWYgKCFjaGFuZ2Vjb250ZXh0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgLyogSWYgdHlwZXMgZGlmZmVyZW50IHRoZW4gdXBkYXRlIG5ld2Nvbi4gKi88YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYyA9IGNvbXBhcmVfdHlwZXMo
Y3VyY29uLCBuZXdjb24sICZhbXA7bmV3dHlwZWNvbik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJjKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobmV3dHlwZWNvbikgezxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWVjb24obmV3Y29uKTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBuZXdjb24g
PSBuZXd0eXBlY29uOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmICghbm9jaGFuZ2UpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobHNldGZpbGVjb24ocGF0aG5h
bWUsIG5ld2NvbikgJmx0OyAwKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1cGRhdGVkID0gdHJ1
ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfTxicj48L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdp
ZHRoOjFweDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0
eWxlOnNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAodmVyYm9zZSAmYW1wOyZhbXA7IHVwZGF0ZWQpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgc2VsaW51eF9sb2coU0VMSU5VWF9JTkZPLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90OyVzICVz
IGZyb20gJXMgdG8gJXMuXG4mcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbm9jaGFuZ2UgPyAmcXVvdDtXb3VsZCByZWxhYmVs
JnF1b3Q7IDogJnF1b3Q7UmVsYWJlbGVkJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBhdGhuYW1lLCBjdXJjb24sIG5ld2Nv
bik7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorb3V0Ojxicj4NCivCoCDCoCDCoCDC
oHJjID0gMDs8YnI+DQorb3V0MTo8YnI+DQorwqAgwqAgwqAgwqBmcmVlY29uKGN1cmNvbik7PGJy
Pg0KK8KgIMKgIMKgIMKgZnJlZWNvbihuZXdjb24pOzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBy
Yzs8YnI+DQorZXJyOjxicj4NCivCoCDCoCDCoCDCoHNlbGludXhfbG9nKFNFTElOVVhfRVJST1Is
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7Q291bGQgbm90IHNldCBj
b250ZXh0IGZvciAlczrCoCAlc1xuJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHBhdGhuYW1lLCBzdHJlcnJvcihlcnJubykpOzxicj4NCivCoCDCoCDCoCDCoHJjID0g
LTE7PGJyPg0KK8KgIMKgIMKgIMKgZ290byBvdXQxOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0
aWMgaW50IGNoZWNrX2V4Y2x1ZGVkKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGNoYXIgKipleGNs
dWRlX2xpc3QpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBpbnQgaTs8YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgZm9yIChpID0gMDsgZXhjbHVkZV9saXN0W2ldOyBpKyspIHs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpZiAoc3RyY21wKGZpbGUsIGV4Y2x1ZGVfbGlzdFtpXSkgPT0gMCk8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gMTs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0K
K308YnI+DQorPGJyPg0KK2ludCBzZWxpbnV4X3Jlc3RvcmVjb24oY29uc3QgY2hhciAqKnBhdGhu
YW1lX2xpc3QsIGNvbnN0IGNoYXIgKipleGNsdWRlX2xpc3QsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3Qg
Y2hhciAqZmNfcGF0aCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgcmVzdG9yZWNvbl9mbGFn
cyk8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoGJvb2wgZm9yY2UgPSAocmVzdG9yZWNvbl9mbGFn
cyAmYW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTRUxJTlVYX1JFU1RPUkVD
T05fRk9SQ0VfQ0hFQ0spID8gdHJ1ZSA6IGZhbHNlOzxicj4NCivCoCDCoCDCoCDCoGJvb2wgbm9j
aGFuZ2UgPSAocmVzdG9yZWNvbl9mbGFncyAmYW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBTRUxJTlVYX1JFU1RPUkVDT05fTk9DSEFOR0UpID8gdHJ1ZSA6IGZhbHNlOzxicj4N
CivCoCDCoCDCoCDCoGJvb2wgY3VzdG9taXphYmxlID0gKHJlc3RvcmVjb25fZmxhZ3MgJmFtcDs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgU0VMSU5VWF9SRVNUT1JFQ09OX0NIQU5H
RV9DVVNUT01JWkFCTEUpID8gdHJ1ZSA6IGZhbHNlOzxicj4NCivCoCDCoCDCoCDCoC8qIHRydWUg
PSBjaGFuZ2UgZmlsZSBsYWJlbCB0byBzcGVjZmlsZSBlbnRyeSw8YnI+DQorwqAgwqAgwqAgwqAg
KiBmYWxzZSA9IG9ubHkgY2hhbmdlIHR5cGUgY29tcG9uZW50LiAqLzxicj4NCivCoCDCoCDCoCDC
oGJvb2wgY2hhbmdlY29udGV4dCA9IChyZXN0b3JlY29uX2ZsYWdzICZhbXA7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNFTElOVVhfUkVTVE9SRUNPTl9DSEFOR0VfVVNFUlJPTEVU
WVBFTEVWRUwpID8gdHJ1ZSA6IGZhbHNlOzxicj4NCivCoCDCoCDCoCDCoGJvb2wgdmVyYm9zZSA9
IChyZXN0b3JlY29uX2ZsYWdzICZhbXA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFNFTElOVVhfUkVTVE9SRUNPTl9WRVJCT1NFKSA/IHRydWUgOiBmYWxzZTs8YnI+DQorwqAgwqAg
wqAgwqBib29sIHJlY3Vyc2UgPSAocmVzdG9yZWNvbl9mbGFncyAmYW1wOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBTRUxJTlVYX1JFU1RPUkVDT05fUkVDVVJTRSkgPyB0cnVlIDog
ZmFsc2U7PGJyPg0KK8KgIMKgIMKgIMKgYm9vbCB2YWxpZGF0ZSA9IChyZXN0b3JlY29uX2ZsYWdz
ICZhbXA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNFTElOVVhfUkVTVE9SRUNP
Tl9WQUxJREFURSkgPyB0cnVlIDogZmFsc2U7PGJyPg0KK8KgIMKgIMKgIMKgYm9vbCB1c2VyZWFs
cGF0aCA9IChyZXN0b3JlY29uX2ZsYWdzICZhbXA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFNFTElOVVhfUkVTVE9SRUNPTl9SRUFMUEFUSCkgPyB0cnVlIDogZmFsc2U7PGJyPg0K
K8KgIMKgIMKgIMKgYm9vbCB4ZGV2ID0gKHJlc3RvcmVjb25fZmxhZ3MgJmFtcDs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgU0VMSU5VWF9SRVNUT1JFQ09OX1hERVYpID8gdHJ1ZSA6
IGZhbHNlOzxicj4NCivCoCDCoCDCoCDCoGJvb2wgaXNzeXM7PGJyPg0KK8KgIMKgIMKgIMKgYm9v
bCBzZXRyZXN0b3JlY29ubGFzdCA9IHRydWU7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHN0YXQg
c2I7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHN0YXRmcyBzZnNiOzxicj4NCivCoCDCoCDCoCDC
oEZUUyAqZnRzID0gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqBGVFNFTlQgKmZ0c2VudDs8YnI+DQor
wqAgwqAgwqAgwqBjaGFyICpwYXRobmFtZSA9IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgY2hhciAq
cGF0aHNbMl0gPSB7IE5VTEwgLCBOVUxMIH07PGJyPg0KK8KgIMKgIMKgIMKgaW50IGZ0c19mbGFn
cyA9IDAsIGVycm9yID0gMCwgaTs8YnI+DQorwqAgwqAgwqAgwqBjaGFyICoqc3BlY2ZpbGVzID0g
TlVMTDs8YnI+DQorwqAgwqAgwqAgwqB1bnNpZ25lZCBjaGFyICpkaWdlc3QgPSBOVUxMOzxicj4N
CivCoCDCoCDCoCDCoGludCBkaWdlc3RfbGVuLCBudW1fc3BlY2ZpbGVzOzxicj4NCivCoCDCoCDC
oCDCoHVuc2lnbmVkIGNoYXIgKnhhdHRyX3ZhbHVlID0gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqBj
aGFyICpzaGExX2J1ZiA9IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgc3NpemVfdCBzaXplLCBlbnRy
eTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFwYXRobmFtZV9saXN0KSB7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsaW51eF9sb2coU0VMSU5VWF9JTkZPLCAmcXVvdDtObyBw
YXRobmFtZXMgZ2l2ZW4uXG4mcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVy
cm5vID0gRUlOVkFMOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtMTs8YnI+
DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChpc19zZWxpbnV4X2Vu
YWJsZWQoKSAmbHQ7PSAwKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAwOzxi
cj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5XaHkgZmFrZSBhIHN1Y2Nlc3Mgd2hl
biB0aGUgZnVuY3Rpb24gZGlkIG5vdGhpbmc/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JdCBz
ZWVtcyB0aGF0IG5vIG90aGVyIGZ1bmN0aW9uIChlLmcuIGxzZXRmaWxlY29uKSBjaGVjayBpZiBz
ZWxpbnV4IGlzIGVuYWJsZWQuIFdoeSBpdCBpcyBvayB0bzwvZGl2PjxkaXY+c2V0IHNvbWUgc2Vs
aW51eCBjb250ZXh0IHVzaW5nIGxzZXRmaWxlY29uLCBhbmQgbm90IG9rIHRvIGdldCB0aGUgZGVm
YXVsdCBjb250ZXh0IGFuZCBzZXQgaXTCoDwvZGl2PjxkaXY+dXNpbmcgcmVzdG9yZWNvbj88L2Rp
dj48ZGl2PsKgPGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxl
ZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5n
LWxlZnQ6MWV4Ij4NCis8YnI+DQorwqAgwqAgwqAgwqBpID0gTlVNX1NFTEFCRUxfT1BUUzs8YnI+
DQorwqAgwqAgwqAgwqB3aGlsZSAoaS0tKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c3dpdGNoIChmY19vcHRzW2ldLnR5cGUpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBj
YXNlIFNFTEFCRUxfT1BUX1BBVEg6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZmNfb3B0c1tpXS52YWx1ZSA9IGZjX3BhdGg7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2Fz
ZSBTRUxBQkVMX09QVF9CQVNFT05MWTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBmY19vcHRzW2ldLnZhbHVlID0gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNl
IFNFTEFCRUxfT1BUX1ZBTElEQVRFOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGZjX29wdHNbaV0udmFsdWUgPSAodmFsaWRhdGUgPyAoY2hhciAqKTEgOiBOVUxMKTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIFNFTEFCRUxfT1BUX0RJR0VTVDo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmY19vcHRzW2ldLnZhbHVlID0gKGNoYXIgKikx
OyAvKiBNdXN0IHJlcXVlc3QgZGlnZXN0ICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivC
oCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgZmNfc2VoYW5kbGUgPSBzZWxhYmVs
X29wZW4oU0VMQUJFTF9DVFhfRklMRSwgZmNfb3B0cywgTlVNX1NFTEFCRUxfT1BUUyk7PGJyPg0K
K8KgIMKgIMKgIMKgaWYgKCFmY19zZWhhbmRsZSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHNlbGludXhfbG9nKFNFTElOVVhfRVJST1IsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7RXJyb3Igb2J0YWluaW5nIGZpbGUgY29udGV4dCBo
YW5kbGU6ICVzXG4mcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RyZXJyb3IoZXJy
bm8pKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KK8KgIMKg
IMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoc2VsYWJlbF9kaWdlc3QoZmNfc2Vo
YW5kbGUsICZhbXA7ZGlnZXN0LCAmYW1wO2RpZ2VzdF9sZW4sPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtzcGVjZmlsZXMsICZh
bXA7bnVtX3NwZWNmaWxlcykgJmx0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c2VsaW51eF9sb2coU0VMSU5VWF9FUlJPUiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtFcnJvciByZWFkaW5nIHNwZWNmaWxlcyBkaWdlc3Q6ICVz
XG4mcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RyZXJyb3IoZXJybm8pKTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxhYmVsX2Nsb3NlKGZjX3NlaGFuZGxlKTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KK8KgIMKgIMKgIMKgfTxi
cj4NCis8YnI+DQorwqAgwqAgwqAgwqB4YXR0cl92YWx1ZSA9IG1hbGxvYyhkaWdlc3RfbGVuKTs8
YnI+DQorwqAgwqAgwqAgwqBpZiAoIXhhdHRyX3ZhbHVlKTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybiAtMTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKHZlcmJvc2UpIHs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzaGExX2J1ZiA9IG1hbGxvYyhkaWdlc3RfbGVu
ICogMiArIDEpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghc2hhMV9idWYpPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgZGlnZXN0X2xl
bjsgaSsrKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNwcmludGYo
KCZhbXA7c2hhMV9idWZbaSAqIDJdKSwgJnF1b3Q7JTAyeCZxdW90OywgZGlnZXN0W2ldKTs8YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsaW51eF9sb2coU0VMSU5VWF9JTkZP
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O3Nw
ZWNmaWxlcyBTSEExIGRpZ2VzdDogJXNcbiZxdW90Oywgc2hhMV9idWYpOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHNlbGludXhfbG9nKFNFTElOVVhfSU5GTyw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtjYWxjdWxhdGVkIHVzaW5nIHRo
ZSBmb2xsb3dpbmcgc3BlY2ZpbGUocyk6XG4mcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmIChzcGVjZmlsZXMpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgbnVtX3NwZWNmaWxlczsgaSsrKTxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGludXhfbG9nKFNF
TElOVVhfSU5GTyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDslc1xuJnF1b3Q7LCBzcGVjZmlsZXNbaV0p
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoGlmICh4ZGV2KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGZ0c19mbGFncyA9IEZUU19QSFlTSUNBTCB8IEZUU19YREVWOzxicj4NCivCoCDCoCDCoCDCoGVs
c2U8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmdHNfZmxhZ3MgPSBGVFNfUEhZU0lDQUw7
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGZvciAoZW50cnkgPSAwOyBwYXRobmFtZV9saXN0W2Vu
dHJ5XTsgZW50cnkrKykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIE5lZWQgdG8g
cmVzZXQgYXMgY291bGQgaGF2ZSBiZWVuIHNldCBmYWxzZSAqLzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHNldHJlc3RvcmVjb25sYXN0ID0gdHJ1ZTs8YnI+DQorPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgLyogQ29udmVydCBwYXNzZWQtaW4gcGF0aG5hbWUgdG8gY2Fub25pY2Fs
IGZvcm0gaWYgcmVxdWlyZWQuICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHVz
ZXJlYWxwYXRoID09IHRydWUpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBwYXRobmFtZSA9IHJlYWxwYXRoKHBhdGhuYW1lX2xpc3RbZW50cnldLCBOVUxMKTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIXBhdGhuYW1lKSB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsaW51
eF9sb2coU0VMSU5VWF9FUlJPUiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtDb3VsZCBub3QgZ2V0IGNhbm9uaWNhbCBwYXRo
ICVzOiAlcy5cbiZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBwYXRobmFtZV9saXN0W2VudHJ5XSwgc3RyZXJyb3IoZXJybm8p
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBl
cnJvciA9IC0xOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGdvdG8gY2xlYW51cDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlIHs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwYXRobmFtZSA9IHN0cmR1cChwYXRobmFtZV9s
aXN0W2VudHJ5XSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
KGxzdGF0KHBhdGhuYW1lLCAmYW1wO3NiKSAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxpbnV4X2xvZyhTRUxJTlVYX0VSUk9S
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCZxdW90O0NvdWxkIG5vdCBzdGF0OiAlcyAlcy5cbiZxdW90Oyw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwYXRobmFtZV9saXN0
W2VudHJ5XSwgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcnJvciA9IC0xOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gY2xlYW51cDs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwYXRoc1swXSA9IHBhdGhu
YW1lOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlzc3lzID0gKCFzdHJjbXAocGF0aG5h
bWUsIFNZU19QQVRIKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHx8ICFzdHJuY21wKHBhdGhuYW1lLCBTWVNfUFJFRklYLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNpemVvZihTWVNfUFJFRklYKSAtIDEpKSA/IHRy
dWUgOiBmYWxzZTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCFyZWN1
cnNlKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJyb3IgPSBy
ZXN0b3JlY29uX3NiKHBhdGhuYW1lLCAmYW1wO3NiLCBub2NoYW5nZSw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2
ZXJib3NlLCBjdXN0b21pemFibGUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2hhbmdlY29udGV4dCk7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBjbGVhbnVwOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgLyogSWdub3JlIC9zeXMgc2luY2UgaXQgaXMgcmVnZW5lcmF0ZWQgb24gZWFjaCBib290LiAq
Lzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChpc3N5cyk8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZXRyZXN0b3JlY29ubGFzdCA9IGZhbHNlOzxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBJZ25vcmUgZmlsZXMgb24gaW4tbWVt
b3J5IGZpbGVzeXN0ZW1zICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHN0YXRm
cyhwYXRobmFtZSwgJmFtcDtzZnNiKSA9PSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKHNmc2IuZl90eXBlID09IFJBTUZTX01BR0lDIHx8PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgc2ZzYi5mX3R5cGUgPT0gVE1QRlNfTUFHSUMpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2V0cmVzdG9yZWNvbmxhc3QgPSBmYWxzZTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIChzZXRyZXN0b3JlY29ubGFzdCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHNpemUgPSBnZXR4YXR0cihwYXRobmFtZSwgUkVTVE9SRUNPTl9M
QVNULCB4YXR0cl92YWx1ZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZGlnZXN0X2xlbik7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChzaXplICZsdDsgMCAmYW1wOyZhbXA7IGVycm5vID09IEVOT1RTVVAp
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29u
dGludWU7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
ICh2ZXJib3NlICZhbXA7JmFtcDsgc2l6ZSA9PSBkaWdlc3RfbGVuKSB7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7
IGRpZ2VzdF9sZW47IGkrKyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzcHJpbnRmKCZhbXA7KHNoYTFfYnVmW2kgKiAyXSks
ICZxdW90OyUwMngmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
eGF0dHJfdmFsdWVbaV0pOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHNlbGludXhfbG9nKFNFTElOVVhfSU5GTyw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVv
dDtFbnRyeTogJXMgaGFzIFNIQTEgZGlnZXN0OiAlc1xuJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBwYXRobmFtZSwgc2hhMV9idWYpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoH0gZWxzZSBpZiAodmVyYm9zZSAmYW1wOyZhbXA7IHNpemUgIT0gZGlnZXN0
X2xlbikgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHNlbGludXhfbG9nKFNFTElOVVhfSU5GTyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtFbnRyeTogJXMgaGFzIG5vIHZh
bGlkIFNIQTEgZGlnZXN0XG4mcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcGF0aG5hbWUpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaWYgKCFmb3JjZSAmYW1wOyZhbXA7IHNpemUgPT0gZGlnZXN0X2xlbiAmYW1wOyZhbXA7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIG1lbWNtcChkaWdlc3QsIHhhdHRyX3ZhbHVlLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaWdl
c3RfbGVuKSA9PSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc2VsaW51eF9sb2coU0VMSU5VWF9JTkZPLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtT
a2lwcGluZyByZWN1cnNpdmUgZW50cnk6ICVzXG4mcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhdGhuYW1l
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBl
cnJvciA9IDA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZ290byBjbGVhbnVwOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGZ0cyA9IGZ0c19vcGVuKHBhdGhzLCBmdHNfZmxhZ3MsIE5VTEwpOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghZnRzKSB7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsaW51eF9sb2coU0VMSU5VWF9FUlJPUiw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVv
dDtGVFMgb3BlbiBlcnJvcjogJXMuXG4mcXVvdDssIHN0cmVycm9yKGVycm5vKSk7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJyb3IgPSAtMTs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGNsZWFudXA7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcnJv
ciA9IDA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgd2hpbGUgKChmdHNlbnQgPSBmdHNf
cmVhZChmdHMpKSAhPSBOVUxMKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgc3dpdGNoIChmdHNlbnQtJmd0O2Z0c19pbmZvKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBGVFNfREM6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsaW51eF9sb2coU0VMSU5VWF9FUlJPUiw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAmcXVvdDtEaXJlY3RvcnkgY3ljbGUgb24gJXMuXG4mcXVvdDssPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnRzZW50LSZndDtmdHNfcGF0aCk7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJybm8gPSBFTE9P
UDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBl
cnJvciA9IC0xOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCh2b2lkKSBmdHNfY2xvc2UoZnRzKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGNsZWFudXA7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBGVFNfRFA6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGludWU7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBGVFNfRE5SOjxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGludXhfbG9nKFNFTElOVVhf
RVJST1IsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgJnF1b3Q7Q291bGQgbm90IHJlYWQgJXM6ICVzLlxuJnF1b3Q7LDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGZ0c2VudC0mZ3Q7ZnRzX3BhdGgsIHN0cmVycm9yKGVycm5vKSk7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnRzX3NldChmdHMs
IGZ0c2VudCwgRlRTX1NLSVApOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNvbnRpbnVlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNhc2UgRlRTX05TOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHNlbGludXhfbG9nKFNFTElOVVhfRVJST1IsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1
b3Q7Q291bGQgbm90IHN0YXQgJXM6ICVzLlxuJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZ0c2VudC0m
Z3Q7ZnRzX3BhdGgsIHN0cmVycm9yKGVycm5vKSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnRzX3NldChmdHMsIGZ0c2VudCwgRlRTX1NLSVAp
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNv
bnRpbnVlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgRlRT
X0VSUjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzZWxpbnV4X2xvZyhTRUxJTlVYX0VSUk9SLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O0Vycm9yIG9uICVzOiAl
cy5cbiZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmdHNlbnQtJmd0O2Z0c19wYXRoLCBzdHJlcnJvcihl
cnJubykpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGZ0c19zZXQoZnRzLCBmdHNlbnQsIEZUU19TS0lQKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEZUU19EOjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChpc3N5cyAmYW1wOyZhbXA7ICFz
ZWxhYmVsX3BhcnRpYWxfbWF0Y2g8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoZmNfc2VoYW5kbGUsIGZ0c2VudC0m
Z3Q7ZnRzX3BhdGgpKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnRzX3NldChmdHMsIGZ0c2VudCwgRlRTX1NLSVApOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGNvbnRpbnVlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAvKiBmYWxsIHRocm91Z2ggKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIChleGNsdWRlX2xpc3QpIHs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoY2hlY2tf
ZXhjbHVkZWQoZnRzZW50LSZndDtmdHNfcGF0aCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBleGNsdWRlX2xpc3QpKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnRzX3NldChm
dHMsIGZ0c2VudCwgRlRTX1NLSVApOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnRpbnVlOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ZXJyb3IgfD0gcmVzdG9yZWNvbl9zYihmdHNlbnQtJmd0O2Z0c19wYXRoLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGZ0c2VudC0mZ3Q7ZnRzX3N0YXRwLCBub2NoYW5nZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2ZXJib3NlLCBj
dXN0b21pemFibGUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2hhbmdlY29udGV4dCk7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnRzX2Nsb3NlKGZ0cyk7
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIExhYmVsaW5nIHN1Y2Nlc3Nm
dWwuIE1hcmsgdG9wIGxldmVsIGRpcmVjdG9yeSBjb21wbGV0ZWQuICovPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKHNldHJlc3RvcmVjb25sYXN0ICZhbXA7JmFtcDsgIW5vY2hhbmdl
ICZhbXA7JmFtcDsgIWVycm9yKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZXJyb3IgPSBzZXR4YXR0cihwYXRobmFtZSwgUkVTVE9SRUNPTl9MQVNULCBkaWdlc3Qs
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGlnZXN0X2xlbiwgMCk7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCFlcnJvciAmYW1wOyZh
bXA7IHZlcmJvc2UpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc2VsaW51eF9sb2coU0VMSU5VWF9JTkZPLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtVcGRh
dGVkIFNIQTEgZGlnZXN0IGZvcjogJXNcbiZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcGF0aG5hbWUpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08
YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCitjbGVhbnVwOjxicj4NCivCoCDCoCDCoCDC
oHNlbGFiZWxfY2xvc2UoZmNfc2VoYW5kbGUpOzxicj4NCivCoCDCoCDCoCDCoGZyZWUocGF0aG5h
bWUpOzxicj4NCivCoCDCoCDCoCDCoGZyZWUoeGF0dHJfdmFsdWUpOzxicj4NCivCoCDCoCDCoCDC
oGlmICh2ZXJib3NlKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWUoc2hhMV9idWYp
Ozxicj4NCivCoCDCoCDCoCDCoHJldHVybiBlcnJvcjs8YnI+DQorfTxicj4NCmRpZmYgLS1naXQg
YS9saWJzZWxpbnV4L3V0aWxzL01ha2VmaWxlIGIvbGlic2VsaW51eC91dGlscy9NYWtlZmlsZTxi
cj4NCmluZGV4IDVkZGE2NmUuLjgwNjgyOTEgMTAwNjQ0PGJyPg0KLS0tIGEvbGlic2VsaW51eC91
dGlscy9NYWtlZmlsZTxicj4NCisrKyBiL2xpYnNlbGludXgvdXRpbHMvTWFrZWZpbGU8YnI+DQpA
QCAtMzAsNiArMzAsOCBAQCBUQVJHRVRTPSQocGF0c3Vic3QgJS5jLCUsJCh3aWxkY2FyZCAqLmMp
KTxicj4NCjxicj4NCsKgc2VmY29udGV4dF9jb21waWxlOiBMRExJQlMgKz0gLWxwY3JlIC1sY3J5
cHRvIC4uL3NyYy9saWJzZWxpbnV4LmEgLWxzZXBvbDxicj4NCjxicj4NCitzZWxpbnV4X3Jlc3Rv
cmVjb246IExETElCUyArPSAtbHNlcG9sPGJyPg0KKzxicj4NCsKgaWZlcSAoJChESVNBQkxFX0FW
QykseSk8YnI+DQrCoCDCoCDCoCDCoCBVTlVTRURfVEFSR0VUUys9Y29tcHV0ZV9hdiBjb21wdXRl
X2NyZWF0ZSBjb21wdXRlX21lbWJlciBjb21wdXRlX3JlbGFiZWw8YnI+DQrCoGVuZGlmPGJyPg0K
ZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvdXRpbHMvc2VsaW51eF9yZXN0b3JlY29uLmMgYi9saWJz
ZWxpbnV4L3V0aWxzL3NlbGludXhfcmVzdG9yZWNvbi5jPGJyPg0KbmV3IGZpbGUgbW9kZSAxMDA2
NDQ8YnI+DQppbmRleCAwMDAwMDAwLi4zNWFkODFmPGJyPg0KLS0tIC9kZXYvbnVsbDxicj4NCisr
KyBiL2xpYnNlbGludXgvdXRpbHMvc2VsaW51eF9yZXN0b3JlY29uLmM8YnI+DQpAQCAtMCwwICsx
LDIxNSBAQDxicj4NCisjaW5jbHVkZSAmbHQ7c3RkaW8uaCZndDs8YnI+DQorI2luY2x1ZGUgJmx0
O3N0ZGxpYi5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7c3RyaW5nLmgmZ3Q7PGJyPg0KKyNpbmNs
dWRlICZsdDtnZXRvcHQuaCZndDs8YnI+DQorI2luY2x1ZGUgJmx0O2Vycm5vLmgmZ3Q7PGJyPg0K
KyNpbmNsdWRlICZsdDtzZXBvbC9zZXBvbC5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7c2VsaW51
eC9zZWxpbnV4LmgmZ3Q7PGJyPg0KKzxicj4NCitzdGF0aWMgY2hhciAqcG9saWN5ZmlsZTs8YnI+
DQorPGJyPg0KK3N0YXRpYyBjaGFyICoqZXhjbHVkZV9saXN0Ozxicj4NCitzdGF0aWMgaW50IGV4
Y2x1ZGVfY291bnQ7PGJyPg0KKzxicj4NCitzdGF0aWMgaW50IHZhbGlkYXRlX2NvbnRleHQoY2hh
ciAqKmNvbnRleHRwKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgY2hhciAqY29udGV4dCA9ICpj
b250ZXh0cCwgKnRtcGNvbjs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKHBvbGljeWZpbGUp
IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc2Vwb2xfY2hlY2tfY29udGV4dChj
b250ZXh0KSAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7SW52YWxpZCBjb250ZXh0ICVzXG4mcXVvdDssIGNvbnRl
eHQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGV4aXQoLTEpOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqB9IGVsc2UgaWYg
KHNlY3VyaXR5X2Nhbm9uaWNhbGl6ZV9jb250ZXh0X3Jhdyhjb250ZXh0LCAmYW1wO3RtcGNvbikg
PT0gMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWUoY29udGV4dCk7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKmNvbnRleHRwID0gdG1wY29uOzxicj4NCivCoCDCoCDC
oCDCoH0gZWxzZSBpZiAoZXJybm8gIT0gRU5PRU5UKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O1ZhbGlkYXRlIGNvbnRleHQgZXJyb3I6ICVzXG4m
cXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBleGl0KC0xKTs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoHJldHVybiAwOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMg
dm9pZCB1c2FnZShjb25zdCBjaGFyICpwcm9nbmFtZSk8YnI+DQorezxicj4NCivCoCDCoCDCoCDC
oGZwcmludGYoc3RkZXJyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O1xudXNh
Z2U6ICVzIFstRm5jbFJ2cmRlXSBbLXAgcG9saWN5XSBbLWYgc3BlY2ZpbGVdICZxdW90Ozxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O3BhdGhuYW1lIC4uLlxuJnF1b3Q7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7V2hlcmU6XG5cdCZxdW90Ozxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90Oy1GwqAgRm9yY2UgdGhlIGNoZWNraW5nIG9mIGxhYmVs
cyBldmVuIGlmIHRoZSBzdG9yZWQgU0hBMVxuXHQmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAmcXVvdDvCoCDCoCBkaWdlc3QgbWF0Y2hlcyB0aGUgc3BlY2ZpbGVzIFNIQTEgZGln
ZXN0LlxuXHQmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDstbsKgIERv
biYjMzk7dCBjaGFuZ2UgYW55IGZpbGUgbGFiZWxzIChwYXNzaXZlIGNoZWNrKS5cblx0JnF1b3Q7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7LWPCoCBSZXNldCBjdXN0b21pemFi
bGUgZmlsZSBsYWJlbCB0byBtYXRjaCBzcGVjZmlsZS5cblx0JnF1b3Q7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgJnF1b3Q7LWzCoCBSZXNldCBmaWxlIGxhYmVsIHRvIHRoYXQgaW4gc3Bl
YyBmaWxlLiBJZiB0aGlzIG9wdGlvblxuXHQmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAmcXVvdDvCoCDCoCBpcyBOT1Qgc2V0IHRoZSBkZWZhdWx0IG9wZXJhdGlvbiBpcyB0byBv
bmx5IHJlc2V0IHRoZVxuXHQmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVv
dDvCoCDCoCBcJnF1b3Q7dHlwZVwmcXVvdDsgY29tcG9uZW50IG9mIHRoZSBsYWJlbCB0byB0aGF0
IGluIHRoZSAmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtzcGVjZmls
ZS5cblx0JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7LVLCoCBSZWN1
cnNpdmVseSBjaGFuZ2UgZmlsZXMgYW5kIGRpcmVjdG9yeSBsYWJlbHMuXG5cdCZxdW90Ozxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90Oy12wqAgU2hvdyBjaGFuZ2VzIGluIGZpbGUg
bGFiZWxzLCBBbHNvIHNwZWNmaWxlcyB1c2VkIHRvIGNhbGNcblx0JnF1b3Q7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7wqAgwqAgU0hBMSBkaWdlc3QgcGx1cyBkaWdlc3QuXG5c
dCZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90Oy1ywqAgVXNlIHJlYWxw
YXRoKDMpIHRvIGNvbnZlcnQgcGF0aG5hbWVzIHRvIGNhbm9uaWNhbCBmb3JtLlxuXHQmcXVvdDs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDstZMKgIFByZXZlbnQgZGVzY2VuZGlu
ZyBpbnRvIGRpcmVjdG9yaWVzIHRoYXQgaGF2ZSBhICZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCZxdW90O2RpZmZlcmVudFxuXHTCoCDCoCBkZXZpY2UgbnVtYmVyIHRoYW4gdGhl
IHBhdGhuYW1lIGZyb23CoCB3aGljaCAmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAmcXVvdDt0aGUgZGVzY2VudCBiZWdhbi5cblx0JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgJnF1b3Q7LWXCoCBFeGNsdWRlIHRoaXMgZmlsZS9kaXJlY3RvcnkgKGFkZCBtdWx0
aXBsZSAtZSBlbnRyaWVzKS5cblx0JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
JnF1b3Q7LXDCoCBPcHRpb25hbCBiaW5hcnkgcG9saWN5IGZpbGUgKGFsc28gc2V0cyB0aGUgdmFs
aWRhdGVcblx0JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7wqAgwqAg
Y29udGV4dCBvcHRpb24pLlxuXHQmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAm
cXVvdDstZsKgIE9wdGlvbmFsIGZpbGUgY29udGV4dHMgZmlsZSAoZGVmYXVsdHMgdG8gdGhvc2Ug
dXNlZCBieVxuXHQmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDvCoCDC
oCBsb2FkZWQgcG9saWN5KS5cblx0JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
JnF1b3Q7cGF0aG5hbWXCoCBPbmUgb3IgbW9yZSBwYXRocyB0byByZWxhYmVsLlxuXG4mcXVvdDss
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJvZ25hbWUpOzxicj4NCivCoCDCoCDCoCDC
oGV4aXQoLTEpOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgdm9pZCBhZGRfZXhjbHVkZShj
b25zdCBjaGFyICpkaXJlY3RvcnkpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBjaGFyICoqdG1w
X2xpc3Q7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChkaXJlY3RvcnkgPT0gTlVMTCB8fCBk
aXJlY3RvcnlbMF0gIT0gJiMzOTsvJiMzOTspIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7RnVsbCBwYXRoIHJlcXVpcmVkIGZvciBleGNsdWRlOiAl
cy5cbiZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkaXJl
Y3RvcnkpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGV4aXQoLTEpOzxicj4NCivCoCDC
oCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgLyogQWRkIGFub3RoZXIgdHdvIGVudHJp
ZXMsIG9uZSBmb3IgZGlyZWN0b3J5LCBhbmQgdGhlIG90aGVyIHRvPGJyPg0KK8KgIMKgIMKgIMKg
ICogdGVybWluYXRlIHRoZSBsaXN0ICovPGJyPg0KK8KgIMKgIMKgIMKgdG1wX2xpc3QgPSByZWFs
bG9jKGV4Y2x1ZGVfbGlzdCwgc2l6ZW9mKGNoYXIgKikgKiAoZXhjbHVkZV9jb3VudCArIDIpKTs8
YnI+DQorwqAgwqAgwqAgwqBpZiAoIXRtcF9saXN0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O0VSUk9SOiByZWFsbG9jIGZhaWxlZC5cbiZxdW90
Oyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXhpdCgtMSk7PGJyPg0KK8KgIMKgIMKg
IMKgfTxicj4NCivCoCDCoCDCoCDCoGV4Y2x1ZGVfbGlzdCA9IHRtcF9saXN0Ozxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqBleGNsdWRlX2xpc3RbZXhjbHVkZV9jb3VudF0gPSBzdHJkdXAoZGlyZWN0
b3J5KTs8YnI+DQorwqAgwqAgwqAgwqBpZiAoIWV4Y2x1ZGVfbGlzdFtleGNsdWRlX2NvdW50XSkg
ezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAmcXVvdDtFUlJP
Ujogc3RyZHVwIGZhaWxlZC5cbiZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ZXhpdCgtMSk7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoGV4Y2x1ZGVfY291
bnQrKzs8YnI+DQorwqAgwqAgwqAgwqBleGNsdWRlX2xpc3RbZXhjbHVkZV9jb3VudF0gPSBOVUxM
Ozxicj4NCit9PGJyPg0KKzxicj4NCitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpPGJy
Pg0KK3s8YnI+DQorwqAgwqAgwqAgwqBpbnQgcmMsIG9wdCwgaSwgbnVtX3BhdGhzLCBzdHJpbmdf
bGVuOzxicj4NCivCoCDCoCDCoCDCoGNoYXIgKipwYXRocyA9IE5VTEw7PGJyPg0KK8KgIMKgIMKg
IMKgdW5zaWduZWQgaW50IHJlc3RvcmVjb25fZmxhZ3MgPSAwOzxicj4NCivCoCDCoCDCoCDCoGNo
YXIgKmZjX25hbWUgPSBOVUxMOzxicj4NCivCoCDCoCDCoCDCoEZJTEUgKnBvbGljeXN0cmVhbTs8
YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGFyZ2MgJmx0OyAyKTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHVzYWdlKGFyZ3ZbMF0pOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBleGNs
dWRlX2xpc3QgPSBOVUxMOzxicj4NCivCoCDCoCDCoCDCoGV4Y2x1ZGVfY291bnQgPSAwOzxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqB3aGlsZSAoKG9wdCA9IGdldG9wdChhcmdjLCBhcmd2LCAmcXVv
dDtGbmNsUnZyZGU6ZjpwOiZxdW90OykpICZndDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHN3aXRjaCAob3B0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSAm
IzM5O0YmIzM5Ozo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN0
b3JlY29uX2ZsYWdzIHw9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgU0VMSU5VWF9SRVNUT1JFQ09OX0ZPUkNFX0NIRUNLOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGNhc2UgJiMzOTtuJiMzOTs6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmVzdG9yZWNvbl9mbGFncyB8PSBTRUxJTlVYX1JFU1RPUkVDT05fTk9D
SEFOR0U7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSAmIzM5O2MmIzM5Ozo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN0b3JlY29uX2ZsYWdzIHw9PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNFTElOVVhf
UkVTVE9SRUNPTl9DSEFOR0VfQ1VTVE9NSVpBQkxFOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2Ug
JiMzOTtsJiMzOTs6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVz
dG9yZWNvbl9mbGFncyB8PTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBTRUxJTlVYX1JFU1RPUkVDT05fQ0hBTkdFX1VTRVJST0xFVFlQRUxF
VkVMOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgJiMzOTtSJiMzOTs6PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVzdG9yZWNvbl9mbGFncyB8PSBTRUxJTlVYX1JF
U1RPUkVDT05fUkVDVVJTRTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlICYjMzk7diYjMzk7Ojxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3RvcmVjb25fZmxhZ3Mg
fD3CoCBTRUxJTlVYX1JFU1RPUkVDT05fVkVSQk9TRTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNl
ICYjMzk7ciYjMzk7Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
c3RvcmVjb25fZmxhZ3MgfD0gU0VMSU5VWF9SRVNUT1JFQ09OX1JFQUxQQVRIOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNhc2UgJiMzOTtkJiMzOTs6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmVzdG9yZWNvbl9mbGFncyB8PSBTRUxJTlVYX1JFU1RPUkVDT05fWERFVjs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlICYjMzk7ZSYjMzk7Ojxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFkZF9leGNsdWRlKG9wdGFyZyk7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgY2FzZSAmIzM5O3AmIzM5Ozo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBwb2xpY3lmaWxlID0gb3B0YXJnOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBwb2xpY3lzdHJlYW0gPSBmb3Blbihwb2xpY3lmaWxlLCAmcXVv
dDtyJnF1b3Q7KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
IXBvbGljeXN0cmVhbSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O0Vycm9yIG9wZW5pbmcg
JXM6ICVzXG4mcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcG9saWN5ZmlsZSwgc3RyZXJyb3IoZXJybm8pKTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBleGl0KC0x
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzZXBvbF9zZXRfcG9saWN5
ZGJfZnJvbV9maWxlKHBvbGljeXN0cmVhbSkgJmx0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
JnF1b3Q7RXJyb3IgcmVhZGluZyBwb2xpY3kgJXM6ICVzXG4mcXVvdDssPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcG9saWN5
ZmlsZSwgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBleGl0KC0xKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ZmNsb3NlKHBvbGljeXN0cmVhbSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmVzdG9yZWNvbl9mbGFncyB8PSBTRUxJTlVYX1JFU1RPUkVDT05fVkFMSURBVEU7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsaW51eF9zZXRfY2FsbGJh
Y2soU0VMSU5VWF9DQl9WQUxJREFURSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAodW5pb24gc2VsaW51eF9jYWxsYmFjaykmYW1wO3Zh
bGlkYXRlX2NvbnRleHQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgJiMzOTtmJiMzOTs6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmNfbmFtZSA9IG9wdGFyZzs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHVzYWdlKGFyZ3ZbMF0pOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oH08YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIENvdW50IHBh
dGhzICovPGJyPg0KK8KgIMKgIMKgIMKgZm9yIChpID0gb3B0aW5kLCBudW1fcGF0aHMgPSAwOyBp
ICZsdDsgYXJnYzsgaSsrLCBudW1fcGF0aHMrKyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChudW1fcGF0aHMpIHs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBwYXRocyA9IGNhbGxvYyhudW1fcGF0aHMgKyAxLCBzaXplb2YoY2hh
ciAqKSk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghcGF0aHMpIHs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwg
JnF1b3Q7RVJST1I6IGNhbGxvYyBmYWlsZWQuXG4mcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGV4aXQoLTEpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIChpID0gb3B0aW5k
LCBudW1fcGF0aHMgPSAwOyBpICZsdDsgYXJnYzsgaSsrLCBudW1fcGF0aHMrKykgezxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cmluZ19sZW4gPSBzdHJsZW4oYXJn
dltpXSkgKyAxOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBhdGhz
W251bV9wYXRoc10gPSBtYWxsb2Moc3RyaW5nX2xlbik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgKCFwYXRoc1tudW1fcGF0aHNdKSB7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZx
dW90O0VSUk9SOiBtYWxsb2MgZmFpbGVkLlxuJnF1b3Q7KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBleGl0KC0xKTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3RyY3B5KHBhdGhzW251bV9wYXRoc10sIGFyZ3ZbaV0pOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDC
oCDCoCDCoHJjID0gc2VsaW51eF9yZXN0b3JlY29uKChjb25zdCBjaGFyICoqKXBhdGhzLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoChjb25zdCBjaGFyICoqKWV4Y2x1ZGVfbGlzdCw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmY19u
YW1lLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJlc3RvcmVjb25fZmxhZ3MpOzxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqBpZiAocmMpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIs
ICZxdW90O3NlbGludXhfcmVzdG9yZWNvbiBlcnJvcjogJXNcbiZxdW90Oyw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzdHJlcnJvcihlcnJubykpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBp
ZiAocGF0aHMpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBwYXRo
c1tpXTsgaSsrKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWUo
cGF0aHNbaV0pOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWUocGF0aHMpOzxicj4N
CivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGV4Y2x1ZGVfbGlzdCkg
ezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGV4Y2x1ZGVfbGlzdFtp
XTsgaSsrKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWUoZXhj
bHVkZV9saXN0W2ldKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKGV4Y2x1ZGVf
bGlzdCk7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqByZXR1cm4g
cmM7PGJyPg0KK308YnI+DQo8c3BhbiBjbGFzcz0iIj48Zm9udCBjb2xvcj0iIzg4ODg4OCI+LS08
YnI+DQoyLjQuMzxicj4NCjxicj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fPGJyPg0KU2VsaW51eCBtYWlsaW5nIGxpc3Q8YnI+DQo8YSBocmVmPSJtYWls
dG86U2VsaW51eEB0eWNoby5uc2EuZ292Ij5TZWxpbnV4QHR5Y2hvLm5zYS5nb3Y8L2E+PGJyPg0K
VG8gdW5zdWJzY3JpYmUsIHNlbmQgZW1haWwgdG8gPGEgaHJlZj0ibWFpbHRvOlNlbGludXgtbGVh
dmVAdHljaG8ubnNhLmdvdiI+U2VsaW51eC1sZWF2ZUB0eWNoby5uc2EuZ292PC9hPi48YnI+DQpU
byBnZXQgaGVscCwgc2VuZCBhbiBlbWFpbCBjb250YWluaW5nICZxdW90O2hlbHAmcXVvdDsgdG8g
PGEgaHJlZj0ibWFpbHRvOlNlbGludXgtcmVxdWVzdEB0eWNoby5uc2EuZ292Ij5TZWxpbnV4LXJl
cXVlc3RAdHljaG8ubnNhLmdvdjwvYT4uPGJyPg0KPC9mb250Pjwvc3Bhbj48L2Jsb2NrcXVvdGU+
PC9kaXY+PGJyPjwvZGl2PjwvZGl2Pg0K
--047d7ba982d4de1b4f0520c20cd2--
