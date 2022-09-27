Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179EDC07E9D
	for <selinux@archiver.kernel.org>; Tue, 27 Sep 2022 19:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiI0Tp1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiI0Tp0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Sep 2022 15:45:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F02BD70C6
        for <selinux@vger.kernel.org>; Tue, 27 Sep 2022 12:45:21 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 9so10556886pfz.12
        for <selinux@vger.kernel.org>; Tue, 27 Sep 2022 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tKoLr1PQZscXRw3jf6ZbvxRTs8e2us7S7/f8o0UR1ig=;
        b=gxpx6yWfPvMe69DHKnTMCZKHJe8Q6e6VzjvveNqgUKlHhEG6E09bHT2qDenuKuRaT9
         g7OjImBt6xsQggubt/xCW56fH889GJHCEfBGbqTpi3EAb5e8iAfh4IKUHhqV4isl4fZS
         8iQvwC5LAA6Fg/xUiqmrX/TXvtT7BMFJfwQH5PlRquZQgaFmK7usrz+bjDjQ/YFjCALi
         EsW3M9mD0nNhoVmG06kiVb7gvNAtzFnMU8t/fUw/GOzhaQ2JIpY/MoK81TT1Ax6oqFrT
         ykCIbQd1mQo2l7xgZOwJOCdJWhxAEMPDS4O/ql358Z703BiAUaUOKEFruOxrXZxBgBV3
         g3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tKoLr1PQZscXRw3jf6ZbvxRTs8e2us7S7/f8o0UR1ig=;
        b=hn8M+EoLKftSzFcH2XcbyeXDe0ZC7Pd12vZyBakr/5hOh+CK+JOCgj0P8zMtvVOOiZ
         j4tZGgYouVqP1yaFb1jPjgMqoDiTTAGsXFxhb4xt5mIYFbhiBeVH4kF486534Out55kX
         IDjeHBpmP3F0tdYIXKKP9b1eA9SFY4b9+GneuGxVPUqAdhMvkObnmDT6B/ZYW/fSOjwV
         GiFxIUQxRu8lMXoSSC3n7fLz5zuoRYxFppzSQo/mN6IyaPZe4hcXN7GZJ0ASnf09euN4
         bED/+bJnD0m9/jX9e0E6XrekVvy+GIa9nyBfVkTnF/AV5UxxHaP7HlbxlCW704hTg0vr
         JboA==
X-Gm-Message-State: ACrzQf3loKvuy/MJS7jUBb6oRxcEge8dPNYDwdbMbUNLpGTz14STwrdg
        C5DwXNzSCm8RGSUdMToA3W2iIGQMESZzNhTigC0dGmC9sP4=
X-Google-Smtp-Source: AMsMyM7PkgkKjEm0Nco1JhqNulZZKACbHqvDYo3MJr0AHyE2nJ9vz1RNs5kTcN/Mh+4iG+b9LdOPFmiZcwZ+a/uaJB0=
X-Received: by 2002:a65:5688:0:b0:3c2:1015:988e with SMTP id
 v8-20020a655688000000b003c21015988emr25761740pgs.280.1664307920649; Tue, 27
 Sep 2022 12:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <166387874213.1884920.6973035378183003234.stgit@olly>
In-Reply-To: <166387874213.1884920.6973035378183003234.stgit@olly>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 27 Sep 2022 15:45:09 -0400
Message-ID: <CAP+JOzSaVG4asajffr2XbGND7sPRv1uQk=szegVPNV+GMfhboQ@mail.gmail.com>
Subject: Re: [PATCH] docs: add Paul Moore's GPG fingerprint
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 22, 2022 at 4:45 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  SECURITY.md |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/SECURITY.md b/SECURITY.md
> index 37630585..c817eac9 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -30,6 +30,7 @@ the issue as quickly as possible and shorten the disclosure window.
>  * Joshua Brindle, brindle@gmail.com
>  * James Carter, jwcart2@gmail.com
>  * Paul Moore, paul@paul-moore.com
> +  *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
>  * Jason Zaman, perfinion@gentoo.org
>  * Steve Lawrence, slawrence@tresys.com
>  * William Roberts, bill.c.roberts@gmail.com
>
