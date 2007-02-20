Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KFC6q2028459
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 10:12:06 -0500
Received: from web51512.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1KFDM3f008207
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 15:13:22 GMT
Date: Tue, 20 Feb 2007 07:13:01 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Another libselinux patch fixing memory leaks
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-775929536-1171984381=:80462"
Message-ID: <475744.80462.qm@web51512.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-775929536-1171984381=:80462
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

I was running restorecond through valgrind to figure out why it consumes so much
memory. It seemed to point to matchpathcon as a possible leak. I looked at the
functions and saw that there are some potentially uninitialized pointers that
could get freed when jumping to finish and a couple allocations that appear to be
leaked.

Patch is attached.

-Steve


 
____________________________________________________________________________________
Never Miss an Email
Stay connected with Yahoo! Mail on your mobile.  Get started!
http://mobile.yahoo.com/services?promote=mail
--0-775929536-1171984381=:80462
Content-Type: text/x-patch; name="libselinux-2.0.0-leaks.patch"
Content-Description: 3536998516-libselinux-2.0.0-leaks.patch
Content-Disposition: inline; filename="libselinux-2.0.0-leaks.patch"

diff -urp libselinux-2.0.0.orig/src/matchpathcon.c libselinux-2.0.0/src/matchpathcon.c
--- libselinux-2.0.0.orig/src/matchpathcon.c	2007-02-19 20:57:53.000000000 -0500
+++ libselinux-2.0.0/src/matchpathcon.c	2007-02-19 21:11:11.000000000 -0500
@@ -445,9 +445,9 @@ static int process_line(const char *path
 {
 	int items, len, regerr, ret;
 	char *buf_p, *ptr;
-	char *regex, *type, *context;
+	char *regex=NULL, *type=NULL, *context=NULL;
 	const char *reg_buf;
-	char *anchored_regex;
+	char *anchored_regex = NULL;
 
 	ret = 0;
 	len = strlen(line_buf);
@@ -543,9 +543,12 @@ static int process_line(const char *path
 				 path, lineno, anchored_regex,
 				 (errbuf ? errbuf : "out of memory"));
 			free(anchored_regex);
+			anchored_regex = NULL;
+			free(errbuf);
 			goto finish;
 		}
 		free(anchored_regex);
+		anchored_regex = NULL;
 
 		/* Convert the type string to a mode format */
 		spec_arr[nspec].type_str = type;
@@ -718,6 +721,7 @@ int matchpathcon_init_prefix(const char 
 		}
 	}
 	free(line_buf);
+	line_buf = NULL;
 
 	/* Move exact pathname specifications to the end. */
 	spec_copy = malloc(sizeof(spec_t) * nspec);
@@ -740,6 +744,7 @@ int matchpathcon_init_prefix(const char 
 	status = 0;
       finish:
 	fclose(fp);
+	free(line_buf);
 	if (spec_arr != spec_copy)
 		free(spec_arr);
 	if (homedirfp)

--0-775929536-1171984381=:80462--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
