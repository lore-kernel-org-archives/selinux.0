Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0410C433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6AF20776
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt0j+Nca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE2O5k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 10:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2O5j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 10:57:39 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C797EC03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 07:57:39 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id d191so2763212oib.12
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGwHay1Aen7SoZLGDG2WQWFNNH+HNGs0L1IPjHbT57s=;
        b=Vt0j+NcaPfD2a0R4NmYUs9eqMCYjSODq2tmRhVqQSZPixiIGHcXJWrVRCNjC1C5wm9
         CgEUw0HYJ9haHqWmd8Z42pr/qN011QW7mAj0HHC2SV0uRdu1Kl+peuCng9Et86RfRxRD
         MFIG8wQGM4K3t9Kt1OA6ixkiYHZuU819tjcidcBIB4Gy+N1bsbaQEt630TPxlPKK7tJF
         /9mPJiiLZPnwLJkqTkuodwY1H4ECzFJ2BgcBvglYNnBx3fcprz6i1NYRTxXCHK5XfsI4
         zfqTZ/oUigMH+SclWurt9mxyPCw9cEEN2lt6/8Z3qa63/YIXPjdrch8+MsB7JDwNnuK8
         /q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGwHay1Aen7SoZLGDG2WQWFNNH+HNGs0L1IPjHbT57s=;
        b=jEP+B7fowbDYA0pS3MgME7TWRkEnFb4J9bcSosEHIEFmHcEH4LxFL/ZP9mlhNfOeYW
         xKs7Fl6lZmlpKz3N6zdh14aW2jxWdH9s8YAgMM37cu8+kLgca+6oP4EBrOnPXP6oKqrK
         iM4LtGlPdTKWaVIjTXSVWuD8gtPQn5lQsgqYkgy17N26bHmlfktHUv/c8H6D//0WFBnS
         KScsJPB4Mykk30ZdlO2n0WMQQRPUgSVLuA2GqVKsRZ8cw58T7SvrGmzUK9rVaaH6jFa6
         GMc+StvV77wqDEq7reeYWDLyaHq2fYhgd2102IEBsBk0jmGg64Hn4Jio9shuoNwuDKB7
         n5tA==
X-Gm-Message-State: AOAM5338esPzF0iRUk2O72c/cyXS68EyB1+SvvcwoaY80fRAClqjNDmO
        czXNZuxllazFBplZJQcA4eTF62J39+z8VMN5jNg=
X-Google-Smtp-Source: ABdhPJziK9GNrL2gG70OwmVcKtkQ1mSn3O62PK2nLPRqlBXl6QWJb34atY4XdMB7cIMIhBh7XvfeaLysB2YM1Gid9To=
X-Received: by 2002:aca:c704:: with SMTP id x4mr5850658oif.92.1590764259270;
 Fri, 29 May 2020 07:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200528184056.105774-1-jwcart2@gmail.com>
In-Reply-To: <20200528184056.105774-1-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 10:57:28 -0400
Message-ID: <CAEjxPJ5a3BDuN2VpyMt-TWMZvPVVx+JHym3EwnMdHC4xkEXTfQ@mail.gmail.com>
Subject: Re: [PATCH] libselpol: Sort portcon rules consistently
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 28, 2020 at 2:41 PM James Carter <jwcart2@gmail.com> wrote:
>
> The comparison function, portcon_data_cmp(), only made use of the
> protocol to put tcp before udp, dccp, and sctp. Rules that have
> the same port range, but with different protocols would be considered
> equal unless one of the protocols was tcp. When generating a CIL or
> conf source policy from a binary or using the "-S" option in
> checkpolicy the non-tcp portcon rules with the same port range would
> not be consistently sorted.
>
> Changed portcon_data_cmp() to sort portcon rules like the CIL function
> cil_post_portcon_compare().
>
> Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Any idea why it used that logic previously?  And how does this compare
with sepol_port_compare/compare2() used by libsemanage?
Regardless,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
