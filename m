Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F20C43461
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7651220658
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy4E0ySl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgIHTzD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbgIHPhg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 11:37:36 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA94C061261
        for <selinux@vger.kernel.org>; Tue,  8 Sep 2020 06:18:44 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 11so8047990oiq.6
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2020 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdf+nMhSqXKqcLivQSRcpLsRlo/em7+qVh/LlbCD8jo=;
        b=gy4E0ySl0U32A/yxLOt2qNNKb4pL1+hO9bDvkSP25iwuRsbACL951QIH17RygZ0Nhe
         9XYQJhMlHbry4Vys/OB3wT0DqASFGyOgxR40l7PFFSHWrsqc7JMRb4EigVt62eFdrsqH
         sZzbfizEuOPEP8EU1zRpYgyqG4Hd31lrkvW0PTNX48QobzdNPpsEZmCQbEnaz1s+nwWG
         YV02M5IVR7c+yRiIQ792v1u6q4bU2klYASxxRGfwAA+4x7X66XjV1WrN4GwFEb5PiVFW
         0cJhTZ9GAIcHCwJmqR097ZE34mxIpYJTBQh2I42XoSBQF2brOaM4MsZDBkSDBBxRc847
         lZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdf+nMhSqXKqcLivQSRcpLsRlo/em7+qVh/LlbCD8jo=;
        b=pr8FLhDwRZC9EqjTJosGeJFXWkULE7c2utgF4QPHa24I/GyfeBjulJq5bwBvaiXVJx
         t8p4R6VCUzAKTemXIyq7L51kDhbs8LIfqGkJhu47PZZHud6ih3Rhgx75f44KR2i0+74H
         wVwyjaV5t0ryanMw+MuJmbjRrfeCUhj3EN2DACyOPnVm0RqU4WNUd9tPiv1vMMCySrfX
         5NoaGjhJXTlMRWpMmbUtXXgqTAsvB/1aEsks2REtVoDTcDR27TEFXSh8HtNd9fKEVc0J
         GiO/Z/z4FjjWYVi67wuVQn+3nVzz/vCw6PSlGGRWttwFUi9rfYqMaDilpWlC2o2/PR3Y
         od+w==
X-Gm-Message-State: AOAM533TSO6u5NDuHcMH0QdiCSEmZShOWk21IhhnhOhcF1CYgEtXGCbm
        zgbP2Tl7vO9ElBmH3id4KRGrfOpMfwiI9aMUnnQUzdSh
X-Google-Smtp-Source: ABdhPJxvYE3ytjuKzwJthWwvyCuSSDD/bwlY2o3qI1GNy9qeKfjxII35Ed/h3SC7lwb7IXHklTxlcmek+bYGyDuIheY=
X-Received: by 2002:aca:4007:: with SMTP id n7mr2526397oia.160.1599571124342;
 Tue, 08 Sep 2020 06:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ73HtLW_AgRBSEUmNVer4xpotkCq1i7r=YJOF1LbixKuQ@mail.gmail.com>
 <20200901161641.431740-1-dominick.grift@defensec.nl> <CAEjxPJ4z6EbdP8nsSdUBKVKJkhmsOHN7U86bpne+0Hy0v=M_ow@mail.gmail.com>
In-Reply-To: <CAEjxPJ4z6EbdP8nsSdUBKVKJkhmsOHN7U86bpne+0Hy0v=M_ow@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 8 Sep 2020 09:18:33 -0400
Message-ID: <CAEjxPJ65xnnnrThBmZusOrVd65=yTFdavRWXZnkEiTgVyuui=Q@mail.gmail.com>
Subject: Re: [PATCH] newrole: support cross-compilation with PAM and audit
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 3, 2020 at 10:22 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 1, 2020 at 12:17 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > Compilation of newrole with PAM and audit support currently requires that you have the respective headers installed on the host. Instead make the header location customizable to accomodate cross-compilation.
> >
> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
