Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEECC77B75
	for <selinux@archiver.kernel.org>; Sat,  6 May 2023 09:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjEFJYh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 6 May 2023 05:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFJYg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 6 May 2023 05:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459EA273A
        for <selinux@vger.kernel.org>; Sat,  6 May 2023 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683365029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ApkK5xwMiB7hx8O78yu+Maf0cD4WNzP4bpXHvx21tM=;
        b=gUQ/6yZYX12MkCBOKoBnNAhqq2F5tpiUbtPnyHKq5YOf76/3MO+DSSrRLlpvV674VwLOrw
        vWHoDiCXLHtQUe9xq6+nGtZIa5MJS67tCx1m7azsMwFFbtrAh6ByZ8puytV6SGSaO9pt8b
        RMchbOgv76uxEMrYv0stUvPriwPGLfQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-yp8SAvzdOx-yRWsDHLmGqw-1; Sat, 06 May 2023 05:23:48 -0400
X-MC-Unique: yp8SAvzdOx-yRWsDHLmGqw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-25014b171a4so2277175a91.1
        for <selinux@vger.kernel.org>; Sat, 06 May 2023 02:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683365026; x=1685957026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ApkK5xwMiB7hx8O78yu+Maf0cD4WNzP4bpXHvx21tM=;
        b=Qf9Q7xreyMbJ4yxCV8FoBrQt2sTIjODDn3OVt5Z2rG0iwBWA9SepIeCqhDgGEWhN8c
         oU6f/a3i2vFgIo66gBzCFbv1W4PLfOC7CPmVy/fwFzh5iIdI6DLnjY2lNnCBzX6m2jPw
         iOp6dhAt15MEtpg920AuCvME2N6rcGh19mH1jpb470HjDUxgV2kjjG54pAq45e9Z14tX
         nqzwq5bp1qOtMbNf2c610MCUlikZaT4bKvNNooP5luN0YS1rWG+K8b4uQ9iJiQ8WWUgR
         eTjgNJGzpiuxIPhWcuyTFTTFcU8t4Ynx6av2gANZ6vZ7Gkz700kx5Y8BzGEjHOWh7gYA
         GbQA==
X-Gm-Message-State: AC+VfDwObAA+ugETXdW59E9sibDdx70FbGQ/WYak6XoBDQkzYEBsgYo6
        B7ImTeB6MJcB2sZO3qtHrjPU5V64VaweK8vBXcGEqqDbE+lpfS+qz2sjVG42VUlaKc6g4CHMBoC
        AquC+I2JI/ZRpKpk4aTyt6AJIPHl4JtG6OVrZgMiqbpH1
X-Received: by 2002:a17:90a:e38f:b0:23a:5f51:6ee5 with SMTP id b15-20020a17090ae38f00b0023a5f516ee5mr4510152pjz.12.1683365026411;
        Sat, 06 May 2023 02:23:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gSTtuIYGGY+aO0kCVCJst1HYBxeQ2fiawycV8/7oCFydxmZySFB1fXD/LXprE3v7bpRF+Fcg8SI096r5IJLs=
X-Received: by 2002:a17:90a:e38f:b0:23a:5f51:6ee5 with SMTP id
 b15-20020a17090ae38f00b0023a5f516ee5mr4510143pjz.12.1683365026181; Sat, 06
 May 2023 02:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230505224835.644278-1-paul@paul-moore.com>
In-Reply-To: <20230505224835.644278-1-paul@paul-moore.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 6 May 2023 11:23:34 +0200
Message-ID: <CAFqZXNunnV45QWBe2rWdRRUZGvV9brmSOkQ-JyycAN17jRU5Cw@mail.gmail.com>
Subject: Re: [PATCH] selinux: more Makefile tweaks
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 6, 2023 at 12:50=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> A few small tweaks to improve the SELinux Makefile:
>
> - Define a new variable, 'genhdrs', to represent both flask.h and
>   av_permissions.h; this should help ensure consistent processing for
>   both generated headers.
>
> - Move the 'ccflags-y' variable closer to the top, just after the
>   main 'obj-$(CONFIG_SECURITY_SELINUX)' definition to make it more
>   visible and improve the grouping in the Makefile.
>
> - Rework some of the vertical whitespace to improve some of the
>   grouping in the Makefile.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/Makefile | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

LGTM,

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

