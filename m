Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B112C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4965E60E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhJKQ2l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhJKQ2i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC3EC06174E
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g8so70007130edt.7
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2ussXvBkiHxOnVE22Z7y8uj3KdpqA+FqXCU69KIusE4=;
        b=fC5XbmI14E4Gej50rf7P5deSlweJE6BayYBuuvQv7OhGjQ3U7LHg/ZQM1LfN4qjHWF
         IpOFTVScY2stVKBpoOMcLTNNWxBEAScY64DnBiM5raPBCHA+dZbMUXphED9+ugLJDciP
         eY3oPG1ykh7TYPrulNkGLMocQc3eOzxvNMBpWysh/Wwx+mVAux6ZtaB2DTBl1bw7Ydjd
         TGI9H9LnGlZ8RJDMhqZjJ4iWJMqucHJndJ8In13b0VkmVpS56xAkEvK3U/9zAMEnv2+t
         G/yrz2GCRqcAkWzkHtBHgZbf5rgv/4f7Ko4bycNiycxfPY7tyBl6IIp1kkMV59jvhjKb
         jLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ussXvBkiHxOnVE22Z7y8uj3KdpqA+FqXCU69KIusE4=;
        b=vYLcYy1e1drlLlM0ldCmz66Qz1B9KlPqX6CDPc3KwbWaNLmC3ytIVe28dgWfW2gvv0
         k8hE4inY3X0I8zBO5GqeV8Bn7i0ydMgo1BTMx4IkcOJ0aYw9T5+C0cWoGAbdRLpgWrgw
         kS0ArbN9BGSfDayeP8xKBBScOeM5b+cQIPtYdGyyQheuMKpu+UFboefAewQwzKnJv7QT
         Nfj8h2bQdkOMoIp6qOZIbClnDmWBVY+fofJSP9OsVksZhSwvbjIUMJzl0EfAe6up+O4e
         ISVySEDYvPokgRcIRa9f1lCIkotVA2M2OFdJcQOO4OISp9Xr7PDFTuO3ukcXK9kY20Ja
         GXzg==
X-Gm-Message-State: AOAM532XD0AzUPweyiNgNzYWyLlnzZi+hjdeXFkFsDu4e91flAYS07eU
        JdBUnqTk3Y0ZHuxJxR85KanXLMo/M/o=
X-Google-Smtp-Source: ABdhPJwUeybu0WVnuNMFekCPgACLq3uddadKiK7Hj+WKAuaBFVJWjCiUOIhRzjtdnc3fWEoJbtsC0w==
X-Received: by 2002:a17:906:48c8:: with SMTP id d8mr27375396ejt.420.1633969596715;
        Mon, 11 Oct 2021 09:26:36 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:36 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 29/35] libsepol: validate genfs contexts
Date:   Mon, 11 Oct 2021 18:25:27 +0200
Message-Id: <20211011162533.53404-30-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5c06e6f4..63fd935c 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -712,6 +712,25 @@ bad:
 	return -1;
 }
 
+static int validate_genfs(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	genfs_t *genfs;
+	ocontext_t *octx;
+
+	for (genfs = p->genfs; genfs; genfs = genfs->next) {
+		for (octx = genfs->head; octx; octx = octx->next) {
+			if (validate_context(&octx->context[0], flavors, p->mls))
+				goto bad;
+		}
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid genfs");
+	return -1;
+}
+
 /*
  * Functions to validate a module policydb
  */
@@ -898,6 +917,8 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 			goto bad;
 		if (validate_ocontexts(handle, p, flavors))
 			goto bad;
+		if (validate_genfs(handle, p, flavors))
+			goto bad;
 		if (p->policyvers >= POLICYDB_VERSION_FILENAME_TRANS)
 			if (validate_filename_trans_hashtab(handle, p->filename_trans, flavors))
 				goto bad;
-- 
2.33.0

