Return-Path: <SRS0=F+qr=BL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE3BC433E0
	for <selinux@archiver.kernel.org>; Sat,  1 Aug 2020 20:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE4420725
	for <selinux@archiver.kernel.org>; Sat,  1 Aug 2020 20:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OKJqsx84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHAUoy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Aug 2020 16:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAUox (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Aug 2020 16:44:53 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0F0C06174A
        for <selinux@vger.kernel.org>; Sat,  1 Aug 2020 13:44:53 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v22so13872919edy.0
        for <selinux@vger.kernel.org>; Sat, 01 Aug 2020 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Na2ApoQTMBGJhfUVK8KJSAdabLgYPbRw+JutxJE1Y1Y=;
        b=OKJqsx84JvKSHpXTIj+kwAHkh2+0RHdtOYaPlTIZDj4ub7+/eqcg2lV7utARc7x/5b
         C5lsF5CJqWfnY/VEAR/AQYB5Uwb0/OFWaP81+4tdJ3qCm4Ng/tRx90TuIlry5yiLQUxQ
         3r4z+n7aVbpxRjVUTZIxa+UZO4Iah8ER1Vyvkf2gaAGLzw7RxOa9RoDz6tPmMXiNY1c3
         WOe90EV4pTIvHK1XUqIVwSfAsgVieOQXBpNb5f+4INRKUjAP5o7sBzrCTyhP13ztMAom
         mi1GEf4j6ilzkyjGO45eWXvaMuqxfarGQR14QEBz/C3fiV6kXLjK8zR3a0GMY7agOngR
         WcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Na2ApoQTMBGJhfUVK8KJSAdabLgYPbRw+JutxJE1Y1Y=;
        b=WIJSIOiOPPjDcCrWgxHVubc3NSsh/xr1VNTbt03wRAmeyjZgju883n8cJS0c1ZfEkP
         LluDOXaw9zjTXHACGrpzI0G18fTEw0Mtzzjwjk5KR0ypfbRSItBURDbOUb1gs5ebd19V
         ANRv8XzEM0Ag9WLeUkbZ/jDID2IuiYrHNMv5ihKQP7hYEilwKN3nVkBrirQ5bgphG7tr
         zdxmFnMtTyGLdfaREQaXIAt40HMzfD3Ml3xJXALKIK4TidZPVZentHt0YGWFjg7BFNTW
         JfWfvTwn7AF0sR90/8A4io/bEB7EjrTo5HUIsI6gc1G2s0V03/awO7ePK8NQu2CmISt1
         lCiw==
X-Gm-Message-State: AOAM530HCu3Jhax6w55lbvtFvk9lRN1jCzF9lYOjDoW+4T0GgramMzau
        pXYcu/FdUwDR9zNMpOuy375fyWdh2ag/7A5iBhwR2Qj5NQ==
X-Google-Smtp-Source: ABdhPJypsu9wJ5xumW3k6TvGfGaBxlLb7dcG79svyC1YUTI8HJe7CkgWJyke5/yitZkh9iD4qGoNwh05uTogBC9rl8w=
X-Received: by 2002:a05:6402:3070:: with SMTP id bs16mr6579475edb.269.1596314692144;
 Sat, 01 Aug 2020 13:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200730093125.896974-1-dominick.grift@defensec.nl> <20200730114150.915048-1-dominick.grift@defensec.nl>
In-Reply-To: <20200730114150.915048-1-dominick.grift@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 1 Aug 2020 16:44:40 -0400
Message-ID: <CAHC9VhS5x_YorZw5szDY3tDw=SHkhowujiivCDQy2GQRpASv1A@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v3] type_statements: document expandattribute
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 30, 2020 at 7:42 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> This functionality was added for Androids Treble in 2017.
>
> I was not sure whether this belong here or in conditional_statements.md
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
> v2: change expandtypeattribute to expandattribute
> v3: overriden is overridden
>
> src/type_statements.md | 70 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)

I'm in the process of converting all of the remaining HTML to markdown
so I would prefer not to add any new HTML tables if it can be avoided;
would you mind trying to write this using markdown's pipe tables (they
render correctly on GitHub)?

Other than that, do any of the policy or SEAndroid folks have any comments?

> diff --git a/src/type_statements.md b/src/type_statements.md
> index 61c7191..04b6f4c 100644
> --- a/src/type_statements.md
> +++ b/src/type_statements.md
> @@ -201,6 +201,76 @@ attribute non_security_file_type;
>
>  <br>
>
> +## `expandattribute`
> +
> +The `expandattribute` statement allows type attribute expansion
> +compiler defaults to be overridden.
> +
> +**The statement definition is:**
> +
> +`expandattribute attribute_id default_value;`
> +
> +**Where:**
> +
> +<table>
> +<tbody>
> +<tr>
> +<td><code>expandattribute</code></td>
> +<td>The <code>expandattribute</code> keyword.</td>
> +</tr>
> +<tr>
> +<td><code>attribute_id</code></td>
> +<td>One or more previously declared <code>attribute</code>. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
> +</tr>
> +<tr>
> +<td><code>default_value</code></td>
> +<td>Either true or false</td>
> +</tr>
> +</tbody>
> +</table>
> +
> +**The statement is valid in:**
> +
> +<table style="text-align:center">
> +<tbody>
> +<tr style="background-color:#D3D3D3;">
> +<td><strong>Monolithic Policy</strong></td>
> +<td><strong>Base Policy</strong></td>
> +<td><strong>Module Policy</strong></td>
> +</tr>
> +<tr>
> +<td>Yes</td>
> +<td>Yes</td>
> +<td>Yes</td>
> +</tr>
> +<tr style="background-color:#D3D3D3;">
> +<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
> +<td><strong><code>optional</code> Statement</strong></td>
> +<td><strong><code>require</code> Statement</strong></td>
> +</tr>
> +<tr>
> +<td>No</td>
> +<td>Yes</td>
> +<td>No</td>
> +</tr>
> +</tbody>
> +</table>
> +
> +**Example:**
> +
> +```
> +# Using the expandattribute statement to forcibly expand a
> +# previously declared domain attribute.
> +
> +# The previously declared attribute:
> +attribute domain;
> +
> +# The attribute stripping using the expandattribute statement:
> +expandattribute domain true;
> +```
> +
> +<br>
> +
>  ## `typeattribute`
>
>  The `typeattribute` statement allows the association of previously
> --
> 2.28.0.rc1
>


-- 
paul moore
www.paul-moore.com
