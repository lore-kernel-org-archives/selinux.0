Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5FAC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6EA20786
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 18:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bshXSO+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZSYw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHZSYw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 14:24:52 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9502C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 11:24:51 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t7so2322808otp.0
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rqs0PyLIVTjtDbK9gfv4Liv9XbBCviqdNljAOmAvHQ8=;
        b=bshXSO+S/qlBL+0g3HOipguWwbkclnIHFUVgtPauTwstl42bblIEj4c1gVDL3To3PR
         zrX0umzk6AajwiDtIChdRT+ML6lviyRyooW8+bMBEKtUwWv8B09wx1JqTak4hyPqCkdV
         yichYvHlDWNDN92gaMAX1u9+QFUpcn96kx4aO+2lyJaDkCNBdZFJCHkEYlCG6ERjDom/
         iEDAaZ3rIhLTV2P804NcFHnA5yjM0kHPqt8jlZcWyO9GH3bzVV+Y8aoRZvds4mV2QaqW
         eK3XZwTK2tAJNkjcW2/byZG+cVFiewLE199jfQrhUBoHR0GtVUizIydsLDNUIRhlldvS
         D/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rqs0PyLIVTjtDbK9gfv4Liv9XbBCviqdNljAOmAvHQ8=;
        b=B/OLs/2p0iiL8gl3RX1KvkvrdRMYLvC200dzZbq86OS6jq2hnqKzFfc+6S/507qWJx
         j+Tg915vX0j+C6OZb7VMkAs9C3n357Pfqc4Wy9XXk5tJ5f/2sG14ku4tX5EuXD+Bqq7Y
         5ssjvOSaZTFYehZyZOsiENL/rH0Y3zHtfiEZAifDyTzzHXThrtaoKyqCOt5BipHyqnCF
         YJ0Qext8vMORnm/Aj+gS325Lk6+moPhqemXE+W9H82fPtOIzbJaN0JFG/QcoKcUKvewy
         /lsJlaCL0JM2qqXikfNTOoyfNp+r9Bp7mAghAIkyXniXeFzS5ZPI2SWINtrb/HNxtRyY
         8viQ==
X-Gm-Message-State: AOAM532a6XyiAJfpUUbqG1YBnI0Gl00Bfi7pg9s9B62NAd9CIw27KvAs
        X7LXItZtsGKYwWwijcHJVgYdpgVCSl7IQ4BFbek=
X-Google-Smtp-Source: ABdhPJy8lqyCIZ222cEUpoqm6KA1nTgSnYDlY2ZLrrp+5djxJzUC41SOc10iEpnVOyETJeKaT15A3PqXdT1AImBSspA=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr10275598otr.89.1598466291256;
 Wed, 26 Aug 2020 11:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200820151551.18235-1-cgzones@googlemail.com> <CAEjxPJ4E6SghcazvGhCsLWRTgtFGcVZynVogTv1zDVQmcg4aTg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4E6SghcazvGhCsLWRTgtFGcVZynVogTv1zDVQmcg4aTg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 14:24:40 -0400
Message-ID: <CAEjxPJ7z0Nvw_jRbAPpWAppSyQbPVbG6Ks8oaQxF1gtMM0-7wg@mail.gmail.com>
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

On Mon, Aug 24, 2020 at 9:38 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 20, 2020 at 11:17 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The argument for security_check_context(_raw) is defined as `const char=
 *`.
> >
> > Say so in the man page.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
