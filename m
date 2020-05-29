Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C382C433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 18:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751CD207BC
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 18:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJu1WMIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2SnT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 14:43:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33797 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbgE2SnS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 14:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590777794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RxcMcq4p4ukXHXKEuaGoKRdTRWM3TO9lIYsuVA2beCI=;
        b=SJu1WMIxBSf4tfwomEWM3Enq/VNCYNFp+zswUzLykHRvRcxmVB7qKdAI9dLHfS7E9kHPK1
        yq0DWH9arupp4Ku9qpmATJPi9jRIR/KcR3tBMqMjieVsCg1JLZ4aK6ANFkkKocKk2dhG5I
        9EhdGC8v3wImjccD5jpP2sZPAgbmqqM=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-joRy4OI0PmSLjyLI5SrxOA-1; Fri, 29 May 2020 14:42:51 -0400
X-MC-Unique: joRy4OI0PmSLjyLI5SrxOA-1
Received: by mail-oo1-f69.google.com with SMTP id y24so225366ool.14
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 11:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxcMcq4p4ukXHXKEuaGoKRdTRWM3TO9lIYsuVA2beCI=;
        b=Q9mBM3FIKgTqclQio5jHc7Z9y9ZvuHTsFcsXqzJEoSZI20gUD295QsPKnrcU/ysjP8
         Jro9qLD5T3CSrniSdzDYkWd72p9L2qkEmdv6F/r7DpDN3kPfBzA7tCMYLq6nR5qbs5IJ
         GZtbbfGWS4jHMu2ElPFQ4fSn1M//MiQiaRfKNz0yKt0d17z48Dx0bbBe7VUtlwFFQs4Q
         g8gIxIi2Lh633dnyBMDcNyrWC1ooMNe1EZQUQ1/yS/T+lYz+5/wp6CDiF2LvbyB0o+XF
         O7MMfLoOrUw0R0Qsh4XaJ9nFsowsk+2c/u1Ew9t1rNcu+ZlIHGfbVoeTg3Tcm0A7zPaO
         +8HA==
X-Gm-Message-State: AOAM532ytH74QFjljxZ/jMdeiTKY0bv5j9jTIPdeZdehz6CleFKF32f8
        JfmpmrMQ2lFzk4qhU2TzCcV1SRS0vOLL+cxnW4IcC/yPugSwrflkfxvzCCQ1tS/j3pjJkyTjqoJ
        h/ESxEN/g2H73xHnngusX/zbsmd9/RzN9oQ==
X-Received: by 2002:aca:488c:: with SMTP id v134mr7317114oia.103.1590777769930;
        Fri, 29 May 2020 11:42:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcxCHJODod2wks/bDlat93pVMYSeqlDgE3pz5sJ1elMFoHztYjpxOdxMv9xpIj5AG49Gw5Xprc/Bptjizi+lM=
X-Received: by 2002:aca:488c:: with SMTP id v134mr7317095oia.103.1590777769580;
 Fri, 29 May 2020 11:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
In-Reply-To: <20200520163421.27965-2-william.c.roberts@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 29 May 2020 20:42:37 +0200
Message-ID: <CAFqZXNt_mQsbS_Yzd7AT0_XUDzGs_u6b6UTb3DPa8XzsbhqrfQ@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Apologies for getting back to this so late... Just some small nitpicks.

On Wed, May 20, 2020 at 6:34 PM <bill.c.roberts@gmail.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> The current Travis CI runs the userspace tooling and libraries against
> policy files, but cannot test against an SELinux enabled kernel. Thus,
> some tests are not being done in the CI. Travis, unfortunately only
> provides Ubuntu images, so in order to run against a modern distro with
> SELinux in enforcing mode, we need to launch a KVM with something like
> Fedora.
>
> This patch enables this support by launching a Fedora32 Cloud Image with
> the SELinux userspace library passed on from the Travis clone, it then
> builds and replaces the current SELinux bits on the Fedora32 image and
> runs the SELinux testsuite.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  .travis.yml                      |   8 +++
>  scripts/ci/README.md             |   8 +++
>  scripts/ci/fedora-test-runner.sh |  89 ++++++++++++++++++++++++
>  scripts/ci/travis-kvm-setup.sh   | 113 +++++++++++++++++++++++++++++++
>  4 files changed, 218 insertions(+)
>  create mode 100644 scripts/ci/README.md
>  create mode 100755 scripts/ci/fedora-test-runner.sh
>  create mode 100755 scripts/ci/travis-kvm-setup.sh
>
[...]
> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
> new file mode 100755
> index 000000000000..14bcf5fc469d
> --- /dev/null
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -0,0 +1,89 @@
> +#!/usr/bin/env bash
> +
> +set -ev
> +
> +# CI Debug output if things go squirrely.
> +getenforce
> +id -Z
> +nproc
> +pwd

I'd add also "uname -r" here to dump the running kernel version (will
probably be also printed later somewhere, but better to have it also
in one place with the other debug info).

> +
> +# Turn off enforcing for the setup to prevent any weirdness from breaking
> +# the CI.
> +setenforce 0
> +
> +dnf clean all -y
> +dnf install -y \
[...]
> diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
> new file mode 100755
> index 000000000000..66606e9d4a5b
> --- /dev/null
> +++ b/scripts/ci/travis-kvm-setup.sh
> @@ -0,0 +1,113 @@
> +#!/usr/bin/env bash
> +
> +set -ev
> +
> +TEST_RUNNER="scripts/ci/fedora-test-runner.sh"
> +
> +#
> +# Travis gives us 7.5GB of RAM and two cores:
> +# https://docs.travis-ci.com/user/reference/overview/
> +#
> +MEMORY=4096
> +VCPUS=2

Why not "VCPUS=$(nproc)"?

> +
> +# Install these here so other builds don't have to wait on these deps to download and install
> +sudo apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker libguestfs-tools
> +
> +sudo usermod -a -G kvm,libvirt,libvirt-qemu $USER
> +
> +# Verify that KVM is working, useful if Travis every changes anything.

s/every/ever/

> +kvm-ok
> +
> +sudo systemctl enable libvirtd
> +sudo systemctl start libvirtd
> +
> +# Set up a key so we can ssh into the VM
> +ssh-keygen -N "" -f "$HOME/.ssh/id_rsa"
> +
> +#
> +# Get the Fedora Cloud Image, It is a base image that small and ready to go, extract it and modify it with virt-sysprep
> +#  - https://alt.fedoraproject.org/en/verify.html
> +cd $HOME
> +wget https://download.fedoraproject.org/pub/fedora/linux/releases/32/Cloud/x86_64/images/Fedora-Cloud-Base-32-1.6.x86_64.raw.xz

I'd suggest extracting the Fedora release version (32) + the image
version (1.6) into variables, so they can be easily bumped later.

> +
> +# Verify the image
> +curl https://getfedora.org/static/fedora.gpg | gpg --import
> +wget https://getfedora.org/static/checksums/Fedora-Cloud-32-1.6-x86_64-CHECKSUM
> +gpg --verify-files *-CHECKSUM
> +sha256sum --ignore-missing -c *-CHECKSUM
> +
> +# Extract the image
> +unxz -T0 Fedora-Cloud-Base-32-1.6.x86_64.raw.xz
> +
> +# Search is needed for $HOME so virt service can access the image file.
> +chmod a+x $HOME
> +
> +#
> +# Modify the virtual image to:
> +#   - Enable a login, we just use root
> +#   - Enable passwordless login
> +#     - Force a relabel to fix labels on ssh keys
> +#
> +sudo virt-sysprep -a "$HOME/Fedora-Cloud-Base-32-1.6.x86_64.raw" \
> +  --root-password password:123456 \

Do you need to set the password when you use an SSH key to login?

> +  --hostname fedoravm \
> +  --append-line '/etc/ssh/sshd_config:PermitRootLogin yes' \
> +  --append-line '/etc/ssh/sshd_config:PubkeyAuthentication yes' \
> +  --mkdir /root/.ssh \
> +  --upload "$HOME/.ssh/id_rsa.pub:/root/.ssh/authorized_keys" \
> +  --chmod '0600:/root/.ssh/authorized_keys' \
> +  --run-command 'chown root:root /root/.ssh/authorized_keys' \

Could these be replaced with just "--ssh-inject root"?

> +  --copy-in "$TRAVIS_BUILD_DIR:/root" \
> +  --network \
> +  --selinux-relabel
> +
> +#
> +# Now we create a domain by using virt-install. This not only creates the domain, but runs the VM as well
> +# It should be ready to go for ssh, once ssh starts.
> +#
> +sudo virt-install \
> +  --name fedoravm \
> +  --memory $MEMORY \
> +  --vcpus $VCPUS \
> +  --disk "$HOME/Fedora-Cloud-Base-32-1.6.x86_64.raw" \
> +  --import --noautoconsole
> +
> +#
> +# Here comes the tricky part, we have to figure out when the VM comes up AND we need the ip address for ssh. So we
> +# can check the net-dhcp leases, for our host. We have to poll, and we will poll for up 3 minutes in 6 second
> +# intervals, so 30 poll attempts (0-29 inclusive). I don't know of a better way to do this.
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
> +    ipaddy=$(grep fedoravm dhcp-leases.txt | awk {'print $5'} | cut -d'/' -f 1-1)

Looks cleaner this way:
[...] | awk '{ print $5 }' | cut -d / -f 1)

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
> +ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
> +
> +exit 0
> --
> 2.17.1

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

