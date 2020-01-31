Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8CDC33CB2
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 03:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3102E205F4
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 03:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="F8K5lyCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgAaDrr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:47:47 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35535 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgAaDrr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 22:47:47 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8so6314479edv.2
        for <selinux@vger.kernel.org>; Thu, 30 Jan 2020 19:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKvW1Wql7tJSnP8CX4jqcGrBQEUab6S2/wn8TeCGhvQ=;
        b=F8K5lyCnhCtuoBbWDdNG/0PEW4RZmVDYzcQGdTedqHeytJ2IdHXBJJTWInC3Ab/4s+
         FUHtZ1/R7lz+tyRBKWTUmSMYqQQ2+TNgkI7cUBFrWvNVQEmaoU70lrBuq6sa1JuxFVc4
         u6lxwFMDTtwxogME8AK9iQIK7JWW42E1MHv80IYjaJazzx0+WkAvs01r+6IoYQIKlSet
         8DgNQRBCIzehIVxc1Voe8aEl4wEhaj2qiwp6kLpJMVFr+Zpex1z2mcAlzfMoFemdKGEV
         TmlNAqKiY6EbGTETG8stL6CEkB/LtBS86QYz2t9M0LAjedOX7NdKYZpYlkYg9jm3jgfn
         SVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKvW1Wql7tJSnP8CX4jqcGrBQEUab6S2/wn8TeCGhvQ=;
        b=UPxCcK+dV2Ek0HUoG8l5q5xogi7ctK0DGlykQL2YjbFd56UzeHcsCL/7fNiAu+KYpr
         WlMywNK0yQigYAhqnfG7TqR89u23rfoyUXtBiDumj5ExYx/tQ3zABmmBhG5l5grYPXhs
         aPzGYD7FbZ4Rb6VnxSkznzABi3kboLRfkW0DhoRloMKGM3vv5jQeouGjaWmlmsvMjKQ5
         XaeHyt+7RWt+SeGjrXHz2rGZDImMnR4bcA5xuG51wTfXJQD+sc5PIkgTVXrheugq/3hK
         BUgDCe24Ud3C2BUbLunvXnfM0d38vl5uhbI5jw0MTj4Ho4kS6A3nka/o5GEFDk7F/1vQ
         Gfng==
X-Gm-Message-State: APjAAAVNfYi6bEwYn7Sg5ln3ojAzCf/3dN9K4dPHegl2pmaII8DmddUL
        BuiLkLJMbLJHlubo75UrR16X4lmTxqr8GtKLhlhuyHiPoA==
X-Google-Smtp-Source: APXvYqxNfCfoRRotfwV9Bl4jbnwpzAwa7bwXLcAKprSSudtAcxByPuXGPIUeNhJlunJYCqPms9KRBbehwbkCdfsrWjM=
X-Received: by 2002:a17:906:9352:: with SMTP id p18mr6877231ejw.95.1580442464384;
 Thu, 30 Jan 2020 19:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20200117085836.445797-1-omosnace@redhat.com> <20200117085836.445797-2-omosnace@redhat.com>
In-Reply-To: <20200117085836.445797-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 22:47:33 -0500
Message-ID: <CAHC9VhS1Dja6TOvQ7S1-CpJXGDFChGG=y=M1xwcfMaZUM0wfWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] selinux: simplify evaluate_cond_node()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 3:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> It never fails, so it can just return void.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/conditional.c |  3 +--
>  security/selinux/ss/conditional.h |  2 +-
>  security/selinux/ss/services.c    | 14 ++++----------
>  3 files changed, 6 insertions(+), 13 deletions(-)

Thanks, I've queued this into selinux/next, you'll see if after the
merge window closes.

-- 
paul moore
www.paul-moore.com
