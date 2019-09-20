Return-Path: <SRS0=JJ8R=XP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15409C49ED7
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 11:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E7820882
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 11:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQG4gAxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438281AbfITLu0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 07:50:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30460 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438245AbfITLu0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Sep 2019 07:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568980225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ujWdPb6tM+fB6ikcFhiakZYrReEpcspq8/UCdHPg77U=;
        b=DQG4gAxSYzutFJK2X0ZLC5Oxu4dP++TKpUxZcO+DoZsHRyo9R/kRBvw4HRD7dKKbsl/wVI
        M2l7g96vx9N0GfEiGpLUmnG2xs5fCbqtT4v5xID8OgNWyMhbNm+Gl5uAczcNXz1uKiTAkU
        nCxW/WzdWG6Of5jeyhKJcgcbJS6qerA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-HW-ce9itNBitBfPT1pFMUA-1; Fri, 20 Sep 2019 07:50:24 -0400
Received: by mail-wm1-f71.google.com with SMTP id t185so925573wmg.4
        for <selinux@vger.kernel.org>; Fri, 20 Sep 2019 04:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSFQRY7wJUqt5hWmMKU4qYegaYWL9fe2P3OLVlHG7aw=;
        b=sChUlqHl0PnSr3m8Mj79gxyPSRQpYzmbiBE55DN31C9+d1/ZhFMfXsDQgXD5aEJEIG
         fCBeKmZF6MREdDKUGW68NV5Y/l3Nl+RPmF1mntce/ZbjbUvdGe6Y19tLPPLIKjivAFq2
         UfNB3yME92EfC0GbeoVXuFpOXWfwxP1GJvMrIT7jxTLfvNKm4k5InFjAFfCF2jvdk7Qx
         oI5DDw0Jy9ENX6uQOkPW/y9V0YGnhFdWhSBd7YVpwFbhDp6gwiqNCT9E1oxxO87dhcHK
         0owZpfgs9Qz9gKDjtpkDTftJjr2XMagfF8ifv5TjNBDWEbYUyWXkisrFz9UrOKRcj7iV
         5Sng==
X-Gm-Message-State: APjAAAWHD0/RokPhnb/F7+t3A1AMieFMfdHbwf/7Zbgq3NOjh3yldnuk
        I6SUGAAOeUP4GDDNf21VE/Iy9muvqBwGuSpSnicjn/lA0VepkVX85CjWbiBEq0bbN2iU776m/tc
        ECNkjg05q3jxMSm2h+w==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr3381086wmt.81.1568980222813;
        Fri, 20 Sep 2019 04:50:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzF5FQVX1cNuDR7cOoT5SjdZ0yU93V1DnJa8U3y5A8Q6pIxhzeWrbBmlbuApp0eqj+lcXl73w==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr3381066wmt.81.1568980222523;
        Fri, 20 Sep 2019 04:50:22 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f17sm2200312wru.29.2019.09.20.04.50.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 04:50:21 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/Makefile: check if BPF library is installed
Date:   Fri, 20 Sep 2019 13:50:19 +0200
Message-Id: <20190920115019.23144-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: HW-ce9itNBitBfPT1pFMUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check for the existence of the <bpf/bpf.h> header before enabling BPF
testing. Otherwise building the tests fails in an environment where
the kernel and policy support BPF, but the library is not installed.

Fixes: 8f0f980a4ad5 ("selinux-testsuite: Add BPF tests")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile b/tests/Makefile
index e5bdfff..e8cf008 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -43,10 +43,12 @@ endif
=20
 ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo =
true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.15),-1)
+ifneq (,$(wildcard $(INCLUDEDIR)/bpf/bpf.h))
 SUBDIRS +=3D bpf
 export CFLAGS +=3D -DHAVE_BPF
 endif
 endif
+endif
=20
 ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=3D" infiniband_endpor=
t/ibendport_test.conf | cut -d'=3D' -f 2),1)
 SUBDIRS +=3D infiniband_endport
--=20
2.21.0

