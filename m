Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC27EB64DD
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 02:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjHDCUX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 22:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjHDCUV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 22:20:21 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2953A90
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 19:20:20 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-63cef62a944so10252416d6.1
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 19:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115619; x=1691720419;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anHjwPjiZzagsTV/ojI6gGr9I5a6pEf5vqZtND3Ybkg=;
        b=SAH2INs0H0RsUQ+WanHmSwBavc1TOKpNv1gxkeirK9w+1X/gVPjigC55V5uE88Bxq/
         i6WPzxjyOWv1MHDW6INGUghZV1A12eCrH7JYeiCSrpJeQNUjM3JS2Ztfq6DRVmMmH7+y
         7RrHGEZYeL/5bSVfKSFKzEPSz9nr4KvYZ7y3h7VUWiiJ8IHQCzifaNTa8/uSso01IxMs
         8m6K1StUuPtmjnkFcqn9h4OeSDtE7beVBN1elhxl4WJNExKZP1dtHb2TUfbO1IPGDvYF
         8L/oJAfvMCVsmNn4slaCfB6caij1pXZCLkdGlyhfj2h5Mk++PF6Tqodl7t0jCO9AKVBu
         sKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115619; x=1691720419;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anHjwPjiZzagsTV/ojI6gGr9I5a6pEf5vqZtND3Ybkg=;
        b=FDbb+fmS3sANgfiVI3gKHbjAf5YVamI+SGEi7+Xg9Plu5hDjOKsIMSBWzIytdD7dgl
         M8wKomz/mayRsRnXogkdel4gA83ZgukgrKROEvY6LVvs5Zxsn6/X2+1Lk3e5PSBEKT29
         njpypYHwWsfAFsr/rcpBp+UDJdVq16mD2SH9etWKvwA/+TK2g7atTIiqyxz8wC2eqL+o
         WkUtBoZiVteaZepR2V2D56xfaOej2uNrvepMpvGeUo/4gpG4cyhoT0Zbn2gTdbS8q1j1
         ftdCKUkyA1nqZfD12zQOp5Kq6iPngbcernnrSdFIJfJ+Z/kvt00V6MrLdVCaRm3Mdc7/
         fabQ==
X-Gm-Message-State: AOJu0Yz2c6YBq/lb/Zm2l6QX+TxVDWz7dU8I2F46h22RUsaSaeyhuyN3
        nCjxOfX8tqGuA+rlejvRuD9v
X-Google-Smtp-Source: AGHT+IFcxBAz22BTHcIswjcjcvcn8/xLuxpnDnVEoB4q/PVHkxBr+BVYhJF5ZURUA0DKVpu851CkIQ==
X-Received: by 2002:a05:620a:444f:b0:76c:9cb8:a243 with SMTP id w15-20020a05620a444f00b0076c9cb8a243mr595224qkp.42.1691115619212;
        Thu, 03 Aug 2023 19:20:19 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id o15-20020ae9f50f000000b00767e1c593acsm334331qkg.79.2023.08.03.19.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:18 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:18 -0400
Message-ID: <5f0390a4bd0649d7a621fbb3c614d5ad.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] selinux: use identical iterator type in  hashtab_duplicate()
References: <20230728155501.39632-2-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-2-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the identical type u32 for the loop iterator.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/ss/hashtab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Merged into selinux/next, thanks.

--
paul-moore.com
