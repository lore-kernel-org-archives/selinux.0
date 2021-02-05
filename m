Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0FCC433E9
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7AA64FBC
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBEJxg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:53:36 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:46889 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBEJqw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 04:46:52 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6EC3456129F
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 10:46:09 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libsepol/cil: fix NULL pointer dereference with empty macro argument
Date:   Fri,  5 Feb 2021 10:45:37 +0100
Message-Id: <20210205094539.388854-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Feb  5 10:46:09 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

OSS-Fuzz found a Null-dereference READ in the CIL compiler when trying
to compile the following policy:

    (macro m((name n))) (call m(()))

When calling the macro, the name (in variable "pc") is NULL, which
triggers a NULL pointer dereference when using it as a key in
__cil_insert_name(). The stack trace is:

    #0 0x7f4662655a85 in __strlen_avx2 (/usr/lib/libc.so.6+0x162a85)
    #1 0x556d0b6d150c in __interceptor_strlen.part.0 (/selinux/libsepol/fuzz/fuzz-secilc+0x44850c)
    #2 0x556d0ba74ed6 in symhash /selinux/libsepol/src/symtab.c:22:9
    #3 0x556d0b9ef50d in hashtab_search /selinux/libsepol/src/hashtab.c:186:11
    #4 0x556d0b928e1f in cil_symtab_get_datum /selinux/libsepol/src/../cil/src/cil_symtab.c:121:37
    #5 0x556d0b8f28f4 in __cil_insert_name /selinux/libsepol/src/../cil/src/cil_resolve_ast.c:96:2
    #6 0x556d0b908184 in cil_resolve_call1 /selinux/libsepol/src/../cil/src/cil_resolve_ast.c:2835:12
    #7 0x556d0b91b404 in __cil_resolve_ast_node /selinux/libsepol/src/../cil/src/cil_resolve_ast.c
    #8 0x556d0b91380f in __cil_resolve_ast_node_helper /selinux/libsepol/src/../cil/src/cil_resolve_ast.c:3773:7
    #9 0x556d0b932230 in cil_tree_walk_core /selinux/libsepol/src/../cil/src/cil_tree.c:263:9
    #10 0x556d0b932230 in cil_tree_walk /selinux/libsepol/src/../cil/src/cil_tree.c:307:7
    #11 0x556d0b932326 in cil_tree_walk_core /selinux/libsepol/src/../cil/src/cil_tree.c:275:9
    #12 0x556d0b932326 in cil_tree_walk /selinux/libsepol/src/../cil/src/cil_tree.c:307:7
    #13 0x556d0b911189 in cil_resolve_ast /selinux/libsepol/src/../cil/src/cil_resolve_ast.c:3941:8
    #14 0x556d0b798729 in cil_compile /selinux/libsepol/src/../cil/src/cil.c:550:7

Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28544
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_resolve_ast.c | 79 ++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 0c85eabe5a81..9300cd2be9be 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -2828,6 +2828,12 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 			switch (flavor) {
 			case CIL_NAME: {
 				struct cil_name *name;
+				if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
+				}
 				name = __cil_insert_name(args->db, pc->data, current);
 				if (name != NULL) {
 					new_arg->arg = (struct cil_symtab_datum *)name;
@@ -2837,21 +2843,57 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 			}
 				break;
 			case CIL_TYPE:
+				if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
+				}
 				new_arg->arg_str = pc->data;
 				break;
 			case CIL_ROLE:
+				if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
+				}
 				new_arg->arg_str = pc->data;
 				break;
 			case CIL_USER:
+				if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
+				}
 				new_arg->arg_str = pc->data;
 				break;
 			case CIL_SENS:
+				if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
+				}
 				new_arg->arg_str = pc->data;
 				break;
 			case CIL_CAT:
+				if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
+				}
 				new_arg->arg_str = pc->data;
 				break;
 			case CIL_BOOL:
+				if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
+				}
 				new_arg->arg_str = pc->data;
 				break;
 			case CIL_CATSET: {
@@ -2871,6 +2913,11 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 					cil_list_append(((struct cil_symtab_datum*)catset)->nodes,
 									CIL_LIST_ITEM, cat_node);
 					new_arg->arg = (struct cil_symtab_datum*)catset;
+				} else if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
 				} else {
 					new_arg->arg_str = pc->data;
 				}
@@ -2896,6 +2943,11 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 					cil_list_append(((struct cil_symtab_datum*)level)->nodes, 
 									CIL_LIST_ITEM, lvl_node);
 					new_arg->arg = (struct cil_symtab_datum*)level;
+				} else if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
 				} else {
 					new_arg->arg_str = pc->data;
 				}
@@ -2921,6 +2973,11 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 					cil_list_append(((struct cil_symtab_datum*)range)->nodes, 
 									CIL_LIST_ITEM, range_node);
 					new_arg->arg = (struct cil_symtab_datum*)range;
+				} else if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
 				} else {
 					new_arg->arg_str = pc->data;
 				}
@@ -2946,6 +3003,11 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 					cil_list_append(((struct cil_symtab_datum*)ipaddr)->nodes,
 									CIL_LIST_ITEM, addr_node);
 					new_arg->arg = (struct cil_symtab_datum*)ipaddr;
+				} else if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
 				} else {
 					new_arg->arg_str = pc->data;
 				}
@@ -2953,9 +3015,21 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 				break;
 			}
 			case CIL_CLASS:
+				if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
+				}
 				new_arg->arg_str = pc->data;
 				break;
 			case CIL_MAP_CLASS:
+				if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
+				}
 				new_arg->arg_str = pc->data;
 				break;
 			case CIL_CLASSPERMISSION: {
@@ -2976,6 +3050,11 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 					cp_node->data = cp;
 					cil_list_append(cp->datum.nodes, CIL_LIST_ITEM, cp_node);
 					new_arg->arg = (struct cil_symtab_datum*)cp;
+				} else if (pc->data == NULL) {
+					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
+					cil_destroy_args(new_arg);
+					rc = SEPOL_ERR;
+					goto exit;
 				} else {
 					new_arg->arg_str = pc->data;
 				}
-- 
2.30.0

