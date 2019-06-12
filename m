Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8A1C31E48
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735D7206E0
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQXRMmEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfFLSkN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:40:13 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39465 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfFLSjp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jun 2019 14:39:45 -0400
Received: by mail-it1-f196.google.com with SMTP id j204so12197717ite.4
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Js1TOkm279Vn4hBlFPYGCDgI48jTfmK6r5Rq/6QD0Sk=;
        b=AQXRMmEXNrfK5j151MbCuo2iR6YWjQCfR9dT8HAN+hOFbH6GKiKqxQjvitnM8IsHOk
         Wv6olkxTvRDT0SaDGD3C9UqrOOgFlROYOByURiMh5BJEM9QUtj5PQe2OOp0zg/PPkBK1
         OaAbWeXpEIIkO9kELkr/d5+WR8r664sDSiK0MICR9Jvkp62BkL3gybVUWLliqyl5QXpg
         0xQDn2se/9Tnzm4afgS2h8AiQrAMDRwob1/212qJHVVXuSLdIyH5Goto/7TOrtcvOQU0
         3nkFjVNwIZmBr+grotsiQTZc181m10lL4rX/rZYkktwOlNCVxDW0V4QzWLUSyClR0VkQ
         nhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Js1TOkm279Vn4hBlFPYGCDgI48jTfmK6r5Rq/6QD0Sk=;
        b=KhCm6e4VjQxYrCyPIgwrsjrSTPQLy12NyE7GdpfYoI3L6gAwbEhMeOflCF1IQ7587T
         sSbv7xgr21L1gjC7qpL/IboApqClXHvcg9/1RLVFkL3LoH5NMV7bzYykSjxVmL7wED9w
         /i4O3VNrzB9rZBNuPc2T5GJwI1GiID3iyOLDPAmdXHo/vxpCBhGdzyOVXYvfNEoGzIjf
         RwX8Sym167z363UFAub+3EJKV945en2IEOlRAP7HJAG+9lJ2LQzRhU2OHCIRyl7S98gQ
         QzMCVAQo4k8XWPDBru/3rIVMAlsMsMaHibHRqGFbcebvxhiNHA2nKkwC3eHvOX9o6aCq
         ExJQ==
X-Gm-Message-State: APjAAAUqmD+XkZv4df/XyPyv5nUCrsPYk58gPnduxTe9nrE7tgnmBSwQ
        5k3ZS/oLbZ+9RjbM68LGfNd5gULmryZL97dshDPWorkr3HA=
X-Google-Smtp-Source: APXvYqyOKyAagmjDXwUalgZGinbsEk9YN3l9SoJDDFZoVV3VMZkE/HklQxuDKcuIqpC9gNfEg9r7WNrt9BN+EQpVj90=
X-Received: by 2002:a24:5247:: with SMTP id d68mr444358itb.141.1560364784064;
 Wed, 12 Jun 2019 11:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1905242306150.9521@34-41-5D-CA-59-C7>
 <pjd5zphv6ei.fsf@redhat.com> <pjd4l51v4ge.fsf@redhat.com> <alpine.LFD.2.21.1906121730070.28042@34-41-5D-CA-59-C7>
In-Reply-To: <alpine.LFD.2.21.1906121730070.28042@34-41-5D-CA-59-C7>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 12 Jun 2019 11:39:32 -0700
Message-ID: <CAFftDdp=Tp1V0wfdn_wiFcaSyHwQV_=NYi0s_Rz5Yvvj-DaUiw@mail.gmail.com>
Subject: Re: [PATCH] trivial: remove unneeded int
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 12, 2019 at 11:01 AM Jokke H=C3=A4m=C3=A4l=C3=A4inen
<jokke.hamalainen@kolttonen.fi> wrote:
>
>
> Hello,
>
> On Fri, 7 Jun 2019, Petr Lautrbach wrote:
>
> > The same comment applies also to your other unmerged patches
> >
> > * trivial: remove unneeded int
> > * remove redundant if
> > * More accurate error messages
> > * trivial fix incorrect indentation
> > * trivial typo fix
>
> The simple patches now have a "Signed-off-by:" line in
> the description.
>
> Pull requests have been done.
>

You have all your new patches as individual PR's with merge commits, very w=
eird:
https://github.com/SELinuxProject/selinux/pull/154/commits

Rather then:
1. creating a PR per patch
2. merge workflow

Please:
1. Since all your patches are related in goal within the series, just
put them on 1 PR
2. rebase workflow, ie always git pull --rebase origin/master
    I don't know if this is the most efficient way with git, but you
can just cherry-pick all
    those commits on a branch that is up-to-date with master.
3. You still need to send them back out to the list
4. commit messages lacking

On top of that, Stephen has mentioned that we don't want to get in the
habit of taking style
fixes. The three actual changes you have are:

> > * trivial: remove unneeded int
> > * remove redundant if
> > * More accurate error messages

Additionally, lets work on those commit messages, typically when
someone starts with <label>: that label isn't
something like trivial, it's used for referencing the component touched.

libsepol: remove unneeded int

the routine context_is_valid() had an int that was used as a return
code that was set and never modified. Just return
the constant instead.

<signed-off...>

I'm OK with those three if you fix the 4 issues I pointed out. I'll
let Stephen decide the fate on the pure style patches.
> Best regards,
> Jokke H=C3=A4m=C3=A4l=C3=A4inen
