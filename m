Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F4DC433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7773D20760
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW0hdgMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgFKMMw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgFKMMv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 08:12:51 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F381C08C5C1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 05:12:51 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 9so5143677ilg.12
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RtIKDHmceYVYqZouTZLkHTLHLknmbAMMOy4f5bJukw=;
        b=DW0hdgMFfIdlQ0JBf1ZR61f4e1zoRxbPTDu01yis/UmpT1zk0Tj+r+yTtQoEdTyqbH
         IHzWwukCY2vpDqZe7EhCuOWMhyB1rAHyWO5hGVRtRuDxooj0av9YGpS9xY9jjZvz7l+F
         0ZWsSt5L7NbrxGBBQ8WuKn7jcBr/ugYawVr7qDGxvFpNfg6pvp/z+clVE5xcMbcYC81y
         dd59lUSfc8d/UH7hpfesoNHM0/UD1a4bFGRLcWV20DwGy7/EhHipIwfug2o3md68R7g9
         idwHY9aS4q3bhuwRqibf/MVWC3f8G1JFxO1Xv0TU6sFXZS2I+MV52euFskyAwRmPc6hd
         wSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RtIKDHmceYVYqZouTZLkHTLHLknmbAMMOy4f5bJukw=;
        b=pRRaZ3Nhn/ZiO/D1Pe3qo4qh8ThXqt5a8nN3pNnc0s0hrvUxJgQ+8eL1nsg5k8uSiS
         th4Gh3aDJVQQsfSXYJlhWTSNO/KbmoVChCu9mq2HIdz3zcTO7S9G9LahCUwXzJY/Aovq
         ZyhpYwCdQEXjL9FCF3hOjYHBY9g5eyXchKcHDn7XTTC5pKbgo5HcJBwUiBuoK0GBaYks
         XpVG60lO486fuESc3r33/+pigb4pFbZwdNzkmaejLU/cL8l0C58tXNiV24ZTqEUWIK6i
         chwHS96iSMawGZjxhV6wKkoq2l7/qY7nU/ZD/445oIm7X07neplzumgm4RCjdhQPpCpK
         K56w==
X-Gm-Message-State: AOAM532eiHn5WjQXZF7rR8kPZ6uWaupBxf6dSBABXdHxIoI5Ha8Z6wpi
        H8kp9fpa5rsGRE9U60W4Y/f+3LHmqlbj9A/IbJU=
X-Google-Smtp-Source: ABdhPJx1W63SgqGS0xE7GWEbcZ+cd46K23JEV7nickRvt1rEuAheFwWtmBJYDuNc+r6NDrG5F5W8NG+Znpg6k/l6BvA=
X-Received: by 2002:a92:b704:: with SMTP id k4mr7497116ili.129.1591877570397;
 Thu, 11 Jun 2020 05:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200520163421.27965-1-william.c.roberts@intel.com>
 <20200602191856.5040-1-william.c.roberts@intel.com> <20200602191856.5040-2-william.c.roberts@intel.com>
 <20200611120145.GA453655@localhost.localdomain>
In-Reply-To: <20200611120145.GA453655@localhost.localdomain>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 11 Jun 2020 07:12:39 -0500
Message-ID: <CAFftDdoJkg_rGRFirKQJLWjCic5CGLX7UU3HKA0g=Otfa4R+3Q@mail.gmail.com>
Subject: Re: [PATCH v3] ci: run SELinux kernel test suite
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 11, 2020 at 7:02 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Tue, Jun 02, 2020 at 02:18:56PM -0500, bill.c.roberts@gmail.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > The current Travis CI runs the userspace tooling and libraries against
> > policy files, but cannot test against an SELinux enabled kernel. Thus,
> > some tests are not being done in the CI. Travis, unfortunately only
> > provides Ubuntu images, so in order to run against a modern distro with
> > SELinux in enforcing mode, we need to launch a KVM with something like
> > Fedora.
> >
> > This patch enables this support by launching a Fedora32 Cloud Image with
> > the SELinux userspace library passed on from the Travis clone, it then
> > builds and replaces the current SELinux bits on the Fedora32 image and
> > runs the SELinux testsuite.
> >
> > The cloud image run can be controlled with the TRAVIS env variable:
> > TRAVIS_CLOUD_IMAGE_VERSION. That variable takes the major and minor
> > version numbers in a colon delimited string, eg: "32:1.6".
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> I pushed all Acked bugs to my fork's branch 3.1-rc2 and the travis jobs failed:
>
> https://travis-ci.org/github/bachradsusi/SELinuxProject-selinux/jobs/697177370
>
> ~~~
> #
> # Great we have a host running, ssh into it. We specify -o so
> # we don't get blocked on asking to add the servers key to
> # our known_hosts.
> #
> ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
> bash: /root/selinux/scripts/ci/fedora-test-runner.sh: No such file or directory
> The command "scripts/ci/travis-kvm-setup.sh" exited with 127.
>
> Done. Your build exited with 1.
> ~~~
>
>
> > ---
> >  .travis.yml                      |   8 ++
> >  scripts/ci/README.md             |   8 ++
> >  scripts/ci/fedora-test-runner.sh |  87 +++++++++++++++++++++
> >  scripts/ci/travis-kvm-setup.sh   | 125 +++++++++++++++++++++++++++++++
> >  4 files changed, 228 insertions(+)
> >  create mode 100644 scripts/ci/README.md
> >  create mode 100755 scripts/ci/fedora-test-runner.sh
> >  create mode 100755 scripts/ci/travis-kvm-setup.sh
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index c36e721a5e1d..bd3c98420c24 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -34,6 +34,14 @@ matrix:
> >        env: PYVER=python3.8 RUBYLIBVER=2.7 LINKER=gold
> >      - compiler: clang
> >        env: PYVER=python3.8 RUBYLIBVER=2.7 LINKER=bfd
> > +  include:
> > +    - compiler: gcc
> > +      env: TRAVIS_RUN_KVM=true TRAVIS_CLOUD_IMAGE_VERSION="32:1.6"
> > +      install:
> > +        - skip
> > +      before_script:
> > +        - skip
> > +      script: scripts/ci/travis-kvm-setup.sh
> >
> >  # Use Travis-CI Ubuntu 18.04 Bionic Beaver, "full image" variant
> >  sudo: required
> > diff --git a/scripts/ci/README.md b/scripts/ci/README.md
> > new file mode 100644
> > index 000000000000..04a134a438c2
> > --- /dev/null
> > +++ b/scripts/ci/README.md
> > @@ -0,0 +1,8 @@
> > +# Continuous Integration Scripts
> > +
> > +The scripts under `scripts/ci` are designed specifically
> > +for the Travis CI system. While nothing prevents you
> > +from mimicking that environment and using them locally,
> > +they are not applicable for general consumption. Any
> > +thing in this directory should never be considered as
> > +a stable API.
> > diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
> > new file mode 100755
> > index 000000000000..0927ed5dad8f
> > --- /dev/null
> > +++ b/scripts/ci/fedora-test-runner.sh
> > @@ -0,0 +1,87 @@
> > +#!/usr/bin/env bash
> > +
> > +set -ev
> > +
> > +# CI Debug output if things go squirrely.
> > +getenforce
> > +id -Z
> > +nproc
> > +pwd
> > +
> > +# Turn off enforcing for the setup to prevent any weirdness from breaking
> > +# the CI.
> > +setenforce 0
> > +
> > +dnf clean all -y
> > +dnf install -y \
> > +    --allowerasing \
> > +    --skip-broken \
> > +    git \
> > +    audit-libs-devel \
> > +    bison \
> > +    bzip2-devel \
> > +    CUnit-devel \
> > +    diffutils \
> > +    flex \
> > +    gcc \
> > +    gettext \
> > +    glib2-devel \
> > +    make \
> > +    libcap-devel \
> > +    libcap-ng-devel \
> > +    pam-devel \
> > +    pcre-devel \
> > +    xmlto \
> > +    python3-devel \
> > +    ruby-devel \
> > +    swig \
> > +    perl-Test \
> > +    perl-Test-Harness \
> > +    perl-Test-Simple \
> > +    selinux-policy-devel \
> > +    gcc \
> > +    libselinux-devel \
> > +    net-tools \
> > +    netlabel_tools \
> > +    iptables \
> > +    lksctp-tools-devel \
> > +    attr \
> > +    libbpf-devel \
> > +    keyutils-libs-devel \
> > +    kernel-devel \
> > +    quota \
> > +    xfsprogs-devel \
> > +    libuuid-devel \
> > +    kernel-devel-"$(uname -r)" \
> > +    kernel-modules-"$(uname -r)"
> > +
> > +#
> > +# Move to selinux code and build
> > +#
> > +cd "$HOME/selinux"
> > +
> > +# Show HEAD commit for sanity checking
> > +git log -1
> > +
> > +#
> > +# Build and replace userspace components
> > +#
> > +make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
> > +make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install-pywrap
> > +make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
> > +
> > +#
> > +# Get the selinux testsuite, but don't clone it in $HOME/selinux, move to $HOME
> > +# first.
> > +#
> > +cd "$HOME"
> > +git clone --depth=1 https://github.com/SELinuxProject/selinux-testsuite.git
> > +cd selinux-testsuite
> > +
> > +# The testsuite must be run in enforcing mode
> > +setenforce 1
> > +
> > +#
> > +# Run the test suite
> > +#
> > +make test
> > diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
> > new file mode 100755
> > index 000000000000..864dbac96a46
> > --- /dev/null
> > +++ b/scripts/ci/travis-kvm-setup.sh
> > @@ -0,0 +1,125 @@
> > +#!/usr/bin/env bash
> > +
> > +set -ev
> > +
> > +TEST_RUNNER="scripts/ci/fedora-test-runner.sh"
> > +
> > +#
> > +# Variables for controlling the Fedora Image version and download URLs.
> > +#
> > +MAJOR_VERSION="32"
> > +MINOR_VERSION="1.6"
> > +
> > +BASE_URL="https://download.fedoraproject.org/pub/fedora/linux/releases"
> > +IMAGE_BASE_NAME="Fedora-Cloud-Base-$MAJOR_VERSION-$MINOR_VERSION.x86_64"
> > +IMAGE_URL="$BASE_URL/$MAJOR_VERSION/Cloud/x86_64/images/$IMAGE_BASE_NAME.raw.xz"
> > +CHECK_URL="$BASE_URL/$MAJOR_VERSION/Cloud/x86_64/images/Fedora-Cloud-$MAJOR_VERSION-$MINOR_VERSION-x86_64-CHECKSUM"
> > +GPG_URL="https://getfedora.org/static/fedora.gpg"
> > +
> > +#
> > +# Travis gives us 7.5GB of RAM and two cores:
> > +# https://docs.travis-ci.com/user/reference/overview/
> > +#
> > +MEMORY=4096
> > +VCPUS="$(nproc)"
> > +
> > +# Install these here so other builds don't have to wait on these deps to download and install
> > +sudo apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker libguestfs-tools
> > +
> > +sudo usermod -a -G kvm,libvirt,libvirt-qemu "$USER"
> > +
> > +# Verify that KVM is working, useful if Travis ever changes anything.
> > +kvm-ok
> > +
> > +sudo systemctl enable libvirtd
> > +sudo systemctl start libvirtd
> > +
> > +# Set up a key so we can ssh into the VM
> > +ssh-keygen -N "" -f "$HOME/.ssh/id_rsa"
> > +
> > +#
> > +# Get the Fedora Cloud Image, It is a base image that small and ready to go, extract it and modify it with virt-sysprep
> > +#  - https://alt.fedoraproject.org/en/verify.html
> > +cd "$HOME"
> > +wget "$IMAGE_URL"
> > +
> > +# Verify the image
> > +curl "$GPG_URL" | gpg --import
> > +wget "$CHECK_URL"
> > +gpg --verify-files ./*-CHECKSUM
> > +sha256sum --ignore-missing -c ./*-CHECKSUM
> > +
> > +# Extract the image
> > +unxz -T0 "$IMAGE_BASE_NAME.raw.xz"
> > +
> > +# Search is needed for $HOME so virt service can access the image file.
> > +chmod a+x "$HOME"
> > +
> > +#
> > +# Modify the virtual image to:
> > +#   - Enable a login, we just use root
> > +#   - Enable passwordless login
> > +#     - Force a relabel to fix labels on ssh keys
> > +#
> > +sudo virt-sysprep -a "$IMAGE_BASE_NAME.raw" \
> > +  --root-password password:123456 \
> > +  --hostname fedoravm \
> > +  --append-line '/etc/ssh/sshd_config:PermitRootLogin yes' \
> > +  --append-line '/etc/ssh/sshd_config:PubkeyAuthentication yes' \
> > +  --mkdir /root/.ssh \
> > +  --upload "$HOME/.ssh/id_rsa.pub:/root/.ssh/authorized_keys" \
> > +  --chmod '0600:/root/.ssh/authorized_keys' \
> > +  --run-command 'chown root:root /root/.ssh/authorized_keys' \
> > +  --copy-in "$TRAVIS_BUILD_DIR:/root" \
> > +  --network \
> > +  --selinux-relabel
> > +
> > +#
> > +# Now we create a domain by using virt-install. This not only creates the domain, but runs the VM as well
> > +# It should be ready to go for ssh, once ssh starts.
> > +#
> > +sudo virt-install \
> > +  --name fedoravm \
> > +  --memory $MEMORY \
> > +  --vcpus $VCPUS \
> > +  --disk "$IMAGE_BASE_NAME.raw" \
> > +  --import --noautoconsole
> > +
> > +#
> > +# Here comes the tricky part, we have to figure out when the VM comes up AND we need the ip address for ssh. So we
> > +# can check the net-dhcp leases, for our host. We have to poll, and we will poll for up to 3 minutes in 6 second
> > +# intervals, so 30 poll attempts (0-29 inclusive).
> > +#
> > +# We have a full reboot + relabel, so first sleep gets us close
> > +#
> > +sleep 30
> > +for i in $(seq 0 29); do
> > +    echo "loop $i"
> > +    sleep 6s
> > +    # Get the leases, but tee it so it's easier to debug
> > +    sudo virsh net-dhcp-leases default | tee dhcp-leases.txt
> > +
> > +    # get our ipaddress
> > +    ipaddy="$(grep fedoravm dhcp-leases.txt | awk '{print $5}' | cut -d'/' -f 1-1)"
> > +    if [ -n "$ipaddy" ]; then
> > +        # found it, we're done looking, print it for debug logs
> > +        echo "ipaddy: $ipaddy"
> > +        break
> > +    fi
> > +    # it's empty/not found, loop back and try again.
> > +done
> > +
> > +# Did we find it? If not die.
> > +if [ -z "$ipaddy" ]; then
> > +    echo "ipaddy zero length, exiting with error 1"
> > +    exit 1
> > +fi
> > +
> > +#
> > +# Great we have a host running, ssh into it. We specify -o so
> > +# we don't get blocked on asking to add the servers key to
> > +# our known_hosts.
> > +#
> > +ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
> > +
> > +exit 0

Well that's a new one. Let me look into it, feel free to drop it from
the RC if you need to. Do me a favor, could you
restart that build just to see if it reproduces again?
