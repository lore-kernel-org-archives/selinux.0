Return-Path: <SRS0=wb4z=OV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B24C65BAF
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 16:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596402080F
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 16:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Bx2K1QWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596402080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeLLQGK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:06:10 -0500
Received: from sonic307-9.consmr.mail.bf2.yahoo.com ([74.6.134.48]:40888 "EHLO
        sonic307-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727830AbeLLQGK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Dec 2018 11:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544630769; bh=AAyDaqBwEWrHzXrCEtlpl306HHAwsgI0AAHJccOhSfc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Bx2K1QWc0JV1Ji+5i52w22o0H1dZA9g8VnvfUTjBDvwIoY1sNELSH06P9aPFs6xHLekdqwpSKtT95UZ2c33kbzFQMjmBbJlSzWQxKqdBI6eZdgnfGAa71tzz7YvkjQSnU18IiVSTHIxi1Qef6+/GLvini9+Ag1Yf3lvU1tV9q8+gaT8N6BIylBZFz0RXaODVkgsVAaMWoNrColh/DYpXMeb5rxdNSkejixJzmp3pG2HvLXGFXxT1v0e/TgmQrNzOu2XXSEFJK8njMmXMqqHvkbsPoV1updg51Q32O36LiIVgSC2QXhtGM3SxiOsb0sreL6RXR4+XkUjaU4RaO7EPXg==
X-YMail-OSG: IbcGqDIVM1kijcQXooZJ0yH02tUHUPsz2kYwHQ7cPD3k9xvzETfaR06USKMfUwr
 OgcpJGMjVc.UPi5zLc_mF2_NEZ5lYfzjaC31MDc8tsCaI6GaXOfTn_jE7RfxjPBKUS6nbWyXRrIJ
 uUmCVUtUQuI.mnGyMX5RhmN2Vd6By_576QkN.PQo.qlLYIvfkykQ9uHSPl9qeIURefqKWdyE142y
 u4kjHhyXoWt8P4_2.nALhZvdETPH8jB0CJCbuQrwvTjZUMla0A9GxRAlXI3Z8mx9JDJ8UsXQwzVV
 3AMaZVNb5p8Oc3vLYLeFfUxj4.h_vE1Uj8klJZAQqQPVA9KYGzwWUxbxxqmgndyN4yUFQjMudf7C
 JesLSQrsDfTFKX5EI9dZ2qWqbghYur8AHkZ9eqr7d_0DmsjJXKXcv3O8.zsKJSYr52SmF1rV1_c1
 YlE328iZOfMMDzs5ybmSbDd.N33vNOlQ9DfbILuAbafGwc_H.pbX9Iorzj5oIf5kDPqPRkLx2XQB
 qWYETZGX5YP.Y0kVYqEPU.01LAv32.meHh8v.FzlGHyhKFZbU6b868GUODyKAgMKbzyNvOkM5B1E
 BAeM4TTFzjNGfzhhHb_4FCmcIPhW0eO3Vo4R6FxTx69N8H8hJIE5x_JQgqvlIvpwRmwm8D_gLO3q
 HN2URR1T2iRoXRxOrfXammZJxKUHB5XV1B.C5zUONbdTDgYqCTv8MTCq0l3mm8zWQzDPSXsN7izt
 1bqoLGiaBjo0kjEmnnJgOFnO56BEAYrHKbhXMO7rdjRxU1S_xiul74R9So3rL5aPKlXPahYBueoI
 aPB5UZ4jJt9moueIGJ3F2wsr9k.RTk__gedMJM.WgN570Cg1fju2brdsMKgYC0U8Vz2j.DdgEBLH
 RnPYtvsyVqTA0xCZ3U.twGq21roux56tRySrg80TXHsYTWrPwQd52Byo7qv0TfjmGn4W48JCDQ1U
 ei3XsMjnA04aI5KwuiCn5P45fDhZ8ASLGhb6buFqe3rxrseq.1WzdOVbtplFYLnYquiHBjhqIQge
 v61esofMkdsiM3UMoHLnoqNpaCqHH50NnKJVtLyBvGhic8AM8kgq5iY35OZwUytNbn.pEYy1LHk9
 b7HY_nwtJpBjefylHekSey7JuHVgWcUyVz.5R
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Wed, 12 Dec 2018 16:06:09 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fe2a1506230eb1105a50167d41a8a69f;
          Wed, 12 Dec 2018 16:06:07 +0000 (UTC)
Subject: [PATCH v5 38/38] TOMOYO: Update LSM flags to no longer be exclusive
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com
References: <20181211224314.22412-1-casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <68432944-ad46-5b8f-09ba-cb956a479d49@schaufler-ca.com>
Date:   Wed, 12 Dec 2018 08:05:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

With blob sharing in place, TOMOYO is no longer an exclusive LSM, so it
can operate separately now. Mark it as such.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/tomoyo/tomoyo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 9094cf41a247..066c0daf0efc 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -577,7 +577,7 @@ static int __init tomoyo_init(void)
 DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
 	.enabled = &tomoyo_enabled,
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &tomoyo_blob_sizes,
 	.init = tomoyo_init,
 };
-- 
2.14.5


