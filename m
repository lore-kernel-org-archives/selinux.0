Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MGfMOb021057
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:41:23 -0400 (EDT)
Received: from e2.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7MGUFo5023569
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:30:16 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7MGVI4N010267
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:31:18 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7MGVIRr213934
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:31:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7MGVIGs002176
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:31:18 -0400
Received: from sergelap.austin.ibm.com (sig-9-65-117-45.mts.ibm.com [9.65.117.45])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j7MGVHdV002125
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:31:17 -0400
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.3/8.13.1) with ESMTP id j7MBk21R025102
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 06:46:02 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7MBk2In025101
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 06:46:02 -0500
Date: Mon, 22 Aug 2005 06:46:02 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage: fix resource leaks
Message-ID: <20050822114602.GC24949@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the last of three patches against libsemanage.  Just needed
to hit these on my way to checking policycoreutils.

The following fixes a bug found by Coverity in libsemanage:

	In both semod_get_active_modules_list() and
	semod_get_sandbox_modules_list() it is possible to return
	-1 after names and versions have been defined (if asprintf
	fails).  In addition it is obviously possible for names to be
	malloced and the versions malloc to fail.

Index: src/module_direct_api.c
===================================================================
--- src.orig/module_direct_api.c
+++ src/module_direct_api.c
@@ -260,6 +260,10 @@ int semod_direct_list_modules(char **res
         char **names, **versions;
         *results = NULL;
         if ((retval = semod_get_active_modules_list (&names, &versions, &len)) < 0) {
+		if (names)
+			free(names);
+		if (versions)
+			free(versions);
                 return retval;
         }
         return list_modules_common (results, names, versions, len);
@@ -278,6 +282,10 @@ int semod_direct_list_sandbox(char *sand
         *results = NULL;
         if ((retval = semod_get_sandbox_modules_list (sandbox,
                                                       &names, &versions, &len)) < 0) {
+		if (names)
+			free(names);
+		if (versions)
+			free(versions);
                 return retval;
         }
         return list_modules_common (results, names, versions, len);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
