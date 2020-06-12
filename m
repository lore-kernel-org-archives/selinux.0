Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E892AC433E0
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 05:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA691207ED
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 05:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5unL0RT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgFLFjx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:39:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42076 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725763AbgFLFjx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jun 2020 01:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591940391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZmwrkZVa/GYX5ygWzG0NDUdIN34EOZdFdNPtifPyHWA=;
        b=O5unL0RTS8OUUaejOoN6QhEUG9QPBNPdhFqNPzdqsEtD4ub3iESrshk6WOCoF0VaqtZ3r0
        NVpejicVjZuB13V+XKcKOqbn4c/5B1l4NQL5Cyg5QQP5wTDAnMixUQv/z8/xcfEkwMHZpP
        /6+cnbZ7dr/bHF6iqqqV+vKpikSQW7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-LPM_hqvpNNGDhmKWzHQ63A-1; Fri, 12 Jun 2020 01:39:46 -0400
X-MC-Unique: LPM_hqvpNNGDhmKWzHQ63A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16B11801504;
        Fri, 12 Jun 2020 05:39:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78C095D9CA;
        Fri, 12 Jun 2020 05:39:43 +0000 (UTC)
Date:   Fri, 12 Jun 2020 07:39:40 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, bill.c.roberts@gmail.com,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: Re: [PATCH v2] ci: dont use hardcoded project name
Message-ID: <20200612053940.GA540562@localhost.localdomain>
References: <CAFftDdrszrtxO64GtiGKyszae-rNv9Kohzs-jwmxgtW3rfTnJw@mail.gmail.com>
 <20200611173039.21742-1-william.c.roberts@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200611173039.21742-1-william.c.roberts@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 12:30:39PM -0500, bill.c.roberts@gmail.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
>=20
> Not everyone's github project is "selinux" so use the projects
> name, as derived from TRAVIS_BUILD_DIR. TRAVIS_BUILD_DIR is
> the absolute path to the project checkout on disk, so the
> basename should be sufficient. The script that runs in the KVM
> environment also needs to be updated where it can find the
> selinux project code, so we pass it in through an env variable
> in the ssh command.
>=20
> Tested on Travis CI here:
>   - https://travis-ci.org/github/williamcroberts/selinux/jobs/697307824
>=20
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!

> ---
> v2:
>  - Fix the KVM script project location when it's not /root/selinux.
>=20
>  scripts/ci/fedora-test-runner.sh | 10 ++++++++--
>  scripts/ci/travis-kvm-setup.sh   |  6 ++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-ru=
nner.sh
> index 0927ed5dad8f..569723387f6b 100755
> --- a/scripts/ci/fedora-test-runner.sh
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -2,6 +2,12 @@
> =20
>  set -ev
> =20
> +#
> +# We expect this to be set in the environment, but if it's not, most sel=
inux projects
> +# just have the same name as upstream, so choose that.
> +#
> +export SELINUX_DIR=3D"${SELINUX_DIR:-/root/selinux}"
> +
>  # CI Debug output if things go squirrely.
>  getenforce
>  id -Z
> @@ -58,7 +64,7 @@ dnf install -y \
>  #
>  # Move to selinux code and build
>  #
> -cd "$HOME/selinux"
> +cd "$SELINUX_DIR"
> =20
>  # Show HEAD commit for sanity checking
>  git log -1
> @@ -71,7 +77,7 @@ make -j"$(nproc)" LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64=
 install-pywrap
>  make -j"$(nproc)" LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 relabel
> =20
>  #
> -# Get the selinux testsuite, but don't clone it in $HOME/selinux, move t=
o $HOME
> +# Get the selinux testsuite, but don't clone it in selinux git directory=
, move to $HOME
>  # first.
>  #
>  cd "$HOME"
> diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup=
.sh
> index 864dbac96a46..8d4cfb79f7d7 100755
> --- a/scripts/ci/travis-kvm-setup.sh
> +++ b/scripts/ci/travis-kvm-setup.sh
> @@ -118,8 +118,10 @@ fi
>  #
>  # Great we have a host running, ssh into it. We specify -o so
>  # we don't get blocked on asking to add the servers key to
> -# our known_hosts.
> +# our known_hosts. Also, we need to forward the project directory
> +# so forks know where to go.
>  #
> -ssh -tt -o StrictHostKeyChecking=3Dno -o LogLevel=3DQUIET "root@$ipaddy"=
 "/root/selinux/$TEST_RUNNER"
> +project_dir=3D"$(basename "$TRAVIS_BUILD_DIR")"
> +ssh -tt -o StrictHostKeyChecking=3Dno -o LogLevel=3DQUIET "root@$ipaddy"=
 "SELINUX_DIR=3D/root/$project_dir /root/$project_dir/$TEST_RUNNER"
> =20
>  exit 0
> --=20
> 2.17.1
>=20

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7jFRYACgkQviIJHj72
InUqtRAApEao9Nj5UxdH5lKy4t83FDeqtQ1vHj1bXRlDMGLHWIFm5M+lNz31K0I9
H/OUdP6GjFep/Ph0eXFNTzDrSzgRgYx41WWInry7K5L2ATxASl/Lsyd3vQW9L1r+
xEsrwaUaNelal05sJXjxacvg2a1324OInIAJPOxVFcgVZ6EKibyn8EMlivhTPGci
eP7Vnxq+mc3fIcRtZYarkl3yLTSmxk2+uGCf+V9EXMX4Q1Hem5QW1iF6+P3puDBA
hdqiRZYIRFOI7uDHDVvRTnJzbhto7fAoPVWw5akZ5Ijp0pd5bKW6q+JJHUKbY+bS
xLhxdMmxbPRr757O4WLYTzKzO+K3tM1KJeu/k6Qan/T0YvPEf5DoT6B/p9iBHuSl
CVxT8YdFuV9rVxqaDz+gduV31IX09Rcc1mHW44gka1PUH12hq/7lOYV2Q3J6pylW
26LvK06tpOtUCyfmTAspWtbw+WkQlarie57DrPfkFsLC4eiXPAU2AVXly+Eshh5w
x4n07C9WtdtYcX9iyPeSGXOsi5bmFnc6xuZvvgf6z4rD5OtC54/LdE2XJm4VIGV5
7drqkJ5QfhzoABPws+6lpTWETnovOudqAMi0cy3egfCD43sAdHUaDbLcjnfKAC/f
5eZGaBEhy25pfn0ttuuk/IzAfpu8dw58BjnBT4EgXJ+wdJL+M8E=
=Kolb
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

