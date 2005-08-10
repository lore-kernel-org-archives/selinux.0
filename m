Date: Wed, 10 Aug 2005 16:42:32 -0500
From: serue@us.ibm.com
To: SELinux@tycho.nsa.gov
Subject: [PATCH] don't risk returning freed data in get_failsafe_context
Message-ID: <20050810214232.GE7826@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a bug found in get_context_list.c by Coverity:

	If get_failsafe_context() fails, 'reachable' is freed, then we
	goto out:, where we set *list=reachable.  I suspect reachable
	should first be set to NULL.  Though the rc<0 may keep users
	from trying to use *list (quick audit of libselinux/{src,utils}
	suggests that's the case), this still seems prudent.

Index: src/get_context_list.c
===================================================================
--- src.orig/get_context_list.c
+++ src/get_context_list.c
@@ -410,6 +410,7 @@ failsafe:
     rc = get_failsafe_context(user, &reachable[0]);
     if (rc < 0) {
 	    freeconary(reachable);
+	    reachable = NULL;
 	    goto out;
     }
     rc = 1; /* one context in the list */

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
