Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F795C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 14:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED6F206F0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 14:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="enrZQb/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfK0OrY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:47:24 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37446 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfK0OrX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 09:47:23 -0500
Received: by mail-qv1-f67.google.com with SMTP id s18so8986250qvr.4
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2019 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FZHyyhl995vEfu5tSgKqpTFrJtkbz8JUjtTee3cZIzY=;
        b=enrZQb/q9nr7MurPjOe6HzE0rFXE6+a1lin3G/v5CRQTyHkySDTm+HtATDoDT5tgmd
         qr5Ccfj+F96RUoyTqzskTOL7I6cBsnAt9trHy0sNzY9XAHFmRObhepEP4+jdD/BkCRYh
         eltVajjT63I5RNurGuG+WLJ3Yg+ubmhePtKSqNT9Uzuvj7HSLtmPLzgiAmUspBLqR0Tq
         ey2VV80CWD28vqFxB5RWEzfw4AnxxuRTBjp4TzLoFlfkbGmkOY4IWtlt8HQ5KWjM7MxW
         P5f4qEEq4jmsXaRG/PScxiMnLf+vhsJ5+16leM/x1cIdMPN7sGZXywDe0hO4sNkY8/AP
         n8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=FZHyyhl995vEfu5tSgKqpTFrJtkbz8JUjtTee3cZIzY=;
        b=Vd8MJnaKFY8WjWRaxzNny8yAyS0wZbUThBo84AedakZ23NOmUZLMjuYDKQMdahw5lq
         yKYHqGkl/mWWHGtcKino7PH/TYDGWiCxbgj/DrX5B+JlbUMK0HzY12ZH2KQ+1POUv1i+
         u+lXGtmKYhBMW7BqrSNrol6Prk/3MMgwcnHGxGovICZFD/6bS+KMK6MokKP5bjc8bQXh
         sf+LokyMfTR6GYmvGeBgPooq997/uKn/fovwNOK3296vla0JIlCjoEV9TzSPUalP1/+l
         C4Qk1R+WAiX19OJy77/CVd/iReDyT2IQlosCj/sSzchQ986FomblWsXYvl8e7S9FTCJw
         EfMA==
X-Gm-Message-State: APjAAAVB1UF8UZ4XTJr6JDENAozrVc3hjY/0av/CjzIdcOXc4YhXRxPA
        ZLvMZss0wSRVqLqIh+2uQYlcgfQ+Dw==
X-Google-Smtp-Source: APXvYqztxF2Hg9WURR/2CTskPlV9G4ETEECqtUGTlYdLXj9a/B0GeE+o9sYdmoDFJmG93i0gtqYHRg==
X-Received: by 2002:a0c:ff0b:: with SMTP id w11mr5052832qvt.77.1574866042125;
        Wed, 27 Nov 2019 06:47:22 -0800 (PST)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id f25sm6686328qkh.93.2019.11.27.06.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 06:47:21 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
X-Google-Original-From: Paul Moore <pmoore2@cisco.com>
Subject: [PATCH] selinux-testsuite: update the dependencies in README.md
To:     selinux@vger.kernel.org
Date:   Wed, 27 Nov 2019 09:47:20 -0500
Message-ID: <157486604069.70468.14139138243381994891.stgit@chester>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

The new kernel module tests added in a68d583c2a70 ("selinux-testsuite:
Add kernel module tests") require the kernel-devel package on Fedora,
make sure we list that in the README.md file.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 README.md |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index e845df8..4352796 100644
--- a/README.md
+++ b/README.md
@@ -53,6 +53,7 @@ similar dependencies):
 * attr _(tools used by the overlayfs tests)_
 * libbpf-devel _(tools used by the bpf tests)_
 * keyutils-libs-devel _(tools used by the keys tests)_
+* kernel-devel _(used by the kernel module tests)_
 
 On a modern Fedora system you can install these dependencies with the
 following command:
@@ -69,7 +70,8 @@ following command:
 		lksctp-tools-devel \
 		attr \
 		libbpf-devel \
-		keyutils-libs-devel
+		keyutils-libs-devel \
+		kernel-devel
 
 The testsuite requires a pre-existing base policy configuration of SELinux,
 using either the old example policy or the reference policy as the baseline.

