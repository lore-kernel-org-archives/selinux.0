Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F01C433DF
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78697206C3
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROUFgCfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgFKMCP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:02:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28656 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726697AbgFKMCP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 08:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591876932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=woA8ahnCz5xjT0m8IRVsUNU4VYd6uLFV/fgsApuS3is=;
        b=ROUFgCfm9k3XrtW22FCuA6VkC9lywR4VvnDKKlAICNXHSh6R/v01Cwoj5Tlmytc1ZKhne5
        r2g207Sc21820k/SbygAlZu+hUHZN3YU4wLoEjd8TI+Ye1P837A8bgXJQT4KKYALa5XYEz
        9VJSJZlleQCnEfD/7B+cgvC1/oIY6vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-HwXMUaK0OfCa8vsLM0dHqQ-1; Thu, 11 Jun 2020 08:01:54 -0400
X-MC-Unique: HwXMUaK0OfCa8vsLM0dHqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A0C0EC1A4;
        Thu, 11 Jun 2020 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 652DB100238D;
        Thu, 11 Jun 2020 12:01:48 +0000 (UTC)
Date:   Thu, 11 Jun 2020 14:01:45 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, bill.c.roberts@gmail.com,
        William Roberts <william.c.roberts@intel.com>
Subject: Re: [PATCH v3] ci: run SELinux kernel test suite
Message-ID: <20200611120145.GA453655@localhost.localdomain>
References: <20200520163421.27965-1-william.c.roberts@intel.com>
 <20200602191856.5040-1-william.c.roberts@intel.com>
 <20200602191856.5040-2-william.c.roberts@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200602191856.5040-2-william.c.roberts@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 02:18:56PM -0500, bill.c.roberts@gmail.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
>=20
> The current Travis CI runs the userspace tooling and libraries against
> policy files, but cannot test against an SELinux enabled kernel. Thus,
> some tests are not being done in the CI. Travis, unfortunately only
> provides Ubuntu images, so in order to run against a modern distro with
> SELinux in enforcing mode, we need to launch a KVM with something like
> Fedora.
>=20
> This patch enables this support by launching a Fedora32 Cloud Image with
> the SELinux userspace library passed on from the Travis clone, it then
> builds and replaces the current SELinux bits on the Fedora32 image and
> runs the SELinux testsuite.
>=20
> The cloud image run can be controlled with the TRAVIS env variable:
> TRAVIS_CLOUD_IMAGE_VERSION. That variable takes the major and minor
> version numbers in a colon delimited string, eg: "32:1.6".
>=20
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

I pushed all Acked bugs to my fork's branch 3.1-rc2 and the travis jobs fai=
led:

https://travis-ci.org/github/bachradsusi/SELinuxProject-selinux/jobs/697177=
370

~~~
#
# Great we have a host running, ssh into it. We specify -o so
# we don't get blocked on asking to add the servers key to
# our known_hosts.
#
ssh -tt -o StrictHostKeyChecking=3Dno -o LogLevel=3DQUIET "root@$ipaddy" "/=
root/selinux/$TEST_RUNNER"
bash: /root/selinux/scripts/ci/fedora-test-runner.sh: No such file or direc=
tory
The command "scripts/ci/travis-kvm-setup.sh" exited with 127.

Done. Your build exited with 1.
~~~


> ---
>  .travis.yml                      |   8 ++
>  scripts/ci/README.md             |   8 ++
>  scripts/ci/fedora-test-runner.sh |  87 +++++++++++++++++++++
>  scripts/ci/travis-kvm-setup.sh   | 125 +++++++++++++++++++++++++++++++
>  4 files changed, 228 insertions(+)
>  create mode 100644 scripts/ci/README.md
>  create mode 100755 scripts/ci/fedora-test-runner.sh
>  create mode 100755 scripts/ci/travis-kvm-setup.sh
>=20
> diff --git a/.travis.yml b/.travis.yml
> index c36e721a5e1d..bd3c98420c24 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -34,6 +34,14 @@ matrix:
>        env: PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 LINKER=3Dgold
>      - compiler: clang
>        env: PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 LINKER=3Dbfd
> +  include:
> +    - compiler: gcc
> +      env: TRAVIS_RUN_KVM=3Dtrue TRAVIS_CLOUD_IMAGE_VERSION=3D"32:1.6"
> +      install:
> +        - skip
> +      before_script:
> +        - skip
> +      script: scripts/ci/travis-kvm-setup.sh
> =20
>  # Use Travis-CI Ubuntu 18.04 Bionic Beaver, "full image" variant
>  sudo: required
> diff --git a/scripts/ci/README.md b/scripts/ci/README.md
> new file mode 100644
> index 000000000000..04a134a438c2
> --- /dev/null
> +++ b/scripts/ci/README.md
> @@ -0,0 +1,8 @@
> +# Continuous Integration Scripts
> +
> +The scripts under `scripts/ci` are designed specifically
> +for the Travis CI system. While nothing prevents you
> +from mimicking that environment and using them locally,
> +they are not applicable for general consumption. Any
> +thing in this directory should never be considered as
> +a stable API.
> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-ru=
nner.sh
> new file mode 100755
> index 000000000000..0927ed5dad8f
> --- /dev/null
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -0,0 +1,87 @@
> +#!/usr/bin/env bash
> +
> +set -ev
> +
> +# CI Debug output if things go squirrely.
> +getenforce
> +id -Z
> +nproc
> +pwd
> +
> +# Turn off enforcing for the setup to prevent any weirdness from breakin=
g
> +# the CI.
> +setenforce 0
> +
> +dnf clean all -y
> +dnf install -y \
> +    --allowerasing \
> +    --skip-broken \
> +    git \
> +    audit-libs-devel \
> +    bison \
> +    bzip2-devel \
> +    CUnit-devel \
> +    diffutils \
> +    flex \
> +    gcc \
> +    gettext \
> +    glib2-devel \
> +    make \
> +    libcap-devel \
> +    libcap-ng-devel \
> +    pam-devel \
> +    pcre-devel \
> +    xmlto \
> +    python3-devel \
> +    ruby-devel \
> +    swig \
> +    perl-Test \
> +    perl-Test-Harness \
> +    perl-Test-Simple \
> +    selinux-policy-devel \
> +    gcc \
> +    libselinux-devel \
> +    net-tools \
> +    netlabel_tools \
> +    iptables \
> +    lksctp-tools-devel \
> +    attr \
> +    libbpf-devel \
> +    keyutils-libs-devel \
> +    kernel-devel \
> +    quota \
> +    xfsprogs-devel \
> +    libuuid-devel \
> +    kernel-devel-"$(uname -r)" \
> +    kernel-modules-"$(uname -r)"
> +
> +#
> +# Move to selinux code and build
> +#
> +cd "$HOME/selinux"
> +
> +# Show HEAD commit for sanity checking
> +git log -1
> +
> +#
> +# Build and replace userspace components
> +#
> +make -j"$(nproc)" LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 install
> +make -j"$(nproc)" LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 install-pywrap
> +make -j"$(nproc)" LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 relabel
> +
> +#
> +# Get the selinux testsuite, but don't clone it in $HOME/selinux, move t=
o $HOME
> +# first.
> +#
> +cd "$HOME"
> +git clone --depth=3D1 https://github.com/SELinuxProject/selinux-testsuit=
e.git
> +cd selinux-testsuite
> +
> +# The testsuite must be run in enforcing mode
> +setenforce 1
> +
> +#
> +# Run the test suite
> +#
> +make test
> diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup=
.sh
> new file mode 100755
> index 000000000000..864dbac96a46
> --- /dev/null
> +++ b/scripts/ci/travis-kvm-setup.sh
> @@ -0,0 +1,125 @@
> +#!/usr/bin/env bash
> +
> +set -ev
> +
> +TEST_RUNNER=3D"scripts/ci/fedora-test-runner.sh"
> +
> +#
> +# Variables for controlling the Fedora Image version and download URLs.
> +#
> +MAJOR_VERSION=3D"32"
> +MINOR_VERSION=3D"1.6"
> +
> +BASE_URL=3D"https://download.fedoraproject.org/pub/fedora/linux/releases=
"
> +IMAGE_BASE_NAME=3D"Fedora-Cloud-Base-$MAJOR_VERSION-$MINOR_VERSION.x86_6=
4"
> +IMAGE_URL=3D"$BASE_URL/$MAJOR_VERSION/Cloud/x86_64/images/$IMAGE_BASE_NA=
ME.raw.xz"
> +CHECK_URL=3D"$BASE_URL/$MAJOR_VERSION/Cloud/x86_64/images/Fedora-Cloud-$=
MAJOR_VERSION-$MINOR_VERSION-x86_64-CHECKSUM"
> +GPG_URL=3D"https://getfedora.org/static/fedora.gpg"
> +
> +#
> +# Travis gives us 7.5GB of RAM and two cores:
> +# https://docs.travis-ci.com/user/reference/overview/
> +#
> +MEMORY=3D4096
> +VCPUS=3D"$(nproc)"
> +
> +# Install these here so other builds don't have to wait on these deps to=
 download and install
> +sudo apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-chec=
ker libguestfs-tools
> +
> +sudo usermod -a -G kvm,libvirt,libvirt-qemu "$USER"
> +
> +# Verify that KVM is working, useful if Travis ever changes anything.
> +kvm-ok
> +
> +sudo systemctl enable libvirtd
> +sudo systemctl start libvirtd
> +
> +# Set up a key so we can ssh into the VM
> +ssh-keygen -N "" -f "$HOME/.ssh/id_rsa"
> +
> +#
> +# Get the Fedora Cloud Image, It is a base image that small and ready to=
 go, extract it and modify it with virt-sysprep
> +#  - https://alt.fedoraproject.org/en/verify.html
> +cd "$HOME"
> +wget "$IMAGE_URL"
> +
> +# Verify the image
> +curl "$GPG_URL" | gpg --import
> +wget "$CHECK_URL"
> +gpg --verify-files ./*-CHECKSUM
> +sha256sum --ignore-missing -c ./*-CHECKSUM
> +
> +# Extract the image
> +unxz -T0 "$IMAGE_BASE_NAME.raw.xz"
> +
> +# Search is needed for $HOME so virt service can access the image file.
> +chmod a+x "$HOME"
> +
> +#
> +# Modify the virtual image to:
> +#   - Enable a login, we just use root
> +#   - Enable passwordless login
> +#     - Force a relabel to fix labels on ssh keys
> +#
> +sudo virt-sysprep -a "$IMAGE_BASE_NAME.raw" \
> +  --root-password password:123456 \
> +  --hostname fedoravm \
> +  --append-line '/etc/ssh/sshd_config:PermitRootLogin yes' \
> +  --append-line '/etc/ssh/sshd_config:PubkeyAuthentication yes' \
> +  --mkdir /root/.ssh \
> +  --upload "$HOME/.ssh/id_rsa.pub:/root/.ssh/authorized_keys" \
> +  --chmod '0600:/root/.ssh/authorized_keys' \
> +  --run-command 'chown root:root /root/.ssh/authorized_keys' \
> +  --copy-in "$TRAVIS_BUILD_DIR:/root" \
> +  --network \
> +  --selinux-relabel
> +
> +#
> +# Now we create a domain by using virt-install. This not only creates th=
e domain, but runs the VM as well
> +# It should be ready to go for ssh, once ssh starts.
> +#
> +sudo virt-install \
> +  --name fedoravm \
> +  --memory $MEMORY \
> +  --vcpus $VCPUS \
> +  --disk "$IMAGE_BASE_NAME.raw" \
> +  --import --noautoconsole
> +
> +#
> +# Here comes the tricky part, we have to figure out when the VM comes up=
 AND we need the ip address for ssh. So we
> +# can check the net-dhcp leases, for our host. We have to poll, and we w=
ill poll for up to 3 minutes in 6 second
> +# intervals, so 30 poll attempts (0-29 inclusive).
> +#
> +# We have a full reboot + relabel, so first sleep gets us close
> +#
> +sleep 30
> +for i in $(seq 0 29); do
> +    echo "loop $i"
> +    sleep 6s
> +    # Get the leases, but tee it so it's easier to debug
> +    sudo virsh net-dhcp-leases default | tee dhcp-leases.txt
> +
> +    # get our ipaddress
> +    ipaddy=3D"$(grep fedoravm dhcp-leases.txt | awk '{print $5}' | cut -=
d'/' -f 1-1)"
> +    if [ -n "$ipaddy" ]; then
> +        # found it, we're done looking, print it for debug logs
> +        echo "ipaddy: $ipaddy"
> +        break
> +    fi
> +    # it's empty/not found, loop back and try again.
> +done
> +
> +# Did we find it? If not die.
> +if [ -z "$ipaddy" ]; then
> +    echo "ipaddy zero length, exiting with error 1"
> +    exit 1
> +fi
> +
> +#
> +# Great we have a host running, ssh into it. We specify -o so
> +# we don't get blocked on asking to add the servers key to
> +# our known_hosts.
> +#
> +ssh -tt -o StrictHostKeyChecking=3Dno -o LogLevel=3DQUIET "root@$ipaddy"=
 "/root/selinux/$TEST_RUNNER"
> +
> +exit 0
> --=20
> 2.17.1
>=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7iHSMACgkQviIJHj72
InUu0w/9HXWo9mooSm5wWQyLERlgRcfEh7x8xFLEtoABOStbgUDMlXX6I3voLTWW
ZHK+QF8a3i7aFjFXl8+B4v5YlfeVaypFn8BEszQT8w3mYtb/VuSqQ4Ha28xFCAre
pM4bjRxKWRDinx/4lNP4iv9kcsriVbdnNzy33sTf/XXFUxdokcH7I9AqMT0KpA6U
QFduuJmwKY+DTTv71nemNOYw19Bf2+r7QnxbQY3qZloru/iWBJ7Z4lVE0VlhqMX0
/lMdq1v0lHyywhij+8uFEBB8QxqOHHPgjN8Nvsxpz6xNj+zpfdfBDGJJ0I3Qm/uv
nBvOUUoT+ZkmcKRhZN1TGVPfvtelnENuT9vJoGNf9DvwCRO7Es4yGyMaVl2zyCGd
nW+S5UOxPevKP2PrXLbXDojBOPSVe0k7LS2vhL/AAlCdqFi0R3SkrAb86pGPu3HN
8gbm9vKRx2BLPpF36V1dAJVxKFFdgyxuWr1y2sM+AmxwusoAmTLnw6w/t7/6annD
ZpyN8bv8HIGCvZPJ2OgvUJRRwPw0qfx0s4CDHkbMbbQM05ESgyShCkmk7F1OMam6
c5kw9ogHul5juWd8S8hoZN0FL+3CouBhD+S0KObgrW//CjetuLxz73Q1y00KylAt
45zOo70fZsWeNfE4+WQl72zk7qsIMpmAfnUfPOg7uxlyeP4X7l0=
=Wye1
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

