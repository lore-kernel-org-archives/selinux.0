Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJ3eXRb016101
	for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2003 22:40:33 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAJ3e2Bb028013
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 03:40:02 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAJ3dt4o028010
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 03:39:58 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id BF64D61BE7
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:40:22 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 09174-09 for <selinux@tycho.nsa.gov>;
	Wed, 19 Nov 2003 14:40:21 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id 5BF1E61BE5
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:40:21 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 033FD925E8
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:40:20 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8E3E97F01C
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:40:19 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils patch
Date: Wed, 19 Nov 2003 14:40:19 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jYuu/xqsKlYTVk3"
Message-Id: <200311191440.19038.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_jYuu/xqsKlYTVk3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have attached a small patch to policycoreutils.  This fixes a bunch of minor 
warnings in setfiles (the sb_unused change is just to flag the parameter as 
one we know we aren't using), and makes some Makefile changes to assist in 
packaging.

Steve, I believe that this is worthy of including in the next release.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_jYuu/xqsKlYTVk3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="policycoreutils.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="policycoreutils.diff"

diff -rup /tmp/policycoreutils-1.2/load_policy/Makefile ./load_policy/Makefile
--- /tmp/policycoreutils-1.2/load_policy/Makefile	2003-08-28 02:07:11.000000000 +1000
+++ ./load_policy/Makefile	2003-11-19 14:11:56.000000000 +1100
@@ -3,7 +3,8 @@ PREFIX ?= ${DESTDIR}/usr
 SBINDIR ?= $(PREFIX)/sbin
 LOCALEDIR ?= /usr/share/locale
 
-CFLAGS = -Wall -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+CFLAGS = -Wall
+override CFLAGS += -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux
 
 # Build static so that we can put it on an initrd.
diff -rup /tmp/policycoreutils-1.2/newrole/Makefile ./newrole/Makefile
--- /tmp/policycoreutils-1.2/newrole/Makefile	2003-08-28 02:07:12.000000000 +1000
+++ ./newrole/Makefile	2003-11-19 14:11:41.000000000 +1100
@@ -5,8 +5,8 @@ MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR = /usr/share/locale
 
-CFLAGS = -Wall -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-override CFLAGS += -DUSE_PAM
+CFLAGS = -Wall
+override CFLAGS += -DUSE_PAM -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -lattr -ldl -lpam -lpam_misc
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
diff -rup /tmp/policycoreutils-1.2/run_init/Makefile ./run_init/Makefile
--- /tmp/policycoreutils-1.2/run_init/Makefile	2003-08-28 02:07:16.000000000 +1000
+++ ./run_init/Makefile	2003-11-19 14:12:26.000000000 +1100
@@ -6,8 +6,8 @@ MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR ?= /usr/share/locale
 
-CFLAGS = -Wall -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-override CFLAGS += -DUSE_PAM
+CFLAGS = -Wall
+override CFLAGS += -DUSE_PAM -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -lattr -ldl -lpam -lpam_misc
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
diff -rup /tmp/policycoreutils-1.2/setfiles/setfiles.c ./setfiles/setfiles.c
--- /tmp/policycoreutils-1.2/setfiles/setfiles.c	2003-09-26 01:06:13.000000000 +1000
+++ ./setfiles/setfiles.c	2003-11-19 14:35:55.000000000 +1100
@@ -212,7 +212,7 @@ int find_stem_from_file(const char **buf
  * same order as in the specification file.
  * Sorting occurs based on hasMetaChars
  */
-static spec_t *spec;
+static spec_t *spec_arr;
 static int nspec;
 
 /*
@@ -270,15 +270,15 @@ static file_spec_t *file_spec_add(ino_t 
 
 			}
 
-			no_conflict = (strcmp(spec[fl->specind].context,spec[specind].context) == 0);
+			no_conflict = (strcmp(spec_arr[fl->specind].context,spec_arr[specind].context) == 0);
 			if (no_conflict)
 				return fl;
 
 			fprintf(stderr,
 				"%s:  conflicting specifications for %s and %s, using %s.\n",
 				progname, file, fl->file,
-				((specind > fl->specind) ? spec[specind].
-				 context : spec[fl->specind].context));
+				((specind > fl->specind) ? spec_arr[specind].
+				 context : spec_arr[fl->specind].context));
 			fl->specind =
 			    (specind >
 			     fl->specind) ? specind : fl->specind;
@@ -403,23 +403,23 @@ int match(const char *name, struct stat 
 	 */
 	for (i = nspec - 1; i >= 0; i--)
 	{
-		if(spec[i].stem_id == -1 || spec[i].stem_id == file_stem)
+		if(spec_arr[i].stem_id == -1 || spec_arr[i].stem_id == file_stem)
 		{
-			if(spec[i].stem_id == -1)
-				ret = regexec(&spec[i].regex, name, 0, NULL, 0);
+			if(spec_arr[i].stem_id == -1)
+				ret = regexec(&spec_arr[i].regex, name, 0, NULL, 0);
 			else
-				ret = regexec(&spec[i].regex, buf, 0, NULL, 0);
+				ret = regexec(&spec_arr[i].regex, buf, 0, NULL, 0);
 			if (ret == 0 &&
-		    	(!spec[i].mode
-		     	|| (sb->st_mode & S_IFMT) == spec[i].mode)) break;
+		    	(!spec_arr[i].mode
+		     	|| (sb->st_mode & S_IFMT) == spec_arr[i].mode)) break;
 			if (ret) {
 				if (ret == REG_NOMATCH)
 					continue;
-				regerror(ret, &spec[i].regex, errbuf,
+				regerror(ret, &spec_arr[i].regex, errbuf,
 				 	sizeof errbuf);
 				fprintf(stderr,
 					"%s:  unable to match %s against %s:  %s\n",
-					progname, name, spec[i].regex_str,
+					progname, name, spec_arr[i].regex_str,
 					errbuf);
 				return -1;
 			}
@@ -430,7 +430,7 @@ int match(const char *name, struct stat 
 		/* No matching specification. */
 		return -1;
 
-	spec[i].matches++;
+	spec_arr[i].matches++;
 
 	return i;
 }
@@ -439,8 +439,8 @@ int match(const char *name, struct stat 
 int spec_compare(const void* specA, const void* specB)
 {
 	return(
-		((struct spec *)specB)->hasMetaChars -
-		((struct spec *)specA)->hasMetaChars
+		((const struct spec *)specB)->hasMetaChars -
+		((const struct spec *)specA)->hasMetaChars
 		); 
 }
 
@@ -456,20 +456,20 @@ int nodups_specs()
 	struct spec *curr_spec;
 
 	for (ii = 0; ii < nspec; ii++) {
-		curr_spec = &spec[ii];
+		curr_spec = &spec_arr[ii];
 		for (jj = ii + 1; jj < nspec; jj++) { 
 				/* Check if same RE string */
-			if ((!strcmp(spec[jj].regex_str, curr_spec->regex_str))
+			if ((!strcmp(spec_arr[jj].regex_str, curr_spec->regex_str))
 									&&
-				(!spec[jj].mode || !curr_spec->mode 
-				 || spec[jj].mode == curr_spec->mode)) {
+				(!spec_arr[jj].mode || !curr_spec->mode 
+				 || spec_arr[jj].mode == curr_spec->mode)) {
 				/* Same RE string found */
-				if (strcmp(spec[jj].context, curr_spec->context)) {
+				if (strcmp(spec_arr[jj].context, curr_spec->context)) {
 					/* If different contexts, give warning */
 					fprintf(stderr,
 					"ERROR: Multiple different specifications for %s  (%s and %s).\n",
 						curr_spec->regex_str, 
-						spec[jj].context,
+						spec_arr[jj].context,
 						curr_spec->context);
 				}
 				else {
@@ -533,7 +533,7 @@ void spec_hasMetaChars(struct spec *spec
 			case '{':
 				spec->hasMetaChars = 1;
 				return;
-			case '\\':		// skip the next character
+			case '\\':		/* skip the next character */
 				c++;
 				break;
 			default:
@@ -553,7 +553,7 @@ void spec_hasMetaChars(struct spec *spec
  * the directory traversal.
  */
 static int apply_spec(const char *file,
-		      const struct stat *sb, int flag, struct FTW *s)
+		      const struct stat *sb_unused, int flag, struct FTW *s_unused)
 {
 	const char *my_file;
 	file_spec_t *fl;
@@ -596,14 +596,14 @@ static int apply_spec(const char *file,
 	}
 
 	if (debug) {
-		if (spec[i].type_str) {
+		if (spec_arr[i].type_str) {
 			printf("%s:  %s matched by (%s,%s,%s)\n", progname,
-			       my_file, spec[i].regex_str,
-			       spec[i].type_str, spec[i].context);
+			       my_file, spec_arr[i].regex_str,
+			       spec_arr[i].type_str, spec_arr[i].context);
 		} else {
 			printf("%s:  %s matched by (%s,%s)\n", progname,
-			       my_file, spec[i].regex_str,
-			       spec[i].context);
+			       my_file, spec_arr[i].regex_str,
+			       spec_arr[i].context);
 		}
 	}
 
@@ -626,15 +626,15 @@ static int apply_spec(const char *file,
 	 * <<none>> or the file is already labeled according to the 
 	 * specification.
 	 */
-	if ((strcmp(spec[i].context, "<<none>>") == 0) || 
-	    (strcmp(context,spec[i].context) == 0)) {
+	if ((strcmp(spec_arr[i].context, "<<none>>") == 0) || 
+	    (strcmp(context,spec_arr[i].context) == 0)) {
 		freecon(context);
 		return 0;
 	}
 
 	if (verbose) {
 		printf("%s:  relabeling %s from %s to %s\n", progname,
-		       my_file, context, spec[i].context);
+		       my_file, context, spec_arr[i].context);
 	}
 
 	freecon(context);
@@ -648,11 +648,11 @@ static int apply_spec(const char *file,
 	/*
 	 * Relabel the file to the specified context.
 	 */
-	ret = lsetfilecon(my_file, spec[i].context);
+	ret = lsetfilecon(my_file, spec_arr[i].context);
 	if (ret) {
 		perror(my_file);
 		fprintf(stderr, "%s:  unable to relabel %s to %s\n",
-			progname, my_file, spec[i].context);
+			progname, my_file, spec_arr[i].context);
 		return 1;
 	}
 
@@ -680,7 +680,7 @@ void set_rootpath(const char *arg)
 int main(int argc, char **argv)
 {
 	FILE *fp;
-	char buf[255 + 1], *buf_p;
+	char line_buf[255 + 1], *buf_p;
 	char *regex, *type, *context;
 	char *anchored_regex;
 	int opt, items, len, lineno, pass, regerr, i;
@@ -754,30 +754,30 @@ int main(int argc, char **argv)
 	for (pass = 0; pass < 2; pass++) {
 		lineno = 0;
 		nspec = 0;
-		while (fgets(buf, sizeof buf, fp)) {
+		while (fgets(line_buf, sizeof line_buf, fp)) {
 			lineno++;
-			len = strlen(buf);
-			if (buf[len - 1] != '\n') {
+			len = strlen(line_buf);
+			if (line_buf[len - 1] != '\n') {
 				fprintf(stderr,
 					"%s:  no newline on line number %d (only read %s)\n",
-					argv[0], lineno, buf);
+					argv[0], lineno, line_buf);
 				inc_err();
 				continue;
 			}
-			buf[len - 1] = 0;
-			buf_p = buf;
+			line_buf[len - 1] = 0;
+			buf_p = line_buf;
 			while (isspace(*buf_p))
 				buf_p++;
 			/* Skip comment lines and empty lines. */
 			if (*buf_p == '#' || *buf_p == 0)
 				continue;
 			items =
-			    sscanf(buf, "%as %as %as", &regex, &type,
+			    sscanf(line_buf, "%as %as %as", &regex, &type,
 				   &context);
 			if (items < 2) {
 				fprintf(stderr,
 					"%s:  line number %d is missing fields (only read %s)\n",
-					argv[0], lineno, buf);
+					argv[0], lineno, line_buf);
 				inc_err();
 				if (items == 1)
 					free(regex);
@@ -791,12 +791,12 @@ int main(int argc, char **argv)
 
 			if (pass == 1) {
 				/* On the second pass, compile and store the specification in spec. */
-				const char *buf = regex;
-				spec[nspec].stem_id = find_stem_from_spec(&buf);
-				spec[nspec].regex_str = regex;
+				const char *reg_buf = regex;
+				spec_arr[nspec].stem_id = find_stem_from_spec(&reg_buf);
+				spec_arr[nspec].regex_str = regex;
 
 				/* Anchor the regular expression. */
-				len = strlen(buf);
+				len = strlen(reg_buf);
 				anchored_regex = malloc(len + 3);
 				if (!anchored_regex) {
 					fprintf(stderr,
@@ -804,16 +804,16 @@ int main(int argc, char **argv)
 						argv[0], lineno);
 					exit(1);
 				}
-				sprintf(anchored_regex, "^%s$", buf);
+				sprintf(anchored_regex, "^%s$", reg_buf);
 
 				/* Compile the regular expression. */
 				regerr =
-				    regcomp(&spec[nspec].regex,
+				    regcomp(&spec_arr[nspec].regex,
 					    anchored_regex,
 					    REG_EXTENDED | REG_NOSUB);
 				if (regerr < 0) {
 					regerror(regerr,
-						 &spec[nspec].regex,
+						 &spec_arr[nspec].regex,
 						 errbuf, sizeof errbuf);
 					fprintf(stderr,
 						"%s:  unable to compile regular expression %s on line number %d:  %s\n",
@@ -824,8 +824,8 @@ int main(int argc, char **argv)
 				free(anchored_regex);
 
 				/* Convert the type string to a mode format */
-				spec[nspec].type_str = type;
-				spec[nspec].mode = 0;
+				spec_arr[nspec].type_str = type;
+				spec_arr[nspec].mode = 0;
 				if (!type)
 					goto skip_type;
 				len = strlen(type);
@@ -838,25 +838,25 @@ int main(int argc, char **argv)
 				}
 				switch (type[1]) {
 				case 'b':
-					spec[nspec].mode = S_IFBLK;
+					spec_arr[nspec].mode = S_IFBLK;
 					break;
 				case 'c':
-					spec[nspec].mode = S_IFCHR;
+					spec_arr[nspec].mode = S_IFCHR;
 					break;
 				case 'd':
-					spec[nspec].mode = S_IFDIR;
+					spec_arr[nspec].mode = S_IFDIR;
 					break;
 				case 'p':
-					spec[nspec].mode = S_IFIFO;
+					spec_arr[nspec].mode = S_IFIFO;
 					break;
 				case 'l':
-					spec[nspec].mode = S_IFLNK;
+					spec_arr[nspec].mode = S_IFLNK;
 					break;
 				case 's':
-					spec[nspec].mode = S_IFSOCK;
+					spec_arr[nspec].mode = S_IFSOCK;
 					break;
 				case '-':
-					spec[nspec].mode = S_IFREG;
+					spec_arr[nspec].mode = S_IFREG;
 					break;
 				default:
 					fprintf(stderr,
@@ -867,7 +867,7 @@ int main(int argc, char **argv)
 
 			      skip_type:
 
-				spec[nspec].context = context;
+				spec_arr[nspec].context = context;
 
 				if (strcmp(context, "<<none>>")) {
 					if (security_check_context(context) < 0) {
@@ -881,7 +881,7 @@ int main(int argc, char **argv)
 
 				/* Determine if specification has 
 				 * any meta characters in the RE */
-				spec_hasMetaChars(&spec[nspec]);
+				spec_hasMetaChars(&spec_arr[nspec]);
 			}
 
 			nspec++;
@@ -901,21 +901,21 @@ int main(int argc, char **argv)
 			       nspec);
 			if (nspec == 0)
 				exit(0);
-			if ((spec = malloc(sizeof(spec_t) * nspec)) ==
+			if ((spec_arr = malloc(sizeof(spec_t) * nspec)) ==
 			    NULL) {
 				fprintf(stderr,
 					"%s:  insufficient memory for specifications\n",
 					argv[0]);
 				exit(1);
 			}
-			bzero(spec, sizeof(spec_t) * nspec);
+			bzero(spec_arr, sizeof(spec_t) * nspec);
 			rewind(fp);
 		}
 	}
 	fclose(fp);
 
 	/* Sort the specifications with most general first */
-	qsort(spec, nspec, sizeof(struct spec), spec_compare);
+	qsort(spec_arr, nspec, sizeof(struct spec), spec_compare);
 
 	/* Verify no exact duplicates */
 	if (nodups_specs() != 0) {
@@ -988,17 +988,17 @@ int main(int argc, char **argv)
 
 	if (warn_no_match) {
 		for (i = 0; i < nspec; i++) {
-			if (spec[i].matches == 0) {
-				if (spec[i].type_str) {
+			if (spec_arr[i].matches == 0) {
+				if (spec_arr[i].type_str) {
 					printf
 						("%s:  Warning!  No matches for (%s, %s, %s)\n",
-						 argv[0], spec[i].regex_str,
-						 spec[i].type_str, spec[i].context);
+						 argv[0], spec_arr[i].regex_str,
+						 spec_arr[i].type_str, spec_arr[i].context);
 				} else {
 					printf
 						("%s:  Warning!  No matches for (%s, %s)\n",
-						 argv[0], spec[i].regex_str,
-						 spec[i].context);
+						 argv[0], spec_arr[i].regex_str,
+						 spec_arr[i].context);
 				}
 			}
 		}

--Boundary-00=_jYuu/xqsKlYTVk3--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
