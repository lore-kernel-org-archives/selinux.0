Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081EAC433F5
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 22:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiAYWuD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbiAYWsh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 17:48:37 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDDEC06176C
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 14:48:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z19so22899991lfq.13
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 14:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mGu4hUVfAAPMG/lySmrJGJl6zgwYxA7GIIsE6nUuYeM=;
        b=F8cdrBtSHqo2Z0Wdu2hZS6TosImMwSBca7DPk7TU+0dPo1RQzmbWmsGN+2aV81aGaN
         81izACf7gyAjcLV9mkx+6Giz0f7M8f2nIey89tbfswPBzAgyzyWlWjD4a+gtGQzR39RF
         IKb6ZiR5Kkj9qwbwHwF/YexTDhfQEF49pqApQtFPt3XsBo+oM6LOz3HTnD9SP6B09lcq
         yj3oBE03IT9NdM5kMPf51sZun0hta9DeBk8eLKXsgu6rppFVO0URuOPgDAvs6L2kgPgs
         LauhbruVRXhQd3K0TNzPF/7sbi1qd0ad9GSU0iwY7ncFTtkd5tvwdB0qNFg8RkbUGfNo
         WHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mGu4hUVfAAPMG/lySmrJGJl6zgwYxA7GIIsE6nUuYeM=;
        b=uVi8RMYu72UTAm+BAfGkXPJqw9Qa7EfVyR9G1oKHb7a1UqmYVSit+QocXya8tgoS0B
         NYlvFzaTZKIEac7xAR2C9AWzDlD2aItbvqLs0pLc07CZJTHh+8+0rpC+ssicKVBsJwuC
         QcoTwP+11LMutyRS3u5LwxcxYCt+spVQnxwOrx0+fNhhQk2uAw6KGag0oYQOhLbuTlx4
         Q7yOXibRzP3X4wqlsrgWofVLJoVaHDMkTiGhKmBCGte10xBPCTd9sqpoyTQp6C6J0643
         K8y2YvMd+KuZnL3dEx06I3819wl/G0tDX2PKZqH+oVqDT1uU8YXUiOLBFhy2f6hF+abz
         u2Gw==
X-Gm-Message-State: AOAM530hMScLYoSRhqPe7VyFcwRhed7h3X1ZECtSBawzkvb8o3yOJhsY
        6k4vI5b2u4B/eJ4+uMgvWccBE2MKdpv+h3cGHzBTDQ==
X-Google-Smtp-Source: ABdhPJzmT2Y2xsealukDgOL1p4z8US3rq7Fw9rDMzOG6kMf1xrw83Fr6LXmzEo8/vnYGtFzKjztv+NqSXUZdyu0Aygk=
X-Received: by 2002:a05:6512:1506:: with SMTP id bq6mr18829314lfb.444.1643150884606;
 Tue, 25 Jan 2022 14:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-8-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-8-cgzones@googlemail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jan 2022 14:47:52 -0800
Message-ID: <CAKwvOdkFOCTE5tTjrhPrfTWDwogvJ59LXZDnQ4wruHE93_6qMg@mail.gmail.com>
Subject: Re: [PATCH 9/9] selinux: drop unused macro
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 6:15 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The macro _DEBUG_HASHES is nowhere used. The configuration DEBUG_HASHES
> enables debugging of the SELinux hash tables, but the with an underscore
> prefixed macro definition has no direct impact or any documentation.
>
> Reported by clang [-Wunused-macros]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  security/selinux/ss/policydb.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 67e03f6e8966..d036e1238e77 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -41,8 +41,6 @@
>  #include "mls.h"
>  #include "services.h"
>
> -#define _DEBUG_HASHES
> -
>  #ifdef DEBUG_HASHES
>  static const char *symtab_name[SYM_NUM] =3D {
>         "common prefixes",
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
