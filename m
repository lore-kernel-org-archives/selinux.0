Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81F1DDA17
	for <selinux@vger.kernel.org>; Thu, 16 Jan 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043467; cv=none; b=ByvbPUczhXckewy4AXZ3x1wanBbsLUS/bZNpb5MoCClDyGPw8DbRSJc+g/VZH5kZsAQ5QVzcfJNx8qMdrUSPHpyapLLqWmftRbD1LQcy6sdQJiVwZrVVqQFj5KtEVVsrE2hqOF7X70KGtLjrwm1u0h65r33YBTHrVbo5X4EnHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043467; c=relaxed/simple;
	bh=vtI0couAkvL+B+pAJKWQ7WfCZAd1L+6oGb02I41Scdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k37rAsSPDpodEFKzZuiA+2WWzjO2LvPJ1yL3SkZfewjDt5NS9eAGlMms1+qCMAZQes+sRv2gfJ8thkM7eAp6S8SR5LENHL+LE4oot9hm8wZYv6bKuglg3czBjSIfCa87MjJSeA+gtZBgOQ+ELOWKMQ6ISmOz3D1shISSafcU5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyIcH5b/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyIcH5b/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737043464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbO+e16XEpqJrChIavIH6k1Cn3QxZWMkRniF/LqsRtg=;
	b=MyIcH5b/ghdQYk8JhrhL5lD9SNuslYtLaUzG/LlJjxECwMUZVg4Q0oxhXqAPd5Rr3MXr/e
	4Iss2kD1png3+59PNi7wdmWjuvzDxLsGMJLl1Fb7s63f8tMcK5/UB7+1NN4MbmbWfAkD6z
	3BxTcPsSQfE1jAjVqnZ7K7Afec0UyzU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-53Huzsz3Nde0NOYtGnuS1Q-1; Thu,
 16 Jan 2025 11:04:20 -0500
X-MC-Unique: 53Huzsz3Nde0NOYtGnuS1Q-1
X-Mimecast-MFC-AGG-ID: 53Huzsz3Nde0NOYtGnuS1Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B8B81956080;
	Thu, 16 Jan 2025 16:04:19 +0000 (UTC)
Received: from localhost (unknown [10.39.196.32])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92AD1195608A;
	Thu, 16 Jan 2025 16:04:18 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 selinux@vger.kernel.org
Cc: 
Subject: Re: [PATCH userspace 1/4] ci: use Testing Farm for running the
 testsuite
In-Reply-To: <CAP+JOzSjP62wTshJp2t-Loqr4ndDuwzBS8hkx3KAY3wZdZC=Eg@mail.gmail.com>
References: <20250103100203.32580-1-omosnace@redhat.com>
 <20250103100203.32580-2-omosnace@redhat.com>
 <CAP+JOzSjP62wTshJp2t-Loqr4ndDuwzBS8hkx3KAY3wZdZC=Eg@mail.gmail.com>
Date: Thu, 16 Jan 2025 17:04:17 +0100
Message-ID: <87h65ywxry.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

James Carter <jwcart2@gmail.com> writes:

> On Fri, Jan 3, 2025 at 5:02=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>>
>> Due to issues with the MacOS + Vagrant setup, selinux-testsuite has
>> migrated its CI to Testing Farm [1][2], so let's use it for running the
>> testsuite here, too.
>>
>> We can import the test definitions from the testsuite repo and just add
>> a setup "test" at the beginning that builds and installs the userspace
>> from git.
>>
>> [1] https://testing-farm.io/
>> [2] https://github.com/SELinuxProject/selinux-testsuite/commit/d75675eb0=
da2906780557ec8cd139d328c81777e
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Merged. Thanks!

>> ---
>>  .fmf/version                       |   1 +
>>  .github/workflows/tf_testsuite.yml |  17 ++++
>>  .github/workflows/vm_testsuite.yml |  22 -----
>>  scripts/ci/.gitignore              |   1 -
>>  scripts/ci/LICENSE                 |   5 --
>>  scripts/ci/README.md               |   8 --
>>  scripts/ci/Vagrantfile             |  48 -----------
>>  scripts/ci/fedora-test-runner.sh   | 100 ----------------------
>>  scripts/ci/travis-kvm-setup.sh     | 130 -----------------------------
>>  tmt/plans.fmf                      |  48 +++++++++++
>>  10 files changed, 66 insertions(+), 314 deletions(-)
>>  create mode 100644 .fmf/version
>>  create mode 100644 .github/workflows/tf_testsuite.yml
>>  delete mode 100644 .github/workflows/vm_testsuite.yml
>>  delete mode 100644 scripts/ci/.gitignore
>>  delete mode 100644 scripts/ci/LICENSE
>>  delete mode 100644 scripts/ci/README.md
>>  delete mode 100644 scripts/ci/Vagrantfile
>>  delete mode 100755 scripts/ci/fedora-test-runner.sh
>>  delete mode 100755 scripts/ci/travis-kvm-setup.sh
>>  create mode 100644 tmt/plans.fmf
>>
>> diff --git a/.fmf/version b/.fmf/version
>> new file mode 100644
>> index 00000000..d00491fd
>> --- /dev/null
>> +++ b/.fmf/version
>> @@ -0,0 +1 @@
>> +1
>> diff --git a/.github/workflows/tf_testsuite.yml b/.github/workflows/tf_t=
estsuite.yml
>> new file mode 100644
>> index 00000000..7e3993d3
>> --- /dev/null
>> +++ b/.github/workflows/tf_testsuite.yml
>> @@ -0,0 +1,17 @@
>> +name: Run SELinux testsuite in Testing Farm
>> +
>> +on: [push, pull_request]
>> +
>> +jobs:
>> +  tf_testsuite:
>> +    runs-on: ubuntu-latest
>> +    strategy:
>> +      fail-fast: false
>> +      matrix:
>> +        arch: [x86_64, aarch64]
>> +    steps:
>> +      - name: Schedule test on Testing Farm
>> +        uses: sclorg/testing-farm-as-github-action@main
>> +        with:
>> +          api_key: ${{ secrets.TESTING_FARM_API_TOKEN }}
>> +          arch: ${{ matrix.arch }}
>> diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_t=
estsuite.yml
>> deleted file mode 100644
>> index b96d58a5..00000000
>> --- a/.github/workflows/vm_testsuite.yml
>> +++ /dev/null
>> @@ -1,22 +0,0 @@
>> -name: Run SELinux testsuite in a virtual machine
>> -
>> -on: [push, pull_request]
>> -
>> -jobs:
>> -  vm_testsuite:
>> -
>> -    # Use VirtualBox+vagrant on macOS, as described in https://github.c=
om/actions/virtual-environments/issues/433
>> -    runs-on: macos-12
>> -
>> -    steps:
>> -    - uses: actions/checkout@v4
>> -
>> -    - name: Create Vagrant VM
>> -      run: |
>> -        cd scripts/ci
>> -        vagrant up
>> -
>> -    - name: Run SELinux testsuite in the VM
>> -      run: |
>> -        cd scripts/ci
>> -        vagrant ssh -- ./run-selinux-test.sh
>> diff --git a/scripts/ci/.gitignore b/scripts/ci/.gitignore
>> deleted file mode 100644
>> index a977916f..00000000
>> --- a/scripts/ci/.gitignore
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -.vagrant/
>> diff --git a/scripts/ci/LICENSE b/scripts/ci/LICENSE
>> deleted file mode 100644
>> index 1f95d26c..00000000
>> --- a/scripts/ci/LICENSE
>> +++ /dev/null
>> @@ -1,5 +0,0 @@
>> -Permission is hereby granted, free of charge, to any person obtaining a=
 copy of this software and associated documentation files (the "Software"),=
 to deal in the Software without restriction, including without limitation =
the rights to use, copy, modify, merge, publish, distribute, sublicense, an=
d/or sell copies of the Software, and to permit persons to whom the Softwar=
e is furnished to do so, subject to the following conditions:
>> -
>> -The above copyright notice and this permission notice shall be included=
 in all copies or substantial portions of the Software.
>> -
>> -THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL T=
HE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER L=
IABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM=
, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN=
 THE SOFTWARE.
>> diff --git a/scripts/ci/README.md b/scripts/ci/README.md
>> deleted file mode 100644
>> index 04a134a4..00000000
>> --- a/scripts/ci/README.md
>> +++ /dev/null
>> @@ -1,8 +0,0 @@
>> -# Continuous Integration Scripts
>> -
>> -The scripts under `scripts/ci` are designed specifically
>> -for the Travis CI system. While nothing prevents you
>> -from mimicking that environment and using them locally,
>> -they are not applicable for general consumption. Any
>> -thing in this directory should never be considered as
>> -a stable API.
>> diff --git a/scripts/ci/Vagrantfile b/scripts/ci/Vagrantfile
>> deleted file mode 100644
>> index f3c90b71..00000000
>> --- a/scripts/ci/Vagrantfile
>> +++ /dev/null
>> @@ -1,48 +0,0 @@
>> -# -*- mode: ruby -*-
>> -# vi: set ft=3Druby :
>> -# Vagrant configuration file which creates a virtual machine that can r=
un the
>> -# test suite using fedora-test-runner.sh, in an environment similar to =
the one
>> -# used for automated continuous integration tests (GitHub Actions)
>> -#
>> -# To create a new virtual machine:
>> -#
>> -#    vagrant up --provision
>> -#
>> -# To launch tests (for example after modifications to libsepol, libseli=
nux... are made):
>> -#
>> -#    vagrant rsync && echo ./run-selinux-test.sh | vagrant ssh
>> -#
>> -# To destroy the virtual machine (for example to start again from a cle=
an environment):
>> -#
>> -#    vagrant destroy
>> -
>> -# Create a helper script in the VM to run the testsuite as root from a =
clean environment
>> -$script =3D <<SCRIPT
>> -cat > /home/vagrant/run-selinux-test.sh << EOF
>> -#/bin/sh
>> -set -e -v
>> -
>> -# Run the tests
>> -sudo /root/selinux/scripts/ci/fedora-test-runner.sh
>> -echo 'All tests passed :)'
>> -EOF
>> -chmod +x /home/vagrant/run-selinux-test.sh
>> -SCRIPT
>> -
>> -# All Vagrant configuration is done below. The "2" in Vagrant.configure
>> -# configures the configuration version (we support older styles for
>> -# backwards compatibility). Please don't change it unless you know what
>> -# you're doing.
>> -Vagrant.configure("2") do |config|
>> -  config.vm.box =3D "fedora/39-cloud-base"
>> -  config.vm.synced_folder "../..", "/root/selinux"
>> -
>> -  config.vm.provider "virtualbox" do |v|
>> -     v.memory =3D 4096
>> -  end
>> -  config.vm.provider "libvirt" do |v|
>> -     v.memory =3D 4096
>> -  end
>> -
>> -  config.vm.provision :shell, inline: $script
>> -end
>> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-r=
unner.sh
>> deleted file mode 100755
>> index 331b9ec7..00000000
>> --- a/scripts/ci/fedora-test-runner.sh
>> +++ /dev/null
>> @@ -1,100 +0,0 @@
>> -#!/usr/bin/env bash
>> -# SPDX-License-Identifier: MIT
>> -set -ev
>> -
>> -#
>> -# We expect this to be set in the environment, but if it's not, most se=
linux projects
>> -# just have the same name as upstream, so choose that.
>> -#
>> -export SELINUX_DIR=3D"${SELINUX_DIR:-/root/selinux}"
>> -
>> -# CI Debug output if things go squirrely.
>> -getenforce
>> -id -Z
>> -nproc
>> -pwd
>> -
>> -# Turn off enforcing for the setup to prevent any weirdness from breaki=
ng
>> -# the CI.
>> -setenforce 0
>> -
>> -dnf clean all -y
>> -dnf install -y \
>> -    --allowerasing \
>> -    --skip-broken \
>> -    git \
>> -    audit-libs-devel \
>> -    bison \
>> -    bzip2-devel \
>> -    CUnit-devel \
>> -    diffutils \
>> -    flex \
>> -    gcc \
>> -    gettext \
>> -    glib2-devel \
>> -    make \
>> -    libcap-devel \
>> -    libcap-ng-devel \
>> -    pam-devel \
>> -    pcre2-devel \
>> -    xmlto \
>> -    python3-devel \
>> -    ruby-devel \
>> -    swig \
>> -    perl-Test \
>> -    perl-Test-Harness \
>> -    perl-Test-Simple \
>> -    selinux-policy-devel \
>> -    gcc \
>> -    libselinux-devel \
>> -    net-tools \
>> -    netlabel_tools \
>> -    iptables \
>> -    lksctp-tools-devel \
>> -    attr \
>> -    libbpf-devel \
>> -    keyutils-libs-devel \
>> -    kernel-devel \
>> -    quota \
>> -    xfsprogs-devel \
>> -    libuuid-devel \
>> -    e2fsprogs \
>> -    jfsutils \
>> -    dosfstools \
>> -    rdma-core-devel \
>> -    kernel-devel-"$(uname -r)" \
>> -    kernel-modules-"$(uname -r)"
>> -
>> -#
>> -# Move to selinux code and build
>> -#
>> -cd "$SELINUX_DIR"
>> -
>> -# Show HEAD commit for sanity checking
>> -git config --global --add safe.directory "$SELINUX_DIR"
>> -git log --oneline -1
>> -
>> -#
>> -# Build and replace userspace components
>> -#
>> -make clean distclean
>> -make -j"$(nproc)" LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 install
>> -make -j"$(nproc)" LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 install-pywrap
>> -make -j"$(nproc)" LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 relabel
>> -
>> -#
>> -# Get the selinux testsuite, but don't clone it in selinux git director=
y, move to $HOME
>> -# first.
>> -#
>> -cd "$HOME"
>> -rm -rf selinux-testsuite
>> -git clone --depth=3D1 https://github.com/SELinuxProject/selinux-testsui=
te.git
>> -cd selinux-testsuite
>> -
>> -# The testsuite must be run in enforcing mode
>> -setenforce 1
>> -
>> -#
>> -# Run the test suite
>> -#
>> -make test
>> diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setu=
p.sh
>> deleted file mode 100755
>> index 997ef73f..00000000
>> --- a/scripts/ci/travis-kvm-setup.sh
>> +++ /dev/null
>> @@ -1,130 +0,0 @@
>> -#!/usr/bin/env bash
>> -# SPDX-License-Identifier: MIT
>> -set -ev
>> -
>> -TEST_RUNNER=3D"scripts/ci/fedora-test-runner.sh"
>> -
>> -#
>> -# Variables for controlling the Fedora Image version and download URLs.
>> -#
>> -if [ -z "$FEDORA_MAJOR" ] || [ -z "$FEDORA_MINOR" ]; then
>> -    echo "$0: FEDORA_MAJOR and FEDORA_MINOR must be set!" 1>&2
>> -    exit 1
>> -fi
>> -
>> -BASE_URL=3D"https://download.fedoraproject.org/pub/fedora/linux/release=
s"
>> -IMAGE_BASE_NAME=3D"Fedora-Cloud-Base-$FEDORA_MAJOR-$FEDORA_MINOR.x86_64"
>> -IMAGE_URL=3D"$BASE_URL/$FEDORA_MAJOR/Cloud/x86_64/images/$IMAGE_BASE_NA=
ME.raw.xz"
>> -CHECK_URL=3D"$BASE_URL/$FEDORA_MAJOR/Cloud/x86_64/images/Fedora-Cloud-$=
FEDORA_MAJOR-$FEDORA_MINOR-x86_64-CHECKSUM"
>> -GPG_URL=3D"https://getfedora.org/static/fedora.gpg"
>> -
>> -#
>> -# Travis gives us 7.5GB of RAM and two cores:
>> -# https://docs.travis-ci.com/user/reference/overview/
>> -#
>> -MEMORY=3D4096
>> -VCPUS=3D"$(nproc)"
>> -
>> -# Install these here so other builds don't have to wait on these deps t=
o download and install
>> -sudo apt-get update
>> -sudo apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-che=
cker libguestfs-tools
>> -
>> -sudo usermod -a -G kvm,libvirt,libvirt-qemu "$USER"
>> -
>> -# Verify that KVM is working, useful if Travis ever changes anything.
>> -kvm-ok
>> -
>> -sudo systemctl enable libvirtd
>> -sudo systemctl start libvirtd
>> -
>> -# Set up a key so we can ssh into the VM
>> -ssh-keygen -N "" -f "$HOME/.ssh/id_rsa"
>> -
>> -#
>> -# Get the Fedora Cloud Image, It is a base image that small and ready t=
o go, extract it and modify it with virt-sysprep
>> -#  - https://alt.fedoraproject.org/en/verify.html
>> -cd "$HOME"
>> -wget "$IMAGE_URL"
>> -
>> -# Verify the image
>> -curl "$GPG_URL" | gpg --import
>> -wget "$CHECK_URL"
>> -gpg --verify-files ./*-CHECKSUM
>> -sha256sum --ignore-missing -c ./*-CHECKSUM
>> -
>> -# Extract the image
>> -unxz -T0 "$IMAGE_BASE_NAME.raw.xz"
>> -
>> -# Search is needed for $HOME so virt service can access the image file.
>> -chmod a+x "$HOME"
>> -
>> -#
>> -# Modify the virtual image to:
>> -#   - Enable a login, we just use root
>> -#   - Enable passwordless login
>> -#     - Force a relabel to fix labels on ssh keys
>> -#
>> -sudo virt-sysprep -a "$IMAGE_BASE_NAME.raw" \
>> -  --root-password password:123456 \
>> -  --hostname fedoravm \
>> -  --append-line '/etc/ssh/sshd_config:PermitRootLogin yes' \
>> -  --append-line '/etc/ssh/sshd_config:PubkeyAuthentication yes' \
>> -  --mkdir /root/.ssh \
>> -  --upload "$HOME/.ssh/id_rsa.pub:/root/.ssh/authorized_keys" \
>> -  --chmod '0600:/root/.ssh/authorized_keys' \
>> -  --run-command 'chown root:root /root/.ssh/authorized_keys' \
>> -  --copy-in "$TRAVIS_BUILD_DIR:/root" \
>> -  --network \
>> -  --selinux-relabel
>> -
>> -#
>> -# Now we create a domain by using virt-install. This not only creates t=
he domain, but runs the VM as well
>> -# It should be ready to go for ssh, once ssh starts.
>> -#
>> -sudo virt-install \
>> -  --name fedoravm \
>> -  --memory $MEMORY \
>> -  --vcpus $VCPUS \
>> -  --disk "$IMAGE_BASE_NAME.raw" \
>> -  --import --noautoconsole
>> -
>> -#
>> -# Here comes the tricky part, we have to figure out when the VM comes u=
p AND we need the ip address for ssh. So we
>> -# can check the net-dhcp leases, for our host. We have to poll, and we =
will poll for up to 3 minutes in 6 second
>> -# intervals, so 30 poll attempts (0-29 inclusive).
>> -#
>> -# We have a full reboot + relabel, so first sleep gets us close
>> -#
>> -sleep 30
>> -for i in $(seq 0 29); do
>> -    echo "loop $i"
>> -    sleep 6s
>> -    # Get the leases, but tee it so it's easier to debug
>> -    sudo virsh net-dhcp-leases default | tee dhcp-leases.txt
>> -
>> -    # get our ipaddress
>> -    ipaddy=3D"$(grep fedoravm dhcp-leases.txt | awk '{print $5}' | cut =
-d'/' -f 1-1)"
>> -    if [ -n "$ipaddy" ]; then
>> -        # found it, we're done looking, print it for debug logs
>> -        echo "ipaddy: $ipaddy"
>> -        break
>> -    fi
>> -    # it's empty/not found, loop back and try again.
>> -done
>> -
>> -# Did we find it? If not die.
>> -if [ -z "$ipaddy" ]; then
>> -    echo "ipaddy zero length, exiting with error 1"
>> -    exit 1
>> -fi
>> -
>> -#
>> -# Great we have a host running, ssh into it. We specify -o so
>> -# we don't get blocked on asking to add the servers key to
>> -# our known_hosts. Also, we need to forward the project directory
>> -# so forks know where to go.
>> -#
>> -project_dir=3D"$(basename "$TRAVIS_BUILD_DIR")"
>> -ssh -tt -o StrictHostKeyChecking=3Dno -o LogLevel=3DQUIET "root@$ipaddy=
" "SELINUX_DIR=3D/root/$project_dir /root/$project_dir/$TEST_RUNNER"
>> -
>> -exit 0
>> diff --git a/tmt/plans.fmf b/tmt/plans.fmf
>> new file mode 100644
>> index 00000000..89f041f2
>> --- /dev/null
>> +++ b/tmt/plans.fmf
>> @@ -0,0 +1,48 @@
>> +/ci:
>> +  summary: Run the testsuite with userspace from git
>> +  # Environment for the testsuite setup
>> +  environment:
>> +    STS_ROOT_DOMAIN: unconfined_t
>> +    STS_KERNEL: latest
>> +  discover:
>> +    - how: shell
>> +      tests:
>> +        - name: /prepare-selinux-userspace
>> +          summary: Build and install SELinux userspace from git
>> +          order: 0
>> +          duration: 10m
>> +          require:
>> +            - audit-libs-devel
>> +            - bison
>> +            - bzip2-devel
>> +            - CUnit-devel
>> +            - diffutils
>> +            - flex
>> +            - gcc
>> +            - gettext
>> +            - glib2-devel
>> +            - make
>> +            - libcap-devel
>> +            - libcap-ng-devel
>> +            - pam-devel
>> +            - pcre2-devel
>> +            - python3-devel
>> +            - python3-pip
>> +            - python3-setuptools
>> +            - python3-wheel
>> +            - swig
>> +            - xmlto
>> +          test: |
>> +            set -ex
>> +
>> +            # Build and replace userspace components
>> +            make clean distclean
>> +            make -j"$(nproc)" LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 ins=
tall
>> +            make -j"$(nproc)" LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 ins=
tall-pywrap
>> +            make -j"$(nproc)" LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 rel=
abel
>> +    - how: fmf
>> +      url: https://github.com/SELinuxProject/selinux-testsuite
>> +      ref: main
>> +      filter: tag:-ci & tag:-nfs
>> +  execute:
>> +    how: tmt
>> --
>> 2.47.1
>>
>>

