Return-Path: <SRS0=nwEP=W4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C08C3A5A4
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 17:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C88121897
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 17:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfIARvZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Sep 2019 13:51:25 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59869 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfIARvY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Sep 2019 13:51:24 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id AF503564609
        for <selinux@vger.kernel.org>; Sun,  1 Sep 2019 19:51:20 +0200 (CEST)
Received: by mail-ot1-f53.google.com with SMTP id y39so1581893ota.7
        for <selinux@vger.kernel.org>; Sun, 01 Sep 2019 10:51:20 -0700 (PDT)
X-Gm-Message-State: APjAAAXD9IFjnt0ha05tPkktRm5KMGY3BXC76OdIydj5r2ciVC2VuNcu
        2UVn/QOcPGiasM1s/YL/VDUWAE/kwo69mtXYTxM=
X-Google-Smtp-Source: APXvYqyGDGYp8qCYxSumy64JAtuELMc+gd6YXQNZhzCDFHq8LJVW4HhIMBY5QaKOQdxWyDJxAOFbhLpbdtiumfqipnQ=
X-Received: by 2002:a05:6830:51:: with SMTP id d17mr19920309otp.358.1567360279728;
 Sun, 01 Sep 2019 10:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190805200434.26911-1-nicolas.iooss@m4x.org>
In-Reply-To: <20190805200434.26911-1-nicolas.iooss@m4x.org>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 1 Sep 2019 19:51:08 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=m=KF8GkUnML-nRth2UA62Bc5BHG6co8LTLeHNVc8xRpw@mail.gmail.com>
Message-ID: <CAJfZ7=m=KF8GkUnML-nRth2UA62Bc5BHG6co8LTLeHNVc8xRpw@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsemanage: include internal header to use the
 hidden function prototypes
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Sep  1 19:51:21 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 5, 2019 at 10:05 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> When functions from libsemanage calls other functions that are exported,
> these functions need to be "wrapped" using hidden_proto() macro. This is
> done in headers such as "user_internal.h". Several functions in
> genhomedircon.c are not doing this, which makes building with -flto
> fail with errors such as:
>
>     /usr/bin/ld: /tmp/libsemanage.so.1.KebOLC.ltrans1.ltrans.o: in
>     function `user_sort_func':
>     /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:758:
>     undefined reference to `semanage_user_get_name'
>     /usr/bin/ld:
>     /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:758:
>     undefined reference to `semanage_user_get_name'
>     /usr/bin/ld: /tmp/libsemanage.so.1.KebOLC.ltrans1.ltrans.o: in
>     function `fcontext_matches':
>     /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:240:
>     undefined reference to `semanage_fcontext_get_expr'
>     /usr/bin/ld:
>     /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:248:
>     undefined reference to `semanage_fcontext_get_type'
>     /usr/bin/ld: /tmp/libsemanage.so.1.KebOLC.ltrans1.ltrans.o: in
>     function `add_user.isra.0':
>     /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:992:
>     undefined reference to `semanage_user_get_mlslevel'
>     /usr/bin/ld: /tmp/libsemanage.so.1.KebOLC.ltrans1.ltrans.o: in
>     function `write_context_file':
>     /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:892:
>     undefined reference to `semanage_user_key_create'
>     /usr/bin/ld:
>     /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:764:
>     undefined reference to `semanage_user_get_name'
>     /usr/bin/ld:
>     /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:897:
>     undefined reference to `semanage_user_query'
>     /usr/bin/ld:
>     /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:905:
>     undefined reference to `semanage_user_get_mlslevel'
>
> Include the missing headers.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/169
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

> ---
>  libsemanage/src/genhomedircon.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index e5f8d3710e8a..d08c88de99a7 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -28,8 +28,10 @@
>  #include <semanage/fcontexts_policy.h>
>  #include <sepol/context.h>
>  #include <sepol/context_record.h>
> +#include "fcontext_internal.h"
>  #include "semanage_store.h"
>  #include "seuser_internal.h"
> +#include "user_internal.h"
>  #include "debug.h"
>
>  #include "utilities.h"
> --
> 2.22.0
>

