Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3197AC6FD1D
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 13:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCTNA2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 09:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCTNAV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 09:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB9259C6
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679317179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTSiCVrkmtA/WRJGm80v372Yg5wNlTp3W5OIt13Gx84=;
        b=bgHGsu7fUiykWFxWe8EYlXjWRhmz4Yk/ym9WFUOtwctsrCM9+7YDmk3N2CFh3/LOWvqMkL
        BOnPF6GDsGLx8MTaGEvmkCjy/U/tFq0X+NCo97cS0oFSE0OPbnFDKRBaZxMsF2Yf83M1Sq
        ICB6d+QbdooPV3m403rDUnYiI50wuo4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-hR2O6NUEN6e3Qd_ql0qCNQ-1; Mon, 20 Mar 2023 08:59:38 -0400
X-MC-Unique: hR2O6NUEN6e3Qd_ql0qCNQ-1
Received: by mail-pj1-f71.google.com with SMTP id ip12-20020a17090b314c00b0023f7dfb7d7fso1265581pjb.6
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 05:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679317177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTSiCVrkmtA/WRJGm80v372Yg5wNlTp3W5OIt13Gx84=;
        b=KZl96uOBqxRv7Nu8NWREz8TpLVodponpxvTl1hjywSlOonLX2VxSfhF3KtSORNBAkm
         wUD1nB4Oav/jFdomQnEsnYSIJp6QyFz78yB38dymRPG5GgOwPueQAnZrvvaAYjkIz7Lt
         B27+5OQoDy7pORsU+P8rwWHRoJAjOrpMeG1PJRx2f1Sah1kN0pQrjKGBAjWR43HA+TuA
         J3an6U/FQj1LkbxVO3NO2UF3TYWkz+VVszRuWqu++hx9K9OFLh2m3XvLMgdxdqv0+KX5
         wYGM+7S9VLz97jUfK/TFzSK4CLUh8zZ+86w6GUc//avtAScjWwzAdXcQDX6IccsaEyte
         aupQ==
X-Gm-Message-State: AO0yUKWyaEG2Qdbxpkj+38bC4EjCyeISS8etQOfGv4nykAdJ16lTrBhA
        SZJMDcfU4X5UoAV2yT0ww8FDBzW0K3QADugRiWAYVOQM/fMSSBE1Wvk3h1UbzUxRpOy32yhYD6J
        W698syPUt/60dz3arjvNQjOCAdIwR38na5PdJPYCpdtCCdj0=
X-Received: by 2002:a05:6a00:218b:b0:625:cda5:c28c with SMTP id h11-20020a056a00218b00b00625cda5c28cmr7097653pfi.6.1679317176895;
        Mon, 20 Mar 2023 05:59:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set84UDv9mh9vCptyASKtvEjk+3uzkpTot3vYwSznIGgN1FSFqOiKRvtme34T1rkXOd5p84kODAaMYdTotIVoGZw=
X-Received: by 2002:a05:6a00:218b:b0:625:cda5:c28c with SMTP id
 h11-20020a056a00218b00b00625cda5c28cmr7097641pfi.6.1679317176459; Mon, 20 Mar
 2023 05:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230309143741.346749-1-omosnace@redhat.com> <CAEjxPJ6Ft_BZ2pLAdhgS+XPZdKgVrxGYUdZM=VZQ0THR0RQvvw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Ft_BZ2pLAdhgS+XPZdKgVrxGYUdZM=VZQ0THR0RQvvw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 20 Mar 2023 13:59:24 +0100
Message-ID: <CAFqZXNsRgOGpQD4XpOg_DDymz4BXuxvA9m9nBdxOaT+=ZTm1mA@mail.gmail.com>
Subject: Re: [PATCH userspace] libsemanage: include more parameters in the
 module checksum
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 17, 2023 at 2:02=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 9, 2023 at 9:41=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > The check_ext_changes option currently assumes that as long as the
> > module content is unchanged, it is safe to assume that the policy.linke=
d
> > file doesn't need to be rebuilt. However, there are some additional
> > parameters that can affect the content of this policy file, namely:
> > * the disable_dontaudit and preserve_tunables flags
> > * the target_platform and policyvers configuration values
> >
> > Include these in the checksum so that the option works correctly when
> > only some of these input values are changed versus the current state.
> >
> > Fixes: 286a679fadc4 ("libsemanage: optionally rebuild policy when modul=
es are changed externally")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Feel free to merge it.

Thanks, merged:
https://github.com/SELinuxProject/selinux/commit/a171ba62bbba891a8dce223932=
7b1d905f695b82

> I was wondering if we ought to somehow unify
> the logic around do_rebuild and check_ext_changes to ensure that an
> update to one is also reflected in the other but that can be done
> later. I don't think do_rebuild currently is set based on
> target_platform or policyvers, likely because we don't ever change the
> former and we only change the latter for libsepol upgrades that
> support newer kernel policy versions and the kernel will cheerfully
> accept the older policy versions (and the new policy version likely
> won't be leveraged until there is an actual change to a policy module
> to use some new feature).

Yeah, I may have gone a bit overboard with those two parameters, but I
wanted to be safe rather than sorry.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

