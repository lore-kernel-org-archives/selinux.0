Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D58C433EC
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 16:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F35920792
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 16:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EGbMneF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgGUQnL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730793AbgGUQnK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 12:43:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2A5C061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 09:43:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w6so22297626ejq.6
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeZ2aKEOTY3blD42rviIY/Dk10ap5XmxVKtORSGMQrY=;
        b=EGbMneF17lNnI61ybfgiIc2lyC7LZAPj2J8YRaiUPEXfWTo8+uU79DSVeFeac63gI3
         QIVL6zPMK91LbmPKaJjqRc0r9evPqSJMHOeeGxJWon0MoZxwdVZUlTMDdWU6N9RZWC8b
         n+MudT7/pTfwFUIUDP21q2yXrZpCfl5bZ8xUESRiNiFI6UN0GscMHoTRNvyBH2u1/H2G
         TapRNCVxbwhFGNZJdfJCj9r/uJINimSgSOSCqZDf1sftdjeI6RHfultFo4MUc6oMsmRS
         BFUIRY7dxS/zLxnZXkCfI18WuQrmpV9cfoXSoZvTC3OOe6ZntES17+P7tf8eJWQ2nOvl
         hgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeZ2aKEOTY3blD42rviIY/Dk10ap5XmxVKtORSGMQrY=;
        b=WovPUpPdnGbxjcKKPyt7ifQ1OfvOEpwrBFfdglKpL0FPUgkSS5fr4KskZPYwAtocSw
         irweDFvap2uAvrEqfGcNaKP4PtZg2eQny/VTm3nRhWSY12t88vEtgMcXeau+rO/rR+Ia
         dsCcvQJQaJPfVV5BIbwre+J2o3j/5uqabAyHwgMeKNsl+nucAfsl1mE4EJu7vGaFXjZw
         9jfE/BCBLBNgRzdtTXoqwXSfWRLJSxVf7U/1BmdsmCDn1iEIoqLlIHTLW6PHwVt8TFE6
         fQ3P6g9jqp1gv++MzstoexqtVigw3yN+vD5+IVW5RmXwfoW4blUl77BlwOsmhdrdydrn
         S+TA==
X-Gm-Message-State: AOAM533H4XUOnGwrGtX69+02m9IW9ScgDPy1OHOykQ/4HhhnRGWG3BRe
        IQs9ZgyJ6U65rtqYGiW/bE/tn6XV+OATWx5lRKQ4m1c=
X-Google-Smtp-Source: ABdhPJw3wHOIWjXHAVOb92MgzomW8Iw4/ONje4bKTI9P8Lov9JaMZIEnKZynubfGIRS8uY/7kL5KSgoLDoFj3/N3+No=
X-Received: by 2002:a17:906:456:: with SMTP id e22mr25649085eja.178.1595349788374;
 Tue, 21 Jul 2020 09:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200718104842.1333101-1-dominick.grift@defensec.nl> <20200719181704.1583398-1-dominick.grift@defensec.nl>
In-Reply-To: <20200719181704.1583398-1-dominick.grift@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Jul 2020 12:42:57 -0400
Message-ID: <CAHC9VhTS0hr+i3GvMJPhs3WQd48fOdz3xbZBUSJDJD=XAfNQvQ@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v5] adds CIL policy with makefile
To:     Dominick Grift <dominick.grift@defensec.nl>,
        James Carter <jwcart2@gmail.com>,
        richard_c_haines@btinternet.com
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 19, 2020 at 2:17 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> This example CIL policy takes a different approach:
>
> 1. Leverages CIL
> 2. Installs using semodule to make it tunable at runtime (but you can obviously also use secilc to build a monolithic version and deploy that)
> 3. Makes few assumptions about variables
> 4. Leverages handleunknown allow and declares least required access vectors so that you can pick and choose which access vectors you want to use and ignore the remainder
> 5. Leverages unlabeled and file ISID and makes no assumptions about any volatile filesystems you may or may not use
> 6. As small and simple as reasonably possible, heavily documented
> 7. Modern, Requires SELinux 3.1
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
> v2: rename XWAYLAND.md to XSERVER_XWAYLAND.md and cover both Xserver as well as Xwayland
> V3: fix typo in XSERVER_XWAYLAND.md and exclude x_contexts altogether
> v4: remove XSERVER_XWAYLAND and add the note to README.md, redo README.md and clean up cil-policy.cil
> v5: add -F to fixfiles onboot (onboot should probably just imply -F)
>
>  src/cil_overview.md                           |  11 +
>  src/notebook-examples/README.md               |   2 +
>  src/notebook-examples/cil-policy/Makefile     |  31 ++
>  src/notebook-examples/cil-policy/README.md    |  90 ++++
>  .../cil-policy/cil-policy.cil                 | 448 ++++++++++++++++++
>  5 files changed, 582 insertions(+)
>  create mode 100644 src/notebook-examples/cil-policy/Makefile
>  create mode 100644 src/notebook-examples/cil-policy/README.md
>  create mode 100644 src/notebook-examples/cil-policy/cil-policy.cil

James, Richard, you both had comments on previous drafts, does v3 look
good to you guys?

--
paul moore
www.paul-moore.com
