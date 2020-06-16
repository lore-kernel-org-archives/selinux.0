Return-Path: <SRS0=GP52=75=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB4C433E0
	for <selinux@archiver.kernel.org>; Tue, 16 Jun 2020 09:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3D92074D
	for <selinux@archiver.kernel.org>; Tue, 16 Jun 2020 09:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRUWdO8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgFPJAe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:00:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47707 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725896AbgFPJAe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Jun 2020 05:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592298033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGut7KQ4Bb1KSRCD8iFnVXoV8pHDoi56+T/7CkKs4TM=;
        b=YRUWdO8jftMS7HrHqOXyTnI14Jp4uD3udRLHBp4i4InijRzU5QpklzRBMUxPQXzyppb873
        JjacSwcVUj+OILm8y2uR5WWxmxVArsaYfYEdh2PhQfAd0kBlFjheryOB3qjnMd5ii5MbT7
        UL17lAXQrPmxKd3YpqjKbESf6Oe/Lpg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-C_9xOgG2M5m39S9PLjKTEw-1; Tue, 16 Jun 2020 05:00:29 -0400
X-MC-Unique: C_9xOgG2M5m39S9PLjKTEw-1
Received: by mail-lf1-f69.google.com with SMTP id y23so6079383lfy.0
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2020 02:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGut7KQ4Bb1KSRCD8iFnVXoV8pHDoi56+T/7CkKs4TM=;
        b=JNM90VLN/H1V4AMf4d3mCvtBs9tgYaOjtygVKixiKHzekxgYbToGUhFmwDVjD/+6DT
         HWNdn7pazU3Ij3R6pdHdf9ae5xairPDIf3Fh+y7zxq6keBdEbXkOmJNiEt0kucuuL3ZL
         D2B86tBhsIp8MFS4f8dLL1aP4pErJTbKb464VAycQa1ZansN/YsJZrlmfomUeZQ9I5e2
         gC9Ye4ZH4Hy3jwMWZHGXDCP66Kuyd66RUR/yzEc2g+pxw5CwkT5UaX/D0jAWQHRSiS8n
         CS5RHDENaRvKORG1upR8TiB4hgAGcm023YfvUW5ymPRJGgZkW6c0P7HDftftjmQTn3RI
         8iXg==
X-Gm-Message-State: AOAM532XbHcILv9W/X8ZvjSQhg4yYoCHCfJrQDvqBGBO4X+z3yIi2arb
        E1NcMKyAZ21xJCrMCJLYO/G4duchBvgEqdYXkjah0y9Mz1boMWD2H8C+IPaeo+FYfF5gt3YHHVy
        /iqK2/2LmQmOsWP5ORWUsIz5gC0MhS+sFYA==
X-Received: by 2002:ac2:5f7a:: with SMTP id c26mr1151900lfc.3.1592298027757;
        Tue, 16 Jun 2020 02:00:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcbfu6hl9TafL4aMnXGEtNvRs8gelsNE2mRLHNL4+SgmK3gNckNp1tvWBYrOeMzooJQEDocoMuPEAUvybsE3A=
X-Received: by 2002:ac2:5f7a:: with SMTP id c26mr1151886lfc.3.1592298027472;
 Tue, 16 Jun 2020 02:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200515131222.7969-1-richard_c_haines@btinternet.com> <CAFqZXNuv=J6aO6P5M2TqYa7nXpd8GC1+=-Oqz=5khioo2S7uzA@mail.gmail.com>
In-Reply-To: <CAFqZXNuv=J6aO6P5M2TqYa7nXpd8GC1+=-Oqz=5khioo2S7uzA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 16 Jun 2020 11:00:16 +0200
Message-ID: <CAFqZXNtdykHQG86MBQauhfshNFHvCaPbX_OFG+2g507DPe51CQ@mail.gmail.com>
Subject: Re: [RFC PATCH V2] selinux-testsuite: Add check for key changes on watch_queue
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        David Howells <dhowells@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 15, 2020 at 2:08 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, May 15, 2020 at 3:12 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Kernel 5.? introduced the watch_queue service that allows watching for
>
> (I will fix up 5.? to 5.8 when applying.)
>
> > key changes. This requires key { view } permission, therefore check if
> > allowed or not.
> >
> > Note that the keyctl_watch_key() function is not yet built into the
> > keyutils library, therefore a syscall() is used.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > Tested on kernel.org 'linux-next: next-20200514'
>
> I tested the patch on the latest Rawhide 5.8-rc1 kernel build and it
> seems to work fine.
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Now applied, thanks!

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

