Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4643C83012
	for <selinux@archiver.kernel.org>; Thu,  3 Dec 2020 08:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A02F20C56
	for <selinux@archiver.kernel.org>; Thu,  3 Dec 2020 08:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgLCIP1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:15:27 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:44275 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgLCIPZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Dec 2020 03:15:25 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 0802D561249
        for <selinux@vger.kernel.org>; Thu,  3 Dec 2020 09:14:41 +0100 (CET)
Received: by mail-oi1-f169.google.com with SMTP id t143so1311040oif.10
        for <selinux@vger.kernel.org>; Thu, 03 Dec 2020 00:14:40 -0800 (PST)
X-Gm-Message-State: AOAM532fnJYt4FgZcAazUtN/vDlsPhICL3VuxIytlx9YeJCKoVrAIv8n
        hyKPt3BzPACtqAzTP41feEUXWb2GaQrj7mhNvEc=
X-Google-Smtp-Source: ABdhPJwOEbRx5CiyRqrwqUyYdPUqMjat0d+2RBVcSNUYgGKybJKkm355xdqcEOkz7AQnVe4NIK5SfhR/rDuNsxabqP8=
X-Received: by 2002:aca:ec09:: with SMTP id k9mr1124484oih.153.1606983279886;
 Thu, 03 Dec 2020 00:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20201124080945.80488-1-nicolas.iooss@m4x.org> <878sagow0g.fsf@redhat.com>
 <CAFftDdq0xw6pkJ-_9b6_3+QygkbN3+dO6Pr9ewv_7um=ddpUow@mail.gmail.com>
In-Reply-To: <CAFftDdq0xw6pkJ-_9b6_3+QygkbN3+dO6Pr9ewv_7um=ddpUow@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 3 Dec 2020 09:14:28 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==GCGXz=JNi6AaUGXQT=nUwku4FVHHGdXbJ-O0=Qyy7Bw@mail.gmail.com>
Message-ID: <CAJfZ7==GCGXz=JNi6AaUGXQT=nUwku4FVHHGdXbJ-O0=Qyy7Bw@mail.gmail.com>
Subject: Re: [PATCH 1/1] scripts/ci: add configuration for a Vagrant virtual machine
To:     William Roberts <bill.c.roberts@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Dec  3 09:14:41 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 2, 2020 at 8:35 PM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> On Wed, Dec 2, 2020 at 1:27 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > Nicolas Iooss <nicolas.iooss@m4x.org> writes:
> >
> > > Using Vagrant makes reproducing and debugging CI issues easier: after
> > > "vagrant up", a test virtual machine is up and running, and ready to run
> > > "fedora-test-runner.sh". In order to make using this VM even easier, a
> > > helper script, "run-selinux-test.sh" is created inside and instructions
> > > on how to use it are documented at the beginning of Vagrantfile.
> > >
> > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > ---
> > >  scripts/ci/.gitignore  |  1 +
> > >  scripts/ci/Vagrantfile | 55 ++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 56 insertions(+)
> > >  create mode 100644 scripts/ci/.gitignore
> > >  create mode 100644 scripts/ci/Vagrantfile
> > >
> > > diff --git a/scripts/ci/.gitignore b/scripts/ci/.gitignore
> > > new file mode 100644
> > > index 000000000000..a977916f6583
> > > --- /dev/null
> > > +++ b/scripts/ci/.gitignore
> > > @@ -0,0 +1 @@
> > > +.vagrant/
> > > diff --git a/scripts/ci/Vagrantfile b/scripts/ci/Vagrantfile
> > > new file mode 100644
> > > index 000000000000..68a2414a8429
> > > --- /dev/null
> > > +++ b/scripts/ci/Vagrantfile
> > > @@ -0,0 +1,55 @@
> > > +# -*- mode: ruby -*-
> > > +# vi: set ft=ruby :
> > > +# Vagrant configuration file which creates a virtual machine that can run the
> > > +# test suite using fedora-test-runner.sh, in an environment similar to the one
> > > +# used for automated continuous integration tests (Travis-CI)
> > > +#
> > > +# To create a new virtual machine:
> > > +#
> > > +#    vagrant up --provision
> > > +#
> > > +# To launch tests (for example after modifications to libsepol, libselinux... are made):
> > > +#
> > > +#    vagrant rsync && echo ./run-selinux-test.sh | vagrant ssh
> > > +#
> > > +# To destroy the virtual machine (for example to start again from a clean environment):
> > > +#
> > > +#    vagrant destroy
> > > +
> > > +# Create a helper script in the VM to run the testsuite as root from a clean environment
> > > +$script = <<SCRIPT
> > > +cat > /home/vagrant/run-selinux-test.sh << EOF
> > > +#/bin/sh
> > > +set -e -v
> > > +
> > > +# Clean-up a previous run.
> > > +# "make" is not installed when the machine is first bootstrapped
> > > +if command -v make > /dev/null 2>&1 ; then
> > > +    sudo make -C /root/selinux clean distclean
> > > +fi
> > > +sudo rm -rf /root/selinux-testsuite
> >
> > Would it make sense to move clean-up directly to fedora-test-runner.sh so
> > that Vagrantfile would not need to know about test runner internals?

Yes, I will send a v2 with this. Thanks for this suggestion!

> >
> > --- a/scripts/ci/fedora-test-runner.sh
> > +++ b/scripts/ci/fedora-test-runner.sh
> > @@ -75,6 +75,7 @@ git log --oneline -1
> >  #
> >  # Build and replace userspace components
> >  #
> > +make clean distclean
> >  make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
> >  make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install-pywrap
> >  make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
> > @@ -84,6 +85,7 @@ make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
> >  # first.
> >  #
> >  cd "$HOME"
> > +rm -rf selinux-testsuite
> >  git clone --depth=1 https://github.com/SELinuxProject/selinux-testsuite.git
> >  cd selinux-testsuite
> >
> >
> >
> >
> > > +# Run the tests
> > > +sudo /root/selinux/scripts/ci/fedora-test-runner.sh
> > > +echo 'All tests passed :)'
> > > +EOF
> > > +chmod +x /home/vagrant/run-selinux-test.sh
> > > +SCRIPT
> > > +
> > > +# All Vagrant configuration is done below. The "2" in Vagrant.configure
> > > +# configures the configuration version (we support older styles for
> > > +# backwards compatibility). Please don't change it unless you know what
> > > +# you're doing.
> > > +Vagrant.configure("2") do |config|
> > > +  config.vm.box = "fedora/33-cloud-base"
> > > +  config.vm.synced_folder "../..", "/root/selinux"
> > > +
> > > +  config.vm.provider "virtualbox" do |v|
> > > +     v.memory = 4096
> > > +  end
> > > +  config.vm.provider "libvirt" do |v|
> > > +     v.memory = 4096
> > > +  end
> > > +
> > > +  config.vm.provision :shell, inline: $script
> > > +end
> > > --
> > > 2.29.2
> >
>
> That's pretty sweet looking. AFAICT vagrant just makes VM's easier to
> manipulate, is that right?
> Does this change any of the infrastructure we run on as we migrate
> away from Travis?

Yes, Vagrant is a tool that makes using virtual machines on a local
computer much easier. It is a powerful tool, which is only used here
in a very simple configuration with a single VM running a system as
close as possible as the CI. My aim here was to "make reproducing and
debugging CI issues easier", because when something goes wrong in the
CI, it is much easier to find out what went wrong on a local computer
than trying to tweak things and submit new CI jobs.

This does not replace Travis, because this is not run for every push
to the git repository, but this shows that fedora-test-runner.sh is
generic enough to be run in a generic Fedora VM that could be provided
by other CI services (though I have not searched if any of them exists
for free).

Nicolas

