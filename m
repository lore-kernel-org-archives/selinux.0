Message-ID: <436C4343.8080604@cornell.edu>
Date: Sat, 05 Nov 2005 00:29:39 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SETSEBOOL ] Fix memory leak
Content-Type: multipart/mixed;
 boundary="------------060702060404030809040009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060702060404030809040009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix memory leak which I introduced... I don't like introducing bugs of 
any sort..



--------------060702060404030809040009
Content-Type: text/x-patch;
 name="setsebool.fix_leak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setsebool.fix_leak.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/policycoreutils/setsebool/setsebool.c new/policycoreutils/setsebool/setsebool.c
--- old/policycoreutils/setsebool/setsebool.c	2005-11-05 00:15:55.000000000 -0500
+++ new/policycoreutils/setsebool/setsebool.c	2005-11-05 00:23:34.000000000 -0500
@@ -220,13 +220,15 @@ int setbool(char **list, size_t start, s
 		i++;
 	}
 
+	for (i=0; i < boolcnt; i++)
+		free(vallist[i].name);
+	free(vallist);
 	return 0;
 				
 	err:
 	for (i=0; i < boolcnt; i++) 
-		if (vallist[i].name) free(vallist[i].name);
+		free(vallist[i].name);
 	free(vallist);
-
 	return -1;
 }
 

--------------060702060404030809040009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
