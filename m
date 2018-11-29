Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FEBC43441
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 19:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819CD21019
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 19:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Yu7kKGqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819CD21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeK3GyJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:54:09 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33594 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeK3GyI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 01:54:08 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so2611808ioi.0
        for <selinux@vger.kernel.org>; Thu, 29 Nov 2018 11:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TObri6b8riy4VhBHAFZkP4Ecjb5uepSkDJv8gstmZS4=;
        b=Yu7kKGqdjPTq46vGx7yd1jlSLE2/yeSlnOJTUzp0wAV07t5THzJxQVdUwsWQHgzCd1
         OCEkl+hRioT0tog9Dfm/TU9+rt9X7oylk7qTcZWpXvF67a0VazX/eBCvqZjYXMkwqxRv
         aD4jYheto+A5B1w2xDyTHp3sHE12ZvlRbI4kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TObri6b8riy4VhBHAFZkP4Ecjb5uepSkDJv8gstmZS4=;
        b=V4uWH+evLwxvt3u0algwqtYufbWR6LQINLoZ02xThDrheJGPGc6/j0LJNuyNEnS8EJ
         eNPhWITC3jkFzIqqmO3h2za4pi81zyIS4cRxhkWg6KvIzq+qG5bme1NPv+xLEATMt+/b
         HAUS27djeR3mPW3b4YGIgqhT8ZC1QsGyKWm/FTnsafrYnk91zzLFkqFWuz85zaxbou2y
         dIyzDRb/I3UI+kUk4wYFaQjUoWz4hbzDmDYnEL42TbSTy4cH6G0KwyJ/1nB0qrRJYXPF
         hckskCR0EAUl9UF61Z3FNCLjhfUWVdtpcQCWeeqfbmy9h+QAcJEEanDgykPH4jvcbHsb
         R0iA==
X-Gm-Message-State: AA+aEWaiz5tIltPOwGYUYAZxPPZKFPmu3wnR3uhKYez2oPMU7Y2U+oqS
        9baEdK//q/kZSA6Caa4DCDF3ilSCF/DbJt0Rjw3Ljw==
X-Google-Smtp-Source: AFSGD/VY7+tkreu3BzL9Ldl1XHVuY20055VF026B6I1wnkcBkGa5S3YtXL6DObT5J7Wa0XKbD84ZdLXNM6OAccNdT/Q=
X-Received: by 2002:a5d:9698:: with SMTP id m24mr2301116ion.246.1543520855197;
 Thu, 29 Nov 2018 11:47:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com> <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com> <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov> <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov>
In-Reply-To: <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Nov 2018 20:47:22 +0100
Message-ID: <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
Subject: Re: overlayfs access checks on underlying layers
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 29, 2018 at 5:14 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Possibly I misunderstood you, but I don't think we want to copy-up on
> permission denial, as that would still allow the mounter to read/write
> special files or execute regular files to which it would normally be
> denied access, because the copy would inherit the context specified by
> the mounter in the context mount case.  It still represents an
> escalation of privilege for the mounter.  In contrast, the copy-up on
> write behavior does not allow the mounter to do anything it could not do
> already (i.e. read from the lower, write to the upper).

Let's get this straight:  when file is copied up, it inherits label
from context=, not from label of lower file?

Next question: permission to change metadata is tied to permission to
open?  Is it possible that open is denied, but metadata can be
changed?

DAC model allows this: metadata change is tied to ownership, not mode
bits.   And different capability flag.

If the same is true for MAC, then the pre-v4.20-rc1 is already
susceptible to the privilege escalation you describe, right?

Thanks,
Miklos
