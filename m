Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD18EC48BE0
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 10:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA45C613E7
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 10:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhFKKSS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Jun 2021 06:18:18 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48860 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230291AbhFKKSR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Jun 2021 06:18:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uc2UO4S_1623406576;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Uc2UO4S_1623406576)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Jun 2021 18:16:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nathan@kernel.org, ndesaulniers@google.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next v2] selinux: Fix kernel-doc
Date:   Fri, 11 Jun 2021 18:16:07 +0800
Message-Id: <1623406567-51427-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix function name and add comment for parameter state in ss/services.c 
kernel-doc to remove some warnings found by running make W=1 LLVM=1.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

Change in v2
--Add comment for parameter state

 security/selinux/ss/services.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3658488..d84c77f 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -859,6 +859,7 @@ int security_validate_transition(struct selinux_state *state,
  * It returns 0, if @newsid is bounded by @oldsid.
  * Otherwise, it returns error code.
  *
+ * @state: SELinux state
  * @oldsid : current security identifier
  * @newsid : destinated security identifier
  */
@@ -1098,6 +1099,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 
 /**
  * security_compute_av - Compute access vector decisions.
+ * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
@@ -1386,6 +1388,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 
 /**
  * security_sid_to_context - Obtain a context for a given SID.
+ * @state: SELinux state
  * @sid: security identifier, SID
  * @scontext: security context
  * @scontext_len: length in bytes
@@ -1411,6 +1414,7 @@ int security_sid_to_context_force(struct selinux_state *state, u32 sid,
 /**
  * security_sid_to_context_inval - Obtain a context for a given SID if it
  *                                 is invalid.
+ * @state: SELinux state
  * @sid: security identifier, SID
  * @scontext: security context
  * @scontext_len: length in bytes
@@ -1587,6 +1591,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 
 /**
  * security_context_to_sid - Obtain a SID for a given security context.
+ * @state: SELinux state
  * @scontext: security context
  * @scontext_len: length in bytes
  * @sid: security identifier, SID
@@ -1616,6 +1621,7 @@ int security_context_str_to_sid(struct selinux_state *state,
  * security_context_to_sid_default - Obtain a SID for a given security context,
  * falling back to specified default if needed.
  *
+ * @state: SELinux state
  * @scontext: security context
  * @scontext_len: length in bytes
  * @sid: security identifier, SID
@@ -1907,6 +1913,7 @@ static int security_compute_sid(struct selinux_state *state,
 
 /**
  * security_transition_sid - Compute the SID for a new subject/object.
+ * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
@@ -1962,6 +1969,7 @@ int security_member_sid(struct selinux_state *state,
 
 /**
  * security_change_sid - Compute the SID for object relabeling.
+ * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
@@ -2260,6 +2268,7 @@ void selinux_policy_commit(struct selinux_state *state,
 
 /**
  * security_load_policy - Load a security policy configuration.
+ * @state: SELinux state
  * @data: binary policy data
  * @len: length of data in bytes
  *
@@ -2367,6 +2376,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 
 /**
  * security_port_sid - Obtain the SID for a port.
+ * @state: SELinux state
  * @protocol: protocol number
  * @port: port number
  * @out_sid: security identifier
@@ -2423,7 +2433,8 @@ int security_port_sid(struct selinux_state *state,
 }
 
 /**
- * security_pkey_sid - Obtain the SID for a pkey.
+ * security_ib_pkey_sid - Obtain the SID for a pkey.
+ * @state: SELinux state
  * @subnet_prefix: Subnet Prefix
  * @pkey_num: pkey number
  * @out_sid: security identifier
@@ -2482,6 +2493,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 
 /**
  * security_ib_endport_sid - Obtain the SID for a subnet management interface.
+ * @state: SELinux state
  * @dev_name: device name
  * @port: port number
  * @out_sid: security identifier
@@ -2540,6 +2552,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 
 /**
  * security_netif_sid - Obtain the SID for a network interface.
+ * @state: SELinux state
  * @name: interface name
  * @if_sid: interface SID
  */
@@ -2614,6 +2627,7 @@ static int match_ipv6_addrmask(u32 *input, u32 *addr, u32 *mask)
 
 /**
  * security_node_sid - Obtain the SID for a node (host).
+ * @state: SELinux state
  * @domain: communication domain aka address family
  * @addrp: address
  * @addrlen: address length in bytes
@@ -2707,6 +2721,7 @@ int security_node_sid(struct selinux_state *state,
 
 /**
  * security_get_user_sids - Obtain reachable SIDs for a user.
+ * @state: SELinux state
  * @fromsid: starting SID
  * @username: username
  * @sids: array of reachable SIDs for user
@@ -2899,6 +2914,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 
 /**
  * security_genfs_sid - Obtain a SID for a file in a filesystem
+ * @state: SELinux state
  * @fstype: filesystem type
  * @path: path from root of mount
  * @sclass: file security class
@@ -2943,6 +2959,7 @@ int selinux_policy_genfs_sid(struct selinux_policy *policy,
 
 /**
  * security_fs_use - Determine how to handle labeling for a filesystem.
+ * @state: SELinux state
  * @sb: superblock in question
  */
 int security_fs_use(struct selinux_state *state, struct super_block *sb)
@@ -3282,6 +3299,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 
 /**
  * security_net_peersid_resolve - Compare and resolve two network peer SIDs
+ * @state: SELinux state
  * @nlbl_sid: NetLabel SID
  * @nlbl_type: NetLabel labeling protocol type
  * @xfrm_sid: XFRM SID
@@ -3506,6 +3524,7 @@ int security_get_allow_unknown(struct selinux_state *state)
 
 /**
  * security_policycap_supported - Check for a specific policy capability
+ * @state: SELinux state
  * @req_cap: capability
  *
  * Description:
@@ -3840,6 +3859,7 @@ static void security_netlbl_cache_add(struct netlbl_lsm_secattr *secattr,
 
 /**
  * security_netlbl_secattr_to_sid - Convert a NetLabel secattr to a SELinux SID
+ * @state: SELinux state
  * @secattr: the NetLabel packet security attributes
  * @sid: the SELinux SID
  *
@@ -3922,6 +3942,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 
 /**
  * security_netlbl_sid_to_secattr - Convert a SELinux SID to a NetLabel secattr
+ * @state: SELinux state
  * @sid: the SELinux SID
  * @secattr: the NetLabel packet security attributes
  *
-- 
1.8.3.1

