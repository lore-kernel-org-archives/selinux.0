Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8OIcgsJ019685
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 14:38:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8OI0AkG029139
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 18:38:39 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h8OEhg1A023516 for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 14:43:42 GMT
Subject: [patch] Fix bug in SELinux convert_context
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
   lkml <linux-kernel@vger.kernel.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1064414610.20804.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 24 Sep 2003 10:43:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a bug introduced by earlier code cleanups in the
SELinux convert_context code that manifests upon a policy reload that
removes previously valid security attributes.  Thanks to Magosanyi Arpad
for reporting the bug.

 security/selinux/ss/services.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/security/selinux/ss/services.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/services.c,v
retrieving revision 1.28
diff -u -r1.28 services.c
--- linux-2.6/security/selinux/ss/services.c	17 Jul 2003 11:33:35 -0000	1.28
+++ linux-2.6/security/selinux/ss/services.c	24 Sep 2003 13:08:40 -0000
@@ -896,13 +896,15 @@
 	struct user_datum *usrdatum;
 	char *s;
 	u32 len;
-	int rc = -EINVAL;
+	int rc;
 
 	args = p;
 
 	rc = context_cpy(&oldc, c);
 	if (rc)
 		goto out;
+
+	rc = -EINVAL;
 
 	/* Convert the user. */
 	usrdatum = hashtab_search(args->newp->p_users.table,


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
