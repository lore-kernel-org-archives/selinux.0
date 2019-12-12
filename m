Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444D2C2D0C9
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 11:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC8020663
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 11:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOuenkUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfLLLsh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:48:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21894 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726492AbfLLLsh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 06:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576151316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DEKf06qzV7w/c1Lssi+ihS+pe3n54hW/9SP5KebYMMc=;
        b=jOuenkUtpspHRZxVQJNrTS2HobyOdTj8MV9es/Jb0tcT2DTQuYDpaeGtdRHe+4GHrBXUUD
        ZpBOeldmg2RHrk44VkgxX6QUt8rW75XFiMMTNHNCu5FsTNTqQoFElF1ycMxVsp8iLrGlKI
        0esoc+ya25viECbvk8xBroSx0+q5I8c=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-ONxyuMoLMJu-3IcnHeLrPQ-1; Thu, 12 Dec 2019 06:48:32 -0500
X-MC-Unique: ONxyuMoLMJu-3IcnHeLrPQ-1
Received: by mail-ot1-f72.google.com with SMTP id z7so494860otm.10
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2019 03:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEKf06qzV7w/c1Lssi+ihS+pe3n54hW/9SP5KebYMMc=;
        b=HD9oaCYaWhUwslyfUURkOYE+LEdx2sLXR18y/tFfExQ3hLW8/UktJehZoo35xKUIOB
         61rDb7ueCwNrOmdFVdEguzCZSV4AUT7q/riBSlMoHFfl5172+8CIRXQntkrbWop48lvL
         UiqkOoANYGY0sz4kG94d4qj+kkeK5u6wKMTTb7r2QKfrBxkZPJ6yn3sdO3kxXXUSUbYS
         mUaiGMAm4RYwJKozlUfj5tYCNAB3X4sBIN3ZUmQVROnSwcmEdUZs17+YqUynu2CRnVoz
         1VXnX2zt79ONEZSmq/5iadMf/63izAQNR9Xn14EwlvJaZe8DTgFkWU5Rfpf0KEmVjXmK
         AdNA==
X-Gm-Message-State: APjAAAUnGsp6/UXJK3g1aLjbUIhkKgtb0wlPdCkqJJsKfB5osouYSye9
        rqLfxYryBhoHxArf4UemF1VJ7eTHJsAxZXaxRCiNYmTkGGRQnTvDhIptYC2ZdgO/qabzgylzkOa
        ig59eccyk6jsU47+T2AS/O17MyINDgbe2lQ==
X-Received: by 2002:a05:6830:2154:: with SMTP id r20mr7754435otd.66.1576151312087;
        Thu, 12 Dec 2019 03:48:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZJqci9D7L7Q7rUwlHrdOa6tMvoEXb57bhibA2ri8cO+1qTkfA8q2tSbaV8Ktepe/b8ks5aKfUXcyi2ymuYlA=
X-Received: by 2002:a05:6830:2154:: with SMTP id r20mr7754410otd.66.1576151311830;
 Thu, 12 Dec 2019 03:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
In-Reply-To: <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 Dec 2019 12:48:20 +0100
Message-ID: <CAFqZXNtViuNTGtDwPF0Wra=ykaNN=n2ZO_GuSTOXQo__HhUawg@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 11, 2019 at 3:29 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
> > Instead of deleting the hooks from each list one-by-one (which creates
> > some bad race conditions), allow an LSM to provide a reference to its
> > "enabled" variable and check this variable before calling the hook.
> >
> > As a nice side effect, this allows marking the hooks (and other stuff)
> > __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no longer
> > makes sense, remove it and instead use SECURITY_SELINUX_DISABLE directly
> > for turning on the runtime disable functionality, to emphasize that this
> > is only used by SELinux and is meant to be removed in the future.
>
> Is this fundamentally different/better than adding if (!selinux_enabled)
> return 0; to the beginning of every SELinux hook function?

It saves us from maintaining the invariant that each hook has to begin
with said condition and it avoids one extra indirect jump. Whether
that's a compelling advantage, I don't know...

> And as I
> noted to Casey in the earlier thread, that provides an additional easy
> target to kernel exploit writers for neutering SELinux with a single
> kernel write vulnerability. OTOH, they already have
> selinux_state.enforcing and friends, and this new one would only be if
> SECURITY_SELINUX_DISABLE=y.

I don't think that makes the situation too much worse, but others may
disagree...

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

