Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1099C4332F
	for <selinux@archiver.kernel.org>; Wed,  4 Jan 2023 17:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbjADR47 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Jan 2023 12:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbjADR4a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Jan 2023 12:56:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6CF3FA2D
        for <selinux@vger.kernel.org>; Wed,  4 Jan 2023 09:55:18 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b88so42369456edf.6
        for <selinux@vger.kernel.org>; Wed, 04 Jan 2023 09:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/hFq/M2laddu/yh/qaUSXNFvYZcOHxdmYjwNEmU1bNU=;
        b=Z5pDOab+L8tJ90oLILr+GzLZO6QPGTSoQtO00B6Etc4QYnhsgV8zIJrTt4Wu+F704V
         oOAxgCfk3uFDFbDzDwGZT/SFdQuaZKMnSwupuSRMGGFRHrurZybo/pHEZBkAWIr+u0Ko
         fzZx4D0kkO0Xni47lXZyfUbVHRNBTTKV1sjl5LpQi84ZkcMLt+seHeqF0RUzdW/bb7rw
         qUhLxfGm81BkI5rE9cfsPEIfLUi3qNTF9a8xfirh6WJlNWCGb1z5h5hNVuqAhAWtGTf2
         h9d0MFKdKeT9Evk6ja0LBisS8BUDk2kWi8h5iJ4onMmpN0x6XJWMItizpsARMXLFk8Xq
         0tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hFq/M2laddu/yh/qaUSXNFvYZcOHxdmYjwNEmU1bNU=;
        b=qCH25uoArBT8Ll91jCPXys17aqWmqS1dlLPHNTTrNu/5AT3AHsuBQBqbqzyJw8Auzl
         emN1hgOMGy9quRorL4WFyijrRB34JdjnzYcDiJj6P1tvfJ0NP5hyWFKWttvMHOy2MYVB
         tGfLAQRlYqbb6ySXScx+tOryMLbiIrd6e28xUs73uxcfWe9I73GREl63lWVD59K9pKAS
         14MESwumMMctgWresrCGrYwC7atPFhRrHobjny9FmOwyyXeGOVFEExqhx5VI8+O+NYBZ
         dFIa8CQFkKwfTbAyI//gljl+8zfIYQscR70NaWmIoqun6OnfJtUbcicSlmpvgXJ/z0Wz
         gHSg==
X-Gm-Message-State: AFqh2krYqL5DNpmeK/dRVFYy/B77TNjjPF2hKGvTKEeiFqz3Ewl9K0Sh
        cXeH9drM53T5tkjvGsLcx3EwWWmC6VB14jTmxhxTWB2y2lY=
X-Google-Smtp-Source: AMrXdXtmnzsHkbnCmk28R/eVm1VIN/SwDf6xi7lLlGah7GMqLQfa1JThcJQtonk3A2uyl82Tb/Ze9DcLxLxliw2e/Ec=
X-Received: by 2002:a05:6402:1f05:b0:487:22f7:36e8 with SMTP id
 b5-20020a0564021f0500b0048722f736e8mr3146931edb.195.1672854916576; Wed, 04
 Jan 2023 09:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20221216153311.17638-1-izhaoshuang@163.com>
In-Reply-To: <20221216153311.17638-1-izhaoshuang@163.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 4 Jan 2023 12:55:05 -0500
Message-ID: <CAP+JOzRrByJ34RP46kzPzUJH0_bvsRcwD5vmizFW8mA_OiSiAQ@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: fix a spelling mistake
To:     zhaoshuang <izhaoshuang@163.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 16, 2022 at 10:49 AM zhaoshuang <izhaoshuang@163.com> wrote:
>
> From: kkz <zhaoshuang@uniontech.com>
>
> Signed-off-by: zhaoshuang <zhaoshuang@uniontech.com>
> Signed-off-by: zhaoshuang <izhaoshuang@163.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolicy/sepolicy/templates/script.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy/templates/script.py b/python/sepolicy/sepolicy/templates/script.py
> index c79738b8..564a6b38 100644
> --- a/python/sepolicy/sepolicy/templates/script.py
> +++ b/python/sepolicy/sepolicy/templates/script.py
> @@ -75,7 +75,7 @@ rpmbuild --define "_sourcedir ${pwd}" --define "_specdir ${pwd}" --define "_buil
>  """
>
>  manpage="""\
> -# Generate a man page off the installed module
> +# Generate a man page of the installed module
>  sepolicy manpage -p . -d DOMAINTYPE_t
>  """
>
> --
> 2.20.1
>
