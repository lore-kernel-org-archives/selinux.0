Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09046C432C3
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F5C2071E
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoSxs3Lm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfK0PVu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:21:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31722 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbfK0PVu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 10:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574868108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgzBedjQeBmYD4RlVldyWP+I+etiSZYlpu2RCrtolBA=;
        b=OoSxs3LmjakMBwQBtIq+ccS9Nn9GoW9rz54gjXkV/e/PTGabxppiig0Sk/8rnrpoVuzAvA
        E+J3JnBlCRwWYSbmvM00gTumk+NuV3EJG0VjCR/5DH0cTHt3fWUt0/u06kqCmRrZLNUCBN
        irdniJNnGDisoAtomzEsUKCPZyQ3lAs=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-GGU1RRgmO52ISidX5q6vrQ-1; Wed, 27 Nov 2019 10:21:46 -0500
Received: by mail-oi1-f197.google.com with SMTP id n30so11294837oij.9
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2019 07:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZkDHKUhxay9h3UjcErJdzoFsadbcneC4P5qP3o2n9A=;
        b=Vqe2P8Ru62hQdjSpg02KQTZtlvhuko975rFpPEtZ14bUg6qFVPdGLcwKLAeNfPq/rH
         qgUcjqX0B7vYN7fHogDNb91jmIkHcUTyr+wDnzpgOw2eYH85Zv4kIr16T1JJHR6iUTUo
         FEGkJRj5l1E+k9PTWSL/gqYMRJFTWG26F0ON+EzufHEWD+PgYMGc+Xrp42WjbQWjQE9i
         pvQq/XFzO4ReVb6oVW496UjqLLoVmqr6+mJ/m/VjSYc/FVGWKQtwhxEgJom2COO2/mg0
         h2dLs3vYFRfjwErbNAuVgw5sH4ui+ivDbc+lmF2gQDLeCRnuLp1E6fyrHlEqvAvCDSKE
         NaOQ==
X-Gm-Message-State: APjAAAXbfMt6ao0ikkI/mkawENcBXop3jpAah78NfGAhbK33/bJT0bbA
        qPyxqU8y5A7ai+yqwiCsqDRjjXZHSZaq56YhGgVjFUQkCkTS7aJRqzLUNkrNydxbTk2pQOg6zuE
        NxTRlsHvu7bMOvk9xV7j4CuwabRnIq0322w==
X-Received: by 2002:a05:6808:2d8:: with SMTP id a24mr4629056oid.127.1574868105502;
        Wed, 27 Nov 2019 07:21:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVUt0/ba8FiEP/KCCDEB3D7GenbPdeGj2jExaGyWMO7BiEDjSTzW7k3URKaRnu6KPUz1SgtGyfJnpLwHCe60M=
X-Received: by 2002:a05:6808:2d8:: with SMTP id a24mr4629028oid.127.1574868105169;
 Wed, 27 Nov 2019 07:21:45 -0800 (PST)
MIME-Version: 1.0
References: <157486604069.70468.14139138243381994891.stgit@chester>
In-Reply-To: <157486604069.70468.14139138243381994891.stgit@chester>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 Nov 2019 16:21:48 +0100
Message-ID: <CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update the dependencies in README.md
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: GGU1RRgmO52ISidX5q6vrQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 27, 2019 at 3:47 PM Paul Moore <paul@paul-moore.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> The new kernel module tests added in a68d583c2a70 ("selinux-testsuite:
> Add kernel module tests") require the kernel-devel package on Fedora,
> make sure we list that in the README.md file.

Thanks, I should have thought of this when reviewing the patch :)

>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  README.md |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index e845df8..4352796 100644
> --- a/README.md
> +++ b/README.md
> @@ -53,6 +53,7 @@ similar dependencies):
>  * attr _(tools used by the overlayfs tests)_
>  * libbpf-devel _(tools used by the bpf tests)_
>  * keyutils-libs-devel _(tools used by the keys tests)_
> +* kernel-devel _(used by the kernel module tests)_
>
>  On a modern Fedora system you can install these dependencies with the
>  following command:
> @@ -69,7 +70,8 @@ following command:
>                 lksctp-tools-devel \
>                 attr \
>                 libbpf-devel \
> -               keyutils-libs-devel
> +               keyutils-libs-devel \
> +               kernel-devel

I'm wondering whether we should rather put kernel-devel-$(uname -r)
here, to make sure that the right package is installed that
corresponds to the running kernel version (which may not be the latest
version that dnf will fetch). Or if the use of shell expansion feels
too clever, then we should at last document that the command may not
always install the version that is needed.

>
>  The testsuite requires a pre-existing base policy configuration of SELin=
ux,
>  using either the old example policy or the reference policy as the basel=
ine.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

