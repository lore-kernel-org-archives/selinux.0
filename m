Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49286C77B6E
	for <selinux@archiver.kernel.org>; Thu, 13 Apr 2023 20:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDMU0k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Apr 2023 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMU0j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Apr 2023 16:26:39 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D7F4EE3
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 13:26:37 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id by8so544766ybb.9
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 13:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681417596; x=1684009596;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPNkxpVVZuTtqqIvXJvis3z3ZfNkZZKj33NwKdGcskY=;
        b=VCs7C/HInERg3ehj03odyjT2dZnEzZA4ADxFFGV5LV7rw4QymHIWdnBYvCv1tgpXD8
         0eItDpiNHXhAK8htCIydX9cigcUu4p3uAjWrcepKCVHjM8ckl3PKl79+qCljf+W9DN06
         3+KEWOkRVuTUIHTjq2aedx6RZWWlJeXPuj/ZxQlhO1ViQMJB2g0NTQRACPaZjAxpreJo
         jDxA2sCrdxxtprjBALw/sGcFSrfj1lAEBfIvpRyiK6XXU8QMPlu2B8ct5Ps9JBVEIM4a
         2ZnVWlBBvKRVdf4cv0m8Ld6uF6Q1xBq8gJQPoU5oaeMATxEEhfePDTHDwrdolWDXIH7m
         EGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681417596; x=1684009596;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPNkxpVVZuTtqqIvXJvis3z3ZfNkZZKj33NwKdGcskY=;
        b=Ul7CGt3qzEjuFoUlgdIoU/7UiEKORglwgt7dqaKiJv/9RQju9+dxZnlIE+ckQ/1BbV
         NN0mCMp2xzmjWPtipnispfsnp+v1DzzIsFIwkBpUBXVNG0dz1L6CwlklK4wcCPbReOYl
         XWMrZyewhUQFBp3o+l2D7GeHF5dHt+dlh/U2URGxhriS7g9D1g8si+LVvd60dxQU7F8A
         kVFarQF1GOsvGgDmgUvMyg8aPq7ZbD+K7ap9n3uyfTxAJtCwhKP7+V5fz/q8sXQPrpo4
         ITt0+zR/SubfUpxIT16+nZkVH5PI1MBdU2uHMlM0U/+GkS8x9+DTCmbIAm+tTytBJl0a
         enkw==
X-Gm-Message-State: AAQBX9dQ1CGMkpjT6sX4tZ+Kdx5mLipOkpusvJtaTn3mAhantGyQdku3
        QvBWMMk0vvFXFnKOcs6KBSEtMkb02P5aTno6cXn2rjJDYqS2RjA=
X-Google-Smtp-Source: AKy350byVFiuSgOsHl9HwglEQ6eEeX5JtNuptRgOV2ctxf3Q78gr5GrxzNHlxZ7/pMNPEB0nuKYMSgKRfEweTWr2Kig=
X-Received: by 2002:a25:ca83:0:b0:b8f:6944:afeb with SMTP id
 a125-20020a25ca83000000b00b8f6944afebmr636146ybg.3.1681417595934; Thu, 13 Apr
 2023 13:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230412234942.533478-1-paul@paul-moore.com>
In-Reply-To: <20230412234942.533478-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Apr 2023 16:26:25 -0400
Message-ID: <CAHC9VhTENc8xqk-fvRMRpuj=LeuMLAoRn5HpoAkk_M=uWW5SDg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: ensure av_permissions.h is built when needed
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 12, 2023 at 7:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The Makefile rule responsible for building flask.h and
> av_permissions.h only lists flask.h as a target which means that
> av_permissions.h is only generated when flask.h needs to be
> generated.  This patch fixes this by adding av_permissions.h as a
> target to the rule.
>
> Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel build=
")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> --
> v2:
> - typo fix in the description
> - use grouped target
> v1:
> - initial release
> ---
>  security/selinux/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next.

--=20
paul-moore.com
