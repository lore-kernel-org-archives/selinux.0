Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DC4C4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 13:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKINrA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 08:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiKINq7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 08:46:59 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E8D15FD7
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 05:46:57 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id a29so7117890lfj.9
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 05:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBZ1ooQTIuW+RK5hxVDTs7SoW5a0Kp7BjwuIKxAcYFY=;
        b=lo5SDDjl3y9MpEVVquQb3jX/o57RyDnI88gm0xAnDEGLueP5ydHgAH91e022ntWRQ/
         q3zBGN+3wYT5K8+9aWYK9aWWFszMDYbvav9hG273uHHR4WMEBpZWHIG/jsRC2H5wR6T9
         x9h9nXVYLkHy0ToEUx663DpPRA5zlJg8BnkQLdNxyUNWki7ZVSfxyu0iTkkVQPUziTAZ
         3TB29V/W29mcjbLUHFYYTYXOOAt73ralQ9neNNLjwFkKDMQdULqvhgqPux1jyj1sTpQF
         ObG1vzIkclbaMKy7/cURYerZV7uA/aV9D7ydPRbB8+pEGoHm897aODPgJM5Q4K6Azewa
         qtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBZ1ooQTIuW+RK5hxVDTs7SoW5a0Kp7BjwuIKxAcYFY=;
        b=XJFi6IWBGsz/oXVplg91exfH8SZa7LuD6F02NIBqlwlDP0Q9++3kEb9sCO72JJ3PNM
         ixg82vRSC9bQxc6oXCfkBy+JXl5r3C3xAndS1VBofJMgvDJl74I2mm8NJxT3xAHx/pA6
         ofTunaHiSEGaNi3ZnebvctFZLyu8AuGz4WyaBb4nD6nn8RFTvp7kjaYZrB/CKVAuzGNG
         DqpMwLzv2tPi5GnvRBuBIgVgnLvfw7m4QrF3OmMnG2s+6Z8T8K33GyO9y2PRSqo1yGu7
         A+oE5pjS3nz/y/vtt56b2LXXWTn++qwjwTSHv6X0afflW2eZ3ukoRBM/Cc+rVDFnL1O6
         jVHg==
X-Gm-Message-State: ACrzQf2prtDz6usansYK6oM7zslXlfXNGZq0nndDoUE5GGN0d/4qh7Ci
        Wk3YFtWY6u3WIBDxC4lN5uueZsFvY+LtLsKVnzA=
X-Google-Smtp-Source: AMsMyM4dUOxdu44tBm4o3F6r0KhJVRTZJB0waafvDOyNqndVek3mQBhY6+XFfnIqb4KcxoMjTwgimoQ741TvMWeitZ0=
X-Received: by 2002:ac2:5bcd:0:b0:4b0:d503:9afb with SMTP id
 u13-20020ac25bcd000000b004b0d5039afbmr16056707lfn.13.1668001615869; Wed, 09
 Nov 2022 05:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20221013132312.294095-1-plautrba@redhat.com> <CAP+JOzR9MTP09ZNmPPhjA2+p-MYLSDOq35VVXY+D8oRBnYJQ7w@mail.gmail.com>
In-Reply-To: <CAP+JOzR9MTP09ZNmPPhjA2+p-MYLSDOq35VVXY+D8oRBnYJQ7w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Nov 2022 08:46:43 -0500
Message-ID: <CAP+JOzSavoLPO9ibMeVU+Q9QvgwWAnEr=UM+x-enS6x-oSapNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sandbox: Do not try to remove tmpdir twice if uid == 0
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 4, 2022 at 2:38 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Oct 13, 2022 at 9:24 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > If the user is root, tmpdir is already wiped out.
> >
> > Fixes:
> >     # sandbox -T /root/tmp -- id
> >     uid=0(root) gid=0(root) groups=0(root) context=unconfined_u:unconfined_r:sandbox_t:s0:c696,c756
> >     Failed to remove directory /tmp/.sandbox-root-KIlB59: No such file or directory
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> >  sandbox/seunshare.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> > index 8917a0f9bd42..dd1d7ddbdc89 100644
> > --- a/sandbox/seunshare.c
> > +++ b/sandbox/seunshare.c
> > @@ -414,7 +414,7 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
> >                 rc++;
> >         }
> >
> > -       if (rmdir(tmpdir) == -1)
> > +       if (pwd->pw_uid != 0 && rmdir(tmpdir) == -1)
> >                 fprintf(stderr, _("Failed to remove directory %s: %s\n"), tmpdir, strerror(errno));
> >         if ((uid_t)setfsuid(pwd->pw_uid) != 0) {
> >                 fprintf(stderr, _("unable to switch back to user after clearing tmp dir\n"));
> > --
> > 2.37.3
> >
