Message-ID: <4243050D.3050808@redhat.com>
Date: Thu, 24 Mar 2005 13:21:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: setsebool problems
Content-Type: multipart/mixed;
 boundary="------------060704040002030802040405"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060704040002030802040405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We have a problem in  the way we are handling booleans in FC3/RHEL4.  
Basically we are allowing the user to edit the booleans
file either by hand or by using setsebool -P.  One problem is that if we 
want to override the default boolean value in policy with the booleans file.
We can  not because selinux-policy-* has booleans marked as 
config(noreplace).  Otherwise the user would loose his settings.  Second 
problem is that setsebool allows users to customize booleans and as an 
option make them permanent.  The way it makes them pemanant is it takes 
the values
that are currently running in the kernel and rewrites the boolean file.  
This brings up the following bug

 > setsebool allow_ypbind=0
 > setsebool -P squid_disable_trans=1
Ends up with a booleans file containing
allow_ypbind=0
squid_disable_trans=1

Which is probably not what the user wanted.

So this patch changes the selinux handling of booleans.  First it 
introduces a new file booleans.local which will contain the users custom 
boolean settings.  booleans will be changes to a config file so that it 
will be overwritten by rpm on upgrade.  security_load_booleans now reads 
booleans and booleans.local to setup boolean values.  setsebool now only 
writes the changed values to booleans.local.

Ideas?

Dan

-- 



--------------060704040002030802040405
Content-Type: text/plain;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.23.2/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2005-03-17 10:34:51.000000000 -0500
+++ libselinux-1.23.2/include/selinux/selinux.h	2005-03-24 09:39:12.000000000 -0500
@@ -136,6 +136,9 @@
 /* Load a policy configuration. */
 extern int security_load_policy(void *data, size_t len);
 
+/* Translate boolean strict to name value pair. */
+extern int security_process_boolean(char *buffer, char *name, int namelen, int *value);
+
 /* Load policy boolean settings.
    Path may be NULL, in which case the booleans are loaded from
    the active policy boolean configuration file. */
diff --exclude-from=exclude -N -u -r nsalibselinux/src/booleans.c libselinux-1.23.2/src/booleans.c
--- nsalibselinux/src/booleans.c	2004-11-09 09:13:54.000000000 -0500
+++ libselinux-1.23.2/src/booleans.c	2005-03-24 09:39:12.000000000 -0500
@@ -238,51 +238,74 @@
 	dest[i+1]='\0';
 	return dest;
 }
-
+int security_process_boolean(char *buffer, char *name, int namesize, int *val) {
+	char name1[BUFSIZ];
+	char *ptr;
+	char *tok=strtok_r(buffer,"=",&ptr);
+	if (tok) {
+		strncpy(name1,tok, BUFSIZ-1);
+		strtrim(name,name1,namesize-1);
+		if ( name[0]=='#' ) return 0;
+		tok=strtok_r(NULL,"\0",&ptr);
+		if (tok) {
+			while (isspace(*tok)) tok++;
+			*val = -1;
+			if (isdigit(tok[0]))
+				*val=atoi(tok);
+			else if (!strncmp(tok, "true", sizeof("true")-1))
+				*val = 1;
+			else if (!strncmp(tok, "false", sizeof("false")-1))
+				*val = 0;
+			if (*val != 0 && *val != 1) {
+				fprintf(stderr,"illegal value for boolean %s=%s\n", name, tok);
+				return -1;
+			}
+			
+		}
+	}
+	return 1;
+}
 int security_load_booleans(char *path) {
 	FILE *boolf;
 	char buffer[BUFSIZ];
-	char name[BUFSIZ];
-	char name1[BUFSIZ];
-	int val;
+	char localbools[BUFSIZ];
 	int errors=0;
+	int val;
+	char name[BUFSIZ];
 
 	boolf = fopen(path ? path : selinux_booleans_path(),"r");
 	if (boolf == NULL) 
 		return -1;
 
         while (fgets_unlocked(buffer, sizeof(buffer), boolf)) {
-		char *ptr;
-		char *tok=strtok_r(buffer,"=",&ptr);
-		if (tok) {
-			strncpy(name1,tok, BUFSIZ-1);
-			strtrim(name,name1,BUFSIZ-1);
-			if ( name[0]=='#' ) continue;
-			tok=strtok_r(NULL,"\0",&ptr);
-			if (tok) {
-				while (isspace(*tok)) tok++;
-				val = -1;
-				if (isdigit(tok[0]))
-					val=atoi(tok);
-				else if (!strncmp(tok, "true", sizeof("true")-1))
-					val = 1;
-				else if (!strncmp(tok, "false", sizeof("false")-1))
-					val = 0;
-				if (val != 0 && val != 1) {
-					fprintf(stderr,"illegal value for boolean %s=%s\n", name, tok);
-					errors++;
-					continue;
-				}
+		int ret=security_process_boolean(buffer, name, sizeof(name), &val);
+		if (ret==-1) 
+			errors++;
+		if (ret==1) 
+			if (security_set_boolean(name, val) < 0) {
+				fprintf(stderr,"error setting boolean %s to value %d \n", name, val);
+				errors++;
+			}
+	}
+	fclose(boolf);
+
+	snprintf(localbools,sizeof(localbools), "%s.local", (path ? path : selinux_booleans_path()));
+	boolf = fopen(localbools,"r");
 
+	if (boolf != NULL) {
+		int ret;
+		while (fgets_unlocked(buffer, sizeof(buffer), boolf)) {
+			ret=security_process_boolean(buffer, name, sizeof(name), &val);
+			if (ret==-1) 
+				errors++;
+			if (ret==1) 
 				if (security_set_boolean(name, val) < 0) {
 					fprintf(stderr,"error setting boolean %s to value %d \n", name, val);
 					errors++;
 				}
-			}
 		}
+		fclose(boolf);
 	}
-	fclose(boolf);
-
 	if (security_commit_booleans() < 0)
 		return -1;
 
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/setsebool.c libselinux-1.23.2/utils/setsebool.c
--- nsalibselinux/utils/setsebool.c	2005-02-22 16:34:17.000000000 -0500
+++ libselinux-1.23.2/utils/setsebool.c	2005-03-24 10:38:20.000000000 -0500
@@ -76,8 +76,15 @@
 {
 	char *name, *value_ptr;
 	int i=start, value;
+	int j=0;
+	int boolcnt=end-start;
 	struct passwd *pwd;
-
+	typedef struct {
+		char *name;
+		int value; 
+		int used;
+	} boolean;
+	boolean *vallist=calloc(boolcnt, sizeof(boolean));
 	while (i < end) {
 		name = list[i];
 		value_ptr = strchr(list[i], '=');
@@ -110,7 +117,11 @@
 			rollback(list, start, i);
 			return 2;
 		}
+		vallist[j].value = value;
+		vallist[j].name = strdup(name);
+		
 		i++;
+		j++;
 
 		/* Now put it back */
 		value_ptr--;
@@ -120,31 +131,17 @@
 	/* At this point we know that everything is good. Let's write
 	   the file if the -P option was given. */
 	if (permanent) {
-		char **names;
-		const char *bool_file;
-		char *tmp_bool_file;
-		int rc, len, fd, j;
-
-		rc = security_get_boolean_names(&names, &len);
-		if (rc) {
-			fprintf(stderr,
-				"Unable to get boolean names:  %s\n",
-				strerror(errno));
-			rollback(list, start, i);
-			return 5;
-		}
-
-		if (!len) {
-			fprintf(stderr, 
-			"Unable to get the boolean list from kernel - exiting\n"
-				);
-			rollback(list, start, i);
-			return 6;
-		}
-
+		int len;
+		char buffer[BUFSIZ];
+		
 		/* Open file */
-		bool_file = selinux_booleans_path();
-		tmp_bool_file = (char *) alloca (strlen(bool_file) + 8);
+		const char *bool_file = selinux_booleans_path();
+		char *local_bool_file = (char *) alloca (strlen(bool_file) + 7);
+		char *tmp_bool_file = (char *) alloca (strlen(bool_file) + 8);
+		FILE *boolf;
+		int fd;
+		sprintf(local_bool_file, "%s.local", bool_file);
+		boolf = fopen(local_bool_file,"r");
 		strcpy(stpcpy(tmp_bool_file, bool_file), ".XXXXXX");
 		fd = mkstemp(tmp_bool_file);
 		if (fd < 0) {
@@ -152,35 +149,74 @@
 				"Error creating boolean file %s\n", 
 				bool_file);
 			rollback(list, start, i);
+			for (i=0; i < boolcnt; i++) 
+				free(vallist[i].name);
+			free(vallist);
 			return 7;
 			
 		}
 
-		/* Walk the list in pending memory, writing each to the file */
-		for (j=0; j<len; j++) {
-			char val_str[72];
-			int len;
-			int pending = security_get_boolean_pending(names[j]);
-			len = snprintf(val_str, sizeof(val_str), "%s=%d\n", 
-							names[j], pending);
-			if (write(fd, val_str, len) != len) {
-			close_remove_fail:
-				close(fd);
-			remove_fail:
-				unlink(tmp_bool_file);
-				rollback(list, start, i);
-				return 8;
+		if (boolf != NULL) {
+			int ret, val;
+			char boolname[BUFSIZ];
+			while (fgets_unlocked(buffer, sizeof(buffer), boolf)) {
+				ret=security_process_boolean(buffer, boolname, sizeof(boolname), &val);
+				if (ret!=1) { 
+					len=strlen(buffer);
+					if (write(fd, buffer, len) != len) 
+						goto close_remove_fail;
+				} else {
+					for (i=0; i < boolcnt; i++) {
+						if (strcmp(vallist[i].name, boolname)==0) {
+							snprintf(buffer,sizeof(buffer), "%s=%d\n", boolname, vallist[i].value); 
+							len=strlen(buffer);
+							vallist[i].used=1;
+							if (write(fd, buffer, len) != len) 
+								goto close_remove_fail;
+							else 
+								break;
+						}
+					}
+					if ( i == boolcnt ) {
+						snprintf(buffer,sizeof(buffer), "%s=%d\n", boolname, val); 
+						len=strlen(buffer);
+						if (write(fd, buffer, len) != len) 
+							goto close_remove_fail;
+					}
+				}
 			}
+			fclose(boolf);
 		}
 
+		for (i=0; i < boolcnt; i++) {
+			if (vallist[i].used==0) {
+				snprintf(buffer,sizeof(buffer), "%s=%d\n", vallist[i].name, vallist[i].value); 
+				len=strlen(buffer);
+				if (write(fd, buffer, len) != len) {
+					close_remove_fail:
+					close(fd);
+				remove_fail:
+					unlink(tmp_bool_file);
+					rollback(list, start, i);
+					for (i=0; i < boolcnt; i++) 
+						free(vallist[i].name);
+					free(vallist);
+					return 8;
+				}
+			}
+
+		}
 		if (fchmod(fd, S_IRUSR | S_IWUSR) != 0)
 			goto close_remove_fail;
 		close(fd);
-		if (rename(tmp_bool_file, bool_file) != 0)
+		if (rename(tmp_bool_file, local_bool_file) != 0)
 			goto remove_fail;
 		syslog(LOG_NOTICE, "%s has been updated.", bool_file);
 	}
-	
+
+		for (i=0; i < boolcnt; i++) 
+			free(vallist[i].name);
+	free(vallist);
 	/* OK, let's do the commit */
 	if (security_commit_booleans()) {
 		fputs("Error committing booleans\n", stderr);

--------------060704040002030802040405--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
