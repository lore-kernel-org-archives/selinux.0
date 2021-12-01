Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACB9C433F5
	for <selinux@archiver.kernel.org>; Wed,  1 Dec 2021 15:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351252AbhLAQB2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Dec 2021 11:01:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351244AbhLAQBY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Dec 2021 11:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638374281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8GjmwqPbXepHWOhKIPJ35oALgq8tUwygHXa2KwUK2ok=;
        b=Oc0fq1aqjO2/rW/LNWlUQSB6hQDna3R9Q2RpoLNyOchUGzW5trfpxrhP7ue5apLkzPYRFT
        oGIzZxWxl70SF+hgOuSVdo8Zz35AsEvY02yJQqqdWRJBh4nFKL0chQLhyO6QffGVcqLbgg
        2R8lVRnsf5xKnQDYxnW/GFuV87/2e70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-AUATLKVoMQe-r1b8HCCoSw-1; Wed, 01 Dec 2021 10:57:52 -0500
X-MC-Unique: AUATLKVoMQe-r1b8HCCoSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFE4187499D;
        Wed,  1 Dec 2021 15:57:51 +0000 (UTC)
Received: from localhost (unknown [10.40.193.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 457227095E;
        Wed,  1 Dec 2021 15:57:51 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 3/3] Replace PCRE with PCRE2 build dependencies
In-Reply-To: <20211123183249.6133-3-cgzones@googlemail.com>
References: <20211123183249.6133-1-cgzones@googlemail.com>
 <20211123183249.6133-3-cgzones@googlemail.com>
Date:   Wed, 01 Dec 2021 16:57:50 +0100
Message-ID: <87mtlk1fnl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Now that libselinux defaults to PCRE2 and mcstrans has been ported,
> update all documentation and scripts.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>



> ---
>  .circleci/config.yml             | 2 +-
>  .github/workflows/run_tests.yml  | 2 +-
>  CONTRIBUTING.md                  | 2 +-
>  README.md                        | 4 ++--
>  scripts/ci/fedora-test-runner.sh | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/.circleci/config.yml b/.circleci/config.yml
> index 5d3177da..af20484b 100644
> --- a/.circleci/config.yml
> +++ b/.circleci/config.yml
> @@ -13,7 +13,7 @@ jobs:
>=20=20
>      # Install dependencies
>      - run: sudo apt-get update -qq
> -    - run: sudo apt-get install -qq bison clang clang-tools flex gawk ge=
ttext libaudit-dev libcap-dev libcap-ng-dev libcunit1-dev libdbus-glib-1-de=
v libpcre3-dev python3-dev python-dev ruby-dev swig xmlto
> +    - run: sudo apt-get install -qq bison clang clang-tools flex gawk ge=
ttext libaudit-dev libcap-dev libcap-ng-dev libcunit1-dev libdbus-glib-1-de=
v libpcre2-dev python3-dev python-dev ruby-dev swig xmlto
>=20=20
>      - run:
>          name: Setup environment variables
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_test=
s.yml
> index ef4be8af..01fbbbe5 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -57,7 +57,7 @@ jobs:
>              libcap-ng-dev \
>              libcunit1-dev \
>              libdbus-glib-1-dev \
> -            libpcre3-dev \
> +            libpcre2-dev \
>              python3-dev \
>              python-dev \
>              ruby-dev \
> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> index a3517cb8..7c548e58 100644
> --- a/CONTRIBUTING.md
> +++ b/CONTRIBUTING.md
> @@ -26,7 +26,7 @@ using a custom policy please include it as well.
>  There are a number of dependencies required to build the userspace
>  tools/libraries. On a Fedora system you can install them with yum:
>=20=20
> -    # yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-gli=
b-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-deve=
l pam-devel pcre-devel python-devel setools-devel swig ustr-devel
> +    # yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-gli=
b-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-deve=
l pam-devel pcre2-devel python-devel setools-devel swig ustr-devel
>=20=20
>  The tools and libraries can be built and installed under a private direc=
tory from the top level with make, e.g.
>=20=20
> diff --git a/README.md b/README.md
> index e1c2fe64..74b0a0c3 100644
> --- a/README.md
> +++ b/README.md
> @@ -51,7 +51,7 @@ dnf install \
>      libcap-devel \
>      libcap-ng-devel \
>      pam-devel \
> -    pcre-devel \
> +    pcre2-devel \
>      xmlto
>=20=20
>  # For Python and Ruby bindings
> @@ -78,7 +78,7 @@ apt-get install --no-install-recommends --no-install-su=
ggests \
>      libcap-ng-dev \
>      libcunit1-dev \
>      libglib2.0-dev \
> -    libpcre3-dev \
> +    libpcre2-dev \
>      pkgconf \
>      python3 \
>      python3-distutils \
> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-ru=
nner.sh
> index f817499b..3ce2c3a6 100755
> --- a/scripts/ci/fedora-test-runner.sh
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -36,7 +36,7 @@ dnf install -y \
>      libcap-devel \
>      libcap-ng-devel \
>      pam-devel \
> -    pcre-devel \
> +    pcre2-devel \
>      xmlto \
>      python3-devel \
>      ruby-devel \
> --=20
> 2.34.0

