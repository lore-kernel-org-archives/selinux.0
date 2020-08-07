Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F79DC433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 15:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201BC21744
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 15:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqbobwB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHGPFe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgHGPFe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 11:05:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE1C061756
        for <selinux@vger.kernel.org>; Fri,  7 Aug 2020 08:05:33 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j187so1956235qke.11
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=6QQ3qQUGOPO1iCH6V6ErwA5HgjTXBwpXQoRxktzK9oI=;
        b=nqbobwB7DPpvJLwkBENq2CRLQnRs9SkTgBbeKKY2hZ2uJS8u/HIfBJ4QYMKiJ9lLe2
         zhZOnev0SSZclsrEMsUjb+nqrXKNMtgijn++jSP66VElpCEQkVcWDx1nHPGZb0oxcYq5
         jHCnV++K1hNHwV+JWwpq/3ODN/ADsDqRZVLy8ApP1bpMpB5AGie0U9pYyN9d+xBWy+18
         g3UegWZIw16e+Nx4yTQLtZpm72Vjkvax5GYIiIs1WMhHq8TJVMCslF5BZeiY9OcikWAo
         KFSiDwNaF8xq6Qx3qyFAcHINYelg8M8LeOFQ78ARJjkfnVZ6uTsXxBU4Xuh/9DA+k8vc
         anUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6QQ3qQUGOPO1iCH6V6ErwA5HgjTXBwpXQoRxktzK9oI=;
        b=GGMOtcw9CQdhFFLVHnmr6V4NAb5yBxnY7fBJatlPBUMBRMblx2QwUqScslsZcYIz0x
         wCvLr8nOW0jje3k3YDSO9sV/MN5miw2YspRBAQdHnRjHi3DMi7/Y04MLHoHBidFxFvuJ
         WRKlNgCjoXaAA2mMBfOghlNMm7ie14Ox8mvD9tNdZHSG4q11lUofdkpcEjzgq8FfIRST
         S/mzWbQWslS3gC5y/PwIW8M03UGyEwV0AKYOCZDwx2Xi8RYc88p4fg394mZNWs4ieJ8w
         ir5SHdfH4pxE9zt/4Te7QT+2t7TBne13jkN70vBOEexpr9StDG72a/bR1uk26QDCmgMY
         I4Sg==
X-Gm-Message-State: AOAM5318gzEbitmAadpiPQEpSxWTvqd9m7arNMxgwXhZ5S6UbKxGmTAN
        CCgkcYUHKXX7Ul+BL24oJaJaVcwq
X-Google-Smtp-Source: ABdhPJxcI6JvPRapcAJnEukBDE/g22Gr4Qzd4y8Qn7yXP5misDgcc5pK9maMDJv7WbG+hzMegnprSw==
X-Received: by 2002:a37:8c7:: with SMTP id 190mr13189223qki.241.1596812732111;
        Fri, 07 Aug 2020 08:05:32 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id t8sm7142990qke.7.2020.08.07.08.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 08:05:31 -0700 (PDT)
Subject: Re: [RFC PATCH v2] fixfiles: correctly restore context of mountpoints
To:     bauen1 <j2468h@googlemail.com>, selinux@vger.kernel.org
References: <CAEjxPJ67MVocx8MO51VcpHRmwZzxANa8Q+-iZFgxPrdwXk5i3g@mail.gmail.com>
 <85917790-f0a6-0d57-face-58a6536b1793@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <c123b432-07e6-c26a-6d08-2b88863c2432@gmail.com>
Date:   Fri, 7 Aug 2020 11:05:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <85917790-f0a6-0d57-face-58a6536b1793@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/6/20 10:48 AM, bauen1 wrote:

> By bind mounting every filesystem we want to relabel we can access all
> files without anything hidden due to active mounts.
>
> This comes at the cost of user experience, because setfiles only
> displays the percentage if no path is given or the path is /
>
> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>

This looks good to me and running fixfiles -vM relabel appeared to work 
as expected, and a subsequent fixfiles -v relabel didn't show any 
changes so it seems to yield a consistent result.  Would welcome 
comments from others though since fixfiles has always been somewhat 
magical / obscure to me and I am not much of a shell programmer.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


