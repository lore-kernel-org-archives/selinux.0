Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC50C34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 16:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104F7208C4
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 16:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auHMvTFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRQBo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:01:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50894 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbgBRQBo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 11:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582041703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EHCKZbp5OothLdZPSUvneXXZgqPy3Tgx+pUXy1jSIHo=;
        b=auHMvTFa/Se7LFxJPeb+bqZHT/03tRUmOZI/h0hG7QuyCMClKd5YfGo4BklTHEY2Ffa1/X
        yla5C8Pghl3kmA6fSHP/12jBDvSMctEFvusbmHAl9xi3MmSqwjWu1Jw2Q5PaS8Uozny/F8
        Aks6WFmspyVoBHugdgxsWa6+gcBCKs4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-zy4_aMkXPFKa3Mab83RVRQ-1; Tue, 18 Feb 2020 11:01:41 -0500
X-MC-Unique: zy4_aMkXPFKa3Mab83RVRQ-1
Received: by mail-ot1-f72.google.com with SMTP id d16so12644991otp.10
        for <selinux@vger.kernel.org>; Tue, 18 Feb 2020 08:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHCKZbp5OothLdZPSUvneXXZgqPy3Tgx+pUXy1jSIHo=;
        b=OSvmA3eb68/ChsWsAv/EIoiLxWd4Km5EqDqVn4dRj3ifeM8L9MD3mtFfwqLCx+1P2O
         cIhil5ksK3B86iVu6FU9THyL1c/58G4auHqDBTv8pxFs531p02CUt8S0JfuERv4mMS0E
         X9OCih+60Ke4kxk6Zu7YsyRF9rToqVKpI3T7O1+IaqduOOyVwyyxckQagcGX6uhkVnEi
         g1AHMFp9m5xFVkWY61oEzFVTCBVeDv+KHJfyBjcAqog3yq+m/4xiUTTF4zFXg91dSwlY
         25vT9SUtNw/ANWSa+OVTmCcFX6tYjQNncmscfTkUWbX8VgOyQoLoXgnCe2+t7dYKR7L4
         +9pw==
X-Gm-Message-State: APjAAAVGqX0gBM9BKiW98pn4K53YKFKQW6RFgvDBDnAriUCzBVL4C5Kf
        khLxT3pVB2mnFDRk6UpahyJR/XrO7HCs8sraMj6WX9NCXsRmibPuY6st3E/jziofEJYF8BUGHFQ
        HlCw6p7zOqgmxT9q1uuXecl4nFg1djHFKPw==
X-Received: by 2002:a9d:7482:: with SMTP id t2mr13147937otk.367.1582041695343;
        Tue, 18 Feb 2020 08:01:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVexx2rqo2/FKZU2Kj1/mFy7cGMl8TgMJfj0S0+TFMkQ5UH8IOERB63INg8iRhkzmlF08B9nVldAOblU7LJrg=
X-Received: by 2002:a9d:7482:: with SMTP id t2mr13147604otk.367.1582041692660;
 Tue, 18 Feb 2020 08:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20200213133959.14217-1-omosnace@redhat.com> <CAFqZXNuxHYN_cMY1+PfUFrwu6dQyG5qc7LGPU8VbUAyTXRF_Wg@mail.gmail.com>
 <7d80365c-d2ea-f167-0757-6038becdb5fc@tycho.nsa.gov>
In-Reply-To: <7d80365c-d2ea-f167-0757-6038becdb5fc@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 18 Feb 2020 17:01:21 +0100
Message-ID: <CAFqZXNuvL1KQwahXPJKngr_p7sON0SNM=5Mecao0QhAGfRTN2g@mail.gmail.com>
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 18, 2020 at 4:40 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/18/20 10:22 AM, Ondrej Mosnacek wrote:
> > On Thu, Feb 13, 2020 at 2:40 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >> According to profiling of semodule -BN, ebitmap_cardinality() is called
> >> quite often and contributes a lot to the total runtime. Cache its result
> >> in the ebitmap struct to reduce this overhead. The cached value is
> >> invalidated on most modifying operations, but ebitmap_cardinality() is
> >> usually called once the ebitmap doesn't change any more.
> >>
> >> After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
> >> decreased from ~14.6s to ~12.4s (2.2s saved).
> >
> > I have no idea why, but I'm now getting completely different times
> > (10.9s vs. 8.9s) with the same builds on the same setup... I can no
> > longer reproduce the slower times anywhere (F31/locally/...) so I have
> > to assume it was some kind of glitch. Since the numbers show a similar
> > magnitude of speed-up (and they depend on a bunch of HW/SW factors
> > anyway), I'm not going to do another respin. The applying person (most
> > likely Stephen) is free to fix the numbers when applying if they wish
> > to do so.
>
> Thanks, applied with fixed times (although I don't really think it
> matters very much).  Maybe you're also picking up the difference from
> the "libsepol/cil: remove unnecessary hash tables" change.

No, that was actually the reason for the first correction.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

