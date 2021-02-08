Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B47C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 19:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D15B64E27
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 19:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhBHTlX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbhBHTjV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 14:39:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426ADC06178A
        for <selinux@vger.kernel.org>; Mon,  8 Feb 2021 11:38:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bl23so27063314ejb.5
        for <selinux@vger.kernel.org>; Mon, 08 Feb 2021 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7gqiOqRD2fAqsgbgcgVyQmaQh7+9rujE936/ufUCsDY=;
        b=MAN8mwhJyWuG6uKu/hykrVXBkknHsw+3V6BVs4vbmM+mqztbXo00T3S00QIH9nnDWk
         XDHwYOkZ7smwO7BVbXd5T+y0o1/864j51+M8BV54SZ0KEw5KrpNfR6OkNcwNqPQ9b80k
         2xSHjuqDBINKTu30AlvwvsfPRsnsQnP9pQ0TBIbk3j4cAznUyjlkbZF4HBoeTSys42k2
         dbSlEjsYPZYVAmT+HnwTADw4wIaUYC2Iu/GB/R/DGKN97SRFchkSSAjcXDeAGHadgVgX
         cUEkhvQRVIjB1VvWIqBhihbpX1sxk9rVo+PuevmA2oSwQ7EgIR+UaT18RgJwiQHwoiln
         De1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7gqiOqRD2fAqsgbgcgVyQmaQh7+9rujE936/ufUCsDY=;
        b=C2Lg0Q5Tx092xgz6ZoNXA2/qp7h/QXsx0/TsSrscQsZpWf/jBxBCN8DMaYXR4MeCgI
         xBI06VS7aCOWKW1tyrxIQT8fwHjujNh4m7F8Z/sKRdyTXdL7X6QbnuehMTMrWcZr4rIm
         aqvoiA4dA06AdRlWajZBVuHT4ICgy2074J4jWopzbVOaLnXdpsdDHPRpxtXO6Jj6iQyR
         AUIcnA+L0ud9oHUYmAg22K5PSaP/vRDsft8y4ZGKIvfwQyPuKW3gPmKn+1ujjxqFT1O2
         OiAGM1Ek96ZMVSVWlD9Z4VCSky1O1325EiBHz94wVTtny1e5F8wqR/BhchcampT72Uq0
         c6uQ==
X-Gm-Message-State: AOAM5309Stx8SxQGNvI3xEnBZZUOCt6T44KRNuMVgwplfPX1Qh4A88Wn
        C9gciE86t9KMQVQIVpSD+h4gjv7CoFE=
X-Google-Smtp-Source: ABdhPJx8OrScq9/T+pIvG0kc4N74hqt5flNfmeTYTx+qmfnNUo4MS9Ws4JcJxLKc/24kEjTFK5O5Ig==
X-Received: by 2002:a17:906:4013:: with SMTP id v19mr18588089ejj.5.1612813120058;
        Mon, 08 Feb 2021 11:38:40 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id g3sm1406317ejz.91.2021.02.08.11.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 11:38:39 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: Re: [PATCH v2 1/3] secilc/docs: use fenced code blocks for cil
 examples
To:     James Carter <jwcart2@gmail.com>, bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
 <55f751a5-2f6b-2f78-932a-9fcb4d363ba7@gmail.com>
 <CAP+JOzRkUOkcgFm-nPiC9Z4Sb+42+vk8p85qHxp0-gwkRh7eWg@mail.gmail.com>
Message-ID: <259fe5ef-9bfe-2eca-69b9-b31bae185ed5@gmail.com>
Date:   Mon, 8 Feb 2021 20:38:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP+JOzRkUOkcgFm-nPiC9Z4Sb+42+vk8p85qHxp0-gwkRh7eWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/8/21 6:40 PM, James Carter wrote:
> You missed updating secilc/docs/cil_default_object_statements.md

Good catch, I should also remove the 4 space indent as it is no longer necessary.

-- 
bauen1
https://dn42.bauen1.xyz/
