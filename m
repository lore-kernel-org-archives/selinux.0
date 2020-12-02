Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B06CC71155
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 19:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F171D206A5
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 19:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgLBTfw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Dec 2020 14:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgLBTfw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Dec 2020 14:35:52 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFDEC0613CF
        for <selinux@vger.kernel.org>; Wed,  2 Dec 2020 11:35:11 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id q1so2629652ilt.6
        for <selinux@vger.kernel.org>; Wed, 02 Dec 2020 11:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=apx+OMLtDwXk2K2M7n7oDT2Ko8y6QzW1vq3m1cNhS8o=;
        b=jagZW99TW57CQKExqauFYMfhlceg+DTrC8x5Yb+BlZ1blGl/d/Vct7G9gPVsaROcUE
         E65lEmhCGBLD29LXmjEapiOkrzwLutXeC13aHBxANDGXzJbRNxcGeuGMZl58AhKMJnE0
         fkCiVtT0aJConcUHcja8WnYjxfxXjtQerLXYVal5w4zWWgN/6UTao3V9NaXwRl6RIlID
         VRdxqYwVZgFnc547t8gLJcAJAnRJtdFTeK7rUvdo1tP94AI2PLlC+0BEN4T1iXS7sZlU
         DI3/untYLDMZ29AS8s8dnKYm2kQhsXiTW68yF2hU0xn+VZ6O1wWX83roTmderj17RQZi
         ZG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=apx+OMLtDwXk2K2M7n7oDT2Ko8y6QzW1vq3m1cNhS8o=;
        b=T0g4fJk5vZnNissx9sT7L/Q9/eC6vAUyPyoqBvOFlwoDFg3GzpJsEy1UKwM18aMF5Q
         X1qcE02OPQNjF4uyEVzPFz0IcsCrHUSKgbguFYAcalLsWL2i7cZQdFfKuQkhWsNqbxMA
         pLdaHY/x2v7cwabBITyUNH9AsMgVEg9NmTpJ0/dNhyx5khTxn0CUfXRbeip8R0r0J2+G
         e+jr2PCOrxPW2CrKQKPXdFnxivH8g0NPpy98hhLPABBIsu/8Z7KdmtpjC56xpNOiCmqv
         M2IOieG9QUG4guvFZEV48gFa2sPH8kK7snx5N+vsMOk8xAeUNER/oNzXct8Xi4g3wIY3
         FmZg==
X-Gm-Message-State: AOAM531HikQIsqpCwomndKRb/VAY76O5HzoJJLKU+OjQDh9d+ih93DVW
        z0eNVBLJjYG2XWUkR3z0eEZyHHTUVKPindI2sxZlq0jp
X-Google-Smtp-Source: ABdhPJw3W0MsoXAycjft9aOX1kEl4iMPQWyLrlgBdJtzJl6XDVC/ozIosbDkE00nZj2F/DErKhJFO21zTMpc/Y7nn20=
X-Received: by 2002:a92:444e:: with SMTP id a14mr3719566ilm.129.1606937711266;
 Wed, 02 Dec 2020 11:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20201124080945.80488-1-nicolas.iooss@m4x.org> <878sagow0g.fsf@redhat.com>
In-Reply-To: <878sagow0g.fsf@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 2 Dec 2020 13:35:00 -0600
Message-ID: <CAFftDdq0xw6pkJ-_9b6_3+QygkbN3+dO6Pr9ewv_7um=ddpUow@mail.gmail.com>
Subject: Re: [PATCH 1/1] scripts/ci: add configuration for a Vagrant virtual machine
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 2, 2020 at 1:27 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
> > Using Vagrant makes reproducing and debugging CI issues easier: after
> > "vagrant up", a test virtual machine is up and running, and ready to run
> > "fedora-test-runner.sh". In order to make using this VM even easier, a
> > helper script, "run-selinux-test.sh" is created inside and instructions
> > on how to use it are documented at the beginning of Vagrantfile.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  scripts/ci/.gitignore  |  1 +
> >  scripts/ci/Vagrantfile | 55 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> >  create mode 100644 scripts/ci/.gitignore
> >  create mode 100644 scripts/ci/Vagrantfile
> >
> > diff --git a/scripts/ci/.gitignore b/scripts/ci/.gitignore
> > new file mode 100644
> > index 000000000000..a977916f6583
> > --- /dev/null
> > +++ b/scripts/ci/.gitignore
> > @@ -0,0 +1 @@
> > +.vagrant/
> > diff --git a/scripts/ci/Vagrantfile b/scripts/ci/Vagrantfile
> > new file mode 100644
> > index 000000000000..68a2414a8429
> > --- /dev/null
> > +++ b/scripts/ci/Vagrantfile
> > @@ -0,0 +1,55 @@
> > +# -*- mode: ruby -*-
> > +# vi: set ft=ruby :
> > +# Vagrant configuration file which creates a virtual machine that can run the
> > +# test suite using fedora-test-runner.sh, in an environment similar to the one
> > +# used for automated continuous integration tests (Travis-CI)
> > +#
> > +# To create a new virtual machine:
> > +#
> > +#    vagrant up --provision
> > +#
> > +# To launch tests (for example after modifications to libsepol, libselinux... are made):
> > +#
> > +#    vagrant rsync && echo ./run-selinux-test.sh | vagrant ssh
> > +#
> > +# To destroy the virtual machine (for example to start again from a clean environment):
> > +#
> > +#    vagrant destroy
> > +
> > +# Create a helper script in the VM to run the testsuite as root from a clean environment
> > +$script = <<SCRIPT
> > +cat > /home/vagrant/run-selinux-test.sh << EOF
> > +#/bin/sh
> > +set -e -v
> > +
> > +# Clean-up a previous run.
> > +# "make" is not installed when the machine is first bootstrapped
> > +if command -v make > /dev/null 2>&1 ; then
> > +    sudo make -C /root/selinux clean distclean
> > +fi
> > +sudo rm -rf /root/selinux-testsuite
>
> Would it make sense to move clean-up directly to fedora-test-runner.sh so
> that Vagrantfile would not need to know about test runner internals?
>
>
> --- a/scripts/ci/fedora-test-runner.sh
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -75,6 +75,7 @@ git log --oneline -1
>  #
>  # Build and replace userspace components
>  #
> +make clean distclean
>  make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
>  make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install-pywrap
>  make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
> @@ -84,6 +85,7 @@ make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
>  # first.
>  #
>  cd "$HOME"
> +rm -rf selinux-testsuite
>  git clone --depth=1 https://github.com/SELinuxProject/selinux-testsuite.git
>  cd selinux-testsuite
>
>
>
>
> > +# Run the tests
> > +sudo /root/selinux/scripts/ci/fedora-test-runner.sh
> > +echo 'All tests passed :)'
> > +EOF
> > +chmod +x /home/vagrant/run-selinux-test.sh
> > +SCRIPT
> > +
> > +# All Vagrant configuration is done below. The "2" in Vagrant.configure
> > +# configures the configuration version (we support older styles for
> > +# backwards compatibility). Please don't change it unless you know what
> > +# you're doing.
> > +Vagrant.configure("2") do |config|
> > +  config.vm.box = "fedora/33-cloud-base"
> > +  config.vm.synced_folder "../..", "/root/selinux"
> > +
> > +  config.vm.provider "virtualbox" do |v|
> > +     v.memory = 4096
> > +  end
> > +  config.vm.provider "libvirt" do |v|
> > +     v.memory = 4096
> > +  end
> > +
> > +  config.vm.provision :shell, inline: $script
> > +end
> > --
> > 2.29.2
>

That's pretty sweet looking. AFAICT vagrant just makes VM's easier to
manipulate, is that right?
Does this change any of the infrastructure we run on as we migrate
away from Travis?
