Return-Path: <SRS0=NQFP=7X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494F9C433DF
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AC420760
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 13:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbm9DdL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgFJNkc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJNkb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 09:40:31 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82193C03E96B
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 06:40:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id u23so1693943otq.10
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8VRqXVpIhoDHWR0FPTfNpNNC7pCjSYya4qjzJAWWVs4=;
        b=kbm9DdL0sfa3PsdbinEEykYO0kadYlkE6GM62uefi0WNl5edu8HCfcpUqPgntiss65
         JO1COx1v+SmI/hfSwFqQeRq8pY+nMOe+prj5t3ecK9N989dqFWto3XbmmVl9nshc4dBv
         +fKtEqoHFWtdgX6X7j7hxaGzxhyrxBsNqks9uM9/Q4i6+/pg6t/uZCrA2BTtS0oISFdh
         L+QZBhY6dklPPdt8bhXj8W6U90QAQ0waIL0K45qmkSljnbYdW1JTMPS819jY3Xo8fvth
         9qOLpFLxgIKSf9y2MD+Ahgl0PT5ROF+yn8/wTY+aUatvtB6Tu1rqW3fnsfb4V8jKyG1A
         Fvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VRqXVpIhoDHWR0FPTfNpNNC7pCjSYya4qjzJAWWVs4=;
        b=LUIhyg+ZVobrkS+5Pq8gLug2CLFedw5wP0qy04MDtTvAWt0xICqz/ZEYiVActRAOqi
         Mm8/l/mkOECxYhcy/SyJKgIoFjXrxxsQoyLzTYnmJX+FGHs6BCg1A+QzMJxJe39K2dJ9
         gjT+PYJ6mXIfxrxVd5Rgb6lN57wPU+mTB7NhPbvevHMDjmOYTYgAFUwmBCZ2Mu4y8ZE9
         MQeN+rlzXDNUX9zhKemyEMuEzUU92E14H5UbjyY/nLqTC81rooPtzLX/FL2wmkKPocJu
         AHcCRDLygFP/mXch3mkdGx7OJrqsy2nx36UWTMohM9KuF/Ow6XS00sTzLpzOnppIXMyq
         ZxQw==
X-Gm-Message-State: AOAM530H5x2DMR43+5G6W4Fk1xrF6121Lbq0cBQ0Mwswj0lb6Jyors/D
        mlhZedWrEfq7bMGJpySVg02AD/HIgAVB2uXBHlY8EWxK
X-Google-Smtp-Source: ABdhPJwejOlGggBtYmJ9zv8y5Z8DaVbnNwREUKiBqqrJoUk8khxue0OMDHTs+r7wnTZwNVBQgoAZAGqjJXOWrWK0vuM=
X-Received: by 2002:a05:6830:18da:: with SMTP id v26mr2738024ote.135.1591796429980;
 Wed, 10 Jun 2020 06:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <d3abd210-928e-374f-1e9b-fddfaa203c53@linux.microsoft.com>
 <CAEjxPJ5Gx+g5U4-iXyMjyGxrvSsGa32jvpjY3_PYS_cbToQTKA@mail.gmail.com>
 <CAFqZXNs=UKNaS=xAW-R1v7o9KKR61vRjmv+90V29cG-xzn-bFw@mail.gmail.com>
 <fcb45f43-5814-8d7d-8f66-d770d092f826@linux.microsoft.com>
 <CAEjxPJ61Bec8Hj8TzH-h_tvaWdGAHoR6ZMye2EazYQUViLfCwg@mail.gmail.com> <0947afa1-0fad-c713-074c-1a9a90dacb16@linux.microsoft.com>
In-Reply-To: <0947afa1-0fad-c713-074c-1a9a90dacb16@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 10 Jun 2020 09:40:18 -0400
Message-ID: <CAEjxPJ5hbi-ofMO8knNhwHZqE0M8bO0=5QirVpS4HppAqB0Vhw@mail.gmail.com>
Subject: Re: Race condition during policy load in kernel
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        selinux list <selinux@vger.kernel.org>,
        james.morris@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 8:40 AM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
> I'll start looking into the atomic tree swapover first then.  If that
> goes well, I'll look into moving on to the policy load refactor.

Wanted to check in and see whether you've been able to make any
progress or need any help.
