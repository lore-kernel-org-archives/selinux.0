Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA25396
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2001 10:09:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA28036
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2001 15:09:46 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA28032
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2001 15:09:45 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26172
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2001 10:09:53 -0500 (EST)
Message-ID: <3C144994.8010308@pcez.com>
Date: Sun, 09 Dec 2001 21:35:16 -0800
From: Shaun Savage <savages@pcez.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_homegate.savages.net-23968-1007964898-0001-2"
To: SELinux@tycho.nsa.gov
Subject: New security policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_homegate.savages.net-23968-1007964898-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Folks

I have worked with RSBAC for about 5 years now and now I trying to work 
with selinux.
I would like a security policy with

sysdm_r    this for root to admin the system but can't change security 
of "system" types
secoff_r    The is for security officer to set up the security for the 
system
dataoff_r    this is the only person that can "see" users personal 
files/directories
user_r        this is for the normal user
system_r    for normal system stuff

 NEXT

I have compiled some of the selinux utils for RH7.2, I hope to do the 
rest this week.
this is how I did it

I first did  >rpm -bp XXXX.spec
the patched the XXXX directory using the patch
on some XXXX i needed to autoconf  (caution: the autoconf that comes 
with RH7.2 is bad upgrade to 2.52 from GNU.org)
I then go back to the SPEC directory and rpm -bc --short-circuit XXXX.spec
then rpm -bi --short-circuit XXXX.spec

then goto /var/tmp/XXXX and get the files.

 More later
Shaun Savage


--=_homegate.savages.net-23968-1007964898-0001-2
Content-Type: text/plain; name="fileutils-4.1-selinux.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fileutils-4.1-selinux.patch"

diff -Nur fileutils-4.1/config.h.in fileutils-4.1-selinux/config.h.in
--- fileutils-4.1/config.h.in	Sun Apr 22 03:19:08 2001
+++ fileutils-4.1-selinux/config.h.in	Sun Dec  9 17:48:33 2001
@@ -37,6 +37,9 @@
 /* Define to 1 if NLS is requested. */
 #undef ENABLE_NLS
 
+/* Define Flask */
+#undef FLASK_LINUX
+
 /* Define on systems for which file names may have a so-called `drive letter'
    prefix, define this to compute the length of that prefix, including the
    colon. */
diff -Nur fileutils-4.1/configure.in fileutils-4.1-selinux/configure.in
--- fileutils-4.1/configure.in	Sun Apr 29 00:02:33 2001
+++ fileutils-4.1-selinux/configure.in	Sun Dec  9 17:46:33 2001
@@ -7,6 +7,18 @@
 
 ALL_LINGUAS="cs da de el es fr gl it ja ko nl no pl pt pt_BR ru sk sl sv zh"
 
+dnl Make Flask security-enhanced versions of fileutils
+dnl Should add existence chackes for libsecure library, etc
+dnl   CFLAGS="$CFLAGS -DFLASK_LINUX  -I/usr/flask/include -I/usr/src/linux/include"
+dnl   LIBS="$LIBS -L/usr/flask/lib -lsecure"])
+
+AC_ARG_WITH(selinux,
+[  --with-selinux            include support for SELinux],
+[  AC_DEFINE(FLASK_LINUX)
+   CFLAGS="$CFLAGS -DFLASK_LINUX -I/usr/local/selinux/include"
+   LIBS="$LIBS -L/usr/local/selinux/lib -lsecure"])
+AC_ARG_PROGRAM
+
 jm_PERL
 AC_PROG_CC
 AC_PROG_CPP
diff -Nur fileutils-4.1/lib/makepath.c fileutils-4.1-selinux/lib/makepath.c
--- fileutils-4.1/lib/makepath.c	Sun Nov  5 05:10:25 2000
+++ fileutils-4.1-selinux/lib/makepath.c	Sun Dec  9 17:49:07 2001
@@ -94,6 +94,10 @@
 # define S_IXUSR 0100
 #endif
 
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#endif FLASK_LINUX
+
 #ifndef S_IRWXU
 # define S_IRWXU (S_IRUSR | S_IWUSR | S_IXUSR)
 #endif
@@ -143,6 +147,25 @@
     }							\
   while (0)
 
+
+#ifdef FLASK_LINUX
+static security_id_t Sid = -1;
+
+int
+make_path_s (const char *argpath,
+	     int mode,
+	     int parent_mode,
+	     uid_t owner,
+	     gid_t group,
+	     int preserve_existing,
+	     const char *verbose_fmt_string,
+	     security_id_t sid)
+{
+  Sid = sid;
+  return( make_path(argpath, mode, parent_mode, owner, group, preserve_existing, verbose_fmt_string) );
+}
+#endif FLASK_LINUX
+
 /* Attempt to create directory DIR (aka DIRPATH) with the specified MODE.
    If CREATED_DIR_P is non-NULL, set *CREATED_DIR_P to non-zero if this
    function creates DIR and to zero otherwise.  Give a diagnostic and
@@ -157,6 +180,11 @@
   int fail = 0;
   int created_dir;
 
+#ifdef FLASK_LINUX
+        if ( (int) Sid > 0 )
+          created_dir = mkdir_secure (dir, mode, Sid);
+        else
+#endif FLASK_LINUX
   created_dir = (mkdir (dir, mode) == 0);
 
   if (!created_dir)
@@ -195,6 +223,7 @@
   return fail;
 }
 
+
 /* Ensure that the directory ARGPATH exists.
    Remove any trailing slashes from ARGPATH before calling this function.
 
@@ -212,7 +241,6 @@
 
    Return 0 if ARGPATH exists as a directory with the proper
    ownership and permissions when done, otherwise 1.  */
-
 int
 make_path (const char *argpath,
 	   int mode,
@@ -224,6 +252,7 @@
 {
   struct stat stats;
   int retval = 0;
+  int rv;
 
   if (stat (argpath, &stats))
     {
diff -Nur fileutils-4.1/src/chcon.c fileutils-4.1-selinux/src/chcon.c
--- fileutils-4.1/src/chcon.c	Wed Dec 31 16:00:00 1969
+++ fileutils-4.1-selinux/src/chcon.c	Sun Dec  9 17:49:29 2001
@@ -0,0 +1,336 @@
+/* chcontext -- change security context of a pathname */
+
+#include <config.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <grp.h>
+#include <getopt.h>
+#include <fs_secure.h>
+
+#include "system.h"
+//#include "xstrtoul.h"
+#include "closeout.h"
+#include "error.h"
+#include "savedir.h"
+#include "group-member.h"
+
+enum Change_status
+{
+  CH_SUCCEEDED,
+  CH_FAILED,
+  CH_NO_CHANGE_REQUESTED
+};
+
+enum Verbosity
+{
+  /* Print a message for each file that is processed.  */
+  V_high,
+
+  /* Print a message for each file whose attributes we change.  */
+  V_changes_only,
+
+  /* Do not be verbose.  This is the default. */
+  V_off
+};
+
+static int change_dir_context PARAMS ((const char *dir, int sid,
+				       const struct stat *statp));
+
+/* The name the program was run with. */
+char *program_name;
+
+/* If nonzero, and the systems has support for it, change the context
+   of symbolic links rather than any files they point to.  */
+static int change_symlinks;
+
+/* If nonzero, change the context of directories recursively. */
+static int recurse;
+
+/* If nonzero, force silence (no error messages). */
+static int force_silent;
+
+/* Level of verbosity.  */
+static enum Verbosity verbosity = V_off;
+
+/* The name of the context the file is being given. */
+static const char *contextname;
+
+/* The argument to the --reference option.  Use the context SID of this file.
+   This file must exist.  */
+static char *reference_file;
+
+/* If nonzero, display usage information and exit.  */
+static int show_help;
+
+/* If nonzero, print the version on standard output and exit.  */
+static int show_version;
+
+static struct option const long_options[] =
+{
+  {"recursive", no_argument, 0, 'R'},
+  {"changes", no_argument, 0, 'c'},
+  {"no-dereference", no_argument, 0, 'h'},
+  {"silent", no_argument, 0, 'f'},
+  {"quiet", no_argument, 0, 'f'},
+  {"reference", required_argument, 0, CHAR_MAX + 1},
+  {"sid", required_argument, 0, CHAR_MAX + 2},
+  {"verbose", no_argument, 0, 'v'},
+  {"help", no_argument, &show_help, 1},
+  {"version", no_argument, &show_version, 1},
+  {0, 0, 0, 0}
+};
+
+/* Tell the user how/if the context of FILE has been changed.
+   CHANGED describes what (if anything) has happened. */
+
+static void
+describe_change (const char *file, enum Change_status changed)
+{
+  const char *fmt;
+  switch (changed)
+    {
+    case CH_SUCCEEDED:
+      fmt = _("context of %s changed to %s\n");
+      break;
+    case CH_FAILED:
+      fmt = _("failed to change context of %s to %s\n");
+      break;
+    case CH_NO_CHANGE_REQUESTED:
+      fmt = _("context of %s retained as %s\n");
+      break;
+    default:
+      abort ();
+    }
+  printf (fmt, file, contextname);
+}
+
+/* Change the context of FILE to SID CONTEXT.
+   If it is a directory and -R is given, recurse.
+   Return 0 if successful, 1 if errors occurred. */
+
+static int
+change_file_context (const char *file, int sid)
+{
+  struct stat file_stats;
+  security_id_t file_sid;
+  int errors = 0;
+
+  if (lstat_secure (file, &file_stats, &file_sid))
+    {
+      if (force_silent == 0)
+	error (0, errno, "%s", file);
+      return 1;
+    }
+
+  if (sid != file_sid)
+    {
+      int fail;
+
+      if (change_symlinks)
+      	fail = lchsid (file, sid);
+      else
+      	fail = chsid (file, sid);
+
+      if (verbosity == V_high || (verbosity == V_changes_only && !fail))
+	describe_change (file, (fail ? CH_FAILED : CH_SUCCEEDED));
+
+      if (fail)
+	{
+	  errors = 1;
+	  if (force_silent == 0)
+	    {
+	      error (0, errno, "%s", file);
+	    }
+	}
+    }
+  else if (verbosity == V_high)
+    {
+      describe_change (file, CH_NO_CHANGE_REQUESTED);
+    }
+
+  if (recurse && S_ISDIR (file_stats.st_mode))
+    errors |= change_dir_context (file, sid, &file_stats);
+
+  return errors;
+}
+
+/* Recursively change context of the files in directory DIR
+   to SID CONTEXT.
+   STATP points to the results of lstat on DIR.
+   Return 0 if successful, 1 if errors occurred. */
+
+static int
+change_dir_context (const char *dir, int sid, const struct stat *statp)
+{
+  char *name_space, *namep;
+  char *path;			/* Full path of each entry to process. */
+  unsigned dirlength;		/* Length of `dir' and '\0'. */
+  unsigned filelength;		/* Length of each pathname to process. */
+  unsigned pathlength;		/* Bytes allocated for `path'. */
+  int errors = 0;
+
+  errno = 0;
+  name_space = savedir (dir, (unsigned int) statp->st_size);
+  if (name_space == NULL)
+    {
+      if (errno)
+        {
+	  if (force_silent == 0)
+	    error (0, errno, "%s", dir);
+	  return 1;
+	}
+      else
+	error (1, 0, _("virtual memory exhausted"));
+    }
+
+  dirlength = strlen (dir) + 1;	/* + 1 is for the trailing '/'. */
+  pathlength = dirlength + 1;
+  /* Give `path' a dummy value; it will be reallocated before first use. */
+  path = xmalloc (pathlength);
+  strcpy (path, dir);
+  path[dirlength - 1] = '/';
+
+  for (namep = name_space; *namep; namep += filelength - dirlength)
+    {
+      filelength = dirlength + strlen (namep) + 1;
+      if (filelength > pathlength)
+	{
+	  pathlength = filelength * 2;
+	  path = xrealloc (path, pathlength);
+	}
+      strcpy (path + dirlength, namep);
+      errors |= change_file_context (path, sid);
+    }
+  free (path);
+  free (name_space);
+  return errors;
+}
+
+static void
+usage (int status)
+{
+  if (status != 0)
+    fprintf (stderr, _("Try `%s --help' for more information.\n"),
+	     program_name);
+  else
+    {
+      printf (_("\
+Usage: %s [OPTION]... CONTEXT FILE...\n\
+  or:  %s [OPTION]... --reference=RFILE FILE...\n\
+  or:  %s [OPTION]... --sid=SID FILE...\n\
+"),
+	program_name, program_name, program_name);
+      printf (_("\
+Change the security context of each FILE to CONTEXT.\n\
+\n\
+  -c, --changes          like verbose but report only when a change is made\n\
+  -h, --no-dereference   affect symbolic links instead of any referenced file\n\
+                         (available only on systems with lchown system call)\n\
+  -f, --silent, --quiet  suppress most error messages\n\
+      --reference=RFILE  use RFILE's group instead of using a CONTEXT value\n\
+      --sid=SID          use context corresponding to SID for CONTEXT value\n\
+  -R, --recursive        change files and directories recursively\n\
+  -v, --verbose          output a diagnostic for every file processed\n\
+      --help             display this help and exit\n\
+      --version          output version information and exit\n\
+"));
+      close_stdout ();
+    }
+  exit (status);
+}
+
+int
+main (int argc, char **argv)
+{
+  int sid = -1;
+  int errors = 0;
+  int optc;
+  
+  program_name = argv[0];
+  setlocale (LC_ALL, "");
+  bindtextdomain (PACKAGE, LOCALEDIR);
+  textdomain (PACKAGE);
+
+  recurse = force_silent = 0;
+  
+  while ((optc = getopt_long (argc, argv, "Rcfhv", long_options, NULL)) != -1)
+  {
+	  switch (optc)
+	  {
+	  case 0:
+		  break;
+	  case CHAR_MAX + 1:
+		  reference_file = optarg;
+		  break;
+	  case CHAR_MAX +2:
+	          sid = (int)strtol( optarg, (char **)NULL, 10);
+		  /* We use an int to represent sids so we can use -1 for *
+		   * an error condition.  All valid sids are positive.    *
+		   * Check for an invalid sid.                            */
+                  if( ( errno == ERANGE ) || ( sid <= 0 ) ) {  
+		    error( 1, 0, _("invalid sid"));
+		  }
+	          break;
+	  case 'R':
+		  recurse = 1;
+		  break;
+ 	  case 'c':
+		  verbosity = V_changes_only;
+		  break;
+	  case 'f':
+		  force_silent = 1;
+		  break;
+	  case 'h':
+		  change_symlinks = 1;
+		  break;
+	  case 'v':
+		  verbosity = V_high;
+		  break;
+	  default:
+		  usage (1);
+	  }
+  }
+
+  if (show_version)
+  {
+     printf ("chcon (%s) %s\n", GNU_PACKAGE, VERSION);
+     close_stdout ();
+     exit (0);
+  }
+
+  if (show_help)
+    usage (0);
+
+  if (argc - optind + ( (reference_file || ( sid > 0 ) ) ? 1 : 0) <= 1)
+  {
+     error (0, 0, _("too few arguments"));
+     usage (1);
+  }
+  
+  if (reference_file)
+    {
+      struct stat ref_stats;
+      security_id_t ref_sid;
+      if (stat_secure (reference_file, &ref_stats, &ref_sid))
+	error (1, errno, "%s", reference_file);
+
+      sid = ref_sid;
+    }
+  else if( sid <= 0 )  /* sid > 0 means sid already set by --sid above */
+   {
+     contextname = argv[optind++];
+
+     if (*contextname == '\0')
+       error (1, 0, _("can not change to null context"));
+
+     if (security_context_to_sid (contextname, strlen (contextname) + 1, &sid))
+       error (1, errno, "%s", contextname);
+   }
+
+  for (; optind < argc; ++optind)
+     errors |= change_file_context (argv[optind], sid);
+
+  if (verbosity != V_off)
+    close_stdout ();
+  exit (errors);
+}
diff -Nur fileutils-4.1/src/copy.c fileutils-4.1-selinux/src/copy.c
--- fileutils-4.1/src/copy.c	Sun Dec  9 17:38:51 2001
+++ fileutils-4.1-selinux/src/copy.c	Sun Dec  9 17:50:37 2001
@@ -37,6 +37,11 @@
 #include "quote.h"
 #include "same.h"
 
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+security_id_t Sid = -1;
+#endif /*FLASK_LINUX*/
+
 #define DO_CHOWN(Chown, File, New_uid, New_gid)				\
   (Chown (File, New_uid, New_gid)					\
    /* If non-root uses -p, it's ok if we can't preserve ownership.	\
@@ -193,6 +198,9 @@
   off_t n_read_total = 0;
   int last_write_made_hole = 0;
   int make_holes = (x->sparse_mode == SPARSE_ALWAYS);
+#ifdef FLASK_LINUX
+  security_id_t lsid;
+#endif /*FLASK_LINUX*/
 
   source_desc = open (src_path, O_RDONLY);
   if (source_desc < 0)
@@ -573,12 +581,21 @@
   int delayed_fail;
   int copied_as_regular = 0;
   int ran_chown = 0;
+#ifdef FLASK_LINUX
+  security_id_t lsid;
+  struct stat tst_sb;
+#endif /*FLASK_LINUX*/
 
   if (move_mode && rename_succeeded)
     *rename_succeeded = 0;
 
   *copy_into_self = 0;
+#ifdef FLASK_LINUX
+  /* will be either stat_secure() or fstat_secure() */
+  if ((*(x->xstat)) (src_path, &src_sb, &lsid))
+#else  /*FLASK_LINUX*/
   if ((*(x->xstat)) (src_path, &src_sb))
+#endif /*FLASK_LINUX*/
     {
       error (0, errno, _("cannot stat %s"), quote (src_path));
       return 1;
@@ -605,7 +622,11 @@
 
   if (!new_dst)
     {
+#ifdef FLASK_LINUX
+      if ((*(x->xstat)) (dst_path, &dst_sb, &lsid))
+#else  /*FLASK_LINUX*/
       if ((*(x->xstat)) (dst_path, &dst_sb))
+#endif /*FLASK_LINUX*/
 	{
 	  if (errno != ENOENT)
 	    {
@@ -893,6 +914,15 @@
 	{
 	  /* Create the new directory writable and searchable, so
              we can create new entries in it.  */
+#ifdef FLASK_LINUX
+        if ( (int) Sid > 0 ) {
+          if (mkdir_secure (dst_path, (src_mode & x->umask_kill) | 0700, Sid)) {
+            error (0, errno, _("cannot create directory `%s'"), dst_path);
+            goto un_backup;
+          }
+        }
+        else
+#endif  /*FLASK_LINUX*/
 
 	  if (mkdir (dst_path, (src_mode & x->umask_kill) | S_IRWXU))
 	    {
@@ -997,6 +1027,15 @@
 #ifdef S_ISFIFO
   if (S_ISFIFO (src_type))
     {
+#ifdef FLASK_LINUX
+      if ( (int) Sid > 0 ) {
+      if (mkfifo_secure (dst_path, get_dest_mode (x, src_mode), Sid)) {
+        error (0, errno, _("cannot create fifo `%s'"), dst_path);
+        goto un_backup;
+      }
+      }
+      else
+#endif  /*FLASK_LINUX*/
       if (mkfifo (dst_path, get_dest_mode (x, src_mode)))
 	{
 	  error (0, errno, _("cannot create fifo %s"), quote (dst_path));
@@ -1011,7 +1050,16 @@
 #endif
 	)
     {
-      if (mknod (dst_path, get_dest_mode (x, src_mode), src_sb.st_rdev))
+#ifdef FLASK_LINUX
+      if ( (int) Sid > 0 ) {
+      if (mknod_secure (dst_path, get_dest_mode (x, src_mode), src_sb.st_rdev, Sid)) {
+        error (0, errno, _("cannot create special file `%s'"), dst_path);
+        goto un_backup;
+      }
+      }
+      else
+#endif  /*FLASK_LINUX*/
+   if (mknod (dst_path, get_dest_mode (x, src_mode), src_sb.st_rdev))
 	{
 	  error (0, errno, _("cannot create special file %s"),
 		 quote (dst_path));
@@ -1078,6 +1126,26 @@
 # endif
 	}
 
+#ifdef FLASK_LINUX
+      /* Trying to preserve a security context can fail for any UID, and user
+       * should probably always know about it.
+       */
+      if ( x->preserve_security_context ) {
+	if ( (int) Sid > 0 ) {
+	  error (0, 0, _("cannot set context to SID==%d and preserve it"), (int)Sid);
+	  return 1;
+	}
+	if ( stat_secure(src_path, &tst_sb, &lsid) < 0 ) {
+	  error (0, errno, _("getting security context for %s"), src_path);
+	  return 1;
+	}
+	if ( chsid(dst_path, lsid) < 0 ) {
+	  error (0, errno, _("preserving security context for %s (sid==%d)"), dst_path, (int)lsid);
+	  return 1;
+	}
+      }
+#endif /*FLASK_LINUX*/
+
       return 0;
     }
   else
@@ -1118,6 +1186,27 @@
 	}
     }
 
+#ifdef FLASK_LINUX
+  /* Trying to preserve a security context can fail for any UID, and user
+   * should probably always know about it.
+   */
+
+  if ( x->preserve_security_context ) {
+    if ( (int) Sid > 0 ) {
+      error (0, 0, _("cannot set context to SID==%d and preserve it"), (int) Sid);
+      return 1;
+    }
+    if ( stat_secure(src_path, &tst_sb, &lsid) < 0 ) {
+      error (0, errno, _("getting security context for %s"), src_path);
+      return 1;
+    }
+    if ( chsid(dst_path, lsid) < 0 ) {
+      error (0, errno, _("preserving security context for %s (sid==%d)"), dst_path, (int)lsid);
+      return 1;
+    }
+  }
+#endif /*FLASK_LINUX*/
+
   /* Avoid calling chown if we know it's not necessary.  */
   if (x->preserve_owner_and_group
       && (new_dst || !SAME_OWNER_AND_GROUP (src_sb, dst_sb)))
@@ -1148,6 +1237,13 @@
 	    return 1;
 	}
     }
+#ifdef FLASK_LINUX
+  if ( (int) Sid > 0 && x->preserve_security_context == 0 ) {
+    if ( chsid(dst_path, Sid) < 0 ) {
+      error (0, errno, _("setting scontext (%d) for %s"), (int)Sid, dst_path);       return 1;
+    }
+  }
+#endif /*FLASK_LINUX*/
 
   return delayed_fail;
 
@@ -1163,6 +1259,14 @@
 		    quote_n (0, dst_backup), quote_n (1, dst_path));
 	}
     }
+
+#ifdef FLASK_LINUX
+  /* if rename() just failed, so will this */
+  if ( (int) Sid > 0 && x->preserve_security_context == 0 )
+    if ( chsid(dst_path, Sid) < 0 )
+      error (0, errno, _("setting scontext (%d) for %s"), (int)Sid, dst_path);
+#endif /*FLASK_LINUX*/
+
   return 1;
 }
 
@@ -1194,6 +1298,17 @@
    same as) DST_PATH;  otherwise, set it to zero.
    Return 0 if successful, 1 if an error occurs. */
 
+#ifdef FLASK_LINUX
+int
+copy_s (const char *src_path, const char *dst_path,
+      int nonexistent_dst, const struct cp_options *options,
+      int *copy_into_self, int *rename_succeeded, security_id_t sid)
+{
+  Sid = sid;
+  return( copy( src_path, dst_path, nonexistent_dst, options, copy_into_self, rename_succeeded) );
+}
+#endif  /*FLASK_LINUX*/
+
 int
 copy (const char *src_path, const char *dst_path,
       int nonexistent_dst, const struct cp_options *options,
diff -Nur fileutils-4.1/src/copy.h fileutils-4.1-selinux/src/copy.h
--- fileutils-4.1/src/copy.h	Sun Jan 14 03:03:30 2001
+++ fileutils-4.1-selinux/src/copy.h	Sun Dec  9 17:52:01 2001
@@ -89,6 +89,9 @@
   int preserve_owner_and_group;
   int preserve_chmod_bits;
   int preserve_timestamps;
+#ifdef FLASK_LINUX
+  int preserve_security_context;
+#endif /*FLASK_LINUX*/
 
   /* If nonzero and any of the above (for preserve) file attributes cannot
      be applied to a destination file, treat it as a failure and return
@@ -157,5 +160,4 @@
 copy PARAMS ((const char *src_path, const char *dst_path,
 	      int nonexistent_dst, const struct cp_options *options,
 	      int *copy_into_self, int *rename_succeeded));
-
 #endif
diff -Nur fileutils-4.1/src/cp.c fileutils-4.1-selinux/src/cp.c
--- fileutils-4.1/src/cp.c	Sat Feb  3 08:48:34 2001
+++ fileutils-4.1-selinux/src/cp.c	Sun Dec  9 17:50:40 2001
@@ -52,6 +52,16 @@
 
 #define AUTHORS "Torbjorn Granlund, David MacKenzie, and Jim Meyering"
 
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#include <flask_util.h>          /* for is_flask_enabled() */
+#define CTXTLEN 256
+char *scontext = NULL;
+security_id_t sid = -1;
+int ctxtlen = CTXTLEN;
+char *calloc();
+#endif /*FLASK_LINUX*/
+
 #ifndef _POSIX_VERSION
 uid_t geteuid ();
 #endif
@@ -133,6 +143,10 @@
   {"version-control", required_argument, NULL, 'V'}, /* Deprecated. FIXME. */
   {GETOPT_HELP_OPTION_DECL},
   {GETOPT_VERSION_OPTION_DECL},
+#ifdef FLASK_LINUX
+  {"sid", required_argument, NULL, 'Z'},
+  {"context", required_argument, NULL, 'X'},
+#endif /*FLASK_LINUX*/
   {NULL, 0, NULL, 0}
 };
 
@@ -161,9 +175,18 @@
                                    opened, remove it and try again\n\
   -i, --interactive            prompt before overwrite\n\
   -H                           follow command-line symbolic links\n\
-  -l, --link                   link files instead of copying\n\
+  -l, --link                   link files instead of copying\n"));
+#ifdef FLASK_LINUX
+      printf(_("\
+  -p, --preserve               preserve file attributes and (if Flask) security contexts if possible\n\
+  -Z, --sid=SID                (Flask only) set Security ID of copy to SID\n\
+  -X, --context=CONTEXT        (Flask only) set security context of copy to CONTEXT\n"));
+#else /*FLASK_LINUX*/
+      printf(_("\
+  -p, --preserve               preserve file attributes if possible\n"));
+#endif /*FLASK_LINUX*/
+      printf(_("\
   -L, --dereference            always follow symbolic links\n\
-  -p, --preserve               preserve file attributes if possible\n\
       --parents                append source path to DIRECTORY\n\
   -P                           same as `--parents' for now; soon to change to\n\
                                  `--no-dereference' to conform to POSIX\n\
@@ -197,7 +220,7 @@
 \n\
 "));
       printf (_("\
-The backup suffix is `~', unless set with --suffix or SIMPLE_BACKUP_SUFFIX.\n\
+The backup suffix is `~`, unless set with --suffix or SIMPLE_BACKUP_SUFFIX.\n\
 The version control method may be selected via the --backup option or through\n\
 the VERSION_CONTROL environment variable.  Here are the values:\n\
 \n\
@@ -245,6 +268,9 @@
   char *dst_path;		/* A copy of CONST_DST_PATH we can change. */
   char *src_path;		/* The source name in `dst_path'. */
   uid_t myeuid = geteuid ();
+#ifdef FLASK_LINUX
+  security_id_t lsid;
+#endif /*FLASK_LINUX*/
 
   dst_path = (char *) alloca (strlen (const_dst_path) + 1);
   strcpy (dst_path, const_dst_path);
@@ -256,7 +282,11 @@
 
       dst_path[p->slash_offset] = '\0';
 
+#ifdef FLASK_LINUX
+      if ((*(x->xstat)) (src_path, &src_sb, &lsid))
+#else  /*FLASK_LINUX*/
       if ((*(x->xstat)) (src_path, &src_sb))
+#endif /*FLASK_LINUX*/
 	{
 	  error (0, errno, _("getting attributes of %s"),
 		 quote (src_path));
@@ -309,6 +339,28 @@
 	    }
 	}
 
+#ifdef FLASK_LINUX
+      /* Trying to preserve a security context can fail for any UID, and user
+       * should probably always know about it.
+       */
+
+      if ( x->preserve_security_context ) {
+	int rv;
+	struct stat st;
+	security_id_t lsid;
+
+	if ( (rv = stat_secure(src_path, &st, &lsid)) < 0 ) {
+	  error (0, errno, _("getting security context for %s"), src_path);
+	  return 1;
+	}
+
+	if ( (rv = chsid(dst_path, lsid)) < 0 ) {
+	  error (0, errno, _("preserving security context for %s (sid==%d)"), dst_path, (int)lsid);
+	  return 1;
+	}
+      }
+#endif /*FLASK_LINUX*/
+
       dst_path[p->slash_offset] = '/';
     }
   return 0;
@@ -344,6 +396,9 @@
   char *src;			/* Source name in `dirpath'. */
   char *tmp_dst_dirname;	/* Leading path of `dirpath', malloc. */
   char *dst_dirname;		/* Leading path of `dirpath', alloca. */
+#ifdef FLASK_LINUX
+  security_id_t lsid;
+#endif /*FLASK_LINUX*/
 
   dirpath = (char *) alloca (strlen (const_dirpath) + 1);
   strcpy (dirpath, const_dirpath);
@@ -356,8 +411,11 @@
   free (tmp_dst_dirname);
 
   *attr_list = NULL;
-
+#ifdef FLASK_LINUX
+  if ((*xstat) (dst_dirname, &stats, &lsid))
+#else  /*FLASK_LINUX*/
   if ((*xstat) (dst_dirname, &stats))
+#endif /*FLASK_LINUX*/
     {
       /* Parent of CONST_DIRNAME does not exist.
 	 Make all missing intermediate directories. */
@@ -377,7 +435,11 @@
 	  *attr_list = new;
 
 	  *slash = '\0';
+#ifdef FLASK_LINUX
+	  if ((*xstat) (dirpath, &stats, &lsid))
+#else  /*FLASK_LINUX*/
 	  if ((*xstat) (dirpath, &stats))
+#endif /*FLASK_LINUX*/
 	    {
 	      /* This element of the path does not exist.  We must set
 		 *new_dst and new->is_new_dir inside this loop because,
@@ -386,6 +448,16 @@
 		 exists. */
 	      *new_dst = 1;
 	      new->is_new_dir = 1;
+#ifdef FLASK_LINUX
+	      /* if there's a SID given set new path components to that SID, too */
+	      if ( (int) sid > 0 ) {
+		if ( mkdir_secure (dirpath, mode, sid) < 0 ) {
+		  error (0, errno, _("make_secure(%s, 0x%x, SID==%d) failed"), dirpath, (int)mode, (int)sid);
+		  return 1;
+		}
+	      }
+	      else
+#endif /*FLASK_LINUX*/
 	      if (mkdir (dirpath, mode))
 		{
 		  error (0, errno, _("cannot make directory %s"),
@@ -574,7 +646,12 @@
 	  else
 	    {
 	      int copy_into_self;
-	      ret |= copy (arg, dst_path, new_dst, x, &copy_into_self, NULL);
+#ifdef FLASK_LINUX
+              if ( (int) sid > 0 )
+                ret |= copy_s (arg, dst_path, new_dst, x, &copy_into_self, NULL, sid);
+              else
+#endif  /*FLASK_LINUX*/
+   	        ret |= copy (arg, dst_path, new_dst, x, &copy_into_self, NULL);
 	      forget_all ();
 
 	      if (flag_path)
@@ -653,8 +730,12 @@
 	{
 	  new_dest = (char *) dest;
 	}
-
-      return copy (source, new_dest, new_dst, x, &unused, NULL);
+#ifdef FLASK_LINUX
+      if ( (int) sid > 0 )
+	return copy_s (source, new_dest, new_dst, x, &unused, NULL, sid);
+      else
+#endif /*FLASK_LINUX*/
+	return copy (source, new_dest, new_dst, x, &unused, NULL);
     }
 
   /* unreachable */
@@ -678,6 +759,10 @@
   x->preserve_chmod_bits = 0;
   x->preserve_timestamps = 0;
 
+#ifdef FLASK_LINUX
+  x->preserve_security_context = 0;
+#endif /*FLASK_LINUX*/
+
   x->require_preserve = 0;
   x->recursive = 0;
   x->sparse_mode = SPARSE_AUTO;
@@ -705,6 +790,11 @@
   struct cp_options x;
   char *target_directory = NULL;
   int used_P_option = 0;
+#ifdef FLASK_LINUX
+  int is_flask_enabled_flag;
+
+  is_flask_enabled_flag = is_flask_enabled();
+#endif /*FLASK_LINUX*/
 
   program_name = argv[0];
   setlocale (LC_ALL, "");
@@ -719,7 +809,11 @@
      we'll actually use backup_suffix_string.  */
   backup_suffix_string = getenv ("SIMPLE_BACKUP_SUFFIX");
 
+#ifdef FLASK_LINUX
+  while ((c = getopt_long (argc, argv, "abdfHilLprsuvxPRS:V:Z:X:", long_opts, NULL))
+#else  /*FLASK_LINUX*/
   while ((c = getopt_long (argc, argv, "abdfHilLprsuvxPRS:V:", long_opts, NULL))
+#endif /*FLASK_LINUX*/
 	 != -1)
     {
       switch (c)
@@ -740,6 +834,10 @@
 	  x.require_preserve = 1;
 	  x.recursive = 1;
 	  x.copy_as_regular = 0;
+#ifdef FLASK_LINUX
+	  if (is_flask_enabled_flag) 
+		  x.preserve_security_context = 1;
+#endif /*FLASK_LINUX*/
 	  break;
 
 	case 'V':  /* FIXME: this is deprecated.  Remove it in 2001.  */
@@ -784,7 +882,86 @@
 	  x.preserve_chmod_bits = 1;
 	  x.preserve_timestamps = 1;
 	  x.require_preserve = 1;
+#ifdef FLASK_LINUX
+	  if ( (int) sid > 0 ) { /* scontext could be NULL because of calloc() failure */
+	    if ( scontext )
+	      (void) fprintf(stderr, "%s: cannot force target context to '%s' and preserve it\n", argv[0], scontext);
+	    else
+	      (void) fprintf(stderr, "%s: cannot force target context <-- %d and preserve it\n", argv[0], (int) sid);
+	    exit( 1 );
+	  }
+	  else if (is_flask_enabled_flag) 
+	    x.preserve_security_context = 1;
+#endif /*FLASK_LINUX*/
+	  break;
+#ifdef FLASK_LINUX
+	case 'Z':
+	  /* politely decline if we're not on a flask-enabled kernel. */
+	  if( !is_flask_enabled_flag ) {
+	    fprintf( stderr, "Warning:  ignoring --sid (-Z) "
+		             "because the kernel is not flask-enabled.\n" );
+	    break;
+	  }
+	  if ( x.preserve_security_context ) {
+	    (void) fprintf(stderr, "%s: can`t force target context to `%s` and preserve it\n", argv[0], optarg);
+	    exit( 1 );
+	  }
+	  if ( (int) sid > 0 || scontext != NULL ) {
+	    (void) fprintf(stderr, "%s: --sid (-Z) and --context (-X) are mutually exclusive\n", argv[0]);
+	    exit( 1 );
+	  }
+	  /* check for typos */
+	  {
+	    char *ep;
+	    sid = (security_id_t) strtol(optarg, &ep, 10);
+	    if ( *ep ) {
+	      (void) fprintf(stderr, "%s: non-numeric SID '%s'\n", argv[0], optarg);
+	      exit( 1 );
+	    }
+	  }
+	  /* do a sanity check and save result if SID is OK */
+	  scontext = calloc(1, ctxtlen+1);
+	  if ( scontext != NULL ) {
+	    if ( security_sid_to_context(sid, scontext, &ctxtlen) ) {
+	      if ( errno != ENOSPC ) {
+		(void) fprintf(stderr, "%s: security_sid_to_context(%d): '%s'\n", argv[0], (int) sid, strerror(errno));
+		exit( 1 );
+	      }
+	      free(scontext);
+	      scontext = calloc(1, ctxtlen+1);
+	      /* nonfatal */
+	      if ( scontext != NULL )
+		if ( security_sid_to_context(sid, scontext, &ctxtlen) ) {
+		  (void) fprintf(stderr, "%s: security_sid_to_context(%d): %s\n", argv[0], (int) sid, strerror(errno));
+		  exit( 1 );
+		}
+	    }
+	  }
+	  break;
+	case 'X':
+	  /* politely decline if we're not on a flask-enabled kernel. */
+	  if( !is_flask_enabled_flag ) {
+	    fprintf( stderr, "Warning:  ignoring --context (-X) "
+		             "because the kernel is not flask-enabled.\n" );
+	    break;
+	  }
+	  if ( x.preserve_security_context ) {
+	    (void) fprintf(stderr, "%s: cannot force target context to '%s' and preserve it\n", argv[0], optarg);
+	    exit( 1 );
+	  }
+	  if ( (int) sid > 0 ) {
+	    (void) fprintf(stderr, "%s: --context (-X) and --sid (-Z) are mutually exclusive\n", argv[0]);
+	    exit( 1 );
+	  }
+	  scontext = optarg;
+	  /* sanity check -- also sets sid val */
+	  if ( security_context_to_sid(scontext, strlen(scontext)+1, &sid) ) {
+	    (void) fprintf(stderr, "%s: security_context_to_sid(%s): %s\n", 
+			   argv[0], scontext, strerror(errno));
+	    exit( 1 );
+	  }
 	  break;
+#endif /*FLASK_LINUX*/
 
 	case 'P':
 	  used_P_option = 1;
@@ -859,8 +1036,8 @@
     {
       error (0, 0,
 	     _("\
-Warning: the meaning of `-P' will change in the future to conform to POSIX.\n\
-Use `--parents' for the old meaning, and `--no-dereference' for the new one."));
+Warning: the meaning of `-P` will change in the future to conform to POSIX.\n\
+Use `--parents` for the old meaning, and `--no-dereference` for the new one."));
     }
 
   if (backup_suffix_string)
@@ -886,6 +1063,15 @@
   /* The key difference between -d (--no-dereference) and not is the version
      of `stat' to call.  */
 
+#ifdef FLASK_LINUX
+  /* not sure whether using secure_stat() is strictly necessary,
+     but there's no penalty for using it
+  */
+  if (x.dereference)
+    x.xstat = stat_secure;
+  else
+    x.xstat = lstat_secure;
+#else  /*FLASK_LINUX*/
   if (x.dereference == DEREF_NEVER)
     x.xstat = lstat;
   else
@@ -895,7 +1081,7 @@
 	 any symlinks that are found via recursive traversal.  */
       x.xstat = stat;
     }
-
+#endif /*FLASK_LINUX*/
   /* If --force (-f) was specified and we're in link-creation mode,
      first remove any existing destination file.  */
   if (x.unlink_dest_after_failed_open && (x.hard_link || x.symbolic_link))
diff -Nur fileutils-4.1/src/df.c fileutils-4.1-selinux/src/df.c
--- fileutils-4.1/src/df.c	Sun Dec  9 17:38:51 2001
+++ fileutils-4.1-selinux/src/df.c	Sun Dec  9 17:50:56 2001
@@ -41,6 +41,10 @@
 #include "path-concat.h"
 #include "quote.h"
 #include "save-cwd.h"
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#include <flask_util.h>
+#endif
 
 /* The official name of this program (e.g., no `g' prefix).  */
 #define PROGRAM_NAME "df"
@@ -57,6 +61,9 @@
 /* If nonzero, show inode information. */
 static int inode_format;
 
+/* If nonzero, show security (sid and context) information */
+static int security_format;
+
 /* If nonzero, show even filesystems with zero size or
    uninteresting types. */
 static int show_all_fs;
@@ -130,6 +137,9 @@
   {"all", no_argument, NULL, 'a'},
   {"block-size", required_argument, NULL, BLOCK_SIZE_OPTION},
   {"inodes", no_argument, NULL, 'i'},
+#ifdef FLASK_LINUX
+  {"security", no_argument, NULL, 's'},
+#endif
   {"human-readable", no_argument, NULL, 'h'},
   {"si", no_argument, NULL, 'H'},
   {"kilobytes", no_argument, NULL, 'k'},
@@ -158,7 +168,13 @@
 
   if (inode_format)
     printf (_("    Inodes   IUsed   IFree IUse%%"));
-  else if (output_block_size < 0)
+  else
+#ifdef FLASK_LINUX
+    if (security_format)
+      printf ("    SID Context                      ");
+  else
+#endif
+  if (output_block_size < 0)
     printf (_("    Size  Used Avail Use%%"));
   else if (posix_format)
     printf (_(" %4d-blocks      Used Available Capacity"), output_block_size);
@@ -287,6 +303,13 @@
   uintmax_t used;
   int negate_used;
   double pct = -1;
+#ifdef FLASK_LINUX
+  struct statfs filesystem_stats;  /* statfs_secure() output stats for fs */
+  security_id_t filesystem_sid;      /* statfs_secure() output sid for fs */
+#define CONTEXTLEN 255          /* this is how ps and ls do it, currently */
+  char filesystem_context_s[ CONTEXTLEN ];     /* security context for fs */
+  int context_length = CONTEXTLEN;    /* length of `filesystem_context_s' */
+#endif
 
   if (me_remote && show_local_fs)
     return;
@@ -339,6 +362,29 @@
 	printf ("%-20s", disk);
     }
 
+#ifdef FLASK_LINUX
+  if (security_format)
+    {
+      /* Get sid and context for filesystem described by `mount_point'. *
+       * `mount_point' will be null if the filesystem is not mounted.   *
+       * We won't be able to report useful sid/context in that case.    */
+      if( mount_point ) {
+	if( 0 != statfs_secure( mount_point, &filesystem_stats, 
+				&filesystem_sid ) ) {
+	  error( 1, errno, "%s", mount_point );
+	}
+	if( security_sid_to_context( filesystem_sid, filesystem_context_s,
+				     &context_length ) ) {
+	  error( 1, errno, "security_sid_to_context(%u)", filesystem_sid );
+	}
+	printf("%5u %-29s", filesystem_sid, filesystem_context_s );
+      } else {
+	/* filesystem not mounted, we have no meaningful sid or context */
+	printf("      %-29s", "<not mounted>" );
+      }
+    }
+  else
+#endif
   if (inode_format)
     {
       width = 7;
@@ -788,6 +834,7 @@
   -m, --megabytes       like --block-size=1048576\n\
       --no-sync         do not invoke sync before getting usage info (default)\n\
   -P, --portability     use the POSIX output format\n\
+  -s, --security        list security information instead of block usage\n\
       --sync            invoke sync before getting usage info\n\
   -t, --type=TYPE       limit listing to filesystems of type TYPE\n\
   -T, --print-type      print filesystem type\n\
@@ -808,6 +855,13 @@
   struct stat *stats IF_LINT (= 0);
   int n_valid_args = 0;
 
+#ifdef FLASK_LINUX
+  int is_flask_enabled_flag;  /* set iff kernel has extra flask system calls */
+
+  /* Set `is_flask_enabled_flag' iff the kernel has the extra flask syscalls */
+  is_flask_enabled_flag = is_flask_enabled();
+#endif
+
   program_name = argv[0];
   setlocale (LC_ALL, "");
   bindtextdomain (PACKAGE, LOCALEDIR);
@@ -818,6 +872,9 @@
   fs_select_list = NULL;
   fs_exclude_list = NULL;
   inode_format = 0;
+#ifdef FLASK_LINUX
+  security_format = 0;
+#endif
   show_all_fs = 0;
   show_listed_fs = 0;
 
@@ -827,7 +884,11 @@
   posix_format = 0;
   exit_status = 0;
 
+#ifdef FLASK_LINUX
+  while ((c = getopt_long (argc, argv, "aiF:hHklmPTst:vx:", long_options, NULL))
+#else
   while ((c = getopt_long (argc, argv, "aiF:hHklmPTt:vx:", long_options, NULL))
+#endif
 	 != -1)
     {
       switch (c)
@@ -838,8 +899,31 @@
 	  show_all_fs = 1;
 	  break;
 	case 'i':
+#ifdef FLASK_LINUX
+	  if( security_format ) {
+	    fprintf( stderr, "you cannot specify --security (-s) and "
+		             "--inode (-i) simultaneously.\n" );
+	    exit( 1 );
+	  }
+#endif
 	  inode_format = 1;
 	  break;
+#ifdef FLASK_LINUX
+	case 's':
+	  if( !is_flask_enabled_flag ) {
+	    fprintf( stderr, "Sorry, --security (-s) can be used only on "
+		             "a flask-enabled kernel.\n" );
+	    exit( 1 );
+	  }
+	  if( inode_format ) {
+	    fprintf( stderr, "you cannot specify --security (-s) and "
+		             "--inode (-i) simultaneously.\n" );
+	    exit( 1 );
+	  }
+
+	  security_format = 1;
+	  break;
+#endif
 	case 'h':
 	  output_block_size = -1024;
 	  break;
diff -Nur fileutils-4.1/src/install.c fileutils-4.1-selinux/src/install.c
--- fileutils-4.1/src/install.c	Sun Dec  9 17:38:51 2001
+++ fileutils-4.1-selinux/src/install.c	Sun Dec  9 17:51:05 2001
@@ -54,6 +54,15 @@
 # include <values.h>
 #endif
 
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#include <flask_util.h>          /* for is_flask_enabled() */
+#define CTXTLEN 256
+char *scontext = NULL;
+int ctxtlen = CTXTLEN;
+char *calloc();
+#endif /*FLASK_LINUX*/
+
 struct passwd *getpwnam ();
 struct group *getgrnam ();
 
@@ -136,6 +145,11 @@
   {"mode", required_argument, NULL, 'm'},
   {"owner", required_argument, NULL, 'o'},
   {"preserve-timestamps", no_argument, NULL, 'p'},
+#ifdef FLASK_LINUX
+  {"sid"             , required_argument, NULL, 'Z'},
+  {"context"         , required_argument, NULL, 'X'},
+  {"preserve_context", no_argument      , NULL, 'P'},
+#endif /*FLASK_LINUX*/
   {"strip", no_argument, NULL, 's'},
   {"suffix", required_argument, NULL, 'S'},
   {"version-control", required_argument, NULL, 'V'}, /* Deprecated. FIXME. */
@@ -255,9 +269,18 @@
   x->umask_kill = 0;
   x->update = 0;
   x->verbose = 0;
+#ifdef FLASK_LINUX
+  x->xstat = stat_secure;
+  x->preserve_security_context = 0;
+#else  /*FLASK_LINUX*/
   x->xstat = stat;
+#endif /*FLASK_LINUX*/
 }
 
+#ifdef FLASK_LINUX
+security_id_t sid = -1;
+#endif /*FLASK_LINUX*/
+
 int
 main (int argc, char **argv)
 {
@@ -271,6 +294,13 @@
   struct cp_options x;
   int n_files;
   char **file;
+#ifdef FLASK_LINUX
+  int rv;
+  int is_flask_enabled_flag;  /* set iff kernel has extra flask system calls */
+
+  /* Set `is_flask_enabled_flag' iff the kernel has the extra flask syscalls */
+  is_flask_enabled_flag = is_flask_enabled();
+#endif /*FLASK_LINUX*/
 
   program_name = argv[0];
   setlocale (LC_ALL, "");
@@ -291,8 +321,13 @@
      we'll actually use backup_suffix_string.  */
   backup_suffix_string = getenv ("SIMPLE_BACKUP_SUFFIX");
 
-  while ((optc = getopt_long (argc, argv, "bcCsDdg:m:o:pvV:S:", long_options,
-			      NULL)) != -1)
+#ifdef FLASK_LINUX
+  while ((optc = getopt_long (argc, argv, "bcsDdg:m:o:pvV:S:Z:X:P", long_options,
+                            NULL)) != -1)
+#else  /*FLASK_LINUX*/
+  while ((optc = getopt_long (argc, argv, "bcsDdg:m:o:pvV:S:", long_options,
+                            NULL)) != -1)
+#endif /*FLASK_LINUX*/
     {
       switch (optc)
 	{
@@ -346,6 +381,91 @@
 	  break;
 	case_GETOPT_HELP_CHAR;
 	case_GETOPT_VERSION_CHAR (PROGRAM_NAME, AUTHORS);
+#ifdef FLASK_LINUX
+      case 'P':
+        /* politely decline if we're not on a flask-enabled kernel. */
+        if( !is_flask_enabled_flag ) {
+          fprintf( stderr, "Warning:  ignoring --preserve_context (-P) "
+                           "because the kernel is not flask-enabled.\n" );
+          break;
+        }
+        if ( (int) sid >= 0 ) { /* scontext could be NULL because of calloc() failure */
+          if ( scontext )
+            (void) fprintf(stderr, "%s: cannot force target context to '%s' and preserve it\n", argv[0], scontext);
+          else
+            (void) fprintf(stderr, "%s: cannot force target context <-- %d and preserve it\n", argv[0], (int) sid);
+          exit( 1 );
+        }
+        x.preserve_security_context = 1;
+        break ;
+      case 'Z':
+        /* politely decline if we're not on a flask-enabled kernel. */
+        if( !is_flask_enabled_flag ) {
+          fprintf( stderr, "Warning:  ignoring --sid (-Z) "
+                           "because the kernel is not flask-enabled.\n" );
+          break;
+        }
+        if ( x.preserve_security_context ) {
+          (void) fprintf(stderr, "%s: can't force target context to '%s' and preserve it\n", argv[0], optarg);
+          exit( 1 );
+        }
+        if ( scontext != NULL ) {
+          (void) fprintf(stderr, "%s: --sid (-Z) and --context (-X) are mutually exclusive\n", argv[0]);
+          exit( 1 );
+        }
+        /* check for typos */
+        {
+          char *ep;
+          sid = (security_id_t) strtol(optarg, &ep, 10);
+          if ( *ep ) {
+            (void) fprintf(stderr, "%s: non-numeric SID '%s'\n", argv[0], optarg);
+            exit( 1 );
+          }
+        }
+        /* do a sanity check and save result if SID is OK */
+        scontext = calloc(1, ctxtlen+1);
+        if ( scontext != NULL ) {
+          if ( security_sid_to_context(sid, scontext, &ctxtlen) ) {
+            if ( errno != ENOSPC ) {
+              (void) fprintf(stderr, "%s: security_sid_to_context(%d): '%s'\n", argv[0], (int) sid, strerror(errno));
+              exit( 1 );
+            }
+            free(scontext);
+            scontext = calloc(1, ctxtlen+1);
+            if ( scontext != NULL )
+              if ( security_sid_to_context(sid, scontext, &ctxtlen) ) {
+                (void) fprintf(stderr, "%s: security_sid_to_context(%d): %s\n", argv[0], (int) sid, strerror(errno));
+                exit( 1 );
+              }
+          }
+        }
+        break;
+      case 'X':
+        /* politely decline if we're not on a flask-enabled kernel. */
+        if( !is_flask_enabled_flag ) {
+          fprintf( stderr, "Warning:  ignoring --context (-X) "
+                           "because the kernel is not flask-enabled.\n" );
+          break;
+        }
+        if ( x.preserve_security_context ) {
+          (void) fprintf(stderr, "%s: cannot force target context == '%s' and
+preserve it\n", argv[0], optarg);
+          exit( 1 );
+        }
+        if ( (int) sid >= 0 ) {
+          (void) fprintf(stderr, "%s: --context (-X) and --sid (-Z) are mutually exclusive\n", argv[0]);
+          exit(1);
+        }
+        scontext = optarg;
+        /* sanity check */
+        rv = security_context_to_sid(scontext, strlen(scontext)+1, &sid);
+        if ( rv ) {
+          (void) fprintf(stderr, "%s: security_context_to_sid(%s): %s\n", argv[0], scontext,
+                        strerror(errno));
+          exit(1);
+        }
+        break;
+#endif /*FLASK_LINUX*/
 	default:
 	  usage (1);
 	}
@@ -391,8 +511,17 @@
       for (i = 0; i < n_files; i++)
 	{
 	  errors |=
-	    make_path (file[i], mode, mode, owner_id, group_id, 0,
-		       (x.verbose ? _("creating directory %s") : NULL));
+#ifdef FLASK_LINUX
+        errors |=
+          make_path_s (file[i], mode, mode, owner_id, group_id, 0,
+                       (x.verbose ? _("creating directory `%s'") : NULL), sid);
+#else  /*FLASK_LINUX*/
+          errors |=
+            make_path (file[i], mode, mode, owner_id, group_id, 0,
+                       (x.verbose ? _("creating directory `%s'") : NULL));
+#endif /*FLASK_LINUX*/
+//	    make_path (file[i], mode, mode, owner_id, group_id, 0,
+//		       (x.verbose ? _("creating directory %s") : NULL));
 	  if(errors==0) chmod(file[i], mode);
 	}
     }
@@ -454,8 +583,12 @@
 	 that this option is intended mainly to help installers when the
 	 distribution doesn't provide proper install rules.  */
 #define DIR_MODE (S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH)
+#ifdef FLASK_LINUX
+      fail = make_path_s (dest_dir, DIR_MODE, DIR_MODE, owner_id, group_id, 0,                       (x->verbose ? _("creating directory `%s'") : NULL), sid);
+#else  /*FLASK_LINUX*/
       fail = make_path (dest_dir, DIR_MODE, DIR_MODE, owner_id, group_id, 0,
-			(x->verbose ? _("creating directory %s") : NULL));
+                      (x->verbose ? _("creating directory `%s'") : NULL));
+#endif /*FLASK_LINUX*/
     }
 
   if (fail == 0)
@@ -506,7 +639,6 @@
 
 /* Copy file FROM onto file TO, creating TO if necessary.
    Return 0 if the copy is successful, 1 if not.  */
-
 static int
 copy_file (const char *from, const char *to, const struct cp_options *x)
 {
@@ -529,7 +661,11 @@
 	return 0;
     }
   
+#ifdef FLASK_LINUX
+  fail = copy_s (from, to, nonexistent_dst, x, &copy_into_self, NULL, sid);
+#else
   fail = copy (from, to, nonexistent_dst, x, &copy_into_self, NULL);
+#endif
 
   return fail;
 }
@@ -695,6 +831,35 @@
   or:  %s -d [OPTION]... DIRECTORY...       (3rd format)\n\
 "),
 	      program_name, program_name, program_name);
+#ifdef FLASK_LINUX
+      printf (_("\
+In the first two formats, copy SOURCE to DEST or multiple SOURCE(s) to\n\
+the existing DIRECTORY, while setting permission modes and owner/group.\n\
+In the third format, create all components of the given DIRECTORY(ies).\n\
+\n\
+  -b, --backup        make backup before removal\n\
+  -c                  (ignored)\n\
+  -d, --directory     treat all arguments as directory names; create all\n\
+                        components of the specified directories\n\
+  -D                  create all leading components of DEST except the last,\n\
+                        then copy SOURCE to DEST;  useful in the 1st format\n\
+  -g, --group=GROUP   set group ownership, instead of process' current group\n\
+  -m, --mode=MODE     set permission mode (as in chmod), instead of rwxr-xr-x\n\
+  -o, --owner=OWNER   set ownership (super-user only)\n\
+  -p, --preserve-timestamps   apply access/modification times of SOURCE files\n\
+                        to corresponding destination files\n\
+  -s, --strip         strip symbol tables, only for 1st and 2nd formats\n\
+  -S, --suffix=SUFFIX override the usual backup suffix\n\
+      --verbose       print the name of each directory as it is created\n\
+  -V, --version-control=WORD   override the usual version control\n\
+      --help          display this help and exit\n\
+      --version       output version information and exit\n\
+  -P, --preserve_context (Flask) Preserve security context\n\
+  -Z, --sid=SID          (Flask) Set SID of files and directories\n\
+  -X, --context=CONTEXT  (Flask) Set security context of files and directories\n\
+\n\
+"));
+#else  /*FLASK_LINUX*/
       printf (_("\
 In the first two formats, copy SOURCE to DEST or multiple SOURCE(s) to\n\
 the existing DIRECTORY, while setting permission modes and owner/group.\n\
@@ -719,6 +884,7 @@
       --version       output version information and exit\n\
 \n\
 "));
+#endif /*FLASK_LINUX*/
       printf (_("\
 The backup suffix is `~', unless set with --suffix or SIMPLE_BACKUP_SUFFIX.\n\
 The version control method may be selected via the --backup option or through\n\
diff -Nur fileutils-4.1/src/ls.c fileutils-4.1-selinux/src/ls.c
--- fileutils-4.1/src/ls.c	Sun Dec  9 17:38:51 2001
+++ fileutils-4.1-selinux/src/ls.c	Sun Dec  9 17:51:19 2001
@@ -133,6 +133,25 @@
 
 #define AUTHORS "Richard Stallman and David MacKenzie"
 
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#include <flask_util.h>                 /* for is_flask_enabled() */
+
+#define CTXTLEN    256
+#define P_CTXT      36
+#define SID_DIGITS   5
+
+security_id_t sid;
+char *scontext;
+int ctxtlen = CTXTLEN;
+char *calloc();
+char *generic_error_string = "<error getting security context string>";
+
+static int print_sid            = 0;
+static int print_scontext       = 0;
+
+#endif /*FLASK_LINUX*/
+
 #define obstack_chunk_alloc malloc
 #define obstack_chunk_free free
 
@@ -241,6 +260,9 @@
        otherwise zero.  */
     int have_acl;
 #endif
+#ifdef FLASK_LINUX
+    security_id_t sid;
+#endif /*FLASK_LINUX*/
   };
 
 #if USE_ACL
@@ -331,6 +353,9 @@
 static void sort_files PARAMS ((void));
 static void parse_ls_color PARAMS ((void));
 void usage PARAMS ((int status));
+#ifdef FLASK_LINUX
+static void print_scontext_format PARAMS ((const struct fileinfo *f));
+#endif
 
 /* The name the program was run with, stripped of any leading path. */
 char *program_name;
@@ -404,7 +429,15 @@
     one_per_line,		/* -1 */
     many_per_line,		/* -C */
     horizontal,			/* -x */
-    with_commas			/* -m */
+#ifndef FLASK_LINUX
+    with_commas		        /* -m */
+#else  /*FLASK_LINUX*/
+    with_commas,		/* -m */
+    /* If we are using the flask security mechanism, we also want
+       an output format that lists all security-relevant 
+       information */
+    security
+#endif /*FLASK_LINUX*/
   };
 
 static enum format format;
@@ -705,19 +738,34 @@
   {"block-size", required_argument, 0, BLOCK_SIZE_OPTION},
   {GETOPT_HELP_OPTION_DECL},
   {GETOPT_VERSION_OPTION_DECL},
+#ifdef FLASK_LINUX
+  {"lsid", no_argument, 0, 18},
+  {"context", no_argument, 0, 19},
+  {"lcontext", no_argument, 0, 20},
+  {"sid", no_argument, 0, 21},
+  {"scontext", no_argument, 0, 22},
+#endif /*FLASK_LINUX*/
   {NULL, 0, NULL, 0}
 };
 
 static char const *const format_args[] =
 {
   "verbose", "long", "commas", "horizontal", "across",
+#ifdef FLASK_LINUX
+  "vertical", "single-column", "context", 0
+#else  /*FLASK_LINUX*/
   "vertical", "single-column", 0
+#endif /*FLASK_LINUX*/
 };
 
 static enum format const format_types[] =
 {
   long_format, long_format, with_commas, horizontal, horizontal,
+#ifdef FLASK_LINUX
+  many_per_line, one_per_line, security
+#else  /*FLASK_LINUX*/
   many_per_line, one_per_line
+#endif /*FLASK_LINUX*/
 };
 
 static char const *const sort_args[] =
@@ -900,6 +948,9 @@
 
   format_needs_stat = sort_type == sort_time || sort_type == sort_size
     || format == long_format
+#ifdef FLASK_LINUX
+    || format == security || print_sid
+#endif /*FLASK_LINUX*/
     || trace_links || trace_dirs || print_block_size || print_inode;
   format_needs_type = (format_needs_stat == 0
 		       && (print_with_color || indicator_style != none));
@@ -995,6 +1046,13 @@
   /* Record whether there is an option specifying sort type.  */
   int sort_type_specified = 0;
 
+#ifdef FLASK_LINUX
+  int is_flask_enabled_flag;  /* 1 iff kernel has new flask system calls */
+
+  /* Set `is_flask_enabled_flag iff the kernel has new flask system calls. */
+  is_flask_enabled_flag = is_flask_enabled();
+#endif
+
   qmark_funny_chars = 0;
 
   /* initialize all switches to default settings */
@@ -1046,6 +1104,10 @@
   all_files = 0;
   really_all_files = 0;
   ignore_patterns = 0;
+#ifdef FLASK_LINUX
+  print_sid            = 0;
+  print_scontext       = 0;
+#endif /*FLASK_LINUX*/
 
   /* FIXME: Shouldn't we complain on wrong values? */
   if ((p = getenv ("QUOTING_STYLE"))
@@ -1362,6 +1424,72 @@
 
 	case_GETOPT_VERSION_CHAR (PROGRAM_NAME, AUTHORS);
 
+#ifdef FLASK_LINUX
+	case 18: /* sid */
+	  /* If our kernel is not flask-enabled, decline politely. */
+	  if( !is_flask_enabled_flag ) {
+	    fprintf( stderr, "Sorry, --lsid can be used only "
+		             "on a flask-enabled kernel.\n" );
+	    exit( EXIT_FAILURE );
+	  }
+
+	  /* We are on a flask-enabled kernel.  Continue processing. */
+	  print_sid = 1;
+	  format = long_format;
+	  break;
+
+	case 19: /* security context */
+	  /* If our kernel is not flask-enabled, decline politely. */
+	  if( !is_flask_enabled_flag ) {
+	    fprintf( stderr, "Sorry, --context can be used only "
+		             "on a flask-enabled kernel.\n" );
+	    exit( EXIT_FAILURE );
+	  }
+
+	  /* We are on a flask-enabled kernel.  Continue processing. */
+	  print_scontext = 1;
+	  format = security;
+	  break;
+
+	case 20: /* long-format security context */
+	  /* If our kernel is not flask-enabled, decline politely. */
+	  if( !is_flask_enabled_flag ) {
+	    fprintf( stderr, "Sorry, --lcontext can be used only "
+		             "on a flask-enabled kernel.\n" );
+	    exit( EXIT_FAILURE );
+	  }
+
+	  /* We are on a flask-enabled kernel.  Continue processing. */
+	  print_scontext = 1;
+	  format = long_format;
+	  break;
+
+	case 21: /* short-format SID (like inode) */
+	  /* If our kernel is not flask-enabled, decline politely. */
+	  if( !is_flask_enabled_flag ) {
+	    fprintf( stderr, "Sorry, --sid can be used only "
+		             "on a flask-enabled kernel.\n" );
+	    exit( EXIT_FAILURE );
+	  }
+
+	  /* We are on a flask-enabled kernel.  Continue processing. */
+	  print_sid = 1;
+	  break;
+
+	case 22: /* short-format security context */
+	  /* If our kernel is not flask-enabled, decline politely. */
+	  if( !is_flask_enabled_flag ) {
+	    fprintf( stderr, "Sorry, --scontext can be used only "
+		             "on a flask-enabled kernel.\n" );
+	    exit( EXIT_FAILURE );
+	  }
+
+	  /* We are on a flask-enabled kernel.  Continue processing. */
+	  print_scontext = 0;
+	  format = security;
+	  break;
+#endif /*FLASK_LINUX*/
+
 	default:
 	  usage (EXIT_FAILURE);
 	}
@@ -1943,8 +2071,18 @@
 	}
 
       val = (trace_links
-	     ? stat (path, &files[files_index].stat)
-	     : lstat (path, &files[files_index].stat));
+	     ? 
+#ifdef FLASK_LINUX
+               stat_secure (path, &files[files_index].stat, &files[files_index].sid)
+#else  /*FLASK_LINUX*/
+               stat (path, &files[files_index].stat)
+#endif /*FLASK_LINUX*/
+	     : 
+#ifdef FLASK_LINUX
+               lstat_secure (path, &files[files_index].stat, &files[files_index].sid));
+#else  /*FLASK_LINUX*/
+               lstat (path, &files[files_index].stat));
+#endif /*FLASK_LINUX*/
 
       if (val < 0)
 	{
@@ -2379,6 +2517,16 @@
 	  DIRED_PUTCHAR ('\n');
 	}
       break;
+
+#ifdef FLASK_LINUX
+    case security:
+      for (i = 0; i < files_index; i++)
+      {
+        print_scontext_format (files + i);
+        DIRED_PUTCHAR ('\n');
+      }
+      break;
+#endif /*FLASK_LINUX*/
     }
 }
 
@@ -2622,6 +2770,41 @@
       p += strlen (p);
     }
 
+#ifdef FLASK_LINUX
+
+  if ( print_sid ) {
+    sprintf (p, " %3u ", (unsigned int) f->sid);
+    p += strlen(p);
+  }
+
+  if ( print_scontext ) {
+    scontext = calloc(1, ctxtlen+1);
+    if ( scontext == NULL ) {
+      scontext = generic_error_string;
+    }
+    else if ( security_sid_to_context(f->sid, scontext, &ctxtlen) ) {
+      if ( errno == ENOSPC ) {
+	free(scontext);
+	scontext = calloc(1, ctxtlen+1);
+	if ( scontext == NULL ) {
+	  free(scontext);
+	  scontext = generic_error_string; /* punt */
+	}
+	else if ( security_sid_to_context(f->sid, scontext, &ctxtlen) ) {
+	  (void) fprintf(stderr, "security_sid_to_context(%d): %s\n", f->sid, strerror(errno));
+	  exit( 1 );
+	}
+      }
+      else {
+	(void) fprintf(stderr, "security_sid_to_context(%d): %s\n", f->sid, strerror(errno));
+	exit( 1 );
+      }
+    }
+    sprintf (p, "%-32s ", scontext);
+    p += strlen (p);
+  }
+#endif /*FLASK_LINUX*/
+
   DIRED_INDENT ();
   DIRED_FPUTS (buf, stdout, p - buf);
   print_name_with_quoting (f->name, FILE_OR_LINK_MODE (f), f->linkok,
@@ -2846,6 +3029,12 @@
     printf ("%*s ", INODE_DIGITS,
 	    human_readable ((uintmax_t) f->stat.st_ino, buf, 1, 1));
 
+#ifdef FLASK_LINUX
+  if (print_sid)
+    printf ("%*s ", SID_DIGITS,
+	    human_readable ((uintmax_t) f->sid, buf, 1, 1));
+#endif /*FLASK_LINUX*/
+
   if (print_block_size)
     printf ("%*s ", block_size_size,
 	    human_readable_inexact ((uintmax_t) ST_NBLOCKS (f->stat), buf,
@@ -2969,6 +3158,11 @@
   if (print_inode)
     len += INODE_DIGITS + 1;
 
+#ifdef FLASK_LINUX
+  if (print_sid)
+    len += SID_DIGITS + 1;
+#endif /*FLASK_LINUX*/
+
   if (print_block_size)
     len += 1 + block_size_size;
 
@@ -3348,8 +3542,21 @@
   -X                         sort alphabetically by entry extension\n\
   -1                         list one file per line\n\
       --help                 display this help and exit\n\
-      --version              output version information and exit\n\
-\n\
+      --version              output version information and exit\n"));
+#ifdef FLASK_LINUX
+      printf(_("\n\n\
+FLASK options:\n\n\
+      --lsid                 Display Security ID (SID).  Enable -l\n\
+      --sid                  Display SID.\n\
+      --lcontext             Display security context.   Enable -l. Lines\n\
+                               will probably be too wide for most displays.\n\
+      --context              Display security context so it fits on most\n\
+                               displays.  Displays only mode, user, group,\n\
+                               security context and file name.\n\
+      --scontext             Display only security context and file name.\n\
+"));
+#endif /*FLASK_LINUX*/
+printf(_("\n\
 By default, color is not used to distinguish types of files.  That is\n\
 equivalent to using --color=none.  Using the --color option without the\n\
 optional WHEN argument is equivalent to using --color=always.  With\n\
@@ -3360,3 +3567,107 @@
     }
   exit (status);
 }
+
+#ifdef FLASK_LINUX
+
+static void
+print_scontext_format (const struct fileinfo *f)
+{
+  char modebuf[11];
+
+  /* 7 fields that may require LONGEST_HUMAN_READABLE bytes,
+     1 10-byte mode string,
+     8 spaces, one following each of these fields, and
+     1 trailing NUL byte.  */
+
+  char init_bigbuf[7 * LONGEST_HUMAN_READABLE + 10  + 8 + 1];
+  char *buf = init_bigbuf;
+  size_t bufsize = sizeof (init_bigbuf);
+  size_t s;
+  char *p;
+  const char *fmt;
+  char *user_name;
+  char *group_name;
+  int rv;
+
+  p = buf;
+
+  if ( print_scontext ) { /* zero means terse listing */
+    mode_string (f->stat.st_mode, modebuf);
+    modebuf[10] = '\0';
+
+    /* print mode */
+
+    (void) sprintf (p, "%s ", modebuf);
+    p += strlen (p);
+
+    /* print standard user and group */
+
+    user_name = (numeric_ids ? NULL : getuser (f->stat.st_uid));
+    if (user_name)
+      (void) sprintf (p, "%-8.8s ", user_name);
+    else
+      (void) sprintf (p, "%-8u ", (unsigned int) f->stat.st_uid);
+    p += strlen (p);
+
+    if ( ! inhibit_group ) {
+      group_name = (numeric_ids ? NULL : getgroup (f->stat.st_gid));
+      if (group_name)
+	(void) sprintf (p, "%-8.8s ", group_name);
+      else
+	(void) sprintf (p, "%-8u ", (unsigned int) f->stat.st_gid);
+      p += strlen (p);
+    }
+  }
+
+  if ( print_sid ) {
+    sprintf (p, " %3u ", (unsigned int) f->sid);
+    p += strlen(p);
+  }
+
+  /* print security context */
+
+  scontext = calloc(1, ctxtlen+1);
+  if ( scontext == NULL ) {
+    scontext = generic_error_string;
+  }
+  else if ( security_sid_to_context(f->sid, scontext, &ctxtlen) ) {
+    if ( errno == ENOSPC ) {
+      free(scontext);
+      scontext = calloc(1, ctxtlen+1);
+      if ( scontext == NULL ) {
+	free(scontext);
+	scontext = generic_error_string; /* punt */
+      }
+      else if ( security_sid_to_context(f->sid, scontext, &ctxtlen) ) {
+	(void) fprintf(stderr, "security_sid_to_context(%d): %s\n", f->sid, strerror(errno));
+	exit( 1 );
+      }
+    }
+    else {
+      (void) fprintf(stderr, "security_sid_to_context(%d): %s\n", f->sid, strerror(errno));
+      exit( 1 );
+    }
+  }
+
+  (void) sprintf (p, "%-32s ", scontext);
+  p += strlen (p);
+ 
+  DIRED_INDENT ();
+  DIRED_FPUTS (buf, stdout, p - buf);
+  print_name_with_quoting (f->name, f->stat.st_mode, f->linkok, &dired_obstack);
+ 
+  if (f->filetype == symbolic_link) {
+      if (f->linkname) {
+	  DIRED_FPUTS_LITERAL (" -> ", stdout);
+	  print_name_with_quoting (f->linkname, f->linkmode, f->linkok - 1, NULL);
+	  if (indicator_style != none)
+	    print_type_indicator (f->linkmode);
+      }
+  }
+  else {
+    if (indicator_style != none)
+      print_type_indicator (f->stat.st_mode);
+  }
+}
+#endif /*FLASK_LINUX*/
diff -Nur fileutils-4.1/src/mkdir.c fileutils-4.1-selinux/src/mkdir.c
--- fileutils-4.1/src/mkdir.c	Wed Feb 21 01:05:00 2001
+++ fileutils-4.1-selinux/src/mkdir.c	Sun Dec  9 17:51:27 2001
@@ -36,6 +36,15 @@
 
 void strip_trailing_slashes ();
 
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#include <flask_util.h>          /* for is_flask_enabled() */
+#define CTXTLEN 256
+char *scontext = NULL;
+int ctxtlen = CTXTLEN;
+char *calloc();
+#endif /*FLASK_LINUX*/
+
 /* The name this program was run with. */
 char *program_name;
 
@@ -44,6 +53,10 @@
 
 static struct option const longopts[] =
 {
+#ifdef FLASK_LINUX
+  {"sid",     required_argument, NULL, 's'},
+  {"context", required_argument, NULL, 'c'},
+#endif /*FLASK_LINUX*/
   {"mode", required_argument, NULL, 'm'},
   {"parents", no_argument, NULL, 'p'},
   {"verbose", no_argument, NULL, 'v'},
@@ -61,15 +74,27 @@
   else
     {
       printf (_("Usage: %s [OPTION] DIRECTORY...\n"), program_name);
+#ifdef FLASK_LINUX
       printf (_("\
 Create the DIRECTORY(ies), if they do not already exist.\n\
 \n\
+  -s, --sid=SID         (Flask) set security ID to SID\n\
+  -c, --context=CONTEXT (Flask) set security context to CONTEXT\n\
   -m, --mode=MODE   set permission mode (as in chmod), not rwxrwxrwx - umask\n\
-  -p, --parents     no error if existing, make parent directories as needed\n\
-  -v, --verbose     print a message for each created directory\n\
+  -p, --parents     no error if existing, make parent directories as needed\n\        --verbose     print a message for each created directory\n\
       --help        display this help and exit\n\
       --version     output version information and exit\n\
 "));
+#else  /*FLASK_LINUX*/
+      printf (_("\
+Create the DIRECTORY(ies), if they do not already exist.\n\
+\n\
+  -m, --mode=MODE   set permission mode (as in chmod), not rwxrwxrwx - umask\n\
+  -p, --parents     no error if existing, make parent directories as needed\n\+       --verbose     print a message for each created directory\n\
+      --help        display this help and exit\n\
+      --version     output version information and exit\n\
+"));
+#endif /*FLASK_LINUX*/
       puts (_("\nReport bugs to <bug-fileutils@gnu.org>."));
     }
   exit (status);
@@ -78,12 +103,21 @@
 int
 main (int argc, char **argv)
 {
+#ifdef FLASK_LINUX
+  security_id_t sid = -1;
+  char *scontext = NULL;
+  int rv;
+#endif /*FLASK_LINUX*/
   mode_t newmode;
   mode_t parent_mode;
   const char *specified_mode = NULL;
   const char *verbose_fmt_string = NULL;
   int errors = 0;
   int optc;
+  int is_flask_enabled_flag;  /* set iff kernel has extra flask system calls */
+
+  /* Set `is_flask_enabled_flag' iff the kernel has the extra flask syscalls */
+  is_flask_enabled_flag = is_flask_enabled();
 
   program_name = argv[0];
   setlocale (LC_ALL, "");
@@ -94,7 +128,11 @@
 
   create_parents = 0;
 
+#ifdef FLASK_LINUX
+  while ((optc = getopt_long (argc, argv, "pm:vs:c:", longopts, NULL)) != -1)
+#else  /*FLASK_LINUX*/
   while ((optc = getopt_long (argc, argv, "pm:v", longopts, NULL)) != -1)
+#endif /*FLASK_LINUX*/
     {
       switch (optc)
 	{
@@ -111,6 +149,66 @@
 	  break;
 	case_GETOPT_HELP_CHAR;
 	case_GETOPT_VERSION_CHAR (PROGRAM_NAME, AUTHORS);
+#ifdef FLASK_LINUX
+      case 's':
+        /* politely decline if we're not on a flask-enabled kernel. */
+        if( !is_flask_enabled_flag ) {
+          fprintf( stderr, "Sorry, --sid (-s) can be used only on "
+                           "a flask-enabled kernel.\n" );
+          exit( 1 );
+        }
+        if ( ((int) sid > 0) || (scontext != NULL) ) {
+          (void) fprintf(stderr, "%s: --sid (-s) and --context (-c) are mutually exclusive\n", argv[0]);
+          exit( 1 );
+        }
+        {
+          /* check for typos */
+          char *ep;
+          sid = (security_id_t) strtol(optarg, &ep, 10);
+          if ( *ep ) {
+            (void) fprintf(stderr, "%s: non-numeric SID '%s'\n", argv[0], optarg);
+            exit( 1 );
+          }
+        }
+        /* do sanity check, save result on success */
+        scontext = calloc(1, ctxtlen+1);
+        if ( scontext != NULL ) {
+          if ( security_sid_to_context(sid, scontext, &ctxtlen) ) {
+            if ( errno != ENOSPC ) {
+              (void) fprintf(stderr, "%s: security_sid_to_context(%d): '%s'\n", argv[0], (int) sid, strerror(errno));
+              exit( 1 );
+            }
+            free(scontext);
+            scontext = calloc(1, ctxtlen+1);
+            /* nonfatal, so if there's an error we punt */
+            if ( scontext != NULL )
+              if ( security_sid_to_context(sid, scontext, &ctxtlen) ) {
+                (void) fprintf(stderr, "%s: security_sid_to_context(%d): %s\n", argv[0], (int) sid, strerror(errno));
+                exit( 1 );
+              }
+          }
+        }
+        break;
+      case 'c':
+        /* politely decline if we're not on a flask-enabled kernel. */
+        if( !is_flask_enabled_flag ) {
+          fprintf( stderr, "Sorry, --context (-c) can be used only on "
+                           "a flask-enabled kernel.\n" );
+          exit( 1 );
+        }
+        if ( ((int) sid >= 0) || (scontext != NULL) ) {
+          (void) fprintf(stderr, "%s: --context (-c) and --sid (-s) are mutually exclusive\n", argv[0]);
+          exit( 1 );
+        }
+        scontext = optarg;
+        /* sanity check */
+        rv = security_context_to_sid(scontext, strlen(scontext)+1, &sid);
+        if ( rv ) {
+          (void) fprintf(stderr, "%s: security_context_to_sid(%s): %s\n", argv[0], scontext, strerror(errno));
+          exit( 1 );
+        }
+        break;
+#endif /*FLASK_LINUX*/
 	default:
 	  usage (1);
 	}
@@ -153,8 +251,30 @@
       if (create_parents)
 	{
 	  char *parents = dir_name (argv[optind]);
-	  fail = make_path (parents, parent_mode, parent_mode,
-			    -1, -1, 1, verbose_fmt_string);
+#ifdef FLASK_LINUX
+        /* `sid' will be > 0 iff the --sid (-s) option was specified
+         * on the command line.  The --sid argument processing code
+         * exits politely if the kernel doesn't support the new
+         * flask system calls.  So, if sid > 0 at this point, we
+         * know we're on a flask-enabled kernel.
+         *
+         * make_path_s() calls make_path(), passing `sid' to it via
+         * a global variable `Sid' made specially for that purpose.
+         * The flask-specific code in make_path() calls
+         * flask-specific system calls only if `sid' (aka `Sid') is
+         * > 0.
+         *
+         * Put these two facts together, and we know that make_path_s()
+         * will make flask-specific system calls only if we are on a
+         * flask-enabled kernel.  Consequently, it's safe to call
+         * make_path_s() whether or not we're on a flask-enabled kernel.
+         */
+          fail = make_path_s (argv[optind], newmode, parent_mode,
+                               -1, -1, 1, verbose_fmt_string, sid);
+#else  /*FLASK_LINUX*/
+          fail = make_path (argv[optind], newmode, parent_mode,
+                             -1, -1, 1, verbose_fmt_string);
+#endif /*FLASK_LINUX*/
 	  free (parents);
 	}
 
@@ -162,7 +282,21 @@
 	{
 	  const char *dir = argv[optind];
 	  int dir_created;
+#ifdef FLASK_LINUX
+      /* `sid' will be > 0 iff the --sid (-s) option was specified on the  *
+       * command line.  The --sid argument processing code exits politely  *
+       * if the kernel doesn't support the new flask system calls.  So,    *
+       * if sid > 0 at this point, we know we're on a flask-enabled kernel *
+       * and can call the "_secure" version of mkdir.                      */
+      if ( (int) sid > 0 ) {
+      if ( mkdir_secure (argv[optind], newmode, sid) < 0 ) {
+        error (0, errno, _("Cannot make directory `%s'"), argv[optind]);
+        fail = 1;
+      }
+      }
+#else /*FLASK_LINUX*/
 	  fail = make_dir (dir, dir, newmode, &dir_created);
+#endif /*FLASK_LINUX*/
 	  if (fail)
 	    {
 	      /* make_dir already gave a diagnostic.  */
diff -Nur fileutils-4.1/src/mkfifo.c fileutils-4.1-selinux/src/mkfifo.c
--- fileutils-4.1/src/mkfifo.c	Sat Sep 30 02:40:35 2000
+++ fileutils-4.1-selinux/src/mkfifo.c	Sun Dec  9 17:51:28 2001
@@ -32,11 +32,20 @@
 
 #define AUTHORS "David MacKenzie"
 
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#include <flask_util.h>          /* for is_flask_enabled() */
+#endif /*FLASK_LINUX*/
+
 /* The name this program was run with. */
 char *program_name;
 
 static struct option const longopts[] =
 {
+#ifdef FLASK_LINUX
+  {"sid",     required_argument, NULL, 's'},
+  {"context", required_argument, NULL, 'c'},
+#endif /*FLASK_LINUX*/
   {"mode", required_argument, NULL, 'm'},
   {GETOPT_HELP_OPTION_DECL},
   {GETOPT_VERSION_OPTION_DECL},
@@ -53,6 +62,17 @@
   else
     {
       printf (_("Usage: %s [OPTION] NAME...\n"), program_name);
+#ifdef FLASK_LINUX
+      printf (_("\
+Create named pipes (FIFOs) with the given NAMEs.\n\
+\n\
+  -s, --sid=SID           set SID\n\
+  -c, --context=CONTEXT   set security context (quoted string)\n\
+  -m, --mode=MODE   set permission mode (as in chmod), not 0666 - umask\n\
+      --help        display this help and exit\n\
+      --version     output version information and exit\n\
+"));
+#else /*FLASK_LINUX*/
       printf (_("\
 Create named pipes (FIFOs) with the given NAMEs.\n\
 \n\
@@ -60,6 +80,7 @@
       --help        display this help and exit\n\
       --version     output version information and exit\n\
 "));
+#endif /*FLASK_LINUX*/
       puts (_("\nReport bugs to <bug-fileutils@gnu.org>."));
     }
   exit (status);
@@ -74,6 +95,15 @@
   const char *specified_mode;
   int errors = 0;
   int optc;
+#ifdef FLASK_LINUX
+  security_id_t sid = -1;
+  char *scontext = NULL;
+  int rv;
+  int is_flask_enabled_flag;  /* set iff kernel has extra flask system calls */
+
+  /* Set `is_flask_enabled_flag' iff the kernel has the extra flask syscalls */
+  is_flask_enabled_flag = is_flask_enabled();
+#endif /*FLASK_LINUX*/
 
   program_name = argv[0];
   setlocale (LC_ALL, "");
@@ -87,7 +117,11 @@
 #ifndef S_ISFIFO
   error (4, 0, _("fifo files not supported"));
 #else
+#ifdef FLASK_LINUX
+  while ((optc = getopt_long (argc, argv, "m:s:c:", longopts, NULL)) != -1)
+#else  /*FLASK_LINUX*/
   while ((optc = getopt_long (argc, argv, "m:", longopts, NULL)) != -1)
+#endif /*FLASK_LINUX*/
     {
       switch (optc)
 	{
@@ -96,6 +130,46 @@
 	case 'm':
 	  specified_mode = optarg;
 	  break;
+#ifdef FLASK_LINUX
+      case 's':
+        /* politely decline if we're not on a flask-enabled kernel. */
+        if( !is_flask_enabled_flag ) {
+          fprintf( stderr, "Sorry, --sid (-s) can be used only on "
+                           "a flask-enabled kernel.\n" );
+          exit( 1 );
+        }
+        if ( scontext != NULL ) {
+          (void) printf("%s: --sid and --context args are mutually exclusive\n", argv[0]);
+          (void) fflush(stdout);
+          close_stdout();
+          exit(1);
+        }
+        sid = atoi(optarg);
+        break;
+      case 'c':
+        /* politely decline if we're not on a flask-enabled kernel. */
+        if( !is_flask_enabled_flag ) {
+          fprintf( stderr, "Sorry, --context (-c) can be used only on "
+                           "a flask-enabled kernel.\n" );
+          exit( 1 );
+        }
+        if ( (int) sid >= 0 ) {
+          (void) printf("%s: --context and --sid args are mutually exclusive\n", argv[0]);
+          (void) fflush(stdout);
+          close_stdout();
+          exit(1);
+        }
+        scontext = optarg;
+        rv = security_context_to_sid(scontext, strlen(scontext)+1, &sid);
+        if ( rv ) {
+          (void) printf("%s: security_context_to_sid(%s): %s\n", argv[0], scontext,
+                        strerror(errno));
+          (void) fflush(stdout);
+          close_stdout();
+          exit(1);
+        }
+        break;
+#endif /*FLASK_LINUX*/
 	case_GETOPT_HELP_CHAR;
 	case_GETOPT_VERSION_CHAR (PROGRAM_NAME, AUTHORS);
 	default:
@@ -123,7 +197,21 @@
 
   for (; optind < argc; ++optind)
     {
-      int fail = mkfifo (argv[optind], newmode);
+       int fail;
+#ifdef FLASK_LINUX
+     /* `sid' will be > 0 iff the --sid (-s) option was specified on the  *
+       * command line.  The --sid argument processing code exits politely  *
+       * if the kernel doesn't support the new flask system calls.  So,    *
+       * if sid > 0 at this point, we know we're on a flask-enabled kernel *
+       * and can call the "_secure" version of mkfifo.                     */
+      if ( (int) sid > 0 ) {
+      if ( mkfifo_secure (argv[optind], newmode, sid) )
+          error (0, errno, _("cannot mkfifo_secure(%s)"), argv[optind]);
+          fail = 1;
+      }
+#else /*FLASK_LINUX*/
+      fail = mkfifo (argv[optind], newmode);
+#endif /*FLASK_LINUX*/
       if (fail)
 	error (0, errno, _("cannot create fifo `%s'"), quote (argv[optind]));
 
diff -Nur fileutils-4.1/src/mknod.c fileutils-4.1-selinux/src/mknod.c
--- fileutils-4.1/src/mknod.c	Sat Sep 30 01:53:23 2000
+++ fileutils-4.1-selinux/src/mknod.c	Sun Dec  9 17:51:29 2001
@@ -24,6 +24,9 @@
    -m, --mode=mode	Set the mode of created nodes to MODE, which is
 			symbolic as in chmod and uses the umask as a point of
 			departure.
+   For Flask-enhanced Linux (FLASK_LINUX)
+   -s, --sid=SID        Set the SID for the special device
+   -c, --context=scontext Set the security context for the special device
 
    David MacKenzie <djm@ai.mit.edu>  */
 
@@ -43,11 +46,20 @@
 
 #define AUTHORS "David MacKenzie"
 
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#include <flask_util.h>          /* for is_flask_enabled() */
+#endif /*FLASK_LINUX*/
+
 /* The name this program was run with. */
 char *program_name;
 
 static struct option const longopts[] =
 {
+#ifdef FLASK_LINUX
+  {"sid",     required_argument, NULL, 's'},
+  {"context", required_argument, NULL, 'c'},
+#endif /*FLASK_LINUX*/
   {"mode", required_argument, NULL, 'm'},
   {GETOPT_HELP_OPTION_DECL},
   {GETOPT_VERSION_OPTION_DECL},
@@ -63,6 +75,23 @@
   else
     {
       printf (_("Usage: %s [OPTION]... NAME TYPE [MAJOR MINOR]\n"), program_name);
+#ifdef FLASK_LINUX
+      printf (_("\
+Create the special file NAME of the given TYPE.\n\
+\n\
+  -s, --sid=SID           set SID\n\
+  -c, --context=CONTEXT   set security context (quoted string)\n\
+  -m, --mode=MODE   set permission mode (as in chmod), not 0666 - umask\n\
+      --help        display this help and exit\n\
+      --version     output version information and exit\n\
+\n\
+MAJOR MINOR are forbidden for TYPE p, mandatory otherwise.  TYPE may be:\n\
+\n\
+  b      create a block (buffered) special file\n\
+  c, u   create a character (unbuffered) special file\n\
+  p      create a FIFO\n\
+"));
+#else /*FLASK_LINUX*/
       printf (_("\
 Create the special file NAME of the given TYPE.\n\
 \n\
@@ -76,6 +105,7 @@
   c, u   create a character (unbuffered) special file\n\
   p      create a FIFO\n\
 "));
+#endif /*FLASK_LINUX*/
       puts (_("\nReport bugs to <bug-fileutils@gnu.org>."));
     }
   exit (status);
@@ -91,6 +121,15 @@
   int i_major, i_minor;
   long int tmp_major, tmp_minor;
   char *s;
+#ifdef FLASK_LINUX
+  security_id_t sid = -1;
+  char *scontext = NULL;
+  int rv;
+  int is_flask_enabled_flag;  /* set iff kernel has extra flask system calls */
+
+  /* Set `is_flask_enabled_flag' iff the kernel has the extra flask syscalls */
+  is_flask_enabled_flag = is_flask_enabled();
+#endif /*FLASK_LINUX*/
 
   program_name = argv[0];
   setlocale (LC_ALL, "");
@@ -100,8 +139,11 @@
   atexit (close_stdout);
 
   specified_mode = NULL;
-
+#ifdef FLASK_LINUX
+  while ((optc = getopt_long (argc, argv, "m:s:c:", longopts, NULL)) != -1)
+#else  /*FLASK_LINUX*/
   while ((optc = getopt_long (argc, argv, "m:", longopts, NULL)) != -1)
+#endif /*FLASK_LINUX*/
     {
       switch (optc)
 	{
@@ -110,6 +152,46 @@
 	case 'm':
 	  specified_mode = optarg;
 	  break;
+#ifdef FLASK_LINUX
+      case 's':
+        /* politely decline if we're not on a flask-enabled kernel. */
+        if( !is_flask_enabled_flag ) {
+          fprintf( stderr, "Sorry, --sid (-s) can be used only on "
+                           "a flask-enabled kernel.\n" );
+          exit( 1 );
+        }
+        if ( scontext != NULL ) {
+          (void) printf("%s: --sid (-s) and --context (-c) are mutually exclusive\n", argv[0]);
+          (void) fflush(stdout);
+          close_stdout();
+          exit(1);
+        }
+        sid = atoi(optarg);
+        break;
+      case 'c':
+        /* politely decline if we're not on a flask-enabled kernel. */
+        if( !is_flask_enabled_flag ) {
+          fprintf( stderr, "Sorry, --context (-c) can be used only on "
+                           "a flask-enabled kernel.\n" );
+          exit( 1 );
+        }
+        if ( (int) sid >= 0 ) {
+          (void) printf("%s: --context (-c) and --sid (-s) are mutually exclusive\n", argv[0]);
+          (void) fflush(stdout);
+          close_stdout();
+          exit(1);
+        }
+        scontext = optarg;
+        rv = security_context_to_sid(scontext, strlen(scontext)+1, &sid);
+        if ( rv ) {
+          (void) printf("%s: security_context_to_sid(%s): %s\n", argv[0], scontext,
+                        strerror(errno));
+          (void) fflush(stdout);
+          close_stdout();
+          exit(1);
+        }
+        break;
+#endif /*FLASK_LINUX*/
 	case_GETOPT_HELP_CHAR;
 	case_GETOPT_VERSION_CHAR (PROGRAM_NAME, AUTHORS);
 	default:
@@ -169,7 +251,18 @@
 
       i_major = (int) tmp_major;
       i_minor = (int) tmp_minor;
-
+#ifdef FLASK_LINUX
+      /* `sid' will be > 0 iff the --sid (-s) option was specified on the  *
+       * command line.  The --sid argument processing code exits politely  *
+       * if the kernel doesn't support the new flask system calls.  So,    *
+       * if sid > 0 at this point, we know we're on a flask-enabled kernel *
+       * and can call the "_secure" version of mknod.                      */
+      if ( (int) sid > 0 ) {
+	if ( mknod_secure (argv[optind], newmode | S_IFBLK, makedev (i_major, i_minor), sid) )
+	  error (1, errno, "mknod_secure(%s)", argv[optind]);
+      }
+      else
+#endif /*FLASK_LINUX*/
       if (mknod (argv[optind], newmode | S_IFBLK, makedev (i_major, i_minor)))
 	error (1, errno, "%s", quote (argv[optind]));
 #endif
@@ -198,7 +291,18 @@
 
       i_major = (int) tmp_major;
       i_minor = (int) tmp_minor;
-
+#ifdef FLASK_LINUX
+      /* `sid' will be > 0 iff the --sid (-s) option was specified on the  *
+       * command line.  The --sid argument processing code exits politely  *
+       * if the kernel doesn't support the new flask system calls.  So,    *
+       * if sid > 0 at this point, we know we're on a flask-enabled kernel *
+       * and can call the "_secure" version of mknod.                      */
+      if ( (int) sid > 0 ) {
+	if ( mknod_secure (argv[optind], newmode | S_IFCHR, makedev (i_major, i_minor), sid) )
+	  error (1, errno, "mknod_secure(%s)", argv[optind]);
+      }
+      else
+#endif /*FLASK_LINUX*/
       if (mknod (argv[optind], newmode | S_IFCHR, makedev (i_major, i_minor)))
 	error (1, errno, "%s", quote (argv[optind]));
 #endif
@@ -214,8 +318,21 @@
 major and minor device numbers may not be specified for fifo files"));
 	  usage (1);
 	}
+#ifdef FLASK_LINUX
+      /* `sid' will be > 0 iff the --sid (-s) option was specified on the  *
+       * command line.  The --sid argument processing code exits politely  *
+       * if the kernel doesn't support the new flask system calls.  So,    *
+       * if sid > 0 at this point, we know we're on a flask-enabled kernel *
+       * and can call the "_secure" version of mknod.                      */
+      if ( (int) sid > 0 ) {
+      if ( mkfifo_secure (argv[optind], newmode, sid) )
+        error (1, errno, "mkfifo_secure(%s)", argv[optind]);
+      }
+      else
+#else /*FLASK_LINUC*/
       if (mkfifo (argv[optind], newmode))
 	error (1, errno, "%s", quote (argv[optind]));
+#endif /*FLASK_LINUX*/
 #endif
       break;
 
diff -Nur fileutils-4.1/src/system.h fileutils-4.1-selinux/src/system.h
--- fileutils-4.1/src/system.h	Wed Apr 19 14:41:14 2000
+++ fileutils-4.1-selinux/src/system.h	Sun Dec  9 17:52:11 2001
@@ -23,6 +23,10 @@
 # define mkfifo(path, mode) (mknod ((path), (mode) | S_IFIFO, 0))
 #endif
 
+#ifdef FLASK_LINUX
+# define mkfifo_secure(path, mode, sid) (mknod_secure ((path), (mode) | S_IFIFO, 0, (sid)))
+#endif /*FLASK_LINUX*/
+
 #if HAVE_SYS_PARAM_H
 # include <sys/param.h>
 #endif

--=_homegate.savages.net-23968-1007964898-0001-2
Content-Type: text/plain; name="findutils-4.1.7-selinux.patch"; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="findutils-4.1.7-selinux.patch"

diff -Nur findutils-4.1.7/INSTALL findutils-4.1.7-lsm/INSTALL
--- findutils-4.1.7/INSTALL	Wed Apr  5 00:20:12 2000
+++ findutils-4.1.7-lsm/INSTALL	Sat Dec  8 20:35:32 2001
@@ -31,6 +31,10 @@
      `sh ./configure' instead to prevent `csh' from trying to execute
      `configure' itself.
=20
+     If you are configuring for the Flask secure Linux, you will need to=

+     say where the root of the Flask source tree is located (`--with-fla=
skroot')
+     in addition to specifying `--with-flask'.
+
      Running `configure' takes awhile.  While running, it prints some
      messages telling which features it is checking for.
=20
diff -Nur findutils-4.1.7/README findutils-4.1.7-lsm/README
--- findutils-4.1.7/README	Tue Jan 18 00:53:44 2000
+++ findutils-4.1.7-lsm/README	Sat Dec  8 20:35:32 2001
@@ -21,6 +21,11 @@
 unless you are running NIS or Hesiod, which make password and group
 calls very expensive.
=20
+--with-flask, --with-flaskroot
+  Both are needed to compile for Flask secure Linux. You will need
+  the Flask libraries, headers and kernel to take advantage of the
+  options.
+
 To gain speed, GNU find avoids statting files whenever possible.
 It does this by:
 1. Checking the number of links to directories and not statting files
diff -Nur findutils-4.1.7/configure.in findutils-4.1.7-lsm/configure.in
--- findutils-4.1.7/configure.in	Sun May 20 14:12:34 2001
+++ findutils-4.1.7-lsm/configure.in	Sat Dec  8 20:35:17 2001
@@ -17,6 +17,17 @@
    are running NIS or Hesiod, which make password and group calls
    very expensive.]))
=20
+dnl Make Flask security-enhanced versions of fileutils
+dnl Should add existence chackes for libsecure library, etc
+dnl   CFLAGS=3D"$CFLAGS -DFLASK_LINUX  -I/usr/flask/include -I/usr/src/l=
inux/include"
+dnl   LIBS=3D"$LIBS -L/usr/flask/lib -lsecure"])
+
+AC_ARG_WITH(selinux,
+[  --with-selinux            include support for SELinux],
+[  AC_DEFINE(FLASK_LINUX)
+   CFLAGS=3D"$CFLAGS -DFLASK_LINUX -I/usr/local/selinux/include"
+   LIBS=3D"$LIBS -L/usr/local/selinux/lib -lsecure"])
+ =20
 dnl Checks for programs.
 AC_PROG_CC
 AC_PROG_CPP
diff -Nur findutils-4.1.7/find/defs.h findutils-4.1.7-lsm/find/defs.h
--- findutils-4.1.7/find/defs.h	Sun May 20 13:39:37 2001
+++ findutils-4.1.7-lsm/find/defs.h	Sat Dec  8 20:35:32 2001
@@ -118,6 +118,10 @@
 #define MODE_RWX	(S_IXUSR | S_IXGRP | S_IXOTH | MODE_RW)
 #define MODE_ALL	(S_ISUID | S_ISGID | S_ISVTX | MODE_RWX)
=20
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#endif /*FLASK_LINUX*/
+
 /* Not char because of type promotion; NeXT gcc can't handle it.  */
 typedef int boolean;
 #define		true    1
@@ -265,6 +269,10 @@
     struct perm_val perm;	/* perm */
     mode_t type;		/* type */
     FILE *stream;		/* fprint fprint0 */
+#ifdef FLASK_LINUX
+    security_id_t sid;          /* sid */
+    char *scontext;             /* scontext */
+#endif /*FLASK_LINUX*/
     struct format_val printf_vec; /* printf fprintf */
   } args;
=20
@@ -310,6 +318,13 @@
 VOID *xmalloc PARAMS((size_t n));
 VOID *xrealloc PARAMS((VOID *p, size_t n));
=20
+#ifdef FLASK_LINUX
+boolean pred_sid PARAMS((char *pathname, struct stat *stat_buf, struct p=
redicate *pred_ptr));
+boolean pred_scontext PARAMS((char *pathname, struct stat *stat_buf, str=
uct predicate *pred_ptr));
+extern int (*x_sec_stat) ();
+#endif /*FLASK_LINUX*/
+
+
 /* xstrdup.c */
 char *xstrdup PARAMS((char *string));
=20
diff -Nur findutils-4.1.7/find/find.1 findutils-4.1.7-lsm/find/find.1
--- findutils-4.1.7/find/find.1	Sun May 20 13:39:37 2001
+++ findutils-4.1.7-lsm/find/find.1	Sat Dec  8 20:35:32 2001
@@ -230,6 +230,10 @@
 file of type \fIc\fR; if \-follow has been given, true if \fIc\fR is
 `l'.  In other words, for symbolic links, \-xtype checks the type of
 the file that \-type does not check.
+.IP "\-sid \fIsid\fR"
+(Flask only) File has the Security Identifier \fIsid\fR.
+.IP "\-scontext \fIscontext\fR"
+(Flask only) File has the security context \fIscontext\fR.
 .SS ACTIONS
 .IP "\-exec \fIcommand\fR ;"
 Execute \fIcommand\fR; true if 0 status is returned.  All following
@@ -417,6 +421,10 @@
 File's user name, or numeric user ID if the user has no name.
 .IP %U
 File's numeric user ID.
+.IP %C
+(Flask only) file's security context.
+.IP %S
+(Flask only) file's numeric SID.
 .PP
 A `%' character followed by any other character is discarded (but the
 other character is printed).
diff -Nur findutils-4.1.7/find/find.c findutils-4.1.7-lsm/find/find.c
--- findutils-4.1.7/find/find.c	Sun May 20 13:39:37 2001
+++ findutils-4.1.7-lsm/find/find.c	Sat Dec  8 20:35:32 2001
@@ -135,6 +135,9 @@
=20
 /* Pointer to the function used to stat files. */
 int (*xstat) ();
+#ifdef FLASK_LINUX
+int (*x_sec_stat) ();
+#endif /* FLASK_LINUX */
=20
 /* Status value to return to system. */
 int exit_status;
@@ -181,6 +184,9 @@
   xstat =3D debug_stat;
 #else /* !DEBUG_STAT */
   xstat =3D lstat;
+#ifdef FLASK_LINUX
+  x_sec_stat =3D lstat_secure;
+#endif /* FLASK_LINUX */
 #endif /* !DEBUG_STAT */
=20
   human_block_size (getenv ("FIND_BLOCK_SIZE"), 0, &output_block_size);
diff -Nur findutils-4.1.7/find/parser.c findutils-4.1.7-lsm/find/parser.c=

--- findutils-4.1.7/find/parser.c	Sun May 20 13:39:37 2001
+++ findutils-4.1.7-lsm/find/parser.c	Sat Dec  8 20:35:32 2001
@@ -23,6 +23,11 @@
 #include "modetype.h"
 #include "xstrtol.h"
=20
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+char *calloc();
+#endif /*FLASK_LINUX*/
+
 #if ENABLE_NLS
 # include <libintl.h>
 # define _(Text) gettext (Text)
@@ -113,7 +118,11 @@
 static boolean parse_version PARAMS((char *argv[], int *arg_ptr));
 static boolean parse_xdev PARAMS((char *argv[], int *arg_ptr));
 static boolean parse_xtype PARAMS((char *argv[], int *arg_ptr));
-
+#ifdef FLASK_LINUX
+static boolean parse_sid PARAMS((char *argv[], int *arg_ptr));
+static boolean parse_scontext PARAMS((char *argv[], int *arg_ptr));
+#endif /*FLASK_LINUX*/
+=20
 static boolean insert_regex PARAMS((char *argv[], int *arg_ptr, boolean =
ignore_case));
 static boolean insert_type PARAMS((char *argv[], int *arg_ptr, boolean (=
*which_pred )()));
 static boolean insert_fprintf PARAMS((FILE *fp, boolean (*func )(), char=
 *argv[], int *arg_ptr));
@@ -215,7 +224,11 @@
   {"-version", parse_version},	/* GNU */
   {"xdev", parse_xdev},
   {"xtype", parse_xtype},	/* GNU */
-  {0, 0}
+#ifdef FLASK_LINUX
+  {"sid", parse_sid},         /* FLASK */
+  {"scontext", parse_scontext},       /* FLASK */
+#endif /*FLASK_LINUX*/
+   {0, 0}
 };
 =0C
 /* Return a pointer to the parser function to invoke for predicate
@@ -465,7 +478,10 @@
 {
   dereference =3D true;
   xstat =3D stat;
-  no_leaf_check =3D true;
+#ifdef FLASK_LINUX
+  x_sec_stat =3D stat_secure;
+#endif /* FLASK_LINUX */
+   no_leaf_check =3D true;
   return (true);
 }
=20
@@ -570,6 +586,10 @@
       -nouser -nogroup -path PATTERN -perm [+-]MODE -regex PATTERN\n\
       -size N[bckw] -true -type [bcdpfls] -uid N -used N -user NAME\n\
       -xtype [bcdpfls]\n"));
+#ifdef FLASK_LINUX
+  puts (_("\
+      -sid SID -scontext SCONTEXT\n"));
+#endif /*FLASK_LINUX*/
   puts (_("\
 actions: -exec COMMAND ; -fprint FILE -fprint0 FILE -fprintf FILE FORMAT=
\n\
       -ok COMMAND ; -print -print0 -printf FORMAT -prune -ls\n"));
@@ -1205,6 +1225,114 @@
 {
   return insert_type (argv, arg_ptr, pred_xtype);
 }
+
+#ifdef FLASK_LINUX
+
+static boolean
+parse_sid ( argv, arg_ptr )
+     char *argv[];
+     int *arg_ptr;
+{
+  struct predicate *our_pred;
+  char *ep, *ctxt;
+  security_id_t sid;
+  int ctxtlen =3D 256;
+
+  if ( (argv =3D=3D NULL) || (argv[*arg_ptr] =3D=3D NULL) )
+    return ( false );
+
+  our_pred =3D insert_primary(pred_sid);
+  our_pred->need_stat =3D false;
+#ifdef DEBUG
+  our_pred->p_name =3D find_pred_name (pred_sid);
+#endif /*DEBUG*/
+
+  /* check for typos */
+
+  sid =3D (security_id_t) strtol(argv[*arg_ptr], &ep, 10);
+  if ( *ep ) {
+    (void) fprintf(stderr, "non-numeric SID '%s'\n", argv[*arg_ptr]);
+    (void) fflush(stderr);
+    return( false );
+  }
+
+  /* sanity check the SID value */
+
+  ctxt =3D calloc(1, ctxtlen+1);
+  if ( ctxt !=3D NULL ) {
+    if ( security_sid_to_context(sid, ctxt, &ctxtlen) ) {
+      if ( errno !=3D ENOSPC ) {
+      (void) fprintf(stderr, "security_sid_to_context(%d): '%s'\n",
+                     (int) sid, strerror(errno));
+      (void) fflush(stderr);
+      free(ctxt);
+      return( false );
+      }
+      free(ctxt);
+      ctxt =3D calloc(1, ctxtlen+1);
+      if ( ctxt !=3D NULL ) {
+      if ( security_sid_to_context(sid, ctxt, &ctxtlen) ) {
+        (void) fprintf(stderr, "security_sid_to_context(%d): %s\n",
+                       (int) sid, strerror(errno));
+        (void) fflush(stderr);
+        free(ctxt);
+        return( false );
+      }
+      else {
+        our_pred->args.scontext =3D calloc(1, strlen(ctxt)+1);
+        (void) strcpy(our_pred->args.scontext, ctxt);
+      }
+      }
+    }
+    else {
+      our_pred->args.scontext =3D calloc(1, strlen(ctxt)+1);
+      (void) strcpy(our_pred->args.scontext, ctxt);
+    }
+
+    free(ctxt);
+  }
+
+  our_pred->args.sid =3D sid;
+
+  (*arg_ptr)++;
+  return( true );
+}
+
+
+static boolean
+parse_scontext ( argv, arg_ptr )
+     char *argv[];
+     int *arg_ptr;
+{
+  struct predicate *our_pred;
+  char *ctxt;
+  security_id_t sid;
+
+  if ( (argv =3D=3D NULL) || (argv[*arg_ptr] =3D=3D NULL) )
+    return( false );
+
+  our_pred =3D insert_primary(pred_scontext);
+  our_pred->need_stat =3D false;
+#ifdef DEBUG
+  our_pred->p_name =3D find_pred_name (pred_scontext);
+#endif /*DEBUG*/
+
+  ctxt =3D argv[*arg_ptr];
+  if ( security_context_to_sid(ctxt, strlen(ctxt)+1, &sid) ) {
+    (void) fprintf(stderr, "security_context_to_sid(%s): %s\n",
+                 ctxt, strerror(errno));
+    (void) fflush(stderr);
+    return( false );
+  }
+
+  our_pred->args.scontext =3D argv[*arg_ptr];;
+  our_pred->args.sid      =3D sid;
+
+  (*arg_ptr)++;
+  return( true );
+}
+
+#endif /*FLASK_LINUX*/
 =0C
 static boolean
 insert_type (char **argv, int *arg_ptr, boolean (*which_pred) (/* ??? */=
))
@@ -1358,7 +1486,11 @@
 	  if (*scan2 =3D=3D '.')
 	    for (scan2++; ISDIGIT (*scan2); scan2++)
 	      /* Do nothing. */ ;
-	  if (strchr ("abcdfFgGhHiklmnpPstuU", *scan2))
+#ifdef FLASK_LINUX
+        if (strchr ("abcdfFgGhHiklmnpPstuUCS", *scan2))
+#else  /* FLASK_LINUX */
+        if (strchr ("abcdfFgGhHiklmnpPstuU", *scan2))
+#endif /* FLASK_LINUX */
 	    {
 	      segmentp =3D make_segment (segmentp, format, scan2 - format,
 				       (int) *scan2);
diff -Nur findutils-4.1.7/find/pred.c findutils-4.1.7-lsm/find/pred.c
--- findutils-4.1.7/find/pred.c	Sun May 20 13:39:37 2001
+++ findutils-4.1.7-lsm/find/pred.c	Sat Dec  8 20:35:32 2001
@@ -27,6 +27,14 @@
 #include "modetype.h"
 #include "wait.h"
=20
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#endif /*FLASK_LINUX*/
+
+#ifndef FNM_CASEFOLD
+#define FNM_CASEFOLD (1<<4)
+#endif  /*FNM_CASEFOLD*/
+
 #if ENABLE_NLS
 # include <libintl.h>
 # define _(Text) gettext (Text)
@@ -68,6 +76,9 @@
 #endif
=20
 extern int yesno ();
+#ifdef FLASK_LINUX
+static boolean get_sid ( );
+#endif /*FLASK_LINUX*/
=20
=20
 /* Get or fake the disk device blocksize.
@@ -196,6 +207,10 @@
   {pred_used, "used    "},
   {pred_user, "user    "},
   {pred_xtype, "xtype   "},
+#ifdef FLASK_LINUX
+  {pred_sid,      "sid     "},
+  {pred_scontext, "scontext"},
+#endif /*FLASK_LINUX*/
   {0, "none    "}
 };
=20
@@ -719,6 +734,70 @@
 	  fprintf (fp, segment->text,
 		   human_readable ((uintmax_t) stat_buf->st_uid, hbuf, 1, 1));
 	  break;
+#ifdef FLASK_LINUX
+      case 'C':               /* Flask security context */
+      case 'S':               /* Flask SID */
+        {
+          security_id_t sid;
+          int rv;
+          struct stat st;
+
+          rv =3D (*x_sec_stat)(rel_pathname, &st, &sid);
+
+          if ( rv < 0 ) {
+            (void) fprintf(stderr, "stat_secure(%s): %s",
+                           pathname, strerror(errno));
+            (void) fflush(stderr);
+          }
+          else {
+            if ( segment->kind =3D=3D 'S' ) {
+             segment->text[segment->text_len] =3D 'd';
+              (void) fprintf (fp, segment->text, sid);
+            }
+            else /* segment->kind =3D=3D 'C' */ {
+              char *ctxt;
+              int len =3D 255;
+
+              ctxt =3D calloc(1, len+1);
+              if ( ctxt !=3D NULL ) {
+               rv =3D security_sid_to_context(sid, ctxt, &len);
+                if ( rv < 0 ) {
+                  if ( errno =3D=3D ENOSPC ) { /* make buffer bigger */
+                    free(ctxt);
+                    ctxt =3D calloc(1, len+1);
+                    if ( ctxt ) {
+                      rv =3D security_sid_to_context(sid, ctxt, &len);
+                      if ( rv < 0 ) { /* should not happen */
+                        (void) fprintf(stderr, "security_sid_to_context(=
%d): %s",
+                                       (int) sid, strerror(errno));
+                        (void) fflush(stderr);
+                      }
+                      else {
+                        segment->text[segment->text_len] =3D 's';
+                        (void) fprintf (fp, segment->text, ctxt);
+                      }
+                    }
+                  }
+                  else {
+                    (void) fprintf(stderr, "security_sid_to_context(%d):=
 %s",
+                                   (int) sid, strerror(errno));
+                    (void) fflush(stderr);
+                  }
+                }
+                else {
+                  segment->text[segment->text_len] =3D 's';
+                  (void) fprintf (fp, segment->text, ctxt);
+                }
+              }
+              else {
+                (void) fprintf(stderr, "calloc(): %s\n", strerror(errno)=
);
+                (void) fflush(stderr);
+              }
+            }
+          }
+        }
+        break ;
+#endif /* FLASK_LINUX */
 	}
     }
   return (true);
@@ -1221,6 +1300,69 @@
   return (pred_type (pathname, &sbuf, pred_ptr));
 }
 =0C
+
+#ifdef FLASK_LINUX
+
+boolean
+pred_sid ( pathname, stat_buf, pred_ptr )
+     char *pathname;
+     struct stat *stat_buf;
+     struct predicate *pred_ptr;
+{
+  int rv;
+  struct stat st;
+  security_id_t sid;
+
+  rv =3D (* x_sec_stat)(rel_pathname, &st, &sid);
+
+  if ( rv < 0 ) {
+    (void) fprintf(stderr, "stat_secure(%s): %s\n", pathname, strerror(e=
rrno));
+    (void) fflush(stderr);
+    return ( false );
+  }
+  if ( sid =3D=3D pred_ptr->args.sid )
+    return( true );
+
+  return( false );
+}
+
+
+boolean
+pred_scontext ( pathname, stat_buf, pred_ptr )
+     char *pathname;
+     struct stat *stat_buf;
+     struct predicate *pred_ptr;
+{
+  int rv;
+  struct stat st;
+  security_id_t sid;
+
+  rv =3D (* x_sec_stat)(rel_pathname, &st, &sid);
+
+  if ( rv < 0 ) {
+    (void) fprintf(stderr, "stat_secure(%s): %s\n", pathname, strerror(e=
rrno));
+    (void) fflush(stderr);
+    return ( false );
+  }
+
+
+  /* From sds@tislabs 7/14/00:
+     Using the SID instead of the context string lets us handle aliases.=

+     Doing a string comparison between contexts loses if the user gave a=
n
+     alias on the command line instead of the canonical form for the
+     context.  We got a SID mapping for the user-supplied context during=

+     command-line parsing, though, and we make use of it.
+  */
+
+  if ( sid =3D=3D pred_ptr->args.sid )
+    return ( true );
+
+  return( false );
+}
+
+#endif /*FLASK_LINUX*/
+
+
 /*  1) fork to get a child; parent remembers the child pid
     2) child execs the command requested
     3) parent waits for child; checks for proper pid of child

--=_homegate.savages.net-23968-1007964898-0001-2
Content-Type: text/plain; name="fu-src-Makefile.am"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fu-src-Makefile.am"

## Process this file with automake to produce Makefile.in -*-Makefile-*-
AUTOMAKE_OPTIONS = ansi2knr

EXTRA_PROGRAMS = df

bin_PROGRAMS = chgrp chown chmod chcon cp dd dircolors du \
ginstall ln dir vdir ls mkdir \
mkfifo mknod mv rm rmdir shred sync touch @DF_PROG@

datadir = $(prefix)/@DATADIRNAME@
localedir = $(datadir)/locale

noinst_HEADERS = \
  system.h sys2.h copy.h cp-hash.h ls.h dircolors.h remove.h \
  chown-core.h
EXTRA_DIST = dcgen dircolors.hin

INCLUDES = -I.. -I$(srcdir) -I$(top_srcdir)/lib -I../intl
DEFS = -DLOCALEDIR=\"$(localedir)\" -DSHAREDIR=\"$(datadir)\" @DEFS@
LDADD = @INTLLIBS@ ../lib/libfetish.a

dir_LDADD = $(LDADD) -ltermcap
ls_LDADD = $(LDADD) -ltermcap
shred_LDADD = $(LDADD) @LIB_CLOCK_GETTIME@
vdir_LDADD = $(LDADD) -ltermcap

$(bin_PROGRAMS) $(libexec_PROGRAMS): ../lib/libfetish.a

# Use `ginstall' in the definition of PROGRAMS and in dependencies to avoid
# confusion with the `install' target.  The install rule transforms `ginstall'
# to install before applying any user-specified name transformations.

transform = s/ginstall/install/; @program_transform_name@
ginstall_SOURCES = install.c copy.c cp-hash.c

cp_SOURCES = cp.c copy.c cp-hash.c
dir_SOURCES = ls.c ls-dir.c
vdir_SOURCES = ls.c ls-vdir.c
ls_SOURCES = ls.c ls-ls.c
chown_SOURCES = chown.c chown-core.c
chgrp_SOURCES = chgrp.c chown-core.c

mv_SOURCES = mv.c copy.c cp-hash.c remove.c
rm_SOURCES = rm.c remove.c

BUILT_SOURCES = dircolors.h
PERL = @PERL@
editpl = sed -e 's,@''PERL''@,$(PERL),g'

MAINTAINERCLEANFILES = dircolors.h

dircolors.h: dcgen dircolors.hin
	$(PERL) -w -- $(srcdir)/dcgen $(srcdir)/dircolors.hin > $@-t
	mv $@-t $@

--=_homegate.savages.net-23968-1007964898-0001-2
Content-Type: text/plain; name="stat-2.5-selinux.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stat-2.5-selinux.patch"

diff -Nur stat-2.5/Makefile stat-2.5-lsm/Makefile
--- stat-2.5/Makefile	Sun Dec  9 20:20:46 2001
+++ stat-2.5-lsm/Makefile	Sun Dec  9 20:19:25 2001
@@ -1,11 +1,17 @@
 # This is the Makefile for stat
 
-CFLAGS=$(RPM_OPT_FLAGS) -D_FILE_OFFSET_BITS=64
+CDEFS=-DFLASK_LINUX -D_FILE_OFFSET_BITS=64
+INCLUDE=-I/usr/local/selinux/include
+CFLAGS=$(RPM_OPT_FLAGS) $(CDEFS) $(INCLUDE)
 CC=gcc
 DESTDIR=$(RPM_BUILD_ROOT)
+SECLIB=-L/usr/local/selinux/lib -lsecure
 
 all: stat
 
+stat: stat.o
+	${CC} -o $@ $< ${CFLAGS} ${SECLIB}
+
 install:
 	mkdir -p ${DESTDIR}/usr/bin
 	install -s -m 755 stat ${DESTDIR}/usr/bin
diff -Nur stat-2.5/stat.1 stat-2.5-lsm/stat.1
--- stat-2.5/stat.1	Thu May 10 06:11:54 2001
+++ stat-2.5-lsm/stat.1	Sun Dec  9 20:19:39 2001
@@ -68,6 +68,8 @@
 
 Group ID (and name if available) of owner
 
+SID Security ID
+
 Device type (if inode device)
 
 Total size, in bytes
diff -Nur stat-2.5/stat.c stat-2.5-lsm/stat.c
--- stat-2.5/stat.c	Sun Dec  9 20:20:46 2001
+++ stat-2.5-lsm/stat.c	Sun Dec  9 20:19:55 2001
@@ -6,6 +6,9 @@
 #include <unistd.h>
 #include <time.h>
 #include <sys/vfs.h>
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#endif /*FLASK_LINUX*/
 
 #include "fs.h"
 
@@ -133,12 +136,19 @@
 void do_stat(char *filename, int link, int terse)
 {
     struct stat statbuf;
-    int i = (link == 1) ? stat(filename, &statbuf) : lstat(filename, &statbuf);
+    int i;
     char access[10];
     struct passwd *pw_ent;
     struct group *gw_ent;
     char linkname[256];
+#ifdef FLASK_LINUX
+    security_id_t sid;
 
+    i = (link == 1) ? stat_secure(filename,&statbuf,&sid) :
+        lstat_secure(filename,&statbuf,&sid);
+#else /*!FLASK_LINUX*/
+    i = (link == 1) ? stat(filename, &statbuf) : lstat(filename, &statbuf);
+#endif /*FLASK_LINUX*/
     if (i == -1) {
 	perror(filename);
 	return;
@@ -203,6 +213,20 @@
 	(void) printf("Unknown\n");
     }
 
+#ifdef FLASK_LINUX
+      {
+        char sbuf[256];
+        int rv;
+        unsigned int sbuflen = sizeof(sbuf);
+
+        rv = security_sid_to_context(sid, (security_context_t *) &sbuf, &sbuflen);
+        if ( rv < 0 )
+          (void) sprintf(sbuf, "<error finding security context>", sid);
+
+        (void) printf("  SID: %d    S_context: %s\n", sid, sbuf);
+      }
+#endif /*FLASK_LINUX*/
+
     printf("Device: %xh/%dd\tInode: %-10d  Links: %-5d", (int)statbuf.st_dev, (int)statbuf.st_dev,
     	 (int)statbuf.st_ino, (int)statbuf.st_nlink);
 

--=_homegate.savages.net-23968-1007964898-0001-2
Content-Type: text/plain; name="tar-1.13.19-selinux.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tar-1.13.19-selinux.patch"

diff -Nur tar-1.13.19/acconfig.h tar-1.13.19-selinux/acconfig.h
--- tar-1.13.19/acconfig.h	Mon Oct 23 23:18:37 2000
+++ tar-1.13.19-selinux/acconfig.h	Sat Dec  8 22:38:36 2001
@@ -13,3 +13,7 @@
 
 /* Define to `int' if <sys/types.h> doesn't define.  */
 #undef ssize_t
+
+/* Define to 1 if we want to compile as security (flask) aware */
+#undef FLASK_LINUX
+
diff -Nur tar-1.13.19/aclocal.m4 tar-1.13.19-selinux/aclocal.m4
--- tar-1.13.19/aclocal.m4	Fri Jan 12 23:59:54 2001
+++ tar-1.13.19-selinux/aclocal.m4	Sat Dec  8 22:39:24 2001
@@ -1,6 +1,6 @@
-dnl aclocal.m4 generated automatically by aclocal 1.4
+dnl aclocal.m4 generated automatically by aclocal 1.4-p5
 
-dnl Copyright (C) 1994, 1995-8, 1999 Free Software Foundation, Inc.
+dnl Copyright (C) 1994, 1995-8, 1999, 2001 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -235,7 +235,7 @@
 ac_cv_func_fnmatch_works=yes, ac_cv_func_fnmatch_works=no,
 ac_cv_func_fnmatch_works=no)])
 if test $ac_cv_func_fnmatch_works = yes; then
-  AC_DEFINE(HAVE_FNMATCH)
+  AC_DEFINE(HAVE_FNMATCH, 1, [Define if you have a working fnmatch function])
 fi
 ])
 #serial 3
@@ -694,58 +694,6 @@
      AC_DEFINE_UNQUOTED([$1], [$]$3, [$4])
    fi])
 
-AC_DEFUN(AC_SYS_LARGEFILE,
-  [AC_REQUIRE([AC_PROG_CC])
-   AC_ARG_ENABLE(largefile,
-     [  --disable-largefile     omit support for large files])
-   if test "$enable_largefile" != no; then
-
-     AC_CACHE_CHECK([for special C compiler options needed for large files],
-       ac_cv_sys_largefile_CC,
-       [ac_cv_sys_largefile_CC=no
-        if test "$GCC" != yes; then
-	  # IRIX 6.2 and later do not support large files by default,
-	  # so use the C compiler's -n32 option if that helps.
-	  AC_TRY_COMPILE(AC_SYS_LARGEFILE_TEST_INCLUDES, , ,
-	    [ac_save_CC="$CC"
-	     CC="$CC -n32"
-	     AC_TRY_COMPILE(AC_SYS_LARGEFILE_TEST_INCLUDES, ,
-	       ac_cv_sys_largefile_CC=' -n32')
-	     CC="$ac_save_CC"])
-        fi])
-     if test "$ac_cv_sys_largefile_CC" != no; then
-       CC="$CC$ac_cv_sys_largefile_CC"
-     fi
-
-     AC_SYS_LARGEFILE_MACRO_VALUE(_FILE_OFFSET_BITS, 64,
-       ac_cv_sys_file_offset_bits,
-       [Number of bits in a file offset, on hosts where this is settable.],
-       AC_SYS_LARGEFILE_TEST_INCLUDES)
-     AC_SYS_LARGEFILE_MACRO_VALUE(_LARGE_FILES, 1,
-       ac_cv_sys_large_files,
-       [Define for large files, on AIX-style hosts.],
-       AC_SYS_LARGEFILE_TEST_INCLUDES)
-   fi
-  ])
-
-AC_DEFUN(AC_FUNC_FSEEKO,
-  [AC_SYS_LARGEFILE_MACRO_VALUE(_LARGEFILE_SOURCE, 1,
-     ac_cv_sys_largefile_source,
-     [Define to make fseeko visible on some hosts (e.g. glibc 2.2).],
-     [#include <stdio.h>], [return !fseeko;])
-   # We used to try defining _XOPEN_SOURCE=500 too, to work around a bug
-   # in glibc 2.1.3, but that breaks too many other things.
-   # If you want fseeko and ftello with glibc, upgrade to a fixed glibc.
-
-   AC_CACHE_CHECK([for fseeko], ac_cv_func_fseeko,
-     [ac_cv_func_fseeko=no
-      AC_TRY_LINK([#include <stdio.h>],
-        [return fseeko && fseeko (stdin, 0, 0);],
-	[ac_cv_func_fseeko=yes])])
-   if test $ac_cv_func_fseeko != no; then
-     AC_DEFINE(HAVE_FSEEKO, 1,
-       [Define if fseeko (and presumably ftello) exists and is declared.])
-   fi])
 # Check whether LC_MESSAGES is available in <locale.h>.
 # Ulrich Drepper <drepper@cygnus.com>, 1995.
 #
@@ -1434,7 +1382,7 @@
 
 # serial 1
 
-AC_DEFUN(AM_C_PROTOTYPES,
+AC_DEFUN([AM_C_PROTOTYPES],
 [AC_REQUIRE([AM_PROG_CC_STDC])
 AC_REQUIRE([AC_PROG_CPP])
 AC_MSG_CHECKING([for function prototypes])
@@ -1455,7 +1403,7 @@
 
 # Like AC_CONFIG_HEADER, but automatically create stamp file.
 
-AC_DEFUN(AM_CONFIG_HEADER,
+AC_DEFUN([AM_CONFIG_HEADER],
 [AC_PREREQ([2.12])
 AC_CONFIG_HEADER([$1])
 dnl When config.status generates a header, we must update the stamp-h file.
@@ -1485,7 +1433,7 @@
 dnl Usage:
 dnl AM_INIT_AUTOMAKE(package,version, [no-define])
 
-AC_DEFUN(AM_INIT_AUTOMAKE,
+AC_DEFUN([AM_INIT_AUTOMAKE],
 [AC_REQUIRE([AC_PROG_INSTALL])
 PACKAGE=[$1]
 AC_SUBST(PACKAGE)
@@ -1513,7 +1461,7 @@
 # Check to make sure that the build environment is sane.
 #
 
-AC_DEFUN(AM_SANITY_CHECK,
+AC_DEFUN([AM_SANITY_CHECK],
 [AC_MSG_CHECKING([whether build environment is sane])
 # Just in case
 sleep 1
@@ -1554,7 +1502,7 @@
 
 dnl AM_MISSING_PROG(NAME, PROGRAM, DIRECTORY)
 dnl The program must properly implement --version.
-AC_DEFUN(AM_MISSING_PROG,
+AC_DEFUN([AM_MISSING_PROG],
 [AC_MSG_CHECKING(for working $2)
 # Run test in a subshell; some versions of sh will print an error if
 # an executable is not found, even if stderr is redirected.
diff -Nur tar-1.13.19/configure.in tar-1.13.19-selinux/configure.in
--- tar-1.13.19/configure.in	Sat Dec  8 22:36:07 2001
+++ tar-1.13.19-selinux/configure.in	Sat Dec  8 22:39:48 2001
@@ -24,6 +24,14 @@
   [Define unconditionally for setting a GNU environment.])
 ALL_LINGUAS="cs da de es et fr it ja ko nl no pl pt pt_BR ru sl sv"
 
+AC_ARG_WITH(selinux,
+[  --with-selinux            include support for SELinux],
+[  AC_DEFINE(FLASK_LINUX)
+   CFLAGS="$CFLAGS -DFLASK_LINUX -I/usr/local/selinux/include"
+   LIBS="$LIBS -L/usr/local/selinux/lib -lsecure"])
+
+#  AC_ARG_PROGRAM
+
 AC_PROG_CC
 AC_PROG_GCC_TRADITIONAL
 AC_AIX
diff -Nur tar-1.13.19/src/buffer.c tar-1.13.19-selinux/src/buffer.c
--- tar-1.13.19/src/buffer.c	Fri Jan 12 21:59:29 2001
+++ tar-1.13.19-selinux/src/buffer.c	Sat Dec  8 22:41:18 2001
@@ -197,13 +197,18 @@
 void
 set_next_block_after (union block *block)
 {
+  /*
+  printf("Checkpoint 4! current_block: %d\n", (int) current_block);
+  */
   while (block >= current_block)
     current_block++;
 
   /* Do *not* flush the archive here.  If we do, the same argument to
      set_next_block_after could mean the next block (if the input record
      is exactly one block long), which is not what is intended.  */
-
+  /*
+  printf("Checkpoint 5! current_block: %d\n", (int) current_block);
+  */
   if (current_block > record_end)
     abort ();
 }
@@ -659,6 +664,9 @@
 
   current_file_name = 0;
   current_link_name = 0;
+#ifdef FLASK_LINUX
+  current_context = 0;
+#endif /*FLASK_LINUX*/
   save_name = 0;
   real_s_name = 0;
 
diff -Nur tar-1.13.19/src/create.c tar-1.13.19-selinux/src/create.c
--- tar-1.13.19/src/create.c	Fri Jan 12 21:59:29 2001
+++ tar-1.13.19-selinux/src/create.c	Sat Dec  8 22:41:35 2001
@@ -18,6 +18,15 @@
 
 #include "system.h"
 
+#if FLASK_LINUX
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <fs_secure.h>
+#endif
+
+
 #if !MSDOS
 # include <pwd.h>
 # include <grp.h>
@@ -357,6 +366,119 @@
 
 static union block *start_header PARAMS ((const char *, struct stat *));
 
+#ifdef FLASK_LINUX
+
+/*
+ * get_scontext(pathname): return security context for pathname, NULL on error
+ */
+
+char *get_scontext ( char *path )
+{
+  int rv;
+  security_id_t sid;
+  struct stat st;
+  static char buf[CONTEXT_SIZE];
+  unsigned int len = sizeof(buf);
+
+
+  rv = lstat_secure(path, &st, &sid);
+  if ( rv < 0 ) {
+    WARN((0,0, _("Unable to get SID of %s"), path));
+    return( (char *) NULL );
+  }
+
+  bzero(buf, 256);
+
+  rv = security_sid_to_context(sid, buf, &len);
+  if ( rv ) {
+    WARN((0,0, _("Unable to get context for SID %d (associated with %s)"), sid, path));
+    return( (char *) NULL );
+  }
+
+  return( buf );
+}
+
+
+/*
+ * get_sid(pathname): return SID for pathname, -1 on error
+ */
+
+
+security_id_t get_sid ( char *path )
+{
+  int rv;
+  security_id_t sid;
+  struct stat st;
+
+  rv = lstat_secure(path, &st, &sid);
+  if ( rv < 0 ) {
+    WARN((0,0, _("Unable to get SID of %s"), path));
+  }
+
+  return( sid );
+}
+
+
+/*-----------------------------------------------------.
+| Write a CONTEXT block.                               |
+`-----------------------------------------------------*/
+
+static void
+write_contexts (const char *p)
+{
+  int size;
+  int bufsize;
+  union block *header;
+  struct stat foo;
+
+  char *context;
+
+
+  context = get_scontext (p);
+
+  if(context==NULL) {
+    WARN((0,0, _("Unable to get context for %s, context will not be recorded in archive"), p));
+    return;
+  }
+
+  size=strlen (context) +1;
+
+
+  memset (&foo, 0, sizeof foo);
+  foo.st_size = size;
+
+  /* I feel dirty doing this, but it seems the simplest way to
+     prevent recursion with start_header */
+
+  include_contexts_option = 0;
+  header = start_header ("././@Context", &foo);
+  include_contexts_option = 1;
+
+  /* There's gotta be a better way to do that... */
+
+
+  header->header.typeflag = FLASK_CONTEXT;
+  finish_header (header);
+
+  header = find_next_block ();
+
+  bufsize = available_space_after (header);
+
+  while (bufsize < size)
+    {
+      memcpy (header->buffer, context, (size_t) bufsize);
+      context += bufsize;
+      size -= bufsize;
+      set_next_block_after (header + (bufsize - 1) / BLOCKSIZE);
+      header = find_next_block ();
+      bufsize = available_space_after (header);
+    }
+  memcpy (header->buffer, context, (size_t) size);
+  memset (header->buffer + size, 0, (size_t) (bufsize - size));
+  set_next_block_after (header + (size - 1) / BLOCKSIZE);
+}
+#endif /*FLASK_LINUX*/
+
 static void
 write_long (const char *p, char type)
 {
@@ -368,7 +490,25 @@
   memset (&foo, 0, sizeof foo);
   foo.st_size = size;
 
+#ifdef FLASK_LINUX
+  
+  /* Again, there's got to be a better way to prevent 
+     write_contexts to be called on "././@LongLink" than this */
+  if(include_contexts_option == 1) {
+    include_contexts_option = 0;
+    header = start_header ("././@LongLink", &foo);
+    include_contexts_option = 1;
+    }
+  else {
+        header = start_header ("././@LongLink", &foo);
+  }
+
+#else
+
   header = start_header ("././@LongLink", &foo);
+
+#endif
+
   header->header.typeflag = type;
   finish_header (header);
 
@@ -396,6 +536,16 @@
 static char const *
 relativize (char const *name)
 {
+
+#ifdef FLASK_LINUX
+
+  /* Do this here, before name gets munged below. */
+
+  if(include_contexts_option)
+    write_contexts (name);
+
+#endif
+
   if (! absolute_names_option)
     {
       {
@@ -568,7 +718,11 @@
 
   if (verbose_option
       && header->header.typeflag != GNUTYPE_LONGLINK
-      && header->header.typeflag != GNUTYPE_LONGNAME)
+      && header->header.typeflag != GNUTYPE_LONGNAME
+#ifdef FLASK_LINUX
+      && header->header.typeflag != FLASK_CONTEXT
+#endif
+)
     {
       /* These globals are parameters to print_header, sigh.  */
 
@@ -1472,6 +1626,15 @@
 	  if (linklen != current_stat.st_size || linklen + 1 == 0)
 	    xalloc_die ();
 	  buffer = (char *) alloca (linklen + 1);
+
+#ifdef FLASK_LINUX
+
+      /* Is this the right place? */
+      if(include_contexts_option)
+      write_contexts(p);
+
+#endif
+
 	  size = readlink (p, buffer, linklen + 1);
 	  if (size < 0)
 	    {
diff -Nur tar-1.13.19/src/extract.c tar-1.13.19-selinux/src/extract.c
--- tar-1.13.19/src/extract.c	Sat Dec  8 22:36:07 2001
+++ tar-1.13.19-selinux/src/extract.c	Sat Dec  8 22:41:49 2001
@@ -30,6 +30,9 @@
 #endif
 
 #include "common.h"
+#ifdef FLASK_LINUX
+# include <fs_secure.h>
+#endif
 
 int we_are_root;		/* true if our effective uid == 0 */
 static mode_t newdir_umask;	/* umask when creating new directories */
@@ -506,6 +509,40 @@
     }
 }
 
+#ifdef FLASK_LINUX
+
+void chcontext ( char *path, char *scontext )
+{
+  int rv;
+  security_id_t new_sid, old_sid;
+  struct stat st;
+
+  rv = lstat_secure(path, &st, &old_sid);
+
+  if ( rv < 0 ) {
+    WARN((0, 0, _("Unable to get old SID for %s, will not be able to change its context"), path));
+    return;
+  }
+
+  rv = security_context_to_sid(scontext, strlen(scontext)+1, &new_sid);
+  if ( rv ){
+    WARN((0, 0, _("Unable to get SID for context %s, probably an invalid context for this system"), scontext));
+    return;
+  }
+
+  if ( old_sid != new_sid ) {
+    rv = lchsid(path, new_sid);
+    if ( rv < 0 ) {
+      WARN((0, 0, _("Unable to change %s to context %s, perhaps permission denied?"), path, scontext));
+      return;
+    }
+  }
+
+  return;
+}
+
+#endif /*FLASK_LINUX*/
+
 /* Fix the statuses of all directories whose statuses need fixing, and
    which are not ancestors of FILE_NAME.  */
 static void
@@ -1119,6 +1156,15 @@
 	undo_last_backup ();
       break;
 
+#ifdef FLASK_LINUX
+    case FLASK_CONTEXT:
+      ERROR ((0, 0, _("Visible context error")));
+      skip_file ((long) current_stat.st_size);
+      if (backup_option)
+      undo_last_backup ();
+      break;
+#endif
+
     default:
       WARN ((0, 0,
 	     _("%s: Unknown file type '%c', extracted as normal file"),
@@ -1126,6 +1172,16 @@
       goto again_file;
     }
 
+#ifdef FLASK_LINUX
+  if(preserve_contexts_option) {
+    if (current_context) {
+      chcontext( current_file_name, current_context);
+      free(current_context);
+      current_context=NULL;
+    }
+  }
+#endif
+
 #undef CURRENT_FILE_NAME
 }
 
diff -Nur tar-1.13.19/src/list.c tar-1.13.19-selinux/src/list.c
--- tar-1.13.19/src/list.c	Fri Jan 12 21:59:29 2001
+++ tar-1.13.19-selinux/src/list.c	Sat Dec  8 22:42:31 2001
@@ -69,6 +69,10 @@
 
   while (1)
     {
+
+      //      printf("Checkpoint 11\n");
+      // fflush(stdout);
+
       prev_status = status;
       status = read_header ();
       switch (status)
@@ -108,7 +112,18 @@
 		}
 	      }
 
+	  /*  
+	      printf("Entering do_something\n");
+	      fflush(stdout);	  
+	  */
+
 	  (*do_something) ();
+
+	  /*
+	  printf("returned from do_something\n");
+	  fflush(stdout);
+	  */
+
 	  continue;
 
 	case HEADER_ZERO_BLOCK:
@@ -264,12 +279,21 @@
   size_t size, written;
   static char *next_long_name, *next_long_link;
 
+#ifdef FLASK_LINUX
+  static char *next_context=NULL;
+#endif
+
   while (1)
     {
       header = find_next_block ();
       current_header = header;
       if (!header)
 	return HEADER_END_OF_FILE;
+      /*
+	printf("Checkpoint 2, current header type is %c\n", header->header.typeflag);
+	printf("Checkpoint 2, current header name %s\n", header->header.name);
+	fflush(stdout);
+      */
 
       unsigned_sum = 0;
       signed_sum = 0;
@@ -312,6 +336,56 @@
       else
 	current_stat.st_size = OFF_FROM_HEADER (header->header.size);
 
+#ifdef FLASK_LINUX
+
+      /* if the header is of the context type, get the context and put
+       it in current_context */
+      /*
+      printf("Checkpoint 1, current header type is %c\n", header->header.typeflag);
+      printf("Checkpoint 1, current header name %s\n", header->header.name);
+      printf("Checkpoint 1, current_stat.st_size is %d\n", current_stat.st_size);
+      fflush(stdout);
+      */
+
+      if (header->header.typeflag == FLASK_CONTEXT) {
+
+      longp = &current_context;
+
+              set_next_block_after (header);
+
+      if (*longp)
+        {
+          free (*longp);
+        }
+
+      bp = *longp = (char *) xmalloc ((size_t) current_stat.st_size);
+
+      for (size = current_stat.st_size; size > 0; size -= written)
+        {
+          data_block = find_next_block ();
+          if (data_block == NULL)
+            {
+              ERROR ((0, 0, _("Unexpected EOF on archive file")));
+              break;
+            }
+          written = available_space_after (data_block);
+          if (written > size)
+            written = size;
+
+          memcpy (bp, data_block->buffer, (size_t) written);
+          bp += written;
+          /*
+          printf("Checkpoint 3. next_context is: %s\n", next_context);
+          fflush(stdout);
+          */
+          set_next_block_after ((union block *)
+                                (data_block->buffer + written - 1));
+        }
+
+      return (read_header());
+      }
+#endif
+
       if (header->header.typeflag == GNUTYPE_LONGNAME
 	  || header->header.typeflag == GNUTYPE_LONGLINK)
 	{
@@ -817,6 +891,21 @@
     }
 #endif
 
+#ifdef FLASK_LINUX
+      if(show_contexts_option) {
+	if (current_context) {
+	  fprintf(stdlis, " %s", current_context);
+	  free(current_context);
+	  current_context = NULL;
+	}
+	else {
+	  fprintf(stdlis, " (no context)");
+	}
+      }
+#endif
+
+
+
   /* The time stamp cannot be broken down, most likely because it
      is out of range.  Convert it as an integer,
      right-adjusted in a field with the same width as the usual
diff -Nur tar-1.13.19/src/tar.c tar-1.13.19-selinux/src/tar.c
--- tar-1.13.19/src/tar.c	Sat Dec  8 22:36:07 2001
+++ tar-1.13.19-selinux/src/tar.c	Sat Dec  8 22:42:49 2001
@@ -139,6 +139,14 @@
   USE_COMPRESS_PROGRAM_OPTION,
   VOLNO_FILE_OPTION,
 
+/* In keeping with this system, I'm adding a few for the FLASK security
+   (context) options */
+#ifdef FLASK_LINUX
+   INCLUDE_CONTEXTS_OPTION,
+   PRESERVE_CONTEXTS_OPTION,
+   SHOW_CONTEXTS_OPTION,
+#endif
+
   /* Some cleanup is being made in GNU tar long options.  Using old names is
      allowed for a while, but will also send a warning to stderr.  Take old
      names out in 1.14, or in summer 1997, whichever happens last.  */
@@ -152,6 +160,10 @@
   OBSOLETE_VERSION_CONTROL
 };
 
+
+
+
+
 /* If nonzero, display usage information and exit.  */
 static int show_help;
 
@@ -194,6 +206,9 @@
   {"gunzip", no_argument, 0, 'z'},
   {"gzip", no_argument, 0, 'z'},
   {"help", no_argument, &show_help, 1},
+#ifdef FLASK_LINUX
+  {"include-contexts", no_argument, NULL, INCLUDE_CONTEXTS_OPTION},
+#endif
   {"ignore-failed-read", no_argument, &ignore_failed_read_option, 1},
   {"ignore-zeros", no_argument, 0, 'i'},
   /* FIXME: --ignore-end as a new name for --ignore-zeros?  */
@@ -222,6 +237,9 @@
   {"portability", no_argument, 0, 'o'},
   {"posix", no_argument, 0, POSIX_OPTION},
   {"preserve", no_argument, 0, PRESERVE_OPTION},
+#ifdef FLASK_LINUX
+  {"preserve-contexts", no_argument, NULL, PRESERVE_CONTEXTS_OPTION},
+#endif
   {"preserve-order", no_argument, 0, 's'},
   {"preserve-permissions", no_argument, 0, 'p'},
   {"recursive-unlink", no_argument, &recursive_unlink_option, 1},
@@ -235,6 +253,9 @@
   {"same-order", no_argument, 0, 's'},
   {"same-owner", no_argument, &same_owner_option, 1},
   {"same-permissions", no_argument, 0, 'p'},
+#ifdef FLASK_LINUX
+  {"show-contexts", no_argument, NULL, SHOW_CONTEXTS_OPTION},
+#endif
   {"show-omitted-dirs", no_argument, &show_omitted_dirs_option, 1},
   {"sparse", no_argument, 0, 'S'},
   {"starting-file", required_argument, 0, 'K'},
@@ -266,6 +287,8 @@
 	     program_name);
   else
     {
+
+#ifdef FLASK_LINUX
       fputs (_("\
 GNU `tar' saves many files together into a single tape or disk archive, and\n\
 can restore individual files from the archive.\n"),
@@ -322,6 +345,8 @@
       --same-owner             try extracting files with the same ownership\n\
       --no-same-owner          extract files as yourself\n\
       --numeric-owner          always use numbers for user/group names\n\
+      --include-contexts       save security contexts in archive\n\
+      --preserve-contexts      use security contexts in archive (if any)\n\
   -p, --same-permissions       extract permissions information\n\
       --no-same-permissions    do not extract permissions information\n\
       --preserve-permissions   same as -p\n\
@@ -393,6 +418,151 @@
       --help            print this help, then exit\n\
       --version         print tar program version number, then exit\n\
   -v, --verbose         verbosely list files processed\n\
+      --show-contexts   add security contexts to verbose output\n\
+      --checkpoint      print directory names while reading the archive\n\
+      --totals          print total bytes written while creating archive\n\
+  -R, --block-number    show block number within archive with each message\n\
+  -w, --interactive     ask for confirmation for every action\n\
+      --confirmation    same as -w\n"),
+	     stdout);
+      fputs (_("\
+\n\
+The backup suffix is `~', unless set with --suffix or SIMPLE_BACKUP_SUFFIX.\n\
+The version control may be set with --backup or VERSION_CONTROL, values are:\n\
+\n\
+  t, numbered     make numbered backups\n\
+  nil, existing   numbered if numbered backups exist, simple otherwise\n\
+  never, simple   always make simple backups\n"),
+	     stdout);
+      printf (_("\
+\n\
+GNU tar cannot read nor produce `--posix' archives.  If POSIXLY_CORRECT\n\
+is set in the environment, GNU extensions are disallowed with `--posix'.\n\
+Support for POSIX is only partially implemented, don't count on it yet.\n\
+ARCHIVE may be FILE, HOST:FILE or USER@HOST:FILE; and FILE may be a file\n\
+or a device.  *This* `tar' defaults to `-f%s -b%d'.\n"),
+	      DEFAULT_ARCHIVE, DEFAULT_BLOCKING);
+      fputs (_("\
+\n\
+Report bugs to <tar-bugs@gnu.ai.mit.edu>.\n"),
+	       stdout);
+#else
+      fputs (_("\
+GNU `tar' saves many files together into a single tape or disk archive, and\n\
+can restore individual files from the archive.\n"),
+	     stdout);
+      printf (_("\nUsage: %s [OPTION]... [FILE]...\n"), program_name);
+      fputs (_("\
+\n\
+If a long option shows an argument as mandatory, then it is mandatory\n\
+for the equivalent short option also.  Similarly for optional arguments.\n"),
+	     stdout);
+      fputs(_("\
+\n\
+Main operation mode:\n\
+  -t, --list              list the contents of an archive\n\
+  -x, --extract, --get    extract files from an archive\n\
+  -c, --create            create a new archive\n\
+  -d, --diff, --compare   find differences between archive and file system\n\
+  -r, --append            append files to the end of an archive\n\
+  -u, --update            only append files newer than copy in archive\n\
+  -A, --catenate          append tar files to an archive\n\
+      --concatenate       same as -A\n\
+      --delete            delete from the archive (not on mag tapes!)\n"),
+	    stdout);
+      fputs (_("\
+\n\
+Operation modifiers:\n\
+  -W, --verify               attempt to verify the archive after writing it\n\
+      --remove-files         remove files after adding them to the archive\n\
+  -k, --keep-old-files       don't overwrite existing files when extracting\n\
+  -U, --unlink-first         remove each file prior to extracting over it\n\
+      --recursive-unlink     empty hierarchies prior to extracting directory\n\
+  -S, --sparse               handle sparse files efficiently\n\
+  -O, --to-stdout            extract files to standard output\n\
+  -G, --incremental          handle old GNU-format incremental backup\n\
+  -g, --listed-incremental   handle new GNU-format incremental backup\n\
+      --ignore-failed-read   do not exit with nonzero on unreadable files\n"),
+	     stdout);
+      fputs (_("\
+\n\
+Handling of file attributes:\n\
+      --owner=NAME             force NAME as owner for added files\n\
+      --group=NAME             force NAME as group for added files\n\
+      --mode=CHANGES           force (symbolic) mode CHANGES for added files\n\
+      --atime-preserve         don't change access times on dumped files\n\
+  -m, --modification-time      don't extract file modified time\n\
+      --same-owner             try extracting files with the same ownership\n\
+      --numeric-owner          always use numbers for user/group names\n\
+  -P, --same-permissions       extract all protection information\n\
+      --preserve-permissions   same as -p\n\
+  -s, --same-order             sort names to extract to match archive\n\
+      --preserve-order         same as -s\n\
+      --preserve               same as both -p and -s\n"),
+	     stdout);
+      fputs (_("\
+\n\
+Device selection and switching:\n\
+  -f, --file=ARCHIVE             use archive file or device ARCHIVE\n\
+      --force-local              archive file is local even if has a colon\n\
+      --rsh-command=COMMAND      use remote COMMAND instead of rsh\n\
+  -[0-7][lmh]                    specify drive and density\n\
+  -M, --multi-volume             create/list/extract multi-volume archive\n\
+  -L, --tape-length=NUM          change tape after writing NUM x 1024 bytes\n\
+  -F, --info-script=FILE         run script at end of each tape (implies -M)\n\
+      --new-volume-script=FILE   same as -F FILE\n\
+      --volno-file=FILE          use/update the volume number in FILE\n"),
+	     stdout);
+      fputs (_("\
+\n\
+Device blocking:\n\
+  -b, --blocking-factor=BLOCKS   BLOCKS x 512 bytes per record\n\
+      --record-size=SIZE         SIZE bytes per record, multiple of 512\n\
+  -i, --ignore-zeros             ignore zeroed blocks in archive (means EOF)\n\
+  -B, --read-full-records        reblock as we read (for 4.2BSD pipes)\n"),
+	     stdout);
+      fputs (_("\
+\n\
+Archive format selection:\n\
+  -V, --label=NAME                   create archive with volume name NAME\n\
+              PATTERN                at list/extract time, a globbing PATTERN\n\
+  -o, --old-archive, --portability   write a V7 format archive\n\
+      --posix                        write a POSIX conformant archive\n\
+  -z, --gzip, --ungzip               filter the archive through gzip\n\
+  -Z, --compress, --uncompress       filter the archive through compress\n\
+      --use-compress-program=PROG    filter through PROG (must accept -d)\n"),
+	     stdout);
+      fputs (_("\
+\n\
+Local file selection:\n\
+  -C, --directory=DIR          change to directory DIR\n\
+  -T, --files-from=NAME        get names to extract or create from file NAME\n\
+      --null                   -T reads null-terminated names, disable -C\n\
+      --exclude=PATTERN        exclude files, given as a globbing PATTERN\n\
+  -X, --exclude-from=FILE      exclude globbing patterns listed in FILE\n\
+  -P, --absolute-names         don't strip leading `/'s from file names\n\
+  -h, --dereference            dump instead the files symlinks point to\n\
+      --no-recursion           avoid descending automatically in directories\n\
+  -l, --one-file-system        stay in local file system when creating archive\n\
+  -K, --starting-file=NAME     begin at file NAME in the archive\n"),
+	     stdout);
+#if !MSDOS
+      fputs (_("\
+  -N, --newer=DATE             only store files newer than DATE\n\
+      --newer-mtime            compare date and time when data changed only\n\
+      --after-date=DATE        same as -N\n"),
+	     stdout);
+#endif
+      fputs (_("\
+      --backup[=CONTROL]       backup before removal, choose version control\n\
+      --suffix=SUFFIX          backup before removel, override usual suffix\n"),
+	     stdout);
+      fputs (_("\
+\n\
+Informative output:\n\
+      --help            print this help, then exit\n\
+      --version         print tar program version number, then exit\n\
+  -v, --verbose         verbosely list files processed\n\
       --checkpoint      print directory names while reading the archive\n\
       --totals          print total bytes written while creating archive\n\
   -R, --block-number    show block number within archive with each message\n\
@@ -417,6 +587,7 @@
 or a device.  *This* `tar' defaults to `-f%s -b%d'.\n"),
 	      DEFAULT_ARCHIVE, DEFAULT_BLOCKING);
       fputs (_("\nReport bugs to <bug-tar@gnu.org>.\n"), stdout);
+#endif /*FLASK_LINUX*/
     }
   exit (status);
 }
@@ -969,6 +1140,21 @@
 	volno_file_option = optarg;
 	break;
 
+#ifdef FLASK_LINUX
+      case INCLUDE_CONTEXTS_OPTION:
+	include_contexts_option = 1;
+	break;
+
+      case PRESERVE_CONTEXTS_OPTION:
+	preserve_contexts_option = 1;
+	break;
+
+      case SHOW_CONTEXTS_OPTION:
+	show_contexts_option = 1;
+	break;
+
+#endif
+
       case USE_COMPRESS_PROGRAM_OPTION:
 	set_use_compress_program_option (optarg);
 	break;
diff -Nur tar-1.13.19/src/tar.h tar-1.13.19-selinux/src/tar.h
--- tar-1.13.19/src/tar.h	Mon Oct 23 23:18:37 2000
+++ tar-1.13.19-selinux/src/tar.h	Sat Dec  8 22:42:54 2001
@@ -209,6 +209,9 @@
 /* This file is a tape/volume header.  Ignore it on extraction.  */
 #define GNUTYPE_VOLHDR 'V'
 
+/* For storing the flask security context of the NEXT file */
+#define FLASK_CONTEXT 'C'
+
 /* tar Header Block, overall structure.  */
 
 /* tar files are made in basic blocks of this size.  */

--=_homegate.savages.net-23968-1007964898-0001-2--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
