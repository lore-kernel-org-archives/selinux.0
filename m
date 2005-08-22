Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MKjvOb023117
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:45:58 -0400 (EDT)
Received: from e33.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7MKYmo5017931
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 20:34:49 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7MKZkf5292136
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:35:48 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7MKZsh5341344
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 14:35:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7MKZj99030804
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 14:35:45 -0600
Received: from sergelap.austin.ibm.com (sig-9-65-117-45.mts.ibm.com [9.65.117.45])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j7MKZiTw030775
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 14:35:45 -0600
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.3/8.13.1) with ESMTP id j7MFoShT004254
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 10:50:28 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7MFoRqt004253
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 10:50:27 -0500
Date: Mon, 22 Aug 2005 10:50:27 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 1/6] libsepol: range_trans_clone memory leak
Message-ID: <20050822155027.GA4191@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This next patchset addresses about the next third of real bugs
(I hope).  Will try to finish libsepol by the end of the week.

This patch fixes a memory leak found by Coverity:

	If an mls_level_clone() failed in range_trans_clone(), then
	the new_range being built was not freed.

thanks,
-serge

Index: src/expand.c
===================================================================
--- src.orig/expand.c
+++ src/expand.c
@@ -1361,17 +1361,18 @@ static int genfs_copy(expand_state_t *st
 
 static int range_trans_clone(expand_state_t *state)
 {
-        range_trans_t *range = state->base->range_tr, *last_new_range = NULL;
+        range_trans_t *range = state->base->range_tr, *last_new_range = NULL,
+				*new_range = NULL;
         state->out->range_tr = NULL;
 
         if (state->verbose)
                 printf("copying range transitions\n");
 
         while (range != NULL) {
-                range_trans_t *new_range;
                 if ((new_range = malloc(sizeof(*new_range))) == NULL) {
                         goto out_of_mem;
                 }
+		memset(new_range, 0, sizeof(*new_range));
                 new_range->dom = state->typemap[range->dom-1];
                 new_range->type = state->typemap[range->type-1];
                 if (mls_level_clone(&new_range->range.level[0], &range->range.level[0]) == -1 ||
@@ -1392,6 +1393,11 @@ static int range_trans_clone(expand_stat
 
  out_of_mem:
         write_error(state, "Out of memory!");
+	if(new_range) {
+		ebitmap_destroy(&new_range->range.level[0].cat);
+		ebitmap_destroy(&new_range->range.level[1].cat);
+		free(new_range);
+	}
         return -1;
 }
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
