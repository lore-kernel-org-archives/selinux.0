Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5S6Sb0S017652
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 02:28:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5S6Sa5e020999
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 06:28:36 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h5S6SZ92020996 for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 06:28:35 GMT
Subject: improvements to chcon.c
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-sgTVxfbHvukb9IwK9ZEA"
Message-Id: <1056781690.14920.81.camel@columbia>
Mime-Version: 1.0
Date: 28 Jun 2003 02:28:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-sgTVxfbHvukb9IwK9ZEA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I found that I almost always just wanted to change one component of a
security contenxt, not the whole thing.  For example, I wanted to
recursively change the user of /var/www/verbum.org to "walters", while
keeping the varied types such as httpd_user_content_t,
httpd_user_script_exec_t, etc. 

However chcon didn't really give me an easy way to do this. 

With the attached patch, I can just say:
chcon -R -h -u walters /var/www/verbum.org

This is my first attempt at programming using the SELinux API, so please
review the changes carefully.  This patch is against the woody patch to
coreutils.


--=-sgTVxfbHvukb9IwK9ZEA
Content-Disposition: attachment; filename=coreutils-chcon.patch
Content-Type: text/plain; name=coreutils-chcon.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- coreutils-4.5.4/src/chcon.c	Sat Jun 28 02:16:05 2003
+++ coreutils-4.5.4.hacked/src/chcon.c	Sat Jun 28 02:12:00 2003
@@ -6,6 +6,7 @@
 #include <grp.h>
 #include <getopt.h>
 #include <fs_secure.h>
+#include <get_user_sid.h>
=20
 #include "system.h"
 #include "error.h"
@@ -31,8 +32,7 @@
   V_off
 };
=20
-static int change_dir_context PARAMS ((const char *dir, int sid,
-				       const struct stat *statp));
+static int change_dir_context PARAMS ((const char *dir, const struct stat =
*statp));
=20
 /* The name the program was run with. */
 char *program_name;
@@ -50,8 +50,14 @@
 /* Level of verbosity.  */
 static enum Verbosity verbosity =3D V_off;
=20
-/* The name of the context the file is being given. */
-static const char *contextname;
+/* The SID given. */
+static int specified_sid =3D -1;
+
+/* The security context components the file is being given. */
+static char *specified_user;
+static char *specified_role;
+static char *specified_type;
+static char *specified_level;
=20
 /* The argument to the --reference option.  Use the context SID of this fi=
le.
    This file must exist.  */
@@ -72,47 +78,144 @@
   {"quiet", no_argument, 0, 'f'},
   {"reference", required_argument, 0, CHAR_MAX + 1},
   {"sid", required_argument, 0, CHAR_MAX + 2},
+  {"user", required_argument, 0, 'u'},
+  {"role", required_argument, 0, 'r'},     =20
+  {"type", required_argument, 0, 't'},
+  {"level", required_argument, 0, 'l'},   =20
   {"verbose", no_argument, 0, 'v'},
   {"help", no_argument, &show_help, 1},
   {"version", no_argument, &show_version, 1},
   {0, 0, 0, 0}
 };
=20
+/* Hacked up utility function stolen from utils/newrole.c in SELinux,
+   see that file for docs. */
+int sid_to_dynamic_context(security_id_t sid,=20
+			   security_context_t *scontextp,
+			   __u32 *lenp)
+{
+  security_context_t scontext;
+  int len;               =20
+
+  len =3D 256;  /* Initial guess. */
+  scontext =3D xmalloc (len);
+
+  if (security_sid_to_context (sid, scontext, &len))
+    {
+      scontext =3D xrealloc (scontext, len);
+     =20
+      if (security_sid_to_context (sid, scontext, &len))
+	return -1;
+    }
+ =20
+  *scontextp =3D scontext;
+  *lenp =3D len;
+  return 0;
+}
+
 /* Tell the user how/if the context of FILE has been changed.
    CHANGED describes what (if anything) has happened. */
-
 static void
-describe_change (const char *file, enum Change_status changed)
+describe_change (const char *file, security_id_t newsid, enum Change_statu=
s changed)
 {
-  const char *fmt;
+  char *context =3D NULL;
+  size_t len;
+  if (specified_sid < 0)
+    if (sid_to_dynamic_context (newsid, &context, &len) < 0)
+      {
+	error (0, 0, "couldn't convert sid %d to context", newsid);
+      return;
+      }
+
   switch (changed)
     {
     case CH_SUCCEEDED:
-      fmt =3D _("context of %s changed to %s\n");
+      if (specified_sid >=3D 0)
+	printf (_("sid of %s changed to %d\n"), file, specified_sid);
+      else
+	printf (_("context of %s changed to %s\n"), file, context);=09
       break;
     case CH_FAILED:
-      fmt =3D _("failed to change context of %s to %s\n");
+      if (specified_sid >=3D 0)
+	printf (_("failed to change sid of %s to %d\n"), file, specified_sid);
+      else
+	printf (_("failed to change context of %s to %s\n"), file, context);=09
       break;
     case CH_NO_CHANGE_REQUESTED:
-      fmt =3D _("context of %s retained as %s\n");
+      printf (_("context of %s retained as %s\n"), file, context);
       break;
     default:
       abort ();
     }
-  printf (fmt, file, contextname);
+  free (context);
+}
+
+static int
+compute_sid_from_mask (const char *file, security_id_t file_sid,
+		       security_id_t *new_sid)
+{
+  char *file_user =3D NULL, *file_role =3D NULL, *file_type =3D NULL, *fil=
e_level =3D NULL;
+  size_t len;
+  security_context_t file_context;
+  security_context_t new_context;
+
+  if (sid_to_dynamic_context (file_sid, &file_context, &len) < 0)
+	goto lose_errno;
+  if (!security_context_to_parts (file_context,
+				  &file_user, &file_role, &file_type, &file_level))
+    goto lose_unknown;
+ =20
+  if (specified_user)
+    {
+      free (file_user);
+      file_user =3D specified_user;
+    }
+  if (specified_role)
+    {
+      free (file_role);
+      file_role =3D specified_role;
+    }
+  if (specified_type)
+    {
+      free (file_type);
+      file_type =3D specified_type;
+    }
+  if (specified_level)
+    {
+      if (file_level) free (file_level);
+      file_level =3D specified_level;
+    }
+ =20
+  if (parts_to_security_context (file_user, file_role, file_type,
+				  file_level, &new_context) !=3D 1)
+    goto lose_unknown;
+  if (security_context_to_sid (new_context, strlen (new_context) + 1, new_=
sid) < 0)
+    goto lose_errno;
+  free (file_context); =20
+  free (new_context);
+  return 0;
+ lose_errno:
+  if (force_silent =3D=3D 0)
+    {
+      error (0, errno, "%s", file);
+    }
+ lose_unknown:
+  return 1;
 }
=20
-/* Change the context of FILE to SID CONTEXT.
+/* Change the context of FILE using globally
+   specified values.
    If it is a directory and -R is given, recurse.
    Return 0 if successful, 1 if errors occurred. */
=20
 static int
-change_file_context (const char *file, int sid)
+change_file_context (const char *file)
 {
-  struct stat file_stats;
   security_id_t file_sid;
+  struct stat file_stats;
+  security_id_t new_sid;
   int errors =3D 0;
-
+ =20
   if (lstat_secure (file, &file_stats, &file_sid))
     {
       if (force_silent =3D=3D 0)
@@ -120,35 +223,34 @@
       return 1;
     }
=20
-  if (sid !=3D file_sid)
+  if (specified_sid < 0)
+    {
+      if (compute_sid_from_mask (file, file_sid, &new_sid) !=3D 0)
+	{
+	  return 1;
+	}
+    }
+  else
+    new_sid =3D specified_sid;
+ =20
+  if (new_sid !=3D file_sid)
     {
       int fail;
-
       if (change_symlinks)
-      	fail =3D lchsid (file, sid);
+	fail =3D lchsid (file, new_sid);
       else
-      	fail =3D chsid (file, sid);
-
+	fail =3D chsid (file, new_sid);
+     =20
       if (verbosity =3D=3D V_high || (verbosity =3D=3D V_changes_only && !=
fail))
-	describe_change (file, (fail ? CH_FAILED : CH_SUCCEEDED));
-
-      if (fail)
-	{
-	  errors =3D 1;
-	  if (force_silent =3D=3D 0)
-	    {
-	      error (0, errno, "%s", file);
-	    }
-	}
+	describe_change (file, new_sid, (fail ? CH_FAILED : CH_SUCCEEDED));
     }
   else if (verbosity =3D=3D V_high)
     {
-      describe_change (file, CH_NO_CHANGE_REQUESTED);
+      describe_change (file, new_sid, CH_NO_CHANGE_REQUESTED);
     }
-
+ =20
   if (recurse && S_ISDIR (file_stats.st_mode))
-    errors |=3D change_dir_context (file, sid, &file_stats);
-
+    errors |=3D change_dir_context (file, &file_stats);
   return errors;
 }
=20
@@ -158,7 +260,7 @@
    Return 0 if successful, 1 if errors occurred. */
=20
 static int
-change_dir_context (const char *dir, int sid, const struct stat *statp)
+change_dir_context (const char *dir, const struct stat *statp)
 {
   char *name_space, *namep;
   char *path;			/* Full path of each entry to process. */
@@ -197,7 +299,7 @@
 	  path =3D xrealloc (path, pathlength);
 	}
       strcpy (path + dirlength, namep);
-      errors |=3D change_file_context (path, sid);
+      errors |=3D change_file_context (path);
     }
   free (path);
   free (name_space);
@@ -214,10 +316,11 @@
     {
       printf (_("\
 Usage: %s [OPTION]... CONTEXT FILE...\n\
+  or:  %s [OPTION]... [-u USER] [-t TYPE] [-r ROLE] [-l LEVEL] FILE...\n\
   or:  %s [OPTION]... --reference=3DRFILE FILE...\n\
   or:  %s [OPTION]... --sid=3DSID FILE...\n\
 "),
-	program_name, program_name, program_name);
+	program_name, program_name, program_name, program_name);
       printf (_("\
 Change the security context of each FILE to CONTEXT.\n\
 \n\
@@ -227,6 +330,10 @@
   -f, --silent, --quiet  suppress most error messages\n\
       --reference=3DRFILE  use RFILE's group instead of using a CONTEXT va=
lue\n\
       --sid=3DSID          use context corresponding to SID for CONTEXT va=
lue\n\
+  -u, --user=3DUSER        set user USER in the target security context\n\
+  -r, --role=3DROLE        set role ROLE in the target security context\n\
+  -t, --type=3DTYPE        set type TYPE in the target security context\n\
+  -l, --level=3DLEVEL      set level LEVEL in the target security context\=
n\
   -R, --recursive        change files and directories recursively\n\
   -v, --verbose          output a diagnostic for every file processed\n\
       --help             display this help and exit\n\
@@ -240,7 +347,6 @@
 int
 main (int argc, char **argv)
 {
-  int sid =3D -1;
   int errors =3D 0;
   int optc;
  =20
@@ -251,21 +357,33 @@
=20
   recurse =3D force_silent =3D 0;
  =20
-  while ((optc =3D getopt_long (argc, argv, "Rcfhv", long_options, NULL)) =
!=3D -1)
+  while ((optc =3D getopt_long (argc, argv, "Rcfhvu:r:t:l:", long_options,=
 NULL)) !=3D -1)
   {
 	  switch (optc)
 	  {
 	  case 0:
 		  break;
+	  case 'u':
+		  specified_user =3D optarg;
+		  break;
+	  case 'r':
+		  specified_role =3D optarg;
+		  break;
+	  case 't':
+		  specified_type =3D optarg;
+		  break;
+	  case 'l':
+		  specified_level =3D optarg;
+		  break;
 	  case CHAR_MAX + 1:
 		  reference_file =3D optarg;
 		  break;
 	  case CHAR_MAX +2:
-	          sid =3D (int)strtol( optarg, (char **)NULL, 10);
+	          specified_sid =3D (int)strtol( optarg, (char **)NULL, 10);
 		  /* We use an int to represent sids so we can use -1 for *
 		   * an error condition.  All valid sids are positive.    *
 		   * Check for an invalid sid.                            */
-                  if( ( errno =3D=3D ERANGE ) || ( sid <=3D 0 ) ) { =20
+                  if( ( errno =3D=3D ERANGE ) || ( specified_sid <=3D 0 ) =
) { =20
 		    error( 1, 0, _("invalid sid"));
 		  }
 	          break;
@@ -298,12 +416,26 @@
=20
   if (show_help)
     usage (0);
+ =20
+  if ((reference_file && (specified_sid > 0
+			  || specified_user || specified_role
+			  || specified_type || specified_level))
+      || (specified_sid > 0
+	  && (specified_user || specified_role
+	      || specified_type || specified_level)))
+    {
+      error (0, 0, _("conflicting security context specifiers given"));
+      usage (1);
+    }
=20
-  if (argc - optind + ( (reference_file || ( sid > 0 ) ) ? 1 : 0) <=3D 1)
-  {
-     error (0, 0, _("too few arguments"));
-     usage (1);
-  }
+  if (!(((reference_file || specified_sid > 0
+	  || specified_user || specified_role || specified_type || specified_leve=
l)
+	 && (argc - optind > 0))
+	|| (argc - optind > 1)))
+    {
+      error (0, 0, _("too few arguments"));
+      usage (1);
+    }
  =20
   if (reference_file)
     {
@@ -312,22 +444,28 @@
       if (stat_secure (reference_file, &ref_stats, &ref_sid))
 	error (1, errno, "%s", reference_file);
=20
-      sid =3D ref_sid;
+      specified_sid =3D ref_sid;
     }
-  else if( sid <=3D 0 )  /* sid > 0 means sid already set by --sid above *=
/
+ /* specified_sid > 0 means sid already set by --sid above */ =20
+  else if(specified_sid <=3D 0 && !(specified_user || specified_role
+				  || specified_type || specified_level))
    {
-     contextname =3D argv[optind++];
+     char *specified_context =3D argv[optind++];
=20
-     if (*contextname =3D=3D '\0')
+     if (*specified_context =3D=3D '\0')
        error (1, 0, _("can not change to null context"));
=20
-     if (security_context_to_sid (contextname, strlen (contextname) + 1, &=
sid))
-       error (1, errno, "%s", contextname);
+  if (!security_context_to_parts (specified_context, &specified_user, &spe=
cified_role, &specified_type,
+				  &specified_level))
+    {
+      error (1, 0, _("couldn't parse context %s"), specified_context);
+      goto exit;
+    }
    }
=20
   for (; optind < argc; ++optind)
-     errors |=3D change_file_context (argv[optind], sid);
-
+     errors |=3D change_file_context (argv[optind]);
+ exit:
   if (verbosity !=3D V_off)
     close_stdout ();
   exit (errors);

--=-sgTVxfbHvukb9IwK9ZEA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
