Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8556CC433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 19:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C90B207D4
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 19:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqtSyWvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgE2TRi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 15:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgE2TRh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 15:17:37 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7340DC03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 12:17:37 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k18so568171ion.0
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Keid+V+3UNGZiIbu2y2i4KGFXPkX/oBRs5//4wbcxrY=;
        b=PqtSyWvOmqSaHV7FxzrSFFVt/DvBSSsU1u97Ft59IZJbLrYqVpuF+Lk1mOcPSExvtN
         mXT5iuMDfkOfFjk+ACFJCwL8rWfuwGIS2yt0s0QDFDcMVg4r1h8wGVD5VvfdnjET+Wvo
         PuiUK2Zj4OTGLquzsCLMN9LyL1L+rkhpUG1U23HylZGYoY0htVOMiOReJT1xckIhFkpm
         FdUzF464ZEP5/9WHXvsYINb+k28BmVMiDKMfhanEEM4//oVf3GN8qU2AsOGpZmW0ZF1O
         bHfEkx0QsooXAhBG/tcNDNS77bK+BIpLJDB0o6dT4UDljsa3EZYPXHedDargHKn/wBmm
         ZJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Keid+V+3UNGZiIbu2y2i4KGFXPkX/oBRs5//4wbcxrY=;
        b=uejXHGKeaiWm2oFYJprTDYyEwNdhByLMxRyhUjF+ivGL6Nd551GowSULYIYZtti1ha
         zfej/R/mprp+HTEue56msESIAnjN+wb5rWCakwp9HQQNxlh5oKbAkaC3HJQarcMzmsNf
         0UXZC2srg7O9sq1J2FJm58E/CF9jHOuTDwTARkEdgi7h3Q3pgDtpUQru5BWgf/3InQfB
         HWxnhV1Sv1xLZqiivfX7LvGTLFzjxfhRvhlxIDXDQ/pvWdbPJz5R9yLxKLYpAF/IRr/S
         aIZFqVhOPWHAiUg4/FkQ8M3+QQHT0yN02i4EjoaeYcZ8kQ/eSW2BTbuxvxuGA8mOq3FO
         7c5Q==
X-Gm-Message-State: AOAM532UOBVzHgsaXdF+SvxJzeMG2FPMwOeYhav0GyYacgy2MfAD4a+v
        gve/zJ/7P5rnrf7g7K8kFudePXmaASQ9NFnC2B4=
X-Google-Smtp-Source: ABdhPJxRNBfjh3ckH4S7PG/ZLkawtJ424ldxQosQGlB9kUjHUeLspryN3CzG3VQfPdQv2lm4fJrABTKaKHFB1uUIApk=
X-Received: by 2002:a02:a805:: with SMTP id f5mr9068103jaj.130.1590779856583;
 Fri, 29 May 2020 12:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
 <CAFqZXNt_mQsbS_Yzd7AT0_XUDzGs_u6b6UTb3DPa8XzsbhqrfQ@mail.gmail.com>
In-Reply-To: <CAFqZXNt_mQsbS_Yzd7AT0_XUDzGs_u6b6UTb3DPa8XzsbhqrfQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 29 May 2020 14:17:25 -0500
Message-ID: <CAFftDdpJ57xt-F1HnO2dp4J12E5q0N6Rt=jV9v8jMJT==KhSNg@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 29, 2020 at 1:43 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Apologies for getting back to this so late... Just some small nitpicks.
>
> On Wed, May 20, 2020 at 6:34 PM <bill.c.roberts@gmail.com> wrote:
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
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  .travis.yml                      |   8 +++
> >  scripts/ci/README.md             |   8 +++
> >  scripts/ci/fedora-test-runner.sh |  89 ++++++++++++++++++++++++
> >  scripts/ci/travis-kvm-setup.sh   | 113 +++++++++++++++++++++++++++++++
> >  4 files changed, 218 insertions(+)
> >  create mode 100644 scripts/ci/README.md
> >  create mode 100755 scripts/ci/fedora-test-runner.sh
> >  create mode 100755 scripts/ci/travis-kvm-setup.sh
> >
> [...]
> > diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
> > new file mode 100755
> > index 000000000000..14bcf5fc469d
> > --- /dev/null
> > +++ b/scripts/ci/fedora-test-runner.sh
> > @@ -0,0 +1,89 @@
> > +#!/usr/bin/env bash
> > +
> > +set -ev
> > +
> > +# CI Debug output if things go squirrely.
> > +getenforce
> > +id -Z
> > +nproc
> > +pwd
>
> I'd add also "uname -r" here to dump the running kernel version (will
> probably be also printed later somewhere, but better to have it also
> in one place with the other debug info).
>
> > +
> > +# Turn off enforcing for the setup to prevent any weirdness from breaking
> > +# the CI.
> > +setenforce 0
> > +
> > +dnf clean all -y
> > +dnf install -y \
> [...]
> > diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
> > new file mode 100755
> > index 000000000000..66606e9d4a5b
> > --- /dev/null
> > +++ b/scripts/ci/travis-kvm-setup.sh
> > @@ -0,0 +1,113 @@
> > +#!/usr/bin/env bash
> > +
> > +set -ev
> > +
> > +TEST_RUNNER="scripts/ci/fedora-test-runner.sh"
> > +
> > +#
> > +# Travis gives us 7.5GB of RAM and two cores:
> > +# https://docs.travis-ci.com/user/reference/overview/
> > +#
> > +MEMORY=4096
> > +VCPUS=2
>
> Why not "VCPUS=$(nproc)"?

+1: Initially I just had this set to what travis provides. I don't
know why I didn't do that.

>
> > +
> > +# Install these here so other builds don't have to wait on these deps to download and install
> > +sudo apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker libguestfs-tools
> > +
> > +sudo usermod -a -G kvm,libvirt,libvirt-qemu $USER
> > +
> > +# Verify that KVM is working, useful if Travis every changes anything.
>
> s/every/ever/

+1

>
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
> > +cd $HOME
> > +wget https://download.fedoraproject.org/pub/fedora/linux/releases/32/Cloud/x86_64/images/Fedora-Cloud-Base-32-1.6.x86_64.raw.xz
>
> I'd suggest extracting the Fedora release version (32) + the image
> version (1.6) into variables, so they can be easily bumped later.

Sure, I forget why I ended up not doing it this way. I remember it
being late at night, and cursing for some reason.

>
> > +
> > +# Verify the image
> > +curl https://getfedora.org/static/fedora.gpg | gpg --import
> > +wget https://getfedora.org/static/checksums/Fedora-Cloud-32-1.6-x86_64-CHECKSUM
> > +gpg --verify-files *-CHECKSUM
> > +sha256sum --ignore-missing -c *-CHECKSUM
> > +
> > +# Extract the image
> > +unxz -T0 Fedora-Cloud-Base-32-1.6.x86_64.raw.xz
> > +
> > +# Search is needed for $HOME so virt service can access the image file.
> > +chmod a+x $HOME
> > +
> > +#
> > +# Modify the virtual image to:
> > +#   - Enable a login, we just use root
> > +#   - Enable passwordless login
> > +#     - Force a relabel to fix labels on ssh keys
> > +#
> > +sudo virt-sysprep -a "$HOME/Fedora-Cloud-Base-32-1.6.x86_64.raw" \
> > +  --root-password password:123456 \
>
> Do you need to set the password when you use an SSH key to login?

Yeah the account is disabled unless you do this. Plus it was helpful when
using the scripts locally and using virsh console

>
> > +  --hostname fedoravm \
> > +  --append-line '/etc/ssh/sshd_config:PermitRootLogin yes' \
> > +  --append-line '/etc/ssh/sshd_config:PubkeyAuthentication yes' \
> > +  --mkdir /root/.ssh \
> > +  --upload "$HOME/.ssh/id_rsa.pub:/root/.ssh/authorized_keys" \
> > +  --chmod '0600:/root/.ssh/authorized_keys' \
> > +  --run-command 'chown root:root /root/.ssh/authorized_keys' \
>
> Could these be replaced with just "--ssh-inject root"?

No, and I went through immense pain trying to get it to work. The
reason is that the tool
will dump it under /home/root instead of /root. So it won't get picked
up without some
other magic anyways.

>
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
> > +  --disk "$HOME/Fedora-Cloud-Base-32-1.6.x86_64.raw" \
> > +  --import --noautoconsole
> > +
> > +#
> > +# Here comes the tricky part, we have to figure out when the VM comes up AND we need the ip address for ssh. So we
> > +# can check the net-dhcp leases, for our host. We have to poll, and we will poll for up 3 minutes in 6 second
> > +# intervals, so 30 poll attempts (0-29 inclusive). I don't know of a better way to do this.
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
> > +    ipaddy=$(grep fedoravm dhcp-leases.txt | awk {'print $5'} | cut -d'/' -f 1-1)
>
> Looks cleaner this way:
> [...] | awk '{ print $5 }' | cut -d / -f 1)
>
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
> > --
> > 2.17.1
>

Thanks Ondrej.

Bill
