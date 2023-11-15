Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CB1C2BB3F
	for <selinux@archiver.kernel.org>; Wed, 15 Nov 2023 17:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjKORER (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Nov 2023 12:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjKORER (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Nov 2023 12:04:17 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500E196
        for <selinux@vger.kernel.org>; Wed, 15 Nov 2023 09:04:13 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-778a20df8c3so455486685a.3
        for <selinux@vger.kernel.org>; Wed, 15 Nov 2023 09:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700067852; x=1700672652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t7PpWKUKX02cwyE97zmsKXOXHDKK115oQwGRXsjroFw=;
        b=IBfpLJAgTd5Ysd7lqUy53I9pEaWT3qbI9o597szWz8eRBOjhH0eoYznvkBOYrFD6le
         A3LG35Gmc4NoOFsHqUhCnf6DXZwluk9X1Zub2ETtcQB3WHLCnQZq+FLwv7fuUg5dldqU
         /BMRN0HWBH4oHvvRQx4ynlpZpOxNg2dMy5o7JQB2irqs3KZXHN52uNJLCWpID85OsQVt
         FfP4oTX0jK2UMDV0FggILu9deiBj3tQy+jUOQdoN4Zt2HCkYLklX4idJtDSAee+oghEJ
         UkPqMz2v70OgDBj2DNX8V5znvP8L4AC01aCZ+Hseqx22UN+Y8NlFrAMkPLiGR+xxyxDz
         ANCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067852; x=1700672652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7PpWKUKX02cwyE97zmsKXOXHDKK115oQwGRXsjroFw=;
        b=sMO3QMmB0tc02BdWeGclUVbu7vgHaqn96ZvGPxF60Z8ACWyrEEPDgRwhw0jOCHamHb
         s47GcoCr4p5mLIIlgUhvhjR3S5LgM1a0jKweawIzugfBzdW+sePRVGyIsP3YdamRFhWT
         aWePtUVXEn0ZvZM4H1qH3EaCMAJfUH4Q4KHSh4Hof57go70rc+e8UzVBRy2Wi6CFotIA
         yrQWvspKzWrRQ4hRShl67zTOiYmS3FKhaM9EzQBIk1S+TDsx13nXM+g5bpvsE399YHZO
         u+8wGawSybGVQ/VnTQHQk5q3A9kr0til5p/Qu8y7KUzyg3qCg4MDutT1HFRssGBAobE+
         ndIg==
X-Gm-Message-State: AOJu0YwydYtlg8yYqDMMiZ0NIZ4bvRPAE2jXL2+AQ755j8Kk4DUJGjzN
        vzI0abnGuKIJ2H8BVpfnHtBuML5BvdwezWVmhw==
X-Google-Smtp-Source: AGHT+IH4n2Ti8bY48zbLY4xkY93dIDk4nAzI/ehOfEEGEAlKH+L3fQiuaHTRo1nk75s7Wk6OjQbOjA==
X-Received: by 2002:ae9:ea0b:0:b0:77b:9a8c:b0bc with SMTP id f11-20020ae9ea0b000000b0077b9a8cb0bcmr4662954qkg.44.1700067852315;
        Wed, 15 Nov 2023 09:04:12 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bp39-20020a05620a45a700b0076ef004f659sm3604178qkb.1.2023.11.15.09.04.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:04:12 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update the SELinux entry
Date:   Wed, 15 Nov 2023 12:04:06 -0500
Message-ID: <20231115170405.113117-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=paul@paul-moore.com; h=from:subject; bh=4mLsqH954iz0FGH1aX+2Fkr6DzcnDDAScNdM7o19nCY=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlVPoFT9bI4VW5ML9USkpdwwUjw5FPlY57+FuYY /I0003qkyiJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZVT6BQAKCRDqIPLalzeJ c3uyD/0Qtx/43Y2fm748mzlHC6XK5IVlZHCz49bY7EKvzNPuJwZ+Bik3Zxs3u4ocX2ENkQCjC+g 07/qgFDRAry/RPtd6QIdzFxg/ip/X9RQnUpEj6nOELBK0EqA55llxRPGhIT5dDvooeduh7aDxcR 4NmBigmp8RjFeWMCkedyFQ0mR8sKE7x+ZabPZPi9lFfXAGuOAqU9qgrRSUGmU3WoE380ZORKLNk 3LsRMAu2euWSl8P1saNOkajhpKjl7OyecqlNebpfYNt+m8oKekV3Pg31R9a9V7D+F/+ICrbj31E 6rgVz7l5MoLLWQAFTOvELhozlfiscfdLJdaNXNGgRXk/negzPLq7ITazM5vtoSg18G54zCM226a kOyEsogDvmIrFsIIb9iQGbNg60kUL8cV7YzhOOcEWraY/Y77KSctXBGSWOkrYHhF5H3ajHV7iKO Jk8EbWSGLlx9CLqdwbMr66JiPMhANkcGIW//pq89PgmvmM9l2eqSBz+8qqPB+2t04EC2NXpVCR9 0UH0YaKXnttuhqBIUgkK3mvCtZnZC51byBANVKIWWDBShkxBLMOEHbB5oXRyjEOBLJ2FQ6PSW8o stdZwLd4xPO73ZY1/NENc16VfaxqUjH7kw61gOy/vsGgE7zNinegw+07uoO9zz4Ll/jh9YeAj58 +6IyAHvXd2+p0yw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Bring the SELinux entry up to date with the following changes:

* Remove the selinuxproject.org link.  The wiki located there is in
read-only mode and exists primarily for historical reasons.

* Add our patchwork link.  I'm not sure this is of much use for
anyone but the maintainer, but there is a provision for including it
here so we might as well include it.

* Add a bug report URI.  I suspect most everyone knows to send mail
to the mailing list if they hit a bug, but let's make it official.

* Add a link to the SELinux tree process/management documentation.
While the doc exists both in the canonical kernel.org location and
the GitHub mirror, provide a link to the mirror as GitHub does a
better job rendering the Markdown.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..e5d289eaba83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19520,8 +19520,10 @@ M:	Stephen Smalley <stephen.smalley.work@gmail.com>
 M:	Eric Paris <eparis@parisplace.org>
 L:	selinux@vger.kernel.org
 S:	Supported
-W:	https://selinuxproject.org
 W:	https://github.com/SELinuxProject
+Q:	https://patchwork.kernel.org/project/selinux/list
+B:	mailto:selinux@vger.kernel.org
+P:	https://github.com/SELinuxProject/selinux-kernel/blob/main/README.md
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 F:	Documentation/ABI/removed/sysfs-selinux-checkreqprot
 F:	Documentation/ABI/removed/sysfs-selinux-disable
-- 
2.42.1

