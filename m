Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB255C4332F
	for <selinux@archiver.kernel.org>; Mon, 13 Nov 2023 19:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjKMT0o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Nov 2023 14:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMT0n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Nov 2023 14:26:43 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8801DD6E
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 11:26:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso7322682a12.1
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 11:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699903599; x=1700508399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NcfwGpH6HPjmS3W9NIdhcymoGyWVFv3w6k10CuCa3E=;
        b=WF7loyy8kvbTxNzDe9bm9kzwZan3t6zXCMItmqofec/+na3Bzy36LZTHIwsgUO4Xf1
         /bm9KfQT1CqALAdSeYTZyqB6o7FMsv0QbcCL7KRjQjA1VefwbrkeeKiOc4VKzZMhdxJV
         d9tmbojqfanWHLiL112GR5trlkVEldjlzvmIlDsdo/rJj1dvL/fLq3uYo7JxNMjAaKOP
         g3f7iL6XMT24AqLaxPs9SagqrWDprk9U5BYa0XX4nrrHe9layCGRtz86GbfY3ol3mRvV
         aX1ViieGj2HO5WT1GxKOP/rXYX77fWNlE2/fJI7F1x7q4ZMAx+MSiAkL+VTG6JNAgXEU
         /0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699903599; x=1700508399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NcfwGpH6HPjmS3W9NIdhcymoGyWVFv3w6k10CuCa3E=;
        b=qG+hU6hXk6x0z8JyfUAvxTA8CCE6c1XQUrXhG2KYiUzGUj7WDqKi5QHk1c9HKvloEU
         qCU3dYp1PkrnXEsHqVehjlaLckyxbZY2ofciBed4UJYlSHS8wfCzN99zT/RddhUZRi+z
         aYbj1BYNhLTRfwzfJuqwQ7sO6K0uhX+SJm7cwC37x0bbSduaF7kWmbH4zPy+7Djsz5o7
         PZp/CPFW7AbMvZm/He46+juQLpJTpDt8MGd3Me7BE7VoK8p3epE/VKe+pcG3fiXChANn
         XUlcv2QifU4foE1dkS2UO2gl0aA9scUTTC1iIdN1co9Px2R9ZniWFqcTrEZj25KATIDp
         deEg==
X-Gm-Message-State: AOJu0YwrBLsG9S/uYqgM9kT9OQppBbTiGunLp4h40Eqdhcuk/WHEBQXT
        IcOoLIXW7k5Zn9YvbUrYDshOmEkGKlA=
X-Google-Smtp-Source: AGHT+IGc00mYFPwZ1hFlpPHfBpOB2y0zYuGQ+nhdQYhb3/6oJGd31WW7T/u0NTE6qq5XL5A4KgGQ/Q==
X-Received: by 2002:a17:906:f115:b0:9b8:7709:6360 with SMTP id gv21-20020a170906f11500b009b877096360mr5940475ejb.40.1699903598800;
        Mon, 13 Nov 2023 11:26:38 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-095-116-141-033.95.116.pool.telefonica.de. [95.116.141.33])
        by smtp.gmail.com with ESMTPSA id lw27-20020a170906bcdb00b009de11bcbbcasm4523568ejb.175.2023.11.13.11.26.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:26:38 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: validate common classes have at least one permissions
Date:   Mon, 13 Nov 2023 20:26:32 +0100
Message-ID: <20231113192632.22509-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The traditional language and CIL permit common classes only to be
defined with at least one permission.  Thus writing a common class
without one will fail.

Reported-by: oss-fuzz (issue 64059)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 016ab655..1121c8bb 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -369,7 +369,7 @@ static int validate_common_datum(sepol_handle_t *handle, const common_datum_t *c
 {
 	if (validate_value(common->s.value, &flavors[SYM_COMMONS]))
 		goto bad;
-	if (common->permissions.nprim > PERM_SYMTAB_SIZE)
+	if (common->permissions.table->nel == 0 || common->permissions.nprim > PERM_SYMTAB_SIZE)
 		goto bad;
 
 	return 0;
-- 
2.42.0

