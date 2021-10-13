Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3CCC433EF
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 18:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4CA9610E8
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 18:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJMSYu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSYt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 14:24:49 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF92C061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 11:22:46 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id b12so3471546qtq.3
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3qR2whVOZNJimQzeW9SY62OU7+STvUVrps1zPaKrcbI=;
        b=lZSM7eD57ujb0SdTMYuyrWPQwMDcwrQzW2GRA5myWt+XG2vopyIcPMv4mCw7MDqnas
         2O+kMNdfRCQOs/qHue/WH0KGh483ymPMSn+mrXePMFEHS8fZfwmrWoPKS60mVXdZ44HM
         1M0yb4idxAW7hg8uXwZbu5MZ59mGHWMpX2XPOaO+ZWduz9Ml/RWrTXTZ1QEM+PiQoenj
         sMRQPa0m0T3NdLxtzOmgIyRzK44SEJZih/UfN/gfpkc8nKllP7NspT7xMp6sGf6ma2ic
         sv67p3FBvCZC9LE+ekqSsTaKpS9bmYIyDzqrWgMcFaLFaUPM5c5NJ5Iiq6k4W92v9G3A
         g5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=3qR2whVOZNJimQzeW9SY62OU7+STvUVrps1zPaKrcbI=;
        b=z+YClRdAiWY19KUB0E5dFadCQZdaKWfHXf+GuDtKmZO+Fvxel2S1D4Nj7Z9V8hXmJv
         q25SlJq6pdUIqz0xvsD3skWgh1a14lNNMiYqPYKrLWph+L+/3SjtEM0Ulcf40sZfl90p
         LsoFMmkJwbGKn1DfJnbhgc32Pw2ooawQSXD7quEild5tI9Z2nbvwHCU7g0KnxSHNmXdw
         b0whX7lAx/CQxdaymzRbX6ASnMuxOPmXdYiLyTOiqkHlH7MhXekA2s5pFH9bWoPINBWm
         BRekkkv1HEmhAwf2IJL/406r9o4GQuVJMczu02nwCKMKRRJU8VJVVSH43FLnY5k2kgcg
         9yKA==
X-Gm-Message-State: AOAM530mTLRvgTs0gxr0iPpllWE9+HIEjCGYrr680KmhAYmvUsf257GU
        YdJjnBIfDoGqdpjLcI//tRm/rztImyOk
X-Google-Smtp-Source: ABdhPJwwZiAnKlOO617Fs2PGCC/Q9z+g+JiIqam1c40NVSOORvAQeEFq4TuoIZ3cW0QVKARqRhUuYQ==
X-Received: by 2002:ac8:4995:: with SMTP id f21mr968486qtq.417.1634149364839;
        Wed, 13 Oct 2021 11:22:44 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id c8sm307991qtb.9.2021.10.13.11.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 11:22:44 -0700 (PDT)
Subject: [PATCH] selinux: fix all of the W=1 build warnings
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Wed, 13 Oct 2021 14:22:43 -0400
Message-ID: <163414936359.182539.7706872229418810020.stgit@olly>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There were a number of places in the code where the function
definition did not match the associated comment block as well
at least one file where the appropriate header files were not
included (missing function declaration/prototype); this patch
fixes all of these issue such that building the SELinux code
with "W=1" is now warning free.

 % make W=1 security/selinux/

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/avc.c         |   13 ++++++++++++-
 security/selinux/netlabel.c    |    7 +++++--
 security/selinux/netport.c     |    2 +-
 security/selinux/ss/hashtab.c  |    1 +
 security/selinux/ss/mls.c      |    4 ++++
 security/selinux/ss/services.c |   14 ++++++++++----
 6 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 97f4c944a20f..abcd9740d10f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -547,6 +547,7 @@ static inline struct avc_node *avc_search_node(struct selinux_avc *avc,
 
 /**
  * avc_lookup - Look up an AVC entry.
+ * @avc: the access vector cache
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
@@ -597,6 +598,7 @@ static int avc_latest_notif_update(struct selinux_avc *avc,
 
 /**
  * avc_insert - Insert an AVC entry.
+ * @avc: the access vector cache
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
@@ -825,9 +827,14 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
 
 /**
  * avc_update_node - Update an AVC entry
+ * @avc: the access vector cache
  * @event : Updating event
  * @perms : Permission mask bits
- * @ssid,@tsid,@tclass : identifier of an AVC entry
+ * @driver: xperm driver information
+ * @xperm: xperm permissions
+ * @ssid: AVC entry source sid
+ * @tsid: AVC entry target sid
+ * @tclass : AVC entry target object class
  * @seqno : sequence number when decision was made
  * @xpd: extended_perms_decision to be added to the node
  * @flags: the AVC_* flags, e.g. AVC_EXTENDED_PERMS, or 0.
@@ -928,6 +935,7 @@ static int avc_update_node(struct selinux_avc *avc,
 
 /**
  * avc_flush - Flush the cache
+ * @avc: the access vector cache
  */
 static void avc_flush(struct selinux_avc *avc)
 {
@@ -956,6 +964,7 @@ static void avc_flush(struct selinux_avc *avc)
 
 /**
  * avc_ss_reset - Flush the cache and revalidate migrated permissions.
+ * @avc: the access vector cache
  * @seqno: policy sequence number
  */
 int avc_ss_reset(struct selinux_avc *avc, u32 seqno)
@@ -1105,6 +1114,7 @@ int avc_has_extended_perms(struct selinux_state *state,
 
 /**
  * avc_has_perm_noaudit - Check permissions but perform no auditing.
+ * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
@@ -1156,6 +1166,7 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
 
 /**
  * avc_has_perm - Check permissions and perform any appropriate auditing.
+ * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index abaab7683840..29b88e81869b 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -29,6 +29,7 @@
 /**
  * selinux_netlbl_sidlookup_cached - Cache a SID lookup
  * @skb: the packet
+ * @family: the packet's address family
  * @secattr: the NetLabel security attributes
  * @sid: the SID
  *
@@ -128,6 +129,7 @@ void selinux_netlbl_cache_invalidate(void)
 /**
  * selinux_netlbl_err - Handle a NetLabel packet error
  * @skb: the packet
+ * @family: the packet's address family
  * @error: the error code
  * @gateway: true if host is acting as a gateway, false otherwise
  *
@@ -160,7 +162,6 @@ void selinux_netlbl_sk_security_free(struct sk_security_struct *sksec)
 /**
  * selinux_netlbl_sk_security_reset - Reset the NetLabel fields
  * @sksec: the sk_security_struct
- * @family: the socket family
  *
  * Description:
  * Called when the NetLabel state of a sk_security_struct needs to be reset.
@@ -313,6 +314,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
 /**
  * selinux_netlbl_inet_conn_request - Label an incoming stream connection
  * @req: incoming connection request socket
+ * @family: the request socket's address family
  *
  * Description:
  * A new incoming connection request is represented by @req, we need to label
@@ -343,6 +345,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
 /**
  * selinux_netlbl_inet_csk_clone - Initialize the newly created sock
  * @sk: the new sock
+ * @family: the sock's address family
  *
  * Description:
  * A new connection has been established using @sk, we've already labeled the
@@ -378,7 +381,7 @@ void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 
 /**
  * selinux_netlbl_socket_post_create - Label a socket using NetLabel
- * @sock: the socket to label
+ * @sk: the sock to label
  * @family: protocol family
  *
  * Description:
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index b8bc3897891d..9ba09d11c0f5 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -73,7 +73,7 @@ static unsigned int sel_netport_hashfn(u16 pnum)
 /**
  * sel_netport_find - Search for a port record
  * @protocol: protocol
- * @port: pnum
+ * @pnum: port
  *
  * Description:
  * Search the network port table and return the matching record.  If an entry
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index b8f6b3e0a921..727c3b484bd3 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include "hashtab.h"
+#include "security.h"
 
 static struct kmem_cache *hashtab_node_cachep __ro_after_init;
 
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index d338962fb0c4..3f5fd124342c 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -553,6 +553,7 @@ int mls_compute_sid(struct policydb *p,
 #ifdef CONFIG_NETLABEL
 /**
  * mls_export_netlbl_lvl - Export the MLS sensitivity levels to NetLabel
+ * @p: the policy
  * @context: the security context
  * @secattr: the NetLabel security attributes
  *
@@ -574,6 +575,7 @@ void mls_export_netlbl_lvl(struct policydb *p,
 
 /**
  * mls_import_netlbl_lvl - Import the NetLabel MLS sensitivity levels
+ * @p: the policy
  * @context: the security context
  * @secattr: the NetLabel security attributes
  *
@@ -595,6 +597,7 @@ void mls_import_netlbl_lvl(struct policydb *p,
 
 /**
  * mls_export_netlbl_cat - Export the MLS categories to NetLabel
+ * @p: the policy
  * @context: the security context
  * @secattr: the NetLabel security attributes
  *
@@ -622,6 +625,7 @@ int mls_export_netlbl_cat(struct policydb *p,
 
 /**
  * mls_import_netlbl_cat - Import the MLS categories from NetLabel
+ * @p: the policy
  * @context: the security context
  * @secattr: the NetLabel security attributes
  *
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index c4931bf6f92a..8e92af7dd284 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1102,7 +1102,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
  * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
- * @tclass: target security class
+ * @orig_tclass: target security class
  * @avd: access vector decisions
  * @xperms: extended permissions
  *
@@ -1626,6 +1626,7 @@ int security_context_str_to_sid(struct selinux_state *state,
  * @scontext_len: length in bytes
  * @sid: security identifier, SID
  * @def_sid: default SID to assign on error
+ * @gfp_flags: the allocator get-free-page (GFP) flags
  *
  * Obtains a SID associated with the security context that
  * has the string representation specified by @scontext.
@@ -1919,6 +1920,7 @@ static int security_compute_sid(struct selinux_state *state,
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
+ * @qstr: object name
  * @out_sid: security identifier for new subject/object
  *
  * Compute a SID to use for labeling a new subject or object in the
@@ -1947,6 +1949,7 @@ int security_transition_sid_user(struct selinux_state *state,
 
 /**
  * security_member_sid - Compute the SID for member selection.
+ * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
@@ -2273,6 +2276,7 @@ void selinux_policy_commit(struct selinux_state *state,
  * @state: SELinux state
  * @data: binary policy data
  * @len: length of data in bytes
+ * @load_state: policy load state
  *
  * Load a new set of security policy configuration data,
  * validate it and convert the SID table as necessary.
@@ -2525,7 +2529,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
  * security_ib_endport_sid - Obtain the SID for a subnet management interface.
  * @state: SELinux state
  * @dev_name: device name
- * @port: port number
+ * @port_num: port number
  * @out_sid: security identifier
  */
 int security_ib_endport_sid(struct selinux_state *state,
@@ -2856,9 +2860,10 @@ int security_get_user_sids(struct selinux_state *state,
 
 /**
  * __security_genfs_sid - Helper to obtain a SID for a file in a filesystem
+ * @policy: policy
  * @fstype: filesystem type
  * @path: path from root of mount
- * @sclass: file security class
+ * @orig_sclass: file security class
  * @sid: SID for path
  *
  * Obtain a SID to use for a file in a filesystem that
@@ -2915,7 +2920,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
  * @state: SELinux state
  * @fstype: filesystem type
  * @path: path from root of mount
- * @sclass: file security class
+ * @orig_sclass: file security class
  * @sid: SID for path
  *
  * Acquire policy_rwlock before calling __security_genfs_sid() and release
@@ -3297,6 +3302,7 @@ int security_sid_mls_copy(struct selinux_state *state,
  * @nlbl_sid: NetLabel SID
  * @nlbl_type: NetLabel labeling protocol type
  * @xfrm_sid: XFRM SID
+ * @peer_sid: network peer sid
  *
  * Description:
  * Compare the @nlbl_sid and @xfrm_sid values and if the two SIDs can be

