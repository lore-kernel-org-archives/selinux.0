Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57963C677D7
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6B920841
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 14:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRB/mYWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6B920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeJKVrM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:47:12 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40362 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeJKVrM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 17:47:12 -0400
Received: by mail-oi1-f195.google.com with SMTP id j68-v6so7165889oib.7
        for <selinux@vger.kernel.org>; Thu, 11 Oct 2018 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6cxJv25Eol9vXGO/upnRfosUlvRsR2mLbPZc5VQQ1vY=;
        b=HRB/mYWhMEbLByIYFQdtlqeBkpEOOwlZ+rnsg9T8uEdVI0nyjYZsTZr/zpgsjFnmWu
         5o67ZMjYcSTX2bWuzdOCvOqJXDKpjXj++nu1MtzB8FdwOWXxLFp/r5MQV2d2xRYnj3fI
         xV26Gnp3opDVIy+v88uCbUnWu2qKcRTRZ3eiiS0UQ8rKiBsVqLfCYo5pB8Sn4Gm5LFMY
         uBGaQA8xNEWjI/ZTe1yVqDdoN6YMK1AaXG89qG/BLk4CZafuiW8hRtr7bKHvu+3PBpeP
         Ky+5EPjKg/YU+YDYcTYbEY3iJ8SMpCTE3tHX58W4ue1skKI0gdy8vghCoEuv0w4Cd49k
         pIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cxJv25Eol9vXGO/upnRfosUlvRsR2mLbPZc5VQQ1vY=;
        b=d0ZhbMMngDSYRwaZlYDvyOHXEm49qjrUm8oGAsEEnxqqQAzXJ63Pz0BAQB9F6ibzys
         ZpHu6GufU1UfQRfYHZWPx5+/4qxmb54I/ai6XFJMIfeiwgvmd1eb1QoBU7+6YgwBJ4WS
         hokEg6x87TGp4/WEadsu8qJxcysT81y23prvCECB+yT6hJSsaELhkQvxMJC1ZmUOa3Bw
         bhgjSItKZzPWDacib0LM7K7B+7M39+RekWA+mYKRteF4UQgRygCU3AMIqPhOUcrZgxKr
         DjOnR9WEcnodrQWhjRAb/om0y7mPQiXIfi/P0/Iz8i2RAdju3DtUdwXVvyy3ezG/hWE/
         kCfQ==
X-Gm-Message-State: ABuFfohGQyJJESVyOafj5J9q4sPDHl6wfx88hJLEWEKE6v+JY8zZUUJJ
        u4J/1lmVYz5J3olccjpauU+FwlRHJ9uK6myWDVI=
X-Google-Smtp-Source: ACcGV60+kYpycVvQtM3DSnc2JyeBMtP92rLW2RGnM7VkyNqhvd3yprRT+HsGP9e+cJyMUr+gxVTDjpHxrHWp64AiMtY=
X-Received: by 2002:aca:59c4:: with SMTP id n187-v6mr928890oib.279.1539267587359;
 Thu, 11 Oct 2018 07:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181011134333.16468-1-yuli@crunchydata.com> <20181011134333.16468-2-yuli@crunchydata.com>
In-Reply-To: <20181011134333.16468-2-yuli@crunchydata.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 11 Oct 2018 07:19:35 -0700
Message-ID: <CAFftDdqagQZbbccJGQ+GB23kF9g_ZuiA3RN9psB7qykt+XhGjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] libsemanage: improve semanage_migrate_store import failure
To:     yuli.khodorkovskiy@crunchydata.com
Cc:     selinux@vger.kernel.org, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 11, 2018 at 6:45 AM Yuli Khodorkovskiy
<yuli.khodorkovskiy@crunchydata.com> wrote:
>
> From: Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
>
> The selinux/semanage python module import error in semanage_migrate_store
> was misleading. Before, it would report that the selinux/semanage modules
> were not installed even though they were on the system.
>
> Now the import failure is only reported if the modules are not installed.
> Otherwise, a stack trace is printed for all other errors in the selinux/semanage
> python modules.
>
> Signed-off-by: Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
> ---
>  libsemanage/utils/semanage_migrate_store | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
> index 2e6cb278..b789d042 100755
> --- a/libsemanage/utils/semanage_migrate_store
> +++ b/libsemanage/utils/semanage_migrate_store
> @@ -15,7 +15,7 @@ sepol = ctypes.cdll.LoadLibrary('libsepol.so.1')
>  try:
>         import selinux
>         import semanage
> -except:
> +except ImportError:
>         print("You must install libselinux-python and libsemanage-python before running this tool", file=sys.stderr)
>         exit(1)
>
> --
> 2.19.0
>

ack

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
