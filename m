Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03J96Xf023027
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:09:06 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03J80qa024035
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 19:08:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Steve G <linux_4ever@yahoo.com>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: setfiles and restorecon performance patch
Date: Wed, 4 Jan 2006 06:08:19 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
   "Stephen C. Tweedie" <sct@redhat.com>
References: <20060103155531.9154.qmail@web51507.mail.yahoo.com>
In-Reply-To: <20060103155531.9154.qmail@web51507.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IvsuDcgJcxcPZN2"
Message-Id: <200601040608.56218.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_IvsuDcgJcxcPZN2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 04 January 2006 02:55, Steve G <linux_4ever@yahoo.com> wrote:
> >@@ -143,7 +141,7 @@ int restore(char *filename) {
> >     if (verbose>1)
> >       fprintf(stderr,"Warning! %s refers to a symbolic link, not
> > following last component.\n", filename);
> >     char *p = NULL, *file_sep;
> >-    char *tmp_path = strdup(filename);
> >+    char *tmp_path = strdupa(filename);
> >     if (!tmp_path) {
> >       fprintf(stderr,"strdup on %s failed:  %s\n",
> > >filename,strerror(errno));
>
> Do you need to check for NULL on strdupa calls? If so, the error message
> needs to have the function updated, too. Otherwise this can be deleted.

Not sure.  The alloca() man page says that the failure result is undefined but 
the strdupa() man page says nothing (implies that it's the same as strdup()).

Ulrich?

> >@@ -155,14 +153,16 @@ int restore(char *filename) {
> >       file_sep++;
> >       p = realpath(tmp_path, path);
> >     }
> >-    if (!p || strlen(path) + strlen(file_sep) + 1 > PATH_MAX) {
> >+    size_t len = strlen(p);
> >+    if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
>
> What if realpath returned NULL? strlen is using a NULL pointer and then p
> is checked in the second line to see if its NULL.

Fixed that, attached a new patch.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_IvsuDcgJcxcPZN2
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="setf2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="setf2.diff"

diff -rup policycoreutils-1.29.2.orig/restorecon/restorecon.c policycoreutils-1.29.2/restorecon/restorecon.c
--- policycoreutils-1.29.2.orig/restorecon/restorecon.c	2005-12-15 06:16:56.000000000 +1100
+++ policycoreutils-1.29.2/restorecon/restorecon.c	2006-01-04 06:03:36.000000000 +1100
@@ -23,7 +23,9 @@
  *
  */
 
+#define _GNU_SOURCE
 #include <stdio.h>
+#include <stdio_ext.h>
 #include <errno.h>
 #include <string.h>
 #include <stdlib.h>
@@ -45,6 +47,8 @@ static char *progname;
 static int errors=0;
 static int recurse=0;
 static int force=0;
+#define STAT_BLOCK_SIZE 8
+static int pipe_fds[2] = { -1, -1 };
 
 #define MAX_EXCLUDES 100
 static int excludeCtr=0;
@@ -115,21 +119,15 @@ void usage(const char * const name)
 	  "usage:  %s [-rRnv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",  name);
   exit(1);
 }
-int restore(char *filename) {
+/* filename has trailing '/' removed by nftw or other calling code */
+int restore(const char *filename) {
   int retcontext=0;
   int retval=0;
   security_context_t scontext=NULL;
   security_context_t prev_context=NULL;
-  int len=strlen(filename);
   struct stat st;
   char path[PATH_MAX+1];
   int user_only_changed=0;
-  /* 
-     Eliminate trailing /
-  */
-  if (len > 0 && filename[len-1]=='/' && (strcmp(filename,"/") != 0)) {
-    filename[len-1]=0;
-  }
 
   if (excludeCtr > 0 && exclude(filename)) {
       return 0;
@@ -143,9 +141,9 @@ int restore(char *filename) {
     if (verbose>1)
       fprintf(stderr,"Warning! %s refers to a symbolic link, not following last component.\n", filename);
     char *p = NULL, *file_sep;
-    char *tmp_path = strdup(filename);
+    char *tmp_path = strdupa(filename);
     if (!tmp_path) {
-      fprintf(stderr,"strdup on %s failed:  %s\n", filename,strerror(errno));
+      fprintf(stderr,"strdupa on %s failed:  %s\n", filename,strerror(errno));
       return 1;
     }
     file_sep = strrchr(tmp_path, '/');
@@ -155,14 +153,18 @@ int restore(char *filename) {
       file_sep++;
       p = realpath(tmp_path, path);
     }
-    if (!p || strlen(path) + strlen(file_sep) + 1 > PATH_MAX) {
+    size_t len;
+    if(p)
+      len = strlen(p);
+    if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
       fprintf(stderr,"realpath(%s) failed %s\n", filename, strerror(errno));
-      free(tmp_path);
       return 1;
     }
-    sprintf(p + strlen(p), "/%s", file_sep);
+    p += len;
+    *p = '/';
+    p++;
+    strcpy(p, file_sep);
     filename = p;
-    free(tmp_path);
   } else {
     char *p;
     p = realpath(filename, path);
@@ -182,10 +184,6 @@ int restore(char *filename) {
     fprintf(stderr,"matchpathcon(%s) failed %s\n", filename,strerror(errno));
     return 1;
   } 
-  if (strcmp(scontext,"<<none>>")==0) {
-    freecon(scontext);
-    return 0;
-  }
   retcontext=lgetfilecon(filename,&prev_context);
   
   if (retcontext >= 0 || errno == ENODATA) {
@@ -230,38 +228,80 @@ int restore(char *filename) {
   freecon(scontext);
   return errors;
 }
+
+static int pre_stat(const char *file_unused __attribute__((unused)),
+		      const struct stat *sb_unused __attribute__((unused)),
+		      int flag_unused __attribute__((unused)),
+		      struct FTW *s_unused __attribute__((unused)))
+{
+  char buf[STAT_BLOCK_SIZE];
+  if(write(pipe_fds[1], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE)
+  {
+    fprintf(stderr, "Error writing to stat pipe, child exiting.\n");
+    exit(1);
+  }
+  return 0;
+}
+
 static int apply_spec(const char *file,
 		      const struct stat *sb_unused __attribute__((unused)),
 		      int flag,
 		      struct FTW *s_unused __attribute__((unused)))
 {
+	char buf[STAT_BLOCK_SIZE];
+	if(pipe_fds[0] != -1 && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE)
+	{
+		fprintf(stderr, "Read error on pipe.\n");
+		pipe_fds[0] = -1;
+	}
 	if (flag == FTW_DNR) {
 		fprintf(stderr, "%s:  unable to read directory %s\n",
 			progname, file);
 		return 0;
 	}
-	errors=errors+restore((char *)file);
+	errors=errors+restore(file);
 	return 0;
 }
 void process(char *buf) {
+      int rc;
       if (recurse) {
-	if (nftw
-	    (buf, apply_spec, 1024, FTW_PHYS)) {
-	  fprintf(stderr,
-		  "%s:  error while labeling files under %s\n",
+	if(pipe(pipe_fds) == -1)
+	  rc = -1;
+	else
+	  rc = fork();
+	if(rc == 0)
+	{
+	  close(pipe_fds[0]);
+	  nftw(buf, pre_stat, 1024, FTW_PHYS);
+	  exit(1);
+	}
+	if(rc > 0)
+	  close(pipe_fds[1]);
+	if(rc == -1 || rc > 0) {
+	  if (nftw(buf, apply_spec, 1024, FTW_PHYS)) {
+	    fprintf(stderr, "%s:  error while labeling files under %s\n",
 		  progname, buf);
-	  errors++;
+	    errors++;
+	  }
 	}
       }
       else
-	errors=errors+restore(buf);
+      {
+	/* Eliminate trailing / */
+	size_t len = strlen(buf);
+	if (len > 1 && buf[len - 1] == '/') {
+	  buf[len - 1] = 0;
+	}
+	errors = errors + restore(buf);
+      }
 }
 int main(int argc, char **argv) {
   int i=0;
   char *file_name=NULL;
   int file=0;
   int opt;
-  char buf[PATH_MAX];
+  char *buf = NULL;
+  size_t buf_len;
 
   memset(excludeArray,0, sizeof(excludeArray));
 
@@ -269,8 +309,6 @@ int main(int argc, char **argv) {
   if (is_selinux_enabled() <= 0 )
     exit(0);
 
-  memset(buf,0, sizeof(buf));
-
   while ((opt = getopt(argc, argv, "FrRnvf:o:e:")) > 0) {
     switch (opt) {
     case 'n':
@@ -293,6 +331,7 @@ int main(int argc, char **argv) {
 		 optarg, strerror(errno));
 	 usage(argv[0]);
       }
+      __fsetlocking(outfile, FSETLOCKING_BYCALLER);
       break;
     case 'v':
       verbose++;
@@ -307,15 +346,16 @@ int main(int argc, char **argv) {
   }
   if (file) {
     FILE *f=stdin;
+    ssize_t len;
     if (strcmp(file_name,"-")!=0) 
       f=fopen(file_name,"r");
-	
     if (f==NULL) {
       fprintf(stderr,"Unable to open %s: %s\n", file_name, strerror(errno));
       usage(argv[0]);
     }
-    while(fgets(buf,PATH_MAX,f)) {
-      buf[strlen(buf)-1]=0;
+    __fsetlocking(f, FSETLOCKING_BYCALLER);
+    while((len = getline(&buf, &buf_len, f)) != -1) {
+      buf[len - 1] = 0;
       process(buf);
     }
     if (strcmp(file_name,"-")!=0) 
diff -rup policycoreutils-1.29.2.orig/setfiles/setfiles.c policycoreutils-1.29.2/setfiles/setfiles.c
--- policycoreutils-1.29.2.orig/setfiles/setfiles.c	2005-12-15 06:16:57.000000000 +1100
+++ policycoreutils-1.29.2/setfiles/setfiles.c	2006-01-04 06:06:02.000000000 +1100
@@ -62,6 +62,7 @@
 #include <stdlib.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include <stdio_ext.h>
 #include <string.h>
 #include <errno.h>
 #include <ctype.h>
@@ -78,6 +79,8 @@
 static int add_assoc = 1;
 static FILE *outfile=NULL;
 static int force=0;
+#define STAT_BLOCK_SIZE 8
+static int pipe_fds[2] = { -1, -1 };
 
 #define MAX_EXCLUDES 100
 static int excludeCtr=0;
@@ -244,6 +247,12 @@ static int apply_spec(const char *file,
 	int i, j, ret;
 	char *context, *newcon; 
 	int user_only_changed=0;
+	char buf[STAT_BLOCK_SIZE];
+	if(pipe_fds[0] != -1 && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE)
+	{
+		fprintf(stderr, "Read error on pipe.\n");
+		pipe_fds[0] = -1;
+	}
 
 	/* Skip the extra slash at the beginning, if present. */
 	if (file[0] == '/' && file[1] == '/')
@@ -288,17 +297,17 @@ static int apply_spec(const char *file,
 	ret = lgetfilecon(my_file, &context);
 	if (ret < 0) {
 		if (errno == ENODATA) {
-			context = malloc(10);
-			strcpy(context, "<<none>>");
+			context = NULL;
 		} else {
 			perror(my_file);
 			fprintf(stderr, "%s:  unable to obtain attribute for file %s\n", 
 				progname, my_file);
 			goto err;
 		}
+		user_only_changed = 0;
 	}
-
-	user_only_changed=only_changed_user(context, newcon);
+	else
+		user_only_changed=only_changed_user(context, newcon);
 
 	/*
 	 * Do not relabel the file if the matching specification is 
@@ -306,12 +315,12 @@ static int apply_spec(const char *file,
 	 * specification.
 	 */
 	if ((strcmp(newcon, "<<none>>") == 0) || 
-	    (strcmp(context,newcon) == 0)) {
+	    (context && (strcmp(context,newcon) == 0))) {
 		freecon(context);
 		goto out;
 	}
 
-	if (! force && 
+	if (! force && context &&
 	    ( is_context_customizable(context)>0 )) {
 		if (verbose > 1) {
 			fprintf(stderr,"%s: %s not reset customized by admin to %s\n",
@@ -325,20 +334,29 @@ static int apply_spec(const char *file,
 		 * the user has changed but the role and type are the
 		 * same.  For "-vv", emit everything. */
 		if (verbose > 1 || !user_only_changed) {
+		    if(context)
 			printf("%s:  relabeling %s from %s to %s\n", progname,
 			       my_file, context, newcon);
+		    else
+			printf("%s:  labeling %s to %s\n", progname,
+			       my_file, newcon);
 		}
 	}
 
 	if ( log && !user_only_changed ) {
-		syslog(LOG_INFO, "relabeling %s from %s to %s\n", 
-		       my_file, context, newcon);
+		if(context)
+			syslog(LOG_INFO, "relabeling %s from %s to %s\n", 
+				my_file, context, newcon);
+		else
+			syslog(LOG_INFO, "labeling %s to %s\n", 
+				my_file, newcon);
 	}
 
 	if (outfile && !user_only_changed)
 		fprintf(outfile, "%s\n", my_file);
 
-	freecon(context);
+	if(context)
+		freecon(context);
 
 	/*
 	 * Do not relabel the file if -n was used.
@@ -411,6 +429,20 @@ int canoncon(const char *path, unsigned 
 	return !valid;
 }
 
+static int pre_stat(const char *file_unused __attribute__((unused)),
+                    const struct stat *sb_unused __attribute__((unused)),
+                    int flag_unused __attribute__((unused)),
+                    struct FTW *s_unused __attribute__((unused)))
+{
+  char buf[STAT_BLOCK_SIZE];
+  if(write(pipe_fds[1], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE)
+  {
+    fprintf(stderr, "Error writing to stat pipe, child exiting.\n");
+    exit(1);
+  }
+  return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int opt, rc, i;
@@ -435,6 +467,7 @@ int main(int argc, char **argv)
 					policyfile, strerror(errno));
 				exit(1);
 			}
+			__fsetlocking(policystream, FSETLOCKING_BYCALLER);
 
 			if (sepol_set_policydb_from_file(policystream) < 0) {
 				fprintf(stderr, "Error reading policy %s: %s\n", policyfile,
@@ -474,6 +507,7 @@ int main(int argc, char **argv)
 
 				usage(argv[0]);
 			}
+			__fsetlocking(outfile, FSETLOCKING_BYCALLER);
 			break;
 		case 'q':
 			quiet = 1;
@@ -580,15 +614,31 @@ int main(int argc, char **argv)
 
 		qprintf("%s:  labeling files under %s\n", argv[0],
 			argv[optind]);
-		
+
+		int rc;
+		if(pipe(pipe_fds) == -1)
+			rc = -1;
+		else
+			rc = fork();
+		if(rc == 0)
+		{
+			close(pipe_fds[0]);
+			nftw(argv[optind], pre_stat, 1024, FTW_PHYS);
+			exit(1);
+		}
+		if(rc > 0)
+			close(pipe_fds[1]);
+		if(rc == -1 || rc > 0) {
+
 		/* Walk the file tree, calling apply_spec on each file. */
-		if (nftw
-		    (argv[optind], apply_spec, 1024,
-		     FTW_PHYS | FTW_MOUNT)) {
-			fprintf(stderr,
+			if (nftw
+			    (argv[optind], apply_spec, 1024,
+			     FTW_PHYS | FTW_MOUNT)) {
+				fprintf(stderr,
 				"%s:  error while labeling files under %s\n",
 				argv[0], argv[optind]);
-			exit(1);
+				exit(1);
+			}
 		}
 
 		/*

--Boundary-00=_IvsuDcgJcxcPZN2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
