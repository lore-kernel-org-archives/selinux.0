Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E32DC38A24
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 19:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44F620747
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 19:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EU8kFbju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgEFThh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 15:37:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29446 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725915AbgEFThh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 May 2020 15:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588793854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMQav58gs1nXQOIJBzVOxorMunMxZMi79h0dPzloWzs=;
        b=EU8kFbjuLqOlQNDMaWCg/IoQf6uN1NPcyXlvoUOfdttNR+VGYYpqdwmiQtwkrA1YtjnC2X
        bkXqP9Is+/9W3Bik/RQyTt1xGBqciqYWPqDcncgWjI23F5WjdnVeqkQdFwQ/CgPeF8XFdH
        +92pVJBBpYhLXB9CfX9ZknlRsFqwWTg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-eZ4RZyykOI2OsG-Y6mrA3Q-1; Wed, 06 May 2020 15:37:31 -0400
X-MC-Unique: eZ4RZyykOI2OsG-Y6mrA3Q-1
Received: by mail-oi1-f199.google.com with SMTP id n63so527538oig.16
        for <selinux@vger.kernel.org>; Wed, 06 May 2020 12:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMQav58gs1nXQOIJBzVOxorMunMxZMi79h0dPzloWzs=;
        b=C4jHcK1se+Q+0vbhXuj2mV4MWlPX2QhauIsff3/hbB4fFXgrXyTrrEEB5Bga+r8l+7
         qCcxwWxxKtr2vp8cHu05bMYXKAWUbq6+3rTSfABSAJpneGOo3Hd2warDaDwLlkxa632a
         LjE83UY++6FvCxi4UjLm54cTIY1sxGE8dnxml67LAIjWAgsrZ1xCQMA94Bf70fohNR13
         MJDEC4stEV70FmrKXZBzmvdjYANEQPj7aWlZ+wjejPJlVXw0yzoKaqiN4gynDrJk1Lfz
         sitNy2PuFYChH8FlWv6H816o6V7d441WckduAf8rfUtbxIzZLXS3IkCq+pxOJL2mTU8n
         Ev8g==
X-Gm-Message-State: AGi0PubCy1tolKic6C6e1l8eGuteZc/LmSC2ITC1Wib3/9g1yViF/FVQ
        atvEl1dCSA3505pGVRDtNWqvzjhWf8/GGSWz3RUsFMuJT6b6VbOEgpfeI348DrUwCfMx0VJi73j
        CILH8qXCyWzd/PV2w9dC97EW6ZPvQIMHJnQ==
X-Received: by 2002:a9d:7d0e:: with SMTP id v14mr7828489otn.197.1588793850168;
        Wed, 06 May 2020 12:37:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypJk5dsdZ4MNw1GoF9LKkNoMhjI7Z0ubGvHcv9TGOiYjH+/lnqu77H+tLOPb1iKaiZpwStX9Ls1k713sSiWGMFs=
X-Received: by 2002:a9d:7d0e:: with SMTP id v14mr7828467otn.197.1588793849703;
 Wed, 06 May 2020 12:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 6 May 2020 21:37:18 +0200
Message-ID: <CAFqZXNt0+BstXTn2yTMHHf=n10SY74nSrj8cfELP26-mcmYkfQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 6, 2020 at 2:54 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Update the testsuite policy and code so that it builds and
> runs on Debian unstable and stable successfully (if one has
> already enabled SELinux on Debian).  Provide the necessary
> dependencies and instructions in the README.
>
> The labeled networking tests relies on specific mlsconstrain

s/relies/rely/

> statements that exist in Fedora policy but not in Debian so
> add them to the test policy as a CIL module; on Fedora this is
> redundant but harmless.  The SCTP tests also assumed that
> netlabel_peer_t was already marked mcs_constrained() in the
> base policy which doesn't appear to be true in Debian, so mark
> it so in the test policy.

[...]

> diff --git a/README.md b/README.md
> index b36494e..0d3f060 100644
> --- a/README.md
> +++ b/README.md
> @@ -36,6 +36,8 @@ one primary security module may be active at a time.
>
>  ### Userland and Base Policy
>
> +#### Fedora or RHEL
> +
>  On a Fedora/RHEL based system the testsuite has the following userspace
>  dependencies beyond a minimal install (other Linux distributions should have
>  similar dependencies):
> @@ -77,8 +79,66 @@ following command:
>                 xfsprogs-devel \
>                 libuuid-devel
>
> +#### Debian
> +
> +On Debian, you must first take steps to install and activate SELinux since
> +it is not enabled in the default install.  Be sure to backup your system first
> +if you care about any local data.
> +
> +       # apt-get install selinux-basics selinux-policy-default auditd
> +       # selinux-activate
> +       # reboot
> +
> +After activating, make sure that your login shell is running in the correct context:
> +
> +       # id -Z
> +
> +If this shows something other than "unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023",
> +you will need to first fix labeling or policy problems in your base system before proceeding.
> +Be sure that your shell context is correct and you can switch to enforcing mode without
> +breaking your system before proceeding.

Maybe it's because I'm not a native English speaker, but I parse "Be
sure that" more as "Rest assured that", at least until I reach the end
of the sentence. May I suggest using "Make sure that" instead?

> +
> +On Debian, you can install the userspace dependencies with the following
> +command:
> +
> +       # apt-get install perl \
> +               gcc \
> +               selinux-policy-dev \
> +               libselinux1-dev \
> +               net-tools \
> +               iptables \
> +               libsctp-dev \
> +               attr \
> +               libbpf-dev \
> +               libkeyutils-dev \
> +               linux-headers-$(uname -r) \
> +               quota \
> +               xfsprogs \
> +               xfslibs-dev \
> +               uuid-dev
> +
> +On Debian, you need to build and install netlabel_tools manually since it is not
> +yet packaged for Debian (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=959806):
> +
> +    # git clone https://github.com/netlabel/netlabel_tools
> +    # cd netlabel_tools
> +    # sudo apt-get install autotools-dev autoconf automake libtool pkg-config libnl-3-dev libnl-genl-3-dev
> +    # ./autogen.sh
> +    # ./configure --prefix=/usr
> +    # make
> +    # sudo make install
> +
> +Debian further requires reconfiguring the default /bin/sh to be bash
> +to support bashisms employed in the testsuite Makefiles and scripts:
> +
> +    # dpkg-reconfigure dash
> +
> +Select No when asked if you want to use dash as the default system shell.

Maybe add quotes around "No"?

> +
> +#### Other Distributions
> +
>  The testsuite requires a pre-existing base policy configuration of SELinux,
> -using either the old example policy or the reference policy as the baseline.
> +using the reference policy as the baseline.
>  It also requires the core SELinux userland packages (`libsepol`, `checkpolicy`,
>  `libselinux`, `policycoreutils`, and if using modular policy, `libsemanage`)
>  to be installed.  The test scripts also rely upon the SELinux extensions being
> diff --git a/policy/Makefile b/policy/Makefile
> index dfe601b..f86aac4 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -40,6 +40,8 @@ CIL_TARGETS = test_add_levels.cil test_glblub.cil
>  endif
>  endif # GLBLUB
>
> +CIL_TARGETS += test_mlsconstrain.cil test_overlay_defaultrange.cil

This causes a problem on RHEL-6, since it doesn't understand CIL
modules. We'll probably need to detect if semodule supports CIL before
trying to add the modules.

> +
>  ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
>  TARGETS += test_bounds.te test_nnp_nosuid.te
>  endif
> @@ -161,12 +163,16 @@ build: $(TARGETS)
>
>  load: expand_check all
>         # General policy load
> -       @-/usr/sbin/setsebool allow_domain_fd_use=0
> +       @if [ -e /sys/fs/selinux/booleans/domain_fd_use ]; then \
> +               /usr/sbin/setsebool domain_fd_use=0; \

On RHEL-6, the boolean is actually called allow_domain_fd_use, so it
doesn't set the boolean, leading to failures in fdreceive and inherit
test. Could we use getsebool and allow_domain_fd_use instead? It
should be able to resolve the alias on all systems where the boolean
exists.

> +       fi
>         $(SEMODULE) -i test_policy/test_policy.pp $(CIL_TARGETS)
>
>  unload:
>         # General policy unload
> -       @-/usr/sbin/setsebool allow_domain_fd_use=1
> +       @if [ -e /sys/fs/selinux/booleans/domain_fd_use ]; then \
> +               /usr/sbin/setsebool domain_fd_use=1; \

Same as above.

> +       fi
>         $(SEMODULE) -r test_policy $(subst .cil,,$(CIL_TARGETS))
>
>  clean:
> diff --git a/policy/test_capable_net.te b/policy/test_capable_net.te
> index 80559f6..2255a14 100644
> --- a/policy/test_capable_net.te
> +++ b/policy/test_capable_net.te
> @@ -28,8 +28,6 @@ corenet_raw_sendrecv_generic_if(capabledomain)
>  corenet_tcp_sendrecv_all_nodes(capabledomain)
>  corenet_udp_sendrecv_all_nodes(capabledomain)
>  corenet_raw_sendrecv_all_nodes(capabledomain)
> -corenet_tcp_sendrecv_all_ports(capabledomain)
> -corenet_udp_sendrecv_all_ports(capabledomain)
>  corenet_all_recvfrom_unlabeled(test_ncap_t)
>  corenet_all_recvfrom_unlabeled(test_resncap_t)
>  corenet_tcp_bind_all_nodes(capabledomain)
> diff --git a/policy/test_execute_no_trans.te b/policy/test_execute_no_trans.te
> index 79ba868..f699f56 100644
> --- a/policy/test_execute_no_trans.te
> +++ b/policy/test_execute_no_trans.te
> @@ -24,4 +24,4 @@ userdom_sysadm_entry_spec_domtrans_to(test_execute_notrans_t)
>
>  #Allow test_execute_notrans permissions to the allowed type
>  can_exec(test_execute_notrans_t,test_execute_notrans_allowed_t)
> -allow test_execute_notrans_t test_execute_notrans_denied_t:file mmap_file_perms;
> +allow test_execute_notrans_t test_execute_notrans_denied_t:file mmap_exec_file_perms;

This causes the testsuite to fail on RHEL-7, since there
mmap_exec_file_perms includes execute_no_trans for some reason. And on
RHEL-6 mmap_exec_file_perms is not defined at all. Can we solve this
bz defining mmap_exec_file_perms as mmap_file_perms in test_policy.if
if mmap_exec_file_perms is not defined?

> diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> index 7d73cbf..4e27134 100644
> --- a/policy/test_filesystem.te
> +++ b/policy/test_filesystem.te
> @@ -350,6 +350,7 @@ allow test_filesystem_fscontext_t test_filesystem_filecon_t:file { getattr open
>  allow test_filesystem_fscontext_t test_filesystem_fscontext_fs_t:dir { add_name search write };
>  allow test_filesystem_fscontext_t test_filesystem_fscontext_fs_t:file { create getattr open relabelfrom write };
>  allow test_filesystem_fscontext_t test_filesystem_fscontext_fs_t:filesystem { mount relabelto unmount };
> +domain_obj_id_change_exemption(test_filesystem_fscontext_t)
>  fs_relabelfrom_all_fs(test_filesystem_fscontext_t)
>  files_search_all(test_filesystem_fscontext_t)
>  allow test_filesystem_filecon_t test_filesystem_fscontext_fs_t:filesystem { associate };

[...]

This is what I discovered so far just by trying the patch on various
RHELs and reading the text parts of the patch. I plan to have a closer
look later.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

