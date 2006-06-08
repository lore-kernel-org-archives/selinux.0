Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k58Ju5hA007427
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 15:56:05 -0400
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k58Ju4rG014372
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 19:56:04 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k58Ju4pp004091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 15:56:04 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k58Ju3Bw231452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 15:56:03 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k58Ju2tP002931
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 15:56:02 -0400
Received: from sergelap.hallyn.com (sig-9-65-96-38.mts.ibm.com [9.65.96.38])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k58Ju2Lx002908
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 15:56:02 -0400
Date: Thu, 8 Jun 2006 14:55:13 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 2/3] libsemanage: deref and double close of fp
Message-ID: <20060608195513.GB29665@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trivial patch to prevent double-closing of a file pointer.

thanks,
-serge

--- libsemanage/src/database_policydb.c.orig	2006-06-08 13:48:30.000000000 -0500
+++ libsemanage/src/database_policydb.c	2006-06-08 13:51:44.000000000 -0500
@@ -156,6 +156,7 @@ static int dbase_policydb_cache(
 
 		sepol_policy_file_free(pf);
 		fclose(fp);
+		fp = NULL;
 	}
 
 	/* Update cache serial */

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
