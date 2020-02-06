Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D437C2D0B1
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F682214AF
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UntRZ6h7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgBFNTI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:19:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51204 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727551AbgBFNTH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 08:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580995146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7qAx4IANH5ESmsoTZGHOF0ktZvwEjvyyN9GhYHWvEk=;
        b=UntRZ6h7tk/b86YqSV/QcD21JZxUf/70iG+iSNvpxlgDLK8MGs6DUQkP2csrh/1eHf4EwE
        CKM++iEHxPq2psbjcojrYkkgsohUHDFmjthX6h6Lfu2D9gajLuHePffbO/sQK0/YAKtqxK
        qd+yKRGZO8SEYzimGwQyctBZcZiGpsI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-djuy2-8XNa2xm4x8fznKaQ-1; Thu, 06 Feb 2020 08:19:04 -0500
X-MC-Unique: djuy2-8XNa2xm4x8fznKaQ-1
Received: by mail-wr1-f72.google.com with SMTP id z15so3395996wrw.0
        for <selinux@vger.kernel.org>; Thu, 06 Feb 2020 05:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h7qAx4IANH5ESmsoTZGHOF0ktZvwEjvyyN9GhYHWvEk=;
        b=XI7lBbF1JX3NP3ikpcpVVwHiARJKL0vBKkNB/1zfcyRdlCSZoFo+sFIaZXFkZNFnrh
         s/EPb2jjcf7CFBp18zcVCOYzRcsASp15OLhs5lb562X7V3i7XG1cy7aYeTNxEV9PB09F
         bRHKInGy2glaUlQ4ukR+EglE/jvHpnos7ssDU8wVd8nPCnJ93e8VmnkfnKI15Ml6egSu
         /I6xpMxuAld4W1o3EmBUzLHrLnPHubEza/bteS+0GU+XTbRFDFw7MATBFmufmEmU/U9i
         mGFScVq5MdGdTGH0f6YnHdHrnYQNk6+z+TYRCELYR0GLnNidrgcv57lF3gx7jryE7zK1
         OxfA==
X-Gm-Message-State: APjAAAVP+2+Vgn2TBhGDcLXDin41CGwhJuHYTE6HOP93agjy4Rurqa01
        DUwu1olTcKV4XnwMRNSMMAoZ0XsIdhQyfRLnf+F5t1ADepLGwyOsIWvqMJyETKji4jYyOxTk7+d
        b+lgWqMgR1KMo2N5sWQ==
X-Received: by 2002:adf:d850:: with SMTP id k16mr3752847wrl.216.1580995143372;
        Thu, 06 Feb 2020 05:19:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGjPWgTWna7DRT9mXpD7aRGuUwdBc1363XJsRWHHJJXhzeIUPd83vlIXouSRHdAG16nwn8Hg==
X-Received: by 2002:adf:d850:: with SMTP id k16mr3752830wrl.216.1580995143172;
        Thu, 06 Feb 2020 05:19:03 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q10sm3668978wme.16.2020.02.06.05.19.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 05:19:02 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsemanage: preserve parent Makefile's flags in debug mode
Date:   Thu,  6 Feb 2020 14:19:00 +0100
Message-Id: <20200206131901.535779-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206131901.535779-1-omosnace@redhat.com>
References: <20200206131901.535779-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not override CFLAGS and LDFLAGS in libsemange Makefile under DEBUG=1,
to make it possible to build the whole tree using the root Makefile with
DEBUG=1.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/src/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 8a9570c7..f6780dc6 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -22,8 +22,8 @@ RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 DEFAULT_SEMANAGE_CONF_LOCATION=/etc/selinux/semanage.conf
 
 ifeq ($(DEBUG),1)
-	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
-	export LDFLAGS = -g
+	export CFLAGS ?= -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
+	export LDFLAGS ?= -g
 endif
 
 LEX = flex
-- 
2.24.1

