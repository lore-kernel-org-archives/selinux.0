Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4F7ECE588
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAB121925
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mmiV8hj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfJON1M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:27:12 -0400
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:20310 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfJON1M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 09:27:12 -0400
X-EEMSG-check-017: 22420348|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="22420348"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 13:27:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571146029; x=1602682029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/QmDn8XULPzx70bpwidmD6Vt6TNuodjqft2TGbNhQLU=;
  b=mmiV8hj2Pr96m2DhzhETs59pvOJVMlZzQEWc11OSwazjlYOL2n8r+t3d
   CJs1EgFmXnLIeqzShvCdiJFU83mZngWfkTzkYjqOPgwcZsjnfJCVVi+4T
   19Pc5zV0dzBtTeyh/A46zCWAW4l/OPdejyeH514YlqyA2v/nHpPp/KT7f
   FfYWJynlAG3Ov5AStDK2VlvBqKgAREKTWZq9XZOdNhPZwHcHIjCMSdxG2
   8ZMgQjP9WLnbnJ8WB+uKHn+qp65vKjYFwLCw0qz/aFT4cqRTIv1fAkpwG
   eoyEf4gLqh0ziet/4CyJlhgUneBZg9eC5+jWfNiZqSVWBFhGyXI5R7it5
   g==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="34156705"
IronPort-PHdr: =?us-ascii?q?9a23=3AWqN3AxLx3TAt1+e3etmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfKvXxwZ3uMQTl6Ol3ixeRBMOHsqkC1LGd7v6ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalwIRi4ognctsgbipZ+J6gszR?=
 =?us-ascii?q?fEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3QqBWAzogM2?=
 =?us-ascii?q?Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VS?=
 =?us-ascii?q?ik4qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ2?=
 =?us-ascii?q?ROXtxVVydcHI2yaYUBBPcFMepBoYTwo14CoB2jDgeuGezv0CdFiH/o06Mn3e?=
 =?us-ascii?q?ovEgbI0w4uH90Bv3rZt8n5OaQIXOyp1qTE0SnPYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+ZL4t7Wt4uTm5ntSogyrAKpI?=
 =?us-ascii?q?S3cDYFxZg53RLTdvqKeJWS7B35TuaeOzJ4iWpgeLK4mhm971Ctyvb5VsmoyF?=
 =?us-ascii?q?ZKqTdFksXUunANyRPT7s+HR+Nh/ki7wzaP1h3T6vpeLUAolavUN54hwrkqmp?=
 =?us-ascii?q?oVrUvDBTP5lF/zjK+XckUo4umo6+L5bbX6vpKQKoB5hw7kPqkuh8CzG/o0Pw?=
 =?us-ascii?q?cQU2SB5OiwzLjj8lf4QLVOgP02iK7ZsJXCKMQAu6G5GBRY0poj6hmjDzem18?=
 =?us-ascii?q?4UnX8cLF1fYh6HgI/pO0/WLPDiEfi/m0iskCtsx/3eJr3uHInNIWbZkLv7Y7?=
 =?us-ascii?q?l97VNTxxQpzd9E4JJUEL4BLenoWk/2stzZDgU1PBCzw+biEN99zJ8RWXqTAq?=
 =?us-ascii?q?+FN6PfqUeI6fgyI+mIf4IVoCzyK+Uh5/L3iH85nlgdfbO30pcNdH+4GfFmKV?=
 =?us-ascii?q?2DYXXwmtcBDXsKvg0mQezxllKCVT9TZ3CvX6Mz/Tw7Fo2mApnZRoy3g7yOwj?=
 =?us-ascii?q?27HptIaWBCEFyMFm3od4rXE8sLPTmfJs5njywsS7esUcki2AuouQu8zKBofc?=
 =?us-ascii?q?TO/ShNjo7uzNh44aXokBg28TFlR5CG33qlU3B/nmROQSQ/mq94vxoumR+4za?=
 =?us-ascii?q?FkjqkARpRo7PRTX1J/bMWNwg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B/AAAuxaVd/wHyM5BmHQEBAQkBEQUFAYFnCAELAYFzL?=
 =?us-ascii?q?IE/ATIqjEeHCwEBAQEBAQaBNol4jzSBewkBAQEBAQEBAQEbGQECAQGEQAKCa?=
 =?us-ascii?q?yQ0CQ4CDAEBAQQBAQEBAQUDAQFshTmCOikBgmgGJwsBRhAgMVcZgmM/glMls?=
 =?us-ascii?q?CsziHuBSIE0AYc0hFkYeIEHhGGFEYUfBK1KgiyCMZJeDBuZQYphnwU5gVgrC?=
 =?us-ascii?q?AIYCCEPgydQEBSQMSUDMIEGAQGQQQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Oct 2019 13:27:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FDPV4J010187;
        Tue, 15 Oct 2019 09:27:00 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Peter Enderborg <peter.enderborg@sony.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 05/10] selinux: Annotate lockdep for services locks
Date:   Tue, 15 Oct 2019 09:25:23 -0400
Message-Id: <20191015132528.13519-6-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015132528.13519-1-sds@tycho.nsa.gov>
References: <20191015132528.13519-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Peter Enderborg <peter.enderborg@sony.com>

The locks are moved to dynamic allocation, we need to
help the lockdep system to classify the locks.
This adds to lockdep annotation for the page mutex and
for the ss lock.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
[sds@tycho.nsa.gov: ported to v5.4-rc1]
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/ss/services.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 57d6b8dddc54..9404a4494c7c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -66,6 +66,9 @@
 #include "ebitmap.h"
 #include "audit.h"
 
+static struct lock_class_key selinux_ss_class_key;
+static struct lock_class_key selinux_status_class_key;
+
 /* Policy capability names */
 const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"network_peer_controls",
@@ -84,7 +87,9 @@ int selinux_ss_create(struct selinux_ss **ss)
 	if (!newss)
 		return -ENOMEM;
 	rwlock_init(&newss->policy_rwlock);
+	lockdep_set_class(&newss->policy_rwlock, &selinux_ss_class_key);
 	mutex_init(&newss->status_lock);
+	lockdep_set_class(&newss->status_lock, &selinux_status_class_key);
 	*ss = newss;
 	return 0;
 }
-- 
2.21.0

