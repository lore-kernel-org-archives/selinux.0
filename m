Return-Path: <SRS0=s25y=DF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF50BC2D0A8
	for <selinux@archiver.kernel.org>; Mon, 28 Sep 2020 13:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8397820759
	for <selinux@archiver.kernel.org>; Mon, 28 Sep 2020 13:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt+JItJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgI1Nn5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Sep 2020 09:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1Nnz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Sep 2020 09:43:55 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84543C061755
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2020 06:43:55 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x14so1324947oic.9
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2020 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbKegl6BHsTmHRU9BUV9+jjQd5WGp6PvePq4xlgLLL4=;
        b=Yt+JItJmuNbGNGGgcOPao4J8ZMwziXUOYH0AQ6YYeFrjoXxL0OYtcl6JPu0yX4OMR1
         t42VJ3qgaMCwOMDUGUeg1crF5ktuA+5TUb+RUB19E7f/PCEIHqrD7De4MwDc5P7Vorup
         Z6r9N9ucbMM/Ne58axO/tEZDVig9dXI5VtY2KwQ5g9aLe5WpmIzVJaXf5ZgTpIdG/5P/
         BSRrgFs1zrUBnE4wd5FxW+rJgNcJPcph8PfdXvOy+68C64fYdt9Gk9MyU17aNOBluMHV
         o2wMEvmYtgnmcKN1Hi/AJeJYx81d6f4FPviy8trFMXqfQcO4oU/PY0obIfw6k1ABuY6q
         ZjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbKegl6BHsTmHRU9BUV9+jjQd5WGp6PvePq4xlgLLL4=;
        b=LuBUPDHlsYnOe7waZmfssYyM3RKA89EEEFZSsKrZQiJTH1EaPxgN3Egan7lh7gCT24
         TpAEBaLNVEWQRtMxRqqPQjdMfmDz8Kv3wojVJS18SXSPkYne4Kzedum3WYI71iEvdCro
         pKS6nKXQAH5Y8NgspOFBCvpaEhDwidiij9XnG5HX7W1vw1BAYnkl8cicQX1OTB9q+tgO
         2Gt3uWAiDjpJks0qVZalbUTkIuc8isw1ENEGTsbacF+8zQ/s1IjlvYyfNZdYkbhaepIj
         vonxgVzAdW6GwXY8hMIAhzrQYVTvjUJdyyS6Ju98Kvu6wzHOFS1d3fCxG68gqi0bbCad
         264w==
X-Gm-Message-State: AOAM530U7wARojzwH43ipaGFQwc4KYTewXhSpDCGX0AFL3b7LJ+S/Lno
        sLn/FbA5FhVK/irXs/kEESByoBMPHhm2FvdbSTE=
X-Google-Smtp-Source: ABdhPJxx4in3Z/cBcUCNdcJZZ4gzaRjcKYnSm/vkZkRr82nPeEX4UxRtoczM/970mBed46LdbUVyiDYk4vkm3Cjby6M=
X-Received: by 2002:aca:ec53:: with SMTP id k80mr889983oih.92.1601300635020;
 Mon, 28 Sep 2020 06:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <160126062161.7010.15501362260483844999.stgit@sifl>
In-Reply-To: <160126062161.7010.15501362260483844999.stgit@sifl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 28 Sep 2020 09:43:44 -0400
Message-ID: <CAEjxPJ4ykGHdhk-3aM6sCVj1FsHj4e2-yUHkxPv1HLcD7Lru5Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: provide a "no sooner than" date for the
 checkreqprot removal
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Sep 27, 2020 at 10:37 PM Paul Moore <paul@paul-moore.com> wrote:
>
> We marked /sys/fs/selinux/checkreqprot as deprecated in Linux v5.7,
> but didn't provide any guidance as to the timeframe.  Considering
> the state of checkreqprot, it seems like one year should be enough
> time.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
