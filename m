Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB07C433E0
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 18:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09AA206C1
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 18:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9fQ7XeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgGUSXE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUSXE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 14:23:04 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783EC061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 11:23:03 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id h17so18075489oie.3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=is8o45EC1QuSoC3CMi3HVfOFGfXAAEBbRhSTMEoysTg=;
        b=X9fQ7XeBQ52O8Zne+NwX/YLtxm1NuJ1JGuhl6rb6LXClTV9cF7sfrV7/D/f0y/vZyF
         seMttQpiEoVNUmr8nAOCa/FzXqjHOVXiA+4+QtkjCT1g7fo+rC211Sv6zLxHCYVwgwiX
         SAYoRuzxn8SucVcMf6ytXwUxC5LMM/T0wkLB4wpsQWjFAJpZu7blpYOzSo7IeFRAQQVe
         3J739LO0SuH9eM2avl141vvGWS9/yNsrGe+tko6xiSUqeeLdCNgjSfq9XH6NgEfoOEBv
         Q5AxlE/rKjULrIBAyOANc3sKX4hc8re+BbsXM3EtlY85IPBR1ncLriAQz2bWWeHyqD/r
         MY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=is8o45EC1QuSoC3CMi3HVfOFGfXAAEBbRhSTMEoysTg=;
        b=WJpvpSalHrY2naPTM1pnjvIDy0mDcH5bQWxokBxZj1oVb0dkShTGYJ2X/yRgUkgE9r
         ejluH8iuvl1l5ItPT4LD7s2Wazqf2k2jLpbzODw3mYAch4/uSn4R43GoQ2cDwKvwQR26
         eJqAkghogdgKoBLcMYEqAipxrIvboB3XIuaHUWr1GFFcCST2z/Ny5pBexPU1hKjEyWaI
         xa4b81Eu4oU0Lr5sPJMInqxH/cWPNK2cq+ZN1D8e245UU4kDcSydlAOjxBqtrTLtOcoF
         djjwo7p/7umxTELwTGxZNqvPoVBex6/j8p5PqbL0DjSiXvswYav15JiFUoVngf7KWG94
         HBMw==
X-Gm-Message-State: AOAM5319f9MugbRNSDmV8BvFlVE7nn3VpJ4dmnIohRIgBpHyP0JXYF0q
        sKgg20u3Roj6WSOIilKecRcofafIlqfjzVXmWBA=
X-Google-Smtp-Source: ABdhPJzs4O0wWv8cxcjEB6ZKA2o5DyEZ8dqNOw45htP05KgB7qr1+oXfPSNT+GgzBjR8KjHZmvfMj95Kg2UoPXFguFs=
X-Received: by 2002:aca:c4cc:: with SMTP id u195mr3916773oif.160.1595355783128;
 Tue, 21 Jul 2020 11:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200719103506.865962-1-omosnace@redhat.com> <20200719103506.865962-2-omosnace@redhat.com>
In-Reply-To: <20200719103506.865962-2-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 21 Jul 2020 14:22:52 -0400
Message-ID: <CAEjxPJ6jiWr5ZHWLqirAmu+9R=_qECyTrXPqtKSqwMeEdHZFQg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] libsepol,checkpolicy: optimize storage of filename transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 19, 2020 at 6:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> In preparation to support a new policy format with a more optimal
> representation of filename transition rules, this patch applies an
> equivalent change from kernel commit c3a276111ea2 ("selinux: optimize
> storage of filename transitions").
>
> See the kernel commit's description [1] for the rationale behind this
> representation. This change doesn't bring any measurable difference of
> policy build performance (semodule -B) on Fedora.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index c6733fa4..01a90438 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -3388,40 +3387,21 @@ int define_filename_trans(void)
<snip>
> +                               dup_name = NULL;
> +                               rc = policydb_filetrans_insert(
> +                                       policydbp, s+1, t+1, c+1, name,
> +                                       &dup_name, otype, NULL
> +                               );
> +                               free(dup_name);

The dup_name / name_alloc handling seems rather odd.  In every caller
except one you follow the pattern above, where we set it to NULL, call
policydb_filetrans_insert, and then free it immediately.  I'm not sure
why you are doing it this way.
