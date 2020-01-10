Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867B7C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1122072E
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUcfAXqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgAJOiD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:38:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26058 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727823AbgAJOiC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 09:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578667081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CzgIuSg008eXA+wOOSE3hAnnszikvAl+lJtEHiEZLKk=;
        b=iUcfAXqjlP8rebrVdG1J7rVGC9C7A3qQNQQC3nQ1pjgRuP2/tzEgfp6t1qNLBs+fqZxBlg
        BhEbrcW/DGtmoVq4xj4ENsgqxY9c3SgX6ciUardMiwEn9M3M7EVcuQY6X06H+g1aQwmsNx
        lXP5irRRYFHO0p8+KrRXdhArAf3FQNU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-DdxKQqVXMrCJoMcpAZNB_g-1; Fri, 10 Jan 2020 09:38:00 -0500
X-MC-Unique: DdxKQqVXMrCJoMcpAZNB_g-1
Received: by mail-wm1-f69.google.com with SMTP id b131so868671wmd.9
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 06:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CzgIuSg008eXA+wOOSE3hAnnszikvAl+lJtEHiEZLKk=;
        b=OldzjQt+rY1uXrXJxsTfKXVqTBjp9DkyBdtAfYZm3PwGe5P0Wr9B7Ah8HqvfbYhhYH
         Haf2QYA51iC65FDMV2/k1kh03xhCOEMBkx9XzonOuEYHkLjA6qcO1OEdNfbPiPyrx0C1
         cd/pRFTgGcsrwb3f37+y227V4eZ/teN94CvSEioUgUkYKeAqSRgX3A4Ok5eCcdCjcekK
         0XW6odkigUOPR100g+3C43RFmISioqmyvmUusg6Bgnr51Sfgo3dR2KTKwwq+bAKL6Pat
         tXl3WmKYDhSq/lnBsZVrR7eH1YidWTP1caN8ZzUDaskt9nYcBJ27VL6+21RRNfk2gd6l
         v90w==
X-Gm-Message-State: APjAAAWk2no/KMQ/QU2yMuKP2Cko3xhi1aLONLDGaTyW65CCFgK7xZRo
        nhP1HqZfkUJ8JNdd8FEY8uOtQ2Hc/ie2W3v2YgxpTuyUNkjdZnLeDfvhUAawxDS+q/3HOZs5Inq
        lpUotiy5Kc6Nv4u7zUA==
X-Received: by 2002:a5d:49cc:: with SMTP id t12mr3775528wrs.363.1578667078951;
        Fri, 10 Jan 2020 06:37:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnYIlwaPrjrUd7FOQEZ6pOeLdrNICVZekZy/HX5y66hvYmj/w4/EbNSGTB63fHfPrCbuaCMQ==
X-Received: by 2002:a5d:49cc:: with SMTP id t12mr3775502wrs.363.1578667078622;
        Fri, 10 Jan 2020 06:37:58 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i11sm2458533wrs.10.2020.01.10.06.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:37:58 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Paul Bunyan <pbunyan@redhat.com>
Subject: [PATCH testsuite] tests/prlimit: avoid invalid limit combinations
Date:   Fri, 10 Jan 2020 15:37:56 +0100
Message-Id: <20200110143756.20101-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There is a bug in the prlimit test that causes invalid limit
combinations (soft > hard) to be created, leading to false failures.

Consider for example an old setting of X for both soft and hard limit.
In such case the hard limit test tries to set the limits to X (soft) and
X/2 (hard), which always fails with -EINVAL.

This patch fixes the logic to clamp the soft limit to keep it from
exceeding the hard limit. In such case the soft limit will also be
changed, but this can't be avoided.

Fixes: 0782228ef06b ("selinux-testsuite: Add tests for prlimit(2) permission checks")
Reported-by: Paul Bunyan <pbunyan@redhat.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/prlimit/parent.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/prlimit/parent.c b/tests/prlimit/parent.c
index be320f0..11c0c25 100644
--- a/tests/prlimit/parent.c
+++ b/tests/prlimit/parent.c
@@ -147,6 +147,12 @@ int main(int argc, char **argv)
 				newrlim.rlim_max = 1024;
 			else
 				newrlim.rlim_max = oldrlim.rlim_max / 2;
+			if (newrlim.rlim_cur > newrlim.rlim_max)
+				/*
+				 * This will change also soft limit, but
+				 * what else can you do in such case...
+				 */
+				newrlim.rlim_cur = newrlim.rlim_max;
 		}
 	}
 
-- 
2.24.1

