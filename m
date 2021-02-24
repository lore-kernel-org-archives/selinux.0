Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA46C433DB
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 01:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F16660231
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 01:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhBXAzf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Feb 2021 19:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbhBXAbA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Feb 2021 19:31:00 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64599C06174A
        for <selinux@vger.kernel.org>; Tue, 23 Feb 2021 16:04:06 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id t11so235600ejx.6
        for <selinux@vger.kernel.org>; Tue, 23 Feb 2021 16:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ujaSmRZsBwxy7ijiic2DjRlFM+Lo7XjiktoksGBmZgU=;
        b=MXPvsr/Zq3sNjA2W5lZe7IVflfhgQurENqiXsHQYmttYRBz5dw1hZ/ed7IovhkrcRt
         7TwYNnOWrwiQnZlXQb0GA15n/O6naKhHtEfr3AgQU+KPS7tUWsZfKFs0ej55icBMTvxJ
         5Zzd8n2tLorAzM0mgGDLWE3VJgk3K1Z0Aomsr3+fPC0vKlmNeG1k1vgPHxH3cGvq3TnJ
         SM2hhPOiilYIb/SNeL+BSfwj25eJRdCerMoX51gyPrzlPtzBWuQUwdT/LTDEVqoIlUlv
         80KgVIaot5po/5jpVwdOR7urqFAuszD47Kzyb6Pp2a3Eiqm2U0iE6nuAYeugvtypHQwX
         4YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujaSmRZsBwxy7ijiic2DjRlFM+Lo7XjiktoksGBmZgU=;
        b=bqeFIQxTJywWBwWWK21qyoozs4wYjpkWPaFYDEiHoqBqhlsEQAzXbXsoN5x1py2bw5
         IniQrXa0Do9hDpxKNEqKJTRlbPvY2UdmXhYziTwHkPhzCkoRyN2p/eKJzi6GTpzjMk3L
         75HOznWx8n1omhVhjCTljOCdZQqcKfu7cVPT1jnuGjirG13Nh5RYuLnxn1ZVWuomQ9Nc
         ikcjEqlBufXjYxZHs5cLtsqsaoKcTmHNoxz+vt4V9kVI6aQy8ysz2bA/cDhfTHKpXxV5
         2I6e+rEbnhHgfb9BOhu9gjQLBV7W7ucGF0Xfyb5fFj3M08LIuGc+fei0Z/T1BRTZd5zQ
         A+bQ==
X-Gm-Message-State: AOAM531V9fK1UMXbIW3U5pM4ZRBUcm/uIKUXKkC/mXRnpCBBy+LIMQA5
        3L/s/bo66r0orULzcnQHMHH5z7GQcXDgzJmnnV4C60kuPA==
X-Google-Smtp-Source: ABdhPJw7wLn61yBHi1fjBNwK7jx6HvQKpbr/Lp7IKALGN+KVnBhrQW3vKurixFkk+NIXSNeZw2lwjYObNn8YYQZEqx4=
X-Received: by 2002:a17:906:a443:: with SMTP id cb3mr13393865ejb.542.1614125043313;
 Tue, 23 Feb 2021 16:04:03 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <9ea5259b-fd84-e176-c042-c52a1c4fcc27@schaufler-ca.com> <CAHC9VhQBbep2WkD6JkCemtcXFLq7j5=AQeM9vVJ4_gmvi7hPQA@mail.gmail.com>
 <1ab6d635-53af-6dd9-fc29-482723c80c6a@schaufler-ca.com> <e03dedaf6f3fc439d1d2240e6c6d5e66301441fd.camel@linux.ibm.com>
In-Reply-To: <e03dedaf6f3fc439d1d2240e6c6d5e66301441fd.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Feb 2021 19:03:52 -0500
Message-ID: <CAHC9VhTQ0uerosmEBTSdH6qNCZ9Z7kt21S3N8XVdRHzwV_kiqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Split security_task_getsecid() into subj and obj variants
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 23, 2021 at 9:14 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Mon, 2021-02-22 at 15:58 -0800, Casey Schaufler wrote:
> > On 2/20/2021 6:41 AM, Paul Moore wrote:
> > > On Fri, Feb 19, 2021 at 8:49 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >> On 2/19/2021 3:28 PM, Paul Moore wrote:
> > >>> As discussed briefly on the list (lore link below), we are a little
> > >>> sloppy when it comes to using task credentials, mixing both the
> > >>> subjective and object credentials.  This patch set attempts to fix
> > >>> this by replacing security_task_getsecid() with two new hooks that
> > >>> return either the subjective (_subj) or objective (_obj) credentials.
> > >>>
> > >>> https://lore.kernel.org/linux-security-module/806848326.0ifERbkFSE@x2/T/
> > >>>
> > >>> Casey and John, I made a quick pass through the Smack and AppArmor
> > >>> code in an effort to try and do the right thing, but I will admit
> > >>> that I haven't tested those changes, just the SELinux code.  I
> > >>> would really appreciate your help in reviewing those changes.  If
> > >>> you find it easier, feel free to wholesale replace my Smack/AppArmor
> > >>> patch with one of your own.
> > >> A quick test pass didn't show up anything obviously
> > >> amiss with the Smack changes. I have will do some more
> > >> through inspection, but they look fine so far.
> > > Thanks for testing it out and giving it a look.  Beyond the Smack
> > > specific changes, I'm also interested in making sure all the hook
> > > callers are correct; I believe I made the correct substitutions, but a
> > > second (or third (or fourth ...)) set of eyes is never a bad idea.
> >
> > I'm still not seeing anything that looks wrong. I'd suggest that Mimi
> > have a look at the IMA bits.
>
> Thanks, Casey, Paul.  The IMA changes look fine.  IMA policy rules are
> normally written in terms of a file's LSM labels, the obj_type, so
> hopefully this change has minimal, if any, impact.

Thanks Mimi I appreciate the additional review.  Would you mind
sending your ACK for the IMA related patches in the patchset?

-- 
paul moore
www.paul-moore.com
