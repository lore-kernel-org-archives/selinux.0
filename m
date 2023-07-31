Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D0DC001DC
	for <selinux@archiver.kernel.org>; Mon, 31 Jul 2023 16:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjGaQUA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jul 2023 12:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGaQT7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jul 2023 12:19:59 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7F310CE
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 09:19:58 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5861116fd74so12380017b3.0
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690820397; x=1691425197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9fIe3Gxr31rzfyQVVD7YCJB9l8UN0uvGypaHt5FeEY=;
        b=FnW4bR5a+Ko5OqBY2aeUz7Zvu6Fr/icuzLfbuXEEvtqjYBd/Qc1ocJu7nVZ6e4E5k1
         Wx4dYd/oJJJzt+gMxM2qXJTSrv7dGC5u4o1Lh7vtzUhPaUe2uWCP2WlrhJAx10yCSCNg
         Dy2vRis1rdc0ZZUzdgGTRjt1cKuNyLlYwPSPeKZzC7aDanr27bgnIq3SdXDs16CjyDJR
         cFExnS/Vs9MoMdEtrhUCdgO2FyFUjA3ws4JHQ2Rxr0wgXX4qX78xaY1PEedFVXXGeQQL
         mmMsuGc8whHCS65+vHwFI6tErOuaIOjcPshAOb7kioZJedQ3CdOD3UG9OKDkFrilCGHY
         KSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820397; x=1691425197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9fIe3Gxr31rzfyQVVD7YCJB9l8UN0uvGypaHt5FeEY=;
        b=hcbQ1oejEOU10uRXZDajjUIQK4zJGi0XBfEFx+TqPz7hZDu9anrwMHoTNrXTAT/Nkv
         91lkpYNRuKDX8Oo6zzUA3d9QKuDzXBTPqNkqUpLJxMNwUJ0xR2ofFMl4UgipoEpaDDyg
         ucQ00HfD/JOkI9XuTUr6sEh0YYVOn/xWVVKzdb7U+HLpmn4Wsi3gohragtWtwbL2SCFv
         M0/cQFIB2sm9qKYjDnwWQP/ThTZNY9ZeGRgolQ3aUifo23cbzNffXkdag+Oiuw08nwm3
         /ww2q6mu/7KgpC6LJ5vD9wHFIiOc97/3fmt/t0sg78bi10Q9K2I5fepP8d9F6VtSZ40q
         9BFA==
X-Gm-Message-State: ABy/qLa4Ts5OG+Nrsmpa2dQpk338TygJ8dvKl7/+ufTt1o3DpRIwW/K0
        5PBs5xFXz9saXhHRlmORB10Hws6sGVg58bknAVyz
X-Google-Smtp-Source: APBJJlEcU7pBLcHrr8QGOVVdhQCA7H8KzdsuLly6Uwguis1KIGUbsMx9nXs4e4mXkaWiHvP5mm1UtSc4LRGwEGnZShM=
X-Received: by 2002:a81:6c52:0:b0:573:9e0a:b8bf with SMTP id
 h79-20020a816c52000000b005739e0ab8bfmr8268556ywc.9.1690820397075; Mon, 31 Jul
 2023 09:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230728050043.59880-1-wangkefeng.wang@huawei.com>
 <20230728050043.59880-4-wangkefeng.wang@huawei.com> <CAEjxPJ5ZuBGVDah0f3g0-7t2v1uSXTmp_cTT3g_MSP3J9QtoeA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5ZuBGVDah0f3g0-7t2v1uSXTmp_cTT3g_MSP3J9QtoeA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 31 Jul 2023 12:19:46 -0400
Message-ID: <CAHC9VhR_Tzbs=fE+D6VrP1boe7O_uHPu9yd7kfVppnB2vtPLOA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and vma_is_initial_heap()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 31, 2023 at 10:26=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> I believe this patch yields a semantic change in the SELinux execheap
> permission check. That said, I think the change is for the better.

Agreed.  I'm also in favor of using a helper which is maintained by
the VM folks over open coded logic in the SELinux code.

--=20
paul-moore.com
