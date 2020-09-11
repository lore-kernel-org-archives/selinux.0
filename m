Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6DC433E2
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 19:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5632075B
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 19:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gae+fZBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKTuQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgIKTuP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 15:50:15 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425A1C061573
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 12:50:15 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id n2so10603310oij.1
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5McQIRcRx1r8f4tAKpY1PHcaUmsTsH4EpUrFA7aob+A=;
        b=Gae+fZBbZOgTKymCscn5WiGCf+SslKcFcyZJFRyBo7Bp4xZvC4MhrOryeNWtj86QgD
         4vi+r8/4L3mdifLSi0xoqSkXRkFap71wxe7qAzZ381Q05Un1ys6j628+xLrmn4cv+Fot
         3QjonIyqd+MRxY+gEr8z0h9/K2zH6SbwNaS1al2Gumw0tuTCXGCo5KMbJc6z1uWxdlT9
         p6a3ipatT8OblmLr0icVZjZpYWu8XyIUlW/aFlGJhMXLsjsMPkPA19uaFgCyd0d2CtDu
         WNiONUNhd26u00d+hiaDN3BNLhRwFFiOwl859mmmU+cVv/Oc1GS1+W94v/YvoM6xzo4+
         V1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5McQIRcRx1r8f4tAKpY1PHcaUmsTsH4EpUrFA7aob+A=;
        b=kB4UTzugPa15M5/Fp4acWa6Pe1O96TkjpTuam4T/kIVzzZeCPoux8n73V9tmDhU70h
         noyMy5BiIiKVWYYB/d9ASSb5SEdKLD8DaR9yxvtJUSu+SsMWV/t4qKoCJ8+mAq1Z6QUY
         icCpDLuoPPsiq/FEsdZE+Q2/ZwHwWz0NxBApNPCJ3ZX44SvOzSueMnnIB56e2pJzm7jc
         ta9IjT5DU3m/ycBwDK+0/ecxdO7NSy1zo6oitNbsqMvD8b6bWi8+aBQnMDOwhqDuHSSs
         iFPz7DvlXqjo4ZkLCXMa8M0+8nXIO4pQ+HpOxXHijmyAjQClNoFGC4lsBCjMzj/u+5H9
         XYYw==
X-Gm-Message-State: AOAM530JpPSuA6bWFxLFQGMqPW/yhiG12iXsm4Xwn+dAc+Zgqh6BgmTN
        MqEv9HetHjTXDiODuHza5MmcSqRs7myJJkMgL6iCIu5E
X-Google-Smtp-Source: ABdhPJwvODDvQ4KLpKk0fD75RNVBgUB94k3khx38i6Ho7wj/5TTqZJBIceZ0+PHhGXnQ9IG+S64e755nG+X2AUCadN0=
X-Received: by 2002:a05:6808:56f:: with SMTP id j15mr2234719oig.140.1599853814752;
 Fri, 11 Sep 2020 12:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200911193534.427521-1-chpebeni@linux.microsoft.com>
In-Reply-To: <20200911193534.427521-1-chpebeni@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 11 Sep 2020 15:50:04 -0400
Message-ID: <CAEjxPJ7+C74OnB+QR6NiO_aDdLoNamTApNwYi0O7k5TELqK1bQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux: Fix selabel_lookup() for the root dir.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 11, 2020 at 3:36 PM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> 9e4480b introduced a change for removing trailing slashes from

For the kernel at least we require the style:
commit <12+ chars of sha1> ("commit subject line")
to ensure that the reference is unambiguous and the reader gets at
least a partial description even without going off to look at it
separately.

> selabel_lookup() for files contexts.  However, it turns the root directory
> lookup "/" into an empty string.
>
> Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/label_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 6eeeea68..726394ca 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -902,7 +902,7 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
>                 goto finish;
>         }
>
> -       if (key[len - 1] == '/') {
> +       if (len > 1 && key[len - 1] == '/') {
>                 /* reuse clean_key from above if available */
>                 if (!clean_key) {
>                         clean_key = (char *) malloc(len);
> --
> 2.26.2
>
