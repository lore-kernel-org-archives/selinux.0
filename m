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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A405C433E9
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 15:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316282242A
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 15:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbhADPtl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 10:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbhADPtk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 10:49:40 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F741C061574
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 07:49:00 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d8so26403382otq.6
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 07:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyGI8vCgj2cWaz5aoeld9aDh3k9R2NFYGb7AY0GSWNQ=;
        b=SSX8zgcZ2mZiN0E8bwl/e/7jWgVRurxya96JjndbIzkcdGJ4Ts7VVGvlfg35r1s2gP
         sVctr2OP89GdkI4KiSJno3vlLmC7Y5k0V1nv61gffP7Ev1BvgCFCpBS7cPC2pr3RRfY6
         iGATaLqjHI93u4EJHdHO+29GIUxBdL4xkFX667Mkr5mWx0dHGxgEuGOxwvXXmccXja5T
         OIPWeZlXie7RBtHQ65t5a9u1GkPhY31uJqGeXPCIZ8qiG+mXF8Do3+P5TEG4jR9XeZ4c
         Hnqy7GpEZgBoErD99COB6PtJi4L5xiwsPLFuQsPuvP6HP6l7poUyastpYbF+IXu/TZCX
         NFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyGI8vCgj2cWaz5aoeld9aDh3k9R2NFYGb7AY0GSWNQ=;
        b=HQhrWwNhJUgajpC+RXIa8GEaPj+xy6WWPathCE4UYQDpNLOe864ir/Yp/heUA4tXNV
         DpTAT5m4IwqjXSLRSZ1vcBh3uGQM5MXmPQjjbWzPwHUsjxnq6cmOieW6uN7s0Ci9CMdT
         QFhkH96h15wE5A0tVptZl9a6GmodsDhTKN8iU7Cr4tuSrMHp0+8sDXDWyfXmR5WvJcL/
         rfgzyZTVj/KZL0jE86teMLM4W5D2ovVKQVokTBW7EivHY5iPQ+DcRlRIP7cjUTliHOzk
         TdNTByK4hv1ouCbtW/JyMnqtPetemI67fe0G022VZhW/rZhUnmTPK/GPcf+bgmqcf4GT
         Oitg==
X-Gm-Message-State: AOAM530rlcQtYnU9ikuRrhfgAnnANhnnmgEWKXpIELrVZ+BgIionE0lt
        aH7DyQ0+XyRE35/NJKKZJ9aWeYXDu5lzuuL1Eaj4itWa
X-Google-Smtp-Source: ABdhPJwMH7tTizPYxz0QouPWKKNmyeDvQa88/d3i1FN3zOw+F14I5+QXFb3hyBvYGNLmLzxYD0DIm7EW2decjW4YlHE=
X-Received: by 2002:a9d:27a7:: with SMTP id c36mr52641676otb.59.1609775339885;
 Mon, 04 Jan 2021 07:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
In-Reply-To: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Jan 2021 10:48:48 -0500
Message-ID: <CAP+JOzQBQ--xZWukZcZTsZ1Eq01Fk4xCa66AotYCHKxZEG-QgQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] libsepol: do not decode out-of-bound rolebounds
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000004d76a005b81507ba"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--0000000000004d76a005b81507ba
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 30, 2020 at 5:11 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> While fuzzing /usr/libexec/hll/pp, a policy module was generated with a
> role->bounds larger that the number of roles in the policy.
>
> This issue has been found while fuzzing hll/pp with the American Fuzzy
> Lop.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/module_to_cil.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index a87bc15e7610..c99790eb76e7 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2165,7 +2165,9 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
>                         }
>                 }
>
> -               if (role->bounds > 0) {
> +               if (role->bounds >= pdb->p_roles.nprim) {
> +                       log_err("Warning: role %s defines an out-of-bound rolebounds", key);
> +               } else if (role->bounds > 0) {
>                         cil_println(indent, "(rolebounds %s %s)", key, pdb->p_role_val_to_name[role->bounds - 1]);
>                 }
>                 break;
> --
> 2.29.2
>

There are other places where the bounds value is used as an index and
type datums also have bounds that are used in the same way.

Correct me if I am wrong, but I think that this can only occur by
crafting a binary (and not as a result of a policy being compiled). So
I think the correct place for the check would be when the binary file
is read.

I'll have to test to be sure, but I think the attached patch might do
the proper checking.

Jim

--0000000000004d76a005b81507ba
Content-Type: text/x-patch; charset="US-ASCII"; name="bounds.patch"
Content-Disposition: attachment; filename="bounds.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kjiqnmnz0>
X-Attachment-Id: f_kjiqnmnz0

ZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9wb2xpY3lkYi5jIGIvbGlic2Vwb2wvc3JjL3BvbGlj
eWRiLmMKaW5kZXggY2U4ZjNhZDcuLmY4ODM5NTM5IDEwMDY0NAotLS0gYS9saWJzZXBvbC9zcmMv
cG9saWN5ZGIuYworKysgYi9saWJzZXBvbC9zcmMvcG9saWN5ZGIuYwpAQCAtMTAzMCw2ICsxMDMw
LDggQEAgc3RhdGljIGludCByb2xlX2luZGV4KGhhc2h0YWJfa2V5X3Qga2V5LCBoYXNodGFiX2Rh
dHVtX3QgZGF0dW0sIHZvaWQgKmRhdGFwKQogCQlyZXR1cm4gLUVJTlZBTDsKIAlpZiAocC0+cF9y
b2xlX3ZhbF90b19uYW1lW3JvbGUtPnMudmFsdWUgLSAxXSAhPSBOVUxMKQogCQlyZXR1cm4gLUVJ
TlZBTDsKKwlpZiAocm9sZS0+Ym91bmRzID4gcC0+cF9yb2xlcy5ucHJpbSkKKwkJcmV0dXJuIF9F
SU5WQUw7CiAJcC0+cF9yb2xlX3ZhbF90b19uYW1lW3JvbGUtPnMudmFsdWUgLSAxXSA9IChjaGFy
ICopa2V5OwogCXAtPnJvbGVfdmFsX3RvX3N0cnVjdFtyb2xlLT5zLnZhbHVlIC0gMV0gPSByb2xl
OwogCkBAIC0xMDQ5LDYgKzEwNTEsOCBAQCBzdGF0aWMgaW50IHR5cGVfaW5kZXgoaGFzaHRhYl9r
ZXlfdCBrZXksIGhhc2h0YWJfZGF0dW1fdCBkYXR1bSwgdm9pZCAqZGF0YXApCiAJCQlyZXR1cm4g
LUVJTlZBTDsKIAkJaWYgKHAtPnBfdHlwZV92YWxfdG9fbmFtZVt0eXBkYXR1bS0+cy52YWx1ZSAt
IDFdICE9IE5VTEwpCiAJCQlyZXR1cm4gLUVJTlZBTDsKKwkJaWYgKHR5cGVkYXR1bS0+Ym91bmRz
ID4gcC0+cF90eXBlcy5ucHJpbSkKKwkJCXJldHVybiAtRUlOVkFMOwogCQlwLT5wX3R5cGVfdmFs
X3RvX25hbWVbdHlwZGF0dW0tPnMudmFsdWUgLSAxXSA9IChjaGFyICopa2V5OwogCQlwLT50eXBl
X3ZhbF90b19zdHJ1Y3RbdHlwZGF0dW0tPnMudmFsdWUgLSAxXSA9IHR5cGRhdHVtOwogCX0K
--0000000000004d76a005b81507ba--
