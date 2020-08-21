Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E9CC433E3
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 12:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67789207DA
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 12:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO9JcizH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgHUMWW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgHUMWO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 08:22:14 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0504C061385
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 05:22:13 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v6so1377416ota.13
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=feCg6eesOCLfL9hzAdr4FD6W9c2IUMKaE2okGgGzLQk=;
        b=aO9JcizHJf6iUW1Yf67ymFO5g1E7D0aytS8OAcY1fk0dWMENCQ9uDDuYoUtZr6VDZz
         bdnyTzp1F5mp67M9O7kwEMQyHzuEenOOk3iDblKMuK0VqsfxTP8D5aee/Vb7BvTONp0+
         yNCzcQdwM/oi5KFJEI55pxXQpcMELLGCUzfqFvJjN2R0NDlxilj+oFY46SjayWdZIfVn
         q3Ca3ho0JAU85YISyfDOI8ObyKVKKLBPRogkvsnZ6u+O03o/SpuHbbt76I0qbhSaZHJ0
         oZg8YnyAZGxl2UIyw01TkEO/xARG9UUWfop/R9cQF/eYVPw3g5ZZGVNm/n3PvzVRs2tt
         bjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=feCg6eesOCLfL9hzAdr4FD6W9c2IUMKaE2okGgGzLQk=;
        b=RxG+PuVXXBLPToq1utz2B5tQl7AoLSyktXGKHK/67ZzuqK6EYTOMRJw2RNt0nvtDJ9
         qlYmFVSjd3dSJTXw7/hmSlMTpRjwDnfrww+5jF2vNRgUfsU167w0Fypk5V1+oEUgjC4/
         BmGXC3dAMi/LU6YlhXA0m/NzhS3jGyPl3wbNAFJvWjWWKrIftyesp44J8SrJqcQrLaGI
         qxPoWhfrSgFFOCv5airG4/Z16Cc858d8UQ448Cxb5KJcJ3N3W1Vfb8bhsRBaDXpHoJik
         UQCaF5Ll423DwOOkwF19GXz7OA/C97/bQefc0k3Z9uix/jwoTKuDgLSeAgn/xx/5GXNA
         C3WA==
X-Gm-Message-State: AOAM53010yPQk6wTuB/7VNHeRqJsEXVAUg4k0mYD45sLOuPYCOeYkja5
        jGYN70BN/Zaz/ULbzvQGiEoC0QjwALMCDrn0J4wy7OxZAUg=
X-Google-Smtp-Source: ABdhPJxLLkEdbkOmbNb0R/l2FxFxDchbJtf4W7QOSd9gAidRrXNioPkSLu64nuI2woSogDOk4Y77x84kIqWGXhiqCAs=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr1636329otr.89.1598012533177;
 Fri, 21 Aug 2020 05:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200820141850.60244-1-stephen.smalley.work@gmail.com> <CAFqZXNupb9Pk636Q=DB7zmRykdetWA0Ng7rh8KNS4f8QUpSLqg@mail.gmail.com>
In-Reply-To: <CAFqZXNupb9Pk636Q=DB7zmRykdetWA0Ng7rh8KNS4f8QUpSLqg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 21 Aug 2020 08:22:02 -0400
Message-ID: <CAEjxPJ5NhStOyzA9ea4HoGDAj1Y93T=f5iqdpbB8K_-kh3Ck+w@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: enable proper lockdep checking for policy
 rcu access
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        peter enderborg <peter.enderborg@sony.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 21, 2020 at 4:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Aug 20, 2020 at 4:19 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > In the previous change to convert the policy rwlock to RCU,
> > the update code was using rcu_dereference_check(..., 1) with
> > a comment to explain why it was safe without taking rcu_read_lock()
> > since the mutex used to provide exclusion was taken at a higher
> > level in selinuxfs.  This change passes the mutex down to the
> > necessary functions and replaces rcu_dereference_check(..., 1)
> > with rcu_dereference_protected(..., lockdep_is_held(mutex)) so
> > that lockdep checking is correctly applied and the dependency
> > is made explicit in the code rather than relying on comments.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > This is relative to the convert policy read-write lock to RCU patch,
> > https://patchwork.kernel.org/patch/11724997/.
> >
> >  security/selinux/include/conditional.h |  3 +-
> >  security/selinux/include/security.h    |  6 ++--
> >  security/selinux/selinuxfs.c           | 12 ++++---
> >  security/selinux/ss/services.c         | 45 ++++++++------------------
> >  4 files changed, 26 insertions(+), 40 deletions(-)
>
> Thanks for trying this out! I indeed like it more this way. The only
> thing I'd suggest is to perhaps name the mutex argument a little more
> descriptively, e.g. "check_mutex" or "rcu_mutex". I understand it'll
> make it harder to wrap some of the long lines, but I tend to think
> it's worth it in this case.

I considered calling it policy_mutex but wasn't sure it was
necessary/worthwhile and also thought it might be confusing (obvious
question becomes why isn't that mutex part of struct selinux_policy,
but that's a layering thing).  I'll wait to see what name Paul prefers
before spinning another patch.

> Speaking about wrapping lines... I noticed only now that in this and
> earlier patches you align wrapped argument lists only by tabs (without
> extra spaces to align to the first argument). I'm not sure what is the
> preferred kernel style in this case, but I personally find the finely
> aligned argument lists much nicer to read (and I have always been
> aligning them like this in my patches). Obviously, I can't enforce my
> preferred style here, but I thought I'd raise this, since I had the
> impression we were trying to follow this style previously for new code
> (could be just confirmation bias on my part, though) and it might not
> have been your intention to change it (changed editor/settings?).

I'm using the emacs mode settings from
Documentation/process/codingstyle.rst.  I don't see anything in the
coding style document to suggest use of extra spaces for aligned
argument lists; if anything use of spaces rather than tabs for
indentation seems discouraged.  I don't really care either way but
would like editor settings to ensure consistency.
