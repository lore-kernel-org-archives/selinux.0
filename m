Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75B0C47404
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 16:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5462205C9
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 16:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaSRo49r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfJGQDr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:03:47 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46952 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfJGQDq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 12:03:46 -0400
Received: by mail-ot1-f48.google.com with SMTP id 89so11383322oth.13
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2019 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RlqF4LT9FgFgK8fWvd2t1z0B8b+UKLUhcnpbvZv7Szg=;
        b=GaSRo49rtZCTKPWe9MWnF7UDsSNTZeqBqGDfQPyp03TbFejibF+YPD3DEW2vv9rpe3
         TMZgA20TlO3CP9SqmGf+IW9Leir8g46jrwhHhEYbYMipObgX9itRxM1rWESOYO6m9mYx
         4rgWW20o4SkcYKqnJhUm6Arz2YQt90xFfa2T1b0RAO+REv52TatwPsaOcUgRzYMslJZe
         EBmHJ1tiglacJQuvHJe/CUipAz3WeflGoWvdyFg62KgN2XkfHV61FKt7mgt7KYG5Eszz
         REBak8b/ekzg7YHwldNCW+CdhqvfnL5mYYDJWPB6c2Be4Voy0pNVImsFigMtl3xvqGVa
         nYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RlqF4LT9FgFgK8fWvd2t1z0B8b+UKLUhcnpbvZv7Szg=;
        b=YyP7PtccP2w3xZSdm3bWaXwqnTPuoENlpBpWznIlv5H3e7GgQLtpWZCmll1odCibTT
         /8KhmnuJLSdF+yeCvOHDa7GD0/GOsy679B1mASqq05zeoYhcfFNpCB67ZO8jGgPLmIrT
         izQedMsAGIo37WiVHcDuzcUFmBGatGxFtzY5BKJGX5p8o21j+bE+Az30IGYEMcccDWv2
         SBsVLjmQzjmr1AF8qGIsIx4cZQizLylYlMXbT7wZcIrjtLXUm31yiCmiIuUkPmXoJgKF
         09mC1Pii7sWGUnUlba+u3a5wT4bivlnd2pdvGf9hI44AA4q9lwclJZeF1EqQfWQip0wj
         /aMg==
X-Gm-Message-State: APjAAAU7+OH03KKWpid7M2bj1ykKUf4KnJwRHCijQfw4Chk66gkEH9Zq
        esFHHGruh5K+uYgEGfNd/KvDZQXP
X-Google-Smtp-Source: APXvYqzbG+EhFcYRE3ydlTUYLebutueBlclRYvLY5VUrsH0qbrT3d+NFqkKhxCgZs+yy7WHa+LUNdw==
X-Received: by 2002:a9d:4b8c:: with SMTP id k12mr21748655otf.86.1570464225865;
        Mon, 07 Oct 2019 09:03:45 -0700 (PDT)
Received: from ian.penurio.us (cpe-70-119-169-186.tx.res.rr.com. [70.119.169.186])
        by smtp.gmail.com with ESMTPSA id o23sm4602879ote.67.2019.10.07.09.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 09:03:45 -0700 (PDT)
To:     selinux@vger.kernel.org,
        Systemd <systemd-devel@lists.freedesktop.org>
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: [systemd SELinux] system status permission
Message-ID: <ae9ac0bb-0354-4d5a-fce7-dfc37481f439@gmail.com>
Date:   Mon, 7 Oct 2019 11:03:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I am hitting this (non-fatal) denial when reloading a service via the
systemd dbus API:

> type=USER_AVC msg=audit(1570462081.809:743): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
> msg='avc:  denied  { status } for auid=n/a uid=0 gid=1001
> cmdline="/usr/bin/python2 /usr/local/bin/test.py"
> scontext=system_u:system_r:denatc_t:s0
> tcontext=system_u:system_r:init_t:s0 tclass=system
> exe="/usr/lib/systemd/systemd" sauid=0 hostname=? addr=? terminal=?'
https://selinuxproject.org/page/NB_ObjectClassesPermissions defines this
permission as "Get system status information," which isn't particularly
helpful.

Ultimately, I need to decide whether to allow or "dontaudit" this
denial, so any information/pointers on what systemd is doing here and
what functionality I will lose if I dontaudit this denial would be
appreciated.

Thanks!

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
