Return-Path: <SRS0=/6QZ=NM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DDEC6786F
	for <selinux@archiver.kernel.org>; Thu,  1 Nov 2018 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD027204FD
	for <selinux@archiver.kernel.org>; Thu,  1 Nov 2018 13:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD027204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeKAWSh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:18:37 -0400
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:10880 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728351AbeKAWSh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Nov 2018 18:18:37 -0400
X-EEMSG-check-008: 156699843|USFB19PA15_EEMSG_MP11.csd.disa.mil
X-EEMSG-Attachment-filename: 0001-Updated-SELinux-performance-patches.patch
X-EEMSG-Attachment-filesize: 46895
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Nov 2018 13:15:34 +0000
X-Attachment-Exists: TRUE
X-IronPort-AV: E=Sophos;i="5.54,452,1534809600"; 
   d="scan'208,223";a="20150533"
IronPort-PHdr: =?us-ascii?q?9a23=3AK8htrRPja5ypbB/0F6ol6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z7psbcNUDSrc9gkEXOFd2Cra4c1KyO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhjexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEvYNMeNeooLgpVUBsAG+CBGxCu3v1DFIiHz406M03O?=
 =?us-ascii?q?suEw7JwBctH9cSvHnOttj5KKkfXOKzwaLVzTvDdfRW2TLl5YbVbhAuv+mMXb?=
 =?us-ascii?q?JufsrX1EIhCgbFgU+UqYzhITyU1vkGvm+A7+V9TuKikHInqgFtrTivwccgkI?=
 =?us-ascii?q?/JhpkPxVze+iV5x5g1KMS+RUVmb9CkF55QuDubN4twWs4iQH9nuDw8yrIYvZ?=
 =?us-ascii?q?63Zi8KyI4oxxPZdveJcJCI7wr+WOueLjp0nnJodK+lixqs/kWs1PfwWtSy3V?=
 =?us-ascii?q?1XtCRKiMPMuWoI1xHL78iHTeZy8Vm51DaU0gDT9vlEIUcplarHM5IhwqA/lp?=
 =?us-ascii?q?4UsUnbAi/5gl/2jK6LdkU/4OSo9+Tmbanmpp+bLYN0jB3xMr8ylcClBOQ4Mw?=
 =?us-ascii?q?wOU3Ca+eS6yrLj4VX0TKhFg/A5iKXUsI3WKd4FqqO2HQNZyJsv5w66Dzi80d?=
 =?us-ascii?q?QYmXcHLEhCeBKCl4XpIEzBIOvjAPejg1WjjDdrx/fcMr3nGZXCNGLPkLjmfb?=
 =?us-ascii?q?Zj80Jc0hY8zchD55JIDbEMOPXzWkr2tNzDCB82KRC7zPj8BdVnyIwRRGKPDb?=
 =?us-ascii?q?WFMK/IrVCI4ecvKfGWZIAJoDb9N+Ql5/n2gH8ih1Adeaip3Z0KaHG3BflmPU?=
 =?us-ascii?q?qZbmT2gtsbEmcFoBA+TOr0h12GSzJTYGyyX60k7DEhFI2mFZvDRpyqgLGZxC?=
 =?us-ascii?q?e0BIBWZmRdB1CUC3joaoGEV+4JaCKVJc9hiCILWaK9RI8m0BH9/DP9np1hIv?=
 =?us-ascii?q?DZ+GU9sonl3dN45KWHkhQ17jp9BMm1yWyBT2ho2GgPQmlylLtypU1710erz6?=
 =?us-ascii?q?d1mbpbGMZV6vcPVR01cdbkxvF+Q/X1XRjMNoORQUuias2vHDV0S9U22dJIaE?=
 =?us-ascii?q?F4TYaMlBfGihG2DqcVmrrDP5k99qbRzjClPMpm42rX36kmyV89S41AMnPw1f?=
 =?us-ascii?q?03zBTaG4OcyxbRrK2tb6lJmXeUrGo=3D?=
X-IPAS-Result: =?us-ascii?q?A2AFAADw+9pb/wHyM5BhAxoBAQEBAQIBAQEBBwIBAQEBg?=
 =?us-ascii?q?VEFAQEBAQsBgVoqZn8og3aIGIwWUAEHgTV6iBaOG4F6MgUBAYRAAoM5IjQND?=
 =?us-ascii?q?QEDAQEBAQEBAgFsHAyCNiQBgl8BAQEBAxoBCARSEAsOAwMBAgEWFAICTwgGA?=
 =?us-ascii?q?QwGAgEBgl4dGAoBgXQND6gHezOELQGFXwoFi2wXeYEHgREngjY1gUEBgyY2A?=
 =?us-ascii?q?SYBDoIuglcCiGMgBIVrQ49tCYQXglWKGAYYgVSIGIZniT+DQot5OCcagRQrC?=
 =?us-ascii?q?AIYCCEPO4JsE4ISAQwLiFyFWiMwAQEBgQIBAYd1DRcHgiABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 01 Nov 2018 13:15:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA1DFUjS026050;
        Thu, 1 Nov 2018 09:15:30 -0400
Subject: Re: [PATCH 2/2] selinux: fix ENOMEM errors during policy reload
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@tycho.nsa.gov
References: <20181031122718.18735-1-omosnace@redhat.com>
 <20181031122718.18735-3-omosnace@redhat.com>
 <974d4ce4-6ddc-bc4b-ecf0-8b8e7a5d4083@tycho.nsa.gov>
Message-ID: <6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov>
Date:   Thu, 1 Nov 2018 09:17:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <974d4ce4-6ddc-bc4b-ecf0-8b8e7a5d4083@tycho.nsa.gov>
Content-Type: multipart/mixed;
 boundary="------------F414D7E22F25BAEF94667B9C"
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------F414D7E22F25BAEF94667B9C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/2018 04:31 PM, Stephen Smalley wrote:
> We'd like to 
> replace the policy rwlock with RCU at some point; there is a very old 
> patch that tried to do that once before, which eliminated the policy 
> write lock altogether (policy switch became a single pointer update), 
> but no one has yet taken that back up.

For reference, here is that old patch that tried converting the policy 
rwlock to RCU.  It applies on Linux v2.6.9 (yes, it is that old).  There 
was a more recent effort by Peter Enderborg to convert to RCU to deal 
with preempt disable holding, but I had some concerns with the approach 
to booleans, see [1]

Aside from the locking aspects, the other reason I mention it is that I 
am unsure of the implications of your model of converting within the 
sidtab for a future migration to RCU, since that doesn't seem amenable 
to a read-copy-update sequence.

[1] 
https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/



--------------F414D7E22F25BAEF94667B9C
Content-Type: text/x-patch;
 name="0001-Updated-SELinux-performance-patches.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Updated-SELinux-performance-patches.patch"

From dca7a6167d9daa57bd7fae696d65b3ef2743b025 Mon Sep 17 00:00:00 2001
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
Date: Wed, 17 Nov 2004 13:03:59 +0900
Subject: [PATCH] Updated SELinux performance patches

Hi,

This patch removes the rwlock for policydb, but significant performance
improvement for networking was NOT observed. And, this fix make
the SELinux code a bit complexity :(

- POLICY_WRLOCK/POLICY_WRUNLOCK are eliminated.
- POLICY_RDLOCK/POLICY_RDUNLOCK are redefined as rcu_read_lock()
 and rcu_read_unlock().
- policydb and sidtab is refered by pointer.
- avtab_duplicate()/hashtab_duplicate()/cond_policydb_dup() are added.
- avtab was allocated by kmalloc(), since we can't release the vmalloc()'ed
 area in RCU handler.
- I didn't touch the MLS code. We can't build the kernel
 when CONFIG_SECURITY_SELINUX_MLS=y

* When Security-Policy was loaded.
This is simple. We replace the original policydb object by the new one.
The new policydb was generated by existing code.

* When Boolean variables were modified.
This is the reason for complexity. :(
When we modify the boolean variables, p_bools(symtab[SYM_BOOLS]),
te_cond_avtab, bool_val_to_struct and cond_list in policydb have
possibility to update. When cond_policydb_dup() duplicate the policydb,
we must allocate the regions for the above members, and copy.

 * Performance Results
 I expected that performance improvement is observed in tbench,
 since stream connection referes the policydb so frequently.
 But we can't get the results expected. orz

 dbench Results [MB/s] (Bigger is better)
 -- Kernel --  - 1CPU- - 2CPU- - 4CPU- - 8CPU- -16CPU- -32CPU-
 Disable         623.2  1133.1  2044.0  3199.5  1632.5  264.7
 Enable          554.0   923.1  1138.4   624.7   406.8  123.5
 RCU             555.5  1012.6  1815.8  2939.8  1593.0  269.4
 NoLockPolicy    559.5  1031.6  1848.7  3033.4  1652.3  271.5
 -------------------------------------------------------------

 tbench Results [MB/s] (Bigger is better)
 -- Kernel --  - 1CPU- - 2CPU- - 4CPU- - 8CPU- -16CPU- -32CPU-
 Disable         92.5   171.8   254.7   488.9   761.1   818.8
 Enable          79.6   139.6   171.0    88.6    41.2    19.9
 RCU             81.4   153.2   238.9   424.1   664.9   744.2
 NoLockPolicy    78.8   154.4   233.5   430.8   653.9   722.0
 -------------------------------------------------------------
 Disable      = Vanilla 2.6.9 + SELinux Disable
 Enable       = Vanilla 2.6.9 + SELinux Enable
 RCU          = 2.6.9 + NSA SELinux(11/4)
 NoLockPolicy = 2.6.9 + NSA SELinux(11/4)
                + selinux-nolock-policydb-041110.patch

 Because we faced slowly perforamece degradation on replacing the avc_lock
 by rwlock when I tried to apply RCU to AVC, I think RCU is better than rwlock.

 I posted in 24/Aug/04
 Re: RCU issue with SELinux (Re: SELINUX performance issues)
 [write() to files on tmpfs Loop=500000 Parallel=<Num of CPU>]
                  -- 1CPU-- -- 2CPU-- -- 4CPU-- -- 8CPU-- --16CPU-- --32CPU--
 2.6.8.1(disable)    8.2959    8.0430    8.0158    8.0183    8.0146    8.0037
 2.6.8.1(enable)    11.8427   14.0358   78.0957  319.0451 1322.0313  too long
 2.6.8.1.rwlock     11.2485   13.8688   20.0100   49.0390   90.0200  177.0533
 2.6.8.1.rcu        11.3435   11.3319   11.0464   11.0205   11.0372   11.0496

 But I feel another factor, such as the Kylene's effort, is bigger in the policydb
 case. I think it should be tuned up first.

 Thanks
---
 security/selinux/hooks.c          |  11 +-
 security/selinux/ss/avtab.c       |  38 ++-
 security/selinux/ss/avtab.h       |   5 +-
 security/selinux/ss/conditional.c | 211 ++++++++++++++-
 security/selinux/ss/conditional.h |   3 +
 security/selinux/ss/hashtab.c     |  50 ++++
 security/selinux/ss/hashtab.h     |   7 +
 security/selinux/ss/policydb.c    |   6 +
 security/selinux/ss/policydb.h    |   3 +
 security/selinux/ss/services.c    | 408 ++++++++++++++++++------------
 security/selinux/ss/services.h    |   4 +-
 11 files changed, 571 insertions(+), 175 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f844e402b53..367194cf056 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -291,7 +291,7 @@ static void sk_free_security(struct sock *sk)
 
 /* The security server must be initialized before
    any labeling or access decisions can be provided. */
-extern int ss_initialized;
+extern struct policydb *policydb;
 
 /* The file system's label must be initialized prior to use. */
 
@@ -514,7 +514,8 @@ static int superblock_doinit(struct super_block *sb, void *data)
 	if (sbsec->initialized)
 		goto out;
 
-	if (!ss_initialized) {
+	rcu_read_lock();
+	if (!policydb) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
 		   server is ready to handle calls. */
@@ -522,6 +523,7 @@ static int superblock_doinit(struct super_block *sb, void *data)
 		if (list_empty(&sbsec->list))
 			list_add(&sbsec->list, &superblock_security_head);
 		spin_unlock(&sb_security_lock);
+		rcu_read_unlock();
 		goto out;
 	}
 
@@ -4482,10 +4484,13 @@ int selinux_disable(void)
 	extern void exit_sel_fs(void);
 	static int selinux_disabled = 0;
 
-	if (ss_initialized) {
+	rcu_read_lock();
+	if (policydb) {
 		/* Not permitted after initial policy load. */
+		rcu_read_unlock();
 		return -EINVAL;
 	}
+	rcu_read_unlock();
 
 	if (selinux_disabled) {
 		/* Only do this once. */
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 66fbdbb58be..3d30b918961 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -232,7 +232,7 @@ void avtab_destroy(struct avtab *h)
 		}
 		h->htable[i] = NULL;
 	}
-	vfree(h->htable);
+	kfree(h->htable);
 	h->htable = NULL;
 }
 
@@ -265,7 +265,7 @@ int avtab_init(struct avtab *h)
 {
 	int i;
 
-	h->htable = vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);
+	h->htable = kmalloc(sizeof(*(h->htable)) * AVTAB_SIZE, GFP_KERNEL);
 	if (!h->htable)
 		return -ENOMEM;
 	for (i = 0; i < AVTAB_SIZE; i++)
@@ -407,3 +407,37 @@ void avtab_cache_init(void)
 					      sizeof(struct avtab_node),
 					      0, SLAB_PANIC, NULL, NULL);
 }
+
+int avtab_duplicate(struct avtab *new, struct avtab *orig)
+{
+	int i,rc;
+	struct avtab_node *node, *tmp, *tail;
+
+	if (!new || !orig)
+		return -EFAULT;
+
+	rc = avtab_init(new);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < AVTAB_SIZE; i++) {
+		tail = NULL;
+		for (node = orig->htable[i]; node; node = node->next) {
+			tmp = kmem_cache_alloc(avtab_node_cachep, SLAB_KERNEL);
+			if (!tmp)
+				goto error;
+			memcpy(tmp, node, sizeof(struct avtab_node));
+			if (!tail) {
+				new->htable[i] = tmp;
+			} else {
+				tail->next = tmp;
+			}
+			tail = tmp;
+			new->nel++;
+		}
+	}
+	return 0;
+ error:
+	avtab_destroy(new);
+	return -ENOMEM;
+}
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index f1d17575d92..f7de3c8dc0c 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -80,7 +80,10 @@ struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified
 
 void avtab_cache_init(void);
 
-#define AVTAB_HASH_BITS 15
+int avtab_duplicate(struct avtab *new, struct avtab *orig);
+
+//#define AVTAB_HASH_BITS 15
+#define AVTAB_HASH_BITS 13
 #define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
 #define AVTAB_HASH_MASK (AVTAB_HASH_BUCKETS-1)
 
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index f8958ba3451..4a0450b9926 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -13,7 +13,7 @@
 #include <linux/spinlock.h>
 #include <asm/semaphore.h>
 #include <linux/slab.h>
-
+#include <linux/rcupdate.h>
 #include "security.h"
 #include "conditional.h"
 
@@ -485,3 +485,212 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key, struct av_decisi
 	}
 	return;
 }
+/* ------------------------------------------------------------ */
+static struct cond_av_list *cond_dup_av_list(struct cond_av_list *orig, struct avtab *te_cond)
+{
+	struct avtab_datum *avdatum;
+	struct cond_av_list *cur, *tmp, *tail = NULL, *head = NULL;
+
+	for (cur = orig; cur; cur = cur->next) {
+		avdatum = avtab_search(te_cond, &cur->node->key, cur->node->datum.specified);
+		if (!avdatum)
+			goto error;
+
+		tmp = kmalloc(sizeof(struct cond_av_list), GFP_KERNEL);
+		if (!tmp)
+			goto error;
+
+		tmp->node = container_of(avdatum, struct avtab_node, datum);
+		tmp->next = NULL;
+		if (!head) {
+			head = tail = tmp;
+		} else {
+			tail->next = tmp;
+			tail = tmp;
+		}
+	}
+	return head;
+ error:
+	for (cur=head; cur; cur = tmp) {
+		tmp = cur->next;
+		kfree(tmp);
+	}
+	return NULL;
+}
+
+static struct cond_expr *cond_dup_expr(struct cond_expr *orig)
+{
+	struct cond_expr *cur, *tmp, *tail, *head;
+
+	tail = head = NULL;
+	for (cur = orig; cur; cur = cur->next) {
+		tmp = kmalloc(sizeof(struct cond_expr), GFP_KERNEL);
+		if (!tmp)
+			goto error;
+		tmp->expr_type = cur->expr_type;
+		tmp->bool = cur->bool;
+		tmp->next = NULL;
+		if (!head) {
+			head = tail = tmp;
+		} else {
+			tail->next = tmp;
+			tail = tmp;
+		}
+	}
+	return head; /* success */
+
+ error:
+        for (cur = head; cur; cur = tmp) {
+                tmp = cur->next;
+                kfree(cur);
+        }
+        return NULL;
+}
+
+/* ------------------------------------------------------------ */
+int duplicate_policydb_cond_list(struct policydb *new, struct policydb *orig)
+{
+	int rc;
+	struct cond_node *cur, *tmp, *tail = NULL;
+
+	rc = avtab_duplicate(&new->te_cond_avtab, &orig->te_cond_avtab);
+	if (rc)
+		return rc;
+
+	new->cond_list = NULL;
+	for (cur = orig->cond_list; cur; cur = cur->next) {
+		tmp = kmalloc(sizeof(struct cond_node), GFP_KERNEL);
+		if (!tmp)
+			goto error;
+		memset(tmp, 0, sizeof(struct cond_node));
+		tmp->cur_state = cur->cur_state;
+
+		if (!tail) {
+			new->cond_list = tmp;
+		} else {
+			tail->next = tmp;
+		}
+		tail = tmp;
+
+		tmp->expr = cond_dup_expr(cur->expr);
+		if (cur->expr && !tmp->expr)
+			goto error;
+
+		tmp->true_list = cond_dup_av_list(cur->true_list, &new->te_cond_avtab);
+		if (cur->true_list && !tmp->true_list)
+			goto error;
+
+		tmp->false_list = cond_dup_av_list(cur->false_list, &new->te_cond_avtab);
+		if (cur->false_list && !tmp->false_list)
+			goto error;
+	}
+	return 0; /* success*/
+
+ error:
+	cond_list_destroy(new->cond_list);
+	return -ENOMEM;
+}
+
+static int cond_bools_destroy(void *key, void *datum, void *args)
+{
+	kfree(datum);
+	return 0;
+}
+
+static int cond_bools_copy(struct hashtab_node *new, struct hashtab_node *orig, void *args)
+{
+	struct cond_bool_datum *datum;
+
+	datum = kmalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
+	if (!datum)
+		return -ENOMEM;
+
+	memcpy(datum, orig->datum, sizeof(struct cond_bool_datum));
+
+	new->key = orig->key; /* Not need to duplicate */
+	new->datum = datum;
+	return 0;
+}
+
+static int cond_bools_index(void *key, void *datum, void *args)
+{
+	struct cond_bool_datum *booldatum, **cond_bool_array;
+
+	booldatum = datum;
+	cond_bool_array = args;
+	cond_bool_array[booldatum->value -1] = booldatum;
+
+	return 0;
+}
+
+static int duplicate_policydb_bools(struct policydb *newdb, struct policydb *orig)
+{
+	int len;
+	struct hashtab *newht;
+	struct cond_bool_datum **cond_bool_array;
+
+	if (!newdb || !orig)
+		return -EFAULT;
+
+	len = sizeof(struct cond_bool_datum *) * orig->p_bools.nprim;
+	cond_bool_array = kmalloc(len, GFP_KERNEL);
+	if (!cond_bool_array)
+		return -ENOMEM;
+	memset(cond_bool_array, 0, len);
+
+	newht = hashtab_duplicate(orig->p_bools.table, cond_bools_copy,
+					cond_bools_destroy, NULL);
+	if (!newht) {
+		kfree(cond_bool_array);
+		return -ENOMEM;
+	}
+	hashtab_map(newht, cond_bools_index, cond_bool_array);
+	newdb->bool_val_to_struct = cond_bool_array;
+	newdb->p_bools.table = newht;
+	newdb->p_bools.nprim = newht->nel;
+
+	return 0;
+}
+
+void cond_policydb_free_rcu(struct rcu_head *p)
+{
+	struct policydb *old_policy;
+
+	old_policy = container_of(p, struct policydb, rhead);
+
+	hashtab_map(old_policy->p_bools.table, cond_bools_destroy, NULL);
+	hashtab_destroy(old_policy->p_bools.table);
+	kfree(old_policy->bool_val_to_struct);
+
+	avtab_destroy(&old_policy->te_cond_avtab);
+	cond_list_destroy(old_policy->cond_list);
+
+	printk("olddb was kfree()'d at cond_policydb_free_rcu()\n");
+
+	kfree(old_policy);
+}
+
+struct policydb *cond_policydb_dup(struct policydb *orig)
+{
+	struct policydb *newdb;
+
+	newdb = kmalloc(sizeof(struct policydb), GFP_KERNEL);
+	if (!newdb)
+		return NULL;
+
+	memcpy(newdb, orig, sizeof(struct policydb));
+
+	if (duplicate_policydb_bools(newdb, orig)) {
+		kfree(newdb);
+		return NULL;
+	}
+
+	if (duplicate_policydb_cond_list(newdb, orig)) {
+		cond_policydb_destroy(newdb);
+		kfree(newdb);
+		return NULL;
+	}
+
+	return newdb; /* success */
+}
+/* ------------------------------------------------------------ */
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index f3a1fc6e5d6..73a68647d6a 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -74,4 +74,7 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key, struct av_decisi
 
 int evaluate_cond_node(struct policydb *p, struct cond_node *node);
 
+void cond_policydb_free_rcu(struct rcu_head *p);
+struct policydb *cond_policydb_dup(struct policydb *orig);
+
 #endif /* _CONDITIONAL_H_ */
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 2a6752a8d01..0e39aca7789 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -278,3 +278,53 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 	info->slots_used = slots_used;
 	info->max_chain_len = max_chain_len;
 }
+
+struct hashtab *hashtab_duplicate(struct hashtab *orig,
+		int (*copy)(struct hashtab_node *new, struct hashtab_node *orig, void *args),
+		int (*destroy)(void *k, void *d, void *args),
+		void *args)
+{
+	int i,rc;
+	struct hashtab *new;
+	struct hashtab_node *cur, *tmp, *tail;
+
+	if (!orig || !copy || !destroy)
+		return NULL;
+
+	new = hashtab_create(orig->hash_value, orig->keycmp, orig->size);
+	if (!new)
+		return NULL;
+
+	for (i = 0; i < orig->size; i++) {
+		tail = NULL;
+		for (cur = orig->htable[i]; cur; cur = cur->next) {
+			tmp = kmalloc(sizeof(struct hashtab_node), GFP_KERNEL);
+			if (!tmp)
+				goto error;
+			rc = copy(tmp, cur, args);
+			if (rc) {
+				kfree(tmp);
+				goto error;
+			}
+			tmp->next = NULL;
+			if (!tail) {
+				new->htable[i] = tmp;
+			} else {
+				tail->next = tmp;
+			}
+			tail = tmp;
+			new->nel++;
+		}
+	}
+	return new;
+ error:
+	for (i = 0; i < new->size; i++) {
+		for (cur = new->htable[i]; cur; cur = tmp) {
+			tmp = cur->next;
+			destroy(cur->key, cur->datum, args);
+			kfree(cur);
+		}
+	}
+	kfree(new);
+	return NULL;
+}
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 10c3be19605..ea4336a4617 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -122,4 +122,11 @@ void hashtab_map_remove_on_error(struct hashtab *h,
 /* Fill info with some hash table statistics */
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
 
+
+struct hashtab *hashtab_duplicate(struct hashtab *orig,
+		int (*copy)(struct hashtab_node *new, struct hashtab_node *orig, void *args),
+		int (*destroy)(void *k, void *d, void *args),
+		void *args);
+
+
 #endif	/* _SS_HASHTAB_H */
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e10ed0e1e9a..758549eb04f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -142,6 +142,11 @@ int policydb_init(struct policydb *p)
 
 	memset(p, 0, sizeof(*p));
 
+	p->sidtab = kmalloc(sizeof(struct sidtab), GFP_KERNEL);
+	if (!p->sidtab)
+		return -ENOMEM;
+	sidtab_init(p->sidtab);
+
 	for (i = 0; i < SYM_NUM; i++) {
 		rc = symtab_init(&p->symtab[i], symtab_sizes[i]);
 		if (rc)
@@ -169,6 +174,7 @@ out_free_avtab:
 out_free_symtab:
 	for (i = 0; i < SYM_NUM; i++)
 		hashtab_destroy(p->symtab[i].table);
+	kfree(p->sidtab);
 	goto out;
 }
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 31321c143a3..568205a7eed 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -18,6 +18,7 @@
 #ifndef _SS_POLICYDB_H_
 #define _SS_POLICYDB_H_
 
+#include <linux/rcupdate.h>
 #include "symtab.h"
 #include "avtab.h"
 #include "sidtab.h"
@@ -246,6 +247,8 @@ struct policydb {
 	struct ebitmap trustedwriters;
 	struct ebitmap trustedobjects;
 #endif
+	struct rcu_head rhead;
+	struct sidtab *sidtab;
 };
 
 extern int policydb_init(struct policydb *p);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index cad42571971..56d2b354e62 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -42,19 +42,14 @@
 extern void selnl_notify_policyload(u32 seqno);
 extern int policydb_loaded_version;
 
-static rwlock_t policy_rwlock = RW_LOCK_UNLOCKED;
-#define POLICY_RDLOCK read_lock(&policy_rwlock)
-#define POLICY_WRLOCK write_lock_irq(&policy_rwlock)
-#define POLICY_RDUNLOCK read_unlock(&policy_rwlock)
-#define POLICY_WRUNLOCK write_unlock_irq(&policy_rwlock)
+#define POLICY_RDLOCK	rcu_read_lock();
+#define POLICY_RDUNLOCK	rcu_read_unlock();
 
 static DECLARE_MUTEX(load_sem);
-#define LOAD_LOCK down(&load_sem)
-#define LOAD_UNLOCK up(&load_sem)
+#define LOAD_LOCK do{ down(&load_sem); rcu_read_lock(); } while(0)
+#define LOAD_UNLOCK do{ rcu_read_unlock(); up(&load_sem); } while(0)
 
-struct sidtab sidtab;
-struct policydb policydb;
-int ss_initialized = 0;
+struct policydb *policydb = NULL;
 
 /*
  * The largest sequence number that has been used when
@@ -69,7 +64,8 @@ static u32 latest_granting = 0;
  * when it is applied to the specified source and target
  * security contexts.
  */
-static int constraint_expr_eval(struct context *scontext,
+static int constraint_expr_eval(struct policydb *p,
+				struct context *scontext,
 				struct context *tcontext,
 				struct constraint_expr *cexpr)
 {
@@ -111,8 +107,8 @@ static int constraint_expr_eval(struct context *scontext,
 			case CEXPR_ROLE:
 				val1 = scontext->role;
 				val2 = tcontext->role;
-				r1 = policydb.role_val_to_struct[val1 - 1];
-				r2 = policydb.role_val_to_struct[val2 - 1];
+				r1 = p->role_val_to_struct[val1 - 1];
+				r2 = p->role_val_to_struct[val2 - 1];
 				switch (e->op) {
 				case CEXPR_DOM:
 					s[++sp] = ebitmap_get_bit(&r1->dominates,
@@ -192,7 +188,8 @@ static int constraint_expr_eval(struct context *scontext,
  * Compute access vectors based on a context structure pair for
  * the permissions in a particular class.
  */
-static int context_struct_compute_av(struct context *scontext,
+static int context_struct_compute_av(struct policydb *p,
+				     struct context *scontext,
 				     struct context *tcontext,
 				     u16 tclass,
 				     u32 requested,
@@ -215,12 +212,12 @@ static int context_struct_compute_av(struct context *scontext,
 		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
 			tclass = SECCLASS_NETLINK_SOCKET;
 
-	if (!tclass || tclass > policydb.p_classes.nprim) {
+	if (!tclass || tclass > p->p_classes.nprim) {
 		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
 		       tclass);
 		return -EINVAL;
 	}
-	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+	tclass_datum = p->class_val_to_struct[tclass - 1];
 
 	/*
 	 * Initialize the access vectors to the default values.
@@ -238,7 +235,7 @@ static int context_struct_compute_av(struct context *scontext,
 	avkey.source_type = scontext->type;
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
-	avdatum = avtab_search(&policydb.te_avtab, &avkey, AVTAB_AV);
+	avdatum = avtab_search(&p->te_avtab, &avkey, AVTAB_AV);
 	if (avdatum) {
 		if (avdatum->specified & AVTAB_ALLOWED)
 			avd->allowed = avtab_allowed(avdatum);
@@ -249,7 +246,7 @@ static int context_struct_compute_av(struct context *scontext,
 	}
 
 	/* Check conditional av table for additional permissions */
-	cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
+	cond_compute_av(&p->te_cond_avtab, &avkey, avd);
 
 	/*
 	 * Remove any permissions prohibited by the MLS policy.
@@ -262,7 +259,7 @@ static int context_struct_compute_av(struct context *scontext,
 	constraint = tclass_datum->constraints;
 	while (constraint) {
 		if ((constraint->permissions & (avd->allowed)) &&
-		    !constraint_expr_eval(scontext, tcontext,
+		    !constraint_expr_eval(p, scontext, tcontext,
 					  constraint->expr)) {
 			avd->allowed = (avd->allowed) & ~(constraint->permissions);
 		}
@@ -277,7 +274,7 @@ static int context_struct_compute_av(struct context *scontext,
 	if (tclass == SECCLASS_PROCESS &&
 	    (avd->allowed & PROCESS__TRANSITION) &&
 	    scontext->role != tcontext->role) {
-		for (ra = policydb.role_allow; ra; ra = ra->next) {
+		for (ra = p->role_allow; ra; ra = ra->next) {
 			if (scontext->role == ra->role &&
 			    tcontext->role == ra->new_role)
 				break;
@@ -308,28 +305,30 @@ int security_compute_av(u32 ssid,
 			u32 requested,
 			struct av_decision *avd)
 {
+	struct policydb *p;
 	struct context *scontext = NULL, *tcontext = NULL;
 	int rc = 0;
 
-	if (!ss_initialized) {
+	POLICY_RDLOCK;
+	p = policydb;
+
+	if (!p) {
 		avd->allowed = requested;
 		avd->decided = requested;
 		avd->auditallow = 0;
 		avd->auditdeny = 0xffffffff;
 		avd->seqno = latest_granting;
-		return 0;
+		goto out;
 	}
 
-	POLICY_RDLOCK;
-
-	scontext = sidtab_search(&sidtab, ssid);
+	scontext = sidtab_search(p->sidtab, ssid);
 	if (!scontext) {
 		printk(KERN_ERR "security_compute_av:  unrecognized SID %d\n",
 		       ssid);
 		rc = -EINVAL;
 		goto out;
 	}
-	tcontext = sidtab_search(&sidtab, tsid);
+	tcontext = sidtab_search(p->sidtab, tsid);
 	if (!tcontext) {
 		printk(KERN_ERR "security_compute_av:  unrecognized SID %d\n",
 		       tsid);
@@ -337,7 +336,7 @@ int security_compute_av(u32 ssid,
 		goto out;
 	}
 
-	rc = context_struct_compute_av(scontext, tcontext, tclass,
+	rc = context_struct_compute_av(p, scontext, tcontext, tclass,
 				       requested, avd);
 out:
 	POLICY_RDUNLOCK;
@@ -351,7 +350,8 @@ out:
  * to point to this string and set `*scontext_len' to
  * the length of the string.
  */
-int context_struct_to_string(struct context *context, char **scontext, u32 *scontext_len)
+int context_struct_to_string(struct policydb *p, struct context *context,
+                             char **scontext, u32 *scontext_len)
 {
 	char *scontextp;
 
@@ -359,9 +359,9 @@ int context_struct_to_string(struct context *context, char **scontext, u32 *scon
 	*scontext_len = 0;
 
 	/* Compute the size of the context. */
-	*scontext_len += strlen(policydb.p_user_val_to_name[context->user - 1]) + 1;
-	*scontext_len += strlen(policydb.p_role_val_to_name[context->role - 1]) + 1;
-	*scontext_len += strlen(policydb.p_type_val_to_name[context->type - 1]) + 1;
+	*scontext_len += strlen(p->p_user_val_to_name[context->user - 1]) + 1;
+	*scontext_len += strlen(p->p_role_val_to_name[context->role - 1]) + 1;
+	*scontext_len += strlen(p->p_type_val_to_name[context->type - 1]) + 1;
 	*scontext_len += mls_compute_context_len(context);
 
 	/* Allocate space for the context; caller must free this space. */
@@ -375,12 +375,12 @@ int context_struct_to_string(struct context *context, char **scontext, u32 *scon
 	 * Copy the user name, role name and type name into the context.
 	 */
 	sprintf(scontextp, "%s:%s:%s:",
-		policydb.p_user_val_to_name[context->user - 1],
-		policydb.p_role_val_to_name[context->role - 1],
-		policydb.p_type_val_to_name[context->type - 1]);
-	scontextp += strlen(policydb.p_user_val_to_name[context->user - 1]) +
-	             1 + strlen(policydb.p_role_val_to_name[context->role - 1]) +
-	             1 + strlen(policydb.p_type_val_to_name[context->type - 1]) + 1;
+		p->p_user_val_to_name[context->user - 1],
+		p->p_role_val_to_name[context->role - 1],
+		p->p_type_val_to_name[context->type - 1]);
+	scontextp += strlen(p->p_user_val_to_name[context->user - 1]) +
+	             1 + strlen(p->p_role_val_to_name[context->role - 1]) +
+	             1 + strlen(p->p_type_val_to_name[context->type - 1]) + 1;
 
 	mls_sid_to_context(context, &scontextp);
 
@@ -404,10 +404,14 @@ int context_struct_to_string(struct context *context, char **scontext, u32 *scon
  */
 int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
 {
+	struct policydb *p;
 	struct context *context;
 	int rc = 0;
 
-	if (!ss_initialized) {
+	POLICY_RDLOCK;
+	p = policydb;
+
+	if (!p) {
 		if (sid <= SECINITSID_NUM) {
 			char *scontextp;
 
@@ -422,18 +426,17 @@ int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
 		rc = -EINVAL;
 		goto out;
 	}
-	POLICY_RDLOCK;
-	context = sidtab_search(&sidtab, sid);
+
+	context = sidtab_search(p->sidtab, sid);
 	if (!context) {
 		printk(KERN_ERR "security_sid_to_context:  unrecognized SID "
 		       "%d\n", sid);
 		rc = -EINVAL;
-		goto out_unlock;
+		goto out;
 	}
-	rc = context_struct_to_string(context, scontext, scontext_len);
-out_unlock:
-	POLICY_RDUNLOCK;
+	rc = context_struct_to_string(p, context, scontext, scontext_len);
 out:
+	POLICY_RDUNLOCK;
 	return rc;
 
 }
@@ -452,6 +455,7 @@ out:
 int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
 {
 	char *scontext2;
+	struct policydb *pol;
 	struct context context;
 	struct role_datum *role;
 	struct type_datum *typdatum;
@@ -459,11 +463,25 @@ int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
 	char *scontextp, *p, oldc;
 	int rc = 0;
 
-	if (!ss_initialized) {
+	/* Copy the string so that we can modify the copy as we parse it.
+	   The string should already by null terminated, but we append a
+	   null suffix to the copy to avoid problems with the existing
+	   attr package, which doesn't view the null terminator as part
+	   of the attribute value. */
+	scontext2 = kmalloc(scontext_len+1,GFP_KERNEL);
+	if (!scontext2)
+		return -ENOMEM;
+	memcpy(scontext2, scontext, scontext_len);
+	scontext2[scontext_len] = 0;
+
+	POLICY_RDLOCK;
+	pol = policydb;
+
+	if (!pol) {
 		int i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
-			if (!strcmp(initial_sid_to_string[i], scontext)) {
+			if (!strcmp(initial_sid_to_string[i], scontext2)) {
 				*sid = i;
 				goto out;
 			}
@@ -471,26 +489,10 @@ int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
 		*sid = SECINITSID_KERNEL;
 		goto out;
 	}
-	*sid = SECSID_NULL;
-
-	/* Copy the string so that we can modify the copy as we parse it.
-	   The string should already by null terminated, but we append a
-	   null suffix to the copy to avoid problems with the existing
-	   attr package, which doesn't view the null terminator as part
-	   of the attribute value. */
-	scontext2 = kmalloc(scontext_len+1,GFP_KERNEL);
-	if (!scontext2) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	memcpy(scontext2, scontext, scontext_len);
-	scontext2[scontext_len] = 0;
 
 	context_init(&context);
 	*sid = SECSID_NULL;
 
-	POLICY_RDLOCK;
-
 	/* Parse the security context. */
 
 	rc = -EINVAL;
@@ -506,7 +508,7 @@ int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
 
 	*p++ = 0;
 
-	usrdatum = hashtab_search(policydb.p_users.table, scontextp);
+	usrdatum = hashtab_search(pol->p_users.table, scontextp);
 	if (!usrdatum)
 		goto out_unlock;
 
@@ -522,7 +524,7 @@ int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
 
 	*p++ = 0;
 
-	role = hashtab_search(policydb.p_roles.table, scontextp);
+	role = hashtab_search(pol->p_roles.table, scontextp);
 	if (!role)
 		goto out_unlock;
 	context.role = role->value;
@@ -534,7 +536,7 @@ int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
 	oldc = *p;
 	*p++ = 0;
 
-	typdatum = hashtab_search(policydb.p_types.table, scontextp);
+	typdatum = hashtab_search(pol->p_types.table, scontextp);
 	if (!typdatum)
 		goto out_unlock;
 
@@ -550,21 +552,22 @@ int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
 	}
 
 	/* Check the validity of the new context. */
-	if (!policydb_context_isvalid(&policydb, &context)) {
+	if (!policydb_context_isvalid(pol, &context)) {
 		rc = -EINVAL;
 		goto out_unlock;
 	}
 	/* Obtain the new sid. */
-	rc = sidtab_context_to_sid(&sidtab, &context, sid);
+	rc = sidtab_context_to_sid(pol->sidtab, &context, sid);
 out_unlock:
 	POLICY_RDUNLOCK;
 	context_destroy(&context);
-	kfree(scontext2);
 out:
+	kfree(scontext2);
 	return rc;
 }
 
 static int compute_sid_handle_invalid_context(
+	struct policydb *p,
 	struct context *scontext,
 	struct context *tcontext,
 	u16 tclass,
@@ -573,18 +576,18 @@ static int compute_sid_handle_invalid_context(
 	char *s = NULL, *t = NULL, *n = NULL;
 	u32 slen, tlen, nlen;
 
-	if (context_struct_to_string(scontext, &s, &slen) < 0)
+	if (context_struct_to_string(p, scontext, &s, &slen) < 0)
 		goto out;
-	if (context_struct_to_string(tcontext, &t, &tlen) < 0)
+	if (context_struct_to_string(p, tcontext, &t, &tlen) < 0)
 		goto out;
-	if (context_struct_to_string(newcontext, &n, &nlen) < 0)
+	if (context_struct_to_string(p, newcontext, &n, &nlen) < 0)
 		goto out;
 	audit_log(current->audit_context,
 		  "security_compute_sid:  invalid context %s"
 		  " for scontext=%s"
 		  " tcontext=%s"
 		  " tclass=%s",
-		  n, s, t, policydb.p_class_val_to_name[tclass-1]);
+		  n, s, t, p->p_class_val_to_name[tclass-1]);
 out:
 	kfree(s);
 	kfree(t);
@@ -600,6 +603,7 @@ static int security_compute_sid(u32 ssid,
 				u32 specified,
 				u32 *out_sid)
 {
+	struct policydb *p;
 	struct context *scontext = NULL, *tcontext = NULL, newcontext;
 	struct role_trans *roletr = NULL;
 	struct avtab_key avkey;
@@ -608,7 +612,10 @@ static int security_compute_sid(u32 ssid,
 	unsigned int type_change = 0;
 	int rc = 0;
 
-	if (!ss_initialized) {
+	POLICY_RDLOCK;
+	p = policydb;
+
+	if (!p) {
 		switch (tclass) {
 		case SECCLASS_PROCESS:
 			*out_sid = ssid;
@@ -620,16 +627,14 @@ static int security_compute_sid(u32 ssid,
 		goto out;
 	}
 
-	POLICY_RDLOCK;
-
-	scontext = sidtab_search(&sidtab, ssid);
+	scontext = sidtab_search(p->sidtab, ssid);
 	if (!scontext) {
 		printk(KERN_ERR "security_compute_sid:  unrecognized SID %d\n",
 		       ssid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
-	tcontext = sidtab_search(&sidtab, tsid);
+	tcontext = sidtab_search(p->sidtab, tsid);
 	if (!tcontext) {
 		printk(KERN_ERR "security_compute_sid:  unrecognized SID %d\n",
 		       tsid);
@@ -670,11 +675,11 @@ static int security_compute_sid(u32 ssid,
 	avkey.source_type = scontext->type;
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
-	avdatum = avtab_search(&policydb.te_avtab, &avkey, AVTAB_TYPE);
+	avdatum = avtab_search(&p->te_avtab, &avkey, AVTAB_TYPE);
 
 	/* If no permanent rule, also check for enabled conditional rules */
 	if(!avdatum) {
-		node = avtab_search_node(&policydb.te_cond_avtab, &avkey, specified);
+		node = avtab_search_node(&p->te_cond_avtab, &avkey, specified);
 		for (; node != NULL; node = avtab_search_node_next(node, specified)) {
 			if (node->datum.specified & AVTAB_ENABLED) {
 				avdatum = &node->datum;
@@ -704,7 +709,7 @@ static int security_compute_sid(u32 ssid,
 	case SECCLASS_PROCESS:
 		if (specified & AVTAB_TRANSITION) {
 			/* Look for a role transition rule. */
-			for (roletr = policydb.role_tr; roletr;
+			for (roletr = p->role_tr; roletr;
 			     roletr = roletr->next) {
 				if (roletr->role == scontext->role &&
 				    roletr->type == tcontext->type) {
@@ -741,16 +746,14 @@ static int security_compute_sid(u32 ssid,
 		goto out_unlock;
 
 	/* Check the validity of the context. */
-	if (!policydb_context_isvalid(&policydb, &newcontext)) {
-		rc = compute_sid_handle_invalid_context(scontext,
-							tcontext,
-							tclass,
-							&newcontext);
+	if (!policydb_context_isvalid(p, &newcontext)) {
+		rc = compute_sid_handle_invalid_context(p, scontext, tcontext,
+							tclass, &newcontext);
 		if (rc)
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
-	rc = sidtab_context_to_sid(&sidtab, &newcontext, out_sid);
+	rc = sidtab_context_to_sid(p->sidtab, &newcontext, out_sid);
 out_unlock:
 	POLICY_RDUNLOCK;
 	context_destroy(&newcontext);
@@ -914,7 +917,7 @@ static int clone_sid(u32 sid,
 	return sidtab_insert(s, sid, context);
 }
 
-static inline int convert_context_handle_invalid_context(struct context *context)
+static inline int convert_context_handle_invalid_context(struct policydb *p, struct context *context)
 {
 	int rc = 0;
 
@@ -924,7 +927,7 @@ static inline int convert_context_handle_invalid_context(struct context *context
 		char *s;
 		u32 len;
 
-		context_struct_to_string(context, &s, &len);
+		context_struct_to_string(p, context, &s, &len);
 		printk(KERN_ERR "security:  context %s is invalid\n", s);
 		kfree(s);
 	}
@@ -994,7 +997,7 @@ static int convert_context(u32 key,
 
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(args->newp, c)) {
-		rc = convert_context_handle_invalid_context(&oldc);
+		rc = convert_context_handle_invalid_context(args->oldp, &oldc);
 		if (rc)
 			goto bad;
 	}
@@ -1003,7 +1006,7 @@ static int convert_context(u32 key,
 out:
 	return rc;
 bad:
-	context_struct_to_string(&oldc, &s, &len);
+	context_struct_to_string(args->oldp, &oldc, &s, &len);
 	context_destroy(&oldc);
 	printk(KERN_ERR "security:  invalidating context %s\n", s);
 	kfree(s);
@@ -1012,6 +1015,17 @@ bad:
 
 extern void selinux_complete_init(void);
 
+void policydb_destroy_rcu(struct rcu_head *p)
+{
+	struct policydb *olddb;
+	olddb = container_of(p, struct policydb, rhead);
+
+	sidtab_destroy(olddb->sidtab);
+	policydb_destroy(olddb);
+	kfree(olddb);
+	printk("kfree(olddb) in policydb_destroy_rcu() preempt()=0x%x\n",preempt_count());
+}
+
 /**
  * security_load_policy - Load a security policy configuration.
  * @data: binary policy data
@@ -1024,27 +1038,32 @@ extern void selinux_complete_init(void);
  */
 int security_load_policy(void *data, size_t len)
 {
-	struct policydb oldpolicydb, newpolicydb;
-	struct sidtab oldsidtab, newsidtab;
+	struct policydb *newdb, *olddb;
 	struct convert_context_args args;
 	u32 seqno;
 	int rc = 0;
 	struct policy_file file = { data, len }, *fp = &file;
 
+	newdb = kmalloc(sizeof(struct policydb), GFP_KERNEL);
+	if (!newdb)
+		return -ENOMEM;
+
 	LOAD_LOCK;
+	olddb = policydb;
 
-	if (!ss_initialized) {
+	if (!olddb) {
 		avtab_cache_init();
-		if (policydb_read(&policydb, fp)) {
+		if (policydb_read(newdb, fp)) {
 			LOAD_UNLOCK;
 			return -EINVAL;
 		}
-		if (policydb_load_isids(&policydb, &sidtab)) {
+		if (policydb_load_isids(newdb, newdb->sidtab)) {
 			LOAD_UNLOCK;
-			policydb_destroy(&policydb);
+			policydb_destroy(newdb);
 			return -EINVAL;
 		}
-		ss_initialized = 1;
+		smp_wmb();
+		policydb = newdb;
 
 		LOAD_UNLOCK;
 		selinux_complete_init();
@@ -1055,15 +1074,13 @@ int security_load_policy(void *data, size_t len)
 	sidtab_hash_eval(&sidtab, "sids");
 #endif
 
-	if (policydb_read(&newpolicydb, fp)) {
+	if (policydb_read(newdb, fp)) {
 		LOAD_UNLOCK;
 		return -EINVAL;
 	}
 
-	sidtab_init(&newsidtab);
-
 	/* Verify that the existing classes did not change. */
-	if (hashtab_map(policydb.p_classes.table, validate_class, &newpolicydb)) {
+	if (hashtab_map(olddb->p_classes.table, validate_class, newdb)) {
 		printk(KERN_ERR "security:  the definition of an existing "
 		       "class changed\n");
 		rc = -EINVAL;
@@ -1071,34 +1088,26 @@ int security_load_policy(void *data, size_t len)
 	}
 
 	/* Clone the SID table. */
-	sidtab_shutdown(&sidtab);
-	if (sidtab_map(&sidtab, clone_sid, &newsidtab)) {
+	sidtab_shutdown(olddb->sidtab);
+	if (sidtab_map(olddb->sidtab, clone_sid, newdb->sidtab)) {
 		rc = -ENOMEM;
 		goto err;
 	}
 
 	/* Convert the internal representations of contexts
 	   in the new SID table and remove invalid SIDs. */
-	args.oldp = &policydb;
-	args.newp = &newpolicydb;
-	sidtab_map_remove_on_error(&newsidtab, convert_context, &args);
-
-	/* Save the old policydb and SID table to free later. */
-	memcpy(&oldpolicydb, &policydb, sizeof policydb);
-	sidtab_set(&oldsidtab, &sidtab);
-
-	/* Install the new policydb and SID table. */
-	POLICY_WRLOCK;
-	memcpy(&policydb, &newpolicydb, sizeof policydb);
-	sidtab_set(&sidtab, &newsidtab);
+	args.oldp = olddb;
+	args.newp = newdb;
+	sidtab_map_remove_on_error(newdb->sidtab, convert_context, &args);
+
+	/* update policydb atomically */
+	smp_wmb();
+	policydb = newdb;
 	seqno = ++latest_granting;
 
-	POLICY_WRUNLOCK;
 	LOAD_UNLOCK;
 
-	/* Free the old policydb and SID table. */
-	policydb_destroy(&oldpolicydb);
-	sidtab_destroy(&oldsidtab);
+	call_rcu(&olddb->rhead, policydb_destroy_rcu);
 
 	avc_ss_reset(seqno);
 	selnl_notify_policyload(seqno);
@@ -1107,8 +1116,8 @@ int security_load_policy(void *data, size_t len)
 
 err:
 	LOAD_UNLOCK;
-	sidtab_destroy(&newsidtab);
-	policydb_destroy(&newpolicydb);
+	sidtab_destroy(newdb->sidtab);
+	policydb_destroy(newdb);
 	return rc;
 
 }
@@ -1127,12 +1136,19 @@ int security_port_sid(u16 domain,
 		      u16 port,
 		      u32 *out_sid)
 {
+	struct policydb *p;
 	struct ocontext *c;
 	int rc = 0;
 
 	POLICY_RDLOCK;
+	p = policydb;
 
-	c = policydb.ocontexts[OCON_PORT];
+	if (!p) {
+		*out_sid = SECINITSID_PORT;
+		goto out;
+	}
+
+	c = p->ocontexts[OCON_PORT];
 	while (c) {
 		if (c->u.port.protocol == protocol &&
 		    c->u.port.low_port <= port &&
@@ -1143,7 +1159,7 @@ int security_port_sid(u16 domain,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = sidtab_context_to_sid(p->sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -1170,11 +1186,19 @@ int security_netif_sid(char *name,
 		       u32 *msg_sid)
 {
 	int rc = 0;
+	struct policydb *p;
 	struct ocontext *c;
 
 	POLICY_RDLOCK;
+	p = policydb;
+
+	if (!p) {
+		*if_sid = SECINITSID_NETIF;
+		*msg_sid = SECINITSID_NETMSG;
+		goto out;
+	}
 
-	c = policydb.ocontexts[OCON_NETIF];
+	c = p->ocontexts[OCON_NETIF];
 	while (c) {
 		if (strcmp(name, c->u.name) == 0)
 			break;
@@ -1183,12 +1207,12 @@ int security_netif_sid(char *name,
 
 	if (c) {
 		if (!c->sid[0] || !c->sid[1]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = sidtab_context_to_sid(p->sidtab,
 						  &c->context[0],
 						  &c->sid[0]);
 			if (rc)
 				goto out;
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = sidtab_context_to_sid(p->sidtab,
 						   &c->context[1],
 						   &c->sid[1]);
 			if (rc)
@@ -1232,9 +1256,16 @@ int security_node_sid(u16 domain,
 		      u32 *out_sid)
 {
 	int rc = 0;
+	struct policydb *p;
 	struct ocontext *c;
 
 	POLICY_RDLOCK;
+	p = policydb;
+
+	if (!p) {
+		*out_sid = SECINITSID_NODE;
+		goto out;
+	}
 
 	switch (domain) {
 	case AF_INET: {
@@ -1247,7 +1278,7 @@ int security_node_sid(u16 domain,
 
 		addr = *((u32 *)addrp);
 
-		c = policydb.ocontexts[OCON_NODE];
+		c = p->ocontexts[OCON_NODE];
 		while (c) {
 			if (c->u.node.addr == (addr & c->u.node.mask))
 				break;
@@ -1261,7 +1292,7 @@ int security_node_sid(u16 domain,
 			rc = -EINVAL;
 			goto out;
 		}
-		c = policydb.ocontexts[OCON_NODE6];
+		c = p->ocontexts[OCON_NODE6];
 		while (c) {
 			if (match_ipv6_addrmask(addrp, c->u.node6.addr,
 						c->u.node6.mask))
@@ -1277,7 +1308,7 @@ int security_node_sid(u16 domain,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = sidtab_context_to_sid(p->sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -1314,6 +1345,7 @@ int security_get_user_sids(u32 fromsid,
 			   u32 **sids,
 			   u32 *nel)
 {
+	struct policydb *p;
 	struct context *fromcon, usercon;
 	u32 *mysids, *mysids2, sid;
 	u32 mynel = 0, maxnel = SIDS_NEL;
@@ -1322,54 +1354,55 @@ int security_get_user_sids(u32 fromsid,
 	struct av_decision avd;
 	int rc = 0, i, j;
 
-	if (!ss_initialized) {
+	POLICY_RDLOCK;
+	p = policydb;
+
+	if (!p) {
 		*sids = NULL;
 		*nel = 0;
 		goto out;
 	}
 
-	POLICY_RDLOCK;
-
-	fromcon = sidtab_search(&sidtab, fromsid);
+	fromcon = sidtab_search(p->sidtab, fromsid);
 	if (!fromcon) {
 		rc = -EINVAL;
-		goto out_unlock;
+		goto out;
 	}
 
-	user = hashtab_search(policydb.p_users.table, username);
+	user = hashtab_search(p->p_users.table, username);
 	if (!user) {
 		rc = -EINVAL;
-		goto out_unlock;
+		goto out;
 	}
 	usercon.user = user->value;
 
 	mysids = kmalloc(maxnel*sizeof(*mysids), GFP_ATOMIC);
 	if (!mysids) {
 		rc = -ENOMEM;
-		goto out_unlock;
+		goto out;
 	}
 	memset(mysids, 0, maxnel*sizeof(*mysids));
 
 	for (i = ebitmap_startbit(&user->roles); i < ebitmap_length(&user->roles); i++) {
 		if (!ebitmap_get_bit(&user->roles, i))
 			continue;
-		role = policydb.role_val_to_struct[i];
+		role = p->role_val_to_struct[i];
 		usercon.role = i+1;
 		for (j = ebitmap_startbit(&role->types); j < ebitmap_length(&role->types); j++) {
 			if (!ebitmap_get_bit(&role->types, j))
 				continue;
 			usercon.type = j+1;
 			mls_for_user_ranges(user,usercon) {
-				rc = context_struct_compute_av(fromcon, &usercon,
+				rc = context_struct_compute_av(p, fromcon, &usercon,
 							       SECCLASS_PROCESS,
 							       PROCESS__TRANSITION,
 							       &avd);
 				if (rc ||  !(avd.allowed & PROCESS__TRANSITION))
 					continue;
-				rc = sidtab_context_to_sid(&sidtab, &usercon, &sid);
+				rc = sidtab_context_to_sid(p->sidtab, &usercon, &sid);
 				if (rc) {
 					kfree(mysids);
-					goto out_unlock;
+					goto out;
 				}
 				if (mynel < maxnel) {
 					mysids[mynel++] = sid;
@@ -1379,7 +1412,7 @@ int security_get_user_sids(u32 fromsid,
 					if (!mysids2) {
 						rc = -ENOMEM;
 						kfree(mysids);
-						goto out_unlock;
+						goto out;
 					}
 					memset(mysids2, 0, maxnel*sizeof(*mysids2));
 					memcpy(mysids2, mysids, mynel * sizeof(*mysids2));
@@ -1394,10 +1427,8 @@ int security_get_user_sids(u32 fromsid,
 
 	*sids = mysids;
 	*nel = mynel;
-
-out_unlock:
-	POLICY_RDUNLOCK;
 out:
+	POLICY_RDUNLOCK;
 	return rc;
 }
 
@@ -1418,13 +1449,21 @@ int security_genfs_sid(const char *fstype,
 		       u32 *sid)
 {
 	int len;
+	struct policydb *p;
 	struct genfs *genfs;
 	struct ocontext *c;
 	int rc = 0, cmp = 0;
 
 	POLICY_RDLOCK;
+	p = policydb;
 
-	for (genfs = policydb.genfs; genfs; genfs = genfs->next) {
+	if (!p) {
+		*sid = SECINITSID_UNLABELED;
+		rc = -ENOENT;
+		goto out;
+	}
+
+	for (genfs = p->genfs; genfs; genfs = genfs->next) {
 		cmp = strcmp(fstype, genfs->fstype);
 		if (cmp <= 0)
 			break;
@@ -1450,7 +1489,7 @@ int security_genfs_sid(const char *fstype,
 	}
 
 	if (!c->sid[0]) {
-		rc = sidtab_context_to_sid(&sidtab,
+		rc = sidtab_context_to_sid(p->sidtab,
 					   &c->context[0],
 					   &c->sid[0]);
 		if (rc)
@@ -1475,11 +1514,19 @@ int security_fs_use(
 	u32 *sid)
 {
 	int rc = 0;
+	struct policydb *p;
 	struct ocontext *c;
 
 	POLICY_RDLOCK;
+	p = policydb;
+
+	if (!p) {
+		*sid = SECINITSID_UNLABELED;
+		*behavior = SECURITY_FS_USE_NONE;
+		goto out;
+	}
 
-	c = policydb.ocontexts[OCON_FSUSE];
+	c = p->ocontexts[OCON_FSUSE];
 	while (c) {
 		if (strcmp(fstype, c->u.name) == 0)
 			break;
@@ -1489,7 +1536,7 @@ int security_fs_use(
 	if (c) {
 		*behavior = c->v.behavior;
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab,
+			rc = sidtab_context_to_sid(p->sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -1514,12 +1561,23 @@ out:
 int security_get_bools(int *len, char ***names, int **values)
 {
 	int i, rc = -ENOMEM;
+	struct policydb *p;
 
 	POLICY_RDLOCK;
+	p = policydb;
+	if (!p) {
+		*len = 0;
+		*names = NULL;
+		*values = NULL;
+		rc = 0;
+		goto out;
+	}
+
+
 	*names = NULL;
 	*values = NULL;
 
-	*len = policydb.p_bools.nprim;
+	*len = p->p_bools.nprim;
 	if (!*len) {
 		rc = 0;
 		goto out;
@@ -1536,12 +1594,12 @@ int security_get_bools(int *len, char ***names, int **values)
 
 	for (i = 0; i < *len; i++) {
 		size_t name_len;
-		(*values)[i] = policydb.bool_val_to_struct[i]->state;
-		name_len = strlen(policydb.p_bool_val_to_name[i]) + 1;
+		(*values)[i] = p->bool_val_to_struct[i]->state;
+		name_len = strlen(p->p_bool_val_to_name[i]) + 1;
 		(*names)[i] = (char*)kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
 		if (!(*names)[i])
 			goto err;
-		strncpy((*names)[i], policydb.p_bool_val_to_name[i], name_len);
+		strncpy((*names)[i], p->p_bool_val_to_name[i], name_len);
 		(*names)[i][name_len - 1] = 0;
 	}
 	rc = 0;
@@ -1564,40 +1622,51 @@ int security_set_bools(int len, int *values)
 {
 	int i, rc = 0;
 	int lenp, seqno = 0;
+	struct policydb *newdb, *olddb;
 	struct cond_node *cur;
 
-	POLICY_WRLOCK;
+	LOAD_LOCK;
+	olddb = policydb;
 
-	lenp = policydb.p_bools.nprim;
+	lenp = olddb->p_bools.nprim;
 	if (len != lenp) {
 		rc = -EFAULT;
 		goto out;
 	}
+	newdb = cond_policydb_dup(olddb);
+	if (!newdb) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	printk(KERN_INFO "security: committed booleans { ");
 	for (i = 0; i < len; i++) {
 		if (values[i]) {
-			policydb.bool_val_to_struct[i]->state = 1;
+			newdb->bool_val_to_struct[i]->state = 1;
 		} else {
-			policydb.bool_val_to_struct[i]->state = 0;
+			newdb->bool_val_to_struct[i]->state = 0;
 		}
 		if (i != 0)
 			printk(", ");
-		printk("%s:%d", policydb.p_bool_val_to_name[i],
-		       policydb.bool_val_to_struct[i]->state);
+		printk("%s:%d", newdb->p_bool_val_to_name[i],
+		       newdb->bool_val_to_struct[i]->state);
 	}
 	printk(" }\n");
 
-	for (cur = policydb.cond_list; cur != NULL; cur = cur->next) {
-		rc = evaluate_cond_node(&policydb, cur);
-		if (rc)
+	for (cur = newdb->cond_list; cur != NULL; cur = cur->next) {
+		rc = evaluate_cond_node(newdb, cur);
+		if (rc) {
+			call_rcu(&newdb->rhead, cond_policydb_free_rcu);
 			goto out;
+		}
 	}
-
+	smp_wmb();
+	policydb = newdb;
 	seqno = ++latest_granting;
 
+	call_rcu(&olddb->rhead, cond_policydb_free_rcu);
 out:
-	POLICY_WRUNLOCK;
+	LOAD_UNLOCK;
 	if (!rc) {
 		avc_ss_reset(seqno);
 		selnl_notify_policyload(seqno);
@@ -1609,16 +1678,23 @@ int security_get_bool_value(int bool)
 {
 	int rc = 0;
 	int len;
+	struct policydb *p;
 
 	POLICY_RDLOCK;
+	p = policydb;
+	if (!p) {
+		rc = -EFAULT;
+		goto out;
+	}
+
 
-	len = policydb.p_bools.nprim;
+	len = p->p_bools.nprim;
 	if (bool >= len) {
 		rc = -EFAULT;
 		goto out;
 	}
 
-	rc = policydb.bool_val_to_struct[bool]->state;
+	rc = p->bool_val_to_struct[bool]->state;
 out:
 	POLICY_RDUNLOCK;
 	return rc;
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index c7030aee83d..5816345a92f 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -14,8 +14,8 @@
  * when providing its services:  the SID table (sidtab)
  * and the policy database (policydb).
  */
-extern struct sidtab sidtab;
-extern struct policydb policydb;
+//extern struct sidtab sidtab;
+extern struct policydb *policydb;
 
 #endif	/* _SS_SERVICES_H_ */
 
-- 
2.19.1


--------------F414D7E22F25BAEF94667B9C--
