Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A17BC001B0
	for <selinux@archiver.kernel.org>; Tue,  8 Aug 2023 18:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjHHS1V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjHHS0n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Aug 2023 14:26:43 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686A30DF
        for <selinux@vger.kernel.org>; Tue,  8 Aug 2023 10:40:54 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-403e7472b28so39300401cf.2
        for <selinux@vger.kernel.org>; Tue, 08 Aug 2023 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691516453; x=1692121253;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUQn25BGcMjzL3y6SoQj0r3paKXJ1PBdCyoodDuSZgc=;
        b=RCHYzGBDUj6GkLss1bipeeIIOF/IMLsW3Ik8qYed3Jw7a+IazwjcJTQt6ekB9lNr1v
         isObGnhFWh4B7vPCrPXkRq1bERg2ZxPlQgVQW+QWYHWA1nNjmdjlhHdtlcDoBrMptVcY
         yXhJZ8HULq8eojtIiQwv4tlJMjHMGVAl/tf59na6RexOzFAaxcbCV+3mw80QNCCQHylS
         rcr9bqYTJEiP3vEcMhElfNW3J/JlDuY/A3jLVzaWAQqLhQr/MK3UX5IlEMEalCmdy4ux
         MyCe5ou+9MZYpLG9OINrlggf7p2dyksseDgM3zAy5/4hxya1pNw7mWeLp52paSFR9uFE
         A/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516453; x=1692121253;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUQn25BGcMjzL3y6SoQj0r3paKXJ1PBdCyoodDuSZgc=;
        b=P+pW3RWVd4ycRKbH+zOrR94QyLTYqwtXKIjuV8NjJJ31tAr8d4ekecy0YKD0AVOhMm
         6phGlutsFJUxY6KkyrCEcmBDGdCKZh68SIzUl5IgjZAB2pvbZkH3/0h1A9nOW8/34vai
         WZD2eifIkQ8UpPsOQgODv9PTvzKICpfpTsM5YLmyDkbRxuZiK6xOPECG870dXxHJoI4B
         dbw9TSQRNp+kRcsI1EXCi4ltUtY/l7bh2j7TtQM0UAMCv5pshIH4Y7zeg+rZ5CYTmqx+
         vEtUpT++YhFriVl9Kv9KKDWS5kWj+MhZgLCGACK4PZKGm2vW3xS4ztNcsBZjzoSLddKT
         bAwg==
X-Gm-Message-State: AOJu0YzW3bBDRQNva6MSIImf40a9M+3cdOWHk9u71WDT2JCzY+Dh2n7o
        VjlRYCmfQ3gpB2PijfOiBGsHwCTKpYkmJFdr5BKH
X-Google-Smtp-Source: AGHT+IEKP6eRNPCD3Myu2ytdLUCB355RvKIELHriFiDMW4Q2zQKdkJov7rM3T3SQ+TjrQFlGIBEBjQ==
X-Received: by 2002:a05:622a:18a2:b0:407:fd3b:c6ed with SMTP id v34-20020a05622a18a200b00407fd3bc6edmr443728qtc.41.1691516453099;
        Tue, 08 Aug 2023 10:40:53 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id m25-20020aed27d9000000b0040fe0fdf555sm3530274qtg.22.2023.08.08.10.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 10:40:52 -0700 (PDT)
Date:   Tue, 08 Aug 2023 13:40:52 -0400
Message-ID: <06c87c5d051ebd4a93a5e39fba577663.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH RFC] selinux: use GFP_KERNEL while reading binary policy
References: <20230807180518.223481-1-cgzones@googlemail.com>
In-Reply-To: <20230807180518.223481-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug  7, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use GFP_KERNEL instead of GFP_ATOMIC while reading a binary policy in
> sens_read() and cat_read(), similar to surrounding code.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
