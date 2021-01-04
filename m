Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0182C433E0
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 15:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A675A22473
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 15:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbhADPwN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 10:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbhADPwN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 10:52:13 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BB9C061574
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 07:51:32 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q25so32558811oij.10
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 07:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6e9Ihwv5Mo2el3U+CSbMHFx7zIVES7S5Keg/POhYD0=;
        b=M4nwvucw1AnFVoODElUJb1MFNHSFI0u6W69/8VZcP2KnT9D2Nd3x8x1Ee3v8nIG+yc
         HWyHZ1BcZCwe4OiwAQ6GD4MpYp54bvaPy9hxdaj7t094Ur2QnSa2UUaHFDBXmZ2clJ3h
         BEH+XUwKKWTDNT78Vt/oROENNbNcw8iGCCQ3Dn0z34PqNTjzZtXLIAJ7gV1kLfPOK5qQ
         k2i0eUJtpo9TF5R2Uty3vAYkQVpMkdj3w74MnplkFpeHeA6FPSo6jhlB44CXadjiqwzA
         +qDMHkzCkFKxyNj/Y6duwL0LUS/W9oACtVMW/DKIYrLdsNk3CWBIWyRsRRbMzdlbqhX8
         Zv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6e9Ihwv5Mo2el3U+CSbMHFx7zIVES7S5Keg/POhYD0=;
        b=dmK0LF7C2wJ8GareYpHNReSlRCIF3O3iKRW+5jkj3bNlaiaVDxf7FpcPXURjJWTNSS
         ylKnbx6OVfd6QK32ZIgNJRX2/kF0GvcvwJ6OCua0uYk5XTe2gNme6gEZ72V8x08dI0JI
         MkZ59KRIHtFSLkqDydlZqv1txYXVXDzoQn92ZscFVQx32O5/+UF5uy+OgM+WLex7OsW0
         Ap7sR4p03QAY7lbu+7QFDtgj2a3gM9Bnytj5WGAGf4WbiIDELPn9wT3wr2QeiRaccBpc
         9Yz61xN15xbPRxPtxqiCQDBk3apeFyLahViEtS7IWSMnpWEsrkpRUphxGpSN04BYOM6Z
         zLoA==
X-Gm-Message-State: AOAM531d4a7IvMAUKijIHZKJGgi5C5FqYx2vkAiBINODJdagvoUXailm
        Yhys9Zsz95SxkPeqWP0eBdBTv/iOjmUtTJIRb8hXiQso
X-Google-Smtp-Source: ABdhPJwoMOjBH1UgGkemf6lC3kfUcBsAqNbyyB4nUfs7pvOAJv8dH9viDG2hhWAbMpPHak283giN0m5YldfpwJjB5Pk=
X-Received: by 2002:a05:6808:49:: with SMTP id v9mr18588895oic.138.1609775492283;
 Mon, 04 Jan 2021 07:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org> <CAP+JOzQBQ--xZWukZcZTsZ1Eq01Fk4xCa66AotYCHKxZEG-QgQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQBQ--xZWukZcZTsZ1Eq01Fk4xCa66AotYCHKxZEG-QgQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Jan 2021 10:51:21 -0500
Message-ID: <CAP+JOzQc3yXczhk5JfUrr+6rFe3AXis+yJAukCFbz=aQotriQQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] libsepol: do not decode out-of-bound rolebounds
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000062e4ea05b81510f2"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--00000000000062e4ea05b81510f2
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 4, 2021 at 10:48 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Dec 30, 2020 at 5:11 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > While fuzzing /usr/libexec/hll/pp, a policy module was generated with a
> > role->bounds larger that the number of roles in the policy.
> >
> > This issue has been found while fuzzing hll/pp with the American Fuzzy
> > Lop.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  libsepol/src/module_to_cil.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> > index a87bc15e7610..c99790eb76e7 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -2165,7 +2165,9 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
> >                         }
> >                 }
> >
> > -               if (role->bounds > 0) {
> > +               if (role->bounds >= pdb->p_roles.nprim) {
> > +                       log_err("Warning: role %s defines an out-of-bound rolebounds", key);
> > +               } else if (role->bounds > 0) {
> >                         cil_println(indent, "(rolebounds %s %s)", key, pdb->p_role_val_to_name[role->bounds - 1]);
> >                 }
> >                 break;
> > --
> > 2.29.2
> >
>
> There are other places where the bounds value is used as an index and
> type datums also have bounds that are used in the same way.
>
> Correct me if I am wrong, but I think that this can only occur by
> crafting a binary (and not as a result of a policy being compiled). So
> I think the correct place for the check would be when the binary file
> is read.
>
> I'll have to test to be sure, but I think the attached patch might do
> the proper checking.
>

Oops, that patch had typos. This one.

> Jim

--00000000000062e4ea05b81510f2
Content-Type: text/x-patch; charset="US-ASCII"; name="bounds.patch"
Content-Disposition: attachment; filename="bounds.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kjiqr8yk0>
X-Attachment-Id: f_kjiqr8yk0

ZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9wb2xpY3lkYi5jIGIvbGlic2Vwb2wvc3JjL3BvbGlj
eWRiLmMKaW5kZXggY2U4ZjNhZDcuLjZmYWFhYTU4IDEwMDY0NAotLS0gYS9saWJzZXBvbC9zcmMv
cG9saWN5ZGIuYworKysgYi9saWJzZXBvbC9zcmMvcG9saWN5ZGIuYwpAQCAtMTAzMCw2ICsxMDMw
LDggQEAgc3RhdGljIGludCByb2xlX2luZGV4KGhhc2h0YWJfa2V5X3Qga2V5LCBoYXNodGFiX2Rh
dHVtX3QgZGF0dW0sIHZvaWQgKmRhdGFwKQogCQlyZXR1cm4gLUVJTlZBTDsKIAlpZiAocC0+cF9y
b2xlX3ZhbF90b19uYW1lW3JvbGUtPnMudmFsdWUgLSAxXSAhPSBOVUxMKQogCQlyZXR1cm4gLUVJ
TlZBTDsKKwlpZiAocm9sZS0+Ym91bmRzID4gcC0+cF9yb2xlcy5ucHJpbSkKKwkJcmV0dXJuIC1F
SU5WQUw7CiAJcC0+cF9yb2xlX3ZhbF90b19uYW1lW3JvbGUtPnMudmFsdWUgLSAxXSA9IChjaGFy
ICopa2V5OwogCXAtPnJvbGVfdmFsX3RvX3N0cnVjdFtyb2xlLT5zLnZhbHVlIC0gMV0gPSByb2xl
OwogCkBAIC0xMDQ5LDYgKzEwNTEsOCBAQCBzdGF0aWMgaW50IHR5cGVfaW5kZXgoaGFzaHRhYl9r
ZXlfdCBrZXksIGhhc2h0YWJfZGF0dW1fdCBkYXR1bSwgdm9pZCAqZGF0YXApCiAJCQlyZXR1cm4g
LUVJTlZBTDsKIAkJaWYgKHAtPnBfdHlwZV92YWxfdG9fbmFtZVt0eXBkYXR1bS0+cy52YWx1ZSAt
IDFdICE9IE5VTEwpCiAJCQlyZXR1cm4gLUVJTlZBTDsKKwkJaWYgKHR5cGRhdHVtLT5ib3VuZHMg
PiBwLT5wX3R5cGVzLm5wcmltKQorCQkJcmV0dXJuIC1FSU5WQUw7CiAJCXAtPnBfdHlwZV92YWxf
dG9fbmFtZVt0eXBkYXR1bS0+cy52YWx1ZSAtIDFdID0gKGNoYXIgKilrZXk7CiAJCXAtPnR5cGVf
dmFsX3RvX3N0cnVjdFt0eXBkYXR1bS0+cy52YWx1ZSAtIDFdID0gdHlwZGF0dW07CiAJfQo=
--00000000000062e4ea05b81510f2--
