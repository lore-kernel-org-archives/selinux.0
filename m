Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C53C4D2FC
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9411A24735
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="O/5rIwJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfLMU2h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:28:37 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:58942 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfLMU2h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 15:28:37 -0500
X-EEMSG-check-017: 38164433|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,311,1571702400"; 
   d="scan'208";a="38164433"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Dec 2019 20:28:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576268914; x=1607804914;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NKMSUYVonUE0kQ8NsbDTxIhmAJASPOrRpBllLU97BQ4=;
  b=O/5rIwJj0AT7HSg03uhzMjlHBGBIJvDRZINT7Z7ifQ+Ztg79EpfGptk4
   FSDDykUIp18OP3H3VEYQJX6Y6/eYPDF4rSjaN21ZPksZujgIKWxSBi70k
   B7PhICAcCZwmDl22Zq5mXRgzgyjagW5BaWrv2gfZ7lp0U/86LOx+qDQIh
   lfK6rqytRcTTJ//KbHrSR+/Rj/KcSXWA+jSeVEEIreOFkrPO65EefedV4
   dJFlzeTrRANz+DV3GXOFCHC4ZkyLM/Wc5VG5IPBT9SNIW3Aflb4OsiEPz
   lMwjC4HGY0CCWAeyfuJXb40WKdEV9t+3+ByFKDmpw6K34udyuig3JILe0
   w==;
X-IronPort-AV: E=Sophos;i="5.69,311,1571702400"; 
   d="scan'208";a="36740856"
IronPort-PHdr: =?us-ascii?q?9a23=3AGEgYVRcovCFk7ByAzerbG59elGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW9bB7h7PlgxGXEQZ/co6odzbaP6Oa5CD1LuM3f+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLq8UbhY9vJqksxh?=
 =?us-ascii?q?bHo3ZDZvhby35vKV+PhRj3+92+/IRk8yReuvIh89BPXKDndKkmTrJWESorPX?=
 =?us-ascii?q?kt6MLkqRfMQw2P5mABUmoNiRpHHxLF7BDhUZjvtCbxq/dw1zObPc3ySrA0RC?=
 =?us-ascii?q?ii4qJ2QxLmlCsLKzg0+3zZhcxqiKJQvQyvqRpxzYXJZI2ZLfpzc6fYcd4cWG?=
 =?us-ascii?q?FPXNteVzZZD428cYUBEuQPM+VfoYbyqFUDtgeyCAq2Ce/z0DJEmmP60Ksn2O?=
 =?us-ascii?q?ohCwHG2wkgEsoTvnTIstr1LKcSXv6zzKLV0DvDaulZ2TP56IfWchEqvPaBXa?=
 =?us-ascii?q?ltfsrK0kQvCwPEgUmQqYziJT+V0P8NvHKB4+pvUuKvlXcqpgdsqTas3schkp?=
 =?us-ascii?q?TFi40ax1ze9Sh13Zw5KcO3RUJle9KoDZ1dvDyAOYRsWMMtWWRotT4/yr0BpJ?=
 =?us-ascii?q?G0YjAHyI8ixx7Dc/yHdJWI4g77WOaRPzh4gHVldaqjhxmo60igy/D8VtKu3F?=
 =?us-ascii?q?ZLqCpFnN7MtmsT2BPP8MSHVvt88Vuh2TaIzQzT7P1LIVsomqbBLp4hw7owmo?=
 =?us-ascii?q?ISsUTFACD2hF37gLKZe0gr4OSl6/nrbq/4qpKTKYN4kBzyPrwrmsOlAOQ4Ng?=
 =?us-ascii?q?YOX3Kc+eS5zLDj5lD2QK5Rg/0qkqjWrJDaJcMBqq6/GA9ayJwv6xm4Dze4yN?=
 =?us-ascii?q?gYh2UILEpZeBKbiIjkI1POL+72DfexnVShizhrx/fBPr3uBpXCMGLPn6vmfb?=
 =?us-ascii?q?Z480Rc0hY8zchD55JIDbEMOPXzWkr2tNzDCB82KRC7zPj8BdVnyIwRRGKPDb?=
 =?us-ascii?q?WFMK/IrVCI4ecvKfGWZIAJoDb9N+Ql5/n2gH86h1ASY7Kp0ocQaHC/HfRrOF?=
 =?us-ascii?q?mWYXr2gtcGFGcKvxc+TOnwhF2FSz5TaG64X7gg6TEjFIKmEYDDS5i2gLOf2C?=
 =?us-ascii?q?e7H5tWZn1JC12XD3foeJuLW+0WZCKRPMBhiDoEWqalS4M70hGurgD6waJ9Lu?=
 =?us-ascii?q?XI4i0YqY7j1N9t6u3Ljx4y6Dh0At+F026XUmF0mnoERzox3KB4u0xy1E2P3r?=
 =?us-ascii?q?R/g/xdRpRv4KZRWxo+HYbV0ug/Dtf1QA+HddCMG3i8RdDzOi08VtI8xZc1Zk?=
 =?us-ascii?q?95H9izxkTY0zGCH64el7vNAoc9tK3bwS6idI5G13/a2fx53BEdScxVODjj2/?=
 =?us-ascii?q?9y?=
X-IPAS-Result: =?us-ascii?q?A2B3AADG8/Nd/wHyM5BlHQEBAQkBEQUFAYFsBgELAYFzg?=
 =?us-ascii?q?WwBIBIqjQaGdAaLII9KgXsJAQEBAQEBAQEBGxwBAYRAgjU2Bw4CEAEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshUOCOymDMwFGgVGCYz+CUyWucokBgUiBNgGHPoRzeYEHgUeDG?=
 =?us-ascii?q?4UWhSEEl0+XKYI6gj+TOQwbmkYBqxIMJoFYKwgCGAghD4MnUBEUjR4XjkEjA?=
 =?us-ascii?q?zCPTwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Dec 2019 20:28:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBDKSCSr127737;
        Fri, 13 Dec 2019 15:28:15 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, keescook@chromium.org,
        omosnace@redhat.com, jeffv@google.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH] selinux: randomize layout of key structures
Date:   Fri, 13 Dec 2019 15:28:38 -0500
Message-Id: <20191213202838.7323-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Randomize the layout of key selinux data structures.
Initially this is applied to the selinux_state, selinux_ss,
policydb, and task_security_struct data structures.

NB To test/use this mechanism, one must install the
necessary build-time dependencies, e.g. gcc-plugin-devel on Fedora,
and enable CONFIG_GCC_PLUGIN_RANDSTRUCT in the kernel configuration.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
I would have expected that two kernels built with the same config
with this enabled would have yielded different struct layouts in
pahole vmlinux output, but that doesn't appear to be the case. They
do have different seeds.  Am I doing something wrong?
Also, does DEBUG_INFO_BTF effectively undermine/negate the benefits of this
change if enabled?

 security/selinux/include/objsec.h   | 2 +-
 security/selinux/include/security.h | 2 +-
 security/selinux/ss/policydb.h      | 2 +-
 security/selinux/ss/services.h      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index a4a86cbcfb0a..330b7b6d44e0 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -35,7 +35,7 @@ struct task_security_struct {
 	u32 create_sid;		/* fscreate SID */
 	u32 keycreate_sid;	/* keycreate SID */
 	u32 sockcreate_sid;	/* fscreate SID */
-};
+} __randomize_layout;
 
 enum label_initialized {
 	LABEL_INVALID,		/* invalid or not initialized */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 49737087ad33..3ea406ad91b6 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -110,7 +110,7 @@ struct selinux_state {
 	bool policycap[__POLICYDB_CAPABILITY_MAX];
 	struct selinux_avc *avc;
 	struct selinux_ss *ss;
-};
+} __randomize_layout;
 
 void selinux_ss_init(struct selinux_ss **ss);
 void selinux_avc_init(struct selinux_avc **avc);
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index bc56b14e2216..98afe52a3d19 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -307,7 +307,7 @@ struct policydb {
 
 	u16 process_class;
 	u32 process_trans_perms;
-};
+} __randomize_layout;;
 
 extern void policydb_destroy(struct policydb *p);
 extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index fc40640a9725..c5896f39e8f6 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -31,7 +31,7 @@ struct selinux_ss {
 	struct selinux_map map;
 	struct page *status_page;
 	struct mutex status_lock;
-};
+} __randomize_layout;
 
 void services_compute_xperms_drivers(struct extended_perms *xperms,
 				struct avtab_node *node);
-- 
2.23.0

