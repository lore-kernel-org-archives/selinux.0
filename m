Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630F6C0032E
	for <selinux@archiver.kernel.org>; Thu, 26 Oct 2023 02:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjJZCQZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Oct 2023 22:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZCQZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Oct 2023 22:16:25 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356F812F
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 19:16:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so273431276.0
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 19:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698286582; x=1698891382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w05sPWRTm+dTN05NaYeFN/A9IoO8yIGSl25pWiGAJHM=;
        b=LPgRLYUrZq7EeZr6m/0aONn+uGDfJ1eb82weaP9IfoowOd88xTi/EkdhzO7go3omDv
         A8hPrKrDaTFLNB4JufEBvhT7mt8G38GrcVuB+pYKh08eam+5KR90CCmzuXMacK661Oeh
         wMgX/VNAftjTgBi75/AWdTmd3vLjct4Kq3x6K/LrBSuzNo2Y+H16BeSl0uI5wBoIlhMo
         WtWZ0EqTsjEE3yX6qzFSbtctWMLnCiPDo71fITVu8Y75j56kc3RapaBrpNzs9ZpoOFGF
         u0mnSxzjG3FPWFqu/D65yHSm08PLeLsbd0gvvYLtvOOxlhNBHarbIJ6kjKHKEPu54SCc
         t1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698286582; x=1698891382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w05sPWRTm+dTN05NaYeFN/A9IoO8yIGSl25pWiGAJHM=;
        b=w4HLize5Pmj1yPtm+5k4uuQoCdulXkhiO/1lVOlb/X6SMkTkTE+r6KWM5LSBM4s05U
         B0FkCTo7d6jDm301Z1N+r/qHWAEgGiPTXyJJbtTsV4uvWyAHl1DOTjLAs2IFErwjQkX+
         z6XrUdW47om5N12uxWm+pDf6pp538nLrUj4zEGOXsDu4WogzJFHeJt9Wmv6ZrTx4lY8Z
         Lsn58IaRgy30uDOQrOLFqiMesYKTiY0EalUWqkeBQ2kTd3BMAsLciYivns+oQQMmqGlv
         xWtYCj6ykoVEaHsz/uMdx+fiZhgPdO/nGTjomeqbLv2op3KahAA4IaCBI4LKmbd2632a
         jqCw==
X-Gm-Message-State: AOJu0YyLBMQ9o/XU9/7vwrD6uFI6U9Yne1fhE2KlcsU8vg1sox+p+Zgh
        K4tWCd3cg8prNvNyuSWT+5AacItnlQh6JRf1D0rkzB9xYvy94qI=
X-Google-Smtp-Source: AGHT+IE1kF4MvlgJF/5BHrItJJ0M8T7QXsoNMMvPvjDfTuLB94fBGUcT14YecoHMjdIo4yHACm5ZO7cs5Ofw2ObQllE=
X-Received: by 2002:a25:a2d2:0:b0:d9c:66d1:958f with SMTP id
 c18-20020a25a2d2000000b00d9c66d1958fmr16829131ybn.55.1698286582333; Wed, 25
 Oct 2023 19:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1wwgH6NNd+cJz4MYogPiRV8NyPDd1yj5SpaxeUB4UVg@mail.gmail.com>
 <ZTm_9Bj1XYTzL0Za@debian.me>
In-Reply-To: <ZTm_9Bj1XYTzL0Za@debian.me>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 25 Oct 2023 22:16:11 -0400
Message-ID: <CAHC9VhSeqEbtdno0mx-J53SSwCcsUr8_Ovj3QVji7rzbYS9bGw@mail.gmail.com>
Subject: Re: ANN: kernel git branches and process changes
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Security Module Subsystem 
        <linux-security-module@vger.kernel.org>,
        SELinux Mailing List <selinux@vger.kernel.org>,
        Linux Kernel Audit <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 25, 2023 at 9:25=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
> On Wed, Oct 25, 2023 at 05:11:51PM -0400, Paul Moore wrote:
> > #### stable-X.Y branch
> >
> > The stable-X.Y branch is intended for stable kernel patches and is base=
d on
> > Linus' X.Y-rc1 tag, or a later X.Y.Z stable kernel release tag as neede=
d.
> > If serious problems are identified and a patch is developed during the =
kernel's
> > release candidate cycle, it may be a candidate for stable kernel markin=
g and
> > inclusion into the stable-X.Y branch.  The main Linux kernel's document=
ation
> > on stable kernel patches has more information both on what patches may =
be
> > stable kernel candidates, and how to mark those patches appropriately; =
upstream
> > mailing list discussions on the merits of marking the patch for stable =
can also
> > be expected.  Once a patch has been merged into the stable-X.Y branch a=
nd spent
> > a day or two in the next branch (see the next branch notes), it will be=
 sent to
> > Linus for merging into the next release candidate or final kernel relea=
se (see
> > the notes on pull requests in this document).  If the patch has been pr=
operly
> > marked for stable, the other stable kernel trees will attempt to backpo=
rt the
> > patch as soon as it is present in Linus' tree, see the main Linux kerne=
l
> > documentation for more details.
> >
> > Unless specifically requested, developers should not base their patches=
 on the
> > stable-X.Y branch.  Any merge conflicts that arise from merging patches
> > submitted upstream will be handled by the maintainer, although help and=
/or may
> > be requested in extreme cases.
> >
> > #### dev branch
> >
> > The dev branch is intended for development patches targeting the upcomi=
ng merge
> > window, and is based on Linus' latest X.Y-rc1 tag, or a later rc tag as=
 needed
> > to avoid serious bugs, merge conflicts, or other significant problems. =
 This
> > branch is the primary development branch where the majority of patches =
are
> > merged during the normal kernel development cycle.  Patches merged into=
 the
> > dev branch will be present in the next branch (see the next branch note=
s) and
> > will be sent to Linus during the next merge window.
> >
> > Developers should use the dev branch a stable basis for their own devel=
opment
> > work, only under extreme circumstances will the dev branch be rebased d=
uring
> > the X.Y-rc cycle and the maintainer will be responsible for resolving a=
ny
> > merge conflicts, although help and/or may be requested in extreme cases=
.
> >
>
> If I have patches targetting current (not next) release cycle, either for
> stabilizing that cycle or for stable backports, I have to base it on dev
> branch (not stable-X.Y), right?
>
> Confused...

I would prefer that yes.  I know it sounds a little odd, but I'd
rather see folks develop and test against what we believe to be the
latest subsystem code, which is what lives in the dev branch.  If
there are merge conflicts, I'd rather we see them when merging the fix
into the stable-X.Y branch so we are aware of the conflict at
development/submission time rather than waiting for the next merge
window.  Having done this for a number of years at this point, I've
learned to appreciate seeing merge conflicts as early in the
development cycle as possible and I've also learned that they are
often not as scary in practice as we imagine.

Of course all of this is a general rule since you can't specify every
single situation in guidance like the above; if there is something
that you believe is particularly ugly you can always write the mailing
list, or me directly if the issue is sensitive, and we can sort it
out.  If after a few months (year?) this proves to be too painful we
can always revisit this and update the policy, it's definitely not set
in stone.

Hopefully you are less confused now?

--=20
paul-moore.com
