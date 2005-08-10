Date: Wed, 10 Aug 2005 16:37:23 -0500
From: serue@us.ibm.com
To: SELinux@tycho.nsa.gov
Subject: [PATCH] fix two related bugs in context_{new,free}
Message-ID: <20050810213723.GD7826@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes two bugs found by Coverity in context.c.

	1. When the malloc() for n fails, but that for result succeeds,
	then result->ptr is dereferenced and used in context_free();
	but it was never initialized either to 0 or to n.
	2. When the malloc for n succeeds but for result fails, then n
	is never freed.

Index: src/context.c
===================================================================
--- src.orig/context.c
+++ src/context.c
@@ -25,10 +25,13 @@ context_new(const char *str)
         context_t result = (context_t) malloc(sizeof(context_s_t));
         const char *p,*tok;
         
+	if (result)
+		result->ptr = n;
+	else
+		free(n);
         if ( n == 0 || result == 0 ) { goto err; }
         n->current_str = n->component[0] = n->component[1] = n->component[2] =
                 n->component[3] = 0;
-        result->ptr = n;
         for ( i = count = 0, p = str; *p; p++ ) {
                 switch ( *p ) { 
                 case ':': count++; break;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
