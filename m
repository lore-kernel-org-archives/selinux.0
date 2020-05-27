Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94C4C433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 19:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4BD207D3
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 19:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN4P68Qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgE0TX1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 15:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE0TX0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 15:23:26 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A1EC05BD1E
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 12:23:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 63so474493oto.8
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GD4eX9IsMqUGYKTFpIFN/1vPodpbG8N7uDuKX1rKLY=;
        b=KN4P68QfAha3OgcT3jlTesxJAre/PWxKbHP7eqmEQvCypbyfZQ00yEi3QLKTINsTS6
         1WrArUGOfG6CXxWA5gllH3L91u2ty66cmk7cpKsDNVe1pRAM8QCKmGitucETULKh6bsg
         7FNnkRtrePGzyNvJ9xXNSnJQAMsKYO1UUWpUrNOZfZ3U2fQK+/SS7DJkn8h1TtS4aeP4
         Rdjcg6rDJ/hgMYL1+X9gesaxhBPsxQYa6P+muICptztsD+gciTh+hbpndUMZvrAMOWO7
         B9nEsz9gu859YywI7CVzAQOdyFSb0U7rpS7pWZrejAQBePBTwe6tHuEeNrsohuLTH/+t
         RWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GD4eX9IsMqUGYKTFpIFN/1vPodpbG8N7uDuKX1rKLY=;
        b=kPZCKx8BtwbFyQR3aMmiEIOtZijlm8UUy8Z3E8yEu9VsyTs80f4KLp7zjkA0mNul5m
         W40ZDr+bbGx5iZ6jUVm/IIvQRF7Nihbd/kRo6n8P7KbgPsSzr+8RbvZvd6Svx5xtQZ4U
         CDxPzIGMJHHRLGDuzFT0WyU4QK6AQzsOeFUp3G9ru280RHkEhYf0bDYMl4DaybdIVNla
         jo0blCuvfCeBbVoqdVj6XDRmrEErHpwPdoS6QLSDOIwS9Y1Jn2y2oLKQVOeUI4S7fl8q
         sJSBCha/bXL93RMUpt67LkUX/ZLzjIMpGVuRDSXxJlGp1mA1g469C9NK+LW23GsBWRjI
         4wFg==
X-Gm-Message-State: AOAM532eWOYHn+rrW/EjoKyXDATK+BkVNZnS6BK2zisMtcKqNm+xHC5P
        VfMhZfqVLYZm2jKemZNifd2xFBcWs0QKKpl1RHYCBmW3
X-Google-Smtp-Source: ABdhPJykyZlCanVtYm4uNys+LLOLS0TE3EAWOuKB1aPN+cshqVdrwPRuHvkX9BodV4RKBvKpWOrkQ+XVCJMym4Gt0VA=
X-Received: by 2002:a05:6830:158b:: with SMTP id i11mr5930437otr.135.1590607405732;
 Wed, 27 May 2020 12:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200522145513.194440-1-jwcart2@gmail.com> <20200522145513.194440-3-jwcart2@gmail.com>
 <CAEjxPJ6UxEaNkZt4sdCfeVd2amr1fxE97d4jWRD=nkDif=oz+w@mail.gmail.com> <CAP+JOzTBqkDgqizyLodJk09-Ru3Kr54Wp=gOO-s_K+ZVX=cu+Q@mail.gmail.com>
In-Reply-To: <CAP+JOzTBqkDgqizyLodJk09-Ru3Kr54Wp=gOO-s_K+ZVX=cu+Q@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 27 May 2020 15:23:14 -0400
Message-ID: <CAEjxPJ5BHwcAW8hRu3e8EP-VoykBSQiJTcw73EKTAFMRu7d6HA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libsepol: Improve writing CIL category rules
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 1:20 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, May 27, 2020 at 12:44 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, May 22, 2020 at 10:58 AM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > Improves writing of CIL category rules when converting MLS kernel
> > > policy to CIL. No changes to functionality, but eliminate useless
> > > checks for category aliases when using the p_cat_val_to_name array,
> > > find the actual number of aliases before allocating memory, and
> > > skip the category alias rules if there are no aliases.
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> >
> > This series looks fine to me but do you have a test case that exercises it?
>
> See attached.

Ok we should likely try to move some of these out of tree tests into
the set of tests exercised by
make test in libsepol or checkpolicy or secilc and thereby get them
regression tested by travis-ci.

Regardless, for this series,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
