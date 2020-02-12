Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F1C35242
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C26A20724
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="P2lwzEIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgBLCsE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:48:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36800 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgBLCsE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 21:48:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id j17so639501edp.3
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 18:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWA7Tw53cHwngf3UyR1R8GTR2N/ZWmNNs1J36DvWJOY=;
        b=P2lwzEIKgIoiFiL4DU3Z2ff9gihRaTW6W2llFbqTMv5sS7G7M4AYZE8IH4+13cO8/P
         U2AmzFeQ5pkJrxvAvZdgxh7rnM/jB5gByijWOMbNTv+FpkknZum9sj9gCa248qNKMNuF
         F2Pad9iMx+tewQZiqCwKiJH33GQPseHVilGV5fU5Zlr0tOfam/1Ru2nabdsOsFkan2iB
         GqcrIPOeQ8PsPf8dO6JCy2v/e+hr8k+cQ8CDLEb/3sRrt6hh6MzfKzPP4375JAlc49H3
         UJ+rfwGQs63DYXlD4TRvv3m9nShN2mmKjHNXerBePz096jCo2hhvpHq1L6lzEClvsdyo
         MgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWA7Tw53cHwngf3UyR1R8GTR2N/ZWmNNs1J36DvWJOY=;
        b=R4uMLAXXwK53grjRdf3B8kqtgHL9kdvby0dhl/oTRzVSvMXceoc07GVDhltcBKhR+c
         aZN/bdLf2x0XQjI5vNxZ7fOKrvdeGaZArkGyex1pQ221+/BPwUlB7RfZWrjeOd9HaLY/
         RWafnik27f1Q6ZUFQFdZsLwC3QYHQ2fZH+WkZDiEsHHfg91k5HQeQ+SNRDHue4AEsDIs
         0azICjEE41lEIsK/mdtRH7VQAfwnk1DQE9di/AoX2UAcDKhCY8PuNH69mHI3Ghy5MSw4
         Bjdt/8AXAvOEqk2+I/PKZeDt9R4KB5DD+lMPjl3+ZPlvol1Q71oyG+spezxm/zzS7pVY
         tgCQ==
X-Gm-Message-State: APjAAAWs5O3nur3mEl8muOBnXTsigk6GfrKVHfMaPNSWlFFUFGO3+cJF
        ietbdQ9vQVjFObUCCQ10v7ofAQNxdP7UtFuZhzlF
X-Google-Smtp-Source: APXvYqy42iPkaK9UZiavp2bmhGkHgsVzroNwGxlN3i6GkhWtUyaWxL0d6MkH023R/2sUc2xfK5OtQt62ZOPeX2YLICs=
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr8928046edc.128.1581475682199;
 Tue, 11 Feb 2020 18:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20200203112723.405341-1-omosnace@redhat.com> <20200203112723.405341-4-omosnace@redhat.com>
In-Reply-To: <20200203112723.405341-4-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Feb 2020 21:47:51 -0500
Message-ID: <CAHC9VhQ0hJr1BXizhUBSZ4N9EvjAkfnOU3U6ma5YP8dgb0aEJQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] selinux: convert cond_av_list to array
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 3, 2020 at 6:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since it is fixed-size after allocation and we know the size beforehand,
> using a plain old array is simpler and more efficient.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/ss/conditional.c | 124 ++++++++++++------------------
>  security/selinux/ss/conditional.h |   8 +-
>  2 files changed, 53 insertions(+), 79 deletions(-)

Also merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
