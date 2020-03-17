Return-Path: <SRS0=xXH+=5C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAD1C1975A
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 18:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6802020674
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 18:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD5J8SKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgCQSYj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:24:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33810 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgCQSYi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 14:24:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id j16so22720122otl.1
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2020 11:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myZBl/YYez7pj56pmJzeHi8Owiain+4xLYHbdpWKWhY=;
        b=pD5J8SKIBVMWqEzacz+UUpHNhnHDGvJln8lyvpPNw7wTZXcQKEMhUZFHAvvElS83fJ
         k9k5RHHK/M7G/0w1Pr9w9LqLmAQZFLBETIDz08faaykNPvV0nrAa1a4VrKr+E1Nk8J/t
         6V7DRhwg4OV8Z9+pE4NZBBU4HPW50Pl8mV2GY+9cllYKvTRLFrKoWG2lgyOwYRZGCx8J
         GLS6u/Z2OfrFAZDyiWhmgSB6jd9nBzb5vbzLMgJ4S1N+4/EGNMGw0js+3uDvqdYd/f7z
         OtolyNWhdxGY55RY7ygubHLm8qgsbxz5TxZ7pDcdvPdg5aUVRe7u+0DrZGa1A/rgCTS1
         W7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myZBl/YYez7pj56pmJzeHi8Owiain+4xLYHbdpWKWhY=;
        b=mzPH73iMT2hKeCvquIVq1nZXU9Rs6kqHMKlpaYVgE+HrjQMK9E9OBkXp3KTSGi5+iE
         eIvIowaPrnTU7YTVkBm8eGw5kGxQden2P1vEYSnOAGmbo+7iSo85xaJqiEz+BiS3hA0o
         GoUE7a5u32ImNyLsBosbrJtoei820EvT/nINYs9vLe2qpktXMlycm+CNBSxEqaL2IOr/
         vb82DYQxAUQH8bT5t6ed7qghjmIIhd+qAK3Db++RPDikDLVzzVpBqA3KzqqMg4SgHrl0
         MNodnRvY8i09OIRgkbVQbheNz/TUksFbYGJNmd9qpkpfKMi+CDxmucYUn9HB1Nj+nSxI
         nDKA==
X-Gm-Message-State: ANhLgQ07cJsbI1pQxbgAjSk0ChXRf3s1MOCrRSybHFmk9t7dtvfGpAw7
        YR5+7CXF4lHsCO7E9H0CennaL1gfxHdjMQR7EkK++FOc
X-Google-Smtp-Source: ADFU+vtjXXg6med9rJNTb2kinhBEF8kIK6r57oQeKc0pXIL6l9yGruCHCKuZIcO4A2VIbDMCP4vdDBIM/R2eU5taWc8=
X-Received: by 2002:a9d:383:: with SMTP id f3mr492512otf.165.1584469478021;
 Tue, 17 Mar 2020 11:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <20200227160257.340737-4-omosnace@redhat.com>
In-Reply-To: <20200227160257.340737-4-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 17 Mar 2020 14:24:27 -0400
Message-ID: <CAEjxPJ6BnBoBGi+Dv=MQkH0-+JPAQE3ewHGykERYw_yEJ92CJQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: speed up policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The iteration over the set ebitmap bits is not implemented very
> efficiently in libsepol. It is slowing down the policy optimization
> quite significantly, so convert the type_map from an array of ebitmaps
> to an array of simple ordered vectors, which can be traveresed more
> easily. The worse space efficiency of the vectors is less important than
> the speed in this case.
>
> After this change the duration of semodule -BN decreased from 6.4s to
> 5.5s on Fedora Rawhide x86_64 (and from 6.1s to 5.6s with the unconfined
> module disabled).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Sidebar: Wondering whether you would have gotten similar results by taking some
of the ebitmap optimization done in the kernel into libsepol. Regardless,

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
