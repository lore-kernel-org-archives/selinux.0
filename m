Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B59C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A243C206A4
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+5UKncP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgFHPTD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbgFHPTC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 11:19:02 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34184C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 08:19:02 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 25so14694449oiy.13
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkWsJEdh/AOE/DIngN0RGGPpbLebEGFD5DHIL1RYIKU=;
        b=N+5UKncPjxiPK/0Eu6roYnUd9o2eQ63OUn+K7cCwaEdkfMh3CLuzLjcMPnyzqbMRxq
         qzhsDrhNF8umREuFhqusCjwHH4sff5Eox9jE8cunm7oQ88YdNmleDfVwyaeniKq2vrKn
         JBn/3ZPoeOC+eHWhwGWdAqzZn3HuKNyjOI2zghDKsg3dL8ns6OyzSL6r9llawYHn59Tj
         ctlmA9ToT060kLiBlIM7QaHaL4WPn4CMqpfVXziysc542nScg6UVFg+ieijPmenBr+39
         bAzlCw8ZxLvA1UAu7UH7t+2o5VJcFhI42YBVch5QyLs4ioDIID7T0XeKKZ4G9mtrMMst
         aQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkWsJEdh/AOE/DIngN0RGGPpbLebEGFD5DHIL1RYIKU=;
        b=cv7YBUId+qdCaYWc3yz+m7rfXOAAhzAE/F9NhVElhpZg6zejWb1MeMZT01plMmn4Z9
         /kBlYm+A9u25fmsCLA/tLJu+Yt7Tl5vUGNGSGPnnQGnaxpFGChRbTvmSpFlyGqVHTTuc
         9lljl5ntU/ovRcbp5O5vX/OztHFcp+VC3DAnhF+nyDjqbBjysxPYGOefiEG4D53MZaN3
         SRnbUBBBJTWncQr8wA1LrIdOgox+pPz9SHVWS8+GMJdsR9DNkfg2L9vSCQmmR9WdXACF
         Ma4Hx1ccC9PCxtB9JAVFtvqSzt0Qt95HakNnytd4ZXZcj82IQctiDEs9h+6NwvBXWC3g
         Q8LQ==
X-Gm-Message-State: AOAM531011wjqEPCEzzMWmhGVHpa2WdzSK1ckk3s0KSNmKkiRG7hwl7y
        PVChc9pubXI95GQ90lYgxrBXqa2PN8UesOY06Ergx/hL
X-Google-Smtp-Source: ABdhPJw1v0pJ2tcrX2Ln6MKai3LssAHqvQgOa0Zmw61rTS2Dr8gNkHhtDevfLDcvEPdNK/rN+hZSDLMyqvZABseHRi8=
X-Received: by 2002:aca:3d09:: with SMTP id k9mr10390498oia.160.1591629541489;
 Mon, 08 Jun 2020 08:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200604191240.263819-1-jlebon@redhat.com>
In-Reply-To: <20200604191240.263819-1-jlebon@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 8 Jun 2020 11:18:50 -0400
Message-ID: <CAEjxPJ5ih8oJFxMe3K3GGyN0FO3VLnWNEv_YibSWX3a-eDbroA@mail.gmail.com>
Subject: Re: [PATCH] setfiles: clarify documented path resolution behaviour
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 4, 2020 at 3:26 PM Jonathan Lebon <jlebon@redhat.com> wrote:
>
> One thing that confused me when investigating
> https://github.com/SELinuxProject/selinux/issues/248 (i.e.
> https://github.com/coreos/fedora-coreos-tracker/issues/512) was that the
> manual page for `setfiles` seemed to imply that paths were fully
> resolved. This was consistent with the issues above where `setfiles` was
> failing because the target of the symbolic link didn't exist.
>
> But in fact, the wording around symbolic links in
> `setfiles`/`restorecon` refers actually to whether the parent
> directories are canonicalized via `realpath(3)` before labeling.
>
> Clarify the man pages to explain this.

Missing Signed-off-by line.  Otherwise I guess it is an improvement
although I think it is still somewhat unclear.
Maybe we should explicitly say that they are canonicalized via
realpath(3) in the man page.

> ---
>  policycoreutils/setfiles/restorecon.8 | 4 ++--
>  policycoreutils/setfiles/setfiles.8   | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
> index bbfc83fe..06ec5a1d 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -159,8 +159,8 @@ The pathname for the file(s) to be relabeled.
>  .SH "NOTES"
>  .IP "1." 4
>  .B restorecon
> -does not follow symbolic links and by default it does not
> -operate recursively on directories.
> +by default does not operate recursively on directories. Parent directories
> +are fully resolved before labeling.
>  .IP "2." 4
>  If the
>  .I pathname
> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
> index 0188a75a..12f41967 100644
> --- a/policycoreutils/setfiles/setfiles.8
> +++ b/policycoreutils/setfiles/setfiles.8
> @@ -214,7 +214,8 @@ option is used.
>  .SH "NOTES"
>  .IP "1." 4
>  .B setfiles
> -follows symbolic links and operates recursively on directories.
> +operates recursively on directories. Parent directories are not fully
> +resolved before labeling.
>  .IP "2." 4
>  If the
>  .I pathname
> --
> 2.26.2
>
