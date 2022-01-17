Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52846C433FE
	for <selinux@archiver.kernel.org>; Mon, 17 Jan 2022 15:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbiAQPCJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jan 2022 10:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbiAQPCI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jan 2022 10:02:08 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51964C061574
        for <selinux@vger.kernel.org>; Mon, 17 Jan 2022 07:02:08 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 30so66838841edv.3
        for <selinux@vger.kernel.org>; Mon, 17 Jan 2022 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nV9iIiBn7guGnjDrmW5qMgA+PvxiYYgRUtea/9KLKnU=;
        b=BhGBAu14/ZvUklrea9IUa+rBy+VzJU0nmpd/7dEKaDgfGxi9W1+SGic+5GkX8wc07x
         3sAZaRHjqmseRZluhj+w1eJFGZOBIxVOxBM+FZ53KiR2JCCvGAre/etD/tTXZz0vrpu2
         3QlLcx978oXuOqUgKWeB/Xv9JOW7Tv57vtkndWEqFh2uxegxllJWjv8XnMZrcSGJOYiH
         hwPw1HXgaMhil/CLjjPKKMitbY6Z+bSI+Wodi8jO7wO2EimcnshWGrm7zrhvU7q2uC6j
         y5qJjGOYwE0mb0qROsx9o9dCWo+/5Y8tYGoeaqYDD7l+lRiAtKyFlrMujVjev0FNlnb/
         vX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nV9iIiBn7guGnjDrmW5qMgA+PvxiYYgRUtea/9KLKnU=;
        b=7sCA8uLSVqHCKhGxp6o7vxMSaWie/yULw/7EPQXitKGrsRcxHwds2lf1XQt4y+ude9
         siAsdsYO21tpvTm3MwM3u2OsG/C/7yzDVBA6dWUgCvf3ORMOuZmx1TmfzEYkH+yissN+
         iAVB0VuNCMwmw3SCwpVVilCw3MwUTarPudQ9MBVxAHEoJu+QUybJOGaoW2HPm5mygAVz
         Czbyq3iqPwpjw8YIrJuL8E/3r+4orIVms9C2u+883YIxcAnOgE2HyjAsAeVRkVN0Ncc1
         4EjVSGjmoQzd60GzYWKgZVuL6jZSjRPPkwI6QlPU6xOiCc6aRGdbaYcAnj6B/sF9o2BM
         GUuA==
X-Gm-Message-State: AOAM53058bXS2zokSdcoGvVQYiAd7WdbTII1yCAx+EjHmQxaRg7aHFd+
        Y3zBpyGA0/M720W+4ULDrNYfGUAkb9Q=
X-Google-Smtp-Source: ABdhPJzd06QM4DipoTfoShjnVKuQFVuHcYkhYKo6yn8LOq3YyjdauZGZZoWHi5omNgxokOCWb5sjtw==
X-Received: by 2002:a05:6402:190d:: with SMTP id e13mr19484191edz.87.1642431726926;
        Mon, 17 Jan 2022 07:02:06 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-097-056.95.116.pool.telefonica.de. [95.116.97.56])
        by smtp.gmail.com with ESMTPSA id v11sm3857682ejq.175.2022.01.17.07.02.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:02:06 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: reject invalid roles before inverting
Date:   Mon, 17 Jan 2022 16:02:00 +0100
Message-Id: <20220117150200.24953-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since the role datums have not been validated yet, they might be invalid
and set to an enormous high value. Inverting such an ebitmap will take
excessive amount of memory and time.

Found by oss-fuzz (#43709)
---
 libsepol/src/expand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 898e6b87..3fc54af6 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2481,6 +2481,10 @@ int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * out, policydb_t
 
 	/* if role is to be complimented, invert the entire bitmap here */
 	if (x->flags & ROLE_COMP) {
+		/* inverting an ebitmap with an invalid highbit will take aeons */
+		if (ebitmap_length(r) > p->p_roles.nprim)
+			return -1;
+
 		for (i = 0; i < ebitmap_length(r); i++) {
 			if (ebitmap_get_bit(r, i)) {
 				if (ebitmap_set_bit(r, i, 0))
-- 
2.34.1

