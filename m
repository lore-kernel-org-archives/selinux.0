Return-Path: <SRS0=6SNF=45=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA524C1975A
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 08:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B3D206FA
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 08:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dj8343gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgCLIkI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:40:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58482 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725980AbgCLIkH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 04:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584002406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uarTr4vtiZmSZst8np06EInr6Z3VbxfONv/v1YTqFuI=;
        b=Dj8343ggL1EIzYHG28VY1Dk+2SyQQfNzRWqF+y0Q4gu3RFTS3RBcwFF+/8Ny4JByuD8IEj
        gLgCzGUhwaUqq/5Z7r2D5mcg1/pYtT5szHUzeGBUqW7UES+ERO5FAi6qW+yCJGbKvKouwX
        qNVUhmRX9yeJNbf38KiKCgrzv3AOTF4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-QN7-URQOM42IrreKR4_GDA-1; Thu, 12 Mar 2020 04:40:04 -0400
X-MC-Unique: QN7-URQOM42IrreKR4_GDA-1
Received: by mail-wm1-f72.google.com with SMTP id a13so1848035wme.7
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2020 01:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uarTr4vtiZmSZst8np06EInr6Z3VbxfONv/v1YTqFuI=;
        b=WPNC3RDu5vA2X5YaLzHksX1Fi/FfGRVeOnMQiolJplhC9vti8uuiw4kt1dOlVvbw18
         SGM32TeKMFnMvwdny7ls+qu+vLmFB4UfyWPAzn4ttpEmpHmi0EgjaIwoL0sAgaSQCghB
         3p4tzSFVj1bhaathg7bVtcTt01d/ksJHA4bXzPqSMmM3H5P6BbtBItlkLp5PbZHktDZZ
         plC/8KWGoc80d4/2olbKqjDUCfll8XwWVCivmMT5hUa5BkmMMdIe+xgm40wnoZWLmi+i
         aylNv2aFSfkN8bK409lCg59v5NRSfodF2q46PcWqxFdY/UvS+BIFtVPeYI3zV3S08XPR
         oIxQ==
X-Gm-Message-State: ANhLgQ2FeU5nSOW5nCxeHO+jZzU6lVktegLyNKm7FDGpl91UY6n30O3Q
        XMs08O314xNvSj9hkzM6lNT2SEgM58M1L0HvERq327+UNQardgW/bZCMQJlPU/Y0ohOdW6pkHDW
        jEDnmFvkZOji6UCwA9Q==
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr10005657wrv.2.1584002403290;
        Thu, 12 Mar 2020 01:40:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsAdODMjuC7JcZWnedtr7Rj/RYBc8EXvzvmepMKmsj9gRYOhNBecEX8kdt6r180/wBVmUAsEg==
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr10005613wrv.2.1584002402950;
        Thu, 12 Mar 2020 01:40:02 -0700 (PDT)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k126sm11649260wme.4.2020.03.12.01.40.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:40:02 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/bpf: ask for unlimited RLIMIT_MEMLOCK
Date:   Thu, 12 Mar 2020 09:40:01 +0100
Message-Id: <20200312084001.101645-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently the code sets it to at most 128K, but this is not enough in
some aarch64/ppc64le environments. Therefore, stop guessing the magic
threshold and just set it straight to RLIM_INFINITY.

Fixes: 8f0f980a4ad5 ("selinux-testsuite: Add BPF tests")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/bpf/bpf_common.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
index 681e2eb..f499034 100644
--- a/tests/bpf/bpf_common.c
+++ b/tests/bpf/bpf_common.c
@@ -41,24 +41,16 @@ int create_bpf_prog(void)
 
 /*
  * The default RLIMIT_MEMLOCK is normally 64K, however BPF map/prog requires
- * more than this so double it unless RLIM_INFINITY is set.
+ * more than this (the actual threshold varying across arches) so set it to
+ * RLIM_INFINITY.
  */
 void bpf_setrlimit(void)
 {
 	int result;
 	struct rlimit r;
 
-	result = getrlimit(RLIMIT_MEMLOCK, &r);
-	if (result < 0) {
-		fprintf(stderr, "Failed to get resource limit: %s\n",
-			strerror(errno));
-		exit(-1);
-	}
-
-	if (r.rlim_cur != RLIM_INFINITY && r.rlim_cur <= (64 * 1024)) {
-		r.rlim_cur *= 2;
-		r.rlim_max *= 2;
-	}
+	r.rlim_cur = RLIM_INFINITY;
+	r.rlim_max = RLIM_INFINITY;
 
 	result = setrlimit(RLIMIT_MEMLOCK, &r);
 	if (result < 0) {
-- 
2.24.1

