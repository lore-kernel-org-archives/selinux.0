Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4K1HSI4007367
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 21:17:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4K1GotV019736
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 01:16:51 GMT
Received: from a.mx.rapturesecurity.com ([66.113.84.53])
        by jazzband.ncsc.mil  with ESMTP id h4K1GMal019550 for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 01:16:23 GMT
Subject: [PATCH] NON PAM Makefile newrole
From: Jack <jack@rapturesecurity.com>
Reply-To: jack@rapturesecurity.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-jvL5xPl9LA03xQIWeJ5J"
Message-Id: <1053393368.17891.32.camel@bubbles.eatflamingdeath.org>
Mime-Version: 1.0
Date: 19 May 2003 18:16:09 -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-jvL5xPl9LA03xQIWeJ5J
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Included is a patch to install newrole mode 4511 for NON-PAM installs,
needed for NON-ROOT newrole operation. 

Other than that, se-linux is working great with slackware 9.0, with a
"more involved" install procedure.

-- 
Jack <jack@rapturesecurity.com>
RaptureSecurity

--=-jvL5xPl9LA03xQIWeJ5J
Content-Disposition: attachment; filename=non-pam.newrole.patch
Content-Type: text/x-patch; name=non-pam.newrole.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -u newrole.orig/Makefile newrole/Makefile
--- newrole.orig/Makefile	2001-12-06 09:11:18.000000000 -0800
+++ newrole/Makefile	2003-05-19 17:25:10.000000000 -0700
@@ -42,13 +42,14 @@
 	$(CC) $(LDFLAGS) $(CFLAGS) -o newrole newrole.c $(LIBFLAGS)
 
 install : all
-	install -m 555 -o root -g root $(PROGS) $(DESTDIR)
 	install -m 644 -o root -g root newrole.1 $(MANDIR)/man1/
 	if [ -d /etc/pam.d ]; then \
+		install -m 555 -o root -g root $(PROGS) $(DESTDIR); \
 		rm -f /etc/pam.d/newrole; \
 		sed "/pam_rootok.so/d" /etc/pam.d/su > /etc/pam.d/newrole; \
-	fi;
-
+	else \
+		install -m 4511 -o root -g root $(PROGS) $(DESTDIR); \
+	fi; 
 clean:
 	rm -f $(PROGS) *.o
 
Only in newrole: newrole

--=-jvL5xPl9LA03xQIWeJ5J--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
