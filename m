Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B0C433FE
	for <selinux@archiver.kernel.org>; Mon, 20 Dec 2021 18:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbhLTSDy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbhLTSDw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Dec 2021 13:03:52 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8C9C06173E
        for <selinux@vger.kernel.org>; Mon, 20 Dec 2021 10:03:52 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w16so13356989edc.11
        for <selinux@vger.kernel.org>; Mon, 20 Dec 2021 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tJyGpuoR7/8NFWzkWOgeO214Ejclc//51ki/FyD4fc=;
        b=dTja5minMxIGCPuENIV4pDoCaRKP0OCoYtNlhfNazwv4fDD3yqKrfPTYirOBaXoLjv
         2LuoRLSrxAsBDGo4OagoZEZDBmXVA5+U3UJM3b+ineE9L6p2voAGUReWiHwG4IzrrEYc
         CjLXQsDc7WGdEtbQqOuCg2lreg0fecYt/pUEjqFssKLTYI5rJmpymGzqJPI265arTbQb
         geQ2Qlk7BXwpR6ZAvmMMf/M1n7u3qZSR4Idx/O3E+94+7+Ba3OEPgQMU1l3yBjB+KhJS
         eHg96GdIoXnx+gyDfyZTuwjUMKC3TfaHTdAPrbsS8Tin8B8YWIo9nZzQS+u/PdV9Pvvf
         SteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tJyGpuoR7/8NFWzkWOgeO214Ejclc//51ki/FyD4fc=;
        b=PK8yVIrPtYECcZuZhUaIhQLp+0j5PWgCtZVFq9kmgBXaWpK5ARUokmv8tyoYH2kGse
         DuPKkYDi0exa4/StX6g9QCichV2aahQu9uqNOUBfZz9KAb1cuMBowSrnE8AWaduaog97
         o3JOQSlSg8RqTUq3koU4zcXiTeEEO/ssVCI9jxdC1NeuDZRJudI3411q+TTkmguCAxas
         QDIRm/otSYJU78Q4IsWsv0WMmn80SgLNiLKUf3Gn1stMkoCn3IqoGNMcp6IigjEJ505c
         G07eSOkklmY2wcIxQ2NQRTG7GcdASxuZyUNGImLsiagt0Q1cIR/gQ9aKWrfxYL1Gz7P2
         ROig==
X-Gm-Message-State: AOAM532XOqa7lGycxz0JRlkmxWMsm6wT4LEWB+N/mKOsoSxdCjXbYRlb
        MpA4FoWQu+bGcjtccxdVtXD6Tjo0MOA=
X-Google-Smtp-Source: ABdhPJyfEnBhZNCZtoN0sO5zcpibq7mXKt9jHyq5kaStVeCokQeFddZdqM+d3Iiqb24LiDzhmdLBnQ==
X-Received: by 2002:a17:906:2686:: with SMTP id t6mr3009781ejc.743.1640023430826;
        Mon, 20 Dec 2021 10:03:50 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-001-020.77.3.pool.telefonica.de. [77.3.1.20])
        by smtp.gmail.com with ESMTPSA id e18sm2217120ejs.78.2021.12.20.10.03.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 10:03:50 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: bail out on snprintf failure
Date:   Mon, 20 Dec 2021 19:03:18 +0100
Message-Id: <20211220180318.37453-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not continue with a negative return value once a string append
operation fails to avoid increasing the buffer length variable
`str_len`, potentially leading to an out-of-bounds write.

Found by GitHub CodeQL.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 9916cbee..38edcf8e 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -1456,6 +1456,12 @@ int cil_userprefixes_to_string(struct cil_db *db, char **out, size_t *size)
 
 		buf_pos = snprintf(str_tmp, str_len, "user %s prefix %s;\n", user->datum.fqn,
 									userprefix->prefix_str);
+		if (buf_pos < 0) {
+			free(str_tmp);
+			*size = 0;
+			*out = NULL;
+			goto exit;
+		}
 		str_len -= buf_pos;
 		str_tmp += buf_pos;
 	}
-- 
2.34.1

