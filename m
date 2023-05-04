Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2CCC7EE21
	for <selinux@archiver.kernel.org>; Thu,  4 May 2023 14:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjEDOPf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 May 2023 10:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjEDOPe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 May 2023 10:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7A383FD
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683209686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4cdyKkEPxoDEMVbGTjlqEi5Ug+DxEbcQNE++nqieDU=;
        b=LdWdr2Np6NgEYB1MZ2LzN2Ki8rfXKaF1ecSmXQK4vObepZtDnkPinHk7fDttUGEhhf3MP/
        WDJy0N0bnoRFDidoo57bBkE9AU508EsFmKaiX5tX2grP/pWjGvRghM8aYCjdj3k+oWircC
        lLts9Tu11ZyXbbY6nB9uVnoRxut3ON8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-WigIXf3nMNKZ06mfZX91yw-1; Thu, 04 May 2023 10:14:44 -0400
X-MC-Unique: WigIXf3nMNKZ06mfZX91yw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-643989eed04so137272b3a.1
        for <selinux@vger.kernel.org>; Thu, 04 May 2023 07:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683209683; x=1685801683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4cdyKkEPxoDEMVbGTjlqEi5Ug+DxEbcQNE++nqieDU=;
        b=POY6H1LBBrqVAp47/9yEYsmmjpYaPC44zz/aBvMiLWLGeIItR71tsmOXgcCd2w6Zky
         mPNpYXNIB3bYZPr3bGNgHSmrW9TACrgqE2CJIHZipOSDI7pDR+H+xnB3PxJ1KjL98+Yi
         WkLnSNky+054S7pR27s26uNd8YIbV4340iupufoPK2T1OCwtueOzpRyyce4j4w8fWFZ+
         3dGkRj6gC+9mXgVsmB5DDFGb8OAoFBfr5Mok86jiib9OUhW1q6BbSMRHuj3gHSRB6hXG
         1ZzrC/DQqNQgmmihTwrGz94SIpkUjtYKUnoVHA59aX1XgSaiCVJQxxXEDIIv2rSDoKzS
         nlKA==
X-Gm-Message-State: AC+VfDyd2VHcKO37iRQNXHblu33WLbMZzGskDJQpUT23+Mb8Ba+hejP2
        a+laPaHt0laUYISB850QDVV79ryX7SEHJnaBaPLhFzQ7SclTeRNLhL84c23PfKy8JOsc1fSTEZ8
        XJIMKVAcdNDlmn8ew6AEEIzDkQQuSTNa7gw==
X-Received: by 2002:a05:6a00:248b:b0:643:6fa2:9bef with SMTP id c11-20020a056a00248b00b006436fa29befmr2894112pfv.20.1683209683101;
        Thu, 04 May 2023 07:14:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4y7cBClrLOAGdXVFtpclUAEu+7WeDA4VqonOPsm46O5gkdhb1DHoEQcktMPokcUbxSTVmQhEARopB669XN6Qg=
X-Received: by 2002:a05:6a00:248b:b0:643:6fa2:9bef with SMTP id
 c11-20020a056a00248b00b006436fa29befmr2894069pfv.20.1683209682774; Thu, 04
 May 2023 07:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-0-e7a3c8c15676@tessares.net>
In-Reply-To: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-0-e7a3c8c15676@tessares.net>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 4 May 2023 16:14:31 +0200
Message-ID: <CAFqZXNt16B5A2o6fZeN5b1coNCW2m6kp7JToJFDorvPajhFyxA@mail.gmail.com>
Subject: Re: [PATCH LSM v2 0/2] security: SELinux/LSM label with MPTCP and accept
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 20, 2023 at 7:17=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> In [1], Ondrej Mosnacek explained they discovered the (userspace-facing)
> sockets returned by accept(2) when using MPTCP always end up with the
> label representing the kernel (typically system_u:system_r:kernel_t:s0),
> while it would make more sense to inherit the context from the parent
> socket (the one that is passed to accept(2)). Thanks to the
> participation of Paul Moore in the discussions, modifications on MPTCP
> side have started and the result is available here.
>
> Paolo Abeni worked hard to refactor the initialisation of the first
> subflow of a listen socket. The first subflow allocation is no longer
> done at the initialisation of the socket but later, when the connection
> request is received or when requested by the userspace. This was a
> prerequisite to proper support of SELinux/LSM labels with MPTCP and
> accept. The last batch containing the commit ddb1a072f858 ("mptcp: move
> first subflow allocation at mpc access time") [2] has been recently
> accepted and applied in netdev/net-next repo [3].
>
> This series of 2 patches is based on top of the lsm/next branch. Despite
> the fact they depend on commits that are in netdev/net-next repo to
> support the new feature, they can be applied in lsm/next without
> creating conflicts with net-next or causing build issues. These two
> patches on top of lsm/next still passes all the MPTCP-specific tests.
> The only thing is that the new feature only works properly with the
> patches that are on netdev/net-next. The tests with the new labels have
> been done on top of them.
>
> Regarding the two patches, the first one introduces a new LSM hook
> called from MPTCP side when creating a new subflow socket. This hook
> allows the security module to relabel the subflow according to the owing
> process. The second one implements this new hook on the SELinux side.
>
> Link: https://lore.kernel.org/netdev/CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBk=
MkwFeM6qEwMKCTw@mail.gmail.com/ [1]
> Link: https://git.kernel.org/netdev/net-next/c/ddb1a072f858 [2]
> Link: https://lore.kernel.org/netdev/20230414-upstream-net-next-20230414-=
mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net/ [3]
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Changes in v2:
> - Address Paul's comments, see the notes on each patch
> - Link to v1: https://lore.kernel.org/r/20230419-upstream-lsm-next-202304=
19-mptcp-sublows-user-ctx-v1-0-9d4064cb0075@tessares.net
>
> ---
> Paolo Abeni (2):
>       security, lsm: Introduce security_mptcp_add_subflow()
>       selinux: Implement mptcp_add_subflow hook
>
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  net/mptcp/subflow.c           |  6 ++++++
>  security/security.c           | 17 +++++++++++++++++
>  security/selinux/hooks.c      | 16 ++++++++++++++++
>  security/selinux/netlabel.c   |  8 ++++++--
>  6 files changed, 52 insertions(+), 2 deletions(-)
> ---
> base-commit: d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> change-id: 20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-eee=
658fafcba
>
> Best regards,
> --
> Matthieu Baerts <matthieu.baerts@tessares.net>
>

I haven't yet looked closer at the code in this series, but I can at
least confirm that with the series (applied on top of net-next) the
selinux-testsuite now passes when run under mptcpize, with one caveat:

The "client" test prog in the inet_socket subtest sets the SO_SNDTIMEO
socket option on the client socket, but the subtest takes
significantly longer to complete than when run without mptcpize. That
suggests to me that there is possibly some (pre-existing) issue with
MPTCP where the send/receive timeouts are not being passed to the
subflow socket(s), leading to a longer wait (I guess the default is
higher?) when the timeout is expected to be hit (there are test cases
where we expect packets to be dropped due to SELinux access controls,
which we detect via timeout). I'm only taking a wild guess at the root
cause here, but I hope you guys will be able to figure it out and fix
whatever needs fixing :)

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

