Message-ID: <41E54436.3080008@redhat.com>
Date: Wed, 12 Jan 2005 10:37:26 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Colin Walters <walters@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Added is_context_configurable function
References: <41E2FEF4.5070604@redhat.com>	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>	 <41E3FAF4.2060109@redhat.com>	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>	 <1105481440.24748.22.camel@nexus.verbum.private> <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040600000607040406060805"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040600000607040406060805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patched for libselinux.

This patch changes the previous to rename configurable_contexts to 
customizable_paths.

Also modifies matchpathcon to process file_contexts.local

So if a user wants to change the config file of a server to a different 
location they can
do something like the following

sed 's|/var/www|/usr/local/www/g' 
/etc/selinux/targeted/context/file_context > 
/etc/selinux/targeted/context/file_context.local

And then restorecon -R -v /usr/local/www


--------------040600000607040406060805
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.20.1/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2004-12-03 14:40:05.000000000 -0500
+++ libselinux-1.20.1/include/selinux/selinux.h	2005-01-12 10:09:49.691145916 -0500
@@ -226,6 +226,7 @@
 extern const char *selinux_media_context_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_booleans_path(void);
+extern const char *selinux_customizable_types_path(void);
 
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
@@ -242,6 +243,10 @@
 		       const char *filename, 
 		       char *const argv[], char *const envp[]);
 
+/* Returns whether a file context is customizable, and should not 
+   be relabeled . */
+extern int is_context_customizable (security_context_t scontext);
+
 #ifdef __cplusplus
 }
 #endif
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/is_context_customizable.3 libselinux-1.20.1/man/man3/is_context_customizable.3
--- nsalibselinux/man/man3/is_context_customizable.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.20.1/man/man3/is_context_customizable.3	2005-01-12 10:09:49.692145804 -0500
@@ -0,0 +1,22 @@
+.TH "is_context_customizable" "3" "10 January 2005" "dwalsh@redhat.com" "SELinux API documentation"
+.SH "NAME"
+is_context_customizable \- check whether context type is customizable by the administrator.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.B int is_context_customizable(security_context_t scon);
+
+.SH "DESCRIPTION"
+.B is_context_customizable
+.br
+This function checks whether the type of scon is in the /etc/selinux/SELINUXTYPE/context/customizable_types file.  A customizable type is a file context type that
+administrators set on files, usually to allow certain domains to share the file content. restorecon and setfiles, by default, leave these context in place.
+
+ 
+.SH "RETURN VALUE"
+returns 1 if security context is customizable or 0 if it is not. 
+returns -1 on error
+
+.SH "FILE"
+/etc/selinux/SELINUXTYPE/context/customizable_types
+
diff --exclude-from=exclude -N -u -r nsalibselinux/src/file_path_suffixes.h libselinux-1.20.1/src/file_path_suffixes.h
--- nsalibselinux/src/file_path_suffixes.h	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.20.1/src/file_path_suffixes.h	2005-01-12 10:09:49.693145692 -0500
@@ -9,3 +9,4 @@
 S_(BOOLEANS, "/booleans")
 S_(MEDIA_CONTEXTS, "/contexts/files/media")
 S_(REMOVABLE_CONTEXT, "/contexts/removable_context")
+S_(CUSTOMIZABLE_TYPES, "/contexts/customizable_types")
diff --exclude-from=exclude -N -u -r nsalibselinux/src/is_customizable_type.c libselinux-1.20.1/src/is_customizable_type.c
--- nsalibselinux/src/is_customizable_type.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.20.1/src/is_customizable_type.c	2005-01-12 10:09:49.695145469 -0500
@@ -0,0 +1,68 @@
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include <pwd.h>
+#include <selinux/selinux.h>
+
+static int get_customizable_type_list (security_context_t **retlist)
+{
+	FILE *fp;
+	char buf[4097];
+	int ctr=0, i;
+	security_context_t *list=NULL;
+
+	fp = fopen(selinux_customizable_types_path(), "r");
+	if (!fp)
+		return -1;
+
+	while (fgets_unlocked(buf, 4096, fp)) {
+		ctr++;
+	}
+	rewind(fp);
+	if (ctr) {
+		list=(security_context_t *) calloc(sizeof(security_context_t *), ctr+1);
+		if (list) {
+		  i=0;
+		  while (fgets_unlocked(buf, 4096, fp)) {
+		    buf[strlen(buf)-1]=0;
+		    list[i++]=(security_context_t) strdup(buf);
+		    if (i>ctr) { 
+		      /* Should never happen */
+		      free(list);
+		      list=NULL;
+		      break;
+		    }
+		  }
+		}
+	}
+	fclose(fp);
+	if (!list)
+		return -1;
+	*retlist=list;
+	return 0;
+}
+
+static security_context_t *customizable_list=NULL;
+
+int is_context_customizable (security_context_t scontext) {
+  int i;
+  char *ptr;
+  if (! customizable_list) {
+    if (get_customizable_type_list(&customizable_list)!=0) 
+      return -1;
+  }
+  
+  ptr=strrchr(scontext, ':');
+  if (ptr) {
+	  ptr++;
+  } else {
+	  ptr=scontext;
+  }
+  for (i = 0; customizable_list[i]; i++) {
+    if (strcmp(customizable_list[i],ptr) == 0) return 1;
+  }
+  return 0;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchpathcon.c libselinux-1.20.1/src/matchpathcon.c
--- nsalibselinux/src/matchpathcon.c	2004-12-29 11:51:23.000000000 -0500
+++ libselinux-1.20.1/src/matchpathcon.c	2005-01-12 10:10:03.411611561 -0500
@@ -207,15 +207,135 @@
 	}
 	return;
 }
-
+static int process_line( const char *path, char *line_buf, int pass, int lineno) {
+	int items, len, regerr;
+	char *buf_p;
+	char *regex, *type, *context;
+	char *anchored_regex;
+	len = strlen(line_buf);
+	if (line_buf[len - 1] != '\n') {
+		myprintf("%s:  line %d is too long, would be truncated, skipping\n", path, lineno); 
+		return 0;
+	}
+	line_buf[len - 1] = 0;
+	buf_p = line_buf;
+	while (isspace(*buf_p))
+		buf_p++;
+	/* Skip comment lines and empty lines. */
+	if (*buf_p == '#' || *buf_p == 0)
+		return 0;
+	items =
+		sscanf(line_buf, "%as %as %as", &regex, &type,
+		       &context);
+	if (items < 2) {
+		myprintf("%s:  line %d is missing fields\n, skipping", path, lineno); 
+		return 0;
+	} else if (items == 2) {
+		/* The type field is optional. */
+		free(context);
+		context = type;
+		type = 0;
+	}
+	
+	if (pass == 1) {
+		/* On the second pass, compile and store the specification in spec. */
+		const char *reg_buf = regex;
+		char *cp;
+		spec_arr[nspec].stem_id = find_stem_from_spec(&reg_buf);
+		spec_arr[nspec].regex_str = regex;
+		
+		/* Anchor the regular expression. */
+		len = strlen(reg_buf);
+		cp = anchored_regex = malloc(len + 3);
+		if (!anchored_regex)
+			return -1;
+		/* Create ^...$ regexp.  */
+		*cp++ = '^';
+		cp = mempcpy(cp, reg_buf, len);
+		*cp++ = '$';
+		*cp = '\0';
+		
+		/* Compile the regular expression. */
+		regerr =
+			regcomp(&spec_arr[nspec].regex,
+				anchored_regex,
+				REG_EXTENDED | REG_NOSUB);
+		free(anchored_regex);
+		if (regerr < 0) {
+			myprintf("%s:  line %d has invalid regex %s\n", path, lineno, anchored_regex); 
+			return 0;
+		}
+		
+		/* Convert the type string to a mode format */
+		spec_arr[nspec].type_str = type;
+		spec_arr[nspec].mode = 0;
+		if (!type)
+			goto skip_type;
+		len = strlen(type);
+		if (type[0] != '-' || len != 2) {
+			myprintf("%s:  line %d has invalid file type %s\n", path, lineno, type); 
+			return 0;
+		}
+		switch (type[1]) {
+		case 'b':
+			spec_arr[nspec].mode = S_IFBLK;
+			break;
+		case 'c':
+			spec_arr[nspec].mode = S_IFCHR;
+			break;
+		case 'd':
+			spec_arr[nspec].mode = S_IFDIR;
+			break;
+		case 'p':
+			spec_arr[nspec].mode = S_IFIFO;
+			break;
+		case 'l':
+			spec_arr[nspec].mode = S_IFLNK;
+			break;
+		case 's':
+			spec_arr[nspec].mode = S_IFSOCK;
+			break;
+		case '-':
+			spec_arr[nspec].mode = S_IFREG;
+			break;
+		default:
+			myprintf("%s:  line %d has invalid file type %s\n", path, lineno, type); 
+			return 0;
+		}
+		
+	skip_type:
+		
+		spec_arr[nspec].context = context;
+		
+		if (strcmp(context, "<<none>>")) {
+			if (security_check_context(context) < 0 && errno != ENOENT) {
+				myprintf("%s:  line %d has invalid context %s\n", path, lineno, context); 
+				return 0;
+			}
+		}
+		
+		/* Determine if specification has 
+		 * any meta characters in the RE */
+		spec_hasMetaChars(&spec_arr[nspec]);
+	}
+	
+	nspec++;
+	if (pass == 0) {
+		free(regex);
+		if (type)
+			free(type);
+		free(context);
+	}
+	return 0;
+}
 static int matchpathcon_init(void)
 {
 	FILE *fp;
 	const char *path;
-	char line_buf[BUFSIZ + 1], *buf_p;
-	char *regex, *type, *context;
-	char *anchored_regex;
-	int items, len, lineno, pass, regerr, i, j;
+	FILE *localfp;
+	char local_path[PATH_MAX + 1];
+	char line_buf[BUFSIZ + 1];
+	int lineno, pass, i, j;
 	spec_t *spec_copy;
 
 	/* Open the specification file. */
@@ -223,6 +343,9 @@
 	if ((fp = fopen(path, "r")) == NULL)
 		return -1;
 
+	snprintf(local_path, sizeof(local_path), "%s.local", path);
+	localfp = fopen(local_path, "r");
+
 	/* 
 	 * Perform two passes over the specification file.
 	 * The first pass counts the number of specifications and
@@ -235,123 +358,15 @@
 		lineno = 0;
 		nspec = 0;
 		while (fgets_unlocked(line_buf, sizeof line_buf, fp)) {
-			lineno++;
-			len = strlen(line_buf);
-			if (line_buf[len - 1] != '\n') {
-				myprintf("%s:  line %d is too long, would be truncated, skipping\n", path, lineno); 
-				continue;
-			}
-			line_buf[len - 1] = 0;
-			buf_p = line_buf;
-			while (isspace(*buf_p))
-				buf_p++;
-			/* Skip comment lines and empty lines. */
-			if (*buf_p == '#' || *buf_p == 0)
-				continue;
-			items =
-			    sscanf(line_buf, "%as %as %as", &regex, &type,
-				   &context);
-			if (items < 2) {
-				myprintf("%s:  line %d is missing fields\n, skipping", path, lineno); 
-				continue;
-			} else if (items == 2) {
-				/* The type field is optional. */
-				free(context);
-				context = type;
-				type = 0;
-			}
-
-			if (pass == 1) {
-				/* On the second pass, compile and store the specification in spec. */
-				const char *reg_buf = regex;
-				char *cp;
-				spec_arr[nspec].stem_id = find_stem_from_spec(&reg_buf);
-				spec_arr[nspec].regex_str = regex;
-
-				/* Anchor the regular expression. */
-				len = strlen(reg_buf);
-				cp = anchored_regex = malloc(len + 3);
-				if (!anchored_regex)
+			if (process_line(path, line_buf, pass, ++lineno) != 0)
+				return -1;
+		}
+		if (localfp) 
+			while (fgets_unlocked(line_buf, sizeof line_buf, localfp)) {
+				if (process_line(local_path, line_buf, pass, ++lineno) != 0)
 					return -1;
-				/* Create ^...$ regexp.  */
-				*cp++ = '^';
-				cp = mempcpy(cp, reg_buf, len);
-				*cp++ = '$';
-				*cp = '\0';
-
-				/* Compile the regular expression. */
-				regerr =
-				    regcomp(&spec_arr[nspec].regex,
-					    anchored_regex,
-					    REG_EXTENDED | REG_NOSUB);
-				free(anchored_regex);
-				if (regerr < 0) {
-					myprintf("%s:  line %d has invalid regex %s\n", path, lineno, anchored_regex); 
-					continue;
-				}
-
-				/* Convert the type string to a mode format */
-				spec_arr[nspec].type_str = type;
-				spec_arr[nspec].mode = 0;
-				if (!type)
-					goto skip_type;
-				len = strlen(type);
-				if (type[0] != '-' || len != 2) {
-					myprintf("%s:  line %d has invalid file type %s\n", path, lineno, type); 
-					continue;
-				}
-				switch (type[1]) {
-				case 'b':
-					spec_arr[nspec].mode = S_IFBLK;
-					break;
-				case 'c':
-					spec_arr[nspec].mode = S_IFCHR;
-					break;
-				case 'd':
-					spec_arr[nspec].mode = S_IFDIR;
-					break;
-				case 'p':
-					spec_arr[nspec].mode = S_IFIFO;
-					break;
-				case 'l':
-					spec_arr[nspec].mode = S_IFLNK;
-					break;
-				case 's':
-					spec_arr[nspec].mode = S_IFSOCK;
-					break;
-				case '-':
-					spec_arr[nspec].mode = S_IFREG;
-					break;
-				default:
-					myprintf("%s:  line %d has invalid file type %s\n", path, lineno, type); 
-					continue;
-				}
-
-			      skip_type:
-
-				spec_arr[nspec].context = context;
-
-				if (strcmp(context, "<<none>>")) {
-					if (security_check_context(context) < 0 && errno != ENOENT) {
-						myprintf("%s:  line %d has invalid context %s\n", path, lineno, context); 
-						continue;
-					}
-				}
-
-				/* Determine if specification has 
-				 * any meta characters in the RE */
-				spec_hasMetaChars(&spec_arr[nspec]);
 			}
 
-			nspec++;
-			if (pass == 0) {
-				free(regex);
-				if (type)
-					free(type);
-				free(context);
-			}
-		}
-
 		if (pass == 0) {
 			if (nspec == 0)
 				return 0;
@@ -360,9 +375,11 @@
 				return -1;
 			memset(spec_arr, '\0', sizeof(spec_t) * nspec);
 			rewind(fp);
+			if (localfp) rewind(localfp);
 		}
 	}
 	fclose(fp);
+	if (localfp) fclose(localfp);
 
 	/* Move exact pathname specifications to the end. */
 	spec_copy = malloc(sizeof(spec_t) * nspec);
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-1.20.1/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.20.1/src/selinux_config.c	2005-01-12 10:09:49.698145133 -0500
@@ -26,7 +26,8 @@
 #define BOOLEANS          7
 #define MEDIA_CONTEXTS    8
 #define REMOVABLE_CONTEXT 9
-#define NEL               10
+#define CUSTOMIZABLE_TYPES    10
+#define NEL               11
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -211,6 +212,10 @@
   return get_path(MEDIA_CONTEXTS);
 }
 
+const char *selinux_customizable_types_path() {
+  return get_path(CUSTOMIZABLE_TYPES);
+}
+
 const char *selinux_contexts_path() {
   return get_path(CONTEXTS_DIR);
 }

--------------040600000607040406060805--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
