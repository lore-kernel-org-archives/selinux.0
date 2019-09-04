Return-Path: <SRS0=KzaI=W7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85770C3A59E
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 22:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EE220674
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 22:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OR3LembM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfIDWu0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:50:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41330 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfIDWuZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Sep 2019 18:50:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id j4so314735lfh.8
        for <selinux@vger.kernel.org>; Wed, 04 Sep 2019 15:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=or8i5QC8wwPyBAqXI9A1QNz+kBi9OgX+KK6APEn8gXY=;
        b=OR3LembMJZ6Jn9kbLR0j8Ywffmk47BwcKIguYKcJyRCmCPvOuiB3iJDJqUEQMaY7YS
         EtALo/WqVHLkao5rs/yNZ3lyIPbkUKV+lTzW4W6rTJseTwhnEM03PbTQPaphcMtfHJ8w
         2mTVwB3bnDZS3RhSCyGNBvah8Pl88SGAJoPWHr7b8Zc5LiSMHevNnaZf1dI0gIQHqNHh
         1vgnDWRBvYdyVbO+hkVUiaSFwH6UFppjmClpyMNs7VWIcwpNNyp3QwVr3MUnJG43ERmM
         27lQJTlUXkPvrUz/FKyR0zYqWI2cT0l5Ate6k6yK8rVvbh+TLsoGJX5r9N3lcpxci2zw
         UQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=or8i5QC8wwPyBAqXI9A1QNz+kBi9OgX+KK6APEn8gXY=;
        b=iV7+Lsu8WRPTXRnRIb5bjdg67eyEsJ60rQQsIqb/lzDBqumz9OgQ+y9E2QbLR8VM1T
         FYj/y/bVv4nyPx6lEX/YyNkhHrW2ZpbAG60aGhLLhmqeb3YEa052EIZsVi/pVdXKWYuf
         cN9ToSspzDRI6eTfPkKzRWeAfs9nvkuJ346nqxDTFOtgV5OGIHOwhZ5KM91+sEGjcAnf
         ykgmLsHhfPKlSoGfDgM6cWNQ09Pla6ujUtQYZDxRheOg4KRmlvuXjVo5DXqp1qZlR3d/
         QaK+0zucnCFNQQk+bid3F/4CoQa1cHKrk9jVdjue5d90ivFxsjje6eKVNoEnMwY+UH3J
         7zhA==
X-Gm-Message-State: APjAAAX19AUIrg+pFFSBSUEo5dZoJPG3j0bI1ahLHpH/NwHVd5pRb65e
        PdsA29NSmKfy7Dj/HZhTbd7Vh47RwDjeaENJiWWg
X-Google-Smtp-Source: APXvYqyNlE9P/7Tzg3qdUCKxPzbeqU5GV6xpkiVe5rNuRgiLqMr5RHF2u9+yDmgcWjNmUy55pt59697Gb3977Rqlx2s=
X-Received: by 2002:a05:6512:202:: with SMTP id a2mr267542lfo.175.1567637423535;
 Wed, 04 Sep 2019 15:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190904143248.7003-1-sds@tycho.nsa.gov>
In-Reply-To: <20190904143248.7003-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Sep 2019 18:50:12 -0400
Message-ID: <CAHC9VhTdv2C2MbNb7p-cPAW8ZeY+tmcz1c77qXmvowSxrWbw4g@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix residual uses of current_security() for the
 SELinux blob
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     keescook@chromium.org, casey@schaufler-ca.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 4, 2019 at 10:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> We need to use selinux_cred() to fetch the SELinux cred blob instead
> of directly using current->security or current_security().  There
> were a couple of lingering uses of current_security() in the SELinux code
> that were apparently missed during the earlier conversions. IIUC, this
> would only manifest as a bug if multiple security modules including
> SELinux are enabled and SELinux is not first in the lsm order. After
> this change, there appear to be no other users of current_security()
> in-tree; perhaps we should remove it altogether.
>
> Fixes: bbd3662a8348 ("Infrastructure management of the cred security blob")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c          |  2 +-
>  security/selinux/include/objsec.h | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)

Thanks Stephen, and everyone who reviewed/commented on the patch.
This looks fine to me too, and while it is a little late, I think
there is value in getting this into the next merge window so I've gone
ahead and merged this into selinux/next.

As far as removing current_security is concerned, I also agree that
removing it is probably a good idea.  Does anyone object if I merge a
follow-up patch via the SELinux tree (patch coming shortly)?

-- 
paul moore
www.paul-moore.com
