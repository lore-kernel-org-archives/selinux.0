Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4KH8FqN023648
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 13:08:15 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4KH8BlR019024
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 17:08:11 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4KH8EPE014788
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 13:08:14 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4KH8C3O010940
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 13:08:13 -0400
Received: from localhost.localdomain (vpn-10-93.bos.redhat.com [10.16.10.93])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4KH8BJb026888
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 13:08:12 -0400
Message-ID: <4A1438FE.2000207@redhat.com>
Date: Wed, 20 May 2009 13:08:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setfiles will only put out a "*" if > 1000 files are fixed.
Content-Type: multipart/mixed;
 boundary="------------060703010302050108020802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060703010302050108020802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

setfiles was always putting out a \n, even when not many files were 
being fixed. yum transactions were being desturbed by this.

--------------060703010302050108020802
Content-Type: text/plain;
 name="policycoreutils-setfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-setfiles.patch"

--- nsapolicycoreutils/setfiles/setfiles.c	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.62/setfiles/setfiles.c	2009-05-14 11:05:15.000000000 -0400
@@ -29,6 +29,8 @@
 static int mass_relabel;
 static int mass_relabel_errs;
 
+#define STAR_COUNT 1000
+
 static FILE *outfile = NULL;
 static int force = 0;
 #define STAT_BLOCK_SIZE 1
@@ -444,11 +446,11 @@
 
 	if (progress) {
 		count++;
-		if (count % 80000 == 0) {
+		if (count % (80 * STAR_COUNT) == 0) {
 			fprintf(stdout, "\n");
 			fflush(stdout);
 		}
-		if (count % 1000 == 0) {
+		if (count % STAR_COUNT == 0) {
 			fprintf(stdout, "*");
 			fflush(stdout);
 		}
@@ -1017,7 +1019,7 @@
 		free(excludeArray[i].directory);
 	}
 
-       if (progress)
+       if (progress && count >= STAR_COUNT)
                printf("\n");
 	exit(errors);
 }

--------------060703010302050108020802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
