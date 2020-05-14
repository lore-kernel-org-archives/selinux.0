Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E7FC433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0980220709
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgkHrFXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgENWXv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 18:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728315AbgENWXv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 18:23:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220DFC061A0C
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 15:23:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w10so130856ljo.0
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OTrWu06yLV6v/GCnClVZzRudXZzMy6CUTDqOEvhNsg=;
        b=DgkHrFXng33y2jMUlUfGu5pUCzJpe63+OLT12ImfUNSKR1rDWjG1I+6UGk7mT2rCVQ
         l9otVjZCxblbSriXcAO+v+s3T7gQV5E8UVPzeV3W7K7B6lj5u9Gea20w8dBNDEwJ+ZoK
         GHM1PykTNXcj++wB9OwdQjfdZUt7cjOfRNwCEt1Hm/Y7IPQUqtJ6JNMMEUIsYa6jlYP+
         7b3EreryXf+JkfBeTSnt8m36pntokYg7mwy5mhOPeJ2V8OAqVf/DQHoMeBB/GRnz2tOg
         9EZ6tWGh2koY58ctY0SwUFcsavEqqO7O81N6jqsBIeNHu+7fbvkItaHNwbTaRHLPUsl3
         vbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OTrWu06yLV6v/GCnClVZzRudXZzMy6CUTDqOEvhNsg=;
        b=I8YLjhnive+i4pW5OKNNulvhVst7zMdRCYTueQEZGJZ8mTOuVCsho4EhI7ZWsHD+gg
         AXGJMgL16ipq1aeCD1mJbBaMIyRDELhM8N6JAXy7a02TSJG4Xv2O4zBk1tuZ5xxAvGD2
         MMptY8Nna7RKNe7GwtV05cEVPkO+4mRgYIEs9cCxYmaOib0GOFftBkOAA5X3frV5at4H
         rpR8EQB+Un2H+mg4/DVNfrQHuKQxA5JLRVGYf4xts/imNzH5ETvr3Xj5m8PTqdSSaJNr
         9OAyqfeVinuOGUFnjQDTUfltnZ+FTdj+PIYj9sW3r5VCOJl+UFvbFEVBYVf+l8if1PaX
         07mw==
X-Gm-Message-State: AOAM532RQLTgHPluE4HENBtFd1HpBPsd/aXAtUI+ZKJXUV7TZ6GrCaQS
        Nz67ZQvUgh9BpSPTzAqeVQVKFd34NmRrjFFKBB4=
X-Google-Smtp-Source: ABdhPJwGJBx1Q9ISdMrJqGyZU89faEsXN1XO+1X6yXXlA9TuUCGnksoirgIf3M5sB9RJD4ao74gIKAoAwhDHWOibXG0=
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr259841ljp.95.1589495029419;
 Thu, 14 May 2020 15:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <3581425.j52oWYpJar@liv> <20200407085922.GA438349@workstation>
 <20200422065053.GA167999@workstation> <CAHC9VhQUmY=ue3zWdTnE1Ehi90Lj3077sLbu+jyaWoAVKuKyeQ@mail.gmail.com>
 <CAFftDdo1hqbacU2TD6zQp_t_KJq-KS5pWBMr89c4HA3=aUdUbQ@mail.gmail.com>
 <20200423150039.GC204116@workstation> <CAFftDdq_g_rUy=KFh_gOEXoVxkCgz9qWzR17d4Mt1qVChoVLjg@mail.gmail.com>
 <CAJfZ7===ssyARiz=cG73hqRq_+d+tGuNKX9-nOU7VJVZGS=+zQ@mail.gmail.com>
In-Reply-To: <CAJfZ7===ssyARiz=cG73hqRq_+d+tGuNKX9-nOU7VJVZGS=+zQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 14 May 2020 17:23:37 -0500
Message-ID: <CAFftDdqhN8KNrNy69tK7LCgD-WewLN9pJjTt8-v4CiuMFonh0A@mail.gmail.com>
Subject: Re: Fedora VM On Travis for Testing
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
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
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 5:03 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, May 14, 2020 at 11:00 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > I just wanted to lay out a demo of a Fedora 32 cloud VM image booting
> > on Travis with execution happening in the Fedora VM.
> > The Fedora VM contains the selinux source code for that particular
> > travis build, so it has the PR patches, etc.
> > The VM has networking.
> >
> > The build logs for the Travis run are here:
> >   - https://travis-ci.org/github/williamcroberts/selinux/builds/687185489
> >
> > Which comes from my git tree here:
> >   - https://github.com/williamcroberts/selinux/tree/kvm-fedora-testing
> >
> > Note that it's super messy, I need to go through and cleanup both the
> > patch and the git
> > history. I also should verify the downloaded image is signed for the VM.
> > Also note that I may rebase/squash my git branch at any time.
> >
> > Petr started a release document here:
> >   - https://github.com/bachradsusi/SELinuxProject-selinux/blob/RELEASE/RELEASE_PROCESS.md
> >
> > I'd like to gather feedback, and perhaps more comments on:
> > 1. Is this CI approach worth continuing?
> > 2. Comments on the CI scripts (I have no idea what I am doing, common issue)
> > 3. Comments, patches, suggestions on what tests to run in this CI environment.
> > 4. More information in in the RELEASE_PROCESS.md file. I made some
> > comments there
> >     as well on ideas.
> >
> > My goal here is that a release can occur if CI is passing without
> > worry, and that
> > we automate manual steps as much as possible. This way, if we get hit by a bus
> > releases can occur without much effort.
>
> Hi,
> This sounds like a nice idea :) Also it appears it only takes 5
> minutes to run the whole Travis CI job of setting the Fedora VM up and
> booting it, which is more than acceptable in term of delays (and is
> very quicker than building and testing the project itself). This could

Yeah I was pretty happy with the timing it took to add this. But CI doesn't
necessarily need to be fast. We run a huge test matrix, Travis only
spins up a few at a time anyways.

> allow to run more tests that require to be able to manage the SELinux
> policy, automatically at every pull requests.
>
> By the way I wasn't expecting Travis-CI to easily allow nested
> virtualization ("nested" because jobs are already run inside VMs,
> IIRC). If it works, it is great!

I was surprised too, I was expecting that to be disabled, when I cat
cpuinfo, I was very happy.

>
> Some quick thoughts/suggestions/comments that I have in my head after
> reading very quickly your changes:
> - The networking setup of the VM seems to be more complex than needed
> because you are relying on getting the IP address from DHCP. Would it
> be possible to configure libvirt with port forwarding, so that "ssh -p
> 2222 127.0.0.1" always work? (with raw QEMU, the command-line
> parameters would be something like -net
> nic,model=virtio,macaddr=52:54:00:12:34:56 -net
> user,hostfwd=tcp:127.0.0.1:2222-:22)

I would love something like that (no idea what I am doing),
but it doesn't get rid of polling for network. We have to wait
for the sshd to be ready.


> - Usually the helper scripts are located in directory scripts/, which
> make them more easily discovered by people reading the code (hidden
> files and directories seems more appropriate to store the
> configuration for different CI platforms that require them ; some
> projects choose to hide everything that is not useful for the build
> process but here it does seem to be so). Are there advantages of using
> .ci/ directory?

No benefit, just did something. They can live wherever....

> - Moreover having a "fedora-test.run" (or "fedora-test.sh", I am more
> used to .sh extension for shell scripts) enables to easily reproduce

and be named whatever....

> tests on a local development machine using "vagrant init
> fedora/32-cloud-base && vagrant ssh" + "sudo
> /vagrant/.../fedora-test.run". Such a command could be documented in
> the header of the shell script.

That sounds good, I like being able to do that. I have no idea what vagrant
is. You could say im ignorant to vargrant!

> - Right now, there are many things in .travis.yml. This file could be
> split in shell script(s) if that reduces duplication.

Yep I agree. Thats how I run all my other projects, I dislike large
travis.yml files,
but I don't want to take on that workload right now, ideally get this
working and then port the other stuff.

> - To verify the download of Fedora cloud image, instead of hard-coding
> its SHA256 digest, you could download the checksum file which is
> signed using GnuPG and check its signature, as described on
> https://alt.fedoraproject.org/cloud/

Yeah I saw that. Thats why I had that verify link in the TODO
comment:
https://alt.fedoraproject.org/en/verify.html

>
> Cheers,
> Nicolas

Thank you, appreciate your feedback
