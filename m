Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E1C4338F
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 15:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7F260F93
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 15:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhG1P4r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Jul 2021 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbhG1P4r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Jul 2021 11:56:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D7FC061764
        for <selinux@vger.kernel.org>; Wed, 28 Jul 2021 08:56:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x90so3884364ede.8
        for <selinux@vger.kernel.org>; Wed, 28 Jul 2021 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KJBia7ATQ1PTUNjJu6JBkn1Mi7yqgxyK+/WDg/bTwg=;
        b=w70ktT0sUm4x5/f26NtVnnrUk4m04hSQhSs4kv5uGRm+4aZ3jc+xsnXtcdLBLG4NFd
         4ffVZN6ro+DEuvceEZPdZ3gfhQdGlEYgFk+OWPUYCi3H2S88nBvByOu2uCBxuK1I9A8f
         cu8U/dG3Oul2ze2IIG2AVchUM771Ffb14PHfrIQSZPTVIJyXgNeCmPcvG3Ezp6dwnCfg
         zT6cw/Nh6Si03kHIVK0vRkOspja7ykHPRO5n1OVpQqsjdbaqLXGSVXXbxUuYv6mdhax5
         VNzsBnP/7LOB2OzRDm7+zS3onc945fAzihKL5zZhsBfOcQwjc5Go8qZ/ZGN8RfBBGUSI
         mD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KJBia7ATQ1PTUNjJu6JBkn1Mi7yqgxyK+/WDg/bTwg=;
        b=IBjbJYFaxMGW3Xt5kOT/q0dYOVgnsy/494hasyDSnNX8WZwPQcl99W+LuOQzIJC72G
         kvAYCEl/5yi35dHabyTzizM9l55OHQLZ9bDQnqp0I6qQ7onWOygUOQV3wN2GN6S56gRB
         hEfCY4BnvCvvYqa4wx7zUWew7d/PLjrf/utgMsS5G3WuI4k87vn11B2TxmdfazpE0lOQ
         YZ+lmd/MEPyxRoaH31mDnljtdDLVtUoJD8i1fhNyyQ3QV3Qf3s8ACKk0Fb3Wk7UWJ3Os
         In/3wPpDdlSe3BESoWpkCVnn4tAWmFneLJJr39xp3R6fHd3tdRsACQ7yd6PDXy2CobW7
         BPHA==
X-Gm-Message-State: AOAM5323Ln/4xPLW6jQafj5v421epCVFhGPGeZ2GQsxAfG0S6JHdKU/t
        o/2h4YZLnEXM2C2jlUOoU9ct1AdyQ44WYzGIU4Qz
X-Google-Smtp-Source: ABdhPJxiK0XAEkUiIv7RelCrxIMbjSS4L19AbQRcvGDWUU+n/7vGxBMFwi2QKmgyT13BXEMeqYLZCyjH0jqsDIEDQoo=
X-Received: by 2002:aa7:c792:: with SMTP id n18mr581349eds.269.1627487803897;
 Wed, 28 Jul 2021 08:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210728063110.3652-1-xiujianfeng@huawei.com>
In-Reply-To: <20210728063110.3652-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Jul 2021 11:56:32 -0400
Message-ID: <CAHC9VhSAA5KmeG9-0t=A6wRyxuHZPLpZ4H=HE0FbT1fwcUeFnA@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: correct the return value when loads
 initial sids
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 28, 2021 at 2:30 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> It should not return 0 when SID 0 is assigned to isids.
> This patch fixes it.
>
> Fixes: e3e0b582c321a ("selinux: remove unused initial SIDs and improve handling")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/policydb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index defc5ef35c66..ad1183e18ce0 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -884,6 +884,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>
>                 if (sid == SECSID_NULL) {
>                         pr_err("SELinux:  SID 0 was assigned a context.\n");
> +                       rc = -EINVAL;
>                         sidtab_destroy(s);
>                         goto out;
>                 }

Hi Xiu Jianfeng,

Thanks for the patch, but since you are fixing the error handling in
policydb_load_isids(), would you mind respinning this patch to get rid
of the "out" label and just have all of the associated callers return
directly instead?  I generally dislike jump targets that do nothing
else other than return a value; those 'goto X;' statements can easily
be converted into 'return Y;' statements.

Thanks.

-- 
paul moore
www.paul-moore.com
