Return-Path: <SRS0=WW+a=AZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BA1C433DF
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 21:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BA92064C
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 21:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u32+1aZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgGNVDY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgGNVDX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jul 2020 17:03:23 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8845C061755
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 14:03:23 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l63so52929oih.13
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J85YlphS0gkyerLPbSXOxtVSsKJZlDG5oWKsSUgk7W0=;
        b=u32+1aZpMu9yv7GuRjI4B6g4D3bgmVDtLuktVrEuBtXkM5I0QwRxm6c6VicupT7RUb
         GlEsErkSd4q/PUIINFBS8rXtXeJI4TTPugImG3hHwXmL9EGxH1n3M7aOYRqhXbckk+5t
         QJjyKUAA+K6W/juNpffsFUfDWxOujHI7jLJWCpU1MLHOVCk6b3EGMDvbcvgOQOttFDlt
         eyeoznlrxTOLvNF2f8VEOUDfFMjabyqDZO+VvOGpA3DZOD1d6PItF+V+qKIeXVYN2C2G
         Alq7oX8bYTMGYh/R4XXtNeOCfgEzTF7mt0PEF/cvtGxC9n5cBOKC9rD2RSnI10Wuo2xM
         nv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J85YlphS0gkyerLPbSXOxtVSsKJZlDG5oWKsSUgk7W0=;
        b=r7eEA+xBJ6Ui+S2lntVnrMC+NwvqrqztCWhPSvW8ofsuGPkhy79aeVRd3nN4AIvr2Q
         PBs9tMqdNhV5vC2Kkfd8ujzsONoywPaBedahTs6lSLtJ/uTnYQJrHOkQ8wltDPGBta2i
         P8PP6yXYB+rh0yL1vpCv5mUNfzVlV/1TTSSSiMcSr9zrZJmejwuDEEU2CSgV0R8GBjjo
         U/IyV/J7rfDIod2vFbFUQO3JSnYafkNG0+kFP8TSG52yu6fkwsoqp8+qIisaExpzo2kX
         /IWCV0eIdKIHWRtEN7udspSO9AScJuYR3Zsnl9kIy0DEQPemOqhATMsz87587wzItfv/
         gP2w==
X-Gm-Message-State: AOAM532gpc8+noISmTtYY5NwOUvz3hCPOvJPdZy33xz0z3q/+dxOj97x
        bvgfQ3pXZgyX45PNf12ic8s6RUJq19+qCXjcZzH7CA==
X-Google-Smtp-Source: ABdhPJyKaAcuRXch6a9LcpFKZUnPXhgcFoM7/xaGDhQ6pAx9od+1jEp/X43pv5jmLkqPx7x9YR24fawpnLGyuAhxIoQ=
X-Received: by 2002:aca:ecc7:: with SMTP id k190mr5118368oih.92.1594760603116;
 Tue, 14 Jul 2020 14:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
In-Reply-To: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 14 Jul 2020 17:03:12 -0400
Message-ID: <CAEjxPJ5m31kcXH66viy3R-ncbBJCET8Wm3+DjphDeZ0iV3giEA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use sestatus if open
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 14, 2020 at 4:35 PM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> /selinux/status") introduced the selinux_status page mechanism, which
> allows for mmap()'ing of selinux status state as a replacement for
> avc_netlink.
>
> The mechanism was initially intended for use by userspace object
> managers which were calculating access decisions in-tree and did not
> rely on the libselinux AVC implementation. In order to properly make use
> of sestatus within avc_has_perm, the status mechanism needs to properly
> set avc internals during status events; else, avc_enforcing is never
> updated upon sestatus changes.
>
> This commit moves the netlink notice logic out into convenience
> functions, which are then called by the sestatus code. Since sestatus
> uses netlink as a fallback, we can change the avc_netlink_check_nb()
> call in avc_has_perm_noaudit to check the status page if it is
> available. If it is not, we fall back to

Missing word/phrase here.  Also you need to do more than just replace
this one call or selinux_status_updated() will do nothing unless the
application has explicitly done a selinux_status_open() itself, e.g.
avc_netlink_open -> selinux_status_open, avc_netlink_close ->
selinux_status_close, deal with other avc_netlink_* calls including
the multi-threaded case.  Finally, I don't think you need to sanitize
the enforcing value from the kernel; it takes care of that itself
these days and no point in fixing it up for old kernels now.
