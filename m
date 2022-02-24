Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E111C433F5
	for <selinux@archiver.kernel.org>; Thu, 24 Feb 2022 21:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiBXVIC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 16:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiBXVIA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Feb 2022 16:08:00 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D97158DBD
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 13:07:30 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id i5so5031869oih.1
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 13:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpCM7rtmF6M8iQQ6zdgI/HR8BHVAMZivbx57v6TPVis=;
        b=QlrzNgV48w6uRujYQy3J1ScisD/kjM3IfxLCrB2+Z68NjJvewME8XE/Ck1myI0tQGY
         3H8wiALodHoPh/RMXixBV/EUq07Iq4nx/KZNe/i+CODA2NNfPlZzPVjkO+KIweiu/41g
         QO3RblTKjQT5fmErspHlfGEzfkM6IJcsrepfcfHwc+EQwNUg6r/+beqvdxyvG2c1S9Jk
         i6mvk73d+1waSFGrvNvho1IoYDvReIvbKeeFhuSL7VbqiDVtD3sQxT9eoVJYT84TdTwB
         73rMeHGfwUS5j9wtiBXvLN379AJ41uh1MXAYtXR9pDlut7D+0Q/KqCbhSi4j049PR8ao
         wo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpCM7rtmF6M8iQQ6zdgI/HR8BHVAMZivbx57v6TPVis=;
        b=H+AMGA/Dzw9tZGhpICVVcnUL1gIphpHazRxP5PvzK9uauv4rGP9cepbWdTspJ+83Ul
         YJyrkzym+B+DvPpna27ALEpyPbMA0EAovy+OJNv2tBkUQzyfsqUy32JofANOg0dWzdkH
         EU7Z+F8EAAgk8ZzPSqKxppWCXkYVMDXEy/ZEAY8I2T3buSLaw/2NC1BX273FzJPLk7Bg
         8WnSEBiJQ139Mv+AAIIEzFSn4Q2oBLguTCUkLvDrN7IIEy5LtciHcWEnWko0laF/QKcK
         BlFj0me7SqwHSmDKdl8NpMVU5DM2ULeFErp9QfWLyiN4xl+kMEU2+R2TpUzghKYwYdFi
         D16w==
X-Gm-Message-State: AOAM533IaHS+yERP/t9YgcavqYPCpcX3gqkGwZG9Fx7fFrANNG7KMeXI
        Ou4vR3oY/mLfm2wgY43zg/8NG+D6Nnuh1Lvbte8JJtD5
X-Google-Smtp-Source: ABdhPJwtNZtkc1kyWYOl+DHnp5uUaC6gwhZ2xDifG2VRWx72cK9Gs9kD1+IK9SIVaZT+2xA1QC6TIO48poDdnuupjdA=
X-Received: by 2002:a05:6808:1152:b0:2d7:27e8:aa48 with SMTP id
 u18-20020a056808115200b002d727e8aa48mr3839745oiu.189.1645736849448; Thu, 24
 Feb 2022 13:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20220111215446.595516-1-jwcart2@gmail.com> <CAP+JOzSc6Gmtc7b9rB6t=CLVG+83OOzU5ikUJ9S8JWv8LxqDiw@mail.gmail.com>
In-Reply-To: <CAP+JOzSc6Gmtc7b9rB6t=CLVG+83OOzU5ikUJ9S8JWv8LxqDiw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 24 Feb 2022 16:07:18 -0500
Message-ID: <CAP+JOzRJG8sYiSRGFF45wF=ytvjUBB-x4E3RZ8_XZ6P+qa8Z4A@mail.gmail.com>
Subject: Re: [PATCH 00/16 v2] Refactor and fix assertion checking
To:     SElinux list <selinux@vger.kernel.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 18, 2022 at 4:16 PM James Carter <jwcart2@gmail.com> wrote:
>
> I plan on merging this series next week.
> Jim
>

This series has been merged.
Jim

>
> On Tue, Jan 11, 2022 at 4:54 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > The first 13 patches refactor and cleanup the neverallow and
> > neverallowxperm checking code to make it easier to understand.
> >
> > The last 3 patches fixes errors in the assertion checking code.
> >
> > This series is to prepare for adding not-self support to assertion
> > checking.
> >
> > The only change for version 2 is in patch 7 where target_type should
> > have been used instead of source_type.
> >
> > James Carter (16):
> >   libsepol: Return an error if check_assertion() returns an error.
> >   libsepol: Change label in check_assertion_avtab_match()
> >   libsepol: Remove uneeded error messages in assertion checking
> >   libsepol: Check for error from check_assertion_extended_permissions()
> >   libsepol: Use consistent return checking style
> >   libsepol: Move check of target types to before check for self
> >   libsepol: Create function check_assertion_self_match() and use it
> >   libsepol: Use (rc < 0) instead of (rc) when calling ebitmap functions
> >   libsepol: Remove unnessesary check for matching class
> >   libsepol: Move assigning outer loop index out of inner loop
> >   libsepol: Make use of previously created ebitmap when checking self
> >   libsepol: Refactor match_any_class_permissions() to be clearer
> >   libsepol: Make return value clearer when reporting neverallowx errors
> >   libsepol: The src and tgt must be the same if neverallow uses self
> >   libsepol: Set args avtab pointer when reporting assertion violations
> >   libsepol: Fix two problems with neverallowxperm reporting
> >
> >  libsepol/src/assertion.c | 193 +++++++++++++++++++++------------------
> >  1 file changed, 102 insertions(+), 91 deletions(-)
> >
> > --
> > 2.31.1
> >
