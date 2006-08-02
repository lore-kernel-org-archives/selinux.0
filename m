Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72HD236002864
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 13:13:02 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k72HCpa2021214
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 17:12:51 GMT
Subject: [PATCH 7/6] netfilter integration take 2: style fixes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 13:14:06 -0400
Message-Id: <1154538846.31522.177.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This applies on top of the previous patches, to fix style.  Also removed
a NULL check since semanage_path() can't return NULL.

 direct_api.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --exclude .svn -purN trunk/libsemanage/src/direct_api.c netfilter-integration/libsemanage/src/direct_api.c
--- trunk/libsemanage/src/direct_api.c	2006-08-02 13:05:25.058888750 -0400
+++ netfilter-integration/libsemanage/src/direct_api.c	2006-08-02 12:49:32.179337500 -0400
@@ -582,23 +582,22 @@ static int semanage_direct_commit(semana
 
 		/* Netfilter Contexts */
 		/* Sort the netfilter contexts. */
-		if (semanage_nc_sort
+		retval = semanage_nc_sort
 		    (sh, sepol_module_package_get_netfilter_contexts(base),
 		     sepol_module_package_get_netfilter_contexts_len(base),
-		     &sorted_nc_buffer, &sorted_nc_buffer_len) < 0) {
+		     &sorted_nc_buffer, &sorted_nc_buffer_len);
+
+		if (retval < 0)
 			goto cleanup;
-		}
 
 		/* Write the contexts to a single file.  The buffer returned by
 		 * the sort function has a trailing \0 character, which we do
 		 * NOT want to write out to disk, so we pass sorted_fc_buffer_len-1. */
 		ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_NC);
-		if (ofilename == NULL)
-			goto cleanup;
+		retval = write_file
+		    (sh, ofilename, sorted_nc_buffer, sorted_nc_buffer_len - 1);
 
-		if (write_file
-		    (sh, ofilename, sorted_nc_buffer,
-		     sorted_nc_buffer_len - 1) < 0)
+		if (retval < 0)
 			goto cleanup;
 
 		/* ==================== Policydb-backed ================ */


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
