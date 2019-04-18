Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F2FC282DD
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 15:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF9A205F4
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 15:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oe2X+wSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbfDRPOF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:14:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40585 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388070AbfDRPOF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 11:14:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id f196so1871081oib.7
        for <selinux@vger.kernel.org>; Thu, 18 Apr 2019 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjY+6jIsjUaFIjWZh3gcx+CDyLJDEs7w4Hi32FVkWhI=;
        b=oe2X+wSo7CBOUrRgeugmWnouzePp70EHHt9hpislvOIrmV0jEf5OjAg/yjdCog5Edt
         ZWeU1rJ9Nig3HbIAjJhjH7XQmrmxmTBYoo1dMrjB5HRtx42n6gc7o9jks/U4n6sHK8n3
         szAabYHWgpyHdw1OKfAdmPxb8vu4GOo+DNO8S9W14aKG5GmzotOCFIH8wGCn3BYVnml6
         XTr3LtMgIsw6VCPcdGr+DV5m/tzTRirgIWg+D2Zu6RWui8Y6SWQi7Gv4oMxVd/x5q48N
         2GpHzQPFPAxQ1t+0KZ05MpLK+EC1b93PSG4UTEKgbQFPoRF+oG+HnzvecwWMn/S2Flcd
         zL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjY+6jIsjUaFIjWZh3gcx+CDyLJDEs7w4Hi32FVkWhI=;
        b=ALc6qvoK2FN6tJhterhkZOUBr2Ez0o7ncoWCgo5vzInSMlYFP8i/uaNJc57kjtnK4I
         ncJuuZuW6jzYgjcLFkyA64yS6LChAYpLdVjx57HJRlFlXsleVZe/UczAMtQdrzHUkQmE
         Ii0ONEC2t4ylnQiOf8ZqDM40HRRoXAHFnlTKdll6T80WtUaitdFAnicECfwRitvBeY01
         tJXRC1aOS8IrLmhjK6USbpJyTfzcKcgICzLbtfqhpDjL28z9MTBk2WqMGTpcTK6okyKt
         9tWHQHbCbdnr10cxZ7fHuk1F3x6AlYJevDOL5MV1Hu2AfSwP3xUhlxoAcRfYC/Zq2wWY
         aCIA==
X-Gm-Message-State: APjAAAWFuzKuzVmLXXWKGPCnJzU2TXf4u/+JoiyNg2y5EkS6JvrQBa4X
        ObjnpFFY/rc6swstqBKpuZl2oNuugIPCzQy53idBy7yC
X-Google-Smtp-Source: APXvYqx41A3GThy6v9/txHoEdBWbz1NFdl2CceEag3686FFt6RWnGA+V6TrPTEW49tvBwS3HZshbp/7SimSL4MEk8hA=
X-Received: by 2002:aca:6c96:: with SMTP id h144mr2120017oic.167.1555600444477;
 Thu, 18 Apr 2019 08:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190417163731.3434-1-gary.tierney@fastmail.com> <20190417163731.3434-3-gary.tierney@fastmail.com>
In-Reply-To: <20190417163731.3434-3-gary.tierney@fastmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 18 Apr 2019 08:13:53 -0700
Message-ID: <CAFftDdqcp6eXFTYCr5xJJE76B0ETjAjDh-zNkocbQbJ5EWE3_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dismod: print policy version of loaded modules
To:     Gary Tierney <gary.tierney@fastmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 17, 2019 at 9:39 AM Gary Tierney <gary.tierney@fastmail.com> wrote:
>
> Signed-off-by: Gary Tierney <gary.tierney@fastmail.com>
> ---
>  checkpolicy/test/dismod.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index d5c7eeab093a..075bd85df4e6 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -903,14 +903,14 @@ int main(int argc, char **argv)
>         }
>
>         if (policydb.policy_type == POLICY_BASE) {
> -               printf("Binary base policy file loaded.\n\n");
> +               printf("Binary base policy file loaded.\n");
>         } else {
>                 printf("Binary policy module file loaded.\n");
>                 printf("Module name: %s\n", policydb.name);
>                 printf("Module version: %s\n", policydb.version);
> -               printf("\n");
>         }
>
> +       printf("Policy version: %d\n\n", policydb.policyvers);
>         menu();
>         for (;;) {
>                 printf("\nCommand (\'m\' for menu):  ");
> --
> 2.17.2
>

I don't have a problem with this, does anyone else?
