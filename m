Date: Wed, 10 Aug 2005 16:45:01 -0500
From: serue@us.ibm.com
To: SELinux@tycho.nsa.gov
Subject: [PATCH] free conary on error path in get_default_context()
Message-ID: <20050810214501.GF7826@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a trivial bug found in get_context_list.c by Coverity:

	When strdup(conary) fails, conary is not freed.

Index: src/get_context_list.c
===================================================================
--- src.orig/get_context_list.c
+++ src/get_context_list.c
@@ -60,9 +60,9 @@ int get_default_context(const char* user
 	    return -1;
 
     *newcon = strdup(conary[0]);
+    freeconary(conary);
     if (!(*newcon))
 	    return -1;
-    freeconary(conary);
     return 0;
 }
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
