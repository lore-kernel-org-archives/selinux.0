Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8FDC433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F7F20882
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ux/yv/Mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgHSPFv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgHSPFp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 11:05:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D1EC061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 08:05:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l23so18378445edv.11
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e9BMkaVMyhDF5FOTq0qtvmCFY39YFal/J43aHn7BmyQ=;
        b=Ux/yv/Mq2wRSv71HsHbqYor0i4WUQZDV1rmMw2MZYqn11hi8u4Q1L8BMuLE1dzf0U2
         dA+P1DS1icJ/lhKEcFCunuI6e/tbCy2+Azr51gPfENAcAVhiflQXD1hYDkRuk1Wxo4tz
         n/hxuri2guIWnb5RQGPB4/+vlTvtGJ56gAFeVZv6nqmRq4egsTS8kQR9AO5jsO/bC5zs
         C9LcpZU2CZ854KW3DwJ+Yj3U1ASeqLf3u0Vn/xTFcfwPZlpfki6NGVbiaDjxz7DTIZLj
         tAi55HhlJ9/XlC1eT0adZtZWdieIkBOh2IFDxGz30qbBKoq6evH5IcMuNg3MKNCaMIzy
         6haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9BMkaVMyhDF5FOTq0qtvmCFY39YFal/J43aHn7BmyQ=;
        b=ixwnl3804eeFM1ZtEthlZZaBk/KLJv0OxYbNmk/TBOas0LfnNY+W2yvecFJbpUvlrN
         mpidKhwo6kjBaHAzkzLZx0nGwKd9KRdyqOi3UjAy6+V1JuVzUUyvFAmmPnUzsTtNBgWU
         yh8BkOkuOL6wWrsutNFid/4iucd5g5Csj29a597EIZvalvXGcB7tpvdr3h0gwhUgXP9U
         I8agInv1dLCNoiWa3DwoMCcqnmptsgmfCRYsLZgCMS247re80iWR2uiO8YIEUTrNHsAL
         0kmNTy+SGVdcYWGmHjQQHV8wRPegh8Mr/ipN6AU488Rn9sEnPMNiZpNM6rFfkgzH3m2m
         lY1g==
X-Gm-Message-State: AOAM533csqTCvGt3ZaH67iz7jNAD2JyNBDuiMsgYaFVPcAlDOUoFl7bx
        pjWC76P0+eGurT2jgwpipEt/Zgrd8Tk=
X-Google-Smtp-Source: ABdhPJyG8hdVOauVwwTBlIQqYZoMDsCce+6zm/2Cza2NRVJ0jYmDuorlrL7lMEEo3CNuYCaQoU1rdw==
X-Received: by 2002:aa7:d411:: with SMTP id z17mr25170523edq.85.1597849542752;
        Wed, 19 Aug 2020 08:05:42 -0700 (PDT)
Received: from debianHome.localdomain (x4d018a81.dyn.telefonica.de. [77.1.138.129])
        by smtp.gmail.com with ESMTPSA id k6sm18932921ejj.41.2020.08.19.08.05.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:05:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] sepolgen: sort extended rules like normal ones
Date:   Wed, 19 Aug 2020 17:05:34 +0200
Message-Id: <20200819150534.18026-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819150534.18026-1-cgzones@googlemail.com>
References: <20200819150534.18026-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently:

    #============= sshd_t ==============

    #!!!! This avc is allowed in the current policy
    #!!!! This av rule may have been overridden by an extended permission av rule
    allow sshd_t ptmx_t:chr_file ioctl;

    #!!!! This avc is allowed in the current policy
    #!!!! This av rule may have been overridden by an extended permission av rule
    allow sshd_t sshd_devpts_t:chr_file ioctl;

    #!!!! This avc is allowed in the current policy
    #!!!! This av rule may have been overridden by an extended permission av rule
    allow sshd_t user_devpts_t:chr_file ioctl;

    #============= user_t ==============

    #!!!! This avc is allowed in the current policy
    #!!!! This av rule may have been overridden by an extended permission av rule
    allow user_t devtty_t:chr_file ioctl;

    #!!!! This avc is allowed in the current policy
    #!!!! This av rule may have been overridden by an extended permission av rule
    allow user_t user_devpts_t:chr_file ioctl;
    allowxperm sshd_t ptmx_t:chr_file ioctl { 0x5430-0x5431 0x5441 };
    allowxperm sshd_t sshd_devpts_t:chr_file ioctl 0x5401;
    allowxperm sshd_t user_devpts_t:chr_file ioctl { 0x5401-0x5402 0x540e };
    allowxperm user_t user_devpts_t:chr_file ioctl { 0x4b33 0x5401 0x5403 0x540a 0x540f-0x5410 0x5413-0x5414 };
    allowxperm user_t devtty_t:chr_file ioctl 0x4b33;

Changed:

    #============= sshd_t ==============

    #!!!! This avc is allowed in the current policy
    #!!!! This av rule may have been overridden by an extended permission av rule
    allow sshd_t ptmx_t:chr_file ioctl;
    allowxperm sshd_t ptmx_t:chr_file ioctl { 0x5430-0x5431 0x5441 };

    #!!!! This avc is allowed in the current policy
    #!!!! This av rule may have been overridden by an extended permission av rule
    allow sshd_t sshd_devpts_t:chr_file ioctl;
    allowxperm sshd_t sshd_devpts_t:chr_file ioctl 0x5401;

    #!!!! This avc is allowed in the current policy
    #!!!! This av rule may have been overridden by an extended permission av rule
    allow sshd_t user_devpts_t:chr_file ioctl;
    allowxperm sshd_t user_devpts_t:chr_file ioctl { 0x5401-0x5402 0x540e };

    #============= user_t ==============

    #!!!! This avc is allowed in the current policy
    #!!!! This av rule may have been overridden by an extended permission av rule
    allow user_t devtty_t:chr_file ioctl;
    allowxperm user_t devtty_t:chr_file ioctl 0x4b33;

    #!!!! This avc is allowed in the current policy
    #!!!! This av rule may have been overridden by an extended permission av rule
    allow user_t user_devpts_t:chr_file ioctl;
    allowxperm user_t user_devpts_t:chr_file ioctl { 0x4b33 0x5401 0x5403 0x540a 0x540f-0x5410 0x5413-0x5414 };

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 python/sepolgen/src/sepolgen/output.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/output.py b/python/sepolgen/src/sepolgen/output.py
index 3a21b64c..aeeaafc8 100644
--- a/python/sepolgen/src/sepolgen/output.py
+++ b/python/sepolgen/src/sepolgen/output.py
@@ -84,7 +84,7 @@ def avrule_cmp(a, b):
         return ret
 
     # At this point, who cares - just return something
-    return cmp(len(a.perms), len(b.perms))
+    return 0
 
 # Compare two interface calls
 def ifcall_cmp(a, b):
@@ -100,7 +100,7 @@ def rule_cmp(a, b):
         else:
             return id_set_cmp([a.args[0]], b.src_types)
     else:
-        if isinstance(b, refpolicy.AVRule):
+        if isinstance(b, refpolicy.AVRule) or isinstance(b, refpolicy.AVExtRule):
             return avrule_cmp(a,b)
         else:
             return id_set_cmp(a.src_types, [b.args[0]])
@@ -130,6 +130,7 @@ def sort_filter(module):
         # we assume is the first argument for interfaces).
         rules = []
         rules.extend(node.avrules())
+        rules.extend(node.avextrules())
         rules.extend(node.interface_calls())
         rules.sort(key=util.cmp_to_key(rule_cmp))
 
-- 
2.28.0

