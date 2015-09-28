Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8SE3xWQ014992
 for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2015 10:03:59 -0400
Date: Mon, 28 Sep 2015 14:00:58 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <734934740.2847960.1443448858200.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <CAMRbyysbJh9jRzoZT=my1vAJYy6PnR3k3dk15PmhT=FVNJHcAw@mail.gmail.com>
References: <CAMRbyysbJh9jRzoZT=my1vAJYy6PnR3k3dk15PmhT=FVNJHcAw@mail.gmail.com>
Subject: Re: [RFC PATCH V2] libselinux: Add selinux_restorecon function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>






On Sunday, 27 September 2015, 23:24, Nir Soffer <nsoffer@redhat.com> wrote:


>
>
>On Sun, Sep 27, 2015 at 3:06 PM, Richard Haines <richard_c_haines@btinternet.com> wrote:
>
>The selinux_restorecon(3) man page details this function that relies
>>on the selabel_digest(3) function available from [1] (as not yet
>>part of upstream libselinux).
>>
>>It has been built using the work from Android where an SHA1 hash
>>of the specfiles is held in an extended attribute to enhance
>>performance. Also contains components from policycoreutils/setfiles.
>>
>>The utils/selinux_restorecon.c utility demonstrates the functionality.
>>
>>[1] http://marc.info/?l=selinux&m=144274383217343&w=2
>>
>>Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>---
>>V2 Changes:
>>Added exclude_list to function, updated util to test and man page
>>Fixed xdev to use fts correctly.
>>
>> libselinux/include/selinux/selinux.h     |  28 ++
>> libselinux/man/man3/selinux_restorecon.3 | 200 ++++++++++++++
>> libselinux/src/Makefile                  |   2 +-
>> libselinux/src/selinux_restorecon.c      | 443 +++++++++++++++++++++++++++++++
>> libselinux/utils/Makefile                |   2 +
>> libselinux/utils/selinux_restorecon.c    | 215 +++++++++++++++
>> 6 files changed, 889 insertions(+), 1 deletion(-)
>> create mode 100644 libselinux/man/man3/selinux_restorecon.3
>> create mode 100644 libselinux/src/selinux_restorecon.c
>> create mode 100644 libselinux/utils/selinux_restorecon.c
>>
>>diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
>>index 4beb170..c5228a6 100644
>>--- a/libselinux/include/selinux/selinux.h
>>+++ b/libselinux/include/selinux/selinux.h
>>@@ -663,6 +663,34 @@ extern int selinux_lsetfilecon_default(const char *path);
>>  */
>> extern void selinux_reset_config(void);
>>
>>+
>>+/* Force the checking of labels even if the stored SHA1
>>+ * digest matches the specfiles SHA1 digest. */
>>+#define SELINUX_RESTORECON_FORCE_CHECK         1
>>+/* Do not change file labels */
>>+#define SELINUX_RESTORECON_NOCHANGE                    2
>>+/* If set change the files label to that in spec file.
>>+ * If not set only change the type component to that in spec file. */
>>+#define SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL    4
>>+/* Reset customizable types */
>>+#define SELINUX_RESTORECON_CHANGE_CUSTOMIZABLE         8
>>+/* Recurse through the directory path */
>>+#define SELINUX_RESTORECON_RECURSE                     16
>>+/* Log changes and show specfiles SHA1 digest */
>>+#define SELINUX_RESTORECON_VERBOSE                     32
>>+/* Set selabel_open(3) option SELABEL_OPT_VALIDATE */
>>+#define SELINUX_RESTORECON_VALIDATE                    64
>>+/* Convert passed-in pathname to canonical pathname */
>>+#define SELINUX_RESTORECON_REALPATH                    128
>>+/* Prevent descending into directories that have a different
>>+ * device number than the pathname from which the descent began */
>>+#define SELINUX_RESTORECON_XDEV                                256
>>+
>>+extern int selinux_restorecon(const char **pathname_list,
>>+                                   const char **exclude_list,
>>+                                   const char *fc_path,
>>+                                   unsigned int restorecon_flags);
>>+
>> #ifdef __cplusplus
>> }
>> #endif
>>diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
>>new file mode 100644
>>index 0000000..3dfdbd3
>>--- /dev/null
>>+++ b/libselinux/man/man3/selinux_restorecon.3
>>@@ -0,0 +1,200 @@
>>+.TH "selinux_restorecon" "3" "22 Sept 2015" "Security Enhanced Linux" "SELinux API documentation"
>>+
>>+.SH "NAME"
>>+selinux_restorecon \- restore file(s) default SELinux security contexts
>>+.
>>+.SH "SYNOPSIS"
>>+.B #include <selinux/selinux.h>
>>+.sp
>>+.BI "int selinux_restorecon(const char **" pathname_list ,
>>+.in +\w'int selinux_restorecon('u
>>+.BI "const char **" exclude_list ,
>>+.br
>>+.BI "const char *" fc_path ,
>>+.br
>>+.BI "unsigned int " restorecon_flags ");"
>>+.in
>>+.
>>+.SH "DESCRIPTION"
>>+.BR selinux_restorecon ()
>>+restores file default security contexts based on:
>>+.sp
>>+.RS
>>+.IR pathname_list
>>+containing a
>>+.B NULL
>>+terminated list of one or more directories or files to be relabeled.
>>+.br
>>+If the
>>+.IR restorecon_flags
>>+.B SELINUX_RESTORECON_RECURSE
>>+has been set (for decending through directories), then for each
>>+.IR pathname_list
>>+entry specified
>>+.BR selinux_restorecon ()
>>+will write an SHA1 digest of the combined specfiles (see the
>>+.B NOTES
>>+section for details) to an extended attribute of
>>+.IR security.restorecon_last
>>+once the relabeling has been completed successfully. This digest will be
>>+checked should
>>+.BR selinux_restorecon ()
>>+be rerun
>>+with the
>>+.IR restorecon_flags
>>+.B SELINUX_RESTORECON_RECURSE
>>+flag set. If any of the specfiles had been updated, the digest
>>+will also be updated. However if the digest is the same, no relabeling checks
>>+will take place unless the
>>+.IR restorecon_flags
>>+.B SELINUX_ANDROID_RESTORECON_FORCE_CHECK
>>+flag is also set.
>>+.sp
>>+.IR exclude_list
>>+containing a
>>+.B NULL
>>+terminated list of zero or more directories or files that are not to be
>>+relabeled.
>>+.sp
>>+.IR fc_path
>>+containing an optional specfile to provide the file labeling
>>+details (see
>>+.BR selabel_file (5)
>>+for details of the file format).
>>+.br
>>+If set to
>>+.B NULL
>>+then the currently loaded policy specfiles will be used.
>>+.sp
>>+.IR restorecon_flags
>>+contains the labeling option/rules as follows:
>>+.sp
>>+.RS
>>+.B SELINUX_ANDROID_RESTORECON_FORCE_CHECK
>>+force the checking of labels even if the stored SHA1 digest matches the
>>+specfiles SHA1 digest.
>>+.sp
>>+.B SELINUX_RESTORECON_NOCHANGE
>>+don't change any file labels (passive check).
>>+.sp
>>+.B SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL
>>+if set, reset the files label to match the default specfile context
>>+(i.e. change user, role, type and range).
>>+.br
>>+If not set, then only reset the files "type" component of the context to
>>+match the default specfile context.
>>+.sp
>>+.B SELINUX_RESTORECON_CHANGE_CUSTOMIZABLE
>>+reset customized file labels (see
>>+.BR is_context_customizable (3))
>>+to match the default specfile context. Use the
>>+.B SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL
>>+flag to determine the components to change.
>>+.sp
>>+.B SELINUX_RESTORECON_VERBOSE
>>+show changes in file labels and display the SHA1 digests in hex format.
>>+.sp
>>+.B SELINUX_RESTORECON_RECURSE
>>+change file and directory labels recursively (descend directories)
>>+and if successful write an SHA1 digest of the combined specfiles to an
>>+extended attribute as described in the
>>+.B NOTES
>>+section.
>>+.sp
>>+.B SELINUX_RESTORECON_VALIDATE
>>+set the global
>>+.B SELABEL_OPT_VALIDATE
>>+option that will cause the security contexts in the specfiles to be
>>+validated against policy as described in
>>+.BR selabel_open (3).
>>+.br
>>+Note that if custom context validation is required, the caller is responsible
>>+for setting this up as described in
>>+.BR selinux_set_callback (3).
>>+.sp
>>+.B SELINUX_RESTORECON_REALPATH
>>+convert passed-in pathnames from
>>+.IR pathname_list
>>+to canonical pathnames using
>>+.BR realpath (3).
>>+.sp
>>+.B SELINUX_RESTORECON_XDEV
>>+prevent descending into directories that have a different device number than
>>+the
>>+.IR pathname_list
>>+entry from which the descent began.
>>+.RE
>>+.RE
>>+.
>>+.SH "RETURN VALUE"
>>+On success, zero is returned.  On error, \-1 is returned and
>>+.I errno
>>+is set appropriately.
>>+.
>>+.SH "NOTES"
>>+To improve performance when relabeling file systems recursively (e.g. the
>>+.IR restorecon_flags
>>+.B SELINUX_RESTORECON_RECURSE
>>+flag is set)
>>+.BR selinux_restorecon ()
>>+will write an SHA1 digest of the specfiles that are processed by
>>+.BR selabel_open (3)
>>+to an extended attribute named
>>+.IR security.restorecon_last
>>+for each entry in the
>>+.IR pathname_list
>>+(these are normally top level directories). Note that if an entry is a file,
>>+then this would also have this extended attribute added (it is therefore
>>+recomended that setting
>>+.B SELINUX_RESTORECON_RECURSE
>>+when relabeling a specific file should be avoided).
>>+.sp
>>+To check the extended attribute entry use
>>+.BR getfattr (1) ,
>>+for example:
>>+.sp
>>+.RS
>>+getfattr -e hex -n security.restorecon_last /
>>+.RE
>>+.sp
>>+The SHA1 digest is calculated by
>>+.BR selabel_open (3)
>>+concatenating the specfiles it reads during initialisation with the
>>+resulting digest and list of specfiles being retrieved by
>>+.BR selabel_digest (3).
>>+.sp
>>+The specfiles consist of the mandatory
>>+.I file_contexts
>>+file plus any subs, subs_dist, local and homedir entries (text or binary versions)
>>+as determined by any
>>+.BR selabel_open (3)
>>+options e.g.
>>+.BR SELABEL_OPT_BASEONLY .
>>+.sp
>>+Should any of the specfiles have changed, then when
>>+.BR selinux_restorecon ()
>>+is run again with the
>>+.B SELINUX_RESTORECON_RECURSE
>>+flag set, a new SHA1 digest will be calculated and all files will be automatically
>>+relabeled depending on the settings of the
>>+.B SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL
>>+and
>>+.B SELINUX_RESTORECON_CHANGE_CUSTOMIZABLE
>>+flags (provided
>>+.B SELINUX_RESTORECON_NOCHANGE
>>+is not set).
>>+.sp
>>+.B /sys
>>+and in-memory filesystems do not support the
>>+.IR security.restorecon_last
>>+extended attribute.
>>+.sp
>>+.BR selinux_restorecon ()
>>+does not check whether the mounted filesystems support the
>>+.B seclabel
>>+option. These should be set by the caller in the
>>+.IR exclude_list .
>>+.
>>+.SH "SEE ALSO"
>>+.BR restorecon (8),
>>+.BR setfiles (8)
>>diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>>index 2a0e889..e07c6bd 100644
>>--- a/libselinux/src/Makefile
>>+++ b/libselinux/src/Makefile
>>@@ -72,7 +72,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
>>           -fipa-pure-const -Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
>>           -Werror -Wno-aggregate-return -Wno-redundant-decls
>>
>>-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
>>+override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(EMFLAGS)
>>
>> SWIG_CFLAGS += -Wno-error -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter \
>>                -Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations
>>diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
>>new file mode 100644
>>index 0000000..653572e
>>--- /dev/null
>>+++ b/libselinux/src/selinux_restorecon.c
>>@@ -0,0 +1,443 @@
>>+/*
>>+ * The majority of this code is from Android's
>>+ * external/libselinux/src/android.c and upstream
>>+ * selinux/policycoreutils/setfiles/restorecon.c
>>+ *
>>+ * See selinux_restorecon(3) for details.
>>+ */
>>+
>>+#include <unistd.h>
>>+#include <string.h>
>>+#include <stdio.h>
>>+#include <stdlib.h>
>>+#include <stdbool.h>
>>+#include <ctype.h>
>>+#include <errno.h>
>>+#include <fcntl.h>
>>+#include <fts.h>
>>+#include <limits.h>
>>+#include <sys/types.h>
>>+#include <sys/stat.h>
>>+#include <sys/xattr.h>
>>+#include <sys/vfs.h>
>>+#include <linux/magic.h>
>>+#include <selinux/selinux.h>
>>+#include <selinux/context.h>
>>+#include <selinux/label.h>
>>+
>>+#include "callbacks.h"
>>+#include "selinux_internal.h"
>>+
>>+#define RESTORECON_LAST "security.restorecon_last"
>>+
>>+#define SYS_PATH "/sys"
>>+#define SYS_PREFIX SYS_PATH "/"
>>+
>>+static struct selabel_handle *fc_sehandle;
>>+
>>+#define NUM_SELABEL_OPTS 4
>>+static struct selinux_opt fc_opts[] = {
>>+       { SELABEL_OPT_PATH, NULL },
>>+       { SELABEL_OPT_BASEONLY, NULL },
>>+       { SELABEL_OPT_VALIDATE, NULL },
>>+       { SELABEL_OPT_DIGEST, NULL } };
>>+
>>+/*
>>+ * This is called if SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL is not set
>>+ * to check if the type components differ, updating newtypecon if so.
>>+ */
>>+static int compare_types(char *curcon, char *newcon, char **newtypecon)
>>+{
>>+       int types_differ = 0;
>>+       context_t cona;
>>+       context_t conb;
>>+       int rc = 0;
>>+
>>+       cona = context_new(curcon);
>>+       if (!cona) {
>>+               rc = -1;
>>+               goto out;
>>+       }
>>+       conb = context_new(newcon);
>>+       if (!conb) {
>>+               context_free(cona);
>>+               rc = -1;
>>+               goto out;
>>+       }
>>+
>>+       types_differ = strcmp(context_type_get(cona), context_type_get(conb));
>>+       if (types_differ) {
>>+               rc |= context_user_set(conb, context_user_get(cona));
>>+               rc |= context_role_set(conb, context_role_get(cona));
>>+               rc |= context_range_set(conb, context_range_get(cona));
>>+               if (!rc) {
>>+                       *newtypecon = strdup(context_str(conb));
>>+                       if (!*newtypecon) {
>>+                               rc = -1;
>>+                               goto err;
>>+                       }
>>+               }
>>+       }
>>+
>>+err:
>>+       context_free(cona);
>>+       context_free(conb);
>>+out:
>>+       return rc;
>>+}
>>+
>>+static int restorecon_sb(const char *pathname, const struct stat *sb,
>>+                                   bool nochange, bool verbose,
>>+                                   bool customizable, bool changecontext)
>>+{
>>+       char *newcon = NULL;
>>+       char *curcon = NULL;
>>+       char *newtypecon = NULL;
>>+       int rc = 0;
>>+       bool updated = false;
>>+
>>+       if (selabel_lookup_raw(fc_sehandle, &newcon, pathname, sb->st_mode) < 0)
>>+               return 0; /* no match, but not an error */
>>+
>>+       if (lgetfilecon_raw(pathname, &curcon) < 0)
>>+               goto err;
>>
>+
>>+       if (strcmp(curcon, newcon) != 0) {
>>+               if (!customizable && (is_context_customizable(curcon) > 0)) {
>>+                       if (verbose) {
>>+                               selinux_log(SELINUX_INFO,
>>+                                "%s not reset as customized by admin to %s\n",
>>+                                                           pathname, curcon);
>>+                                       goto out;
>>+                       }
>>+               }
>>+
>>+               if (!nochange && changecontext) {
>>+                       if (lsetfilecon(pathname, newcon) < 0)
>>+                               goto err;
>>+                       updated = true;
>>+               } else if (nochange && changecontext) {
>>+                       updated = true;
>>+               } else if (!changecontext) {
>>+                       /* If types different then update newcon. */
>>+                       rc = compare_types(curcon, newcon, &newtypecon);
>>+                       if (rc)
>>+                               goto err;
>>+
>>+                       if (newtypecon) {
>>+                               freecon(newcon);
>>+                               newcon = newtypecon;
>>+                               if (!nochange) {
>>+                                       if (lsetfilecon(pathname, newcon) < 0)
>>+                                               goto err;
>>+                               }
>>+                               updated = true;
>>+                       }
>>+               }
>>
>+
>>+               if (verbose && updated)
>>+                       selinux_log(SELINUX_INFO,
>>+                                   "%s %s from %s to %s.\n",
>>+                                   nochange ? "Would relabel" : "Relabeled",
>>+                                   pathname, curcon, newcon);
>>+       }
>>+
>>+out:
>>+       rc = 0;
>>+out1:
>>+       freecon(curcon);
>>+       freecon(newcon);
>>+       return rc;
>>+err:
>>+       selinux_log(SELINUX_ERROR,
>>+                   "Could not set context for %s:  %s\n",
>>+                   pathname, strerror(errno));
>>+       rc = -1;
>>+       goto out1;
>>+}
>>+
>>+static int check_excluded(const char *file, const char **exclude_list)
>>+{
>>+       int i;
>>+
>>+       for (i = 0; exclude_list[i]; i++) {
>>+               if (strcmp(file, exclude_list[i]) == 0)
>>+                               return 1;
>>+       }
>>+       return 0;
>>+}
>>+
>>+int selinux_restorecon(const char **pathname_list, const char **exclude_list,
>>+                                           const char *fc_path,
>>+                                           unsigned int restorecon_flags)
>>+{
>>+       bool force = (restorecon_flags &
>>+                  SELINUX_RESTORECON_FORCE_CHECK) ? true : false;
>>+       bool nochange = (restorecon_flags &
>>+                  SELINUX_RESTORECON_NOCHANGE) ? true : false;
>>+       bool customizable = (restorecon_flags &
>>+                  SELINUX_RESTORECON_CHANGE_CUSTOMIZABLE) ? true : false;
>>+       /* true = change file label to specfile entry,
>>+        * false = only change type component. */
>>+       bool changecontext = (restorecon_flags &
>>+                  SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL) ? true : false;
>>+       bool verbose = (restorecon_flags &
>>+                  SELINUX_RESTORECON_VERBOSE) ? true : false;
>>+       bool recurse = (restorecon_flags &
>>+                  SELINUX_RESTORECON_RECURSE) ? true : false;
>>+       bool validate = (restorecon_flags &
>>+                  SELINUX_RESTORECON_VALIDATE) ? true : false;
>>+       bool userealpath = (restorecon_flags &
>>+                  SELINUX_RESTORECON_REALPATH) ? true : false;
>>+       bool xdev = (restorecon_flags &
>>+                  SELINUX_RESTORECON_XDEV) ? true : false;
>>+       bool issys;
>>+       bool setrestoreconlast = true;
>>+       struct stat sb;
>>+       struct statfs sfsb;
>>+       FTS *fts = NULL;
>>+       FTSENT *ftsent;
>>+       char *pathname = NULL;
>>+       char *paths[2] = { NULL , NULL };
>>+       int fts_flags = 0, error = 0, i;
>>+       char **specfiles = NULL;
>>+       unsigned char *digest = NULL;
>>+       int digest_len, num_specfiles;
>>+       unsigned char *xattr_value = NULL;
>>+       char *sha1_buf = NULL;
>>+       ssize_t size, entry;
>>+
>>+       if (!pathname_list) {
>>+               selinux_log(SELINUX_INFO, "No pathnames given.\n");
>>+               errno = EINVAL;
>>+               return -1;
>>+       }
>>+
>>+       if (is_selinux_enabled() <= 0)
>>+               return 0;
>>
>
>

>Why fake a success when the function did nothing?
The current version of restorecon(8) does this so I followed that. However
it will need to change if this new function is also used for setfiles(8)
functionality as that still labels even if SELinux is not enabled (it also

checks associations between inodes and contexts that I have not added as I'm
not sure if needed or not).

The overall objective of this function is to reduce restorecon and setfiles
to simple wrappers calling selinux_restorecon as it sets a digest as explained
in the man page. My current objectives are to see if this is worthwhile, if so
what additional functionality needs to be added to selinux_restorecon before
updating restorecon(8) and setfiles(8)
>
>

>It seems that no other function (e.g. lsetfilecon) check if selinux is enabled.
Some do, some don't - depends whether they rely on SELinux being active or not.
lsetfilecon sets the xattr that relies on filesystem support not SELinux.


>Why it is ok to>set some selinux context using lsetfilecon, and not ok to get the default context and set it 

>using restorecon?
As above the overall objective is to reduce restorecon to a wrapper for this function.
> 
>
>+
>>+       i = NUM_SELABEL_OPTS;
>>+       while (i--) {
>>+               switch (fc_opts[i].type) {
>>+               case SELABEL_OPT_PATH:
>>+                       fc_opts[i].value = fc_path;
>>+                       break;
>>+               case SELABEL_OPT_BASEONLY:
>>+                       fc_opts[i].value = NULL;
>>+                       break;
>>+               case SELABEL_OPT_VALIDATE:
>>+                       fc_opts[i].value = (validate ? (char *)1 : NULL);
>>+                       break;
>>+               case SELABEL_OPT_DIGEST:
>>+                       fc_opts[i].value = (char *)1; /* Must request digest */
>>+                       break;
>>+               }
>>+       }
>>+
>>+       fc_sehandle = selabel_open(SELABEL_CTX_FILE, fc_opts, NUM_SELABEL_OPTS);
>>+       if (!fc_sehandle) {
>>+               selinux_log(SELINUX_ERROR,
>>+                           "Error obtaining file context handle: %s\n",
>>+                                                   strerror(errno));
>>+               return -1;
>>+       }
>>+
>>+       if (selabel_digest(fc_sehandle, &digest, &digest_len,
>>+                                   &specfiles, &num_specfiles) < 0) {
>>+               selinux_log(SELINUX_ERROR,
>>+                           "Error reading specfiles digest: %s\n",
>>+                                                   strerror(errno));
>>+               selabel_close(fc_sehandle);
>>+               return -1;
>>+       }
>>+
>>+       xattr_value = malloc(digest_len);
>>+       if (!xattr_value)
>>+               return -1;
>>+
>>+       if (verbose) {
>>+               sha1_buf = malloc(digest_len * 2 + 1);
>>+               if (!sha1_buf)
>>+                       return -1;
>>+
>>+               for (i = 0; i < digest_len; i++)
>>+                       sprintf((&sha1_buf[i * 2]), "%02x", digest[i]);
>>+
>>+               selinux_log(SELINUX_INFO,
>>+                           "specfiles SHA1 digest: %s\n", sha1_buf);
>>+               selinux_log(SELINUX_INFO,
>>+                           "calculated using the following specfile(s):\n");
>>+               if (specfiles) {
>>+                       for (i = 0; i < num_specfiles; i++)
>>+                               selinux_log(SELINUX_INFO,
>>+                                           "%s\n", specfiles[i]);
>>+               }
>>+       }
>>+
>>+       if (xdev)
>>+               fts_flags = FTS_PHYSICAL | FTS_XDEV;
>>+       else
>>+               fts_flags = FTS_PHYSICAL;
>>+
>>+       for (entry = 0; pathname_list[entry]; entry++) {
>>+               /* Need to reset as could have been set false */
>>+               setrestoreconlast = true;
>>+
>>+               /* Convert passed-in pathname to canonical form if required. */
>>+               if (userealpath == true) {
>>+                       pathname = realpath(pathname_list[entry], NULL);
>>+                       if (!pathname) {
>>+                               selinux_log(SELINUX_ERROR,
>>+                                   "Could not get canonical path %s: %s.\n",
>>+                                   pathname_list[entry], strerror(errno));
>>+                               error = -1;
>>+                               goto cleanup;
>>+                       }
>>+               } else {
>>+                       pathname = strdup(pathname_list[entry]);
>>+                       if (lstat(pathname, &sb) < 0) {
>>+                               selinux_log(SELINUX_ERROR,
>>+                                   "Could not stat: %s %s.\n",
>>+                                   pathname_list[entry], strerror(errno));
>>+                               error = -1;
>>+                               goto cleanup;
>>+                       }
>>+               }
>>+
>>+               paths[0] = pathname;
>>+               issys = (!strcmp(pathname, SYS_PATH)
>>+                           || !strncmp(pathname, SYS_PREFIX,
>>+                           sizeof(SYS_PREFIX) - 1)) ? true : false;
>>+
>>+               if (!recurse) {
>>+                       error = restorecon_sb(pathname, &sb, nochange,
>>+                                           verbose, customizable,
>>+                                           changecontext);
>>+                       goto cleanup;
>>+               }
>>+
>>+               /* Ignore /sys since it is regenerated on each boot. */
>>+               if (issys)
>>+                       setrestoreconlast = false;
>>+
>>+               /* Ignore files on in-memory filesystems */
>>+               if (statfs(pathname, &sfsb) == 0) {
>>+                       if (sfsb.f_type == RAMFS_MAGIC ||
>>+                                           sfsb.f_type == TMPFS_MAGIC)
>>+                               setrestoreconlast = false;
>>+               }
>>+
>>+               if (setrestoreconlast) {
>>+                       size = getxattr(pathname, RESTORECON_LAST, xattr_value,
>>+                                                                  digest_len);
>>+
>>+                       if (size < 0 && errno == ENOTSUP)
>>+                               continue;
>>+
>>+                       if (verbose && size == digest_len) {
>>+                               for (i = 0; i < digest_len; i++)
>>+                                       sprintf(&(sha1_buf[i * 2]), "%02x",
>>+                                                           xattr_value[i]);
>>+                               selinux_log(SELINUX_INFO,
>>+                                           "Entry: %s has SHA1 digest: %s\n",
>>+                                                  pathname, sha1_buf);
>>+                       } else if (verbose && size != digest_len) {
>>+                               selinux_log(SELINUX_INFO,
>>+                                   "Entry: %s has no valid SHA1 digest\n",
>>+                                                                   pathname);
>>+                       }
>>+
>>+                       if (!force && size == digest_len &&
>>+                                          memcmp(digest, xattr_value,
>>+                                          digest_len) == 0) {
>>+                               selinux_log(SELINUX_INFO,
>>+                                          "Skipping recursive entry: %s\n",
>>+                                          pathname);
>>+                               error = 0;
>>+                               goto cleanup;
>>+                       }
>>+               }
>>+
>>+               fts = fts_open(paths, fts_flags, NULL);
>>+               if (!fts) {
>>+                       selinux_log(SELINUX_ERROR,
>>+                                   "FTS open error: %s.\n", strerror(errno));
>>+                       error = -1;
>>+                       goto cleanup;
>>+               }
>>+
>>+               error = 0;
>>+               while ((ftsent = fts_read(fts)) != NULL) {
>>+                       switch (ftsent->fts_info) {
>>+                       case FTS_DC:
>>+                               selinux_log(SELINUX_ERROR,
>>+                                       "Directory cycle on %s.\n",
>>+                                                           ftsent->fts_path);
>>+                               errno = ELOOP;
>>+                               error = -1;
>>+                               (void) fts_close(fts);
>>+                               goto cleanup;
>>+                       case FTS_DP:
>>+                               continue;
>>+                       case FTS_DNR:
>>+                               selinux_log(SELINUX_ERROR,
>>+                                       "Could not read %s: %s.\n",
>>+                                           ftsent->fts_path, strerror(errno));
>>+                               fts_set(fts, ftsent, FTS_SKIP);
>>+                               continue;
>>+                       case FTS_NS:
>>+                               selinux_log(SELINUX_ERROR,
>>+                                       "Could not stat %s: %s.\n",
>>+                                           ftsent->fts_path, strerror(errno));
>>+                               fts_set(fts, ftsent, FTS_SKIP);
>>+                               continue;
>>+                       case FTS_ERR:
>>+                               selinux_log(SELINUX_ERROR,
>>+                                       "Error on %s: %s.\n",
>>+                                           ftsent->fts_path, strerror(errno));
>>+                               fts_set(fts, ftsent, FTS_SKIP);
>>+                               continue;
>>+                       case FTS_D:
>>+                               if (issys && !selabel_partial_match
>>+                                           (fc_sehandle, ftsent->fts_path)) {
>>+                                       fts_set(fts, ftsent, FTS_SKIP);
>>+                                       continue;
>>+                               }
>>+                               /* fall through */
>>+                       default:
>>+                               if (exclude_list) {
>>+                                       if (check_excluded(ftsent->fts_path,
>>+                                                           exclude_list)) {
>>+                                               fts_set(fts, ftsent, FTS_SKIP);
>>+                                               continue;
>>+                                       }
>>+                               }
>>+                               error |= restorecon_sb(ftsent->fts_path,
>>+                                           ftsent->fts_statp, nochange,
>>+                                           verbose, customizable,
>>+                                           changecontext);
>>+                               break;
>>+                       }
>>+               }
>>+
>>+               fts_close(fts);
>>+
>>+               /* Labeling successful. Mark top level directory completed. */
>>+               if (setrestoreconlast && !nochange && !error) {
>>+                       error = setxattr(pathname, RESTORECON_LAST, digest,
>>+                                                           digest_len, 0);
>>+                       if (!error && verbose)
>>+                               selinux_log(SELINUX_INFO,
>>+                                          "Updated SHA1 digest for: %s\n",
>>+                                                            pathname);
>>+               }
>>+       }
>>+
>>+cleanup:
>>+       selabel_close(fc_sehandle);
>>+       free(pathname);
>>+       free(xattr_value);
>>+       if (verbose)
>>+               free(sha1_buf);
>>+       return error;
>>+}
>>diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
>>index 5dda66e..8068291 100644
>>--- a/libselinux/utils/Makefile
>>+++ b/libselinux/utils/Makefile
>>@@ -30,6 +30,8 @@ TARGETS=$(patsubst %.c,%,$(wildcard *.c))
>>
>> sefcontext_compile: LDLIBS += -lpcre -lcrypto ../src/libselinux.a -lsepol
>>
>>+selinux_restorecon: LDLIBS += -lsepol
>>+
>> ifeq ($(DISABLE_AVC),y)
>>        UNUSED_TARGETS+=compute_av compute_create compute_member compute_relabel
>> endif
>>diff --git a/libselinux/utils/selinux_restorecon.c b/libselinux/utils/selinux_restorecon.c
>>new file mode 100644
>>index 0000000..35ad81f
>>--- /dev/null
>>+++ b/libselinux/utils/selinux_restorecon.c
>>@@ -0,0 +1,215 @@
>>+#include <stdio.h>
>>+#include <stdlib.h>
>>+#include <string.h>
>>+#include <getopt.h>
>>+#include <errno.h>
>>+#include <sepol/sepol.h>
>>+#include <selinux/selinux.h>
>>+
>>+static char *policyfile;
>>+
>>+static char **exclude_list;
>>+static int exclude_count;
>>+
>>+static int validate_context(char **contextp)
>>+{
>>+       char *context = *contextp, *tmpcon;
>>+
>>+       if (policyfile) {
>>+               if (sepol_check_context(context) < 0) {
>>+                       fprintf(stderr, "Invalid context %s\n", context);
>>+                       exit(-1);
>>+               }
>>+       } else if (security_canonicalize_context_raw(context, &tmpcon) == 0) {
>>+               free(context);
>>+               *contextp = tmpcon;
>>+       } else if (errno != ENOENT) {
>>+               fprintf(stderr, "Validate context error: %s\n",
>>+                                                   strerror(errno));
>>+               exit(-1);
>>+       }
>>+
>>+       return 0;
>>+}
>>+
>>+static void usage(const char *progname)
>>+{
>>+       fprintf(stderr,
>>+               "\nusage: %s [-FnclRvrde] [-p policy] [-f specfile] "
>>+               "pathname ...\n"
>>+               "Where:\n\t"
>>+               "-F  Force the checking of labels even if the stored SHA1\n\t"
>>+               "    digest matches the specfiles SHA1 digest.\n\t"
>>+               "-n  Don't change any file labels (passive check).\n\t"
>>+               "-c  Reset customizable file label to match specfile.\n\t"
>>+               "-l  Reset file label to that in spec file. If this option\n\t"
>>+               "    is NOT set the default operation is to only reset the\n\t"
>>+               "    \"type\" component of the label to that in the "
>>+               "specfile.\n\t"
>>+               "-R  Recursively change files and directory labels.\n\t"
>>+               "-v  Show changes in file labels, Also specfiles used to calc\n\t"
>>+               "    SHA1 digest plus digest.\n\t"
>>+               "-r  Use realpath(3) to convert pathnames to canonical form.\n\t"
>>+               "-d  Prevent descending into directories that have a "
>>+               "different\n\t    device number than the pathname from  which "
>>+               "the descent began.\n\t"
>>+               "-e  Exclude this file/directory (add multiple -e entries).\n\t"
>>+               "-p  Optional binary policy file (also sets the validate\n\t"
>>+               "    context option).\n\t"
>>+               "-f  Optional file contexts file (defaults to those used by\n\t"
>>+               "    loaded policy).\n\t"
>>+               "pathname  One or more paths to relabel.\n\n",
>>+               progname);
>>+       exit(-1);
>>+}
>>+
>>+static void add_exclude(const char *directory)
>>+{
>>+       char **tmp_list;
>>+
>>+       if (directory == NULL || directory[0] != '/') {
>>+               fprintf(stderr, "Full path required for exclude: %s.\n",
>>+                       directory);
>>+               exit(-1);
>>+       }
>>+
>>+       /* Add another two entries, one for directory, and the other to
>>+        * terminate the list */
>>+       tmp_list = realloc(exclude_list, sizeof(char *) * (exclude_count + 2));
>>+       if (!tmp_list) {
>>+               fprintf(stderr, "ERROR: realloc failed.\n");
>>+               exit(-1);
>>+       }
>>+       exclude_list = tmp_list;
>>+
>>+       exclude_list[exclude_count] = strdup(directory);
>>+       if (!exclude_list[exclude_count]) {
>>+               fprintf(stderr, "ERROR: strdup failed.\n");
>>+               exit(-1);
>>+       }
>>+       exclude_count++;
>>+       exclude_list[exclude_count] = NULL;
>>+}
>>+
>>+int main(int argc, char **argv)
>>+{
>>+       int rc, opt, i, num_paths, string_len;
>>+       char **paths = NULL;
>>+       unsigned int restorecon_flags = 0;
>>+       char *fc_name = NULL;
>>+       FILE *policystream;
>>+
>>+       if (argc < 2)
>>+               usage(argv[0]);
>>+
>>+       exclude_list = NULL;
>>+       exclude_count = 0;
>>+
>>+       while ((opt = getopt(argc, argv, "FnclRvrde:f:p:")) > 0) {
>>+               switch (opt) {
>>+               case 'F':
>>+                       restorecon_flags |=
>>+                                   SELINUX_RESTORECON_FORCE_CHECK;
>>+                       break;
>>+               case 'n':
>>+                       restorecon_flags |= SELINUX_RESTORECON_NOCHANGE;
>>+                       break;
>>+               case 'c':
>>+                       restorecon_flags |=
>>+                                  SELINUX_RESTORECON_CHANGE_CUSTOMIZABLE;
>>+                       break;
>>+               case 'l':
>>+                       restorecon_flags |=
>>+                                  SELINUX_RESTORECON_CHANGE_USERROLETYPELEVEL;
>>+                       break;
>>+               case 'R':
>>+                       restorecon_flags |= SELINUX_RESTORECON_RECURSE;
>>+                       break;
>>+               case 'v':
>>+                       restorecon_flags |=  SELINUX_RESTORECON_VERBOSE;
>>+                       break;
>>+               case 'r':
>>+                       restorecon_flags |= SELINUX_RESTORECON_REALPATH;
>>+                       break;
>>+               case 'd':
>>+                       restorecon_flags |= SELINUX_RESTORECON_XDEV;
>>+                       break;
>>+               case 'e':
>>+                       add_exclude(optarg);
>>+                       break;
>>+               case 'p':
>>+                       policyfile = optarg;
>>+
>>+                       policystream = fopen(policyfile, "r");
>>+                       if (!policystream) {
>>+                               fprintf(stderr,
>>+                                       "Error opening %s: %s\n",
>>+                                       policyfile, strerror(errno));
>>+                               exit(-1);
>>+                       }
>>+
>>+                       if (sepol_set_policydb_from_file(policystream) < 0) {
>>+                               fprintf(stderr,
>>+                                       "Error reading policy %s: %s\n",
>>+                                       policyfile, strerror(errno));
>>+                               exit(-1);
>>+                       }
>>+                       fclose(policystream);
>>+                       restorecon_flags |= SELINUX_RESTORECON_VALIDATE;
>>+                       selinux_set_callback(SELINUX_CB_VALIDATE,
>>+                                   (union selinux_callback)&validate_context);
>>+                       break;
>>+               case 'f':
>>+                       fc_name = optarg;
>>+                       break;
>>+               default:
>>+                       usage(argv[0]);
>>+               }
>>+       }
>>+
>>+       /* Count paths */
>>+       for (i = optind, num_paths = 0; i < argc; i++, num_paths++)
>>+               ;
>>+
>>+       if (num_paths) {
>>+               paths = calloc(num_paths + 1, sizeof(char *));
>>+
>>+               if (!paths) {
>>+                       fprintf(stderr, "ERROR: calloc failed.\n");
>>+                       exit(-1);
>>+               }
>>+
>>+               for (i = optind, num_paths = 0; i < argc; i++, num_paths++) {
>>+                       string_len = strlen(argv[i]) + 1;
>>+                       paths[num_paths] = malloc(string_len);
>>+                       if (!paths[num_paths]) {
>>+                               fprintf(stderr, "ERROR: malloc failed.\n");
>>+                               exit(-1);
>>+                       }
>>+                       strcpy(paths[num_paths], argv[i]);
>>+               }
>>+       }
>>+
>>+       rc = selinux_restorecon((const char **)paths,
>>+                                           (const char **)exclude_list,
>>+                                           fc_name,
>>+                                           restorecon_flags);
>>+
>>+       if (rc)
>>+               fprintf(stderr, "selinux_restorecon error: %s\n",
>>+                                                   strerror(errno));
>>+
>>+       if (paths) {
>>+               for (i = 0; paths[i]; i++)
>>+                       free(paths[i]);
>>+               free(paths);
>>+       }
>>+
>>+       if (exclude_list) {
>>+               for (i = 0; exclude_list[i]; i++)
>>+                       free(exclude_list[i]);
>>+               free(exclude_list);
>>+       }
>>+
>>+       return rc;
>>+}
>>--
>>2.4.3
>>
>>_______________________________________________
>>Selinux mailing list
>>Selinux@tycho.nsa.gov
>>To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>
>
>
