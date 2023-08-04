Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C243AC0015E
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 02:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjHDCUX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 22:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjHDCUW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 22:20:22 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87944A1
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 19:20:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76ad8892d49so133261285a.1
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 19:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115620; x=1691720420;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LNKOwxHOWE7F5nlJr77NyuO/IQs7geHTBuf/n+r57NU=;
        b=O5r7Ja0UXIglCSK253x/L4+KBTQ6RjCR/Idfm6Lbd5MhCNdjDz4TxzN2ECQ8nA62xG
         vdT0J91bUbaf967iC5zuzvcsUAJT9CqK7fRWhe/CtRVWgrYWvPP0lYjuddDa2Axtlxs0
         /gRStbuknqnrB08xejghT5pSlTtvuEw7Uf1jL0zobKE3mFPtlD9UV49Beq7VzTb23JTh
         MhaWKX918uE8BMoOpP9/jpz/VtTMweKjmqUJIfd9ZIKOTPRR7uhwaPpG9cRYiFlS2mHb
         inhyIZrJio4MHW2PS87qLucEQP3LRx562/3vLY4loOCY/pRg1owY5lxtRZUBnVg1L0/W
         kOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115620; x=1691720420;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNKOwxHOWE7F5nlJr77NyuO/IQs7geHTBuf/n+r57NU=;
        b=TabfIt8FuLNFgw8RGKEj7joH9TUO4OGvb14/Si9BrZUI0dVH9R1H1O5FyOCKt/NgI1
         BG3ZLCMATGvRJUe+VF3a/rnPvJJ/suDze8NQp1k6agiE6YT8iIFNgFaAcvnP+gXB3SSL
         bZMKz79hMb9TgtqodmbIrQMFEk14hunCXL81B2u19/l9fgi9NDmz/FJ2eoyQTxOE6trm
         cvenPt52B/IRavCpDcBvaLiEbpu1duZDgTY2UrPkHFiKu22BPaDgf9qVDW55WGI4FC5a
         4/lKYJZFAg5OnyhMpgShsX22Y5EeDCLTCQJiI5rWU/6DmH2wgCEjpT8puIOlJfr1pond
         FEAg==
X-Gm-Message-State: AOJu0Yy/f2Z3kKffdrVPDZb6FVmtiU6mBCR0IIk8A5IgCkrie4ivkaa5
        6kgy7jzGhrnbZuSIsNI1DkxB
X-Google-Smtp-Source: AGHT+IFVkjumHTvwJDTFPEiji4el72MdE25hpNy/Vg94yts8Q9m/rrET88tTdhk2YiDBTVBYbDNXCQ==
X-Received: by 2002:a05:620a:1711:b0:765:d53e:3352 with SMTP id az17-20020a05620a171100b00765d53e3352mr693534qkb.30.1691115620163;
        Thu, 03 Aug 2023 19:20:20 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a10b000b00767da9b6ae9sm340279qkk.11.2023.08.03.19.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:19 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:19 -0400
Message-ID: <05f7a2e580dc616b292c848e75f8a03d.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] selinux: avoid implicit conversions in mls code
References: <20230728155501.39632-3-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-3-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use u32 for ebitmap bits.
> 
> Use char for the default range of a class.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/ss/mls.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
