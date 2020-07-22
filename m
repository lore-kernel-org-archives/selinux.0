Return-Path: <SRS0=bGuM=BB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7CFC433E0
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 15:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E3720709
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 15:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNOqUQ9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGVPLR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgGVPLR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jul 2020 11:11:17 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ADAC0619DC
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 08:11:17 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r8so2160106oij.5
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ndc1+IlcWOd9atR8DyOzVh+HyNr8OFRL+STwZrv5jCU=;
        b=hNOqUQ9dEzVgHMODkj+vJVF8g1BVq1qmt51HGnBsqKArR2tKPklbHWLEFbxQhA6CxC
         WPnORD7FIBB2oAhAz6tdxhRe5wJIMqG/R4QsK5CbEDeUnXeFCNVEUA6z245wz6MzDbUQ
         HUCLmB4a+o5WBwtCmSXjs7KefRBkxmJ3Szr1egjMXj2FD9vTr0GI3R6sq8DGRHT2V9Xv
         CpQkfRo/OdU1FVtu31rWn+wwa+wcdFLOR3ultnBP8cN6xK/e7n2ZQd1avzSkgJqbkEH5
         RECtOHTPvFH+V7BCRRZMJLQRSj/yiUywIuYp7ut8Mg5Chb9NuorvVwk/0tgYc5f1iLEj
         kOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ndc1+IlcWOd9atR8DyOzVh+HyNr8OFRL+STwZrv5jCU=;
        b=qpJo8Q1r5YyReTsvEwa9MpSvyNxjzMJToBu/g9888MrYoOAq5NzzNPFM6bLxbIrO1R
         fKuZTCLmjufLWixbTRPj9GD6kuSw2nKSOSrjXeerUvnJLiuUZz7xkOttBHrxV9hUX4+j
         HTT3BURoL0h5p8yGapjqb85IodhzFIh6dmIpAnXVY7WvlZjhqWKfVwT9hUlMSKMLwsss
         VHbDl923o97J9ghkl45BSY/DUs388C4rWA/ZYLktHASD19yU2t9QH2FjFTjv2cE+N35w
         OnE/BXagUd/OIPb9zy3MwrRcUocrz92hSKYhHZAqTB7kzOX8NMMJ2wvAI104g8A4VWdg
         f2dQ==
X-Gm-Message-State: AOAM530UEjDemwy6yx2qn7ZJkf87UiV1oGK7NBODKCGIt3Pc6q06o8ec
        LZsmwFtp/XYrKIFIB9NjRGQT/qvgOgzvLL3tzv/o8A==
X-Google-Smtp-Source: ABdhPJzdwKYEZ2Sv0G40HBfXHeCuFnbjdbLZVkYUgR+BAtgdu5buPvJ+0pY5NXqFkc5E0pTMHzn5A9bOcM6EQsqcpOI=
X-Received: by 2002:aca:ecd3:: with SMTP id k202mr114081oih.92.1595430676678;
 Wed, 22 Jul 2020 08:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200721195153.1974509-1-dominick.grift@defensec.nl> <20200721200230.1976501-1-dominick.grift@defensec.nl>
In-Reply-To: <20200721200230.1976501-1-dominick.grift@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 22 Jul 2020 11:11:05 -0400
Message-ID: <CAEjxPJ6twZempmDtTBQjUxs_x9PJr5eQf1aSLJ1a6OpM_1eR=g@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 4:03 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Elaborate on labeling. Touch on the significance of the default statement=
, on various av permissions related to labeling using the libselinux API, a=
nd on how the kernel and unlabeled initial security identifiers are used to=
 address labeling challenges in special cases such as initialization and fa=
ilover respectively.
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---

> diff --git a/src/objects.md b/src/objects.md
> index 58664ef..1907316 100644
> --- a/src/objects.md
> +++ b/src/objects.md
> @@ -269,6 +275,39 @@ and manage their transition:
> +The `kernel` **initial security identifier** is used to associate
> +a specified label with kernel objects, including kernel threads
> +(both those that are created during initialization but also kernel
> +threads created later), kernel-private sockets, synthetic objects

      ^^and^^

> +representing kernel resources (e.g. the "system" class).
> +
> +It is true that processes created prior to initial policy load will
> +also be in the kernel SID until/unless there is a policy loaded and
> +either a policy-defined transition or an explicit setcon or
> +setexeccon+execve, but that's just the typical default inheritance
> +from creating task behavior for processes.
> +
> +The `unlabeled` **initial security identifier** is used
> +to associate a specified label with subjects that had their label
> +invalidated due to policy changes at runtime.
> +
> +It is also assigned as the initial state for various objects e.g.
> +inodes, superblocks, etc until they reach a point where a more
> +specific label can be determined e.g. from an xattr or from policy.
> +The context associated with the unlabeled SID is used as the fallback
> +context for both subjects and objects when their label is invalidated
> +by a policy reload (their SID is unchanged but the SID is
> +transparently remapped to the unlabeled context).

There is some redundancy between the last sentence of the last
paragraph above and the preceding paragraph; the last sentence notes
that it is used for both subject and objects (not just subjects as in
the preceding paragraph) and that it is technically the context
associated with the unlabeled SID that is used for invalidated SIDs,
not the SID itself.  The unlabeled SID itself is used as per the 1st
sentence of the last paragraph above.
