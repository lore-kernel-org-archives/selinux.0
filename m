Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5247CA7D
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356777; cv=none; b=X5DyF78SEUKcN4RImndY28LES/AQxWkiWCZQe7P1rNxNziG7m9SBGIU5giUvD1v0zh7LHfhYy0q7hzyVl0BV2xSFokz01N850I/QBAPWbrXtdEZc5TrDJDiXMeL4sYjMq8YoTl5qCk/xl53nv5Ogkq+CUMoqrB4/8RneZai1sro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356777; c=relaxed/simple;
	bh=aACwltl1ZU0WbD3tq0kXF1wvq126MYRhnrVC3XwoUi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlWSQbVlzXwy6AiUppX7jtIQRvlUcTYWM7pXlQoA4bgCQF0nVGxgvg/KhZA/nEOCF10fxFk2CJSA5d0+ARgVS5uOHWcWwGdehwRxpXirtrRF0OJixp2UkxJFovHHRIBIcT4SKBBySbk24tMEBTldFDf0rQOiO9azd62ykBDzx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKNJITay; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKNJITay"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-530187593e0so12534701cf.1
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356775; x=1788961575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XW5bsunI5tFDnMF7+O8o66VjrM0zG8UGo/I7d0UClRQ=;
        b=iKNJITayy3XuyJKXEr/im7zmza7mefrTH2GkkNzYUrLIFaV7zk3Z6N7Ciff5ujTl3T
         Pg5mNNgQEHvMYuv2a/zjBjwTzAyIDL+qmM5MVcvK+rKqa+NRE8mY8srdJnf0N7UU9EXs
         MddRb2kRSV9txyqGZ4eu2cn4lOva0fua6jN2BmqsgmYQQUiR+knUCG+axRsRgSOFuQgV
         AidA4LXExDsd20Zu3eXFfD8GooxzM3a0m271+MjkQG+8paqj92jiM3orO2HpSxyzVFgk
         A3FqNJusif5fhliEsJIoKOm0Zs5Q1DDzAj6kbJRnouI49X2YJGt4g1/VzlbDVpezCZNR
         x8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356775; x=1788961575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XW5bsunI5tFDnMF7+O8o66VjrM0zG8UGo/I7d0UClRQ=;
        b=pDazG/nQ+uOMwikZtgmIFY0jykE/2UXMT/uH3KDutDBgzmYGMgYKFfAyvtYP+LaAN+
         4pHnJq6cRKBlmwTKEsR0e1Gqo3ACNLTPUKpazvpDT5GHfkWlfAjyqeEzkUWfdKBLCxfK
         lPN3YnU0JRQudAQuv7KFx5NaKRQ+Cq+6DuR7gn78p29WMUJX6Gjy1gmSLyP71acxFbzJ
         RApCS6+0U9DaiDufbq3ERntNaMFOPQX/qLBYDKXIIk6WSI9de3nyeCJKOcQQOLO0MNoD
         z+jGbIazXfCwI3FETPrsAQcw5PXnWeJOO2ZLCrdL+lTZ3JIlPKii2ngKfX8itPW2b3Xg
         ehdg==
X-Gm-Message-State: AFuF++kmFY80eBxrEg+vLmzJ9FbQM9V8CXzN3SWhWcJYVOBq13tyK1qF
	PmYI+bM/2jOGgJEbIvoI0oXQL1tpkpnXB4iAh/WYmr46MMfTejF0VJT69oCWPQ==
X-Gm-Gg: AR+sD10CUJRwlmj5/uDCVIT3XKhDncBKDxxbea/+KJUMEyuWfERqq+fZ7Y8oRInAQve
	XUWyXY/j1TCCz0J9A9UNpn/4XYoEBqMVVL96GfSUzfyNA+d+Zq5Au5sCPXs/Wti2e6XWpE8lD/L
	Nukovlzo4pY9XGoP6Tq1JkrNHz9hYdr3H4mRekIPwuMNEdqjdo3wFf73FSjg/dJfO6XyznK+nK1
	Dohwy0EO80b2waYrBa6K6wQK87r6FdnG4yNqbMFM2RFx+IEmQxyLwkK2g/qN/0WQoyFIf21vZRd
	byGyOeCRWqYsmF8OZu/l8I/3G9vzkY+ylD418jsvsHnzd2hiHUv6Qe/hhO4cSK+wyz9KkT4pouR
	b6J+36e3Zapn0IQCIdy26gJZi93rsZZdGLoHHOHfQ05VOBPrCBgA6J+g1nJfsxzEzCofegb2Zb5
	1WrQv6qZ+nIgO8l26PMDPdX6RvIhP2uUh1fJ/ObkNcB23q0MoOrXn8yV28YFdeMpShTSoQSnknK
	dqqYiYDCluNAY5nA+HEXR07DibTNVPdTFd8z2WkWHoYCzJzp9P6zhw4N5vCDszCo8reD16vR44=
X-Received: by 2002:a05:622a:428b:b0:52e:4982:22cc with SMTP id d75a77b69052e-5303a462b59mr37283761cf.5.1788356765589;
        Wed, 02 Sep 2026 06:46:05 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5303325af1esm18686011cf.29.2026.09.02.06.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:46:05 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 9/9] libsemanage: document semanage.conf search path and ro-store-root
Date: Wed,  2 Sep 2026 09:33:17 -0400
Message-ID: <20260902133316.51981-11-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
References: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new semanage.conf search path:
	 /etc/selinux, /run/selinux, /usr/lib/selinux

and document the new ro-store-root option for semanage.conf.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/man/man5/semanage.conf.5 | 36 ++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 74f0d34f..2e560dec 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -5,8 +5,18 @@ semanage.conf \- global configuration file for the SELinux Management library
 .PP
 The
 .BR semanage.conf
-file is usually located under the directory /etc/selinux and it is used for run-time configuration of the
-behavior of the SELinux Management library.
+file is used for run-time configuration of the behavior of the SELinux Management library.
+It is searched for under
+.IR /etc/selinux/ ,
+then
+.IR /run/selinux ,
+then
+.IR /usr/lib/selinux ;
+the first one found is used.
+This lets a vendor ship a default under
+.I /usr/lib/selinux/semanage.conf
+and an adminstrator override it under
+.IR /etc .
 
 .PP
 Each line should contain a configuration parameter followed by the equal sign ("=") and then followed by the configuration value for that
@@ -35,6 +45,28 @@ Specify an alternative root path to use for the store. The default is "/"
 .B store-root
 Specify an alternative store_root path to use. The default is "/var/lib/selinux"
 
+.TP
+.B ro-store-root
+Specify a colon-separated list of additional, read-only module-store roots to search after
+.B store-root
+when reading, e.g. "/usr/lib/selinux".
+Only the
+.I active
+subtree of a listed root is read; the sandbox, previous store, and lock files always live under
+.BR store-root .
+Module listing is the union across all roots, and a module at the same priority and name under
+.B store-root
+shadows one from a read-only root; installing at that priority overrides the vendor module and removing the local copy un-shadows it.
+.B semodule \-r
+on a module that exists only in a read-only root is refused (use
+.B \-d
+to disable it), as is
+.B semodule \-e
+on a module that a read-only root marks disabled.
+Unset by default, in which case only
+.B store-root
+is searched and behavior is unchanged.
+
 .TP
 .B compiler-directory
 Specify an alternative directory that contains HLL to CIL compilers. The default value is "/usr/libexec/selinux/hll".
-- 
2.55.0

