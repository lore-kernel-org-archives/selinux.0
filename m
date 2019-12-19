Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58580C43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 18:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295C2227BF
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 18:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="H9BittSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLSSMG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:12:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43449 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfLSSMG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 13:12:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so7240577ljm.10
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2019 10:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPnABL4TYvKVdvQn07ZfQTm4mjo2e0dNh3ePBxHpwdk=;
        b=H9BittSMWZIG/chPkfrJgpXJe+MzIPMQ7+z8wvMvRZGrMeyEQ/eCd3UyjZDpv/lLiP
         AhdyT0V7Zk1NGdpeKEwRpaJ5T+KoM7kkL9zFhA3TVDheKSxYAZlnxd+L9hyWZpgcBqlA
         P/QpnLz1Mgrz8/fCvoh9YvSEdyfbC6Dc3YsvEcr6MWnV2FNTmORziYNvjMqnVZ3sOjGG
         8nsfkFBaZ4njhhyYiimZ4ua9eNwVRj5ZnhuDnBJ92KY17H3nIRBc1TqoWyFHffIuR/W8
         Tto1Blf/LFPz4L3jrWTacKQh6S7qvNxgDT3tKRMNsD7JWIGXLnXZ92HymB0+zOsm6ANe
         GVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPnABL4TYvKVdvQn07ZfQTm4mjo2e0dNh3ePBxHpwdk=;
        b=LRxzBKP0tYy6F3MA+pi11eM/+oJkOKM6m72kgRUpIJmlKYD7JPR3uwvcakjeUHIQgK
         eXetGJDCPlVrTjz7xlqpjU95ZJADGUO2hRWxPx0oYTeUOqCrQQ4adnbPDJcJqoO+qjqP
         s8XZDRPaeR3jVx5k/nYPL5u/a2BCmBOzszUHUuPZDvD3DXdO+toC0hAvKD3lleGCu5G2
         jnVozKZtrRDRToq6LTLQof60iEbHP+nW65YV+f0lPMqhpSEfCM6Zy/5PXV7zUCJdAdIi
         bXMkAqsriahDwEd27Z4lKaupvpYOfeAOzCyj6FOqgJu4jrdKfxdgY4/B5OMel1j4yVgT
         f4yA==
X-Gm-Message-State: APjAAAWi+MrKiWRI8EF6pOS0CmKzlf3UVAM76R0Z/IR5hOQR5RS2Qnb2
        rcw0Uqg4YK8QLKyZ17qS14hWj5si4YgF1eScJbJD
X-Google-Smtp-Source: APXvYqwjjIeHBYKn1jVnJSSywjYpRVI3y/DG7d8W8RPjikJjijGrGKoiYdQkyCMz5WKNeMAsJh5YBbwkqmkptt1KFeg=
X-Received: by 2002:a2e:3005:: with SMTP id w5mr7237498ljw.184.1576779124446;
 Thu, 19 Dec 2019 10:12:04 -0800 (PST)
MIME-Version: 1.0
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com>
 <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov> <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com>
 <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov> <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov>
 <0101016ef59a2152-41e65aac-8784-4401-b20d-45b2852872d4-000000@us-west-2.amazonses.com>
 <411fa1ea-d9b4-b89e-8cab-656db8eef259@tycho.nsa.gov> <001e01d5b4f0$495efbd0$dc1cf370$@codeaurora.org>
 <21b5511a-fdba-3c2f-e9a6-efdc890b5881@tycho.nsa.gov> <CAHC9VhQYA8uTRQ0OajEmsTrDytNVx+BSiL5vEsGefKEhAw+gKA@mail.gmail.com>
 <002701d5b651$8434b2b0$8c9e1810$@codeaurora.org>
In-Reply-To: <002701d5b651$8434b2b0$8c9e1810$@codeaurora.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 19 Dec 2019 13:11:51 -0500
Message-ID: <CAHC9VhSv9BsjqNtwdpAv1yj630L-k8UBcWA5bwC9ySevrPw34w@mail.gmail.com>
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
To:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 19, 2019 at 4:48 AM Ravi Kumar Siddojigari
<rsiddoji@codeaurora.org> wrote:
>
> Sorry , Re-adding the patch  below as requested.
>
> Stephen ,
> Issue is fixed with this  2 changes , Issue as even reproduced on v4.14 and  similar changes work there also .
>
> --
> From 77c618006397c7a65ead257f3cb4e4fe3da2d4b8 Mon Sep 17 00:00:00 2001
> From: Jaihind Yadav <jaihindyadav@codeaurora.org>
> Date: Tue, 17 Dec 2019 17:25:47 +0530
> Subject: [PATCH] selinux: ensure we cleanup the internal AVC counters on error
>  in avc_update()
>
> In AVC update we don't call avc_node_kill() when avc_xperms_populate()
> fails, resulting in the avc->avc_cache.active_nodes counter having a
> false value. In last patch this changes was missed , so correcting it.
>
> Change-Id: Ic0298162cc766c0f21be7ab232e259766654dad3
> Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
> ---
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Two things:

* As Stephen already pointed out, please don't include "Change-Id"
metadata in your commit, that means nothing to the upstream kernel.

* If the patch is really from Jaihind Yadav then they should include
their sign-off, and preferably you would include your sign-off as well
since you are the one posting the patch.  Please look at the
"Developer's Certificate of Origin" section in
Documentation/process/submitting-patches.rst.

-- 
paul moore
www.paul-moore.com
