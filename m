Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D170C433F5
	for <selinux@archiver.kernel.org>; Wed,  2 Mar 2022 18:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiCBSv3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiCBSv2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Mar 2022 13:51:28 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCA0C5D84
        for <selinux@vger.kernel.org>; Wed,  2 Mar 2022 10:50:45 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id u17-20020a056830231100b005ad13358af9so2443235ote.11
        for <selinux@vger.kernel.org>; Wed, 02 Mar 2022 10:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a6EJF04XZ29uWSCDy8zvR4rbQyA1Ds2/JsDQnSDfZFc=;
        b=NyyMwoIUYjlloaRxtba9LoNXU+GO61VGHCVPMzJGf5XFpApa5RDATzhd/KMK1p818q
         0tFg2uRD1dPTITpGBBORFJIW8btkjL5Mh77a2w9uhgKnLmklWufWBLpba1laeXfgKMdQ
         2NLFS3FGsL2ngQtLp1jqQ2TYbWJ6fIdWHiQaWK9EyDBoL2qnGjf+BaMYsOczcZkiLh08
         WTLlCPE0rTSx/IraZUnB79zLdyl/YM8Y0vjDlTXEGHgaXqJdTyli/hD3YBLuJpg9x2eT
         pj+LwmSkkyKp4KnFfXUWM/tupiet71kd1OdnWdSZQaj7iJwXzuR5A2FVmJbA8xdXcHkD
         3TPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a6EJF04XZ29uWSCDy8zvR4rbQyA1Ds2/JsDQnSDfZFc=;
        b=QyOWazAIJdj2Hpf8aAHB5sAgP+5z7Nyt0FPkk+QLGEzhHXuE1RGsQ8zrokpxfo1tLl
         0VJDEcmmE65ZOLNELpDd/xS1MBkEvcivou48JFHHjN6caQwGGeSG/LBsW6l0f22PbcuR
         tgr2U+SM+iWjXAaB0Mha4oM8IxYewlRRjnTya6ttiAYAnjBabpRWzIo3Jg5+/fBSYU7D
         Bo2U8qwrHrFQX4ohxhsSsCAE3IRzpHpBcnf35DomWGeRIGu9XpkSTuC3/JSaR+AxvnsH
         4Tu+1TfhKFNvKSUr0W8t7T7nEMNNn5eVST39E9mngITNN4uwBnvEJdIRwNoUUjTbC9yr
         JACw==
X-Gm-Message-State: AOAM5334vm2JCQFn+KTdxD4aMFobN7Z7/S0NSX+7Ql/EMa1qO7rH9ZXM
        EJidhFnIBv8D+CDgkWmFfBRIK7Hl5TJI/eA/KYojkPBLlz8=
X-Google-Smtp-Source: ABdhPJzbxcRTSuVAP0SM79koeEhA92E26vyAz+ANXXWYNNKpRjuoPQgPvEiTSjAYRT7MEpzY8TriRXbGis6qRkKjs5Q=
X-Received: by 2002:a9d:6c8:0:b0:5ad:5a1e:f79d with SMTP id
 66-20020a9d06c8000000b005ad5a1ef79dmr16560031otx.154.1646247044382; Wed, 02
 Mar 2022 10:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20220302101415.431161-1-plautrba@redhat.com>
In-Reply-To: <20220302101415.431161-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 2 Mar 2022 13:50:33 -0500
Message-ID: <CAP+JOzRs3m1HcKGLCcQuxaTyqLNSikneHpqGnAzmegQuy7q-yw@mail.gmail.com>
Subject: Re: [PATCH] semanage-fcontext.8: Drop extra )s after FILE_SPEC
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 2, 2022 at 7:35 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/340
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/semanage/semanage-fcontext.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semana=
ge-fcontext.8
> index 49635ba788f7..1ebf085faed8 100644
> --- a/python/semanage/semanage-fcontext.8
> +++ b/python/semanage/semanage-fcontext.8
> @@ -3,7 +3,7 @@
>  semanage\-fcontext \- SELinux Policy Management file context tool
>
>  .SH "SYNOPSIS"
> -.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYPE =
\-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ) | \-\-delete ( \-t=
 TYPE \-f FTYPE | \-e EQUAL ) FILE_SPEC ) | \-\-deleteall  | \-\-extract  |=
 \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-=
e EQUAL ) FILE_SPEC ) ]
> +.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYPE =
\-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC | \-\-delete ( \-t T=
YPE \-f FTYPE | \-e EQUAL ) FILE_SPEC | \-\-deleteall  | \-\-extract  | \-\=
-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQ=
UAL ) FILE_SPEC ]
>
>  .SH "DESCRIPTION"
>  semanage is used to configure certain elements of
> --
> 2.35.1
>
