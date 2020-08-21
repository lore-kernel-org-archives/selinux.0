Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F8EC433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 08:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F79207DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 08:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUAAVi6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHUIgX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726433AbgHUIgW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 04:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597998980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYb5lE+F4mnJQuoSVKWY9dd6S+qmZNyh4JNUJmZeqjo=;
        b=TUAAVi6VLnfXe02Bc2Tovliprvq1C1OGKBYitG4FsbX0ZyUKJFY/TqI7ECqKqpoMDvj1kQ
        vv5IVV+QBk7ntilPU960aBIOgXO7Yd5Kev216I0kw0Do9HImGv0262xyMNy01mSTUd1NOa
        VM1BkHxm6PoaTLSmWeQcPbMmazZ12fw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-fdnwN1lXPrKe9dCu8RX3nA-1; Fri, 21 Aug 2020 04:36:18 -0400
X-MC-Unique: fdnwN1lXPrKe9dCu8RX3nA-1
Received: by mail-lf1-f71.google.com with SMTP id k1so113740lfm.4
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 01:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYb5lE+F4mnJQuoSVKWY9dd6S+qmZNyh4JNUJmZeqjo=;
        b=gUXGx9BwB5dOX0oURf5Mv/yvfMrtXqIIIqbsGt76kqMBl5WFiZzlYgfmwdorb94u5F
         Xs9gzsyNeY/gEBjmwq9jy3SewfC1dzvBJ4hwYJ3/ekEp2gWFWXtDcuynPcFYDOAbZbIz
         bQjjHzTfcsuGtm21g/5lpbU141gNaZ992RuyULimM/T0nUFYnoH4IzQS3fTFbxOwsp+a
         m2LupJtuCbB5+vMmlJExdiZlRybeQWos9ffcOqxW7wWUWlMGfIJNkbygPckv2f5wXWNi
         00Ww94BvJeJ00w8OR83PgnW7v9IscFjwUIEtO9qni+yNunVh7nVZWsvEu1tCi9uLCAmX
         nqlw==
X-Gm-Message-State: AOAM533MXJFWGtAgNWUhupEGZX46o2izD0YvDZXdHszZJk4WIGa5QQ2r
        Lfuh1K2TKEuZDnpoafSUwGKAQI2ll5jm17hj4YYGcTJZnMCOoC0k0zK5OO/UHwn1zNXgWEjFRCI
        py0Ov7Fxbzm1mQYKhLQbdEynpJeRePYd7rw==
X-Received: by 2002:ac2:4add:: with SMTP id m29mr392266lfp.189.1597998977469;
        Fri, 21 Aug 2020 01:36:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyurriI4aKk2WNLld4ZzenO/llCuogn8VQoWr9xZxd5Z9vfAa9957rQjy+4djPx/X3q92OvCwAjD9gkwZ9Zy18=
X-Received: by 2002:ac2:4add:: with SMTP id m29mr392217lfp.189.1597998975709;
 Fri, 21 Aug 2020 01:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200820141850.60244-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200820141850.60244-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 21 Aug 2020 10:36:04 +0200
Message-ID: <CAFqZXNupb9Pk636Q=DB7zmRykdetWA0Ng7rh8KNS4f8QUpSLqg@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: enable proper lockdep checking for policy
 rcu access
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        peter enderborg <peter.enderborg@sony.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 20, 2020 at 4:19 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> In the previous change to convert the policy rwlock to RCU,
> the update code was using rcu_dereference_check(..., 1) with
> a comment to explain why it was safe without taking rcu_read_lock()
> since the mutex used to provide exclusion was taken at a higher
> level in selinuxfs.  This change passes the mutex down to the
> necessary functions and replaces rcu_dereference_check(..., 1)
> with rcu_dereference_protected(..., lockdep_is_held(mutex)) so
> that lockdep checking is correctly applied and the dependency
> is made explicit in the code rather than relying on comments.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This is relative to the convert policy read-write lock to RCU patch,
> https://patchwork.kernel.org/patch/11724997/.
>
>  security/selinux/include/conditional.h |  3 +-
>  security/selinux/include/security.h    |  6 ++--
>  security/selinux/selinuxfs.c           | 12 ++++---
>  security/selinux/ss/services.c         | 45 ++++++++------------------
>  4 files changed, 26 insertions(+), 40 deletions(-)

Thanks for trying this out! I indeed like it more this way. The only
thing I'd suggest is to perhaps name the mutex argument a little more
descriptively, e.g. "check_mutex" or "rcu_mutex". I understand it'll
make it harder to wrap some of the long lines, but I tend to think
it's worth it in this case.

Speaking about wrapping lines... I noticed only now that in this and
earlier patches you align wrapped argument lists only by tabs (without
extra spaces to align to the first argument). I'm not sure what is the
preferred kernel style in this case, but I personally find the finely
aligned argument lists much nicer to read (and I have always been
aligning them like this in my patches). Obviously, I can't enforce my
preferred style here, but I thought I'd raise this, since I had the
impression we were trying to follow this style previously for new code
(could be just confirmation bias on my part, though) and it might not
have been your intention to change it (changed editor/settings?).

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

