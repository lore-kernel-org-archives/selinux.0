Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8GHRV8d019285
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 13:27:31 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8GHSsjq001440
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 17:28:55 GMT
Message-ID: <4AB11FFD.3060101@redhat.com>
Date: Wed, 16 Sep 2009 13:27:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libsemanage patch
References: <C6CBF8CF.AA709%csellers@tresys.com> <4AB102CE.3070102@manicmethod.com>
In-Reply-To: <4AB102CE.3070102@manicmethod.com>
Content-Type: multipart/mixed;
 boundary="------------090409060506080902070007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090409060506080902070007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Updated patch.  Need check in two places.

--------------090409060506080902070007
Content-Type: text/plain;
 name="libsemanage-genhomedir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage-genhomedir.patch"

--- nsalibsemanage/src/genhomedircon.c	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.37/src/genhomedircon.c	2009-09-16 13:25:43.000000000 -0400
@@ -304,6 +304,10 @@
 			continue;
 		if (!semanage_list_find(shells, pwbuf->pw_shell))
 			continue;
+		int len = strlen(pwbuf->pw_dir) -1;
+		for(; len > 0 && pwbuf->pw_dir[len] == '/'; len--) {
+			pwbuf->pw_dir[len] = '\0';
+		}
 		if (strcmp(pwbuf->pw_dir, "/") == 0)
 			continue;
 		if (semanage_str_count(pwbuf->pw_dir, '/') <= 1)
@@ -788,6 +792,11 @@
 			continue;
 		}
 
+		int len = strlen(pwent->pw_dir) -1;
+		for(; len > 0 && pwent->pw_dir[len] == '/'; len--) {
+			pwent->pw_dir[len] = '\0';
+		}
+
 		if (strcmp(pwent->pw_dir, "/") == 0) {
 			/* don't relabel / genhomdircon checked to see if root
 			 * was the user and if so, set his home directory to

--------------090409060506080902070007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
