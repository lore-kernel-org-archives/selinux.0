Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C329BC2D0A3
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48FAB221F9
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clWGyMmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgKDHvi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 02:51:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbgKDHvi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 02:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604476297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RTXqb4uMLNfZdeL6ojMGTCNdvfZ9kcIIvJ+MXGHr3Rk=;
        b=clWGyMmfgsP5IQzCr3MXiBvwjcDxzvYLSt/sPR5nueQDxotmSXuBmApIIUTOI+NlyuOd9V
        jKes+71dadWtyppT24BP+IeSXn8jX3sPBa1vPYKp3NsXRc4iX52DR3FKYbrIPUmZvz+F48
        cQJFVKXsseSKWQfU4Ei+eRlN4cWeZBQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-jMRqQIMXPliD6c8CcSjBig-1; Wed, 04 Nov 2020 02:51:32 -0500
X-MC-Unique: jMRqQIMXPliD6c8CcSjBig-1
Received: by mail-lj1-f198.google.com with SMTP id i3so8035740lja.15
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2020 23:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTXqb4uMLNfZdeL6ojMGTCNdvfZ9kcIIvJ+MXGHr3Rk=;
        b=g0HscYY8DXlUSfXVq0VMbTllMCahLgfHP6s9M8V17rg3OP0aS5+CTQtlGEaSPs3KII
         M0y7KrOscmF24TgkBxPjQCnDgMDZvFgKhPYsN5aCC+DlXAq/VOo7JPBkx9xkSw56CUJw
         olA5AhnlHTUvP/14OziXipYkWcKNskZikLLprFpcv4jdm3enKiXpszuAwqf9U4XqcJfd
         nAYki0y9a0gPRiRSHbEBMRUxG76QZEcDTx5rF7X1mVuJcmXkJBq6xjli1kVokDqvWo8j
         hkcSxk3O3NwKhgyz3Dnnm50FXfNjzaq0K6xv0OVrBhoZU06ihthBI+xtVXqSoo3KPnY2
         EeFw==
X-Gm-Message-State: AOAM532MZmgyRFWo20zamJUYAjB7q8XM8hB05hsZ+32vkp+qDXSSLsto
        UuMH4gNSr1iFeAZU9EVAxBPOwqQl0AbGmBQbBoIJ4YHE0EM7WYbVaizCjGUU0OGsZk7i0JIOSlO
        8O36AB5FjR4ACRRqiRZfVwvvwLrsUX7kvcA==
X-Received: by 2002:ac2:51cb:: with SMTP id u11mr8310031lfm.247.1604476290722;
        Tue, 03 Nov 2020 23:51:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfh4NVeqr8Ry4D5VNsLsUep/nkZnbPa+loxWhZnoajJeWBOW5knw1ud2VrR8ff2hjOZw8JcR7LxndURI87CtE=
X-Received: by 2002:ac2:51cb:: with SMTP id u11mr8310026lfm.247.1604476290509;
 Tue, 03 Nov 2020 23:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20201102110223.493899-1-omosnace@redhat.com>
In-Reply-To: <20201102110223.493899-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 4 Nov 2020 08:51:19 +0100
Message-ID: <CAFqZXNs1qf+KD-HUEnRgKxThxY4Q0gPwGxayOs6Ggch4uBtebg@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: handle the case of multiple rawhide images
To:     SElinux list <selinux@vger.kernel.org>
Cc:     William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 2, 2020 at 12:02 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> For whatever reason, some mirrors contain more than one image version in
> the directory, causing the test to bail out. This happens only sometimes
> and restarting the Travis job usually helps, but it's better to adapt
> the script to handle this case.
>
> Tweak the script to pick the lexicographically last image and exit with
> error only if there is no image at all.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  travis-ci/run-kvm-test.sh | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
> index 6afbf96..bb7c3b7 100755
> --- a/travis-ci/run-kvm-test.sh
> +++ b/travis-ci/run-kvm-test.sh
> @@ -36,8 +36,9 @@ VCPUS="$(nproc)"
>  #  - https://alt.fedoraproject.org/en/verify.html
>  cd "$HOME"
>  wget -r -nd -np -l 1 -H -e robots=off -A "*.raw.xz,*-CHECKSUM" "$BASE_URL"
> -if [ $(ls -1q *.raw.xz | wc -l) -ne 1 ]; then
> -    echo "$0: too many image files downloaded!" 1>&2
> +latest_image="$(ls -1q *.raw.xz | tail -n 1)"
> +if [ -z "$latest_image" ]; then
> +    echo "$0: no image file downloaded!" 1>&2
>      exit 1
>  fi
>
> @@ -49,7 +50,8 @@ fi
>  sha256sum --ignore-missing -c ./*-CHECKSUM
>
>  # Extract the image
> -unxz -T0 *.raw.xz
> +unxz -T0 "$latest_image"
> +latest_image="${latest_image%.xz}"
>
>  # Search is needed for $HOME so virt service can access the image file.
>  chmod a+x "$HOME"
> @@ -60,7 +62,7 @@ chmod a+x "$HOME"
>  #   - Enable passwordless login
>  #     - Force a relabel to fix labels on ssh keys
>  #
> -sudo virt-sysprep -a *.raw \
> +sudo virt-sysprep -a "$latest_image" \
>    --root-password password:123456 \
>    --hostname fedoravm \
>    --append-line '/etc/ssh/sshd_config:PermitRootLogin yes' \
> @@ -81,7 +83,7 @@ sudo virt-install \
>    --name fedoravm \
>    --memory $MEMORY \
>    --vcpus $VCPUS \
> -  --disk *.raw \
> +  --disk "$latest_image" \
>    --import --noautoconsole
>
>  #
> --
> 2.26.2

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/025fe57d9b707c925590b78c26dfc9726a4a3933

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

