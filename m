Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B1CC43462
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B866121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhECRy6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhECRyx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5793C06138B
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:53:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b25so9187567eju.5
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1JhlCsiGRXtSRbdAAlrHwjRODmg8T/Akun+p7ZCPbQg=;
        b=n0vPmMKNYd4COy9wIxVVMC+Z9/iiwr23bMQHm5p0grzsWvkAb2605AlcJoPEabNVFO
         XFlln3IsjIr/+cQEwPkoqHUXHseaYfr0k1oXWgpoVtLqjgbkMP+kExQ2ouAuWqStLzZ0
         gwTU5F4hGd92xyBldlsQkY7bnJK0UPIW7wH7o7rQRwB9wvS57p4DlRETdm+XuI/EqDr0
         BgQGe3K0i+ww7AxcfQhkxmcHaODW66GaopMArxNeS0NtaK4yDgOz0SV9O2XXjVd5FWTW
         zXh1tKVjWBofn1qI/i3QPS57R7T+tBAaD6CHBa9J8JhfDVgM1n434lZojaR9CewZ/tDN
         ER+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JhlCsiGRXtSRbdAAlrHwjRODmg8T/Akun+p7ZCPbQg=;
        b=tmtKnehES8xwFJ4iHAoS1bNVoZ4vETJj+SSYkxV+1RT6rjbnlvQ5kgKLavU55I4/lE
         bVrw3PiFZ2RCdWSOtJJUOMdL3qdDJPopw6+YEfoTidhD5L/brlPugPYcg5g/dTBVqVg5
         pYA1W46DyB5bWylJ6I6EsePYDoJCagnAaPEhwpKrHinqqRDQzUkZZY9u5HiPF8S5qUk1
         qDJW6iiSnl724TMjgnpnLjz4C5Sf5wMAZIOQeMFroj8BYSyo23a8bbJJ8QE6GHY5u0CA
         Pv9xaQy8H/+JCln1k2ejbP6EOH8MhVq+5SMs7TiTPLLsyw7U+060v7b9xse6LrOrkqs0
         69cA==
X-Gm-Message-State: AOAM532S/cquvqymy0nVe00NUV4Au4tboPuPTMNtJ7kbM5XXp+Ir7I8c
        fA38K2lK/UrLQPaScIzcr01CQP298/JViA==
X-Google-Smtp-Source: ABdhPJz3l+fgidxQTlG79BtrnLBVC6hT3HKOLxZMWRYMVSDJ9+MqMGpUyyxWTv5LZIaHb920sdJY6A==
X-Received: by 2002:a17:906:2482:: with SMTP id e2mr6622734ejb.212.1620064437597;
        Mon, 03 May 2021 10:53:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 06/25] libselinux: avcstat: use standard length modifier for unsigned long long
Date:   Mon,  3 May 2021 19:53:31 +0200
Message-Id: <20210503175350.55954-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The format width specifier `L` is only standardized for floating point
types. Use `ll` for fixed-width data types.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/avcstat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/avcstat.c b/libselinux/utils/avcstat.c
index da239287..cc9a48dd 100644
--- a/libselinux/utils/avcstat.c
+++ b/libselinux/utils/avcstat.c
@@ -205,7 +205,7 @@ int main(int argc, char **argv)
 			die("unable to parse \'%s\': no data", avcstatfile);
 
 		if (cumulative || !i)
-			printf("%10Lu %10Lu %10Lu %10Lu %10Lu %10Lu\n",
+			printf("%10llu %10llu %10llu %10llu %10llu %10llu\n",
 			       tot.lookups, tot.hits, tot.misses,
 			       tot.allocations, tot.reclaims, tot.frees);
 		else {
@@ -215,7 +215,7 @@ int main(int argc, char **argv)
 			rel.allocations = tot.allocations - last.allocations;
 			rel.reclaims = tot.reclaims - last.reclaims;
 			rel.frees = tot.frees - last.frees;
-			printf("%10Lu %10Lu %10Lu %10Lu %10Lu %10Lu\n",
+			printf("%10llu %10llu %10llu %10llu %10llu %10llu\n",
 			       rel.lookups, rel.hits, rel.misses,
 			       rel.allocations, rel.reclaims, rel.frees);
 		}
-- 
2.31.1

