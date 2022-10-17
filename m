Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810D3C433FE
	for <selinux@archiver.kernel.org>; Mon, 17 Oct 2022 17:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJQRwA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJQRv7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Oct 2022 13:51:59 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C86E17887
        for <selinux@vger.kernel.org>; Mon, 17 Oct 2022 10:51:57 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-35ad0584879so114761077b3.7
        for <selinux@vger.kernel.org>; Mon, 17 Oct 2022 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1kcQY67zF+4mN7SLyI10DtPe/+9Pw3KrCkytTl3nHO4=;
        b=H7LPk+7qUnofhLn8+3kcne+/sKtOHF23cHz7jPZQlAlZz8PPGdGURO9fVxQySSQ46C
         cjIPYTZUG0buzaXIm19NffC8FJ54NdoYMJphPI4tg7IR/Hqtq0KAfs6wd37OBlGM4kzQ
         ITLrNhk3vIfEu52r3k96wAwRg4+U/eR68FiDB4WbCLHScRYYVttF9QCfQPTbg5o3wyag
         n9F5XXoxZUUmLkD9CSWIiJ4HwJhD/FVn1K5nGs9LW1jprnQhDYNVoA/rbLu8CrH0iYbr
         guHwmYm0Nu7YF70AkIDs4x47oFnys6vQC553847ogQjt2AoytPFWGVSaUsNSpJEMs+4p
         DIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kcQY67zF+4mN7SLyI10DtPe/+9Pw3KrCkytTl3nHO4=;
        b=OSDOjKNWUkghKtQ1n6QR34sEzdI9BcSh++w2SvZo5OhPz+n/He2nq9MsCpBLjMlcs7
         XZjdKC5LVqimnLAH6p+mScV2aygFq45oy5NLcJCTtJR1G56BFjBgHTlFnnmFsUkC1fCg
         4Yuj+0f9IbcymrRozz9dUYNo+C0kZ17R4lXlPoGin1bSi6bKP3Oj4U1EcYBHZrVrsn7N
         asFCpt6T+nLmuD+o1B7NbQOsmdwbuN7GZYS/Gg9/ymgb/nXFQuwcvFRT2znR3W5/FJXh
         dk+BJDpFbFGPHJ0nQUXNVpCvNP+dDABiTGyEzz9KsVKp+0/TInCOM5OJOIWVYYFRG7I/
         9lHw==
X-Gm-Message-State: ACrzQf3N5i+hYT2EtMZa/Ev88ZbVxLjVBzALHgWT8KqrjoaMn3X/xgFe
        s/0lCx7rO9HRKj5G/XF+nA0/yiDPHiug5/FYgGDfVATkFQzR
X-Google-Smtp-Source: AMsMyM4FG0UGmoQxiTJAtl0N6hdELsUm/jNqONAjS3moTtbSabTUpy8OdG40E2NFSjHEZFTIvPYoNujOvFsKcDuE3G8=
X-Received: by 2002:a0d:ebc1:0:b0:360:5a77:4d78 with SMTP id
 u184-20020a0debc1000000b003605a774d78mr10123349ywe.336.1666029116144; Mon, 17
 Oct 2022 10:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221017122151.2837373-1-jwcart2@gmail.com>
In-Reply-To: <20221017122151.2837373-1-jwcart2@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Oct 2022 13:51:45 -0400
Message-ID: <CAHC9VhRkX17eXYqhA4-E1SxoXhqVr0j7NM3uHPBbRyG6c5CROw@mail.gmail.com>
Subject: Re: [PATCH V2] docs: Add GPG fingerprints
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org, perfinion@gentoo.org,
        nicolas.iooss@m4x.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 17, 2022 at 8:23 AM James Carter <jwcart2@gmail.com> wrote:
>
> For Nicolas Iooss, James Carter, and Jason Zaman.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v2: Removed Ondrej Mosnacek's GPG fingerprint
>
>  SECURITY.md | 3 +++
>  1 file changed, 3 insertions(+)

Nicolas, James, and Jason's keys all match keys that I have verified with them.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/SECURITY.md b/SECURITY.md
> index c817eac9..4f624f5d 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -26,12 +26,15 @@ the issue as quickly as possible and shorten the disclosure window.
>
>  * Petr Lautrbach, plautrba@redhat.com
>  * Nicolas Iooss, nicolas.iooss@m4x.org
> +  *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 C5EB
>  * Jeffrey Vander Stoep, jeffv@google.com
>  * Joshua Brindle, brindle@gmail.com
>  * James Carter, jwcart2@gmail.com
> +  *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 62AE
>  * Paul Moore, paul@paul-moore.com
>    *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
>  * Jason Zaman, perfinion@gentoo.org
> +  *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
>  * Steve Lawrence, slawrence@tresys.com
>  * William Roberts, bill.c.roberts@gmail.com
>  * Ondrej Mosnacek, omosnace@redhat.com
> --
> 2.37.3

-- 
paul-moore.com
