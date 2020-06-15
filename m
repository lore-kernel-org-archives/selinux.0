Return-Path: <SRS0=CKju=74=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB481C433DF
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 16:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF7320810
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 16:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRt5BBZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgFOQa4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgFOQaz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Jun 2020 12:30:55 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E82AC061A0E
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 09:30:55 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b8so16471649oic.1
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YJGX1d+Ux+GSGjUMTD7p4PylGJiEp4S9ZBZotOpwIik=;
        b=LRt5BBZlBm9kOPrI3PTVW/5hgy+nmzRhdSxH23zHDgYgms0l/+UN/qdCWZbkDqYimr
         sTyM/+ypo26LLoCMU1e42zP6tE+HCzUSAvhy7mxBjemGXi5B3iWpkSD3auWOUCu3lRhe
         Ux8kEejcPvzJsZ3UbYHFGM2VgFTNj1XXOlFpBvHor5l7qVAopXtPIBrddEz/6u08tIWB
         MIetJdAc5NdyRomM452etd45VpFo3Ewkeq5GSw/Gixgy8ncVGqXJCIoSyRLasES7X6ax
         rU4mOkFWLjXf1DA6F23CquXKoQa4m4ZDX+3ChoPrdxy5/Lw4dE+NuyJTQyXP7byfQx6Y
         prqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YJGX1d+Ux+GSGjUMTD7p4PylGJiEp4S9ZBZotOpwIik=;
        b=B9VuZ+G+JrTIamDVYxqS38rnzn7pDKrjmDwqKuLqFnv0N5ZcuaE+VxrVKCwyYMB5Ob
         drw8QnTgUJs/XvGn5q9XxywffOIMMRUjw1lO4ubcaCictwda8Xtmbb2aP15rGv7D6LqO
         T8VbPkbHkpqyFcSqjC89pnN5jpyqLjXwfi/DSW/wnwcdXAUKSwOfpE6ZH9aEu/cmixZi
         iqgqsc5lps0NZfdLimFMTwb7FJ+Xnpg3sA5FYyv+239baY6LkNS25g1bsrpbPSvvVCkY
         2/+gJjc1JjogURH1nR5s6tsA2XL9z8/D8HfiHTr7nx9jF94skBul62yrEiIq2ojjUPlm
         XBqA==
X-Gm-Message-State: AOAM5302triAIuGbdioIPgaPjcdf9hRGKglYx9PzUtuhyY2UBib/8Wf0
        ogpCJ1+mIrZtUvac5Y4aSyEYJSEvLimgtJptwrs=
X-Google-Smtp-Source: ABdhPJxAq2TMrLrAJvWGrkTkM5IRYFI9FhdA6lxaNc1JajANjjhNmln2VnZAXsk9qtUzawfwWMD6zpk6fID7EPi1iA4=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr126381oib.160.1592238654432;
 Mon, 15 Jun 2020 09:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200611135303.19538-3-cgzones@googlemail.com> <20200615150741.18526-1-cgzones@googlemail.com>
In-Reply-To: <20200615150741.18526-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 15 Jun 2020 12:30:43 -0400
Message-ID: <CAEjxPJ6tSKVSeJSJMYfrq53QSRVTWh1fQbHUchxvWysCKLPtxg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] sepolgen-ifgen: refactor default policy path retrieval
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 15, 2020 at 11:08 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On a SELinux disabled system the python call
> `selinux.security_policyvers()` will fail.
>
> Move the logic to find a binary policy from the python script
> `sepolgen-ifgen` to the C-helper `sepolgen-ifgen-attr-helper`.
> Change the helper command line interface to accept an optional policy
> path as second argument.  If not given try the current loaded policy
> (`selinux_current_policy_path`) and if running on a SELinux disabled
> system iterate over the default store path appending policy versions
> starting at the maximum supported policy version
> (`sepol_policy_kern_vers_max`).
>
> This changes the helper command line interface from:
>     sepolgen-ifgen-attr-helper policy_file out_file
> to
>     sepolgen-ifgen-attr-helper out_file [policy_file]
> and adds a linkage to libselinux.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
