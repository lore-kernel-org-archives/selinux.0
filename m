Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MKw1Ob023299
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:58:01 -0400 (EDT)
Received: from e31.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7MKkqo5019187
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 20:46:52 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7MKluF3196096
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:47:56 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7MKlRcX546982
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 14:47:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7MKluHt013076
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 14:47:56 -0600
Received: from sergelap.austin.ibm.com (sig-9-65-117-45.mts.ibm.com [9.65.117.45])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j7MKltg1012997
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 14:47:55 -0600
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.3/8.13.1) with ESMTP id j7MG2cER004445
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 11:02:39 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7MG2cpE004444
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 11:02:38 -0500
Date: Mon, 22 Aug 2005 11:02:38 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 3/6] libsepol: resource leaks in policydb.c
Message-ID: <20050822160238.GC4191@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes 2 resource leaks found by Coverity in policydb.c.

	1. in avrule_read(), the 'cur' element has been malloc'ed
	but not yet added to the avrule->perms list at one point
	whene we jump to bad:

	2. 'key' is not freed in one case in scope_read().

The second point makes me wonder - is scope_destroy() fully
implemented?  It takes 'key' as an argument, but does nothing with
it.  Same with its third arg.  Of course, they both have attribute
unused...

Hmm, I see now my formatting is not matching what's in the original
file...  I'll fix them by hand as I'm mailing them, and try to get
it right next time.

thanks,
-serge

Index: src/policydb.c
===================================================================
--- src.orig/policydb.c
+++ src/policydb.c
@@ -2027,8 +2027,10 @@ static avrule_t *avrule_read(policydb_t 
                 class_perm_node_init(cur);
 
                 buf = next_entry(fp, sizeof(uint32_t) * 2);
-                if (!buf)
+                if (!buf) {
+                        free(cur);
                         goto bad;
+       }
 
                 cur->class = le32_to_cpu(buf[0]);
                 cur->data = le32_to_cpu(buf[1]);
@@ -2363,7 +2365,8 @@ static int scope_read(policydb_t * p, ha
 
         if (strcmp(key, "object_r") == 0 && h == p->p_roles_scope.table) {
                 /* object_r was already added to this table in roles_init() */
-                scope_destroy(key, scope, NULL);
+                free(key);
+                scope_destroy(NULL, scope, NULL);
         }
         else {
                 if (hashtab_insert(h, key, scope)) {

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
