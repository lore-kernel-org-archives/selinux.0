Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5DC433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 12:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823D32072E
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 12:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2GqVzW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbgFWMhL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:37:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57425 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729611AbgFWMhK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 08:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592915829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5P+U8IcWcn+FoMRhSlbLGo4kHHroRUUqScou366eC4=;
        b=W2GqVzW0Gz05pLXUs6Ewkrse/g/DwgPHqt/dpCR+sujPGzwzIso2H5c+2PhvPNLQdV35Nx
        8Nzy/0+nHRF+aHcLXG3z4E0CYcyp22bcoq9pBa2v+P8CoHIananAYHpSyLkQQ7/FY5jEDD
        gP8pP5ITfvRi7lF3Xw21d374CU3loBY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-ef2WL2heMzqDvgzjod6C_g-1; Tue, 23 Jun 2020 08:37:07 -0400
X-MC-Unique: ef2WL2heMzqDvgzjod6C_g-1
Received: by mail-wr1-f69.google.com with SMTP id r5so15513201wrt.9
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 05:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5P+U8IcWcn+FoMRhSlbLGo4kHHroRUUqScou366eC4=;
        b=gxIIg0wkV5Nt3TMldYhSPumh8sxAsVbVTVa2PyXlGCBRngaAAQE2L7s7HRJ6Qt6Doj
         bFxZ9f6cUC7bWauWEmm0hkX9IzrFfxtKNhmJxyFgKm2uopRn9aVteOIUffvm46zXJnhI
         kWilFhEq31Rjx9VuN34nfO6Xel/1vDoHZlv3y3imx54FU8shuioV4GI0DYAXa2cCFt84
         N5/SJ62JSgn2jzz1wTVHVlxhw1/1v6C2qqf5IsYfpmIl9W2JXHcK+/3Z7T4r60fEuR4L
         G1pS8ulkp82PWjEZho+xI/xgj1lgqbNF1gw7M/n/mLqUEoWZms9B1sZMH2tBP29myoUW
         +k2g==
X-Gm-Message-State: AOAM533hliNduIof5XkMHJjLNSu5HoImCw6PTXQgEzbrOYykoITipl3F
        vE5LK0L8jo6mDpl3wUiutm2x6exUcabVrqkX8r8v6E/euF/sgDCo/vgyOH3iXVhXCCk4Iui6CTN
        jCC4xHQtgOYC2sq3MLA==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr22972636wrr.391.1592915826277;
        Tue, 23 Jun 2020 05:37:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwb0dHatkxbMbVS/yoyMp6nbAMKJhKngPuTcbSiHs92FLnQhmR1sEaKS4Jzjn6imMaXGj4V5Q==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr22972619wrr.391.1592915826082;
        Tue, 23 Jun 2020 05:37:06 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id p9sm3449729wma.48.2020.06.23.05.37.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:37:05 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 1/4] Makefiles: remove bashisms
Date:   Tue, 23 Jun 2020 14:36:59 +0200
Message-Id: <20200623123702.401338-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623123702.401338-1-omosnace@redhat.com>
References: <20200623123702.401338-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In Travis CI (Ubuntu), the shell used by Make doesn't understand
bashisms like [[ ... ]]. Replace them with plain [ ... ] and also break
up the conditionals for better readabilty.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile | 4 +++-
 tests/Makefile  | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index 672733e..6c49091 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -37,13 +37,15 @@ endif
 
 ifeq ($(SUPPORTS_CIL),y)
 CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
-ifeq ($(shell [[ $(MAX_KERNEL_POLICY) -ge 32 && $(POL_VERS) -ge 32 ]] && echo true),true)
+ifeq ($(shell [ $(MAX_KERNEL_POLICY) -ge 32 ] && echo true),true)
+ifeq ($(shell [ $(POL_VERS) -ge 32 ] && echo true),true)
 # If other MLS tests get written this can be moved outside of the glblub test
 ifeq ($(POL_TYPE), MLS)
 CIL_TARGETS += test_glblub.cil
 else ifeq ($(POL_TYPE), MCS)
 CIL_TARGETS += test_add_levels.cil test_glblub.cil
 endif # POL_TYPE
+endif # POL_VERS
 endif # MAX_KERNEL_POLICY
 endif # SUPPORTS_CIL
 
diff --git a/tests/Makefile b/tests/Makefile
index bdbdf3e..919335b 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -68,9 +68,13 @@ ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt && test
 SUBDIRS += key_socket
 endif
 
-ifeq ($(shell [[ $(MAX_KERNEL_POLICY) -ge 32 && ( $(POL_TYPE) == 'MLS' || $(POL_TYPE) == 'MCS' ) && $(POL_VERS) -ge 32 ]]  && echo true),true)
+ifeq ($(shell [ $(MAX_KERNEL_POLICY) -ge 32 ] && echo true),true)
+ifeq ($(shell [ $(POL_TYPE) = 'MLS' ] || [ $(POL_TYPE) = 'MCS' ] && echo true),true)
+ifeq ($(shell [ $(POL_VERS) -ge 32 ] && echo true),true)
 SUBDIRS += glblub
-endif
+endif # POL_VERS
+endif # POL_TYPE
+endif # MAX_KERNEL_POLICY
 
 ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=" infiniband_endport/ibendport_test.conf | cut -d'=' -f 2),1)
 SUBDIRS += infiniband_endport
-- 
2.26.2

