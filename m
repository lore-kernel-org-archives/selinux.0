Return-Path: <SRS0=duOh=PS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD25EC43387
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 16:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF8320685
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 16:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="CfbqQ/qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfAJQYW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:24:22 -0500
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:5613 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfAJQYW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 11:24:22 -0500
X-EEMSG-check-017: 632571726|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,462,1539648000"; 
   d="scan'208";a="632571726"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2019 16:24:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547137460; x=1578673460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WbuNS1R5SKKbJsJzW35BJpu3s4sQoc0YIydEdArFbxw=;
  b=CfbqQ/qaf7DgiDzOf93u7aV2xmF/Y5un+gkyWVQ0KV22HY2aSFWj8VmW
   T//HB/y+lzB5XVT9uwJJ5hm+O2KxpUB1RgxDJv1G8paf0/Uq577GgwNhe
   BfatF4HlFLllDQ2aJA1VG/MCKesQWQEyO85Jrd7WMAMmGjDEMGNK6aVxC
   tPgqX23yqhTZlSooBbHLqDjSaKLLd84v8IFDl3SIF9jz9WdO/OE6uXZyz
   Q8gD890jMfZldgsW429wJd1kL/gCAyJd0FhfdHdvTeSfpWr6tVLrRdYkw
   hhIqem3B0Q9VYixgIp8hEC6N8wKTIEl38z2nJjoE6fsRAjsYdXGlVcwXx
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,462,1539648000"; 
   d="scan'208";a="19410013"
IronPort-PHdr: =?us-ascii?q?9a23=3ABQzIThZ7uFPi9z+CnFOpgy7/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMu/bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?us9adrTALjhjkBOTA37WrbjtV8gL9HrB6koRF03ozab5yPNPdmfq3TY84US2?=
 =?us-ascii?q?RCUMhWWCNPDZixY5cMAucbIepVtZXxq0cIoBCjBQesHuTvyjpQi3Hrwa01zf?=
 =?us-ascii?q?whEQHY0wwmAtkArXHUo8/xNKcWT++0zLTDwDLYb/xLwjfw85TIcxA9rvGMWr?=
 =?us-ascii?q?J8a8zRyVI1GA/fgVWQrpLlMiqT2+8QvWab6O9gWviui24hswxxrTmvxtssio?=
 =?us-ascii?q?nUnY0Z0EzL9SJ8wIszONa2S1Z7bMa5HJZfuCyWLYt7Tt44T212tys21KcKtY?=
 =?us-ascii?q?O9cSMX0poo3QTfZOaCc4WQ5xLjU/ueLilgiXJ+fbK/mw6y8U+9yu3gTsW00E?=
 =?us-ascii?q?hFri5CktTUqnACzQbT6smaSvtm5EuhxTaO2BzT6uFDO0w0k7bUK4U9zbIqk5?=
 =?us-ascii?q?oTsEDDEjf3mEXwkqCWal0p9vWn5unoeLnrpoKQO5VqhgzxLKgigNGzDfw9Mg?=
 =?us-ascii?q?cUXmib/eq81Kfk/U38WLhKleA5krLCvZDGJcUUuq65AwhP3oYl8BawFS2q0N?=
 =?us-ascii?q?sfnXkZNF5FYg6Ij5D1O1HSJ/D1Fey/jEqokDdqwfDGI7LgD47TLnjMjrjhZ6?=
 =?us-ascii?q?xx601Cxwopy9BQ+ZZUBqsGIPLpVU+i/ODfWwQ0Nw2y3vbPFtpwzMUdVHiJD6?=
 =?us-ascii?q?vfN7nd4nGS4ed6GPWBfI8Yvn7GLvEh4/P/xSsilUQ1Ybii3ZxRbmuxWPthPR?=
 =?us-ascii?q?PKMjLXnt4dHDJS7UIFR+vwhQjHCGZe?=
X-IPAS-Result: =?us-ascii?q?A2AxAADscDdc/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VopZk8zJ4wai29MAQEBAQEBBophjkuBeyAQCAGDPztGgiciNAkNAQMBAQEBA?=
 =?us-ascii?q?QECAWwcDII6KYMgAUaBUYJjPwGBdA0PrkCELgGBE4RpBYd+hEEXeIEHgRGGM?=
 =?us-ascii?q?AKCLoUTAolNBoYigQBTkC0JhxmKWgwYkXyOfI0rOIFWKwgCGAghDzuCbIYJi?=
 =?us-ascii?q?nEhAzCBBQEBiUcBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Jan 2019 16:24:18 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0AGOH6O029592;
        Thu, 10 Jan 2019 11:24:17 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     jwcart2@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] setsebool: support use of -P on SELinux-disabled hosts
Date:   Thu, 10 Jan 2019 11:26:24 -0500
Message-Id: <20190110162624.29309-1-sds@tycho.nsa.gov>
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
case, skip setting of active boolean values, but set the persistent value
in the policy store.  Policy reload is automatically disabled by libsemanage
when SELinux is disabled, so we only need to call semanage_set_reload()
if -N was used.

Fixes: https://github.com/SELinuxProject/selinux/issues/123
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 changes setsebool to only call semanage_set_reload() if -N was specified;
otherwise we can use the libsemanage defaults just as we do in semodule
and semanage.
 policycoreutils/setsebool/setsebool.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
index 53d3566c..a5157efc 100644
--- a/policycoreutils/setsebool/setsebool.c
+++ b/policycoreutils/setsebool/setsebool.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 
 int permanent = 0;
-int reload = 1;
+int no_reload = 0;
 int verbose = 0;
 
 int setbool(char **list, size_t start, size_t end);
@@ -38,11 +38,6 @@ int main(int argc, char **argv)
 	if (argc < 2)
 		usage();
 
-	if (is_selinux_enabled() <= 0) {
-		fputs("setsebool:  SELinux is disabled.\n", stderr);
-		return 1;
-	}
-
 	while (1) {
 		clflag = getopt(argc, argv, "PNV");
 		if (clflag == -1)
@@ -53,7 +48,7 @@ int main(int argc, char **argv)
 			permanent = 1;
 			break;
 		case 'N':
-			reload = 0;
+			no_reload = 1;
 			break;
 		case 'V':
 			verbose = 1;
@@ -130,6 +125,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
 	semanage_bool_key_t *bool_key = NULL;
 	int managed;
 	int result;
+	int enabled = is_selinux_enabled();
 
 	handle = semanage_handle_create();
 	if (handle == NULL) {
@@ -191,7 +187,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
 						  boolean) < 0)
 			goto err;
 
-		if (semanage_bool_set_active(handle, bool_key, boolean) < 0) {
+		if (enabled && semanage_bool_set_active(handle, bool_key, boolean) < 0) {
 			fprintf(stderr, "Failed to change boolean %s: %m\n",
 				boollist[j].name);
 			goto err;
@@ -202,7 +198,8 @@ static int semanage_set_boolean_list(size_t boolcnt,
 		boolean = NULL;
 	}
 
-	semanage_set_reload(handle, reload);
+	if (no_reload)
+		semanage_set_reload(handle, 0);
 	if (semanage_commit(handle) < 0)
 		goto err;
 
-- 
2.20.1

