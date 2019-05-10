Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5895DC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 22:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238AB217F5
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 22:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="xAOZKdg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfEJWHP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 18:07:15 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:59708 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbfEJWHP (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 10 May 2019 18:07:15 -0400
Received: from 34-41-5D-CA-59-C7 (176-93-196-243.bb.dnainternet.fi [176.93.196.243])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x4AM78Dl014364
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Sat, 11 May 2019 01:07:09 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x4AM78Dl014364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1557526029;
        bh=gP69B0bjLJuoOO/dZhJO5GAu3QShdSwGtJN8ag6UC8g=;
        h=Date:From:To:Subject:From;
        b=xAOZKdg/mu8OpuNbSaF9ofSarleoF/+uCmROtIbWGU7nWiud+Tn7tiAEM/xylegjl
         1QV+tKyAsTY3EYYrsSxOPvNxKpVnu4QPGt039XWcNt8a92+yvSVvtZCk9FE2zz2hEw
         ZRFayBXju+od1jfJSbf1Lt7owoBAsVVIQui6wyFqR+8kgiCLAHslWzXcf/bR1lUngX
         KQnOYr0GwTmJXq7r2fguPZVUttouPeGdFkgOYAEY8c07uyEym/YqssCwxMe+Yk5Td5
         AfhLOYOM0Xrt3sJo4TFUxjbWCt3FH5vswWXXzpiiSJxdaebXfLcXUi1+EcGxzEcnSv
         fTQQ5EbxCsQNg==
Date:   Sat, 11 May 2019 01:07:12 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH] Trivial style fixes pt2
Message-ID: <alpine.LFD.2.21.1905110105390.19034@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


---
 libsemanage/src/direct_api.c    | 2 +-
 libsemanage/src/modules.c       | 2 +-
 libsemanage/src/seusers_local.c | 2 +-
 libsemanage/src/users_local.c   | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index c58961be..7e097d5f 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -517,7 +517,7 @@ ssize_t bunzip(semanage_handle_t *sh, FILE *f, char **data)
 	size_t  size = 1<<18;
 	size_t  bufsize = size;
 	int     bzerror;
-	size_t  total=0;
+	size_t  total = 0;
 	char*   uncompress = NULL;
 	char*   tmpalloc = NULL;
 	int     ret = -1;
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index 62af1018..fa84d33e 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -1130,7 +1130,7 @@ int semanage_module_install_info(semanage_handle_t *sh,
 int semanage_module_remove_key(semanage_handle_t *sh,
 			       const semanage_module_key_t *modkey)
 {
-	if (sh->funcs->remove_key== NULL) {
+	if (sh->funcs->remove_key == NULL) {
 		ERR(sh,
 		    "No remove key function defined for this connection type.");
 		return -1;
diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
index a79e2d3d..3e2761c4 100644
--- a/libsemanage/src/seusers_local.c
+++ b/libsemanage/src/seusers_local.c
@@ -133,7 +133,7 @@ int semanage_seuser_modify_local(semanage_handle_t * handle,
 	semanage_seuser_t *new = NULL;
 
 	if (!sename) {
-		errno=EINVAL;
+		errno = EINVAL;
 		return -1;
 	}
 	rc = semanage_seuser_clone(handle, data, &new);
diff --git a/libsemanage/src/users_local.c b/libsemanage/src/users_local.c
index 7aa43d44..8193476d 100644
--- a/libsemanage/src/users_local.c
+++ b/libsemanage/src/users_local.c
@@ -38,7 +38,7 @@ static int lookup_seuser(semanage_handle_t * handle, const semanage_user_key_t *
 	semanage_seuser_list_local(handle,
 				   &records,
 				   &count);
-	for(i=0; i<count; i++) {
+	for(i = 0; i < count; i++) {
 		sename = semanage_seuser_get_sename(records[i]);
 		if (strcmp(name, sename) == 0) {
 			errno = EINVAL;
@@ -47,7 +47,7 @@ static int lookup_seuser(semanage_handle_t * handle, const semanage_user_key_t *
 			rc = -1;
 		}
 	}
-	for(i=0; i<count; i++)
+	for(i = 0; i < count; i++)
 		semanage_seuser_free(records[i]);
 	free(records);
 	semanage_user_free(user);
-- 
2.21.0

