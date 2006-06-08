Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k58JtxLg007410
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 15:55:59 -0400
Received: from e36.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k58JtvrG014360
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 19:55:58 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k58Jtv0S031278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 15:55:57 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k58Jtv5u230538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 13:55:57 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k58JtvCF014450
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 13:55:57 -0600
Received: from sergelap.hallyn.com (sig-9-65-96-38.mts.ibm.com [9.65.96.38])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k58Jtusv014420
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 13:55:57 -0600
Date: Thu, 8 Jun 2006 14:55:08 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 1/3] libsemanage: database_file.c uninit'd deref
Message-ID: <20060608195508.GA29665@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Actually a short set of patches for all of libsemanage.

This first one addresses a potential deref of uninitialized
parse_info on the error path.

thanks,
-serge

--- libsemanage/src/database_file.c.orig	2006-06-06 21:15:47.000000000 -0500
+++ libsemanage/src/database_file.c	2006-06-06 21:16:25.000000000 -0500
@@ -69,7 +69,7 @@ static int dbase_file_cache(
 	record_t* process_record = NULL;
 	int pstatus = STATUS_SUCCESS;
 
-	parse_info_t* parse_info;
+	parse_info_t* parse_info = NULL;
 	char* fname = NULL;
 
 	/* Already cached */
@@ -127,8 +127,10 @@ static int dbase_file_cache(
 	err:
 	ERR(handle, "could not cache file database");
 	rtable->free(process_record);
-	parse_close(parse_info);
-	parse_release(parse_info);
+	if (parse_info) {
+		parse_close(parse_info);
+		parse_release(parse_info);
+	}
 	dbase_llist_drop_cache(&dbase->llist);
 	free(fname);
 	return STATUS_ERR;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
