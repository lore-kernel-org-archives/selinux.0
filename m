Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BB2C83013
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 19:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C2B22247
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 19:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgLBTYH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Dec 2020 14:24:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729212AbgLBTYG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Dec 2020 14:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606936960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mtUOmiXxqysYX3PODhc0ZGCRybw9ian4rWN51Zrl5tg=;
        b=VatOJcdwsrusZcwBlxRXmiIJemDywzoBvubj8HFdB63+Zo860Tf7y3AqvKh64ieKeM2f20
        Yi7q5QDO3GMNxIhsLhqZH+R05KL9R8RIym8cGRdRCyr4ctbyomX++vtXM9FdtqYD7E+wAL
        tMOZf+dYZf5Y2zO+kZ8mY2eS/forM7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-5KGlz5FpOcyAURYtm9WXwA-1; Wed, 02 Dec 2020 14:22:38 -0500
X-MC-Unique: 5KGlz5FpOcyAURYtm9WXwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6541100B8C8;
        Wed,  2 Dec 2020 19:20:16 +0000 (UTC)
Received: from localhost (unknown [10.40.193.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F58E5D6AC;
        Wed,  2 Dec 2020 19:20:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Subject: Re: [PATCH 1/1] scripts/ci: add configuration for a Vagrant virtual
 machine
In-Reply-To: <20201124080945.80488-1-nicolas.iooss@m4x.org>
References: <20201124080945.80488-1-nicolas.iooss@m4x.org>
Date:   Wed, 02 Dec 2020 20:20:15 +0100
Message-ID: <878sagow0g.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> Using Vagrant makes reproducing and debugging CI issues easier: after
> "vagrant up", a test virtual machine is up and running, and ready to run
> "fedora-test-runner.sh". In order to make using this VM even easier, a
> helper script, "run-selinux-test.sh" is created inside and instructions
> on how to use it are documented at the beginning of Vagrantfile.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  scripts/ci/.gitignore  |  1 +
>  scripts/ci/Vagrantfile | 55 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 scripts/ci/.gitignore
>  create mode 100644 scripts/ci/Vagrantfile
>
> diff --git a/scripts/ci/.gitignore b/scripts/ci/.gitignore
> new file mode 100644
> index 000000000000..a977916f6583
> --- /dev/null
> +++ b/scripts/ci/.gitignore
> @@ -0,0 +1 @@
> +.vagrant/
> diff --git a/scripts/ci/Vagrantfile b/scripts/ci/Vagrantfile
> new file mode 100644
> index 000000000000..68a2414a8429
> --- /dev/null
> +++ b/scripts/ci/Vagrantfile
> @@ -0,0 +1,55 @@
> +# -*- mode: ruby -*-
> +# vi: set ft=ruby :
> +# Vagrant configuration file which creates a virtual machine that can run the
> +# test suite using fedora-test-runner.sh, in an environment similar to the one
> +# used for automated continuous integration tests (Travis-CI)
> +#
> +# To create a new virtual machine:
> +#
> +#    vagrant up --provision
> +#
> +# To launch tests (for example after modifications to libsepol, libselinux... are made):
> +#
> +#    vagrant rsync && echo ./run-selinux-test.sh | vagrant ssh
> +#
> +# To destroy the virtual machine (for example to start again from a clean environment):
> +#
> +#    vagrant destroy
> +
> +# Create a helper script in the VM to run the testsuite as root from a clean environment
> +$script = <<SCRIPT
> +cat > /home/vagrant/run-selinux-test.sh << EOF
> +#/bin/sh
> +set -e -v
> +
> +# Clean-up a previous run.
> +# "make" is not installed when the machine is first bootstrapped
> +if command -v make > /dev/null 2>&1 ; then
> +    sudo make -C /root/selinux clean distclean
> +fi
> +sudo rm -rf /root/selinux-testsuite

Would it make sense to move clean-up directly to fedora-test-runner.sh so
that Vagrantfile would not need to know about test runner internals?


--- a/scripts/ci/fedora-test-runner.sh
+++ b/scripts/ci/fedora-test-runner.sh
@@ -75,6 +75,7 @@ git log --oneline -1
 #
 # Build and replace userspace components
 #
+make clean distclean
 make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
 make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install-pywrap
 make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
@@ -84,6 +85,7 @@ make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
 # first.
 #
 cd "$HOME"
+rm -rf selinux-testsuite
 git clone --depth=1 https://github.com/SELinuxProject/selinux-testsuite.git
 cd selinux-testsuite




> +# Run the tests
> +sudo /root/selinux/scripts/ci/fedora-test-runner.sh
> +echo 'All tests passed :)'
> +EOF
> +chmod +x /home/vagrant/run-selinux-test.sh
> +SCRIPT
> +
> +# All Vagrant configuration is done below. The "2" in Vagrant.configure
> +# configures the configuration version (we support older styles for
> +# backwards compatibility). Please don't change it unless you know what
> +# you're doing.
> +Vagrant.configure("2") do |config|
> +  config.vm.box = "fedora/33-cloud-base"
> +  config.vm.synced_folder "../..", "/root/selinux"
> +
> +  config.vm.provider "virtualbox" do |v|
> +     v.memory = 4096
> +  end
> +  config.vm.provider "libvirt" do |v|
> +     v.memory = 4096
> +  end
> +
> +  config.vm.provision :shell, inline: $script
> +end
> -- 
> 2.29.2

