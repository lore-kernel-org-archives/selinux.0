Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99HIXVV022914
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 13:18:33 -0400
Received: from M4.sparta.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k99HHGS2000901
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 17:17:16 GMT
Received: from Beta5.sparta.com (beta5.sparta.com [157.185.63.21])
	by M4.sparta.com (8.13.5/8.13.5) with ESMTP id k99HIXuG027416
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 12:18:33 -0500
Received: from nemo.columbia.ads.sparta.com (nemo.columbia.sparta.com [157.185.80.75])
	by Beta5.sparta.com (8.12.11/8.13.1) with ESMTP id k99HIXY9000418
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 12:18:33 -0500
Mime-Version: 1.0 (Apple Message framework v752.3)
To: SE Linux <selinux@tycho.nsa.gov>
Message-Id: <E0ADF7C3-6BA3-40B0-9CD9-B24339135AF4@sparta.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-8--428998275
From: Todd Miller <Todd.Miller@sparta.com>
Subject: PATCH: fix memory leaks in matchpathcon.c
Date: Mon, 9 Oct 2006 13:18:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-8--428998275
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

The process_line() function does not clean up correctly on early  
return in all cases.
This diff does two things:

  1) replaces usage of the non-standard %as scanf() format (which  
conflicts with C99)
       with simple strtok().  This does mean that line_buf is  
modified but this variable is
       only used as an argument to process_line() and is then freed.

  2) adds a finish: label and ret variable that holds the return  
value.  Instead of
       returning early we just goto finish and let it clean things up  
as needed.  This
       does assume that free(NULL) is valid but that as been the case  
since C89.

As far as the memory leaks go, #2 is the important part.  I needed #1  
for our
port of libselinux to FreeBSD and Darwin.

  - todd


--Apple-Mail-8--428998275
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=matchpathcon.c.diff
Content-Disposition: attachment;
	filename=matchpathcon.c.diff

--- matchpathcon.c.DIST	2006-10-09 11:41:38.000000000 -0400
+++ matchpathcon.c	2006-10-09 11:44:28.000000000 -0400
@@ -443,11 +443,13 @@
 static int process_line(const char *path, const char *prefix, char *line_buf,
 			int pass, unsigned lineno)
 {
-	int items, len, regerr;
+	int items, len, regerr, ret;
 	char *buf_p;
 	char *regex, *type, *context;
 	const char *reg_buf;
 	char *anchored_regex;
+
+	ret = 0;
 	len = strlen(line_buf);
 	if (line_buf[len - 1] == '\n')
 		line_buf[len - 1] = 0;
@@ -457,26 +459,35 @@
 	/* Skip comment lines and empty lines. */
 	if (*buf_p == '#' || *buf_p == 0)
 		return 0;
-	items = sscanf(line_buf, "%as %as %as", &regex, &type, &context);
+
+	regex = strtok(buf_p, " \t");
+	type = strtok(NULL, " \t");
+	context = strtok(NULL, " \t");
+	items = !!regex + !!type + !!context;
 	if (items < 2) {
 		myprintf("%s:  line %d is missing fields, skipping\n", path,
 			 lineno);
 		return 0;
 	} else if (items == 2) {
 		/* The type field is optional. */
-		free(context);
 		context = type;
-		type = 0;
+		type = NULL;
+	}
+
+	regex = strdup(regex);
+	if (type != NULL)
+		type = strdup(type);
+	context = strdup(context);
+	if (!!regex + !!type + !!context != items) {
+		ret = -1;
+		goto finish;
 	}
 
 	reg_buf = regex;
 	len = get_stem_from_spec(reg_buf);
 	if (len && prefix && strncmp(prefix, regex, len)) {
 		/* Stem of regex does not match requested prefix, discard. */
-		free(regex);
-		free(type);
-		free(context);
-		return 0;
+		goto finish;
 	}
 
 	if (pass == 1) {
@@ -488,8 +499,10 @@
 		/* Anchor the regular expression. */
 		len = strlen(reg_buf);
 		cp = anchored_regex = malloc(len + 3);
-		if (!anchored_regex)
-			return -1;
+		if (!anchored_regex) {
+			ret = -1;
+			goto finish;
+		}
 		/* Create ^...$ regexp.  */
 		*cp++ = '^';
 		cp = mempcpy(cp, reg_buf, len);
@@ -515,7 +528,7 @@
 				 path, lineno, anchored_regex,
 				 (errbuf ? errbuf : "out of memory"));
 			free(anchored_regex);
-			return 0;
+			goto finish;
 		}
 		free(anchored_regex);
 
@@ -528,7 +541,7 @@
 		if (type[0] != '-' || len != 2) {
 			myprintf("%s:  line %d has invalid file type %s\n",
 				 path, lineno, type);
-			return 0;
+			goto finish;
 		}
 		switch (type[1]) {
 		case 'b':
@@ -555,7 +568,7 @@
 		default:
 			myprintf("%s:  line %d has invalid file type %s\n",
 				 path, lineno, type);
-			return 0;
+			goto finish;
 		}
 
 	      skip_type:
@@ -564,11 +577,11 @@
 				if (myinvalidcon) {
 					/* Old-style validation of context. */
 					if (myinvalidcon(path, lineno, context))
-						return 0;
+						goto finish;
 				} else {
 					/* New canonicalization of context. */
 					if (mycanoncon(path, lineno, &context))
-						return 0;
+						goto finish;
 				}
 				spec_arr[nspec].context_valid = 1;
 			}
@@ -579,16 +592,19 @@
 		/* Determine if specification has 
 		 * any meta characters in the RE */
 		spec_hasMetaChars(&spec_arr[nspec]);
+
+		/* Prevent stored strings from being freed */
+		regex = NULL;
+		type = NULL;
+		context = NULL;
 	}
 
 	nspec++;
-	if (pass == 0) {
-		free(regex);
-		if (type)
-			free(type);
-		free(context);
-	}
-	return 0;
+finish:
+	free(regex);
+	free(type);
+	free(context);
+	return ret;
 }
 
 int matchpathcon_init_prefix(const char *path, const char *prefix)

--Apple-Mail-8--428998275--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
