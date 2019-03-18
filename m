Return-Path: <SRS0=cHrg=RV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCF1C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 23:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E102171F
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 23:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="yp64phMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfCRXAH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:00:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40750 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCRXAH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Mar 2019 19:00:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id u68so12955305lff.7
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8VlcdzkPP9rEjYJUrCvcc+8S2RS2ZCPdchVlGZyIoM=;
        b=yp64phMbso1C4LUyfbEJXP5hjcsRxs7TjL6R3sA8DLSLIhkgVDGC4MVGQ+nCfLLeNg
         bITHUNNfILrq4ggA9fh8j/WcElpUwzWYCnqBD8zeOjPjqZjjjfDfynFlN/ouTZya3qs6
         dAw6H1Ch46E5NOhCipj4NRtr5AThfamoD69D2mDmDZIK2eVuapaUZnnEqfjKRKt84RcP
         W1s3DkolLsUvK55OKQBV4xtwnBBUzZ8WpUDuzMoNFZk/4vPkK2QKqH9JskBm6D/mx3d1
         ZN9jcFV6rY6/tYybATbdYSL8axqdSp1usUnqc1qbGR3ynIQOSzQ5sqsyBuwg0zJmUnmS
         33Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8VlcdzkPP9rEjYJUrCvcc+8S2RS2ZCPdchVlGZyIoM=;
        b=AELtbFbSvjOGfs8Iv/l/KgD6mYVqe0RLsTfI3UOfwdb92Vi56lArwcjw9a4RVOkuOL
         iEfjF/S5T3zxN86T+15+TFWwqTUtMznici519etPms5Kywi2e1aBcxnCLGj3nOSmLTur
         iGaV/sVhQqw2X9ciXPo2jqTnKdkL9326xt5dWZY+7xEhRRQnkGbc5pVPvmW/XfS89N1c
         kpEAUggqggRS+Bq2Iozw5m+POI8mdqN0wwHcAIMvFAf8vtDDCCmLwXNtEmW+EvRryw68
         kk7Ii/agl7jVs84apTjLCqIsND1VNjdA1RqwlbWsxxwaQOcoYycQAKSkls+4zAkBRT3e
         iqAQ==
X-Gm-Message-State: APjAAAWnTfmd59JbXS6Lk7J+Q03dnpVkI1ao5w13mDBJ3P1KKFaNS1Fr
        aEvRoKh0PBkvyMigwsKmAfwbVMqyEc1wUMwl9e5CJ7E=
X-Google-Smtp-Source: APXvYqzF0ujR+OEZSGvdi19lQNxVI/oKFDJ/ET6fnVU5GRaIa4vPMjaK7tLnBSMen/tSJm0PLWzE2SS4VMOLc7zp6+Y=
X-Received: by 2002:a19:ee11:: with SMTP id g17mr2483718lfb.117.1552950002818;
 Mon, 18 Mar 2019 16:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190312194758.6f411a8b@t440s.fritz.box> <30b42bae-2aef-071f-6d59-fda40d2e4ff2@tycho.nsa.gov>
In-Reply-To: <30b42bae-2aef-071f-6d59-fda40d2e4ff2@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 18 Mar 2019 18:59:51 -0400
Message-ID: <CAHC9VhQrcrVoJKmjD1yde6zkUkYifU_ALFhhCfoDyG-QhvM6rg@mail.gmail.com>
Subject: Re: [PATCH] selinux: use kernel definition of PF_MAX in scripts
To:     Johannes Brechtmann <johannes@jnbr.me>
Cc:     Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 12, 2019 at 4:21 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 3/12/19 2:47 PM, Johannes Brechtmann wrote:
> >  From 1892b9ff8045bac6fe166802b2d8a8a3111c1e0c Mon Sep 17 00:00:00 2001
> > From: Johannes Brechtmann <johannes@jnbr.me>
> > Date: Tue, 12 Mar 2019 17:50:12 +0100
> > Subject: [PATCH] selinux: use kernel definition of PF_MAX in scripts
> >
> > Building selinux scripts of old releases on a current host fails with:
> >
> >      In file included from scripts/selinux/genheaders/genheaders.c:19:
> >      ./security/selinux/include/classmap.h:245:2: error: #error New
> >      address family defined, please update secclass_map.
> >
> > Fix the issue by including linux/socket.h from kernel instead of
> > sys/socket.h from host.
> >
> > Signed-off-by: Johannes Brechtmann <johannes@jnbr.me>
>
> Thanks, but already covered by
> https://lore.kernel.org/selinux/20190225005528.28371-1-paulo@paulo.ac/

... and as of right now, the fix has been merged into selinux/next.

-- 
paul moore
www.paul-moore.com
