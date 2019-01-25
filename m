Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDB7C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 22:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788BE218D0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 22:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bCu3tXXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfAYWgO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:36:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37230 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYWgO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 17:36:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id t18-v6so9680607ljd.4
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 14:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2plFC2FV6Arr9P9Lul+wqrdFlMCwpSDJvsmnlPPp+QM=;
        b=bCu3tXXR4owZYwbktl39Wot3hB3XQ7GL1P09k+0reQWxAgTf2SoHPjAY/52sT/iv+o
         aibNQJBHbtDKt31WEBdEjmWx5LQx0k8RNFbdupeBfrCNO93gYg9BasiF821qz8g1W/p9
         fecEMwP2awU65+V7/p685/pjwtvQsvRGrd7EajCROpBPOdUq1uB6TcVzhU8tr12/gBnx
         9FAUmNJwogfusY2PZgefPEENiO94BtN13yw86S3EmH5ChtWpPsayaTO2ORNZW+IJbJpU
         BEuCaVrnrQ74mnpjHNXRQsp26PYEGkR5zdrooiPjiQ9D4kbXLstCFsWUuJ/ryKetjEc7
         9NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2plFC2FV6Arr9P9Lul+wqrdFlMCwpSDJvsmnlPPp+QM=;
        b=UBROP/YVapE3J9MUpYJin/2sW8s4565eeFW7KNhnPf8r/NKt0s5uBdKeXvZx6FkRKQ
         P3lesgQa/rvCfE+ZHrLSHILiB3WAyeCVYLzhJjxMRv0kWBv1rxDzC38o3+1v2HFVwy4t
         8V3m/lvl39PVQ3LpqmKLBbRWtgIVgAlozgozcI8aA0+boSxHg1AaYmq2z+hUb00BA3fX
         LuV/h/F/2mhavlxg7XBiDI0zc6ZKghGj9sQ4cRM2GAirrAHH/ZFiVth45KZUCP9rnLqG
         ZBlDrWy439QQuJmgYP+xfWu4VjbmOD8d1pfI4TpCY2DbcKYSzQX+owDWXRCNaDj454Qu
         mwZA==
X-Gm-Message-State: AHQUAuaRdBVnFCeMgMD/C36EUfdFEr9INb2ZWYrHJ2k7K2MNUvz/KwkJ
        V0C0CpbZliQA2rfCxqywyeFwZX55DH6IIW5PkR6I
X-Google-Smtp-Source: AHgI3Ia7gIwq0e0lSRm7I/H14s/Qwvxd2ISGP8wAi4Oaky+vZxA4pawsQdTLOrAl05b9+ISQFJVm8MWhnGP1ukDJOtY=
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr2273038ljj.95.1548455771685;
 Fri, 25 Jan 2019 14:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20190125100651.21753-1-omosnace@redhat.com> <20190125100651.21753-4-omosnace@redhat.com>
 <0e0ce852-12ab-4855-7794-c1744160e78e@tycho.nsa.gov> <CAFqZXNtuue8dQGigBR0SkiXbeohVxHhh5vdJxX7f=2p6C072gA@mail.gmail.com>
In-Reply-To: <CAFqZXNtuue8dQGigBR0SkiXbeohVxHhh5vdJxX7f=2p6C072gA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 17:36:00 -0500
Message-ID: <CAHC9VhQB=WMiRF4BVKsz4GOAr+Szb=JYnJfFbgurQk7bEB8F8w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] selinux: remove some useless BUG_ONs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 25, 2019 at 11:15 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Jan 25, 2019 at 2:49 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 1/25/19 5:06 AM, Ondrej Mosnacek wrote:
> > > These BUG_ONs do not really protect from any catastrophic situation so
> > > there is no need to have them there.
> >
> > They are to catch bugs in callers that pass requested==0.  That is
> > always indicative of a bug in the caller (e.g. failed to correctly
> > compute the permissions).  Otherwise, we will silently allow such calls
> > and not notice them.
> >
> > At the least, they should be WARN_ONs.
>
> OK, seems that switching to WARN_ON() will be a better choice.
>
> Paul, you can apply the series without this patch and I will post a
> corrected patch separately (if that's OK with you).

Yep.  Patches 1, 2, and 4 should now be in selinux/next.

-- 
paul moore
www.paul-moore.com
