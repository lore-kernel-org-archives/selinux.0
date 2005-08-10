Date: Wed, 10 Aug 2005 16:34:57 -0500
From: serue@us.ibm.com
To: SELinux@tycho.nsa.gov
Subject: [PATCH] fix resource leak (on failure path) in sidtab_insert
Message-ID: <20050810213457.GB7826@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a trivial bug found in avc_sidtab.c by Coverity:

	When the newctx malloc fails in sidtab_insert(), newnode,
	which was previously malloced, is never freed.

Index: src/avc_sidtab.c
===================================================================
--- src.orig/avc_sidtab.c
+++ src/avc_sidtab.c
@@ -58,6 +58,7 @@ sidtab_insert(struct sidtab *s, security
 	newctx = (security_context_t)strdup(ctx);
 	if (!newctx) {
 		rc = -1;
+		avc_free(newnode);
 		goto out;
 	}
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
