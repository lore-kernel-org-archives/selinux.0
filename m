Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ED0C433FE
	for <selinux@archiver.kernel.org>; Thu, 29 Sep 2022 19:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiI2TaK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiI2TaJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Sep 2022 15:30:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101950506
        for <selinux@vger.kernel.org>; Thu, 29 Sep 2022 12:30:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b75so2305337pfb.7
        for <selinux@vger.kernel.org>; Thu, 29 Sep 2022 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zIFxvH+Z7YUI5rlJf1zLwASF87ximYkwFPTXoCnRXTk=;
        b=nwyFhzosQ/82QPKc6Sbe0N/94oZ+KzhsdoNB6xqVdHUyzMo68rRjBgkE/080jvcY7B
         UXHY0whYcdP6AxHIhgdoLYXcLjQoUdQBlZGCtVgc+T3I/irYHoYPggATlwpntmahN7Ff
         8MVscVaYa4AfbIvz5P95XhuMG+wMc8KpQjziX1r9vNQmshzvYFofhJWJr0NwcacotGyE
         IZn74f1nFfjJqfgOFXYx2PTUlo7OM/vPtgGgnsZWSGc2Mr/EpaWuLhq8t14NAerGabWu
         63Gese210rh9qV96yO/cWJJS6ciadmobeLtHU8boFac4PQiK7GOHKBe/bg16CEK01z2+
         HaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zIFxvH+Z7YUI5rlJf1zLwASF87ximYkwFPTXoCnRXTk=;
        b=XWqxRb7JOB3tvniGSO0cnd9yAynHBFU91Tt1zo4zS6unEAJ5eGBeXBbr1ZiRInbdyK
         OPNuaHqytbJWHD+TBheBC2mppl3XIdr4T57W/pikDc8KqQg/iqulIRHSau96TnJLoU9B
         2YGcFUaiuNfdCxJwlyXplvld9AU3q7rEgsS7HqW/fFwSpFz/GhQH9KE5ktAAcKTFmsLz
         Sh3ARVHdCkuku3MB5xHwzuQMe5BXoNXfCXdiWyDwaDumcRVWHksoNxHQN2bLVbCvlR7K
         MmCgdSIfCIRD9fEMajPbBZLmYPFE7y7ES4tKCoAoiZtAu1ufCrotNN6zf/m2o05LX34E
         QfUQ==
X-Gm-Message-State: ACrzQf09LJNUBRdE+R1YInKbpsVoCqGkMEDOd61HK9Fx6CAW23dJFoLA
        rpvs1jEwQPQElWIJZ/BEOqxHTNqZcQdhyBbVYbziP2qUe40=
X-Google-Smtp-Source: AMsMyM7yvTNRpIVYRN8oEQrMdyamrKRVw3auS99k/3ITTpZWpWATrZj/8xqJqsockpb8n4qNT22rfM9zz6buBQcj7vU=
X-Received: by 2002:a63:191d:0:b0:434:4bb3:e016 with SMTP id
 z29-20020a63191d000000b004344bb3e016mr4288174pgl.133.1664479806778; Thu, 29
 Sep 2022 12:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220919134914.145651-1-dominick.grift@defensec.nl>
In-Reply-To: <20220919134914.145651-1-dominick.grift@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 29 Sep 2022 15:29:55 -0400
Message-ID: <CAP+JOzSGRSA1k8x_0jHtrq9O2wKFPF2vYXtxfXBwj6jZCO0Q5w@mail.gmail.com>
Subject: Re: [PATCH] secilc/doc: classmap is also allowed in permissionx
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 19, 2022 at 9:56 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  secilc/docs/cil_class_and_permission_statements.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/secilc/docs/cil_class_and_permission_statements.md b/secilc/docs/cil_class_and_permission_statements.md
> index 368e3a4d..c494f144 100644
> --- a/secilc/docs/cil_class_and_permission_statements.md
> +++ b/secilc/docs/cil_class_and_permission_statements.md
> @@ -536,7 +536,7 @@ Defines a named extended permission, which can be used in the [`allowx`](cil_acc
>  </tr>
>  <tr class="odd">
>  <td align="left"><p><code>class_id</code></p></td>
> -<td align="left"><p>A single previously declared <code>class</code> identifier.</p></td>
> +<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier.</p></td>
>  </tr>
>  <tr class="even">
>  <td align="left"><p><code>permission</code></p></td>
> --
> 2.37.2
>
