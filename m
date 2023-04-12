Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9462C77B6E
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 15:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjDLP1O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDLP1N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 11:27:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D3E2109
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 08:27:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g3so13126060pja.2
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681313229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05AAsukunEnGm6+/LRevMylzTQS1vcZs/QiQ11E87GE=;
        b=VShk8PKnWbz7jce50is00WZ5PETmx24nji+aKfNynISCR3MWIa8+wZINA0gpxI7WC/
         O5jmALEj9Tts7McTFLZMzwTrstfutyS8f74zYOdheunIO/1D5XmhoyB8BKB2UuKYzPRG
         QVZ5j25J4Q6ZapEQCeYmGgcow6k4r9Eebn2RlRShDCsXREggtNPj3/X2kQmuSlT/Vt5+
         aJ/RWWm+xVJLDqRUBGMVTei8Me48HeTOi4QXvkHmHyC2aR37derx9Y9n+C/3aM4Z2vdn
         4CfSDAnXqQ8IAoaMkcnlHX4tpkSkDpplzIJfRCCHn3mFffbzk8sFjJkEvRtN2UW70nHr
         tH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681313229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05AAsukunEnGm6+/LRevMylzTQS1vcZs/QiQ11E87GE=;
        b=wxdiNUyTVTv5Sf+cT4yGk4PWUZX3TBtcpVfDb+ozG8rrW+TwkIZWxn3HnQTXs++Z6L
         ClFjVQl8X9A+mVwwDthsOkJrsNHtN4nOOHKY6t2VnCgzitnQViNybwUKgQNLDEm/H6Ki
         mGyfAeaN/avNTmJ1SKGbfCN8aVvoqxeWznE84gHr0pk1Hpj2TGWQprJ8vTr8nOgXq2UO
         H9HybkFUdPeE4lXThZ3gE5aCoWj+84f8JEVp0rPTtg/gMhSRpM/IuPR5fws0j6c1EL8m
         UWhUMOdnTB1KajVNyTxQG57FN2eKitISCKY8H8kY5ZlTlMP1z/swjRQdNEdLXXqMHQvT
         IVDg==
X-Gm-Message-State: AAQBX9eLUMl2QGobuGb/5vBok1IDZhnTNQAqeAuMoKIhRRc8SdJQpVsy
        ApPri3r1rn9Veob+w70aKt3d5/TDroYnq09GedE=
X-Google-Smtp-Source: AKy350YK0zn5LPN0bqnZfqG9rtOBICNlvZjN+55vrCly1X/VfcJ4kZ9Gk+sx1lPrwphBxLRTPI1HC5engiGwPYNr5J4=
X-Received: by 2002:a17:90b:4c0d:b0:23f:2661:f94c with SMTP id
 na13-20020a17090b4c0d00b0023f2661f94cmr20782969pjb.47.1681313229282; Wed, 12
 Apr 2023 08:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230412135919.582613-1-omosnace@redhat.com>
In-Reply-To: <20230412135919.582613-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 12 Apr 2023 11:26:58 -0400
Message-ID: <CAEjxPJ4upcQUc5ZZ-KDP=HR9EJauMXcRGFw_UPLQCTHa8b57UA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix Makefile dependencies of flask.h
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 12, 2023 at 9:59=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Make the flask.h target depend on the genheaders binary instead of
> classmap.h to ensure that it is rebuilt if any of the dependencies of
> genheaders are changed.
>
> Notably this fixes flask.h not being rebuilt when
> initial_sid_to_string.h is modified.
>
> Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel build=
")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index 7761624448826..103c2776478a7 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -23,8 +23,8 @@ ccflags-y :=3D -I$(srctree)/security/selinux -I$(srctre=
e)/security/selinux/include
>  $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
>
>  quiet_cmd_flask =3D GEN     $(obj)/flask.h $(obj)/av_permissions.h
> -      cmd_flask =3D scripts/selinux/genheaders/genheaders $(obj)/flask.h=
 $(obj)/av_permissions.h
> +      cmd_flask =3D $< $(obj)/flask.h $(obj)/av_permissions.h
>
>  targets +=3D flask.h av_permissions.h
> -$(obj)/flask.h: $(src)/include/classmap.h FORCE
> +$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
>         $(call if_changed,flask)
> --
> 2.39.2
>
