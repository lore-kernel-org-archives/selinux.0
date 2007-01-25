Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0Q00Y6c016078
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 19:00:34 -0500
Received: from tex.courtesan.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0Q018sh020562
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 00:01:08 GMT
Received: from tex.courtesan.com (smmsp@localhost [127.0.0.1])
	by tex.courtesan.com (8.13.8/8.13.8) with ESMTP id l0PNxM5P028213
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 18:59:22 -0500 (EST)
Date: Thu, 25 Jan 2007 18:59:22 -0500 (EST)
Message-Id: <200701252359.l0PNxMjc011991@tex.courtesan.com>
From: "Todd C. Miller" <Todd.Miller@sparta.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: PATCH: libselinux matchpathcon() eliminate %as scanf format
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a patch I sent in last year but forgot to split up as
requested; it still applies to the recently-released selinux-1.34.0.

THe patch replaces usage of the non-standard %as scanf() format
(which conflicts with C99) with strtok_r().  This does mean that
line_buf is modified but this variable is only used as an argument
to process_line() and is freed thereafter.

I made this change as part of the port of libselinux to SEBSD and
SEDarwin.

 - todd

--- matchpathcon.c	2007-01-25 14:19:39.000000000 -0500
+++ matchpathcon.c	2007-01-25 14:21:32.000000000 -0500
@@ -444,7 +444,7 @@
 			int pass, unsigned lineno)
 {
 	int items, len, regerr, ret;
-	char *buf_p;
+	char *buf_p, *ptr;
 	char *regex, *type, *context;
 	const char *reg_buf;
 	char *anchored_regex;
@@ -459,7 +459,11 @@
 	/* Skip comment lines and empty lines. */
 	if (*buf_p == '#' || *buf_p == 0)
 		return 0;
-	items = sscanf(line_buf, "%as %as %as", &regex, &type, &context);
+
+	regex = strtok_r(buf_p, " \t", &ptr);
+	type = strtok_r(NULL, " \t", &ptr);
+	context = strtok_r(NULL, " \t", &ptr);
+	items = !!regex + !!type + !!context;
 	if (items < 2) {
 		myprintf("%s:  line %d is missing fields, skipping\n", path,
 			 lineno);
@@ -470,6 +474,15 @@
 		type = NULL;
 	}
 
+	regex = strdup(regex);
+	if (type != NULL)
+		type = strdup(type);
+	context = strdup(context);
+	if (!!regex + !!type + !!context != items) {
+		ret = -1;
+		goto finish;
+	}
+
 	reg_buf = regex;
 	len = get_stem_from_spec(reg_buf);
 	if (len && prefix && strncmp(prefix, regex, len)) {

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
