Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9E0EB64D9
	for <selinux@archiver.kernel.org>; Wed, 28 Jun 2023 01:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjF1B2E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Jun 2023 21:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF1B2E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Jun 2023 21:28:04 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E6D2125
        for <selinux@vger.kernel.org>; Tue, 27 Jun 2023 18:28:02 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5703cb4bcb4so45603257b3.3
        for <selinux@vger.kernel.org>; Tue, 27 Jun 2023 18:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687915681; x=1690507681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn49EvtPd2I57PHJ9DxAzVe24AA5Q46zoKDx435Xu2M=;
        b=RCPZqTSQQ/Ma1oKB+A0nDg2xXf04Za3JaiX2i+dpBm6UMn+uUqxMk7eS/IsQZiTClE
         +s1FTRQR+GRRP/b6s9XYTInUzH1xqos71EdM+rgDxepFkJyJ0+k2MPyb52bFlFVjYKv1
         Z3Wnur3nVc27Tn9QYKeWRP72VjK3WjsyRizdrHlnHxMMjM15VhbvRIeiQ02YNmwmJvv/
         yap8C6IbLv4cj0ugL52Thi0YEoJMlTZoveMHcSv4hwl48FSyRQu8mzi5k1JiR0n/HiQM
         j/nMHjNJExMI0PCMSc9ukj4r43wTAx3+QpHKhaU7TexASFp8wVZgqbAqHjTUnOl/90Su
         RgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687915681; x=1690507681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn49EvtPd2I57PHJ9DxAzVe24AA5Q46zoKDx435Xu2M=;
        b=kNwJIVVI+A4D4hJF0mZ/hmdUdXHfmkW2KvROItOXXdryZUO21ZMuZKIQ4U+2/aU6tW
         8EQa8b4e4awJXkGUZKJ0C978KkrYdL9gEjQQZ3VD6ih/IvQxaixjD6Gs6h8BuOpk1di0
         AmVl+hHDxvGNqsID1J/5eUZrCM8jpCYS2oFcljsGAs3z2qkKNAoAaW+aaYyd098Nbllp
         VZBwNFfEpDpYhY8tQR3pG6Gi0Juhzg4cb2OWRtDV2Ej6u1PEGlLLg38icnRRv1Vk+FPc
         hWvzJXkyuxkS9inAlEobbdkgNlZlMW55MOhJcFGUPCXY5QumLj9JPSRIaEckmSousD2s
         0jZw==
X-Gm-Message-State: AC+VfDyTZ+7cM+OTVOFSnw/U3hmR4bsScpKHOenppx7LY2iO2kWvewYM
        9HmrzbauM6dTj9HwEyXFfos5lGoytMp3M2ZMiOcV7QkKTbg29QKB8Q==
X-Google-Smtp-Source: ACHHUZ7ZUxLTQKSiAlXQ2sO19fudM6LZG1/tNd6zzNhmO04Gm4mGmcx33lTSX+3W5Au9s6+mMgrE0j/VvvTuYa43avQ=
X-Received: by 2002:a0d:ddcb:0:b0:56d:308f:1f00 with SMTP id
 g194-20020a0dddcb000000b0056d308f1f00mr22680379ywe.12.1687915681653; Tue, 27
 Jun 2023 18:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRpBZpqwJ4J+sPHr=ZMmkpd5qmLW-a+B+GGKre=NSU-AA@mail.gmail.com>
 <CAFqZXNs+VW44pa2kMLDqcOMRaudNXgZCuGy2Zt51KhR2fD7QOg@mail.gmail.com>
In-Reply-To: <CAFqZXNs+VW44pa2kMLDqcOMRaudNXgZCuGy2Zt51KhR2fD7QOg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Jun 2023 21:27:50 -0400
Message-ID: <CAHC9VhTsStLPVPnjb=k+dgbtUPk_5H1rvS3NRx46Cfws2FnZ3g@mail.gmail.com>
Subject: Re: RFC: style/formatting changes for SELinux kernel code
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 27, 2023 at 10:34=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> On Fri, Jun 9, 2023 at 4:24=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > Hello all,
> >
> > Over the past few weeks, as time allowed, I've been working on adding
> > some automation to my Linux Kernel workflows.  Most of this has been
> > scripting various maintainer tasks, e.g. reviewing and merging
> > patches, which I expect is not very interesting to most people reading
> > this, but I think there is one aspect of these automations that might
> > be interesting for a wider audience: basic patch sanity/verification
> > tests.  These tests are intended to mimic the sanity tests I perform
> > when reviewing patch submissions, things like "run checkpatch", "make
> > sure it builds without error", "ensure the style/formatting is
> > reasonable", etc.  For those that are curious, you can see the current
> > tests in the repo below, but I will caution you that there are surely
> > problems with the scripts, they are still very new and barely tested;
> > expect changes.  I should also note that I haven't published the
> > tool/framework which I use to run these tests just yet, but the tests
> > are intended to be standalone so there should still be value as-is.
> > My thinking is that by sharing these scripts, and keeping them
> > updated, it will help keep the developers and reviewers sync'd as to
> > what is expected from a SELinux kernel patch.  Much like checkpatch, I
> > don't expect these scripts to represent a perfect, ideal standard but
> > I think they represent a "good enough" example where the accepted
> > verification failures should be relatively few.
> >
> > * https://github.com/pcmoore/git-verification_scripts
>
> This looks like a nice step forward.

Thanks.  My hope is that we can continue to grow/refine as we go along.

> Are you also looking into
> integrating these checks into patchwork? I noticed that e.g. in the
> netdev project patches get tagged with similar sanity checks (netdev)
> and even test results (bpf).

I just noticed that a few weeks ago too.  I took a look at the
documentation (there isn't much) and it looks like I should be able to
mark/set the "checks" using pwclient; I'll need to do some extra work
to filter out the non-kernel patches but that shouldn't be too hard.
For a while now I've had hopes to automatically run each posted
patchset through a full build/test cycle similar to what happens with
kernel-secnext and updates to the XXX/next branches, and getting it
working with the sanity tests above is a good first step towards
making that happen.

> Perhaps you could even reuse some of the tooling/infra they use.

As far as tooling/infrastructure is concerned, I've got my own hacky
little setup that I started putting together back when I started the
kernel-secnext automated builds/testing, I'd just assume use that as
it is already in place and works well for my needs.  I can post a link
to the tooling I use if anyone is interested, but I'm not sure I would
recommend anyone use it ;)

> > With all of the above in mind, I wanted to get everyone's opinions on
> > the style/formatting suggested by the scripts above.  As anyone who
> > has looked at the SELinux kernel code knows, the style is somewhat
> > inconsistent, both with respect to the SELinux subsystem, and the
> > kernel as a whole.  That unfortunately means that if we want to be
> > able to start vetting the style of new code changes, we really need to
> > properly (re)format the existing code first.  Before I went too far
> > with this I wanted to see what it might look like when applied to one
> > of our ugliest source files, security/selinux/hooks.c; you can see the
> > results in the commit below:
> >
> > * https://github.com/pcmoore/misc-linux_kernel/commit/3f94fd77b46522a03=
8eb6771b63d0a6d36ca3547
> >
> > I'd like to hear what everyone thinks about making a change like this.
> > I personally think it is a positive step forward, but I do acknowledge
> > that those who have to do backports will likely feel some occasional
> > pain.  As the backport pain will eventually subside, and the benefits
> > of nicer-looking code and improved/shared patch verification will
> > continue, I'm leaning towards reformatting the code, but I do *really*
> > want to hear what people have to say before we do this.
>
> Regarding the impact on backports: yes, this will be potentially
> *very* painful for us (Red Hat engineering), depending on how it's
> done. What would help is if you could split the change into many small
> commits - ideally something close to per-function (with some closely
> related functions/declarations/definitions maybe combined together).

Thanks for the input and the suggestions.

I'm not sure I have the time/patience to do this on a per-function
level across all of security/selinux, but I understand your point
about breaking it up to allow for easier cherry-picking.  Let me see
what I can do.

> From a pure upstream perspective I
> definitely support the change, so hopefully we can come to a
> compromise such that we are both happy with the result :)

 :)

> As for the proposed style, it looks mostly good to me. One minor
> concern I have is that it removes some visually helpful alignment
> after '=3D'/':' in selinux_sb_clone_mnt_opts(), selinux_syslog(),
> selinux_fs_parameters, and selinux_nf_ops. Not something I would lose
> sleep over, but would be nice if it can be somehow preserved.

I'm not sure if there is a clang-format config setting for that, but
if I'm honest I kinda prefer it without the alignment.  If you can
find a clang-format config that would preserve the alignment without
affecting anything else we can consider it, but I might pull a
"maintainer's prerogative" card on that ;)

--
paul-moore.com
