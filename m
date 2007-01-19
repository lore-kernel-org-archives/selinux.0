Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0JKoZuV004908
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 15:50:35 -0500
Received: from e32.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0JKpTU1008570
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 20:51:29 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l0JAo1xq003074
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 05:50:01 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0JKpRHa510836
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 13:51:28 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0JKpRdp011267
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 13:51:27 -0700
Received: from [127.0.0.1] (pendarric.austin.ibm.com [9.41.46.140])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l0JKpNw9010986
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 13:51:27 -0700
Message-ID: <45B086A1.30008@us.ibm.com>
Date: Fri, 19 Jan 2007 02:51:45 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: [PATCH] Update newrole authors and provide use examples in manpage
Content-Type: multipart/mixed;
 boundary="------------090702000608080005020102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090702000608080005020102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Due to lack of clear documentation, the below patch adds an examples 
section to the newrole.1 manpage. These examples include changing role, 
and level (sensitivty only, and both sensitivity and clearance).

This patch also updates the authors sections of the newrole.1 manpage 
and the newrole.c source file, listing them in alphabetical order by 
last name.

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>

---


--------------090702000608080005020102
Content-Type: text/x-diff;
 name="newrole-man_author.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newrole-man_author.patch"

diff -Naur policycoreutils-1.33.12.orig/newrole/newrole.1 policycoreutils-1.33.12/newrole/newrole.1
--- policycoreutils-1.33.12.orig/newrole/newrole.1	2007-01-11 13:01:39.000000000 -0600
+++ policycoreutils-1.33.12/newrole/newrole.1	2007-01-12 10:15:14.000000000 -0600
@@ -57,16 +57,45 @@
 .B --version
 shows the current version of newrole
 .PP
+.SH EXAMPLE
+.br
+Changing role:
+   # id -Z
+   staff_u:staff_r:staff_t:SystemLow-SystemHigh
+   # newrole -r sysadm_r
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:SystemLow-SystemHigh
+
+Changing sensitivity only:
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
+   # newrole -l Secret
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Secret-SystemHigh
+
+.PP
+Changing sensitivity and clearance:
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
+   # newrole -l Secret-Secret
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Secret
+
 .SH FILES
 /etc/passwd - user account information
 .br
 /etc/shadow - encrypted passwords and age information
+.br
+/etc/selinux/<policy>/contexts/default_type - default types for roles
+.br
 .SH SEE ALSO
-.B su
-(1),
-.B runas
+.B runcon
 (1)
 .SH AUTHORS
 .nf
-Tim Fraser (tfraser@tislabs.com) 
-Anthony Colatrella (amcolat@epoch.ncsc.mil)
+Anthony Colatrella
+Tim Fraser
+Steve Grubb <sgrubb@redhat.com>
+Darrel Goeddel <DGoeddel@trustedcs.com>
+Michael Thompson <mcthomps@us.ibm.com>
+Dan Walsh <dwalsh@redhat.com>
diff -Naur policycoreutils-1.33.12.orig/newrole/newrole.c policycoreutils-1.33.12/newrole/newrole.c
--- policycoreutils-1.33.12.orig/newrole/newrole.c	2007-01-11 13:01:39.000000000 -0600
+++ policycoreutils-1.33.12/newrole/newrole.c	2007-01-14 13:56:41.000000000 -0600
@@ -36,8 +36,14 @@
  * setuid root, so that it can read the shadow passwd file.
  * 
  *
- * Authors:  Tim Fraser , 
- *           Anthony Colatrella <amcolat@epoch.ncsc.mil>
+ * Authors:
+ *      Anthony Colatrella <amcolat@epoch.ncsc.mil>
+ *	Tim Fraser
+ *	Steve Grubb <sgrubb@redhat.com>
+ *	Darrel Goeddel <DGoeddel@trustedcs.com>
+ *	Michael Thompson <mcthomps@us.ibm.com>
+ *	Dan Walsh <dwalsh@redhat.com>
+ *
  * Various bug fixes by Stephen Smalley <sds@epoch.ncsc.mil>
  *
  *************************************************************************/

--------------090702000608080005020102--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
