Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E58DC433E3
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9F12065F
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/YBui6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHXNj1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgHXNjG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:39:06 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC62C061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:39:05 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t7so7307656otp.0
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WlA9vL1kx0EgtSX5P1DSDZ1JxD8YIkmcB4kJGfdhkSw=;
        b=E/YBui6biE9oP5TK4P/lCs69wvxfGmolw4VN8hjjEZDhBcto0/zrUDL7IXMTCPYXQD
         46L3a3MxxmVF++9fVyM35Bia8OFppf/9JhOwVxpZ1jExRlFeh3C/r1TRPB8GEmFpRLFl
         VL5Nqh1/AUFHZe5NvQ6qvi1x/2mAoFkvMmpRqcCFwnoGog97JLTcKu5TUFsC9mmVD0SK
         h+E060Jh/f0+TOSBIQqz6hWrK08auVAcO4GXHnGXt4SstHLUu3+wssRWHW3Dy+9GYbJb
         rpYhe4uzPST3faweTGKeJSQ2e5Ztu/TKAD/HpIjSK23jgZ9AJh4qaotPs7J05QzfTaWu
         lPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WlA9vL1kx0EgtSX5P1DSDZ1JxD8YIkmcB4kJGfdhkSw=;
        b=RDkx4XuO0ssd+QRo/l5zfdYh0uq9W2VKWLdD4Q2HvZecgxYvB9lXmXmBHro3nl3d1o
         V8e9r8Xd7K50vYwSsTzPdqG8OLVTbCSY/gXA0JWWEbGLtFkJL8EwXXapE/yZo7MIZwOY
         IGPMkTcRjvNiHIoOGo0HwTBOMbZ8WPzk3Gjqfo0AIGuPzzvHEuqCz+QYmDPisZhuJfL/
         YUrLhvbf9eRKgq7n3z568c9E4cHQyZtqsZq5DRRGe4nXAheka3e/7bBcjd77x9vy4tyn
         AoWhS0v7Z52yVXoaExmv+VVXmH5RT3U4SPc+zlcwrjiiSqVehWamHIqPaGaLlddX/yrA
         Qd3w==
X-Gm-Message-State: AOAM532IbgAN5siOmy5UNAFrsKMaApEkzQh5ePxrOIrh7w/mwmW7Oio3
        ULk1s9IUqEQfFwywe08s2gq2UfI9P77aoAfXwTw=
X-Google-Smtp-Source: ABdhPJyP6kfBKhUAbT37ArsJtqkUmIhCf0WTiv96DtRPWkqSI9O1gcOkvDlvUJFmpxWn8d+4JVPgEGZrU072VC6Iwys=
X-Received: by 2002:a9d:25:: with SMTP id 34mr1329949ota.135.1598276345140;
 Mon, 24 Aug 2020 06:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200820151551.18235-1-cgzones@googlemail.com>
In-Reply-To: <20200820151551.18235-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Aug 2020 09:38:54 -0400
Message-ID: <CAEjxPJ4E6SghcazvGhCsLWRTgtFGcVZynVogTv1zDVQmcg4aTg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: use full argument specifiers for
 security_check_context in man page
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 20, 2020 at 11:17 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The argument for security_check_context(_raw) is defined as `const char *=
`.
>
> Say so in the man page.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
