Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DD9C6FD1D
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 13:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCTNqq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 09:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCTNqp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 09:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB988697
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679319948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JULaVpIPEDdCPZG12GcfjCOlIVCvymXB1A3fFwd2h0=;
        b=QkyakASIEf7izfm6ISjJht60XYVRATzYAxEi+kzjnHrlF8N2/VMeqgOALKCA8BMtmEfQZ6
        X66rHbgWKN7NHl/9peh0l4PE1Ylg1tJAm19uNpvTUGOMJRQAHHLgdmOQrlClqVDTrlJeRt
        Hf9ZrQhC9vRMmYY+ZFP+/5fUZnGfoxg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-5v5q8k8_MjyQWW2kvvz19g-1; Mon, 20 Mar 2023 09:45:46 -0400
X-MC-Unique: 5v5q8k8_MjyQWW2kvvz19g-1
Received: by mail-pl1-f199.google.com with SMTP id x4-20020a170902ec8400b001a1a5f6f272so5704985plg.1
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 06:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679319945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JULaVpIPEDdCPZG12GcfjCOlIVCvymXB1A3fFwd2h0=;
        b=CtYv1s+bm7lMalVdqauOm1Dv60CVXDPea33kWsQEREZfuaRBmLoCBw98FM9wAz5LxE
         9FU39zDKXr4Zoa/APVEGNvndeV+1MzjpdoAczUQQmAiH/40RHnn7ZYotQ9d/pfc8HnKG
         2gbppusAvQuhl5rQXvbiEiioIFHMM2t8a+lndPxXii86UxxFCTi3Xy2QvVPUU0RzW2X5
         6WxKNn1Y1bp7e8LB7Pi8/0xFfeG6AbGh9nw0jK1eTMsEJt10fLXl9FCK9XuuBe9Ra2HB
         Rdh/p2jwTZCWQOFbcO+zvmSFB0GcVNQMSXzzgpxxEcDAsZ7epbs/WRK6ty4oJCYQy1Q+
         DMeQ==
X-Gm-Message-State: AO0yUKVMx9bhxoZ0FkasjUHaKrdYyCMaq79KaZIb1Le4PYoqbeePon8H
        pgyiT3LxnPHE9IuiOrsIaeSGTpfZqNGdxyX0LGnZ90yK7GmZ8Y3EOCZjSusa3imcF1940B/NHgN
        LFOX0DicvG2CBq+40F+oUkGaUaOUhbnEcxKfevOWSvJ0A6nc=
X-Received: by 2002:a17:903:452:b0:19e:f660:81ee with SMTP id iw18-20020a170903045200b0019ef66081eemr6974714plb.2.1679319945274;
        Mon, 20 Mar 2023 06:45:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set+5qY0GmqCkXEJw7wBDeaA4+PCs5/Gc5iN10gYo0Ufwsk2QB/sGWSbA8fFRYYfsyE5fdsSZdLI+jEFnipfiIPc=
X-Received: by 2002:a17:903:452:b0:19e:f660:81ee with SMTP id
 iw18-20020a170903045200b0019ef66081eemr6974709plb.2.1679319945037; Mon, 20
 Mar 2023 06:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230320123956.181765-1-omosnace@redhat.com> <CAEjxPJ7xMXaqwewRWhDNkrsViNOfpdSaHBUZ=sET7dDcqmpjyg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7xMXaqwewRWhDNkrsViNOfpdSaHBUZ=sET7dDcqmpjyg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 20 Mar 2023 14:45:33 +0100
Message-ID: <CAFqZXNvtxKQ0jaBgVokCKcSMqkUE73Dz7AUq1ZjgykvY+F0OxA@mail.gmail.com>
Subject: Re: [PATCH userspace] scripts/ci: install rdma-core-devel for selinux-testsuite
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 2:01=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Mar 20, 2023 at 8:45=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > It is required to build it as of commit 4b4922e115e2
> > ("tests/infiniband*: simplify test activation").
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Feel free to merge it.

Done:
https://github.com/SELinuxProject/selinux/commit/86b49aa7a319b465a3383b8974=
3453708c45b96c

>
> > ---
> >  scripts/ci/fedora-test-runner.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-=
runner.sh
> > index 7676f6ea..331b9ec7 100755
> > --- a/scripts/ci/fedora-test-runner.sh
> > +++ b/scripts/ci/fedora-test-runner.sh
> > @@ -61,6 +61,7 @@ dnf install -y \
> >      e2fsprogs \
> >      jfsutils \
> >      dosfstools \
> > +    rdma-core-devel \
> >      kernel-devel-"$(uname -r)" \
> >      kernel-modules-"$(uname -r)"
> >
> > --
> > 2.39.2
> >
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

