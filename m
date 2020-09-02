Return-Path: <SRS0=YX5s=CL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4981CC43461
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 13:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40D1208DB
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 13:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="rcFLUH5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIBNU7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:20:59 -0400
Received: from mailomta4-sa.btinternet.com ([213.120.69.10]:23987 "EHLO
        sa-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727783AbgIBNSy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Sep 2020 09:18:54 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20200902131744.VSYZ26396.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052664; 
        bh=4CuCl3ZGb3eXUCF7I0EoQVrYtT38Ut+MJdeqNvA/lBY=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=rcFLUH5k2p4QJljufHs2Yce6uPJrb5iS+4RkrdGBNqgighh5YJVz1nIL1EERUTd1dqGypJLhsoBzwmLmjHfJtUy9jkkfEP6tVVlXKVK47rLM96CdObO6Bmdb4FUqEQNvYczOd9J1KO/E9sDoQR4E19ng2+8rrKYOg/e7pEDrjuy1OLqIcQQ8582vNB8Y5AJ10o905bOFcfYuDdleDy30RTHEPjlRbW874zqMIKt38Uqdte3oGOV8IB5PtVIdH5BWggiyXxYC5bCDme8yyXkt3G2rEdu98QqTyFobbhwOnuGLH6KXf+BhBSanBKCpTvzW6nX7jckc5x/Y/XKzcHcrTQ==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.32.197]
X-OWM-Source-IP: 109.155.32.197 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepieduteeiteeiteejgfeiueejfedvueduvdelkeetudegleekffetgfdvjedvfeeknecuffhomhgrihhnpegtohhnthgvgihtrdhlohgtrghlnecukfhppedutdelrdduheehrdefvddrudeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrfedvrdduleejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehv
        ghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.197) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0EF36B6E; Wed, 2 Sep 2020 14:17:44 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 01/13] libselinux_functions: Convert to markdown
Date:   Wed,  2 Sep 2020 14:17:26 +0100
Message-Id: <20200902131738.18425-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert to markdown

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/libselinux_functions.md | 2179 ++++++++++++++++++-----------------
 1 file changed, 1092 insertions(+), 1087 deletions(-)

diff --git a/src/libselinux_functions.md b/src/libselinux_functions.md
index 9cae37a..b06018a 100644
--- a/src/libselinux_functions.md
+++ b/src/libselinux_functions.md
@@ -2,1096 +2,1101 @@
 
 These functions have been taken from the following header files of
 *libselinux* version 3.0:
--   */usr/include/selinux/avc.h*
--   */usr/include/selinux/context.h*
--   */usr/include/selinux/get_context_list.h*
--   */usr/include/selinux/get_default_type.h*
--   */usr/include/selinux/label.h*
--   */usr/include/selinux/restorecon.h*
--   */usr/include/selinux/selinux.h*
+
+- */usr/include/selinux/avc.h*
+- */usr/include/selinux/context.h*
+- */usr/include/selinux/get_context_list.h*
+- */usr/include/selinux/get_default_type.h*
+- */usr/include/selinux/label.h*
+- */usr/include/selinux/restorecon.h*
+- */usr/include/selinux/selinux.h*
 
 The appropriate ***man**(3)* pages should consulted for detailed usage.
 
-<table>
-<tbody>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Function Name</strong></td>
-<td><strong>Description</strong></td>
-<td><strong>Header File</strong></td>
-</tr>
-<tr>
-<td>avc_add_callback</td>
-<td>Register a callback for security events.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_audit</td>
-<td>Audit the granting or denial of permissions in accordance with the policy. This function is typically called by <strong>avc_has_perm</strong>(3) after a permission check, but can also be called directly by callers who use <strong>avc_has_perm_noaudit</strong>(3) in order to separate the permission check from the auditing. For example, this separation is useful when the permission check must be performed under a lock, to allow the lock to be released before calling the auditing code.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_av_stats</td>
-<td>Log AV table statistics. Logs a message with information about the size and distribution of the access vector table. The audit callback is used to print the message.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_cache_stats</td>
-<td>Get cache access statistics. Fill the supplied structure with information about AVC activity since the last call to <strong>avc_init</strong>(3) or <strong>avc_reset</strong>(3).</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_cleanup</td>
-<td><p>Remove unused SIDs and AVC entries.</p>
-<p>Search the SID table for SID structures with zero reference counts, and remove them along with all AVC entries that reference them. This can be used to return memory to the system.</p></td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_compute_create</td>
-<td>Compute SID for labeling a new object. Call the security server to obtain a context for labeling a new object. Look up the context in the SID table, making a new entry if not found.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_compute_member</td>
-<td><p>Compute SID for polyinstantation.</p>
-<p>Call the security server to obtain a context for labeling an object instance. Look up the context in the SID table, making a new entry if not found.</p></td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td><p>avc_context_to_sid</p>
-<p>avc_context_to_sid_raw</p></td>
-<td>Get SID for context. Look up security context <em>ctx</em> in SID table, making a new entry if <em>ctx</em> is not found. Store a pointer to the SID structure into the memory referenced by <em>sid</em>, returning 0 on success or -1 on error with <em>errno</em> set.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_destroy</td>
-<td><p>Free all AVC structures.</p>
-<p>Destroy all AVC structures and free all allocated memory. User-supplied locking, memory, and audit callbacks will be retained, but security-event callbacks will not. All SID's will be invalidated. User must call <strong>avc_init</strong>(3) if further use of AVC is desired.</p></td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_entry_ref_init</td>
-<td><p>Initialize an AVC entry reference.</p>
-<p>Use this macro to initialize an avc entry reference structure before first use. These structures are passed to <strong>avc_has_perm</strong>(3), which stores cache entry references in them. They can increase performance on repeated queries.</p></td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_get_initial_sid</td>
-<td><p>Get SID for an initial kernel security identifier.</p>
-<p>Get the context for an initial kernel security identifier specified by name using <strong>security_get_initial_context</strong>(3) and then call <strong>avc_context_to_sid</strong>(3) to get the corresponding SID.</p></td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_has_perm</td>
-<td><p>Check permissions and perform any appropriate auditing.</p>
-<p>Check the AVC to determine whether the requested permissions are granted for the SID pair (ssid, tsid), interpreting the permissions based on tclass, and call the security server on a cache miss to obtain a new decision and add it to the cache. Update aeref to refer to an AVC entry with the resulting decisions. Audit the granting or denial of permissions in accordance with the policy. Return 0 if all requested permissions are granted, -1 with errno set to EACCES if any permissions are denied or to another value upon other errors.</p></td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_has_perm_noaudit</td>
-<td>Check permissions but perform no auditing. Check the AVC to determine whether the requested permissions are granted for the SID pair (ssid, tsid), interpreting the permissions based on tclass, and call the security server on a cache miss to obtain a new decision and add it to the cache. Update aeref to refer to an AVC entry with the resulting decisions, and return a copy of the decisions in avd. Return 0 if all requested permissions are granted, -1 with errno set to EACCES if any permissions are denied, or to another value upon other errors. This function is typically called by <strong>avc_has_perm</strong>(3), but may also be called directly to separate permission checking from auditing, e.g. in cases where a lock must be held for the check but should be released for the auditing.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_init (deprecated)</td>
-<td><p>Use <em>avc_open</em></p>
-<p>Initialize the AVC. Initialize the access vector cache. Return 0 on success or -1 with errno set on failure. If msgprefix is NULL, use "uavc". If any callback structure references are NULL, use default methods for those callbacks (see the definition of the callback structures).</p></td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_netlink_acquire_fd</td>
-<td>Create a netlink socket and connect to the kernel.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_netlink_check_nb</td>
-<td>Wait for netlink messages from the kernel.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_netlink_close</td>
-<td>Close the netlink socket.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_netlink_loop</td>
-<td>Acquire netlink socket fd. Allows the application to manage messages from the netlink socket in its own main loop.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_netlink_open</td>
-<td>Release netlink socket fd. Returns ownership of the netlink socket to the library.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_netlink_release_fd</td>
-<td>Check netlink socket for new messages. Called by the application when using <em><strong>avc_netlink_acquire_fd</strong>(3)</em> to process kernel netlink events.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_open</td>
-<td>Initialize the AVC. This function is identical to <strong>avc_init</strong>(3) except the message prefix is set to "avc" and any callbacks desired should be specified via <strong>selinux_set_callback</strong>(3).</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_reset</td>
-<td>Flush the cache and reset statistics. Remove all entries from the cache and reset all access statistics (as returned by <strong>avc_cache_stats</strong>(3)) to zero. The SID mapping is not affected. Return 0 on success, -1 with errno set on error.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>avc_sid_stats</td>
-<td>Log SID table statistics. Log a message with information about the size and distribution of the SID table. The audit callback is used to print the message.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td><p>avc_sid_to_context</p>
-<p>avc_sid_to_context_raw</p></td>
-<td>Get copy of context corresponding to SID. Return a copy of the security context corresponding to the input sid in the memory referenced by ctx. The caller is expected to free the context with <strong>freecon</strong>(3). Return 0 on success, -1 on failure, with errno set to ENOMEM if insufficient memory was available to make the copy, or EINVAL if the input SID is invalid.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>checkPasswdAccess (deprecated)</td>
-<td><p>Use <em><strong>selinux_check_passwd_access</strong>(3)</em> or preferably <em><strong>selinux_check_access</strong>(3)</em></p>
-<p>Check a permission in the passwd class. Return 0 if granted or -1 otherwise.</p></td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>context_free</td>
-<td>Free the storage used by a context.</td>
-<td>context.h</td>
-</tr>
-<tr>
-<td>context_new</td>
-<td>Return a new context initialized to a context string.</td>
-<td>context.h</td>
-</tr>
-<tr>
-<td>context_range_get</td>
-<td>Get a pointer to the range.</td>
-<td>context.h</td>
-</tr>
-<tr>
-<td>context_range_set</td>
-<td>Set the range component. Returns nonzero if unsuccessful.</td>
-<td>context.h</td>
-</tr>
-<tr>
-<td>context_role_get</td>
-<td>Get a pointer to the role.</td>
-<td>context.h</td>
-</tr>
-<tr>
-<td>context_role_set</td>
-<td>Set the role component. Returns nonzero if unsuccessful.</td>
-<td>context.h</td>
-</tr>
-<tr>
-<td>context_str</td>
-<td>Return a pointer to the string value of context_t. Valid until the next call to context_str or context_free for the same context_t*.</td>
-<td>context.h</td>
-</tr>
-<tr>
-<td>context_type_get</td>
-<td>Get a pointer to the type.</td>
-<td>context.h</td>
-</tr>
-<tr>
-<td>context_type_set</td>
-<td>Set the type component. Returns nonzero if unsuccessful.</td>
-<td>context.h</td>
-</tr>
-<tr>
-<td>context_user_get</td>
-<td>Get a pointer to the user.</td>
-<td>context.h</td>
-</tr>
-<tr>
-<td>context_user_set</td>
-<td>Set the user component. Returns nonzero if unsuccessful.</td>
-<td>context.h</td>
-</tr>
-<tr>
-<td><p>fgetfilecon</p>
-<p>fgetfilecon_raw</p></td>
-<td>Wrapper for the xattr API - Get file context, and set *con to refer to it. Caller must free via freecon.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>fini_selinuxmnt</td>
-<td>Clear <em>selinuxmnt</em> variable and free allocated memory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>freecon</td>
-<td>Free the memory allocated for a context by any of the get* calls.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>freeconary (deprecated)</td>
-<td>Free the memory allocated for a context array by <strong>security_compute_user</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>fsetfilecon</p>
-<p>fsetfilecon_raw</p></td>
-<td>Wrapper for the xattr API - Set file context.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>get_default_context</td>
-<td>Get the default security context for a user session for 'user' spawned by 'fromcon' and set *newcon to refer to it. The context will be one of those authorized by the policy, but the selection of a default is subject to user customizable preferences. If 'fromcon' is NULL, defaults to current context. Returns 0 on success or -1 otherwise. Caller must free via freecon. </td>
-<td>get_context_list.h</td>
-</tr>
-<tr>
-<td>get_default_context_with_level</td>
-<td>Same as <strong>get_default_context</strong>(3), but use the provided MLS level rather than the default level for the user. </td>
-<td>get_context_list.h</td>
-</tr>
-<tr>
-<td>get_default_context_with_role</td>
-<td>Same as <strong>get_default_context</strong>(3), but only return a context that has the specified role.</td>
-<td>get_context_list.h</td>
-</tr>
-<tr>
-<td>get_default_context_with_rolelevel</td>
-<td>Same as <strong>get_default_context</strong>(3), but only return a context that has the specified role and level.</td>
-<td>get_context_list.h</td>
-</tr>
-<tr>
-<td>get_default_type</td>
-<td>Get the default type (domain) for 'role' and set 'type' to refer to it. Caller must free via <strong>free</strong>(3). Return 0 on success or -1 otherwise. </td>
-<td>get_default_type.h</td>
-</tr>
-<tr>
-<td>get_ordered_context_list</td>
-<td>Get an ordered list of authorized security contexts for a user session for 'user' spawned by 'fromcon' and set *conary to refer to the NULL-terminated array of contexts. Every entry in the list will be authorized by the policy, but the ordering is subject to user customizable preferences. Returns number of entries in *conary. If 'fromcon' is NULL, defaults to current context. Caller must free via <strong>freeconary</strong>(3).</td>
-<td>get_context_list.h</td>
-</tr>
-<tr>
-<td>get_ordered_context_list_with_level</td>
-<td>Same as <strong>get_ordered_context_list</strong>(3), but use the provided MLS level rather than the default level for the user.</td>
-<td>get_context_list.h</td>
-</tr>
-<tr>
-<td><p>getcon</p>
-<p>getcon_raw</p></td>
-<td>Get current context, and set *con to refer to it. Caller must free via <strong>freecon</strong>(3). </td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>getexeccon</p>
-<p>getexeccon_raw</p></td>
-<td>Get exec context, and set *con to refer to it. Sets *con to NULL if no exec context has been set, i.e. using default. If non-NULL, caller must free via <strong>freecon</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>getfilecon</p>
-<p>getfilecon_raw</p></td>
-<td>Wrapper for the xattr API - Get file context, and set *con to refer to it. Caller must free via <strong>freecon</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>getfscreatecon</p>
-<p>getfscreatecon_raw</p></td>
-<td>Get fscreate context, and set *con to refer to it. Sets *con to NULL if no fs create context has been set, i.e. using default.If non-NULL, caller must free via <strong>freecon</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>getkeycreatecon</p>
-<p>getkeycreatecon_raw</p></td>
-<td>Get keycreate context, and set *con to refer to it. Sets *con to NULL if no key create context has been set, i.e. using default. If non-NULL, caller must free via <strong>freecon</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>getpeercon</p>
-<p>getpeercon_raw</p></td>
-<td>Wrapper for the socket API - Get context of peer socket, and set *con to refer to it. Caller must free via <em><strong>freecon</strong>(3)</em>.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>getpidcon</p>
-<p>getpidcon_raw</p></td>
-<td>Get context of process identified by pid, and set *con to refer to it. Caller must free via <em><strong>freecon</strong>(3)</em>.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>getprevcon</p>
-<p>getprevcon_raw</p></td>
-<td>Get previous context (prior to last exec), and set *con to refer to it. Caller must free via <em><strong>freecon</strong></em>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>getseuser</td>
-<td>Get the SELinux username and level to use for a given Linux username and service. These values may then be passed into the get_ordered_context_list* and get_default_context* functions to obtain a context for the user. Returns 0 on success or -1 otherwise. Caller must free the returned strings via <strong>free</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>getseuserbyname</td>
-<td>Get the SELinux username and level to use for a given Linux username. These values may then be passed into the get_ordered_context_list* and get_default_context* functions to obtain a context for the user. Returns 0 on success or -1 otherwise. Caller must free the returned strings via <strong>free</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>getsockcreatecon</p>
-<p>getsockcreatecon_raw</p></td>
-<td>Get sockcreate context, and set *con to refer to it. Sets *con to NULL if no socket create context has been set, i.e. using default. If non-NULL, caller must free via <strong>freecon</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>init_selinuxmnt</td>
-<td>There is a man page for this, however it is not a user accessible function (internal use only - although the <em>fini_selinuxmnt</em> is reachable).</td>
-<td>-</td>
-</tr>
-<tr>
-<td>is_context_customizable</td>
-<td>Returns whether a file context is customizable, and should not be relabeled.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>is_selinux_enabled</td>
-<td>Return 1 if running on a SELinux kernel, or 0 if not or -1 for error.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>is_selinux_mls_enabled</td>
-<td>Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>lgetfilecon</p>
-<p>lgetfilecon_raw</p></td>
-<td>Wrapper for the xattr API - Get file context, and set *con to refer to it. Caller must free via <strong>freecon</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>lsetfilecon</p>
-<p>lsetfilecon_raw</p></td>
-<td>Wrapper for the xattr API- Set file context for symbolic link.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>manual_user_enter_context</td>
-<td>Allow the user to manually enter a context as a fallback if a list of authorized contexts could not be obtained. Caller must free via <strong>freecon</strong>(3). Returns 0 on success or -1 otherwise. </td>
-<td>get_context_list.h</td>
-</tr>
-<tr>
-<td>matchmediacon</td>
-<td>Match the specified media and against the media contexts configuration and set *con to refer to the resulting context. Caller must free con via freecon.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>matchpathcon (deprecated)</td>
-<td>Match the specified pathname and mode against the file context sconfiguration and set *con to refer to the resulting context.'mode' can be 0 to disable mode matching. Caller must free via freecon. If <strong>matchpathcon_init</strong>(3) has not already been called, then this function will call it upon its first invocation with a NULL path.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>matchpathcon_checkmatches (deprecated)</td>
-<td>Check to see whether any specifications had no matches and report them. The 'str' is used as a prefix for any warning messages.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>matchpathcon_filespec_add (deprecated)</td>
-<td>Maintain an association between an inode and a specification index, and check whether a conflicting specification is already associated with the same inode (e.g. due to multiple hard links). If so, then use the latter of the two specifications based on their order in the file contexts configuration. Return the used specification index. </td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>matchpathcon_filespec_destroy (deprecated)</td>
-<td>Destroy any inode associations that have been added, e.g. to restart for a new filesystem. </td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>matchpathcon_filespec_eval (deprecated)</td>
-<td>Display statistics on the hash table usage for the associations.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>matchpathcon_fini (deprecated)</td>
-<td>Free the memory allocated by matchpathcon_init.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>matchpathcon_index (deprecated)</td>
-<td>Same as <strong>matchpathcon</strong>(3), but return a specification index for later use in a <strong>matchpathcon_filespec_add</strong>(3) call.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>matchpathcon_init (deprecated)</td>
-<td>Load the file contexts configuration specified by 'path' into memory for use by subsequent matchpathcon calls. If 'path' is NULL, then load the active file contexts configuration, i.e. the path returned by <strong>selinux_file_context_path</strong>(3). Unless the MATCHPATHCON_BASEONLY flag has been set, this function also checks for a 'path'.homedirs file and a 'path'.local file and loads additional specifications from them if present.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>matchpathcon_init_prefix (deprecated)</td>
-<td>Same as <strong>matchpathcon_init</strong>(3), but only load entries with regexes that have stems that are prefixes of 'prefix'.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>mode_to_security_class</td>
-<td>Translate mode_t to a security class string name (e.g. <em>S_ISREG</em> = "<em>file</em>").</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>print_access_vector</td>
-<td>Display an access vector in a string representation.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>query_user_context</td>
-<td>Given a list of authorized security contexts for the user, query the user to select one and set *newcon to refer to it. Caller must free via <strong>freecon</strong>(3). Returns 0 on success or -1 otherwise. </td>
-<td>get_context_list.h</td>
-</tr>
-<tr>
-<td>realpath_not_final</td>
-<td>Resolve all of the symlinks and relative portions of a pathname, but NOT the final component (same a <em><strong>realpath</strong>(3)</em> unless the final component is a symlink. Resolved path must be a path of size <em>PATH_MAX + 1</em>.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>rpm_execcon (deprecated)</td>
-<td><strong>Use setexecfilecon and execve</strong> Execute a helper for rpm in an appropriate security context.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_av_perm_to_string</td>
-<td>Convert access vector permissions to string names.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_av_string</td>
-<td>Returns an access vector in a string representation. User must free the returned string via <strong>free</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>security_canonicalize_context</p>
-<p>security_canonicalize_context_raw</p></td>
-<td>Canonicalize a security context. Returns a pointer to the canonical (primary) form of a security context in <em>canoncon</em> that the kernel is using rather than what is provided by the userspace application in <em>con</em>. </td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>security_check_context</p>
-<p>security_check_context_raw</p></td>
-<td>Check the validity of a security context.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_class_to_string</td>
-<td>Convert security class values to string names.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_commit_booleans</td>
-<td>Commit the pending values for the booleans.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>security_compute_av</p>
-<p>security_compute_av_raw</p></td>
-<td><p>Compute an access decision. </p>
-<p>Queries whether the policy permits the source context <em>scon</em> to access the target context <em>tcon</em> via class <em>tclass</em> with the <em>requested</em> access vector. The decision is returned in <em>avd</em>.</p></td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>security_compute_av_flags</p>
-<p>security_compute_av_flags_raw</p></td>
-<td><p>Compute an access decision and return the flags. </p>
-<p>Queries whether the policy permits the source context <em>scon</em> to access the target context <em>tcon</em> via class <em>tclass</em> with the <em>requested</em> access vector. The decision is returned in <em>avd</em>. that has an additional <em><strong>flags</strong></em> entry. Currently the only flag defined is SELINUX_AVD_FLAGS_PERMISSIVE that indicates the decision was computed on a permissive domain (i.e. the <em><strong>permissive</strong></em> policy language statement has been used in policy or <em><strong>semanage</strong>(8)</em> has been used to set the domain in permissive mode). Note this does not indicate that SELinux is running in permissive mode, only the <em>scon</em> domain.</p></td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>security_compute_create</p>
-<p>security_compute_create_raw</p></td>
-<td>Compute a labeling decision and set *newcon to refer to it. Caller must free via <strong>freecon</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>security_compute_create_name</p>
-<p>security_compute_create_name_raw</p></td>
-<td><p>This is identical to<em> <strong>security_compute_create</strong>(3)</em> but also takes the name of the new object in creation as an argument.</p>
-<p>When a <em>type_transition</em> rule on the given class and the <em>scon</em> / <em>tcon</em> pair has an object name extension, <em>newcon</em> will be returned according to the policy. Note that this interface is only supported on the kernels 2.6.40 or later. For older kernels the object name is ignored.</p></td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>security_compute_member</p>
-<p>security_compute_member_raw</p></td>
-<td>Compute a polyinstantiation member decision and set *newcon to refer to it. Caller must free via <strong>freecon</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>security_compute_relabel</p>
-<p>security_compute_relabel_raw</p></td>
-<td>Compute a relabeling decision and set *newcon to refer to it. Caller must free via <strong>freecon</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>security_compute_user (deprecated)</p>
-<p>security_compute_user_raw (deprecated)</p></td>
-<td>Compute the set of reachable user contexts and set *con to refer to the NULL-terminated array of contexts. Caller must free via <strong>freeconary</strong>(3). </td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_deny_unknown</td>
-<td>Get the behavior for undefined classes / permissions.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_disable</td>
-<td>Disable SELinux at runtime (must be done prior to initial policy load).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_get_boolean_active</td>
-<td>Get the active value for the boolean.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_get_boolean_names</td>
-<td>Get the boolean names</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_get_boolean_pending</td>
-<td>Get the pending value for the boolean.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>security_get_initial_context</p>
-<p>security_get_initial_context_raw</p></td>
-<td>Get the context of an initial kernel security identifier by name. Caller must free via <strong>freecon</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_getenforce</td>
-<td>Get the enforce flag value.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_load_booleans (deprecated)</td>
-<td>Load policy boolean settings. Path may be NULL, in which case the booleans are loaded from the active policy boolean configuration file.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_load_policy</td>
-<td>Load a policy configuration.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_policyvers</td>
-<td>Get the policy version number.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_set_boolean</td>
-<td>Set the pending value for the boolean.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_set_boolean_list</td>
-<td>Save a list of booleans in a single transaction.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>security_setenforce</td>
-<td>Set the enforce flag value.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>security_validatetrans</p>
-<p>security_validatetrans_raw</p></td>
-<td>Validate a transition. This determines whether a transition from scon to newcon using tcon as the target for object class tclass is valid in the loaded policy. This checks against the mlsvalidatetrans and validatetrans constraints in the loaded policy. Returns 0 if allowed and -1 if an error occurred with errno set.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selabel_close</td>
-<td>Destroy the specified handle, closing files, freeing allocated memory, etc. The handle may not be further used after it has been closed.</td>
-<td>label.h</td>
-</tr>
-<tr>
-<td>selabel_cmp</td>
-<td><p>Compare two label configurations. Returns:</p>
-<p><em>SELABEL_SUBSET</em> if <em>h1</em> is a subset of <em>h2</em></p>
-<p><em>SELABEL_EQUAL</em> if <em>h1</em> is identical to <em>h2</em></p>
-<p><em>SELABEL_SUPERSET</em> if <em>h1</em> is a superset of <em>h2</em></p>
-<p><em>SELABEL_INCOMPARABLE</em> if <em>h1</em> and <em>h2</em> are incomparable</p></td>
-<td>label.h</td>
-</tr>
-<tr>
-<td>selabel_digest</td>
-<td>Retrieve the SHA1 digest and the list of specfiles used to generate the digest. The <em>SELABEL_OPT_DIGEST</em> option must be set in <em><strong>selabel_open</strong>(3)</em> to initiate the digest generation.</td>
-<td>label.h</td>
-</tr>
-<tr>
-<td>selabel_get_digests_all_partial_matches</td>
-<td>Returns true if the digest of all partial matched contexts is the same as the one saved by setxattr, otherwise returns false. The length of the SHA1 digest will always be returned. The caller must free any returned digests.</td>
-<td>label.h</td>
-</tr>
-<tr>
-<td>selabel_hash_all_partial_matches</td>
-<td>Returns true if the digest of all partial matched contexts is the same as the one saved by setxattr, otherwise returns false.</td>
-<td>label.h</td>
-</tr>
-
-<tr>
-<td><p>selabel_lookup</p>
-<p>selabel_lookup_raw</p></td>
-<td>Perform a labeling lookup operation. Return 0 on success, -1 with errno set on failure. The <em>key</em> and <em>type</em> arguments are the inputs to the lookup operation; appropriate values are dictated by the backend in use. The result is returned in the memory pointed to by con and must be freed by freecon.</td>
-<td>label.h</td>
-</tr>
-<tr>
-<td><p>selabel_lookup_best_match</p>
-<p>selabel_lookup_best_match_raw</p></td>
-<td><p>Obtain a best match SELinux security context - Only supported on file backend. The order of precedence for best match is:</p>
-<p>1. An exact match for the real path (key) or</p>
-<p>2. An exact match for any of the links (aliases), or</p>
-<p>3. The longest fixed prefix match.</p></td>
-<td>label.h</td>
-</tr>
-<tr>
-<td>selabel_open</td>
-<td><p>Create a labeling handle.</p>
-<p>Open a labeling backend for use. The available backend identifiers are:</p>
-<p>SELABEL_CTX_FILE - file_contexts.</p>
-<p>SELABEL_CTX_MEDIA - media contexts.</p>
-<p>SELABEL_CTX_X - x_contexts.</p>
-<p><em>SELABEL_CTX_DB</em> - SE-PostgreSQL contexts.</p>
-<p>SELABEL_CTX_ANDROID_PROP – <em>property</em>_contexts.</p>
-<p>S<em>ELABEL_CTX_ANDROID_SERVICE</em> – <em>service_contexts</em>.</p>
-<p> Options may be provided via the opts parameter; available options are:</p>
-<p>SELABEL_OPT_UNUSED - no-op option, useful for unused slots in an array of options.</p>
-<p>SELABEL_OPT_VALIDATE - validate contexts before returning them (boolean value).</p>
-<p>SELABEL_OPT_BASEONLY - don't use local customizations to backend data (boolean value).</p>
-<p>SELABEL_OPT_PATH - specify an alternate path to use when loading backend data.</p>
-<p>SELABEL_OPT_SUBSET - select a subset of the search space as an optimization (file backend).</p>
-<p><em>SELABEL_OPT_DIGEST</em> – request an SHA1 digest of the specfiles.</p>
-<p>Not all options may be supported by every backend. Return value is the created handle on success or NULL with errno set on failure.</p></td>
-<td>label.h</td>
-</tr>
-<tr>
-<td>selabel_partial_match</td>
-<td>label.h</td>
-</tr>
-<tr>
-<td>selabel_stats</td>
-<td>Log a message with information about the number of queries performed, number of unused matching entries, or other operational statistics. Message is backend-specific, some backends may not output a message.</td>
-<td>label.h</td>
-</tr>
-<tr>
-<td>selinux_binary_policy_path</td>
-<td>Return path to the binary policy file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_booleans_path (deprecated)</td>
-<td>Return path to the booleans file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_boolean_sub</td>
-<td>Reads the <em>/etc/selinux/TYPE/booleans.subs_dist</em> file looking for a record with <em>boolean_name</em>. If a record exists <em><strong>selinux_boolean_sub</strong>(3)</em> returns the translated name otherwise it returns the original name. The returned value needs to be freed. On failure NULL will be returned.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_booleans_subs_path</td>
-<td>Returns the path to the <em>booleans.subs_dist</em> configuration file.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_check_access</td>
-<td><p>Used to check if the source context has the access permission for the specified class on the target context. Note that the permission and class are reference strings.</p>
-<p>The <em>aux</em> parameter may reference supplemental auditing information. </p>
-<p>Auditing is handled as described in <em><strong>avc_audit</strong>(3)</em>.</p>
-<p>See <em><strong>security_deny_unknown</strong>(3)</em> for how the <em>deny_unknown</em> flag can influence policy decisions.</p></td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_check_passwd_access (deprecated)</td>
-<td><p><strong>Use selinux_check_access<strong> Check a permission in the passwd class. Return 0 if granted or -1 otherwise.</p>
-<p>Replaced by <em><strong>selinux_check_access</strong>(3)</em></p></td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_check_securetty_context </td>
-<td>Check if the tty_context is defined as a securetty. Return 0 if secure, &lt; 0 otherwise.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_colors_path</td>
-<td>Return path to file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_contexts_path</td>
-<td>Return path to contexts directory under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_current_policy_path</td>
-<td>Return path to the current policy.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_customizable_types_path</td>
-<td>Return path to customizable_types file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_default_context_path</td>
-<td>Return path to default_context file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_default_type_path</td>
-<td>Return path to <em>default_type</em> file.</td>
-<td>get_default_type.h</td>
-</tr>
-<tr>
-<td>selinux_failsafe_context_path</td>
-<td>Return path to failsafe_context file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_file_context_cmp</td>
-<td>Compare two file contexts, return 0 if equivalent.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_file_context_homedir_path</td>
-<td>Return path to <em>file_context.homedir</em> file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_file_context_local_path</td>
-<td>Return path to <em>file_context.local</em> file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_file_context_path</td>
-<td>Return path to <em>file_context</em> file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_file_context_subs_path</td>
-<td>Return path to <em>file_context.subs</em> file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_file_context_subs_dist_path</td>
-<td>Return path to <em>file_context.subs_dist</em> file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_file_context_verify</td>
-<td>Verify the context of the file 'path' against policy. Return 0 if correct.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_get_callback</td>
-<td>Used to get a pointer to the callback function of the given <em>type</em>. Callback functions are set using <em><strong>selinux_set_callback</strong>(3)</em>.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_getenforcemode</td>
-<td>Reads the /etc/selinux/config file and determines whether the machine should be started in enforcing (1), permissive (0) or disabled (-1) mode. </td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_getpolicytype</td>
-<td>Reads the /<em>etc/selinux/config</em> file and determines what the default policy for the machine is. Calling application must free <em>policytype</em>.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_homedir_context_path</td>
-<td>Return path to file under the policy root directory. Note that this file will only appear in older versions of policy at this location. On systems that are managed using <em><strong>semanage</strong>(8)</em> this is now in the policy store.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_init_load_policy</td>
-<td><p>Perform the initial policy load.</p>
-<p>This function determines the desired enforcing mode, sets the the *enforce argument accordingly for the caller to use, sets the SELinux kernel enforcing status to match it, and loads the policy. It also internally handles the initial selinuxfs mount required to perform these actions.</p>
-<p>The function returns 0 if everything including the policy load succeeds. In this case, init is expected to re-exec itself in order to transition to the proper security context. Otherwise, the function returns -1, and init must check *enforce to determine how to proceed. If enforcing (*enforce &gt; 0), then init should halt the system. Otherwise, init may proceed normally without a re-exec.</p></td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_lsetfilecon_default</td>
-<td>This function sets the file context to the system defaults. Returns 0 on success.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_lxc_contexts_path</td>
-<td>Return the path to the <em>lxc_contexts</em> configuration file.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_media_context_path</td>
-<td>Return path to file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_mkload_policy</td>
-<td><p>Make a policy image and load it. </p>
-<p>This function provides a higher level interface for loading policy than <strong>security_load_policy</strong>(3), internally determining the right policy version, locating and opening the policy file, mapping it into memory, manipulating it as needed for current boolean settings and/or local definitions, and then calling <strong>security_load_policy</strong>(3) to load it.</p>
-<p>'preservebools' is a boolean flag indicating whether current policy boolean values should be preserved into the new policy (if 1) or reset to the saved policy settings (if 0). The former case is the default for policy reloads, while the latter case is an option for policy reloads but is primarily for the initial policy load.</p></td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_netfilter_context_path</td>
-<td>Returns path to the netfilter_context file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_path</td>
-<td>Returns path to the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_policy_root</td>
-<td>Reads the /etc/selinux/config file and returns the top level directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_raw_context_to_color</td>
-<td>Perform context translation between security contexts and display colors. Returns a space-separated list of ten ten hex RGB triples prefixed by hash marks, e.g. "#ff0000". Caller must free the resulting string via <strong>free</strong>(3). Returns -1 upon an error or 0 otherwise.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_raw_to_trans_context</td>
-<td>Perform context translation between the human-readable format ("translated") and the internal system format ("raw"). Caller must free the resulting context via <strong>freecon</strong>(3). Returns -1 upon an error or 0 otherwise. If passed NULL, sets the returned context to NULL and returns 0.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_removable_context_path</td>
-<td>Return path to <em>removable_context</em> file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_restorecon</td>
-<td><p>Relabel files that automatically calls <em><strong>selinux_restorecon_default_handle</strong>(3)</em> and <em><strong>selinux_restorecon_set_sehandle</strong>(3)</em> first time through to set the <em><strong>selabel_open</strong>(3)</em> parameters to use the currently loaded policy <em>file_contexts</em> and request their computed digest.</p>
-<p>Should other <em><strong>selabel_open</strong>(3)</em> parameters be required see <em><strong>selinux_restorecon_set_sehandle</strong>(3)</em>.</p></td>
-<td>restorecon.h</td>
-</tr>
-<tr>
-<td>selinux_restorecon_xattr</td>
-<td><p>Read/remove <em>RESTORECON_LAST</em> xattr entries that automatically calls <em><strong>selinux_restorecon_default_handle</strong>(3)</em> and <em><strong>selinux_restorecon_set_sehandle</strong>(3)</em> first time through to set the <em><strong>selabel_open</strong>(3)</em> parameters to use the currently loaded policy <em>file_contexts</em> and request their computed digest.</p>
-<p>Should other <em><strong>selabel_open</strong>(3)</em> parameters be required see <em><strong>selinux_restorecon_set_sehandle</strong>(3)</em>, however note that a <em>file_contexts</em> computed digest is required for <em><strong>selinux_restorecon_xattr</strong>(3)</em>.</p></td>
-<td>restorecon.h</td>
-</tr>
-<tr>
-<td>selinux_restorecon_default_handle</td>
-<td>Sets default <em><strong>selabel_open</strong>(3)</em> parameters to use the currently loaded policy and <em>file_contexts</em>, also requests the digest.</td>
-<td>restorecon.h</td>
-</tr>
-<tr>
-<td>selinux_restorecon_set_alt_rootpath</td>
-<td>Use alternate rootpath.</td>
-<td>restorecon.h</td>
-</tr>
-<tr>
-<td>selinux_restorecon_set_exclude_list</td>
-<td>Add a list of directories that are to be excluded from relabeling.</td>
-<td>restorecon.h</td>
-</tr>
-<tr>
-<td>selinux_restorecon_set_sehandle</td>
-<td>Set the global fc handle. Called by a process that has already called <em><strong>selabel_open</strong>(3)</em> with its required parameters, or if <em><strong>selinux_restorecon_default_handle</strong>(3)</em> has been called to set the default <em><strong>selabel_open</strong>(3)</em> parameters.</td>
-<td>restorecon.h</td>
-</tr>
-<tr>
-<td>selinux_securetty_types_path</td>
-<td>Return path to the securetty_types file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_sepgsql_context_path</td>
-<td>Return path to <em>sepgsql_context</em> file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_set_callback</td>
-<td>Sets the callback according to the type: <em>SELINUX_CB_LOG</em>, <em>SELINUX_CB_AUDIT</em>, <em>SELINUX_CB_VALIDATE</em>, <em>SELINUX_CB_SETENFORCE</em>, <em>SELINUX_CB_POLICYLOAD</em></td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_set_mapping</td>
-<td>Userspace class mapping support that establishes a mapping from a user-provided ordering of object classes and permissions to the numbers actually used by the loaded system policy.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_set_policy_root</td>
-<td>Sets an alternate policy root directory path under which the compiled policy file and context configuration files exist.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_status_open</td>
-<td>Open and map SELinux kernel status page.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>selinux_status_close</td>
-<td>Unmap and close kernel status page.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>selinux_status_updated</td>
-<td>Inform whether the kernel status has been updated.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>selinux_status_getenforce</td>
-<td>Get the enforce flag value.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>selinux_status_policyload</td>
-<td>Get the number of policy loads.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>selinux_status_deny_unknown</td>
-<td>Get behaviour for undefined classes/permissions.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>selinux_systemd_contexts_path</td>
-<td>Returns the path to the <em>systemd_contexts</em> configuration file.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_reset_config</td>
-<td>Force a reset of the loaded configuration. <strong>WARNING</strong>: This is not thread safe. Be very sure that no other threads are calling into <em>libselinux</em> when this is called.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_trans_to_raw_context</td>
-<td>Perform context translation between the human-readable format ("translated") and the internal system format ("raw"). Caller must free the resulting context via <strong>freecon</strong>(3). Returns -1 upon an error or 0 otherwise. If passed NULL, sets the returned context to NULL and returns 0.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_translations_path</td>
-<td>Return path to setrans.conf file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_user_contexts_path</td>
-<td>Return path to file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_users_path (deprecated)</td>
-<td>Return path to file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_usersconf_path</td>
-<td>Return path to file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_virtual_domain_context_path</td>
-<td>Return path to file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_virtual_image_context_path</td>
-<td>Return path to file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinux_x_context_path</td>
-<td>Return path to x_context file under the policy root directory.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>selinuxfs_exists</td>
-<td>Check if selinuxfs exists as a kernel filesystem.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>set_matchpathcon_canoncon (deprecated)</td>
-<td>Same as <strong>set_matchpathcon_invalidcon</strong>(3), but also allows canonicalization of the context, by changing *context to refer to the canonical form. If not set, and invalidcon is also not set, then this defaults to calling <strong>security_canonicalize_context</strong>(3).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>set_matchpathcon_flags (deprecated)</td>
-<td><p>Set flags controlling operation of <strong>matchpathcon_init</strong>(3) or <strong>matchpathcon</strong>(3): </p>
-<p>MATCHPATHCON_BASEONLY - Only process the base file_contexts file. </p>
-<p>MATCHPATHCON_NOTRANS - Do not perform any context translation.</p>
-<p>MATCHPATHCON_VALIDATE - Validate/canonicalize contexts at init time.</p></td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>set_matchpathcon_invalidcon (deprecated)</td>
-<td>Set the function used by <strong>matchpathcon_init</strong>(3) when checking the validity of a context in the file_contexts configuration. If not set, then this defaults to a test based on <strong>security_check_context</strong>(3). The function is also responsible for reporting any such error, and may include the 'path' and 'lineno' in such error messages.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>set_matchpathcon_printf (deprecated)</td>
-<td>Set the function used by <strong>matchpathcon_init</strong>(3) when displaying errors about the file_contexts configuration. If not set, then this defaults to fprintf(stderr, fmt, ...).</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>set_selinuxmnt </td>
-<td>Set the path to the selinuxfs mount point explicitly. Normally, this is determined automatically during libselinux initialization, but this is not always possible, e.g. for /sbin/init which performs the initial mount of selinuxfs.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>setcon</p>
-<p>setcon_raw</p></td>
-<td><p>Set the current security context to con.</p>
-<p>Note that use of this function requires that the entire application be trusted to maintain any desired separation between the old and new security contexts, unlike exec-based transitions performed via <strong>setexeccon</strong>(3). When possible, decompose your application and use <strong>setexeccon</strong>(3)+<strong>execve</strong>(3) instead. Note that the application may lose access to its open descriptors as a result of a <strong>setcon</strong>(3) unless policy allows it to use descriptors opened by the old context. </p></td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>setexeccon</p>
-<p>setexeccon_raw</p></td>
-<td>Set exec security context for the next <strong>execve</strong>(3). Call with NULL if you want to reset to the default.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>setexecfilecon</td>
-<td>Set an appropriate security context based on the filename of a helper program, falling back to a new context with the specified type.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>setfilecon</p>
-<p>setfilecon_raw</p></td>
-<td>Wrapper for the xattr API - Set file context.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>setfscreatecon</p>
-<p>setfscreatecon_raw</p></td>
-<td>Set the fscreate security context for subsequent file creations. Call with NULL if you want to reset to the default.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>setkeycreatecon</p>
-<p>setkeycreatecon_raw</p></td>
-<td>Set the keycreate security context for subsequent key creations. Call with NULL if you want to reset to the default.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td><p>setsockcreatecon</p>
-<p>setsockcreatecon_raw</p></td>
-<td>Set the sockcreate security context for subsequent socket creations. Call with NULL if you want to reset to the default.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>sidget (deprecated)</td>
-<td>From 2.0.86 this is a no-op.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>sidput (deprecated)</td>
-<td>From 2.0.86 this is a no-op.</td>
-<td>avc.h</td>
-</tr>
-<tr>
-<td>string_to_av_perm</td>
-<td>Convert string names to access vector permissions.</td>
-<td>selinux.h</td>
-</tr>
-<tr>
-<td>string_to_security_class</td>
-<td>Convert string names to security class values.</td>
-<td>selinux.h</td>
-</tr>
-</tbody>
-</table>
+Some useful notes:
+
+1. Use ***free**(3)* instead of ***freecon**(3)* for context strings as they
+   are now defined as *char\**. Note this does not apply to ***context_free**(3)*.
+2. There must be more ???
+
+*avc_add_callback* - *avc.h*
+
+Register a callback for security events.
+
+*avc_audit* - *avc.h*
+
+Audit the granting or denial of permissions in accordance with the policy.
+This function is typically called by ***avc_has_perm**(3)* after a permission
+check, but can also be called directly by callers who use
+***avc_has_perm_noaudit**(3)* in order to separate the permission check from
+the auditing. For example, this separation is useful when the permission
+check must be performed under a lock, to allow the lock to be released before
+calling the auditing code.
+
+*avc_av_stats* - *avc.h*
+
+Log AV table statistics. Logs a message with information about the size and
+distribution of the access vector table. The audit callback is used to print
+the message.
+
+*avc_cache_stats* - *avc.h*
+
+Get cache access statistics. Fill the supplied structure with information
+about AVC activity since the last call to ***avc_init**(3)*
+or ***avc_reset**(3)*.
+
+*avc_cleanup* - *avc.h*
+
+Remove unused SIDs and AVC entries. Search the SID table for SID structures
+with zero reference counts, and remove them along with all AVC entries that
+reference them. This can be used to return memory to the system.
+
+*avc_compute_create* - *avc.h*
+
+Compute SID for labeling a new object. Call the security server to obtain
+a context for labeling a new object. Look up the context in the SID table,
+making a new entry if not found.
+
+*avc_compute_member* - *avc.h*
+
+Compute SID for polyinstantation. Call the security server to obtain a
+context for labeling an object instance. Look up the context in the SID table,
+making a new entry if not found.
+
+*avc_context_to_sid*, *avc_context_to_sid_raw* - *avc.h*
+
+Get SID for context. Look up security context *ctx* in SID table, making a new
+entry if *ctx* is not found. Store a pointer to the SID structure into the
+memory referenced by *sid*, returning 0 on success or -1 on error with
+*errno* set.
+
+*avc_destroy* - *avc.h*
+
+Free all AVC structures. Destroy all AVC structures and free all allocated
+memory. User-supplied locking, memory, and audit callbacks will be retained,
+but security-event callbacks will not. All SID's will be invalidated.
+User must call ***avc_init**(3)* if further use of AVC is desired.
+
+*avc_entry_ref_init* - *avc.h*
+
+Initialize an AVC entry reference. Use this macro to initialize an *avc* entry
+reference structure before first use. These structures are passed to
+***avc_has_perm**(3)*, which stores cache entry references in them.
+They can increase performance on repeated queries.
+
+*avc_get_initial_sid* - *avc.h*
+
+Get SID for an initial kernel security identifier. Get the context for an
+initial kernel security identifier specified by name using
+***security_get_initial_context**(3)* and then call
+***avc_context_to_sid**(3)* to get the corresponding SID.
+
+*avc_has_perm* - *avc.h*
+
+Check permissions and perform any appropriate auditing. Check the AVC to
+determine whether the requested permissions are granted for the SID pair
+(*ssid*, *tsid*), interpreting the permissions based on tclass, and call the
+security server on a cache miss to obtain a new decision and add it to the
+cache. Update *aeref* to refer to an AVC entry with the resulting decisions.
+Audit the granting or denial of permissions in accordance with the policy.
+Return 0 if all requested permissions are granted, -1 with errno set to EACCES
+if any permissions are denied or to another value upon other errors.
+
+*avc_has_perm_noaudit* - *avc.h*
+
+Check permissions but perform no auditing. Check the AVC to determine whether
+the requested permissions are granted for the SID pair (*ssid*, *tsid*),
+interpreting the permissions based on tclass, and call the security server
+on a cache miss to obtain a new decision and add it to the cache. Update aeref
+to refer to an AVC entry with the resulting decisions, and return a copy of
+the decisions in *avd*. Return 0 if all requested permissions are granted, -1
+with errno set to EACCES if any permissions are denied, or to another value
+upon other errors. This function is typically called by ***avc_has_perm**(3)*,
+but may also be called directly to separate permission checking from auditing,
+e.g. in cases where a lock must be held for the check but should be released
+for the auditing.
+
+*avc_init* (deprecated)
+
+Use *avc_open*. Initialize the AVC. Initialize the access vector cache.
+Return 0 on success or -1 with errno set on failure. If *msgprefix* is NULL,
+use *uavc*. If any callback structure references are NULL, use default methods
+for those callbacks (see the definition of the callback structures).
+
+*avc_netlink_acquire_fd* - *avc.h*
+
+Create a netlink socket and connect to the kernel.
+
+*avc_netlink_check_nb* - *avc.h*
+
+Wait for netlink messages from the kernel.
+
+*avc_netlink_close* - *avc.h*
+
+Close the netlink socket.
+
+*avc_netlink_loop* - *avc.h*
+
+Acquire netlink socket fd. Allows the application to manage messages from
+the netlink socket in its own main loop.
+
+*avc_netlink_open* - *avc.h*
+
+Release netlink socket fd. Returns ownership of the netlink socket to the
+ibrary.
+
+*avc_netlink_release_fd* - *avc.h*
+
+Check netlink socket for new messages. Called by the application when using
+***avc_netlink_acquire_fd**(3)* to process kernel netlink events.
+
+*avc_open* - *avc.h*
+
+Initialize the AVC. This function is identical to ***avc_init**(3)* except the
+message prefix is set to *avc* and any callbacks desired should be specified
+via ***selinux_set_callback**(3)*.
+
+*avc_reset* - *avc.h*
+
+Flush the cache and reset statistics. Remove all entries from the cache and
+reset all access statistics (as returned by ***avc_cache_stats**(3)*) to zero.
+The SID mapping is not affected. Return 0 on success, -1 with errno set on error.
+
+*avc_sid_stats* - *avc.h*
+
+Log SID table statistics. Log a message with information about the size and
+distribution of the SID table. The audit callback is used to print the message.
+
+avc_sid_to_context*, *avc_sid_to_context_raw* - *avc.h*
+
+Get copy of context corresponding to SID. Return a copy of the security context
+corresponding to the input sid in the memory referenced by *ctx*. The caller is
+expected to free the context with ***freecon**(3)*. Return 0 on success, -1
+on failure, with errno set to ENOMEM if insufficient memory was available to
+make the copy, or EINVAL if the input SID is invalid.
+
+*checkPasswdAccess* (deprecated) - *selinux.h*
+
+Use ***selinux_check_passwd_access**(3)* or preferably
+***selinux_check_access**(3)*. Check a permission in the passwd class.
+Return 0 if granted or -1 otherwise.
+
+*context_free* - *context.h*
+
+Free the storage used by a context structure.
+
+*context_new* - *context.h*
+
+Return a new context initialized to a context string.
+
+*context_range_get* - *context.h*
+
+Get a pointer to the range.
+
+*context_range_set* - *context.h*
+
+Set the range component. Returns nonzero if unsuccessful.
+
+*context_role_get* - *context.h*
+
+Get a pointer to the role.
+
+*context_role_set* - *context.h*
+
+Set the role component. Returns nonzero if unsuccessful.
+
+*context_str* - *context.h*
+
+Return a pointer to the string value of *context_t*. Valid until the next call
+to ***context_str**(3)* or ***context_free**(3)* for the same *context_t*.
+
+*context_type_get* - *context.h*
+
+Get a pointer to the type.
+
+*context_type_set* - *context.h*
+
+Set the type component. Returns nonzero if unsuccessful.
+
+*context_user_get* - *context.h*
+
+Get a pointer to the user.
+
+*context_user_set* - *context.h*
+
+Set the user component. Returns nonzero if unsuccessful.
+
+*fgetfilecon*, *fgetfilecon_raw* - *selinux.h*
+
+Wrapper for the ***xattr**(7)* API - Get file context, and set *\*con* to
+refer to it. Caller must free via ***freecon**(3)*.
+
+*fini_selinuxmnt* - *selinux.h*
+
+Clear *selinuxmnt* variable and free allocated memory.
+
+*freecon* - *selinux.h*
+
+Free the memory allocated for a context by any of the *get\** calls.
+
+*freeconary* - *selinux.h*
+
+Free the memory allocated for a context array by
+***get_ordered_context_list**(3)*.
+
+*fsetfilecon*, *fsetfilecon_raw* - *selinux.h*
+
+Wrapper for the ***xattr**(7)* API - Set file context.
+
+*get_default_context* - *get_context_list.h*
+
+Get the default security context for a user session for *user* spawned by
+*fromcon* and set *\*newcon* to refer to it. The context will be one of those
+authorized by the policy, but the selection of a default is subject to user
+customizable preferences. If *fromcon* is NULL, defaults to current context.
+Returns 0 on success or -1 otherwise. Caller must free via ***freecon**(3)*.
+
+*get_default_context_with_level* - *get_context_list.h*
+
+Same as ***get_default_context**(3)*, but use the provided MLS level rather
+than the default level for the user.
+
+*get_default_context_with_role* - *get_context_list.h*
+
+Same as ***get_default_context**(3)*, but only return a context that
+has the specified role.
+
+*get_default_context_with_rolelevel* - *get_context_list.h*
+
+Same as ***get_default_context**(3)*, but only return a context that has
+the specified role and level.
+
+*get_default_type* - *get_default_type.h*
+
+Get the default type (domain) for *role* and set *type* to refer to it.
+Caller must free via ***free**(3)*.
+Return 0 on success or -1 otherwise.
+
+*get_ordered_context_list* - *get_context_list.h*
+
+Get an ordered list of authorized security contexts for a user session for
+*user* spawned by *fromcon* and set *\*conary* to refer to the NULL-terminated
+array of contexts. Every entry in the list will be authorized by the policy,
+but the ordering is subject to user customizable preferences.
+Returns number of entries in *\*conary*. If *fromcon* is NULL, defaults
+to current context. Caller must free via ***freeconary**(3)*.
+
+*get_ordered_context_list_with_level* - *get_context_list.h*
+
+Same as ***get_ordered_context_list**(3)*, but use the provided MLS level
+rather than the default level for the user.
+
+*getcon*, *getcon_raw* - *selinux.h*
+
+Get current context, and set *\*con* to refer to it. Caller must free via
+***freecon**(3)*.
+
+*getexeccon*, *getexeccon_raw* - *selinux.h*
+
+Get exec context, and set *\*con* to refer to it. Sets *\*con* to NULL if no
+exec context has been set, i.e. using default. If non-NULL, caller must
+free via ***freecon**(3)*.
+
+*getfilecon*, *getfilecon_raw* - *selinux.h*
+
+Wrapper for the ***xattr**(7)* API - Get file context, and set *\*con* to refer
+to it. Caller must free via ***freecon**(3)*.
+
+*getfscreatecon*, *getfscreatecon_raw* - *selinux.h*
+
+Get fscreate context, and set *\*con* to refer to it. Sets *\*con* to NULL if
+no fs create context has been set, i.e. using default.If non-NULL, caller must
+free via ***freecon**(3)*.
+
+*getkeycreatecon* *getkeycreatecon_raw* - *selinux.h*
+
+Get keycreate context, and set *\*con* to refer to it. Sets *\*con* to NULL
+if no key create context has been set, i.e. using default. If non-NULL, caller
+must free via ***freecon**(3)*.
+
+*getpeercon*, *getpeercon_raw* - *selinux.h*
+
+Wrapper for the socket API - Get context of peer socket, and set *\*con* to
+refer to it. Caller must free via ***freecon**(3)*.
+
+*getpidcon*, *getpidcon_raw* - *selinux.h*
+
+Get context of process identified by pid, and set *\*con* to refer to it.
+Caller must free via ***freecon**(3)*.
+
+*getprevcon*, *getprevcon_raw* - *selinux.h*
+
+Get previous context (prior to last exec), and set *\*con* to refer to it.
+Caller must free via ***freecon**(3)*.
+
+*getseuser* - *selinux.h*
+
+Get the SELinux username and level to use for a given Linux username and
+service. These values may then be passed into the
+***get_ordered_context_list**(3)* and ***get_default_context**(3)* functions
+to obtain a context for the user.
+Returns 0 on success or -1 otherwise.
+Caller must free the returned strings via ***free**(3)*.
+
+*getseuserbyname* - *selinux.h*
+
+Get the SELinux username and level to use for a given Linux username.
+These values may then be passed into the ***get_ordered_context_list**(3)*
+and ***get_default_context**(3)* functions to obtain a context for the user.
+Returns 0 on success or -1 otherwise.
+Caller must free the returned strings via ***free**(3)*.
+
+*getsockcreatecon*, *getsockcreatecon_raw* - *selinux.h*
+
+Get sockcreate context, and set *\*con* to refer to it. Sets *\*con* to NULL
+if no socket create context has been set, i.e. using default.
+If non-NULL, caller must free via ***freecon**(3)*.
+
+*init_selinuxmnt* - *selinux.h*
+
+There is a man page for this, however it is not a user accessible function
+(internal use only - although the ***fini_selinuxmnt**(3)* is reachable).
+
+*is_context_customizable* - *selinux.h*
+
+Returns whether a file context is customizable, and should not be relabeled.
+
+*is_selinux_enabled* - *selinux.h*
+
+Return 1 if running on a SELinux kernel, or 0 if not or -1 for error.
+
+*is_selinux_mls_enabled* - *selinux.h*
+
+Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise.
+
+*lgetfilecon*, *lgetfilecon_raw* - *selinux.h*
+
+Wrapper for the ***xattr**(7)* API - Get file context, and set *\*con* to
+refer to it. Caller must free via ***freecon**(3)*.
+
+*lsetfilecon*, *lsetfilecon_raw* - *selinux.h*
+
+Wrapper for the xattr API- Set file context for symbolic link.
+
+*manual_user_enter_context* - *get_context_list.h*
+
+Allow the user to manually enter a context as a fallback if a list of
+authorized contexts could not be obtained. Caller must free via
+***freecon**(3)*. Returns 0 on success or -1 otherwise.
+
+*matchmediacon* - *selinux.h*
+
+Match the specified media and against the media contexts configuration and
+set *\*con* to refer to the resulting context.
+Caller must free con via ***freecon**(3)*.
+
+*matchpathcon* (deprecated) - *selinux.h*
+
+Match the specified *pathname* and *mode* against the file context configuration
+and set *\*con* to refer to the resulting context. *mode* can be 0 to disable
+mode matching. Caller must free via freecon. If ***matchpathcon_init**(3)*
+has not already been called, then this function will call it upon its first
+invocation with a NULL path.
+
+*matchpathcon_checkmatches* (deprecated) - *selinux.h*
+
+Check to see whether any specifications had no matches and report them.
+The *str* is used as a prefix for any warning messages.
+
+*matchpathcon_filespec_add* (deprecated) - *selinux.h*
+
+Maintain an association between an inode and a specification index, and check
+whether a conflicting specification is already associated with the same inode
+(e.g. due to multiple hard links). If so, then use the latter of the two
+specifications based on their order in the file contexts configuration.
+Return the used specification index.
+
+*matchpathcon_filespec_destroy* (deprecated) - *selinux.h*
+
+Destroy any inode associations that have been added, e.g. to restart for a
+new filesystem.
+
+*matchpathcon_filespec_eval* (deprecated) - *selinux.h*
+
+Display statistics on the hash table usage for the associations.
+
+*matchpathcon_fini* (deprecated) - *selinux.h*
+
+Free the memory allocated by ***matchpathcon_init**(3)*.
+
+*matchpathcon_index* (deprecated) - *selinux.h*
+
+Same as ***matchpathcon**(3)*, but return a specification index for later use
+in a ***matchpathcon_filespec_add**(3)* call.
+
+
+*matchpathcon_init* (deprecated) - *selinux.h*
+
+Load the file contexts configuration specified by *path* into memory for use
+by subsequent *matchpathcon* calls. If *path* is NULL, then load the active file
+contexts configuration, i.e. the path returned by
+***selinux_file_context_path**(3)*. Unless the *MATCHPATHCON_BASEONLY* flag
+has been set, this function also checks for a *path.homedirs* file and a
+*path.local* file and loads additional specifications from them if present.
+
+*matchpathcon_init_prefix* (deprecated) - *selinux.h*
+
+Same as ***matchpathcon_init**(3)*, but only load entries with regexes that
+have stems that are prefixes of *prefix*.
+
+*mode_to_security_class* - *selinux.h*
+
+Translate mode_t to a security class string name (e.g. *S_ISREG* = *file*).
+
+*print_access_vector* - *selinux.h*
+
+Display an access vector in a string representation.
+
+*query_user_context*- *get_context_list.h*
+
+Given a list of authorized security contexts for the user, query the user to
+select one and set *\*newcon* to refer to it. Caller must free via
+***freecon**(3)*. Returns 0 on success or -1 otherwise.
+
+*realpath_not_final* - *selinux.h*
+
+Resolve all of the symlinks and relative portions of a *pathname*, but NOT the
+final component (same a ***realpath**(3)* unless the final component is a symlink.
+Resolved path must be a path of size *PATH_MAX + 1*.
+
+*rpm_execcon* (deprecated) - *selinux.h*
+
+Use ***setexecfilecon**(3)* and ***execve**(2)*. Execute a helper for rpm in
+an appropriate security context.
+
+*security_av_perm_to_string* - *selinux.h*
+
+Convert access vector permissions to string names.
+
+*security_av_string* - *selinux.h*
+
+Returns an access vector in a string representation. User must free the
+returned string via ***free**(3)*.
+
+*security_canonicalize_context*, *security_canonicalize_context_raw* - *selinux.h*
+
+Canonicalize a security context. Returns a pointer to the canonical (primary)
+form of a security context in *canoncon* that the kernel is using rather than
+what is provided by the userspace application in *con*.
+
+*security_check_context*, *security_check_context_raw* - *selinux.h*
+
+Check the validity of a security context.
+
+*security_class_to_string* - *selinux.h*
+
+Convert security class values to string names.
+
+*security_commit_booleans* - *selinux.h*
+
+Commit the pending values for the booleans.
+
+*security_compute_av*, *security_compute_av_raw* - *selinux.h*
+
+Compute an access decision. Queries whether the policy permits the source
+context *scon* to access the target context *tcon* via class *tclass* with
+the *requested* access vector. The decision is returned in *avd*.
+
+*security_compute_av_flags*, *security_compute_av_flags_raw* - *selinux.h*
+
+Compute an access decision and return the flags.
+Queries whether the policy permits the source context *scon* to access the
+target context *tcon* via class *tclass* with the *requested* access vector.
+The decision is returned in *avd*. that has an additional *flags* entry.
+Currently the only *flag* defined is *SELINUX_AVD_FLAGS_PERMISSIVE* that
+indicates the decision was computed on a permissive domain (i.e. the
+*permissive* policy language statement has been used in policy or
+***semanage**(8)* has been used to set the domain in permissive mode).
+Note this does not indicate that SELinux is running in permissive mode,
+only the *scon* domain.
+
+*security_compute_create*, *security_compute_create_raw* - *selinux.h*
+
+Compute a labeling decision and set *newcon to refer to it.
+Caller must free via ***freecon**(3)*.
+
+*security_compute_create_name*, *security_compute_create_name_raw* - *selinux.h*
+
+This is identical to* ***security_compute_create**(3)* but also takes the name
+of the new object in creation as an argument.
+When a *type_transition* rule on the given class and the *scon* / *tcon* pair
+has an object name extension, *newcon* will be returned according to the policy.
+Note that this interface is only supported on the kernels 2.6.40 or later.
+For older kernels the object name is ignored.
+
+*security_compute_member*, *security_compute_member_raw* - *selinux.h*
+
+Compute a polyinstantiation member decision and set *newcon to refer to it.
+Caller must free via ***freecon**(3)*.
+
+*security_compute_relabel*, *security_compute_relabel_raw* - *selinux.h*
+
+Compute a relabeling decision and set *\*newcon* to refer to it.
+Caller must free via ***freecon**(3)*.
+
+*security_compute_user*, security_compute_user_raw* (deprecated) - *selinux.h*
+
+Compute the set of reachable user contexts and set *\*con* to refer to the
+NULL-terminated array of contexts. Caller must free via ***freeconary**(3)*.
+
+*security_deny_unknown* - *selinux.h*
+
+Get the behavior for undefined classes / permissions.
+
+*security_disable* - *selinux.h*
+
+Disable SELinux at runtime (must be done prior to initial policy load).
+
+*security_get_boolean_active* - *selinux.h*
+
+Get the active value for the boolean.
+
+*security_get_boolean_names* - *selinux.h*
+
+Get the boolean names
+
+*security_get_boolean_pending* - *selinux.h*
+
+Get the pending value for the boolean.
+
+*security_get_initial_context*, *security_get_initial_context_raw* - *selinux.h*
+
+Get the context of an initial kernel security identifier by name.
+Caller must free via ***freecon**(3)*.
+
+*security_getenforce* - *selinux.h*
+
+Get the enforce flag value.
+
+*security_load_booleans* (deprecated) - *selinux.h*
+
+Load policy boolean settings. Path may be NULL, in which case the booleans
+are loaded from the active policy boolean configuration file.
+
+*security_load_policy* - *selinux.h*
+
+Load a policy configuration.
+
+*security_policyvers* - *selinux.h*
+
+Get the policy version number.
+
+*security_set_boolean* - *selinux.h*
+
+Set the pending value for the boolean.
+
+*security_set_boolean_list* - *selinux.h*
+
+Save a list of booleans in a single transaction.
+
+*security_setenforce* - *selinux.h*
+
+Set the enforce flag value.
+
+*security_validatetrans*, *security_validatetrans_raw* - *selinux.h*
+
+Validate a transition. This determines whether a transition from *scon*
+to *newcon* using *tcon* as the target for object class *tclass* is valid in
+the loaded policy. This checks against the *mlsvalidatetrans* and
+*validatetrans* constraints in the loaded policy.
+Returns 0 if allowed and -1 if an error occurred with errno set.
+
+*selabel_close* - *label.h*
+
+Destroy the specified handle, closing files, freeing allocated memory, etc.
+The handle may not be further used after it has been closed.
+
+*selabel_cmp* - *label.h*
+
+Compare two label configurations. Returns:
+
+- *SELABEL_SUBSET* - if *h1* is a subset of *h2*
+- *SELABEL_EQUAL* - if *h1* is identical to *h2*
+- *SELABEL_SUPERSET* - if *h1* is a superset of *h2*
+- *SELABEL_INCOMPARABLE* - if *h1* and *h2* are incomparable
+
+*selabel_digest* - *label.h*
+
+Retrieve the SHA1 digest and the list of specfiles used to generate the digest.
+The *SELABEL_OPT_DIGEST* option must be set in ***selabel_open**(3)* to
+initiate the digest generation.
+
+*selabel_get_digests_all_partial_matches* - *label.h*
+
+Returns true if the digest of all partial matched contexts is the same as the
+one saved by ***setxattr**(2)*, otherwise returns false. The length of the
+SHA1 digest will always be returned. The caller must free any returned digests.
+
+*selabel_hash_all_partial_matches* - *label.h*
+
+Returns true if the digest of all partial matched contexts is the same as the
+one saved by ***setxattr**(2)*, otherwise returns false.
+
+*selabel_lookup*, *selabel_lookup_raw* - *label.h*
+
+Perform a labeling lookup operation. Return 0 on success, -1 with *errno*
+set on failure. The *key* and *type* arguments are the inputs to the lookup
+operation; appropriate values are dictated by the backend in use.
+The result is returned in the memory pointed to by *con* and must be freed by
+***freecon**(3)*.
+
+*selabel_lookup_best_match*, *selabel_lookup_best_match_raw* - *label.h*
+
+Obtain a best match SELinux security context - Only supported on file backend.
+The order of precedence for best match is:
+
+- An exact match for the real path (key) or
+- An exact match for any of the links (aliases), or
+- The longest fixed prefix match.
+
+*selabel_open* - *label.h*
+
+Create a labeling handle. Open a labeling backend for use.
+The available backend identifiers are:
+
+- *SELABEL_CTX_FILE* - *file_contexts*.
+- *SELABEL_CTX_MEDIA* - media contexts.
+- *SELABEL_CTX_X* - *x_contexts*.
+- *SELABEL_CTX_DB* - SE-PostgreSQL contexts.
+- *SELABEL_CTX_ANDROID_PROP* – *property_contexts*.
+- *SELABEL_CTX_ANDROID_SERVICE* – *service_contexts*.
+
+Options may be provided via the *opts* parameter; available options are:
+
+- *SELABEL_OPT_UNUSED* - no-op option, useful for unused slots in an array of
+  options.
+- *SELABEL_OPT_VALIDATE* - validate contexts before returning them
+  (boolean value).
+- *SELABEL_OPT_BASEONLY* - don't use local customizations to backend data
+  (boolean value).
+- *SELABEL_OPT_PATH* - specify an alternate path to use when loading backend
+  data.
+- *SELABEL_OPT_SUBSET* - select a subset of the search space as an
+  optimization (file backend).
+- *SELABEL_OPT_DIGEST* – request an SHA1 digest of the specfiles.
+
+Not all options may be supported by every backend.
+Return value is the created handle on success or NULL with errno set on failure.
+
+*selabel_partial_match* - *label.h*
+
+Performs a partial match operation, returning TRUE or FALSE.
+The *key* parameter is a file *path* to check for a direct or partial match.
+Returns TRUE if a direct or partial match is found, FALSE if not.
+
+*selabel_stats* - *label.h*
+
+Log a message with information about the number of queries performed, number
+of unused matching entries, or other operational statistics.
+Message is backend-specific, some backends may not output a message.
+
+*selinux_binary_policy_path* - *selinux.h*
+
+Return path to the binary policy file under the policy root directory.
+
+*selinux_booleans_path* (deprecated) - *selinux.h*
+
+Return path to the booleans file under the policy root directory.
+
+*selinux_boolean_sub* - *selinux.h*
+
+Reads the */etc/selinux/TYPE/booleans.subs_dist* file looking for a record
+with *boolean_name*. If a record exists ***selinux_boolean_sub**(3)* returns
+the translated name otherwise it returns the original name.
+The returned value needs to be freed. On failure NULL will be returned.
+
+*selinux_booleans_subs_path* - *selinux.h*
+
+Returns the path to the *booleans.subs_dist* configuration file.
+
+*selinux_check_access* - *selinux.h*
+
+Used to check if the source context has the access permission for the specified
+class on the target context. Note that the permission and class are reference
+strings. The *aux* parameter may reference supplemental auditing information.
+Auditing is handled as described in ***avc_audit**(3)*.
+See ***security_deny_unknown**(3)* for how the *deny_unknown* flag can
+influence policy decisions.
+
+*selinux_check_passwd_access* (deprecated) - *selinux.h*
+
+Use ***selinux_check_access**(3)*. Check a permission in the passwd class.
+Return 0 if granted or -1 otherwise.
+
+*selinux_check_securetty_context* - *selinux.h*
+
+Check if the tty_context is defined as a securetty. Return 0 if secure,
+\< 0 otherwise.
+
+*selinux_colors_path* - *selinux.h*
+
+Return path to file under the policy root directory.
+
+*selinux_contexts_path* - *selinux.h*
+
+Return path to contexts directory under the policy root directory.
+
+*selinux_current_policy_path* - *selinux.h*
+
+Return path to the current policy.
+
+*selinux_customizable_types_path* - *selinux.h*
+
+Return path to customizable_types file under the policy root directory.
+
+*selinux_default_context_path* - *selinux.h*
+
+Return path to default_context file under the policy root directory.
+
+*selinux_default_type_path* - *get_default_type.h*
+
+Return path to *default_type* file.
+
+*selinux_failsafe_context_path* - *selinux.h*
+
+Return path to failsafe_context file under the policy root directory.
+
+*selinux_file_context_cmp* - *selinux.h*
+
+Compare two file contexts, return 0 if equivalent.
+
+*selinux_file_context_homedir_path* - *selinux.h*
+
+Return path to *file_context.homedir* file under the policy root directory.
+
+*selinux_file_context_local_path* - *selinux.h*
+
+Return path to *file_context.local* file under the policy root directory.
+
+*selinux_file_context_path* - *selinux.h*
+
+Return path to *file_context* file under the policy root directory.
+
+*selinux_file_context_subs_path* - *selinux.h*
+
+Return path to *file_context.subs* file under the policy root directory.
+
+*selinux_file_context_subs_dist_path* - *selinux.h*
+
+Return path to *file_context.subs_dist* file under the policy root directory.
+
+*selinux_file_context_verify* - *selinux.h*
+
+Verify the context of the file *path* against policy. Return 0 if correct.
+
+*selinux_get_callback* - *selinux.h*
+
+Used to get a pointer to the callback function of the given *type*.
+Callback functions are set using ***selinux_set_callback**(3)*.
+
+*selinux_getenforcemode* - *selinux.h*
+
+Reads the /etc/selinux/config file and determines whether the machine should
+be started in enforcing (1), permissive (0) or disabled (-1) mode.
+
+*selinux_getpolicytype* - *selinux.h*
+
+Reads the /*etc/selinux/config* file and determines what the default policy
+for the machine is. Calling application must free *policytype*.
+
+*selinux_homedir_context_path* - *selinux.h*
+
+Return path to file under the policy root directory. Note that this file will
+only appear in older versions of policy at this location. On systems that are
+managed using ***semanage**(8)* this is now in the policy store.
+
+*selinux_init_load_policy* - *selinux.h*
+
+Perform the initial policy load.
+This function determines the desired enforcing mode, sets the *enforce*
+argument accordingly for the caller to use, sets the SELinux kernel enforcing
+status to match it, and loads the policy. It also internally handles the
+initial *selinuxfs* mount required to perform these actions.
+The function returns 0 if everything including the policy load succeeds.
+In this case, init is expected to re-exec itself in order to transition to the
+proper security context. Otherwise, the function returns -1, and init must
+check *enforce* to determine how to proceed. If enforcing (*enforce* \> 0),
+then init should halt the system. Otherwise, init may proceed normally without
+a re-exec.
+
+*selinux_lsetfilecon_default* - *selinux.h*
+
+This function sets the file context to the system defaults.
+Returns 0 on success.
+
+*selinux_lxc_contexts_path* - *selinux.h*
+
+Return the path to the *lxc_contexts* configuration file.
+
+*selinux_media_context_path* - *selinux.h*
+
+Return path to file under the policy root directory.
+
+*selinux_mkload_policy* - *selinux.h*
+
+Make a policy image and load it.
+This function provides a higher level interface for loading policy than
+***security_load_policy**(3)*, internally determining the right policy version,
+locating and opening the policy file, mapping it into memory, manipulating
+it as needed for current boolean settings and/or local definitions, and then
+calling ***security_load_policy**(3)* to load it.
+*preservebools* is a boolean flag indicating whether current policy boolean
+values should be preserved into the new policy (if 1) or reset to the saved
+policy settings (if 0). The former case is the default for policy reloads,
+while the latter case is an option for policy reloads but is primarily for the
+initial policy load.
+
+*selinux_netfilter_context_path* - *selinux.h*
+
+Returns path to the netfilter_context file under the policy root directory.
+
+*selinux_path* - *selinux.h*
+
+Returns path to the policy root directory.
+
+*selinux_policy_root* - *selinux.h*
+
+Reads the /etc/selinux/config file and returns the top level directory.
+
+*selinux_raw_context_to_color* - *selinux.h*
+
+Perform context translation between security contexts and display colors.
+Returns a space-separated list of ten ten hex RGB triples prefixed by
+hash marks, e.g. *#ff0000*. Caller must free the resulting string
+via ***free**(3)*. Returns -1 upon an error or 0 otherwise.
+
+*selinux_raw_to_trans_context* - *selinux.h*
+
+Perform context translation between the human-readable format (*translated*)
+and the internal system format (*raw*). Caller must free the resulting context
+via ***freecon**(3)*. Returns -1 upon an error or 0 otherwise.
+If passed NULL, sets the returned context to NULL and returns 0.
+
+*selinux_removable_context_path* - *selinux.h*
+
+Return path to *removable_context* file under the policy root directory.
+
+*selinux_restorecon* - *restorecon.h*
+
+Relabel files that automatically calls ***selinux_restorecon_default_handle**(3)* and ***selinux_restorecon_set_sehandle**(3)* first time through to set the ***selabel_open**(3)* parameters to use the currently loaded policy *file_contexts* and request their computed digest.
+Should other ***selabel_open**(3)* parameters be required see ***selinux_restorecon_set_sehandle**(3)*.
+
+*selinux_restorecon_xattr* - *restorecon.h*
+
+Read/remove *RESTORECON_LAST* xattr entries that automatically calls ***selinux_restorecon_default_handle**(3)* and ***selinux_restorecon_set_sehandle**(3)* first time through to set the ***selabel_open**(3)* parameters to use the currently loaded policy *file_contexts* and request their computed digest.
+Should other ***selabel_open**(3)* parameters be required see ***selinux_restorecon_set_sehandle**(3)*, however note that a *file_contexts* computed digest is required for ***selinux_restorecon_xattr**(3)*.
+
+*selinux_restorecon_default_handle* - *restorecon.h*
+
+Sets default ***selabel_open**(3)* parameters to use the currently loaded policy and *file_contexts*, also requests the digest.
+
+*selinux_restorecon_set_alt_rootpath* - *restorecon.h*
+
+Use alternate rootpath.
+
+*selinux_restorecon_set_exclude_list* - *restorecon.h*
+
+Add a list of directories that are to be excluded from relabeling.
+
+*selinux_restorecon_set_sehandle* - *restorecon.h*
+
+Set the global fc handle. Called by a process that has already called ***selabel_open**(3)* with its required parameters, or if ***selinux_restorecon_default_handle**(3)* has been called to set the default ***selabel_open**(3)* parameters.
+
+*selinux_securetty_types_path* - *selinux.h*
+
+Return path to the securetty_types file under the policy root directory.
+
+*selinux_sepgsql_context_path* - *selinux.h*
+
+*Return path to *sepgsql_context* file under the policy root directory.
+
+*selinux_set_callback* - *selinux.h*
+
+Sets the callback according to the type: *SELINUX_CB_LOG*, *SELINUX_CB_AUDIT*, *SELINUX_CB_VALIDATE*, *SELINUX_CB_SETENFORCE*, *SELINUX_CB_POLICYLOAD*
+
+*selinux_set_mapping* - *selinux.h*
+
+Userspace class mapping support that establishes a mapping from a user-provided ordering of object classes and permissions to the numbers actually used by the loaded system policy.
+
+*selinux_set_policy_root* - *selinux.h*
+
+Sets an alternate policy root directory path under which the compiled policy file and context configuration files exist.
+
+*selinux_status_open* - *avc.h*
+
+Open and map SELinux kernel status page.
+
+*selinux_status_close* - *avc.h*
+
+Unmap and close kernel status page.
+
+*selinux_status_updated* - *avc.h*
+
+Inform whether the kernel status has been updated.
+
+*selinux_status_getenforce* - *avc.h*
+
+Get the enforce flag value.
+
+*selinux_status_policyload* - *avc.h*
+
+Get the number of policy loads.
+
+*selinux_status_deny_unknown* - *avc.h*
+
+Get behaviour for undefined classes/permissions.
+
+*selinux_systemd_contexts_path* - *selinux.h*
+
+Returns the path to the *systemd_contexts* configuration file.
+
+*selinux_reset_config* - *selinux.h*
+
+Force a reset of the loaded configuration. **WARNING**: This is not thread safe.
+Be very sure that no other threads are calling into *libselinux* when this
+is called.
+
+*selinux_trans_to_raw_context* - *selinux.h*
+
+Perform context translation between the human-readable format (*translated*)
+and the internal system format (*raw*). Caller must free the resulting context
+via ***freecon**(3)*. Returns -1 upon an error or 0 otherwise.
+If passed NULL, sets the returned context to NULL and returns 0.
+
+*selinux_translations_path* - *selinux.h*
+
+Return path to setrans.conf file under the policy root directory.
+
+*selinux_user_contexts_path* - *selinux.h*
+
+Return path to file under the policy root directory.
+
+*selinux_users_path* (deprecated) - *selinux.h*
+
+Return path to file under the policy root directory.
+
+*selinux_usersconf_path* - *selinux.h*
+
+Return path to file under the policy root directory.
+
+*selinux_virtual_domain_context_path* - *selinux.h*
+
+Return path to file under the policy root directory.
+
+*selinux_virtual_image_context_path* - *selinux.h*
+
+Return path to file under the policy root directory.
+
+*selinux_x_context_path* - *selinux.h*
+
+Return path to x_context file under the policy root directory.
+
+*selinuxfs_exists* - *selinux.h*
+
+Check if selinuxfs exists as a kernel filesystem.
+
+*set_matchpathcon_canoncon* (deprecated) - *selinux.h*
+
+Same as ***set_matchpathcon_invalidcon**(3)*, but also allows canonicalization
+of the context, by changing *context* to refer to the canonical form.
+If not set, and *invalidcon* is also not set, then this defaults to calling
+***security_canonicalize_context**(3)*.
+
+*set_matchpathcon_flags* (deprecated) - *selinux.h*
+
+Set flags controlling operation of ***matchpathcon_init**(3)* or
+***matchpathcon**(3)*:
+
+- *MATCHPATHCON_BASEONLY* - Only process the base file_contexts file.
+- *MATCHPATHCON_NOTRANS* - Do not perform any context translation.
+- *MATCHPATHCON_VALIDATE* - Validate/canonicalize contexts at init time.
+
+*set_matchpathcon_invalidcon* (deprecated) - *selinux.h*
+
+Set the function used by ***matchpathcon_init**(3)* when checking the validity
+of a context in the *file_contexts* configuration. If not set, then this
+defaults to a test based on ***security_check_context**(3)*. The function is
+also responsible for reporting any such error, and may include the *path* and
+*lineno* in such error messages.
+
+*set_matchpathcon_printf* (deprecated) - *selinux.h*
+
+Set the function used by ***matchpathcon_init**(3)* when displaying errors
+about the *file_contexts* configuration. If not set, then this defaults
+to *fprintf(stderr, fmt, ...)*.
+
+*set_selinuxmnt* - *selinux.h*
+
+Set the path to the selinuxfs mount point explicitly. Normally, this is
+determined automatically during libselinux initialization, but this is not
+always possible, e.g. for /sbin/init which performs the initial mount of
+*selinuxfs*.
+
+*setcon*, *setcon_raw* - *selinux.h*
+
+Set the current security context to con.
+Note that use of this function requires that the entire application be trusted
+to maintain any desired separation between the old and new security contexts,
+unlike exec-based transitions performed via ***setexeccon**(3)*.
+When possible, decompose your application and use ***setexeccon**(3)* +
+***execve**(3)* instead. Note that the application may lose access to its
+open descriptors as a result of a ***setcon**(3)* unless policy allows it to
+use descriptors opened by the old context.
+
+*setexeccon*, *setexeccon_raw* - *selinux.h*
+
+Set exec security context for the next ***execve**(3)*.
+Call with NULL if you want to reset to the default.
+
+*setexecfilecon* - *selinux.h*
+
+Set an appropriate security context based on the filename of a helper program,
+falling back to a new context with the specified type.
+
+*setfilecon*, *setfilecon_raw* - *selinux.h*
+
+Wrapper for the xattr API - Set file context.
+
+*setfscreatecon*, *setfscreatecon_raw* - *selinux.h*
+
+Set the fscreate security context for subsequent file creations.
+Call with NULL if you want to reset to the default.
+
+*setkeycreatecon*, *setkeycreatecon_raw* - *selinux.h*
+
+Set the keycreate security context for subsequent key creations.
+Call with NULL if you want to reset to the default.
+
+*setsockcreatecon*, *setsockcreatecon_raw* - *selinux.h*
+
+Set the sockcreate security context for subsequent socket creations.
+Call with NULL if you want to reset to the default.
+
+*sidget* (deprecated) - *avc.h*
+
+From 2.0.86 this is a no-op.
+
+*sidput* (deprecated) - *avc.h*
+
+From 2.0.86 this is a no-op.
+
+*string_to_av_perm* - *selinux.h*
+
+Convert string names to access vector permissions.
+
+*string_to_security_class* - *selinux.h*
+
+Convert string names to security class values.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

