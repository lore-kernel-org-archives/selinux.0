Subject: Re: make install fails if any users are in local.users
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Colin Walters <walters@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <1110983044.3914.24.camel@nexus.verbum.private>
References: <1110672353.29153.2.camel@cobra.ivg2.net>
	 <4235BE2F.8020009@redhat.com> <1110821742.16850.14.camel@cobra.ivg2.net>
	 <42360347.1030105@redhat.com>  <1110838214.19525.1.camel@cobra.ivg2.net>
	 <1110864047.30167.8.camel@cobra.ivg2.net>
	 <1110979208.4802.45.camel@moss-spartans.epoch.ncsc.mil>
	 <1110983044.3914.24.camel@nexus.verbum.private>
Content-Type: multipart/mixed; boundary="=-RFH2R56a0hmyKCZrFeaD"
Date: Wed, 16 Mar 2005 10:23:53 -0500
Message-Id: <1110986633.4802.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-RFH2R56a0hmyKCZrFeaD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-03-16 at 09:24 -0500, Colin Walters wrote:
> On Wed, 2005-03-16 at 08:20 -0500, Stephen Smalley wrote:
> > One question is whether setfiles -c
> > should only validate the base file_contexts configuration (which no
> > longer contains the home directory entries at all). 
> 
> I don't see a good alternative, really.  The home directory stuff is
> entirely dynamic and outside policy build.

Ok, then the attached patches for libselinux and policycoreutils should
disable processing of file_contexts.local and file_contexts.homedirs by
setfiles -c.

> Perhaps though genhomedircon itself could run setfiles -c though on e.g.
> file_contexts.homedir.tmp before renaming it to file_contexts.homedir.

Yes, that is a good idea, and even with the attached patches, it should
be possible to explicitly pass file_contexts.homedir.tmp to setfiles -c,
so I'd encourage Dan to make that change to genhomedircon.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

--=-RFH2R56a0hmyKCZrFeaD
Content-Disposition: attachment; filename=libselinux-matchpathcon.patch
Content-Type: text/x-patch; name=libselinux-matchpathcon.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/ChangeLog,v
retrieving revision 1.115
diff -u -p -r1.115 ChangeLog
--- libselinux/ChangeLog	8 Mar 2005 16:34:48 -0000	1.115
+++ libselinux/ChangeLog	16 Mar 2005 14:52:21 -0000
@@ -1,3 +1,11 @@
+1.23.1 2005-03-16
+	* Added set_matchpathcon_flags() function for setting flags
+	  controlling operation of matchpathcon.  MATCHPATHCON_BASEONLY
+	  means only process the base file_contexts file, not 
+	  file_contexts.homedirs or file_contexts.local, and is for use by
+	  setfiles -c.
+	* Updated matchpathcon.3 man page.
+
 1.22 2005-03-09
 	* Updated version for release.
 
Index: libselinux/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/VERSION,v
retrieving revision 1.35
diff -u -p -r1.35 VERSION
--- libselinux/VERSION	7 Mar 2005 15:18:18 -0000	1.35
+++ libselinux/VERSION	16 Mar 2005 14:24:32 -0000
@@ -1 +1 @@
-1.22
+1.23.1
Index: libselinux/libselinux.spec
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/libselinux.spec,v
retrieving revision 1.52
diff -u -p -r1.52 libselinux.spec
--- libselinux/libselinux.spec	7 Mar 2005 15:18:18 -0000	1.52
+++ libselinux/libselinux.spec	16 Mar 2005 14:24:29 -0000
@@ -1,6 +1,6 @@
 Summary: SELinux library and simple utilities
 Name: libselinux
-Version: 1.22
+Version: 1.23.1
 Release: 1
 License: Public domain (uncopyrighted)
 Group: System Environment/Libraries
Index: libselinux/include/selinux/selinux.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/selinux.h,v
retrieving revision 1.36
diff -u -p -r1.36 selinux.h
--- libselinux/include/selinux/selinux.h	17 Feb 2005 15:21:04 -0000	1.36
+++ libselinux/include/selinux/selinux.h	16 Mar 2005 14:49:17 -0000
@@ -196,12 +196,18 @@ extern void set_matchpathcon_invalidcon(
 						 unsigned lineno, 
 						 char *context));
 
+/* Set flags controlling operation of matchpathcon_init or matchpathcon. */
+#define MATCHPATHCON_BASEONLY 1 /* Only process the base file_contexts file. */
+extern void set_matchpathcon_flags(unsigned int flags);
+
 /* Load the file contexts configuration specified by 'path'
    into memory for use by subsequent matchpathcon calls.  
    If 'path' is NULL, then load the active file contexts configuration,
    i.e. the path returned by selinux_file_context_path().
-   Also checks for a 'path'.local file and loads additional 
-   specifications from it if present. */
+   Unless the MATCHPATHCON_BASEONLY flag has been set, this
+   function also checks for a 'path'.homedirs file and 
+   a 'path'.local file and loads additional specifications 
+   from them if present. */
 extern int matchpathcon_init(const char *path);
 
 /* Match the specified pathname and mode against the file contexts
Index: libselinux/man/man3/matchpathcon.3
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/man/man3/matchpathcon.3,v
retrieving revision 1.2
diff -u -p -r1.2 matchpathcon.3
--- libselinux/man/man3/matchpathcon.3	30 Nov 2004 20:30:37 -0000	1.2
+++ libselinux/man/man3/matchpathcon.3	16 Mar 2005 15:07:51 -0000
@@ -1,26 +1,107 @@
-.TH "matchpathcon" "3" "1 August 2004" "dwalsh@redhat.com" "SE Linux API documentation"
+.TH "matchpathcon" "3" "16 March 2005" "sds@tycho.nsa.gov" "SE Linux API documentation"
 .SH "NAME"
-matchpathcon \- get the default security context for the specified file from the policy.
+matchpathcon \- get the default security context for the specified path from the file contexts configuration.
 
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
+.BI "int matchpathcon_init(const char *" path ");"
+.br
 .BI "int matchpathcon(const char *" path ", mode_t " mode ", security_context_t *" con);
+.sp
 .br 
-.BI "void set_matchpathcon_printf(void (*f)(const char *fmt, ...));"
-
-.SH "DESCRIPTION"
+.BI "void set_matchpathcon_printf(void (*" f ")(const char *" fmt ", ...));"
+.br
+.BI "void set_matchpathcon_invalidcon(int (*" f ")(const char *"path ", unsigned " lineno ", char * " context "));"
 .br
+.BI "void set_matchpathcon_flags(unsigned int " flags ");"
+.br
+.SH "DESCRIPTION"
+.B matchpathcon_init
+loads the file contexts configuration specified by
+.I path
+into memory for use by subsequent 
 .B matchpathcon 
-matches the specified pathname and mode against the file contexts configuration and sets the security context "con" to refer to the resulting context. "mode" can be 0 to disable mode matching, but should be provided whenever possible, as it may affect the matching.
-.B Note: 
-   Caller must free returned security context "con" using freecon.
-
+calls.  If
+.I path
+is NULL, then the active file contexts configuration is loaded by default,
+i.e. the path returned by 
+.B selinux_file_context_path(3).
+Unless the 
+.B MATCHPATHCON_BASEONLY 
+flag has been set via 
+.B set_matchpathcon_flags,
+files with the same path prefix but a 
+.B .homedirs
+and
+.B .local
+suffix are also looked up and loaded if present.  These files provide
+dynamically generated entries for user home directories and for local
+customizations.
+.br 
+.sp
+.B matchpathcon 
+matches the specified pathname and mode against the file contexts
+configuration and sets the security context 
+.I con 
+to refer to the
+resulting context. The caller must free the returned security context 
+.I con
+using freecon when finished using it.
+.I mode
+can be 0 to disable mode matching, but
+should be provided whenever possible, as it may affect the matching.
+Only the file format bits (i.e. the file type) of the 
+.I mode 
+are used.
+If 
+.B matchpathcon_init
+has not already been called, then this function will call it upon
+its first invocation with a NULL
+.I path,
+defaulting to the active file contexts configuration.
+.sp
+.br
 .B set_matchpathcon_printf
-
-Set the function used by matchpathcon when displaying errors about the file_contexts configuration.  If not set, then this defaults to fprintf(stderr, fmt, ...).
+sets the function used by 
+.B matchpathcon_init
+when displaying errors about the file contexts configuration.  If not set, 
+then this defaults to fprintf(stderr, fmt, ...).  This can be set to redirect
+error reporting to a different destination.
+.br
+.sp
+.B set_matchpathcon_invalidcon
+sets the function used by 
+.B matchpathcon_init
+when checking the validity of a context in the file contexts
+configuration.  If not set, then this defaults to a test based 
+on 
+.B security_check_context(3),
+which checks validity against the active policy on a SELinux system.
+This can be set to instead perform checking based on a binary policy file,
+e.g. using 
+.B sepol_check_context(3),
+as is done by 
+.B setfiles -c.
+The function is also responsible for reporting any such error, and
+may include the 
+.I path
+and
+.I lineno
+in such error messages.
+.br
 .sp
+.B set_matchpathcon_flags
+sets flags controlling the operation of 
+.B matchpathcon_init
+or
+.B matchpathcon.
+If the 
+.B MATCHPATHCON_BASEONLY
+flag is set, then only the base file contexts configuration file
+will be processed, not any dynamically generated entries or local customizations.
 .br
+.sp
 .SH "RETURN VALUE"
 Returns 0 on success or -1 otherwise.
 
Index: libselinux/src/matchpathcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/matchpathcon.c,v
retrieving revision 1.22
diff -u -p -r1.22 matchpathcon.c
--- libselinux/src/matchpathcon.c	8 Mar 2005 16:34:49 -0000	1.22
+++ libselinux/src/matchpathcon.c	16 Mar 2005 14:31:41 -0000
@@ -48,6 +48,13 @@ void set_matchpathcon_invalidcon(int (*f
 	myinvalidcon = f;
 }
 
+static unsigned int myflags;
+
+void set_matchpathcon_flags(unsigned int flags)
+{
+	myflags = flags;
+}
+
 /*
  * A file security context specification.
  */
@@ -517,8 +524,8 @@ static int process_line( const char *pat
 int matchpathcon_init(const char *path)
 {
 	FILE *fp;
-	FILE *localfp;
-	FILE *homedirfp;
+	FILE *localfp = NULL;
+	FILE *homedirfp = NULL;
 	char local_path[PATH_MAX + 1];
 	char homedir_path[PATH_MAX + 1];
 	char *line_buf = NULL;
@@ -534,15 +541,17 @@ int matchpathcon_init(const char *path)
 		return -1;
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 
-	snprintf(homedir_path, sizeof(homedir_path), "%s.homedirs", path);
-	homedirfp = fopen(homedir_path, "r");
-	if (homedirfp != NULL)
-		__fsetlocking(homedirfp, FSETLOCKING_BYCALLER);
-
-	snprintf(local_path, sizeof(local_path), "%s.local", path);
-	localfp = fopen(local_path, "r");
-	if (localfp != NULL)
-		__fsetlocking(localfp, FSETLOCKING_BYCALLER);
+	if ((myflags & MATCHPATHCON_BASEONLY) == 0) {
+		snprintf(homedir_path, sizeof(homedir_path), "%s.homedirs", path);
+		homedirfp = fopen(homedir_path, "r");
+		if (homedirfp != NULL)
+			__fsetlocking(homedirfp, FSETLOCKING_BYCALLER);
+
+		snprintf(local_path, sizeof(local_path), "%s.local", path);
+		localfp = fopen(local_path, "r");
+		if (localfp != NULL)
+			__fsetlocking(localfp, FSETLOCKING_BYCALLER);
+	}
 
 	/* 
 	 * Perform two passes over the specification file.

--=-RFH2R56a0hmyKCZrFeaD
Content-Disposition: attachment; filename=policycoreutils-setfiles.patch
Content-Type: text/x-patch; name=policycoreutils-setfiles.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/ChangeLog,v
retrieving revision 1.105
diff -u -p -r1.105 ChangeLog
--- policycoreutils/ChangeLog	14 Mar 2005 20:27:01 -0000	1.105
+++ policycoreutils/ChangeLog	16 Mar 2005 15:12:02 -0000
@@ -1,3 +1,7 @@
+1.23.2 2005-03-16
+	* Changed setfiles -c to call set_matchpathcon_flags(3) to
+	  turn off processing of .homedirs and .local.
+
 1.23.1 2005-03-14
 	* Merged rewrite of genhomedircon by Eric Paris.
 	* Changed fixfiles to relabel jfs since it now supports security xattrs
Index: policycoreutils/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/VERSION,v
retrieving revision 1.45
diff -u -p -r1.45 VERSION
--- policycoreutils/VERSION	14 Mar 2005 16:40:50 -0000	1.45
+++ policycoreutils/VERSION	16 Mar 2005 15:11:33 -0000
@@ -1 +1 @@
-1.23.1
+1.23.2
Index: policycoreutils/policycoreutils.spec
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/policycoreutils.spec,v
retrieving revision 1.68
diff -u -p -r1.68 policycoreutils.spec
--- policycoreutils/policycoreutils.spec	14 Mar 2005 16:40:50 -0000	1.68
+++ policycoreutils/policycoreutils.spec	16 Mar 2005 15:11:23 -0000
@@ -1,14 +1,14 @@
 Summary: SELinux policy core utilities.
 Name: policycoreutils
-Version: 1.23.1
+Version: 1.23.2
 Release: 1
 License: GPL
 Group: System Environment/Base
 Source: http://www.nsa.gov/selinux/archives/%{name}-%{version}.tgz
 
 Prefix: %{_prefix}
-BuildRequires: libselinux-devel >= 1.21.10 libsepol-devel >= 1.3.7
-Requires: libselinux >= 1.21.10 libsepol >= 1.3.7
+BuildRequires: libselinux-devel >= 1.23.1 libsepol-devel >= 1.3.7
+Requires: libselinux >= 1.23.1 libsepol >= 1.3.7
 
 BuildRoot: %{_tmppath}/%{name}-buildroot
 
Index: policycoreutils/setfiles/setfiles.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/setfiles/setfiles.c,v
retrieving revision 1.33
diff -u -p -r1.33 setfiles.c
--- policycoreutils/setfiles/setfiles.c	22 Feb 2005 16:07:58 -0000	1.33
+++ policycoreutils/setfiles/setfiles.c	16 Mar 2005 15:10:43 -0000
@@ -431,6 +431,10 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			fclose(policystream);
+
+			/* Only process the specified file_contexts file, not
+			   any .homedirs or .local files. */
+			set_matchpathcon_flags(MATCHPATHCON_BASEONLY);
 			
 			break;
 		}

--=-RFH2R56a0hmyKCZrFeaD--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
