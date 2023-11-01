Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6557FC4167D
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 19:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjKATEY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 15:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKATEX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 15:04:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE43F7
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 12:04:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50939d39d0fso52718e87.1
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698865459; x=1699470259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEyts5sSCrrf9og6PwF1BTBa2Q90v0rrz4OM4eEUklI=;
        b=JglbIdqOYaIT6N5zXN0skQmcNzi84/Lck9PahQEd2izWzPCu/CotL29JJhRPFsYXiM
         YhUAlQANV9r4vQ+g+trREQrXfWVPHp4YR1dQvlUirgpBlZUJD2BT8Wf/kLU/8uWznSrf
         8uNjK6SNtP7KNFo2clMUUR69EgHcQQKmaNMUe0AuKoqQh/G2qwmX4cHmpvezGBcZXDvP
         8uK6L+p7Gkh8+wD0X5G5+NifJwp//RG/uJQLKBdim5vSykdSW1h/zIsBhIZToalMOj1C
         veuJoTqekkl2NbWHx/rRh3k2Z1t5+AeT0Qo2GSVxExJLNZr5lqUs/6hCLsBn5kyZwOL7
         RunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698865459; x=1699470259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEyts5sSCrrf9og6PwF1BTBa2Q90v0rrz4OM4eEUklI=;
        b=Kd1NpfMKnNn3QY2XaDm6xevie41CHDpX4kmQqPRx2ij5elYqLYn0RVocGiAH+p9D7p
         5D04QN0DrGyqmRYUGKwtPXn/aymsKbkylfHdcQt1nf8VUTMmGUKIcds8INiNOHbTLGt/
         /J8ba1dzOGBBWbzzjSrl37HZDkZbG0JvOi+cqtlMulv9vD7idzn9MjtzFhNNGkp09PN2
         aVw1fMb9k9dqGsR7v6CCbKd62m1z0VJFlFWJUMa11UZ6PMtnWDL9Sadu803R+XMrDaPL
         YII6fxDR/MwrWuJID6opXl1IKBX0ZIRI/B724nZEHFz7Oz7HYKhs6cDdTKAz7bk0UuxK
         8L1w==
X-Gm-Message-State: AOJu0Yye4secKCGLKWrb8bsg/keYZHqS2LfKziw1pqS2Er0p3+hFcVeZ
        lFyeoOmv3Yfq28b6x88m78oF2qZOPi5lKEwnBoktVjp4frY=
X-Google-Smtp-Source: AGHT+IEMkkuwkA4QpMbVR/s7K71p9bVpHclLd1y5lYeXhj7LV0JQIfr99zA08dwPYWERCb0m46UbSYfqcF/guLGemZg=
X-Received: by 2002:a19:5517:0:b0:507:a5e2:7c57 with SMTP id
 n23-20020a195517000000b00507a5e27c57mr12819526lfe.18.1698865458743; Wed, 01
 Nov 2023 12:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <f56796460aeb726520d0d954b94683c4.plautrba@redhat.com> <CAP+JOzTwFoRkevmohFs4gtZnaPPUcOQ3PdkkG0QF8D1tDbO3_g@mail.gmail.com>
In-Reply-To: <CAP+JOzTwFoRkevmohFs4gtZnaPPUcOQ3PdkkG0QF8D1tDbO3_g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 1 Nov 2023 15:04:07 -0400
Message-ID: <CAP+JOzQQe7P9vuDYmu5qnAFS2_8ThXYF34bZy+vWCv_nD5184w@mail.gmail.com>
Subject: Re: SELinux userspace 3.6 release - the current status and plan
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 9:51=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Wed, Nov 1, 2023 at 8:39=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > Hello,
> >
> > it's been some time [1] since we released 3.5 so it's time to start wit=
h
> > 3.6
> >
> > [1] https://lore.kernel.org/selinux/87v8auhbr6.fsf@redhat.com/T/#t
> >
> > Currently we have about 153 merged changes and about 39 changes waiting
> > for review or to be merged.
> >
> > You can see waiting queue at
> >
> > https://patchwork.kernel.org/project/selinux/list/?series=3D&submitter=
=3D&state=3D&q=3D&archive=3D&delegate=3D82149
> >
> > # Series:
> >
> > ## [RFC,1/9] libselinux: annotate interfaces with compiler attributes
> >
> > https://patchwork.kernel.org/project/selinux/list/?series=3D747047&subm=
itter=3D&state=3D*&q=3D&archive=3D&delegate=3D
> >
> > Given that some patches were already rejected, I guess that the whole s=
et could be considered as rejected as well.
> >
>
> Yes.
>
> > ## [1/5] libsepol: free memory on str_read() failures
> >
> > https://patchwork.kernel.org/project/selinux/list/?series=3D765423&subm=
itter=3D&state=3D*&q=3D&archive=3D&delegate=3D
> >
> > Based on https://lore.kernel.org/all/CAP+JOzQ-AuM9M3c4ehKYca-eUAOy0wbVG=
kygkpPkhhSTNaVC-Q@mail.gmail.com/ I've marked them as "not applicable"
> >
>
> Yes, nothing necessarily wrong with the patches, but they would need
> to be updated and resubmitted.
>
> > ## libselinux: rework selabel_file(5) database
> >
> > https://patchwork.kernel.org/project/selinux/list/?series=3D775966&subm=
itter=3D&state=3D*&q=3D&archive=3D&delegate=3D
> >
> > Given that the majority was already accepted/merged, the rest could be =
considered as rejected.
> > If there's no objection I'll mark them before the release.
> >
>
> I am very hesitant about the selabel patches. I have never been
> involved with the selablel code before and I am very worried about
> potential ordering changes leading to labeling problems.
> I would be ok with Christian updating them and resubmitting them after
> this release. I am willing to review the code, but I really need some
> other people to test them before I would be ready to merge them.
>
> > ## [1/5] libsepol: include length squared in hashtab_hash_eval()
> >
> > https://patchwork.kernel.org/project/selinux/list/?series=3D776635
> >
> > no response yet
> >
>
> I never saw this patch series. I got kicked off the mailing list at
> one point and had to resubscribe. I went through the archives, but
> must have missed this series.
> I'll take a look at it.
>

I did take a look at it and it looks good.
I tried my best to create a reply to the list, but I was unable to
make any of the suggestions work.
See: https://lore.kernel.org/all/20230816123845.80171-1-cgzones@googlemail.=
com/

If someone could reply to the first email of the series and cc me,
then I can add my ack.

Unless someone has a better suggestion.

Thanks,
Jim


> > ## CIL Cleanups and Improved Argument handling
> >
> > https://patchwork.kernel.org/project/selinux/list/?series=3D788225
> >
> > There's Reviewed-by and Acked-by attached to the first patch but I gues=
s that it applies to the whole serie.
> > If it's not merged before the release and there's no other objection, I=
'll merge it.
> >
>
> Sounds good to me.
>
> Thanks,
> Jim
>
> >
> >
> > The rest are individual patches which are already acked or waiting for =
review.
> >
> >
> > # Plan
> >
> > During this week, I'll prepare update of translations from fedora webla=
te and I'll prepare pre-release list of highlights for this release.
> >
> > I'd like to start with rc1 during next week and then do rc releases eve=
ry other week (14 days)
> >
> >
> > Please let me know if there's any objection or if you think that we sho=
uld wait for somethig or if you want to have seomthing in release notes.
> >
> >
> > Thanks,
> >
> > Petr
> >
> >
> >
> >
> >
> >
