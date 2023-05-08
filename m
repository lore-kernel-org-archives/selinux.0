Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE13C7EE22
	for <selinux@archiver.kernel.org>; Mon,  8 May 2023 20:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjEHUqy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 May 2023 16:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjEHUqy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 May 2023 16:46:54 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCDA2735
        for <selinux@vger.kernel.org>; Mon,  8 May 2023 13:46:51 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9a879cd49cso6762504276.0
        for <selinux@vger.kernel.org>; Mon, 08 May 2023 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683578811; x=1686170811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H40B52g5QtY2K7HMOXzkQQbQswsl4NHface25sWjLwo=;
        b=HCpsPAo5dKatpn2ccu5sihCZGZMwBbKKrp95CW7XXwsporF2l4v2Qs37oo7JjOiVhd
         eLr2Rd+gdGYyF1wjt27qrWgBU1lWAmHFab7ZNm0qUse9ldF9Wzgnlfwf8KkkzUt5pEJr
         n3o6qFIJ0cOnVCKYaPCdfjq1MOQ456UEDplR6m1Vwn8uWouBl1ph24ECl/CbSWUm2yQa
         YSjrYeENoJGtNMTDtnPconZCu1cfM5qsQWJeGjEY+HyDTXeWcebBCSpzVGzYZbIbMb60
         9/qFnaO2SkliWQFZq8aY6j2z3R9JolR1md+OMiYe6k/44xoz9dnk5ozrqEJSsICtkZS6
         KtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683578811; x=1686170811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H40B52g5QtY2K7HMOXzkQQbQswsl4NHface25sWjLwo=;
        b=aoWI1T3sSLbza/oiB0DtLaRA2pN6PXc3+DMcFzLaK6FeXDp9zuDUp3Yq0jTGMd92bb
         vNv0lMHN+V0XkDsmIrDlGIv9jAYmz5mdTXKMhO/LzSzMZxQr0m7S3CI+9A5tS33aao9Q
         6KppPE0b6A9R8zRvXJxsZh24Nnue5yVYlHDrdG/7/UCWxIlZfghhURBVU8LxITLCP59G
         6tsAAHxRInigxgDVXXy6Fw8JEWQwB/Nxfux4tTxX7SksKCWUW1RdUF6MPnquUue8lf/N
         NESHwnlAIeovJbU7aBnYt/3xLmTiJXePADgPfc/NifjGuDPTtDdOIetuvhNmq1HYk+d6
         KI1g==
X-Gm-Message-State: AC+VfDyp+LpeMaE0YqKgBWP8VwUFSo/BHBYkSiUeOUPW4ihViij33q4P
        j6/aUi3UCmsnKoTGywzs8gDqIvZh9t6126lcuYjz
X-Google-Smtp-Source: ACHHUZ4JTLbQA78mMtolgkZ/oRvFI0o9rk1AK1u3GOIMaIz34R4zZEae1GGIRf8idXUiJa6WXxSxl/fyj5SQj5CZJQ8=
X-Received: by 2002:a25:d812:0:b0:b99:1053:becf with SMTP id
 p18-20020a25d812000000b00b991053becfmr11220801ybg.0.1683578810816; Mon, 08
 May 2023 13:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230420150503.22227-1-cgzones@googlemail.com> <20230420150503.22227-3-cgzones@googlemail.com>
In-Reply-To: <20230420150503.22227-3-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 May 2023 16:46:40 -0400
Message-ID: <CAHC9VhQ5qVFO92LT1+oLbbjZKXZSVrHZkPJ83iv-wWraLQF9NQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] selinux: avc: drop unused function avc_disable()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 20, 2023 at 11:05=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Since commit f22f9aaf6c3d ("selinux: remove the runtime disable
> functionality") the function avc_disable() is no longer used.
>
> Improves: f22f9aaf6c3d ("selinux: remove the runtime disable functionalit=
y")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/avc.c         | 19 -------------------
>  security/selinux/include/avc.h |  3 ---
>  2 files changed, 22 deletions(-)

Merged into selinux/next (without the Improves tag), thanks!

--=20
paul-moore.com
