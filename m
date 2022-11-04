Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E2C433FE
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 18:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiKDSix (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 14:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKDSiw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 14:38:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B6101EF
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 11:38:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o12so8524619lfq.9
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 11:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=015tx0joRryUDRXarwOX/xwKpy9GDXgVst1S4pqz7qA=;
        b=UEj7pEJd9ZO1xaXis29J4lDRVytoNJaSlgdxGauQdt6yezt40vbNm80HwlC1FD+uH1
         sui8Ng5MODkaLotCCKCcVyZIpIJKZaoVMkj0XmqYd0bDs7pxG8d5/2lx5z5UwuQ+3GiE
         e13A+u0yHEP9KDbTaJp0eDYkvZhX62vHYV5fcthHAJ/Jn73Y9xMdCp5n7N//YkC9qfN9
         YAOyGP4cR/XL3F1xezKMJl7oqF0YK8Xs1C2irozY4jXelWoXXkKfGo/cvgbeisf3yk3Q
         ULxu596WCc5Usyvial2EgKnvodP0cgHQY/Fp2VZn/xIsKtcLIUYUWaQW5v/tbbv3bMxF
         y/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=015tx0joRryUDRXarwOX/xwKpy9GDXgVst1S4pqz7qA=;
        b=fpOD+qhdtr5ZQUbW51e51UqJyoewGPNuKHDW/tMVLJnFQoHxUChbCxg5vYjtpIc4Gh
         LnRkwLzFI+ljCoPpphbrF4zmGWkOd4xwM7O5zgeWgnsiwWoDmy9C4qAhofFweFDzbrFB
         S4gn+G4WwaNMn7qhGME7NVh/AiMob8VIwIkQWlPADP9bYalow8vkGUIMdg0Fu1f3zjNC
         3PpcQ+69Z/52Xg1QTGbFzYhMun89Q2uIb8PlyuA4PLOa2PlBbIm8HInWEw1dqfrgK1OW
         OeZVSWsBcUglmoUO8YehXa2lbMzGQcBdz/uztKClR4em0CMEyLUaGWTNI9gm/UNm3xht
         KsKQ==
X-Gm-Message-State: ACrzQf1qp/k3+rJmv8MouWZTC0uqyhXQJtjQIoywReGmDE1ZA5BkPG4W
        vgkekhf92fEFfmrvUKQena9hwbjczx2raeVOG7TjlbE7sqk=
X-Google-Smtp-Source: AMsMyM5nTsdGQcI9LYcao/nzBTHKd34b8Th/Awyz0FAPFr9AUIRmATx2CyN6QPVBE+Moy+3llpCcse4yNDASMkx54Wc=
X-Received: by 2002:a19:7704:0:b0:4a4:5d9d:2f66 with SMTP id
 s4-20020a197704000000b004a45d9d2f66mr15428023lfc.515.1667587120262; Fri, 04
 Nov 2022 11:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221013132312.294095-1-plautrba@redhat.com>
In-Reply-To: <20221013132312.294095-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Nov 2022 14:38:28 -0400
Message-ID: <CAP+JOzR9MTP09ZNmPPhjA2+p-MYLSDOq35VVXY+D8oRBnYJQ7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] sandbox: Do not try to remove tmpdir twice if uid == 0
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 13, 2022 at 9:24 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> If the user is root, tmpdir is already wiped out.
>
> Fixes:
>     # sandbox -T /root/tmp -- id
>     uid=0(root) gid=0(root) groups=0(root) context=unconfined_u:unconfined_r:sandbox_t:s0:c696,c756
>     Failed to remove directory /tmp/.sandbox-root-KIlB59: No such file or directory
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  sandbox/seunshare.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 8917a0f9bd42..dd1d7ddbdc89 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -414,7 +414,7 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
>                 rc++;
>         }
>
> -       if (rmdir(tmpdir) == -1)
> +       if (pwd->pw_uid != 0 && rmdir(tmpdir) == -1)
>                 fprintf(stderr, _("Failed to remove directory %s: %s\n"), tmpdir, strerror(errno));
>         if ((uid_t)setfsuid(pwd->pw_uid) != 0) {
>                 fprintf(stderr, _("unable to switch back to user after clearing tmp dir\n"));
> --
> 2.37.3
>
