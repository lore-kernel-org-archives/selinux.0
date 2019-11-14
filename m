Return-Path: <SRS0=pcBM=ZG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A0AC432C3
	for <selinux@archiver.kernel.org>; Thu, 14 Nov 2019 23:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AF620723
	for <selinux@archiver.kernel.org>; Thu, 14 Nov 2019 23:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="drGsLk69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKNXfY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Nov 2019 18:35:24 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44923 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKNXfY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Nov 2019 18:35:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id g3so8576052ljl.11
        for <selinux@vger.kernel.org>; Thu, 14 Nov 2019 15:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYuSkJ9oPws3UUjingV1Zg7JO0uNEunaTAcySA2zhvs=;
        b=drGsLk699/Br4+VVrSrOXTe6yaXJJ6yIw1gOjgkEEw5tMhezrFL07cnw+8S3+WhMCL
         AXCwM2nPk8/ScuV17amf/yZk23nQtsNnZOteIhU2UCFx6T3dc5Q53Apt+74qlyya20VK
         qgp5gjJWACC2B0ud39nE0/t6eNMo+Dee7kp6vklXx6ih33vjUDt7J8CcUJPiuDLz04E1
         WnZeU+2IKKGB3ZuE7pL3cKt3mYGRYQkgxluwi6qP/EwtNFNJ1OLA8SsVwS+gZTWWWUD+
         fNw1zXTLZcE/n20xHfO5ucEXkPuCIzYfZl4uFxcqYT3YuYE9a/4C64Qhxcs1LNzLBvc7
         2zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYuSkJ9oPws3UUjingV1Zg7JO0uNEunaTAcySA2zhvs=;
        b=L9b6kJ55rDHbbWa3hrzbSkk4d5ud1nWU46gOkGMcs/VAltXMJ+C2s5aVPPqUWXMRFQ
         Lb/SwuPhkArcKYhY5xX1Anv+HjhKBb+v3MTXPatZYWeWFyg+weKM5eQ8Tzr67h6DDWIj
         NDhx5t9IaRwms9DJT+oNK7GE+Lhre2xG52LUSz+360yvwfUPE9wRjMDpQfde6T/iVaLA
         trKuX9+cqad7nRMb1zixvq0/szYHyPkQNYTywr78Dnyn7PnN5F5rJclnB0G/BNiCRbVu
         MJTiUiWJup9Qz0CESXRPss/h3ppq6kdPX+R59QA3cV8ywH5gZqIWTLyK6D58eyPglMYi
         y+ig==
X-Gm-Message-State: APjAAAXYUKgXomXN4+wY4STT3ycGOh30uPEN3x4nzaDtxMg0fuAjSY/d
        K0yKFChXd4kjuViuDIJHfrVemuDfO01I7+e+SXBF
X-Google-Smtp-Source: APXvYqyn6QWpb+fW0JLGaGp9fW1p4xYgqa5dnCSGCbLPQ1YEWLQW9O0YnLvgM9qDLp293eUqpSx2rwp1R82kBt+VlyQ=
X-Received: by 2002:a2e:300d:: with SMTP id w13mr9024068ljw.117.1573774522150;
 Thu, 14 Nov 2019 15:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20191107101743.203699-1-jeffv@google.com> <CABXk95A1aKrcSLmHxyoH+mdXoZTc83BRV8SOOwQbrnCw4gfAwg@mail.gmail.com>
In-Reply-To: <CABXk95A1aKrcSLmHxyoH+mdXoZTc83BRV8SOOwQbrnCw4gfAwg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Nov 2019 18:35:11 -0500
Message-ID: <CAHC9VhQEZPt4pOGTS9mcQaUVpzz_S8Vcv9ScUVmSY+v9jznxuA@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: sidtab: reverse lookup hash table
To:     Jeffrey Vander Stoep <jeffv@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, will@kernel.org,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 7, 2019 at 7:01 AM Jeffrey Vander Stoep <jeffv@google.com> wrote:
> Note this should be v4, not v5.
>
> Paul, please let me know if you'd prefer my change applied on top of Ondrej's
>  "selinux: cache the SID -> context string translation" patch.

Sorry for the delay, travel had me a bit backlogged.  Regardless,
don't worry about rebasing on other in-flight patches; unless it gets
*really* messy I'll take care of that when I merge everything.

-- 
paul moore
www.paul-moore.com
