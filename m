Return-Path: <SRS0=CKju=74=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40F7C433DF
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 11:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7503E2067B
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 11:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbKwUcWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgFOLjg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOLjf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Jun 2020 07:39:35 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF88C061A0E
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 04:39:35 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s21so15560230oic.9
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 04:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bf0IIROrD5l4LpUblLe/g+nRUkvZ5XnAGzqEaHw2XEo=;
        b=AbKwUcWFdW/dXPrRznZRYX6ou9cioP0Kr2oqCPmGDR1xdExWTdxvuVc2UwYKLLOszA
         Zpf4tNyZiH/7QaLmU5dePriT+ImJUu8qdQjjdQt5z/du2a/6CpijEWMUoKklNnOyShvl
         p8exrIRlMp9Dv9LIkFaFozxu/F/SdJv2RmXJLFflZhx2Fvveuf6sUb84BebVOeGPD+9T
         1RyaA+9JEpQV6RrOg8SyYkUfQFIDeuJuthOJdq1M2bt7LMaMT3T+5GYZTgxmWHHkJ8QH
         OrCdXdCrTCy0YsJ31Vlq5ppf9l232Mrm3FXAEnOahiTX0HtFZue2mEF95sc4SXalG62a
         fOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bf0IIROrD5l4LpUblLe/g+nRUkvZ5XnAGzqEaHw2XEo=;
        b=fzXQ9Rgm/J+oYg0iRo5s/Cc/+8sRR/p/BkasVHZ5vkjZbP/S/tDyXhsyMi7BanBJ0B
         Jcj1SQccqmOF5aTrnOlK3DXDptdVYS8R2COB98Fwl/HqfJC8kjtUQnry6AlGxS1eENJf
         PEUwRkqLphmfKpZBvbELL5ohJ+yvayitkP+zRM1I5fDyoiN4yZBzQnGbQpv90LlYCtvc
         ellRgvvvWqJJrhRHv/2MaRREUN5jud22vvr+p1+H95Ur947bFcxX8+AHMGkz7NW9/VBU
         ZWErq6nLf5A7k6P3dqRlReXWCoIP4qijPAvxmJ+glMOlt1dF7nDRf60DkxdNgN6Kq43L
         6nrg==
X-Gm-Message-State: AOAM531ArrNr0e7lOGQxtkoorqBQGBcy1x68OVF2x5Yk2u2mad3ZSvyL
        vA7/f6FYwTz2rgJ0Xs8ENhmhg+SeI/OGXeyVd4+zJZf5
X-Google-Smtp-Source: ABdhPJz5zCGdBAXjoyDJcgcF00H2i8AAPmsABs0GG9vdWIQ6m6tvZ8YGREKRviKIU9HVNAQvSbETkDVsnEum5wgX5JA=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr8022267oib.160.1592221174687;
 Mon, 15 Jun 2020 04:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200615012023.8315-1-jiqin.ji@huawei.com>
In-Reply-To: <20200615012023.8315-1-jiqin.ji@huawei.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 15 Jun 2020 07:39:23 -0400
Message-ID: <CAEjxPJ4_09hUSYrvs7Av_JV7w9ApiQDRmY=wVu6B2MGJYStKVA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Fix NULL pointer use in selinux_restorecon_set_sehandle
To:     Ji Qin <jiqin.ji@huawei.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jun 14, 2020 at 9:22 PM Ji Qin <jiqin.ji@huawei.com> wrote:
>
> error occur when selinux_restorecon_default_handle return NULL in
> restorecon_init.
>
> fixes: https://github.com/SELinuxProject/selinux/issues/249
>
> Signed-off-by: Ji Qin <jiqin.ji@huawei.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
