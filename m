Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F81EC4332F
	for <selinux@archiver.kernel.org>; Fri,  9 Dec 2022 19:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLITQf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Dec 2022 14:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLITQd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Dec 2022 14:16:33 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD9026AB1
        for <selinux@vger.kernel.org>; Fri,  9 Dec 2022 11:16:30 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so5929957pjj.4
        for <selinux@vger.kernel.org>; Fri, 09 Dec 2022 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C75ZdPzcM3XHSDZ6KUrUvEAP75rB8vnMji+ESgdMU+Q=;
        b=ptrqBjDMGxm4gOlYsTBV05wOY4RNj3CF/U6bM732ww3jlyEIxqRH+aKJz+duI0iD4i
         zhIrxjn1CVvrHZwnIeyb6hx7rX3yJ20DP+OrAb2NuZj7r/YkXQNq/zEsFwKN85ptBF31
         s9RfVYKf0+5n6luQnHnv9UlkzWtn6I45poBghybyngCiEbHtZqzm09LsQ7zgvplpQqUH
         GqgHkEzwUzqjEHwt7xU1kQhcBCPyZvzk9dO7UH529dw5yfMuOXT7vK54jZR8KnwIzkT9
         dVt3VnIOD8udgypf0Q5mnh2wCpBcOqgn6QyPqJ+n3CvOB8FGU07F/ypvY6++pm2i8vyh
         cowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C75ZdPzcM3XHSDZ6KUrUvEAP75rB8vnMji+ESgdMU+Q=;
        b=YPX16iTUzpSs1g+GlbyccYJ4t8sSRvMsJK2JgMYNVVNy1ZAYTE5oF2t8iu23ozxkLi
         NfCRUIeit0+j5nIM7p7zyqPASabJjC/BvqJV2B8jx15m8Da4yq6ml08B2Ih+RvKnE0nb
         8qMM8VPRd0P8ASqH9JG/Ner+KmDKwWYQRG1LBtBbA1hTcaMVM/caGsuGFq72af7thqsy
         TbqaJKrv20rH2v6HTWcYMN7c9y4OJtRjSzVobF1DpC2O6LJ19ATYrrq96p76wTyYPLjG
         rWylZXFlXD4lBKnJrYDBc2LKweSaPEom8BAucTqfY5+J1x+z1SHDI4NfUPQ15vi3aqGA
         7JsQ==
X-Gm-Message-State: ANoB5pntGPZ75f30C/TZ0m40lenPoQtDZ4kgpenfkEK/LaGId6hQq2wq
        egJojinNNIWhrMiSSjVHNUNrklrVUVqCz+2o/OWTCscmGV7Dqa4=
X-Google-Smtp-Source: AA0mqf7SGeI8Vl1Oga84deTjhoxzrfmTFKH6SJf6Q1UCMkaPUHrtGDS6krSsyRQeiv7LB6pPhBrJaaFqgD4HjnPdkps=
X-Received: by 2002:a17:90b:892:b0:219:b79d:c308 with SMTP id
 bj18-20020a17090b089200b00219b79dc308mr24725143pjb.69.1670613390062; Fri, 09
 Dec 2022 11:16:30 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Dec 2022 14:16:19 -0500
Message-ID: <CAHC9VhQhYuxwiTcr1=tXrznGpDHBTLC-x+1Sm-u8vXEabMjbpA@mail.gmail.com>
Subject: BUG: selinux-testsuite failures in tests/cap_userns
To:     selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A quick heads-up that the selinux-testsuite appears broken on current
Rawhide, presumably due to a recent addition of the user_namespace
object class.  I believe a small tweak to the selinux-testsuite policy
for the cap_userns test should resolve the problem.

% (cd selinux-testsuite; git rev-parse HEAD)
77352e748f006c343d602e4be03ae0d2cfcca831
% rpm -q selinux-policy
selinux-policy-38.2-1.fc38.noarch
% rpm -q --changelog selinux-policy
* Tue Dec 06 2022 Zdenek Pytela <zpytela@redhat.com> - 38.2-1
...
- Add the user_namespace security class
...
% tail -f /var/log/audit/audit.log
...
type=AVC msg=audit(1670612746.925:1138): avc:  denied  { create } for
  pid=11865 comm="userns_child_ex"
  scontext=unconfined_u:unconfined_r:test_cap_userns_t:s0-s0:c0.c1023
  tcontext=unconfined_u:unconfined_r:test_cap_userns_t:s0-s0:c0.c1023
  tclass=user_namespace permissive=0
...

-- 
paul-moore.com
