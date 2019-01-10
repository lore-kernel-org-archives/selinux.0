Return-Path: <SRS0=duOh=PS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540B8C43387
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 15:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E3020685
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 15:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZMnwn38F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfAJPbr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:31:47 -0500
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:33616 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbfAJPbr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 10:31:47 -0500
X-EEMSG-check-017: 191368681|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2019 15:31:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547134303; x=1578670303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lsYlce0gkvWRN3mL/VcDHOPgA/YQ4yA9szfekt8ZdWQ=;
  b=ZMnwn38FvrNa5s7iwfG+y+KtkE9x/acNSHSs0nIgwqyelmxFicIXprxF
   EZNDf35oD7EqHw3DwuxvGYV35e8Gcq3pSydSO+OoxYuiV1cJstZo6nIGE
   AIRmkY4G8VrHT1fuIO97jQwvIiVcHfE9Uosw/qPJYY1HwCFMFngJQYZG9
   xU9447IvlvRFNNwVJEbk3W4Be9boz3h2p0UQIaiRQ2wGE8KHtMX9wmCQh
   n/Cq3VodhBki/Eno5ZcxyEnqSUePkGCzwMBDSD3uFKL65dDkMrYinzeIy
   e7IpD1Xy6r4UgOrd+TCyZsQkcX8URDeILpU4UgJEfpsgDECmFuwPlTIwS
   g==;
X-IronPort-AV: E=Sophos;i="5.56,461,1539648000"; 
   d="scan'208";a="22525519"
IronPort-PHdr: =?us-ascii?q?9a23=3AArJYPxEbSF5p9iEdIHbkaJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ78oMmwAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/Vj?=
 =?us-ascii?q?q476dvVRTmliEJOTAk+23Tk8B8kb5XrBenqhdiwYDbfZuVOeJ+cK3DYN0US2?=
 =?us-ascii?q?lPUMFeWCJOGY6wc4gCAvAdMetCs4Xxu10Dpga+Cwm2A+PvzydFiGLq3aIky+?=
 =?us-ascii?q?QhER/J3Ao9FNwTtXTbttH1NKMMXuG10aLFyi7DYO5N2Trm9IjJcgwuofGLXb?=
 =?us-ascii?q?5qd8rR0lMgGxnKjlWXt4zoJjWY3fkDvWic6upvT+Ovi2g/pgF+oziv2scsip?=
 =?us-ascii?q?TSiY4P1l/E8iB5zYAoLtO7UE52ecOoHZRfui2AN4Z6X9kuT39ntSok0LEKpJ?=
 =?us-ascii?q?i2dzUQxps93R7QcfmHfpCN4hLkSemePy91hGlgeLKjnxay9lWgyvHkWsm0zl?=
 =?us-ascii?q?lKqi1Fn8HQtn8XzRzT69WHSuBn8ke92TeAywDT6uZeLUAyiaXbMIIuzqQ1lp?=
 =?us-ascii?q?oStUTPBi72mEPog6+Kbkgo5+el5uv9brjmu5OQLZF4hw7gPqg0h8CzGeE4PR?=
 =?us-ascii?q?IPX2if9+S8zrrj/UjhTbVRk/I2ibLUsIzaJMsHpq65BBVZ0oA46xmlFTum39?=
 =?us-ascii?q?MYnWcfIFJfZB2Hl5TpO03JIP3gFvewnVCskDZtx/DbMbzsGYvNLnfdn7f7Z7?=
 =?us-ascii?q?p96FBTyBA1zd9B45JYELYBIOj8Why5iNuNFRI9Mgqp0875B9hnkIATQ2SCBu?=
 =?us-ascii?q?meKqyBn0WP47cUP+SUZIIT8A34Ivwh6u+m2WQ1gncBbKKp2t0Rc3n+EfN4dR?=
 =?us-ascii?q?bKKUHwi8sMRD9Z9jE1S/bn3RjbCTM=3D?=
X-IPAS-Result: =?us-ascii?q?A2AxAACuZDdc/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VopZk8zJ4wai29MAQEBAQEBBophjkuBeyAQCAGDPztGgiciNAkNAQMBAQEBA?=
 =?us-ascii?q?QECAWwcDII6KYMgAUaBUYJjPwGBdA0PrhqELgGBE4RpBYd+hEEXeIEHgRGGM?=
 =?us-ascii?q?AKCLoUTAolNBoYigQBTkC0JhxmKWgwYkXsBjnyNKziBVisIAhgIIQ+DJ4YJi?=
 =?us-ascii?q?nEhAzCBBQEBiUcBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jan 2019 15:31:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0AFVf8a010066;
        Thu, 10 Jan 2019 10:31:41 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     jwcart2@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] setsebool: support use of -P on SELinux-disabled hosts
Date:   Thu, 10 Jan 2019 10:33:47 -0500
Message-Id: <20190110153347.26951-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As reported in #123, setsebool immediately exits with an error if
SELinux is disabled, preventing its use for setting boolean persistent
values.  In contrast, semanage boolean -m works on SELinux-disabled
hosts.  Change setsebool so that it can be used with the -P option
(persistent changes) even if SELinux is disabled.  In the SELinux-disabled
case, disable the policy reload and skip setting of active boolean
values, but set the persistent value in the policy store.

Fixes: https://github.com/SELinuxProject/selinux/issues/123
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policycoreutils/setsebool/setsebool.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
index 53d3566c..fed296ee 100644
--- a/policycoreutils/setsebool/setsebool.c
+++ b/policycoreutils/setsebool/setsebool.c
@@ -38,10 +38,7 @@ int main(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	if (is_selinux_enabled() <= 0) {
-		fputs("setsebool:  SELinux is disabled.\n", stderr);
-		return 1;
-	}
+	reload = (is_selinux_enabled() > 0);
 
 	while (1) {
 		clflag = getopt(argc, argv, "PNV");
@@ -130,6 +127,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
 	semanage_bool_key_t *bool_key = NULL;
 	int managed;
 	int result;
+	int enabled = is_selinux_enabled();
 
 	handle = semanage_handle_create();
 	if (handle == NULL) {
@@ -191,7 +189,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
 						  boolean) < 0)
 			goto err;
 
-		if (semanage_bool_set_active(handle, bool_key, boolean) < 0) {
+		if (enabled && semanage_bool_set_active(handle, bool_key, boolean) < 0) {
 			fprintf(stderr, "Failed to change boolean %s: %m\n",
 				boollist[j].name);
 			goto err;
-- 
2.20.1

