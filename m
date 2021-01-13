Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D04DC433E9
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 14:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65D323441
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbhAMOoA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbhAMOoA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 09:44:00 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F60DC061786
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 06:43:20 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id a109so2112080otc.1
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 06:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDUT6x4gv99JOb0R474RLy4ywYXeAWT+Wyy2TSxGWR0=;
        b=HgwxCxdOjH9s+F/dD4srK82RlA6tZHHGM2ilgPa52EiLnvjnsYhH4WDAbEdP65Rum8
         /Gn2PQ+qoJtqt+NCtNAdt5DantN5+G5CM2/z8KQp+OAPDFytBp4IvMrNuDTPfVlouImZ
         Hh/1rPoAdm/wRWggT6ANFaeI4iLj+xpiemiyvmGu+WCBfUCdl+0odQs+mkaKPkwVnMma
         nprrqe9bn8K02SFCS3naaA1ej8EhFemO4HMj8rhWwnARgs5ZiirQ2AXwonzP2DKygWFr
         U1FEmhLQaI6hi/eAO605Asdp5bb7vNNAtLvQ0+HR19n7yAkzrE7yO93JTgeP82DqKc8G
         x0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDUT6x4gv99JOb0R474RLy4ywYXeAWT+Wyy2TSxGWR0=;
        b=iWkHbxxucZYx9JhRs5hcgvV8pelC4vx/i5Y2o6kIyJe+LGj17s2iwkXWgYATmjJDjN
         u+v9C+wEcU/YjLiFda28XoVovBqjDZZlGG4kIV25gAlPEOQfPzI2xp5kJjgjLIFKu6Ow
         yQEPJY9z6s09lyk7lOaY+C9QLnx3/6LVLs3NkGU5sDAky8pLY5QlrRRjeZTAnoAdIxVz
         IR0Yn8blpV5t4ij6LdTFjRy7PIGCVHnZCUCWXt0VVUpk8eaBdRQG4Y9TwLm49QhH9RDj
         V7CPriTt0jua8z4vtXfafmNrHI9IcOXEkKSCf1jShvBttsxTxPi7ZMaxaR2O+mf7IU4E
         oX3Q==
X-Gm-Message-State: AOAM533dveFN4ZN+fLQabiWpKlb1pH52uvSrI89hTgsDarsjZSgfOgsv
        DgTLRvPQtFRsiEFMTZQXGidlmgKTR+hwSzH+rtfM9B5y
X-Google-Smtp-Source: ABdhPJygk7Uy/28HF9tFAVatmRfZvOIWi3QppDvifJuPsp6C8EnbcF6BzoidVmPadKMczqFooS5TjiUHIYUNvt1d4qE=
X-Received: by 2002:a05:6830:1385:: with SMTP id d5mr1439724otq.295.1610548999780;
 Wed, 13 Jan 2021 06:43:19 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjcgaLpB-4L7oD+UaPJsBC=F1c0R21F-vvv3k7M-RGtO_5w@mail.gmail.com>
In-Reply-To: <CAP2OjcgaLpB-4L7oD+UaPJsBC=F1c0R21F-vvv3k7M-RGtO_5w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 13 Jan 2021 09:43:08 -0500
Message-ID: <CAP+JOzQ9wsCGwL42FMZEJ_EyR3mzeNHgrUyPfNdadKX1ScOU6g@mail.gmail.com>
Subject: Re: Why every file context is "system_u:object_r"
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 13, 2021 at 1:09 AM Ashish Mishra <ashishm@mvista.com> wrote:
>
> Hi Members ,
>
> Any input as to why we have "system_u:object_r " in every context
> for initramfs (temfs file system)
> I can see that the type section of selinux-context is proper
>
> -But the user & role seems to be "system_u:object_r " for every file in
> /etc/selinux/refpolicy/contexts/files/file_contexts
>
> Any pointers here or if i am missing any aspect here
>
> Thanks ,
> Ashish

The short answer is that it is tradition.

system_u is used for system files because no user creates or owns
them. unconfined_u is used for home directories because users are run
in unconfined_u. When a file is created it will inherit the user label
of the process creating it.

object_r is used because roles are meaningful for domains, but not so
much for objects.

The type is usually the most important part.

SELinux is flexible enough that policy could be written (through the
use of constraint rules) that would make the user and role fields more
important in access control and labeling decisions, but type
enforcement is usually sufficient.

Jim
