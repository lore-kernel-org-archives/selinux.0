Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D379EC433E0
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B75C420756
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgENWDx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 18:03:53 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:37781 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgENWDw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 18:03:52 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8C380566906
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 00:03:48 +0200 (CEST)
Received: by mail-oo1-f49.google.com with SMTP id g22so7689oop.13
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 15:03:48 -0700 (PDT)
X-Gm-Message-State: AOAM531SuJz6gTthcSKnXRFO5QdQqNKl9fnLPxyr9VeL5ZV3LxBptFhH
        x1/YaFxe5th3gox8L1TFtW1h0/NwMv6DqGWfPI4=
X-Google-Smtp-Source: ABdhPJwtu5+GwGufoHaMZaXewuRZ/ETxz08CNQNCRCnVVlCxio/y6FvsSAuMd/2VOma1k1JRJtWVyyjEeI9RnRBe/FA=
X-Received: by 2002:a4a:4cca:: with SMTP id a193mr121433oob.46.1589493827425;
 Thu, 14 May 2020 15:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <3581425.j52oWYpJar@liv> <20200407085922.GA438349@workstation>
 <20200422065053.GA167999@workstation> <CAHC9VhQUmY=ue3zWdTnE1Ehi90Lj3077sLbu+jyaWoAVKuKyeQ@mail.gmail.com>
 <CAFftDdo1hqbacU2TD6zQp_t_KJq-KS5pWBMr89c4HA3=aUdUbQ@mail.gmail.com>
 <20200423150039.GC204116@workstation> <CAFftDdq_g_rUy=KFh_gOEXoVxkCgz9qWzR17d4Mt1qVChoVLjg@mail.gmail.com>
In-Reply-To: <CAFftDdq_g_rUy=KFh_gOEXoVxkCgz9qWzR17d4Mt1qVChoVLjg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 15 May 2020 00:03:36 +0200
X-Gmail-Original-Message-ID: <CAJfZ7===ssyARiz=cG73hqRq_+d+tGuNKX9-nOU7VJVZGS=+zQ@mail.gmail.com>
Message-ID: <CAJfZ7===ssyARiz=cG73hqRq_+d+tGuNKX9-nOU7VJVZGS=+zQ@mail.gmail.com>
Subject: Re: Fedora VM On Travis for Testing
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Jason Zaman <jason@perfinion.com>,
        Steve Lawrence <slawrence@tresys.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Joshua Brindle <brindle@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri May 15 00:03:49 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 11:00 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> I just wanted to lay out a demo of a Fedora 32 cloud VM image booting
> on Travis with execution happening in the Fedora VM.
> The Fedora VM contains the selinux source code for that particular
> travis build, so it has the PR patches, etc.
> The VM has networking.
>
> The build logs for the Travis run are here:
>   - https://travis-ci.org/github/williamcroberts/selinux/builds/687185489
>
> Which comes from my git tree here:
>   - https://github.com/williamcroberts/selinux/tree/kvm-fedora-testing
>
> Note that it's super messy, I need to go through and cleanup both the
> patch and the git
> history. I also should verify the downloaded image is signed for the VM.
> Also note that I may rebase/squash my git branch at any time.
>
> Petr started a release document here:
>   - https://github.com/bachradsusi/SELinuxProject-selinux/blob/RELEASE/RELEASE_PROCESS.md
>
> I'd like to gather feedback, and perhaps more comments on:
> 1. Is this CI approach worth continuing?
> 2. Comments on the CI scripts (I have no idea what I am doing, common issue)
> 3. Comments, patches, suggestions on what tests to run in this CI environment.
> 4. More information in in the RELEASE_PROCESS.md file. I made some
> comments there
>     as well on ideas.
>
> My goal here is that a release can occur if CI is passing without
> worry, and that
> we automate manual steps as much as possible. This way, if we get hit by a bus
> releases can occur without much effort.

Hi,
This sounds like a nice idea :) Also it appears it only takes 5
minutes to run the whole Travis CI job of setting the Fedora VM up and
booting it, which is more than acceptable in term of delays (and is
very quicker than building and testing the project itself). This could
allow to run more tests that require to be able to manage the SELinux
policy, automatically at every pull requests.

By the way I wasn't expecting Travis-CI to easily allow nested
virtualization ("nested" because jobs are already run inside VMs,
IIRC). If it works, it is great!

Some quick thoughts/suggestions/comments that I have in my head after
reading very quickly your changes:
- The networking setup of the VM seems to be more complex than needed
because you are relying on getting the IP address from DHCP. Would it
be possible to configure libvirt with port forwarding, so that "ssh -p
2222 127.0.0.1" always work? (with raw QEMU, the command-line
parameters would be something like -net
nic,model=virtio,macaddr=52:54:00:12:34:56 -net
user,hostfwd=tcp:127.0.0.1:2222-:22)
- Usually the helper scripts are located in directory scripts/, which
make them more easily discovered by people reading the code (hidden
files and directories seems more appropriate to store the
configuration for different CI platforms that require them ; some
projects choose to hide everything that is not useful for the build
process but here it does seem to be so). Are there advantages of using
.ci/ directory?
- Moreover having a "fedora-test.run" (or "fedora-test.sh", I am more
used to .sh extension for shell scripts) enables to easily reproduce
tests on a local development machine using "vagrant init
fedora/32-cloud-base && vagrant ssh" + "sudo
/vagrant/.../fedora-test.run". Such a command could be documented in
the header of the shell script.
- Right now, there are many things in .travis.yml. This file could be
split in shell script(s) if that reduces duplication.
- To verify the download of Fedora cloud image, instead of hard-coding
its SHA256 digest, you could download the checksum file which is
signed using GnuPG and check its signature, as described on
https://alt.fedoraproject.org/cloud/

Cheers,
Nicolas

