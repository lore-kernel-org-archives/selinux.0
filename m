Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EDEC433EF
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 17:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347517AbiC3RgA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349330AbiC3Rf7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 13:35:59 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA190CD0
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 10:34:12 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so15372029otj.10
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DAZW+k5xUtjQ5aVFwcphIg1GlF4c06mlNzxsXunQSGI=;
        b=jmQQbPAlj8cvyNpaB5bkN/2BlwAWsod/IRO9+fltIsiqW9atmLut2BbWY0nxW7FfIi
         Xw4n2Y0DUt78fF+Lddfs+sB87SwWPSiZ29c6u06XmLCJp+NBqJlhtMiMAYTfsDvrxrtC
         oDQHFU2pJc3fHpDo4k6YkdmpS7i2W8xd0Jwb/6s9M3iOrLgi71MkiOSJnB88qOrh9yfv
         4hmBrNa7f1OVM4QdVs0eLlDl8h5JmzBOa+rCUoX3DVwiSeTHrVdWF24lFP/rEegs1PTx
         wMhvyIVsM0PxcpbWRnM1HK4b1+jd9eea+qHr6nP+kmSOhkTiujO4u0mSPp7Lj3T62eGz
         /c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DAZW+k5xUtjQ5aVFwcphIg1GlF4c06mlNzxsXunQSGI=;
        b=Sxjl6c+m8k5U12/zX4Ht62XeGIvy3Xa2/kxToJ1dOa8pi8WcbqaC7rww1rg06huRto
         BLjdChAv+dsqI53MAxR5EJK9CmoHqcF/vPpZ82LabJccWHhAf9dwbpYSS2dIiCE35RvU
         RENlTEPpDteMJqKobDrL7Do8DGgLY9QROJU+RATav0vvaactjW5CShxRNi9vfOTPrUiF
         OvEC9WVI7+NmXnrv7n3zQTPLHLZsvdPxtP7RJJ8yYBuhQbshhvDCvihWcq0Poo4q8NgK
         AabKxEUAQ8PfuFLS9FqY3F133MNI06ElP4h+wc3ZzQ2Hi2tiNYg34cLh6p3Jy63exvrO
         rL0w==
X-Gm-Message-State: AOAM531PQ7jQQiwrOupOnWl9SuPO4vQVhagAJuzE/iOf9J8vuo8QtRfo
        hD8IVMITXcdAuARlWJmcxBj6Z+sW/AIRz2JUbfo=
X-Google-Smtp-Source: ABdhPJybbTXZEKDGH4MPWEbee4rVqig1blYDaDwwDLAM6/HgyqQQ0GqkT6TOhbsjZ/7pifemM+Mf5EA7+Z6UGOwPLhE=
X-Received: by 2002:a9d:7842:0:b0:5b2:4dee:79c2 with SMTP id
 c2-20020a9d7842000000b005b24dee79c2mr3782089otm.53.1648661649246; Wed, 30 Mar
 2022 10:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211212184944.8681-1-toiwoton@gmail.com>
In-Reply-To: <20211212184944.8681-1-toiwoton@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 30 Mar 2022 13:33:58 -0400
Message-ID: <CAP+JOzS7Ft0B2Ap5MQwtZcVBhAbeBbiDvdLnq+=ah+Z85zXKCQ@mail.gmail.com>
Subject: Re: [PATCH v2] secilc: kernel policy language is infix
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Dec 12, 2021 at 4:22 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Prefix / Polish (CIL): and a b
> Infix (KPL): a and b
> Postfix / Reverse Polish: a b and
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

Sorry, this dropped off my radar.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2: improved commit message
>
> v1: https://lore.kernel.org/selinux/20211119213728.19331-1-toiwoton@gmail=
.com/
> ---
>  secilc/docs/cil_reference_guide.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_referen=
ce_guide.md
> index 1e63e680..ac800b12 100644
> --- a/secilc/docs/cil_reference_guide.md
> +++ b/secilc/docs/cil_reference_guide.md
> @@ -189,7 +189,7 @@ Expressions
>
>  Expressions may occur in the following CIL statements: [`booleanif`](cil=
_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_statem=
ents.md#tunableif), [`classpermissionset`](cil_class_and_permission_stateme=
nts.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#typ=
eattributeset), [`roleattributeset`](cil_role_statements.md#roleattributese=
t), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constrai=
n`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constrain=
t_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statements.=
md#validatetrans), [`mlsvalidatetrans`](cil_constraint_statements.md#mlsval=
idatetrans)
>
> -CIL expressions use the [prefix](http://www.cs.man.ac.uk/~pjj/cs212/fix.=
html) or Polish notation and may be nested (note that the kernel policy lan=
guage uses postfix or reverse Polish notation). The syntax is as follows, w=
here the parenthesis are part of the syntax:
> +CIL expressions use the [prefix](http://www.cs.man.ac.uk/~pjj/cs212/fix.=
html) or Polish notation and may be nested (note that the kernel policy lan=
guage uses infix notation). The syntax is as follows, where the parenthesis=
 are part of the syntax:
>
>  ```
>      expr_set =3D (name ... | expr ...)
>
> base-commit: f7ec4b4a84aaf3e60b099e267dbfdabbfb1878c7
> --
> 2.33.0
>
