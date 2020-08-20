Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5D7C433DF
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 14:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3903B2075E
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 14:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/kqLO5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgHTOzk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgHTOzj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 10:55:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A6C061385;
        Thu, 20 Aug 2020 07:55:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d14so1714908qke.13;
        Thu, 20 Aug 2020 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rjWO6TXU8NO0ZVEVeXOHVAkNDhOIhxqt7yy8iaGsnEE=;
        b=O/kqLO5ILTPzaPEjNEZr/GENnVeNsbYSYUmmT90uppuSrtyZhwKzhNBNtPFJMFJRdL
         Gc3nrfKHzjM7ZtaM060Sm77t4jYaZXs5rAcezDDjLvz57KLkV/ETKUQSte4Xg8lbQC8z
         uNRgfcxKLyXfAITUTILzq1I16u4fd3OtY/ROlZvLifQfEQuCn8w8eL1adG5zkSl6ZU0r
         lXBGGmXfWMXkiS4xHZmj1nlPUypcY0PLTFmgt6MdHOLiP6GImLT8wjxmdcGVrqBP1a2j
         fOqQp0MCK+9aSoASvXlomD9jH4zgsJ0EVdlKKBOZqL9r/3PCFGi5F+6z7/GqAwWEKsYl
         8/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rjWO6TXU8NO0ZVEVeXOHVAkNDhOIhxqt7yy8iaGsnEE=;
        b=OEqSRbTCS7Uz8XMR8c6wKp0ZF/Kw5EDoB7xRPT2Jn3B6ncFCQK23rPFleU5XlWjzA7
         REeVDOcP70Kn3o1sCNSUarjnX3OL2SYKEmDvlYnWT3DjcQzRZMTDvK/CgoZ7adt6fLN7
         +7mBiY90xxj9VheZIaBM1uzK2onKfWGSri2o7tQBkMuofFWIBQ3JlIqaiGQgh89UAfLg
         WOPWHMAhwwg0+KppHLHVh4HnhZl8+iZY0qpuHW0Y9r/iXj/gUocN2yGbL+XrNIxAz6GR
         UKoEsVlWeSEycP+UI3j2HoXyvQC4f/Sl9e06xfNq5VGOAre4zW7v1RWkp/Ud6zyF2DRC
         H6Tg==
X-Gm-Message-State: AOAM531IMw+wIfxp3lbVsR4QkgB3z/M93q54GDd5VQXPFNQTdEdn+q7v
        NVQy7xE/IUpAeH12WwPtf9L7yChHgu0=
X-Google-Smtp-Source: ABdhPJwwSSXFv5eMmkESyqtx+B5Bga6Z3UcBBr9wS05748Kigjsx0hbk5nppCKisS8VlZWDzxRh4iQ==
X-Received: by 2002:a37:4c9:: with SMTP id 192mr2831201qke.125.1597935338368;
        Thu, 20 Aug 2020 07:55:38 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id n184sm2317027qkn.49.2020.08.20.07.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 07:55:38 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] selinux: Refactor selinuxfs directory populating
 functions
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
 <20200819195935.1720168-3-dburgener@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <c407864d-16f0-0a31-fb64-944c13420858@gmail.com>
Date:   Thu, 20 Aug 2020 10:55:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819195935.1720168-3-dburgener@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/19/20 3:59 PM, Daniel Burgener wrote:

> Make sel_make_bools and sel_make_classes take the specific elements of
> selinux_fs_info that they need rather than the entire struct.
>
> This will allow a future patch to pass temporary elements that are not in
> the selinux_fs_info struct to these functions so that the original elements
> can be preserved until we are ready to perform the switch over.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
