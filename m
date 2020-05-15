Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F55C433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06D6205CB
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="reZkweKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgEOVNd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 17:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOVNd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 17:13:33 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6DBC061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 14:13:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s1so4109951qkf.9
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 14:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlhtWXl7hMmfHckMkTV2E+hGLy2+qvZshwZFbm2Ekog=;
        b=reZkweKynXk6zyL2DPJBvPhUulvzowWc9PVjc0UDLWkeQ+vWInkPl34hX0fK+hqYMC
         Ke7A7ua8Flr0Yyv/ki8mEFxo6mzvu+Hgbg0EDUASIrz0lV2ibjvl6yK1qpnhsXGRpBpJ
         uUbN2KpHTL3nDcnBUD5Qnq7PY71PlInS+d0FlVuGiO8FX9rYgJvKLXr5/MDB9Dj6OhjO
         IeyTLqDPBYtw8YhVGdvxGePvMXr1E/VQ6kuDTAQcRMWvQJLzSl1L9aHFYwzbyN3IKbFX
         esbf7YuUHJtuUGpilXByVWSXHpgY+NHuAcV6V8EX0qDTjVuSgqM7RAJ8WGD8ItkgZ1gl
         1u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlhtWXl7hMmfHckMkTV2E+hGLy2+qvZshwZFbm2Ekog=;
        b=QMabrqSXr9CAqwFk4YgK8C1PNTyDz7/qEi44/XgnXQgWYHKmrkYJQ0AeBbY9llnE4p
         XSZM0xe1Yd9nJBEW1CcaAlTR+F+Tl5dmZhn329Qs/5NyKkZnYvKM+FJIxAeFgeTuY/Me
         3GCN13sCIWD+d4vsnTbnjA/kpXTnb4W6u8JyD6NGNtv/lC440FsnLYoEFFZsqS7P4FTZ
         nbsZn3KNGDK9wpH6Vqu32ivPxuIITZj6CE+PzRo5kcevuLSA9URkQ/j6LoRmS7HEZtRo
         Xa0TuctOeHk5cdMhJU7OFvDLyh2lnIDdjYlKqaATocuPdaaGanV0P49YjnMvj74KoYWg
         wuwg==
X-Gm-Message-State: AOAM531g6kv+3AK65Xw4pjzLDJgjubQRJ3AhrsI99xWAEjSwZn4XtULT
        +IMxobAztVnp7iFBVocnE3gtUuuq/4gy5QMiYX4REmU+
X-Google-Smtp-Source: ABdhPJwr3tzK7zaKDiwIcrg+OI/6a1A+huZx+gesgBjSC1VASXeN0bqEoBh7YWr14iy15+2+V0+yF9H8cUc79nUXfYg=
X-Received: by 2002:a05:620a:14a1:: with SMTP id x1mr5285365qkj.92.1589577211631;
 Fri, 15 May 2020 14:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
 <CAEjxPJ7FQyme=udYKRJ9_gSmaF0Jz_4kk2SSo7S0HkMELg0D3g@mail.gmail.com>
In-Reply-To: <CAEjxPJ7FQyme=udYKRJ9_gSmaF0Jz_4kk2SSo7S0HkMELg0D3g@mail.gmail.com>
From:   Peter Whittaker <pww@edgekeep.com>
Date:   Fri, 15 May 2020 17:13:05 -0400
Message-ID: <CAGeouKHuAeNmU3FtD3XraZmtE9+JdSMBCa7sDmG6re65qYuFiw@mail.gmail.com>
Subject: Re: Bad context in PostgreSQL page on SELinux Project wiki?
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks, Stephen, if Richard haunts here, I'll let him comment. (Then I
can send him my other errata! :->)

Just a couple of comments:

1. I know the contexts are valid, but they are inconsistent with other
contexts on that page (especially s10), and with other, related pages
applicable to different versions. Given their context, they seem out
of place.
2. There is a lot of historical and out of date SELinux information
out there, I have no illusions about trying to correct it all, and I
know this particular wiki isn't updated anymore, but it is there and
present and if incorrect then misleading - that's why I reached out to
the list - the information in github is organized quite differently
and doesn't intersect completely with this particular wiki.

Thanks,

P

Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP


Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP



On Fri, May 15, 2020 at 4:20 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 15, 2020 at 4:02 PM Peter Whittaker <pww@edgekeep.com> wrote:
> >
> > Folks, with whom I can verify whether there are errors on the SELinux
> > Project Wiki?
>
> As noted on the front page, selinuxproject.org isn't being updated and
> is just historical at this point.  Anything new should go into the
> GitHub SELinuxProject wiki(s) instead.
>
> > Details: It looks like MCS information is missing from a few security
> > contexts on https://selinuxproject.org/page/NB_SQL_9.3
>
> I think that particular page was derived from the SELinux Notebook,
> which was written by Richard Haines.
> Not sure if he is still updating it but he frequents the list.
>
> > The schema row has
> >
> >    security_label = 'unconfined_u:object_r:sepgsql_schema_t:s10'
> >
> > which should likely be
> >
> >    security_label = 'unconfined_u:object_r:sepgsql_schema_t:s0:c10'
>
> Those are two different contexts, both valid (if using MLS policy).
> Under MLS policy, there are multiple sensitivity levels (s0, s1, ...).
> The category set is optional and can be omitted if empty.
>
> > Likewise, the database row has
> >
> >     context = 'unconfined_u:object_r:postgresql_db_t:s0'
> >
> > but I'm unsure whether this should be as is or whether it should also
> > have MCS info.
>
> That's also a valid context.
>
> > With whom can I verify this? (Not using PostgreSQL, just noticing
> > errors as I crawl through my hardcopy of the handbook.)
