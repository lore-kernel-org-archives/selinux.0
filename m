Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7705C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86DC920782
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ddjqn5Ud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgHYPcV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHYPcR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 11:32:17 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE5AC061755
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 08:32:17 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d26so7032519ejr.1
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dbtyeMEeM+XxYPDUnUEqoigy+WyZUSo16ECMGI0BnE=;
        b=Ddjqn5UdEMa2uBA83gEG30LPvU9aI6w2oDkcjBclN5oT8dpwzg1kqWq6VsHhdyT4b+
         SZl0Ph9Rvww2z3k9XfB131Pp3YOxmAL2Wms/zbdRvyGWD0Ip0uQSv+b5xoJB26x+58dh
         qXrcfrOlhhj3m5CqR5lBO/6IWd3/FyUqUVLiHWFZmXjlxNxP39zhLBiZ282d+qwqeZBe
         LC9hTt+ujrPNE2vGHhy9qN92ih/CjwIELeS472ltFA1lvytzlYwBrSUMLK7edKDR4vGB
         4dmTZ2GUaGHuenuB/Hfy7a/5QXDvbw1h0EiLzwG88D/xr4KaoEiK7P6VLqPS1o1+d2tY
         5WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dbtyeMEeM+XxYPDUnUEqoigy+WyZUSo16ECMGI0BnE=;
        b=qN/vRv/vYcyAO6eaERtAet1PMVMNrsSiYu8EYfJzr8Hs1fE56lysTZJyih0pM/KQZ6
         KMd7EscxzkXXa4SgfLSjFkle31GFPKLGmANcy0A3cCnn99Mb56Xe0Crwubl8zYDG84ws
         bEnwTvC+IU9qEDgjgfNLP1js2fS0oEql6TpRFKHbfNLAACiZ7Bcn7cr8YYPtB9sQojuG
         KXV6E9x4YyAgfQrfyJi1Fbh9Hr0EcM0Hweiksyaii9goolv2QqnjLN4AJYfUqbF+57Rm
         IcE8XJXXqYugAceYSuB+K9KMpzNu2wdsQZtpqoBmNV83zE0wcW/is70+qBDO/pt8vYYO
         b0fQ==
X-Gm-Message-State: AOAM531uZPa2dzBJSL5vdYSlm9a/9Hc6ItcxaSxajKFQvBWqeqG5SeCy
        D8UxX6Uzebms39Pcsgw57S3i2C5YdXA=
X-Google-Smtp-Source: ABdhPJyCyjrjMF6bCuB/gjE8foxsEJDJDht/I3uuLcN7gZE/faCt8umDjs/zBXQggYio8aY9VBoqXA==
X-Received: by 2002:a17:906:5f90:: with SMTP id a16mr10940905eju.189.1598369535883;
        Tue, 25 Aug 2020 08:32:15 -0700 (PDT)
Received: from debianHome.localdomain (x5f74352c.dyn.telefonica.de. [95.116.53.44])
        by smtp.gmail.com with ESMTPSA id v4sm14029167eje.39.2020.08.25.08.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:32:15 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Subject: [PATCH v2 2/2] libselinux: initialize last_policyload in selinux_status_open()
Date:   Tue, 25 Aug 2020 17:32:05 +0200
Message-Id: <20200825153205.224136-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825153205.224136-1-cgzones@googlemail.com>
References: <20200824131841.55687-1-cgzones@googlemail.com>
 <20200825153205.224136-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If not initialized to the current policyload count, an enforcing change
will trigger policyload-callbacks in selinux_status_updated().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/sestatus.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index ca2d3bbf..9ff2785d 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -278,9 +278,10 @@ static int fallback_cb_policyload(int policyload)
  */
 int selinux_status_open(int fallback)
 {
-	int	fd;
-	char	path[PATH_MAX];
-	long	pagesize;
+	int		fd;
+	char		path[PATH_MAX];
+	long		pagesize;
+	uint32_t	seqno;
 
 	if (!selinux_mnt) {
 		errno = ENOENT;
@@ -304,6 +305,14 @@ int selinux_status_open(int fallback)
 	selinux_status_fd = fd;
 	last_seqno = (uint32_t)(-1);
 
+	/* sequence must not be changed during references */
+	do {
+		seqno = read_sequence(selinux_status);
+
+		last_policyload = selinux_status->policyload;
+
+	} while (seqno != read_sequence(selinux_status));
+
 	/* No need to use avc threads if the kernel status page is available */
 	avc_using_threads = 0;
 
-- 
2.28.0

