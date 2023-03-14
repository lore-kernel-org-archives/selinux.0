Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A9DC05027
	for <selinux@archiver.kernel.org>; Tue, 14 Mar 2023 16:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCNQ7t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Mar 2023 12:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCNQ7s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Mar 2023 12:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9DA6B314
        for <selinux@vger.kernel.org>; Tue, 14 Mar 2023 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678813144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ic14qY8AtfshmC4R1E3KPVCyYvuYFfssvGZ5fsMvA/0=;
        b=hTqn9yr0yPvIO704N3286WeFSuwNeSp+CeFsnRmE5pXuAAa+Jn1ashAnTYii8ItIwKTkLn
        keXb+uwIYtZxXGOokgc2jHHX+uv5uXtdapHe79w/dTVGHKlspKYAovSLz57akH1fYJE6j/
        U1MAyaHMlcxjKBy2d5htiUjAtYe6klE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-co7S0z0-PVS7Dg2ACosB-g-1; Tue, 14 Mar 2023 12:59:01 -0400
X-MC-Unique: co7S0z0-PVS7Dg2ACosB-g-1
Received: by mail-wr1-f71.google.com with SMTP id g14-20020a5d64ee000000b002cfe47b8ec4so1036501wri.10
        for <selinux@vger.kernel.org>; Tue, 14 Mar 2023 09:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678813140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ic14qY8AtfshmC4R1E3KPVCyYvuYFfssvGZ5fsMvA/0=;
        b=aB0jfhr9ljih6aEakYnfDjeJv3KDWd/JnBQN2db9FqpBsSTDjwwv6GKo7JAgXGfHS1
         ewHmc9OG9uFIj9Hcfq+IE01flWwD3w4XPYjnA6cMtI0YzZdvY16oco5aLc6uQziUGCla
         qcbzrLwnYYFtL6znsnszwZkrNVsjzo26sZWuQV/ERtxFfNkzYJ1Q4a7ZGhDzYjTHs0ln
         5KKGsNIhZiwTqjDIyzPlpHUS9XDJes9cae5LsfkNCmeYUDDca5bLMkNmHS8T4QdeDRvl
         nd4vYxaf3fZ8AGtd2oZmpFWSCcq9maYheJY4ZB7yvTcGVCLL1JySEP3Ew13+6+WUV/is
         iekQ==
X-Gm-Message-State: AO0yUKUiB8cfF3MeAWSE5kRKT9NOVx48zEEa3G0+iuhheEfkAFI94ceR
        rjV9w1AO0vJB6AlSr5hZacrNYLQvZvip9e/SmnhEK5+qxTVU8f0GpGZZgKZLciQ+r4WyxJzRNjb
        8NtsgGoIs6ahxuKMrs7UKYjkzoTFsfeai/FBW7ATmj5BozfnLeAXRm1szIrs/SIB6tGwJjmZohJ
        oTiCBN
X-Received: by 2002:a05:600c:470a:b0:3e1:bfc:d16e with SMTP id v10-20020a05600c470a00b003e10bfcd16emr14906582wmo.39.1678813140277;
        Tue, 14 Mar 2023 09:59:00 -0700 (PDT)
X-Google-Smtp-Source: AK7set86AvsliidUT3+XKHCWzp5Gps3bFdq1o7h7LP2R/o8TOn5kQeSG9Mc6EdifhNQKYV1DtMCx5Q==
X-Received: by 2002:a05:600c:470a:b0:3e1:bfc:d16e with SMTP id v10-20020a05600c470a00b003e10bfcd16emr14906564wmo.39.1678813139925;
        Tue, 14 Mar 2023 09:58:59 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d5951000000b002c70bfe505esm2508711wri.82.2023.03.14.09.58.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 09:58:59 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/atsecure: avoid running bash under test domains
Date:   Tue, 14 Mar 2023 17:58:58 +0100
Message-Id: <20230314165858.498705-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 'env' utility can be used just as well. This avoids the "bash:
/root/.bashrc: Permission denied" error message that appears when the
testsuite is ran with a terminal attached to the stdout/stdin and the
corresponding AVC denials.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/atsecure/test | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/atsecure/test b/tests/atsecure/test
index 59ba3a4..4079a1b 100755
--- a/tests/atsecure/test
+++ b/tests/atsecure/test
@@ -20,12 +20,12 @@ ok( $result, 0 );
 
 # Verify that LD_PRELOAD is ignored when noatsecure permission is not allowed.
 $result = system(
-"runcon -t test_atsecure_denied_t -- bash -c 'LD_PRELOAD=$basedir/evil.so runcon -t test_atsecure_newdomain_t $basedir/good'"
+"runcon -t test_atsecure_denied_t -- env LD_PRELOAD=$basedir/evil.so runcon -t test_atsecure_newdomain_t $basedir/good"
 );
 ok( $result, 0 );
 
 # Verify that LD_PRELOAD is honored when noatsecure permission is allowed.
 $result = system(
-"runcon -t test_atsecure_allowed_t -- bash -c 'LD_PRELOAD=$basedir/evil.so runcon -t test_atsecure_newdomain_t $basedir/good'"
+"runcon -t test_atsecure_allowed_t -- env LD_PRELOAD=$basedir/evil.so runcon -t test_atsecure_newdomain_t $basedir/good"
 );
 ok($result);
-- 
2.39.2

