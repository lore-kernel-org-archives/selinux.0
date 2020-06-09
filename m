Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C49BC433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 11:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08EA2078D
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 11:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGMk793R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgFIL52 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgFIL51 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 07:57:27 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ABFC05BD1E
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 04:57:27 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b8so18491029oic.1
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2020 04:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0m2Xcohta7JH4XgL5xjexd/5I2nCMuvTOkjzOEBZdA=;
        b=GGMk793RdUxlc6YMGjGuk7Bcp6jl7bxiRKuGw6H9WyJm2gOfshriVAEleZrMaHD7GY
         g39ooA/yVH2B3x/h964SHxY+s1s0SsPneBVQ+3lOSNjVO6+VZjb2i3GkgNfW4W1LHbrn
         SsTdanXaO6Aiy0sfX1XfPmNq/4PY5OaxtIx99c85xUCSy4sPSAbhJJQ06Mb578gI+wC/
         ZWyyGlVAHSyD6/oimBwUNHiXbDqCdxWDifuBQnuuje91EKXukwIG7BxeClNvT4hXaK6Z
         aj1u232juOIJzR2eseIGVichnyg8CA/z/YGCheW0NCYKzAnDPEcS7co4ceeHpxC5bxyT
         gYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0m2Xcohta7JH4XgL5xjexd/5I2nCMuvTOkjzOEBZdA=;
        b=KLf+IBPBGb/r54nCoYmpzFlHyzsXbnS0f0c/KWt3bgTNUf2WzS05BInd7GfbmsLLpP
         0O8P9xoIEZ5sbLzC1wNCLhkWVTWTrl+292JpQ97VHPnDXiob0TCdy20dmOM1G6mxcN74
         tYD2vblKC7qZW/gDMw47+S8JPJLj6hV8tgce7/E7LHjXxuTxtatHuWAM3UZg8DPZYpLI
         9GnJMVXmcHpqtKEkLwmKXJWMxF1yL6Zc+ZOPO3yOX2TipvkKNebnQzLcbtk1bEdK22L/
         MtjbU9RimuLOT4A1JVB0DCcxbo9dhjulNEAZX7tmLcECwQKDKPeLGzi+/fsYvPR3vU8N
         lggg==
X-Gm-Message-State: AOAM530TrWv/2B17xkI8VD4bm+mnlQrqs5SIMIgh7Wwo4ezEond9M87F
        Jnfr9ACyXOiagavjPIHTkj/BjQFA7zupC+BL/Y4=
X-Google-Smtp-Source: ABdhPJzcsM6PWFIIW3vm9zvtTbPWg5lPMOeCe5u7VWOfkwpYJKY5CxWuwzCLc47dD3qep4Afq/64fhpUu31vL1NEZ+4=
X-Received: by 2002:aca:ec97:: with SMTP id k145mr2900650oih.92.1591703846848;
 Tue, 09 Jun 2020 04:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ7AtH67Gdoj6eHGJ22mXWYHWOqaRZP+Gi18aR5iJeJ5Cg@mail.gmail.com>
 <20200608223816.17039-1-william.c.roberts@intel.com>
In-Reply-To: <20200608223816.17039-1-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 9 Jun 2020 07:57:16 -0400
Message-ID: <CAEjxPJ5XBQj_1p58QZZd8Pz0G4xh-0i4Va9O4JSOrtcU9QnXSQ@mail.gmail.com>
Subject: Re: [PATCH v3] README: start a section for documenting CFLAGS
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Laurent Bigonville <bigon@debian.org>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 8, 2020 at 6:38 PM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> Start a section in the README for documenting that custom CFLAGS yields
> custom results and that your mileage may vary. The first CFLAG to
> document that you likely want to include is -fno-semantic-interposition.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
