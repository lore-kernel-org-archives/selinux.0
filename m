Message-ID: <41D1A19D.8000704@redhat.com>
Date: Tue, 28 Dec 2004 13:10:37 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Proposed change to install
References: <41D00FE7.2070203@redhat.com> <1104158005.15615.84.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1104158005.15615.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2004-12-27 at 08:36, Daniel J Walsh wrote:
>  
>
>>But with install, I believe 
>>matchpathcon is required.  So I am have modified the patch in coreutils 
>>to call matchpathcon and setfilecon.  This function currently will fail 
>>silently, leaving the current behavior.  Do you think this should report 
>>errors?
>>    
>>
>
>Likely not, if it is the default behavior, as the caller may not have
>permission to relabel files at all or to the particular context. 
>Definitely not for errno == EOPNOTSUPP, i.e. filesystems that do not
>support the security xattr.
>
>  
>
Ok not reporting errors when matchpathcon fails as this is expected to 
happen,  If lsetfilecon fails
and errno != ENOTSUP it will report a warning.
selinux_enabled call before this will prevent errors from non selinux 
machines.
Could add check to see if matchpathcon is failing for something other 
than EPERM, which maybe should be reported???

>>I am not sure what we should do with the "preserve_context" field.  Also 
>>it is questionable whether we should use setfscreatecon rather then 
>>setfilecon.
>>    
>>
>
>You don't want to call your new function if the -P or -Z options were
>specified, as your new function will clobber whatever context would have
>been preserved by -P or set by -Z.  We definitely want to be able to
>still use -P to explicitly request preservation of the original context
>or -Z to explicitly request a particular context for the installed file.
>
>  
>
Patch will now not run if these qualifiers are specified.

>Using setfscreatecon() prior to file creation would be preferable to
>avoid any window where the file will be in wrong context, but may be
>more difficult to integrate into install.
>
>I believe that you don't need to check scontext for NULL if
>matchpathcon() returns 0; matchpathcon() should never return 0 with a
>NULL scontext unless I am missing something.
>
>  
>
Removed NULL check

>On a different note, should matchpathcon() be doing something different
>in the <<none>> case rather than returning it to the caller, so that the
>caller doesn't have to hardcode a check for it?  Possibly return -1 with
>errno ENOENT as in the case where there is no matching entry in
>file_contexts?
>
>  
>
Sounds good, that way we don't need to check.

--- coreutils-5.2.1/src/install.c.selinux    2004-12-27 
08:25:32.000000000 -0500
+++ coreutils-5.2.1/src/install.c    2004-12-28 13:06:11.562504627 -0500
@@ -47,6 +47,43 @@
 # include <sys/wait.h>
 #endif
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>          /* for is_selinux_enabled() */
+int selinux_enabled=0;
+static int use_default_selinux_context = 1;
+/* Modify file context to match the specified policy, 
+   If an error occurs the file will remain with the default directory
+   context.*/
+static int setdefaultfilecon(const char *path) {
+    struct stat st;
+    security_context_t scontext=NULL;
+    if (selinux_enabled != 1) {
+        /* Indicate no context found. */
+        return 0;
+    }
+    if (lstat(path, &st) != 0)
+        return 0;
+
+    /* If there's an error determining the context, or it has none,
+       return 0 to allow default context */
+    if ((matchpathcon(path, st.st_mode, &scontext) != 0) ||
+        (strcmp(scontext, "<<none>>") == 0)) {
+        if (scontext != NULL) {
+            freecon(scontext);
+        }
+        return 0;
+    }
+    if (lsetfilecon(path, scontext) < 0) {
+        if (errno != ENOTSUP) {
+            error (0, errno,
+                   _("warning: failed to change context of %s to %s"), 
path, scontext);
+        }
+    }
+    freecon(scontext);
+    return 1;
+}
+#endif
+
 struct passwd *getpwnam ();
 struct group *getgrnam ();
 
@@ -123,11 +160,17 @@
 static struct option const long_options[] =
 {
   {"backup", optional_argument, NULL, 'b'},
+#ifdef WITH_SELINUX
+  {"context", required_argument, NULL, 'Z'},
+#endif
   {"directory", no_argument, NULL, 'd'},
   {"group", required_argument, NULL, 'g'},
   {"mode", required_argument, NULL, 'm'},
   {"owner", required_argument, NULL, 'o'},
   {"preserve-timestamps", no_argument, NULL, 'p'},
+#ifdef WITH_SELINUX
+  {"preserve_context", no_argument, NULL, 'P'},
+#endif
   {"strip", no_argument, NULL, 's'},
   {"suffix", required_argument, NULL, 'S'},
   {"version-control", required_argument, NULL, 'V'}, /* Deprecated. 
FIXME. */
@@ -244,6 +287,9 @@
 
   x->update = 0;
   x->verbose = 0;
+#ifdef WITH_SELINUX
+  x->preserve_security_context = 0;
+#endif
   x->dest_info = NULL;
   x->src_info = NULL;
 }
@@ -261,6 +307,11 @@
   struct cp_options x;
   int n_files;
   char **file;
+#ifdef WITH_SELINUX
+  security_context_t scontext = NULL;
+ /* set iff kernel has extra selinux system calls */
+  selinux_enabled = (is_selinux_enabled()>0);
+#endif
 
   initialize_main (&argc, &argv);
   program_name = argv[0];
@@ -282,7 +333,11 @@
      we'll actually use backup_suffix_string.  */
   backup_suffix_string = getenv ("SIMPLE_BACKUP_SUFFIX");
 
+#ifdef WITH_SELINUX
+  while ((optc = getopt_long (argc, argv, "bcCsDdg:m:o:pPvV:S:Z:", 
long_options,
+#else
   while ((optc = getopt_long (argc, argv, "bcCsDdg:m:o:pvV:S:", 
long_options,
+#endif
                   NULL)) != -1)
     {
       switch (optc)
@@ -335,6 +390,41 @@
       make_backups = 1;
       backup_suffix_string = optarg;
       break;
+#ifdef WITH_SELINUX
+     case 'P':
+    /* politely decline if we're not on a selinux-enabled kernel. */
+      if( !selinux_enabled ) {
+         fprintf( stderr, "Warning:  ignoring --preserve_context (-P) "
+                     "because the kernel is not selinux-enabled.\n" );
+         break;
+       }
+       if ( scontext!=NULL ) { /* scontext could be NULL because of 
calloc() failure */
+           (void) fprintf(stderr, "%s: cannot force target context to 
'%s' and preserve it\n", argv[0], scontext);
+         exit( 1 );
+       }
+       x.preserve_security_context = 1;
+       use_default_selinux_context = 0;
+       break ;
+     case 'Z':
+       /* politely decline if we're not on a selinux-enabled kernel. */
+      if( !selinux_enabled) {
+         fprintf( stderr, "Warning:  ignoring --context (-Z) "
+                      "because the kernel is not selinux-enabled.\n" );
+         break;
+       }
+       if ( x.preserve_security_context ) {
+
+                 (void) fprintf(stderr, "%s: cannot force target 
context == '%s' and preserve it\n", argv[0], optarg);
+         exit( 1 );
+       }
+       scontext = optarg;
+       use_default_selinux_context = 0;
+      if (setfscreatecon(scontext)) {
+         (void) fprintf(stderr, "%s: cannot setup default context == 
'%s'\n", argv[0], scontext);
+        exit(1);
+      }
+       break;
+#endif
     case_GETOPT_HELP_CHAR;
     case_GETOPT_VERSION_CHAR (PROGRAM_NAME, AUTHORS);
     default:
@@ -564,6 +654,10 @@
       err = 1;
     }
 
+#ifdef WITH_SELINUX
+  if (use_default_selinux_context)
+      setdefaultfilecon(path);
+#endif
   return err;
 }
 
@@ -716,6 +810,11 @@
   -S, --suffix=SUFFIX override the usual backup suffix\n\
   -v, --verbose       print the name of each directory as it is created\n\
 "), stdout);
+      fputs (_("\
+  -P, --preserve_context (SELinux) Preserve security context\n\
+  -Z, --context=CONTEXT  (SELinux) Set security context of files and 
directories\n\
+"), stdout);
+
       fputs (HELP_OPTION_DESCRIPTION, stdout);
       fputs (VERSION_OPTION_DESCRIPTION, stdout);
       fputs (_("\

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
