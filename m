Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B56C2D0EC
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 19:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7912D2076E
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 19:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjrbPETd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDGTLO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:11:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48657 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726332AbgDGTLO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 15:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586286673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sdcxcm94hmtRRuwbD4xQJ0ZuA4NWf668nF9/5g3jGyg=;
        b=FjrbPETdvlGDjQGMEBEAp66HpP7MzKMa55igTK8M1slXX/8B9Jjpvtk5yu2y6Q7h/+9s1v
        U2giq41nCloaLm1FWifLkSjWkrKr9fylUuPnWRq0aOMsuKcUR6xduW7GEkb5kYvO8MRX84
        Qs4c7KQ/5Y0mMvpD9JC5EiCkVnCbhrk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-bdxZpBV1PVSS3Y8i1hQbCg-1; Tue, 07 Apr 2020 15:11:04 -0400
X-MC-Unique: bdxZpBV1PVSS3Y8i1hQbCg-1
Received: by mail-ot1-f69.google.com with SMTP id x89so3488462otb.12
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 12:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sdcxcm94hmtRRuwbD4xQJ0ZuA4NWf668nF9/5g3jGyg=;
        b=j72MZ6zzFCuRc+wzDrJhkubDPYGXS84/4fQLK1TE2rAoo9en58fpCMBudPP+LXN9vQ
         f7LwXxrDMyotCO2l+WaSspOt9kjyvxHzb6kJcN1bcXLosX8M3ax9EKqADvx78owEgFHU
         GGVk4oCmev7voN5ksoaFCP+jGnEdRqJS4yGm0Zf8smdw0h/iQkdoiGEhulZqaz949eWY
         CUw3BR0dOrzG/92sauZBYWwr/1n5BmVSDYrgWDaAB/MzfyFWUUbmsEskc7nUbAUUVTO4
         awi2+1CqgE0uRZoNKmbWg3bgssyOy2TmkJESYH/PohUIN9AHT211x3Qv4HrIIu1+O+4M
         fx8Q==
X-Gm-Message-State: AGi0PuZmQ0nl2JkNKK185gbRtRqOqDYbaFFQAO8RcE6bKvWNyyJPDnpd
        4XdkO/4KhkUL/ogva+7dcTwkbSWFjIy6JppvhlRI7khq1SIaN9SYNHqd4MR/pJ1JnWDjVUbbdvs
        wPLfZFv+XhYX2NWU/baxc9mhOHdeb4vJAig==
X-Received: by 2002:aca:488a:: with SMTP id v132mr293414oia.166.1586286663689;
        Tue, 07 Apr 2020 12:11:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypJOq/b909elLKjov23RvissYXGDAFNcFNNpohd5HxOAi32urPGiaziRxobG7RvoLVS2cG9ssmtgFGYJfHSQvW8=
X-Received: by 2002:aca:488a:: with SMTP id v132mr293398oia.166.1586286663443;
 Tue, 07 Apr 2020 12:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200402133945.8427-1-richard_c_haines@btinternet.com> <CAFqZXNvp=yAyNM84vOxFdMaNAQ_=FTL00favpQr1mJ4GG261Lg@mail.gmail.com>
In-Reply-To: <CAFqZXNvp=yAyNM84vOxFdMaNAQ_=FTL00favpQr1mJ4GG261Lg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 7 Apr 2020 21:10:52 +0200
Message-ID: <CAFqZXNu3FD9KfAa335mYRgQJXYP6xrukvdDN6Qn-ncGDJppryQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Add notify gitignore file
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 2, 2020 at 3:53 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Apr 2, 2020 at 3:40 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Add .gitignore to stop format-patch sucking in binaries
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  tests/notify/.gitignore | 2 ++
> >  1 file changed, 2 insertions(+)
> >  create mode 100644 tests/notify/.gitignore
> >
> > diff --git a/tests/notify/.gitignore b/tests/notify/.gitignore
> > new file mode 100644
> > index 0000000..fd7c5db
> > --- /dev/null
> > +++ b/tests/notify/.gitignore
> > @@ -0,0 +1,2 @@
> > +test_inotify
> > +test_fanotify
> > --
> > 2.24.1
> >
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Now applied. Thanks and sorry for the delay.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

