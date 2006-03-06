Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k26MFMdW013579
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 17:15:22 -0500
Received: from e35.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k26MFJuY027279
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 22:15:20 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k26MFLJw007220
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 17:15:21 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k26MCeTY184722
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 15:12:40 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k26MFLae015101
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 15:15:21 -0700
Received: from sergelap.hallyn.com (sig-9-65-85-1.mts.ibm.com [9.65.85.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k26MFKJY015076
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 15:15:20 -0700
Date: Mon, 6 Mar 2006 16:15:19 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: libsemanage/src/semanage_store.c:semanage_split_fc
Message-ID: <20060306221519.GA25033@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In semanage_split_fc(), linex 887 and 893, the file_con fd is not closed
on error.  Trivial patch follows.

-serge

Index: libsemanage/src/semanage_store.c
===================================================================
--- libsemanage.orig/src/semanage_store.c	2006-02-15 10:47:23.000000000 -0600
+++ libsemanage/src/semanage_store.c	2006-03-06 16:14:48.000000000 -0600
@@ -885,11 +885,13 @@ int semanage_split_fc(semanage_handle_t 
 	fc = open(semanage_path(SEMANAGE_TMP, SEMANAGE_FC), O_WRONLY | O_CREAT | O_TRUNC,  S_IRUSR | S_IWUSR);
 	if (!fc) {
 		ERR(sh, "Could not open %s for writing.", semanage_path(SEMANAGE_TMP, SEMANAGE_FC));
+		fclose(file_con);
 		return -1;
 	}
 	hd = open(semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL), O_WRONLY | O_CREAT | O_TRUNC,  S_IRUSR | S_IWUSR);
 	if (!hd) {
 		ERR(sh, "Could not open %s for writing.", semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
+		fclose(file_con);
 		close(fc);
 		return -1;
 	}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
