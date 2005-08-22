Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MH4IOb021387
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 13:04:18 -0400 (EDT)
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7MGsGuD000563
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:54:16 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7MGsCUn009463
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:54:12 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7MGsBPr205584
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:54:11 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7MGsBqF015909
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:54:11 -0400
Received: from sergelap.austin.ibm.com (sig-9-65-117-45.mts.ibm.com [9.65.117.45])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j7MGsB0b015884
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:54:11 -0400
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.3/8.13.1) with ESMTP id j7MC8t6t025716
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 07:08:56 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7MC8tG4025715
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 07:08:55 -0500
Date: Mon, 22 Aug 2005 07:08:55 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] policycoreutils: check lstat return value
Message-ID: <20050822120855.GC25231@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch addresses a potential bug found by Coverity.

I was going to ignore this one at first, but then thought that a
race condition could still cause problems.  The lstat return value
is not checked in sestatus.  This seems safe because it is only
called if lgetfilecon has already succeeded, however it seems
possible that a parent directory context or permission could be
changed between these two calls.

(these were the only two warnings on policycoreutils - now back
to libsepol :)

thanks,
-serge

Index: sestatus/sestatus.c
===================================================================
--- sestatus.orig/sestatus.c
+++ sestatus/sestatus.c
@@ -359,7 +359,12 @@ int main(int argc, char **argv) {
 			printf_tab(fc[i]);
 
 			/* check if this is a symlink */
-			lstat(fc[i],&m);
+			if (lstat(fc[i],&m)) {
+				printf("%s (could not check link status (%s)!)\n",
+						context, strerror(errno));
+				freecon(context);
+				continue;
+			}
 			if( S_ISLNK(m.st_mode) ) {
 				/* print link target context */
 				printf("%s -> ",context);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
