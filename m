Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57CEC47255
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 12:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E85320722
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 12:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMG6bxIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgEKMt6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 08:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726021AbgEKMt5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 08:49:57 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B641EC061A0C
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 05:49:57 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id b18so14945740oic.6
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 05:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEH4xTTzx2jVLTnERJW5CWimRyRoR/LpPsbjHVxYLx8=;
        b=mMG6bxIklb33w67un/M91qCNHOT4dGrTx6b43LGKEFNYgubgMOcV5FjHshL03rYqIG
         PRfy87LnmjffQjOHKjmfEX6/bVpLzjycQsnlzEZdSqtFHw7l81vZfIBS34zKYwINMS9b
         DD8+nYUrQ+rCNGbfhZjvSzNMTSeQHRnHh/Ct2NeZ0vzdWm+pRkX3yQX7o+iE9DTDAiJs
         ETGIeg6CWk2qzvD5cVNXY00n3fqaG4MIhM3cxrNItvf58Zgkm/q5o+TQXoSna4cFcjsr
         foixnQ6v6XAUixNJlWSyGdGS6l4QBZayZP5FgW9EcXpcyEXnBZja37oY8kFzCA45q0Q/
         3QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEH4xTTzx2jVLTnERJW5CWimRyRoR/LpPsbjHVxYLx8=;
        b=GhhV91vLdk/R9VP/fcCJE70Pq1h32MTUcP2B20zlsWy3sbXU+nbpg+6Po7RCNwz6dh
         y8co0sr/XbLJx0u0FKZCH1lCbgKWXw98KJgVOSVjiWenWayszvOg7inlwD2QWQwRRwR8
         Ylq2wMtB0F64jlHBW2mgEGV2xLLTwldZoLteOSjWPuNYRidjYFO+1vNAiLXPUTimoarN
         euZa1RN40ifN3lWfhUJvrVS2dwKH5245Vay2k32Ax22/bSfCYyhbB5FPeD6ZKBsKfSX8
         dQq1vmMGL8Qcwxk71hCLRGUV+XTkISz0w4EpomnpXRm5DDeXCBOF0vjeZC7IlzLEh81n
         4C1g==
X-Gm-Message-State: AGi0PuZwbsG5QZ0ij/9No2Y2M0N1t6sVXFvDVpz8JSgUAqj2E7u32ZA5
        VV7I0Ux+g2lULK5vbCN/4HhqxHmEwQqtC8nsZ5E=
X-Google-Smtp-Source: APiQypKTGRZwBqIoiTZEwgclzvDcQ4OTHxY3XagiU9X8iO9bT7Qqw6pKKOF5MM2jwb4cmeeaJoBZQVef88/CvS0dSF8=
X-Received: by 2002:aca:5e0b:: with SMTP id s11mr18513018oib.160.1589201396553;
 Mon, 11 May 2020 05:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200508193721.29283-1-stephen.smalley.work@gmail.com> <CAFqZXNt+MWnELtqZh9V2ZbOv+1+wUZ4jdCikG3LnPVYiYeBVuQ@mail.gmail.com>
In-Reply-To: <CAFqZXNt+MWnELtqZh9V2ZbOv+1+wUZ4jdCikG3LnPVYiYeBVuQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 11 May 2020 08:49:45 -0400
Message-ID: <CAEjxPJ7mhs+gWEbQ2mdBMs56b_RykFEi7wrsLES902q1gv3=wQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/filesystem: fix quotas_test
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 11, 2020 at 8:05 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, May 8, 2020 at 9:37 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > As per the man page, quotactl(2) expects to be passed a pointer to
> > a 4-byte buffer for Q_GETFMT.  The kernel copies a single u32 value.
> > On Ubuntu, this was detected as a stack smash when running the test.
> > Fix the test program.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  tests/filesystem/quotas_test.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tests/filesystem/quotas_test.c b/tests/filesystem/quotas_test.c
> > index 8359811..1424362 100644
> > --- a/tests/filesystem/quotas_test.c
> > +++ b/tests/filesystem/quotas_test.c
> > @@ -33,7 +33,7 @@ int main(int argc, char *argv[])
> >         int opt, result, qcmd, save_err, test_id = geteuid();
> >         char *context, *src = NULL, *tgt = NULL;
> >         bool verbose = false;
> > -       char fmt_buf[2];
> > +       unsigned int fmtval;
>
> I wish we could use something like uint32_t here to make the size
> explicit, but that's a C99 thing... OTOH the binder test code already
> happily uses C99 stuff, so I'm not sure how to best handle this...
> (Add -std=c99 to CFLAGS? Just use <stdint.h> and assume the compiler
> has it? Avoid using C99 library features?)

I'll add stdint.h and use uint32_t.  We already use the fixed-size
types in a couple other tests and in the userspace.
