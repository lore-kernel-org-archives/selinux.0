Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E30C433E5
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 16:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393AA2053B
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 16:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5LhnhZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgG1QCb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731270AbgG1QC0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 12:02:26 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4A4C0619D2
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 09:02:25 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id s20so10457359vsq.5
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 09:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BWgk9dNeTI7P5Harbraq661vRoSXP3YNIUIGuCS2xQs=;
        b=Q5LhnhZsWYW2J7hzozGLPrvuwJvn6C3rRrmPX5F+uYYdEqmdPbgTr9v8m7SC3Jsc2r
         1XMUIyN6C64/Pzndv21km5JEt/aDywOOug9ONBPrfDTnfrYkM/RtFh5zuk+nGnxCtH9i
         aMosLGf8G1NTsyRDOkOETebByHSpd5RLUSOxfPc8KmK9H0TjxF9VZwHEV2v6cqt/6S55
         fodnl55bx2704i+Qdskcb2JXCLwrfU4lLVK8EBJubXu3g4Gb+poN4PbXGEs3Bje2ACMD
         BGXEUrFAZ2TNJI8M9A0/TeLWeC5Hpzo33DHSMsRBWVGsfljM07pd7+y6fRLMEAoqzQn9
         rfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BWgk9dNeTI7P5Harbraq661vRoSXP3YNIUIGuCS2xQs=;
        b=VS74Nzei2snTUNDuAdmo5OqoUPGG4l9uag0Gi9+YWno3sb3w5jqF6jDEnQEmt7dPbE
         c4pkx0CxXSZg+vNHpzLkJwJUigznbPm38sI7TPS1evgRSD5C3oNfb2+YFb7m6hECJR8V
         DQuG277sYbIoxCVZh9mq+/iAkDnyhB1byyeTuimTW0UWTHXhVsalLiy/2Y2Hnvp95uF7
         oAxd00VCu0lEoXYOOWByL2WhRa6le4fSFTyl95bB5pSTC4ev2HpPmoxYQxP85aVE1Hr9
         Y0uUhHuqQ2EZYIRkXF8ReQYjEEQ2nDRwfuNGMUotsYBI6hcXI/YQD4i1JJ0nK0/0Uq/n
         4JWg==
X-Gm-Message-State: AOAM532gM8+g0ChPfClw4JgrfkRdijaBcnfENJZkwG5I4wygPl10/wAy
        gEuQZkY42uBcsKfJAHJeJE1XEovkzDJ4mPddHFc2kw==
X-Google-Smtp-Source: ABdhPJyCzVnvJQHXogDaDGiJt+f1Dgl8tBnFZtpwzft/t9n/trKAgjWy6YSMN9JlG/KJ3xDzfiYjS19/XRCWU5VVh2M=
X-Received: by 2002:a67:b601:: with SMTP id d1mr19852614vsm.46.1595952144353;
 Tue, 28 Jul 2020 09:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com> <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
 <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
 <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com> <CAHC9VhT1sGSpfCKojbKR+O2Hf_h+wnKnBwwSo09CbFaCYLcOHA@mail.gmail.com>
In-Reply-To: <CAHC9VhT1sGSpfCKojbKR+O2Hf_h+wnKnBwwSo09CbFaCYLcOHA@mail.gmail.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Tue, 28 Jul 2020 18:02:07 +0200
Message-ID: <CA+zpnLecz_gvXYnrwNGW8SLaJsu==M_n9MuJgjqX9nPJtuTZBg@mail.gmail.com>
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 28, 2020 at 5:12 PM Paul Moore <paul@paul-moore.com> wrote:
> Perhaps it would be helpful if you provided an example of how one
> would be expected to use this new tracepoint?  That would help put
> things in the proper perspective.

The best example is the one I provided in the commit message, that is
using perf (or a perf equivalent), to hook onto that tracepoint.

> Well, to be honest, the very nature of this tracepoint is duplicating
> the AVC audit record with a focus on using perf to establish a full
> backtrace at the expense of reduced information.  At least that is how
> it appears to me.

I see both methods as complementary. By default, the kernel itself can
do some reporting (i.e avc message) on which process triggered the
denial, what was the context, etc. This is useful even in production
and doesn't require any extra tooling.
The case for adding this tracepoint can be seen as advanced debugging.
That is, once an avc denial has been confirmed, a developer can use
this tracepoint to surface the userland stacktrace. It requires more
userland tools and symbols on the userland binaries.
