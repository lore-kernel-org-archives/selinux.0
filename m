Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D44C433E0
	for <selinux@archiver.kernel.org>; Wed, 23 Dec 2020 12:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94FA204EF
	for <selinux@archiver.kernel.org>; Wed, 23 Dec 2020 12:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgLWMWB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Dec 2020 07:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgLWMWA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Dec 2020 07:22:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693F6C0613D3
        for <selinux@vger.kernel.org>; Wed, 23 Dec 2020 04:21:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 3so5969206wmg.4
        for <selinux@vger.kernel.org>; Wed, 23 Dec 2020 04:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Laoxity+eJiKcx2OtwQHZI8ZRkUwTtAoIAfDHR9m8M0=;
        b=owAKtrQpT7t7fo9K8+WwUe0DCWYClWukJtIex4jf5n7z5veTC/JTgQwX//2N8ZnB4I
         QIVIhuJq1tjGwxqffMjcLnQ8MX92g0+F1lwS1rZQVRaU03BAgh6wt6oDUCWi9NluF7vh
         84NeYz2pI28Oi1UR0sVCQV9jVb5fswDTgoGjdnQ5FMHkDfDFv5w6EhtUcbPdWS9DOGLo
         3XK2qRVIwCFB4PBcFzw15c9NlOc/EkoYrkAfHZow6Gp0DqyNoIQj+Qvup+ZGuJdaa4k6
         UViylNkDQ0mosFOOmvC0P14AW4eizxuiSlva8sIOtCOQ7rrvv8E5/w4EijGdPchXnxX7
         de5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Laoxity+eJiKcx2OtwQHZI8ZRkUwTtAoIAfDHR9m8M0=;
        b=AjHmVEV2s5eFtVJU0fARcLMQEQRwRHbMYRsp1Mp+x9DCnIEK+a5gmdXr4t2cIQFebZ
         LjPSYYRSePWeKdv9wPAyFnCt4dYa45bKeBLr79FK3RQ944ZmTX32KeCCeAdWKDSLicq3
         hS32842d8F+eelhmim47DYWuJqE3AjaWj1Bk+tFxrWeE5XYn8mpNgp/dD96OWRaEOp2Y
         2bl3uP5JdR45ws+pNT0UV92+fOvBBU4izvX0/+awYnhVm6yZsKmzQyP1ZkQiuOlkb+89
         kn88h3GcFRLMd5n+G7EBayppq7UdW7vjGTSklEoYsvPvqIV3U4JlH58/vDzbZcnTdHIW
         Tmjg==
X-Gm-Message-State: AOAM531dkzVuyxicncLx9u7tAOeQkPWIqW9affrBloojlVdc1InQuU5S
        m1vKgxAwvA+349ymZc0sXWddfG3UHTLnlg==
X-Google-Smtp-Source: ABdhPJwJxznGU8boSaOAVZf6i3fMC+hZeDIB4BXYni6moe8HZJg3cUITaMdsTn/9cAOcvAHB4WZIDw==
X-Received: by 2002:a1c:8085:: with SMTP id b127mr25985558wmd.16.1608726078863;
        Wed, 23 Dec 2020 04:21:18 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id f77sm28686157wmf.42.2020.12.23.04.21.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 04:21:18 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     selinux <selinux@vger.kernel.org>
Subject: useless debug output by secilc when using expandtypeattribute in
 containers
Message-ID: <3c2ab876-b0b7-42eb-573d-e5b450a7125a@gmail.com>
Date:   Wed, 23 Dec 2020 13:21:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

This has been bugging me for a while now, but when using `expandtypeattribute` in a template block and inheriting this block secilc will print

cil_copy_expandtypeattribute 656

It appears to be a left over debug statement, and can get quite annoying (My policy currently manages to generate almost 1k lines of this output).

-- 
bauen1
https://dn42.bauen1.xyz/
