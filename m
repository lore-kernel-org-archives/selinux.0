Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC86C25B4E
	for <selinux@archiver.kernel.org>; Tue, 24 Jan 2023 19:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjAXTkW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjAXTkI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Jan 2023 14:40:08 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3674093E0
        for <selinux@vger.kernel.org>; Tue, 24 Jan 2023 11:39:21 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g68so11981232pgc.11
        for <selinux@vger.kernel.org>; Tue, 24 Jan 2023 11:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f6OPaQLzgGTTjs3xmj3EjeSUakEUdKxMuCPF6eXnllA=;
        b=G093g5CMO1J93xoHm31xcfvyq0oYfEi645v6xyFdaBsdEdIsuNzmqnyniL3e4rIR68
         xZ9SpQS/nP2Fsrq806K63+rXdYp2XhCIxjVhAJA9lH6atOfsCJGEQEjnyBu1N6lSAjKH
         vJMatuAgrVqNEVPPMFioSNACAd715D7qqycwO0Y6RcrkjFQD/j2Woq3VWYtvzfOuymPk
         gFVnAvnP+4tsD8440/oixa63GSy+mVWzy2EGUimclEuxraL/mucxWrvje9RCQIfs5w7G
         rZudkIvLQBDsfJMOPmh84L5vjO/rdCteNrEwIviWXvuJyOM6e2IFGHkTCpCyRtbt0U/7
         ESEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6OPaQLzgGTTjs3xmj3EjeSUakEUdKxMuCPF6eXnllA=;
        b=ao8bAQP1tzx3YiT5JBkBPrxznpz4t/v3+0zzp6MwgPHcgD7rXE6YD/eLOkz9weWv6l
         tg6M9mo17hTlE9pmJuQbp8qWo+M2IHSCzhkDLLBrnSV3bpgY4EGNBOcaBAgH9yQbwf6e
         wzoGj3U/DYqRIlCY5vcAU6aqDMu2nyfqrM5LbkrLvF36H0CeLkQqEQNwpdZ+CLaAryVs
         GsVISgPDWyXt3sesl5UTiWr/s4EpYWir63OqM+9e/6b2OHFxhZlju78eApnPvC9xbgoO
         5a4rpX/VPaDuQ7Klo/J/gXer0x8I8oe7ytCYuK22130+Cn7l3PGZ1r2zGzQoH83Dn+Lk
         vT4g==
X-Gm-Message-State: AFqh2koKOrY2qIA95acvSGoVVkdioqM+SA6TalvKK3nwsHfkPXLxXB/g
        qtjKdMFw2/FGMwuq5gyn4JcB/BBCDo+TUTntZt9UtKOstTO0JMw=
X-Google-Smtp-Source: AMrXdXtdY2lth0GX8JmaP3euNTUE9vfDdN9cLQ1cFHMko4/ic4tVaqR8PNdwL1e8jWnIVD8dhCLcE1CB48G3sOVyplQ=
X-Received: by 2002:a05:6a00:f07:b0:577:62a8:f7a1 with SMTP id
 cr7-20020a056a000f0700b0057762a8f7a1mr3100614pfb.2.1674589160303; Tue, 24 Jan
 2023 11:39:20 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jan 2023 14:39:09 -0500
Message-ID: <CAHC9VhS1tSbP8s4QzVPB42O6_3wGX47=9HXBSyqwnHrW47965w@mail.gmail.com>
Subject: selinux-testsuite broken pipe noise
To:     selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When running the selinux-testsuite manually today I noticed the
following noise in the filesystem tests:

% make test
...
chmod +x */test
chcon -R -t test_file_t .
Running as user root with context unconfined_u:unconfined_r:unconfined_t

domain_trans/test ........... ok
entrypoint/test ............. ok
...
perf_event/test ............. ok
filesystem/ext4/test ........ 1/76 yes: standard output: Broken pipe
yes: standard output: Broken pipe
filesystem/ext4/test ........ 14/76 yes: standard output: Broken pipe
filesystem/ext4/test ........ 20/76 yes: standard output: Broken pipe
yes: standard output: Broken pipe
filesystem/ext4/test ........ 22/76 yes: standard output: Broken pipe
yes: standard output: Broken pipe
filesystem/ext4/test ........ 24/76 yes: standard output: Broken pipe
yes: standard output: Broken pipe
filesystem/ext4/test ........ 30/76 yes: standard output: Broken pipe
yes: standard output: Broken pipe
filesystem/ext4/test ........ 34/76 yes: standard output: Broken pipe
yes: standard output: Broken pipe
filesystem/ext4/test ........ 40/76 yes: standard output: Broken pipe
filesystem/ext4/test ........ 43/76 yes: standard output: Broken pipe
yes: standard output: Broken pipe
filesystem/ext4/test ........ 49/76 yes: standard output: Broken pipe
yes: standard output: Broken pipe
filesystem/ext4/test ........ 55/76 yes: standard output: Broken pipe
yes: standard output: Broken pipe
filesystem/ext4/test ........ 64/76 yes: standard output: Broken pipe
filesystem/ext4/test ........ ok

The test system was an updated Rawhide system with the following details:

% uname -r
6.2.0-0.rc5.20230123git2475bf02.38.1.secnext.fc38.x86_64
% rpm -q selinux-policy
selinux-policy-38.5-1.fc38.noarch

... and my selinux-testsuite build should be current:

% git log --oneline | head -n 1
2cc067f ci: limit VM reboot time to 5 minutes

-- 
paul-moore.com
