Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B885C282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 14:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D04F2070E
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 14:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uAlMUBq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgAHOPi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:15:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41897 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgAHOPi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 09:15:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so3459609ljc.8
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2020 06:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5pI4fBzIJsU6l3gU7xTEo4VjlTDOUzp1D9uIDuFCa+g=;
        b=uAlMUBq0BlVKe0v7UV65l+B6i9q9FmRwjd5EpWjiXlFuWeQEWyuhbuH5V+EuNNwzlE
         0uF9HEquG1FuGrLVQiToVGhtZfDdDCaCNUVBmu3brpVCAnNSgdUiSXKafacfVf1f682P
         5UdSyTLXIA0Va1BYX4gfa6ryNq9KfbIlFtPTJjmbNLPnGB+OZli3lAIXGNoxRfwDpEB9
         fUcyEDe3N0AKp62Ey5Akif+Sc6+whqljrAaXdw7ia/6IDIVneL9FDMh/x5hGIubTFkla
         4f1GTPndGcBYBHk9cqPyZFtCKuPyfY5JwsGUMLyz8omeYFBpGdAVE+CQH2BDGwH/a6Re
         7A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5pI4fBzIJsU6l3gU7xTEo4VjlTDOUzp1D9uIDuFCa+g=;
        b=hAlxTdUl8Fg1tf0gvwHppAVAiWI7xZwrzxvLCV1J5G6BygRN1b8PQCtV1b8eLR9p5v
         3O5rqGXtIKwzhJHPE0C+fMqpgS4mZUYy9ayLJgQXEnvHavjCplYaaEtP0FBOg8MV7CrT
         wtY5IBeFku7nAGR1S4UaYNUt5GNHszjqF2gr6CVOPwYfw1JVvIHloqe7FTrpGDzF7TmY
         FtKKhFCBJ33Ks0I7v3tDkCusbm5/zQZaUjdj1kI7fv87/VavsZfDJTuWNlQxeEa05LR3
         0zYbSIaOh56pmm911lvFdnaF+nIR2D9vFFHBB7hNgNSL7M/kNjh+6ZokY/zvawRuT9pJ
         IG6w==
X-Gm-Message-State: APjAAAU3AzlO7Z+utm8CqZGu298gDXRrirY/GJCvTYexr3mnLJvCNFY+
        Z6rEPsOYd4NS97OWYfI2GMQm/zsNNbw3PRk3TWNI
X-Google-Smtp-Source: APXvYqw9E0p/QPHbPafCS90m3U/efgSb16c6904jK20sjRnoTrZVpBE7Bxb8tyODPcUw3t11L4jKjBc+eUT5yf267V8=
X-Received: by 2002:a2e:7e11:: with SMTP id z17mr3075912ljc.117.1578492936421;
 Wed, 08 Jan 2020 06:15:36 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_Ddz0dXzuhyyO_SNNZRc==8K7Nba0N6Rh_u+yig6c7w3tQ@mail.gmail.com>
 <ed8c325b-f8e8-3e91-81cf-1db5c59e2bc0@tycho.nsa.gov> <CAJ2a_DcEnxg4w92ayqg7y76_5AvkGnzFBU32FpV_qzcxuUN_Pg@mail.gmail.com>
 <CAFqZXNsOJMS_pi80O1+-57dBgwGJ0oHS=v2b1X9SR2rU1u0=dg@mail.gmail.com>
In-Reply-To: <CAFqZXNsOJMS_pi80O1+-57dBgwGJ0oHS=v2b1X9SR2rU1u0=dg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Jan 2020 09:15:25 -0500
Message-ID: <CAHC9VhS7aeDk-BYYQ4GE0KbBzdRAcurA-MxOZmk_d3sqN2Zdvw@mail.gmail.com>
Subject: Re: incorrect sysfs contexts
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 8, 2020 at 8:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Dec 19, 2019 at 3:16 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> > Default Debian sid kernel:
> > Linux debian-test 5.3.0-3-amd64 #1 SMP Debian 5.3.15-1 (2019-12-07)
> > x86_64 GNU/Linux
> >
> > Somehow symlinks do not inherit their parent label.
> > They all have the root-sysfs label.
> >
> > Remounting sysfs with `mount -o remount -t sysfs /sys` leaves all
> > symlinks with the root-sysfs label.
>
> Hm... this seems to happen due to the !S_ISLNK(inode->i_mode)
> condition in inode_doinit_with_dentry() introduced in ea6b184f7d521
> ("selinux: use default proc sid on symlinks"). Since the condition was
> apparently only intended for procfs at that time, I think we can
> change the condition to !((sbsec->flags & SE_SBPROC) &&
> S_ISLNK(inode->i_mode)) to fix this for sysfs (et al.). Stephen, do
> you agree? Or could the condition even be removed completely?

It looks like this was generalized to genfs in 134509d54e4e ("selinux:
enable per-file labeling for debugfs files.") but unfortunately there
doesn't appear to be any discussion of link handling in the patch.

I'm definitely not a debugfs expert, but based on my limited knowledge
and a rather liberal interpretation of the commit decription in the
patch mentioned above, it would appear that expanding the procfs link
handling to debugfs was intended.  This makes me wonder if the proper
solution is to create another sbsec->flag specifically for link
handling?

--=20
paul moore
www.paul-moore.com
