Return-Path: <SRS0=BB3M=CZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49988C433E2
	for <selinux@archiver.kernel.org>; Wed, 16 Sep 2020 00:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0289207DE
	for <selinux@archiver.kernel.org>; Wed, 16 Sep 2020 00:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB91feiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgIPAhf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgIONXy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 09:23:54 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF088C061A27
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 06:23:26 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id 4so730986ooh.11
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ij4TRBfUkaBfw5ERpLvzncgf6wPeQwgiIog3HeWapDg=;
        b=BB91feiMTBICQ1bNWdQgo7j0qW0LMoMlRVm8vvjnfIe/m7TKxeUDRwuSn/VpnIWguL
         1ZcMpVxGzfDq1sh2ztJ+feteEttlwjq5p75m1Ymay3p9+3IUrx4O1WK66tNsBWLzpthu
         qkNd6D5bzd02svNyyj+IAgnEwyw+b9pql7euYpQo9U9zzoNGVuP2T98/FPufKGZ/9bvg
         WzFZWHXnJH6SfDmkbaYhOEF1pY7Ojhq6C6VJWoX9JOQCE3tHK7sln7oqXIxs3HQXoZ3o
         +fvc1L5g+k4ReXkJFk+eg9FsTIkRlaHkXdS+O4+DrjhMeONG71A8KxQ5JJ8lxEl1CgT5
         PKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ij4TRBfUkaBfw5ERpLvzncgf6wPeQwgiIog3HeWapDg=;
        b=ALYQtXLyOvUozaD/KkOydGvksyFJUE1Zxz5MaIlcPJnN7GXJFm9X4Qe7PufHOkSUH3
         g71qTuOljpCdbhfJJnIrbrEo+Ux/hjZzyc63viHB9l9A/sZtUPYay223w6cSBDqSS7MO
         N6pR/sBph5811MRrESzQP7TFYRPnHyaBeP14syWg39K4sM/twueejendj9VE4fDVRSxg
         GLaL9An1vEl9yxe/qFjyoZrfb4dCHm16nt80vRURbiDBV4tILBEAcwZ9Kt6JbNpxQjUZ
         V2bMwSx7gVJhbTslGTVoWzM8MWmb3oG8U9R88yh1Ap7Fik3I8HFe7JBsI/EMrRS0l7Zn
         S3gQ==
X-Gm-Message-State: AOAM532h8zx6uT78cOHWtUI7JlONoCcZX+zp+s3Bsj8PPlQfp0RSWIyq
        U3v/bDpxpEF3KjBWgeIgi0s7ETHIZtXoUSLeVQGDgDjj
X-Google-Smtp-Source: ABdhPJwcuB03BitXV3I5ysj5gfy2gjiMOjI2MSs5koEy+QLSVcpjywkJdQhv1Lx9oo9Xf8pQcKJpYWs5UueX3B6dLGQ=
X-Received: by 2002:a4a:d0ad:: with SMTP id t13mr14207128oor.58.1600176206355;
 Tue, 15 Sep 2020 06:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200911195614.429223-1-chpebeni@linux.microsoft.com> <CAEjxPJ5P0sv4v88xYnf=tadNk=y5+D_z6dDX-JTqQ=dgGjBarg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5P0sv4v88xYnf=tadNk=y5+D_z6dDX-JTqQ=dgGjBarg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 15 Sep 2020 09:23:15 -0400
Message-ID: <CAEjxPJ4yfAi-Ha1V50EaU01FBU-D2zwUOtxLEPhaVz8hp38E9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] libselinux: Fix selabel_lookup() for the root dir.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 11, 2020 at 4:18 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 11, 2020 at 3:57 PM Chris PeBenito
> <chpebeni@linux.microsoft.com> wrote:
> >
> > 9e4480b921bb ("Remove trailing slash on selabel_file lookups.") introduced
> > a bug which turns the root directory lookup "/" into an empty string.
>
> Thanks.
>
> > v2: Fix commit message
>
> This should go after the --- so that it doesn't get included in the
> commit message since only the final version gets committed.  But don't
> worry about re-posting just for that; I can just amend it before
> merging if I remember or if not no big deal.
>
> > Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
