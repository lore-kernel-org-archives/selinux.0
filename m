Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0207C3F2CF
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 08:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84348246A3
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 08:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H71j1vet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgB1IRZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:17:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54793 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgB1IRZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 03:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582877844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4zZ4ytZvW2EX4LfIXAIbKAXJPgkSs9ZgHOAAomSuL1I=;
        b=H71j1vetzxUQPHSIGQL+EUk14+p+LhkiZKcPgZFPqhbKwetrEBxXqWW9zZKp/9ZTu/rr3D
        xRT/zMkzrjb7YZ+VOBgEXO/3bugVM7x8sEaivdX3Mc3CljUaZkntzG6GrSYM7TTb3hMGHw
        Ic0a1NwkBksaZ5TV8jEunEmTE49N0qI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-hhmRpSBQPyyRoLjvRFDrCQ-1; Fri, 28 Feb 2020 03:17:22 -0500
X-MC-Unique: hhmRpSBQPyyRoLjvRFDrCQ-1
Received: by mail-ot1-f69.google.com with SMTP id 39so1337376otb.8
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 00:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4zZ4ytZvW2EX4LfIXAIbKAXJPgkSs9ZgHOAAomSuL1I=;
        b=T+QwGgsOUxlKeNClnNTDiNWhud2a3fL0g0I+aR2bSweJK0ZxErNv1VhQa76MVoYILj
         U7IKF2Na/34eDJOsIJ0p1R//HdiX29lT55q8t5o5orYVl7etEqOKMNBbcpfj3x0miqz6
         wXRTOJwahNv7i5IGCNTZOPCcrb7KkfImA2RBVJws/gcjOqmd1SfT0tkf3je32p98DWBn
         mObDePDxGwHnKqb6crr7aIVpDFVsGR8Dli0rHbIcjTaO5R9LijqCuooE8tgLUvQFj742
         Neeog2hSJxXSpQqbO7zcHIq5mQsfsG4jL/86KfZOAQ539DN4sdL9VnTGdAGbbqObK8YK
         1Sqg==
X-Gm-Message-State: APjAAAXmdx8uedjmPtaYPUcxkVpKwkVd8PNyWIzYA0RSmMQfFPKkkw9g
        EEHe8kxTjWfpMIyMkcxyAyCp8B72XH+gkqVeCJg1kkoZhwwcGZ9oqRMTGcy9PhlEarH/NbGef/t
        A47Eivfij6R2sAKhnQap1BpMK2p1aMofOCg==
X-Received: by 2002:aca:5646:: with SMTP id k67mr2316805oib.166.1582877841573;
        Fri, 28 Feb 2020 00:17:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqfwl2if9oOKuftIcGidr5BfbiRWlC5JW41Xpw3XA5aFU+BP93YscQGkK9dcwwIgEI0UfOHWlqKl299KBej7Y=
X-Received: by 2002:aca:5646:: with SMTP id k67mr2316798oib.166.1582877841312;
 Fri, 28 Feb 2020 00:17:21 -0800 (PST)
MIME-Version: 1.0
References: <20200227224706.29892-1-william.c.roberts@intel.com>
In-Reply-To: <20200227224706.29892-1-william.c.roberts@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 28 Feb 2020 09:17:11 +0100
Message-ID: <CAFqZXNv4g8fdreQgSqrEumjPVYhT5btjiMcSYezZm7LaEJRW_A@mail.gmail.com>
Subject: Re: [PATCH] libsemange: add missing header sepol/policydb.h
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 11:47 PM <bill.c.roberts@gmail.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> Fix below compilation issue:
> direct_api.c: In function =E2=80=98semanage_direct_commit=E2=80=99:
> direct_api.c:1466:13: error: implicit declaration of function =E2=80=98se=
pol_policydb_optimize=E2=80=99; did you mean =E2=80=98sepol_policydb_to_ima=
ge=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>     retval =3D sepol_policydb_optimize(out);

It is probably a good idea to include it explicitly, but it is already
included indirectly via <sepol/module.h>, so I'm not sure how you got
the above error. Maybe your build flags weren't set properly and the
compiler was including older system headers instead of the local ones?

(BTW, there is a typo in the subject line - 'libsemange' is missing an 'a'.=
)

>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libsemanage/src/direct_api.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 1088a0ac6165..92f0a17b0156 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -23,6 +23,7 @@
>  #include <sepol/handle.h>
>  #include <sepol/cil/cil.h>
>  #include <selinux/selinux.h>
> +#include <sepol/policydb.h>
>
>  #include <assert.h>
>  #include <fcntl.h>
> --
> 2.17.1
>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

