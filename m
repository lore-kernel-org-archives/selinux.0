Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA187C43219
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbiAKVzQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbiAKVzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:04 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC96C034000
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:03 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id l17so839084qtk.7
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gRanSiycO/zRRQM7PRkt+DCm4KzjHr1EXVa37LNDsg=;
        b=UxTdXEUT3alcI3RD9PuNaH10zlXDpHJiQH7SyzGNREIfaPRSS3CTahym2Faiy4zbi9
         +Zmp91UClYv76YpO8VyZ/HsvZWrpd7VTtmkM7S5kADQA5i9YTzBbLxmvOYkLsPN8YV4t
         UDvvwdxikt459Ci2tAaZGxtXWXrSUORzMpM5CV7Gc5T6N2ZBYjcpSOsRvdQiXKEHiiGY
         gXrMdNoEIYWmrrh+0TmAVIoQsXxhjvxT2pMwezLBmtHO+C/aOuIs1FO28jRFXoY1nLzZ
         aPHzKhoLbyUIdd7MGnzYeZTVxXFLAgCCXn+7NTJBDMcolx2g3iRBZX+IubdgYat5sYjm
         ZAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gRanSiycO/zRRQM7PRkt+DCm4KzjHr1EXVa37LNDsg=;
        b=eWJP3p8vI9+RZULNZquRVP9JRbToG869MqhRTYEWCWI1TPFykl9sbn5ylxKFYjP+C8
         lhvYGo//j5HykYRvxcnGkMbyFeSfY9Y62BqCclesSg7gtkBEjREgvFJGp2fbUhk/aQ2K
         taTrOyT88DndVxo4x57qao84/kWu6xBObhiU2t54ZVrIIwp49ryt4InU+fJjxfI3nc47
         AEnZANch37Ol09pF16j0cQzNaVWUwid9FgAUOInGPYVVxlpJeca5ANgy2j8ciU3mz2e/
         IjZdIQgNl+uscz0eUWAxpVVIZ4or1NwbNlt7LhYSEUDzOSOFkhahGNf3IgMh96e+noIY
         veiA==
X-Gm-Message-State: AOAM531ld3T7Z95ot1i3YVymXhZedGgtbaLVWOEZVXrmSLb0tAnbOLEj
        htv++pYhcok+mz+zSgJBZ/nCONGIbMc=
X-Google-Smtp-Source: ABdhPJys4KTVBmRTmoCzaP3xLaHOCzuLiA95fDujQmeRqGO5WhJq+wMcuFlnNgbCG+SBryUZ0VjnZg==
X-Received: by 2002:a05:622a:130b:: with SMTP id v11mr384786qtk.355.1641938102143;
        Tue, 11 Jan 2022 13:55:02 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:55:01 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 10/16 v2] libsepol: Move assigning outer loop index out of inner loop
Date:   Tue, 11 Jan 2022 16:54:40 -0500
Message-Id: <20220111215446.595516-11-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Assign value based on outer loop index in the outer loop instead
of the inner loop.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 42fa87d9..9c09eef3 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -158,8 +158,8 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
 
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
+		tmp_key.source_type = i + 1;
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
-			tmp_key.source_type = i + 1;
 			tmp_key.target_type = j + 1;
 			for (node = avtab_search_node(avtab, &tmp_key);
 			     node;
@@ -334,8 +334,8 @@ static int check_assertion_extended_permissions_avtab(avrule_t *avrule, avtab_t
 	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
 
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
+		tmp_key.source_type = i + 1;
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
-			tmp_key.source_type = i + 1;
 			tmp_key.target_type = j + 1;
 			for (node = avtab_search_node(avtab, &tmp_key);
 			     node;
-- 
2.31.1

