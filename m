Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1OJFbNv022796
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 14:15:37 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1OJFKGA011731
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 19:15:21 GMT
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o1OJFZP1011430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 14:15:35 -0500
Received: from localhost.localdomain (vpn-11-226.rdu.redhat.com [10.11.11.226])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o1OJFV7d002703
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 14:15:34 -0500
Message-ID: <4B857AD3.4090701@redhat.com>
Date: Wed, 24 Feb 2010 14:15:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Fix memory leak on disabled selinux machines.
Content-Type: multipart/mixed;
 boundary="------------000501050706060804000907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000501050706060804000907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I think this patch originally came from Eric Paris and was updated by 
others but has not been adopted yet.  Not sure why.

Always free buf on exit.



--------------000501050706060804000907
Content-Type: text/plain;
 name="libselinux_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux_init.patch"

--- nsalibselinux/src/init.c	2009-07-14 11:16:03.000000000 -0400
+++ libselinux-2.0.90/src/init.c	2010-02-22 11:04:16.000000000 -0500
@@ -23,7 +23,7 @@
 static void init_selinuxmnt(void)
 {
 	char *buf=NULL, *p;
-	FILE *fp;
+	FILE *fp=NULL;
 	struct statfs sfbuf;
 	int rc;
 	size_t len;
@@ -57,16 +57,17 @@
 			break;
 		}
 	}
-	fclose(fp);
 
-	if (!exists)
-		return;
+	if (!exists) 
+		goto out;
+
+	fclose(fp);
 
 	/* At this point, the usual spot doesn't have an selinuxfs so
 	 * we look around for it */
 	fp = fopen("/proc/mounts", "r");
 	if (!fp)
-		return;
+		goto out;
 
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 	while ((num = getline(&buf, &len, fp)) != -1) {
@@ -90,7 +91,8 @@
 
       out:
 	free(buf);
-	fclose(fp);
+	if (fp)
+		fclose(fp);
 	return;
 }
 

--------------000501050706060804000907--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
