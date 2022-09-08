Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CE3C38145
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 18:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiIHSxb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 14:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiIHSxV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 14:53:21 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D96E103033
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 11:53:09 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1278624b7c4so28620255fac.5
        for <selinux@vger.kernel.org>; Thu, 08 Sep 2022 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=UGWr8neW2kZVvnYmU4foAjz85tjsLBPCReYEfGouu3o=;
        b=Zfv+f/tcECQO+in83mDqvC9nt1YoHnY0higsjVcA0ETwcM2064UVteVhVebC0O/ynC
         H3x3uVjbW1YaOM1yMxxB1/01wi1+sVxpOaZVu1IPS5HuR9u9oKhfnDdraZ8Av5kFf7IG
         HxyV9QUpSUBqZv+xbiZFPXQGNVpPkZAqypiwfIC/qJZWeMJqsCForwDwvMq2p6NZQtyd
         y+Ezn19Xw0mGBoOLQLS1m/rr6wrW3jq1PmNL5eZQcw3fov3xgPofLPUu+mL20azCOyfb
         cACwbPAu2Ob43WEQNzzbitP82ByBBiAw6f8WdLgrq5rd80R53dsJBrnAP8FPHJth1ga6
         EIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UGWr8neW2kZVvnYmU4foAjz85tjsLBPCReYEfGouu3o=;
        b=LSbn5nb30cb4AL/Ud2Kt3QJbVGotVinU1WcJ9mTOnrM4IAYW6uG8/4Cxw42z3297F4
         7NPNAD+W/UZLT5zyQptQ19BJ92rtYZSJjjXS8rjWsOSGRB+jz+5aW1JRIKHNrps/J+EU
         J7QCbKHCgj7OgvOBtF81/Z06fgwJGQouU60wakRPRPoJC1KznmjuPOlqhHDxjcnogDZr
         oXKXCZTJovYQbknR56EiybaEkJE1rqEhUcgAbdNTp6PeEXrqOAY6DUhLnrR7/3dP8t3P
         VduP3sbxwNp4Zz6cCHkBByF9iTGhOL7+2/AZBpXzyHISGwWsOuERi58N/dwFuxXDjoVR
         F4MQ==
X-Gm-Message-State: ACgBeo3pGCKQD40Zpuhf6dY9kZfgpbE6t+c7QGkuEDSXyksZGsYqnds0
        gfYqDrF2X4AxNETR6fEfSnjEXyCeNDQ3G8itGIPS
X-Google-Smtp-Source: AA6agR5JkrTnbm7jIqCq8klhdUoP5ILTdl0E8T8trQmm7e7YtT+UULusyktIYzKRB4qUzLGXLiTnkVg+uShHcpjjyvs=
X-Received: by 2002:a05:6870:5808:b0:128:afd5:491f with SMTP id
 r8-20020a056870580800b00128afd5491fmr2846197oap.136.1662663188353; Thu, 08
 Sep 2022 11:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <8ac2731c-a1db-df7b-3690-dac2b371e431@I-love.SAKURA.ne.jp>
In-Reply-To: <8ac2731c-a1db-df7b-3690-dac2b371e431@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Sep 2022 14:52:57 -0400
Message-ID: <CAHC9VhQGnEcoYeGpwbbXbMrG1dOvJ=2ohd4zPYoqBJK9p1mSjQ@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 8, 2022 at 11:19 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2022/08/03 9:01, Casey Schaufler wrote:
> > I would like very much to get v38 or v39 of the LSM stacking for Apparm=
or
> > patch set in the LSM next branch for 6.1. The audit changes have polish=
ed
> > up nicely and I believe that all comments on the integrity code have be=
en
> > addressed. The interface_lsm mechanism has been beaten to a frothy peak=
.
> > There are serious binder changes, but I think they address issues beyon=
d
> > the needs of stacking. Changes outside these areas are pretty well limi=
ted
> > to LSM interface improvements.

> Many modules
>
>     SimpleFlow =EF=BC=88 2016/04/21 https://lwn.net/Articles/684825/ =EF=
=BC=89
>     HardChroot =EF=BC=88 2016/07/29 https://lwn.net/Articles/695984/ =EF=
=BC=89
>     Checmate =EF=BC=88 2016/08/04 https://lwn.net/Articles/696344/ =EF=BC=
=89
>     LandLock =EF=BC=88 2016/08/25 https://lwn.net/Articles/698226/ =EF=BC=
=89
>     PTAGS =EF=BC=88 2016/09/29 https://lwn.net/Articles/702639/ =EF=BC=89
>     CaitSith =EF=BC=88 2016/10/21 https://lwn.net/Articles/704262/ =EF=BC=
=89
>     SafeName =EF=BC=88 2016/05/03 https://lwn.net/Articles/686021/ =EF=BC=
=89
>     WhiteEgret =EF=BC=88 2017/05/30 https://lwn.net/Articles/724192/ =EF=
=BC=89
>     shebang =EF=BC=88 2017/06/09 https://lwn.net/Articles/725285/ =EF=BC=
=89
>     S.A.R.A. =EF=BC=88 2017/06/13 https://lwn.net/Articles/725230/ =EF=BC=
=89
>
> are proposed 5 or 6 years ago, but mostly became silent...

At least one of those, Landlock, has been merged upstream and is now
available in modern released Linux Kernels.  As far as the other LSMs
are concerned, I don't recall there ever being significant interest
among other developers or users to warrant their inclusion upstream.
If the authors believe that has changed, or is simply not true, they
are always welcome to post their patches again for discussion, review,
and potential upstreaming.  However, I will caution that it is
becoming increasingly difficult for people to find time to review
potential new LSMs so it may a while to attract sufficient comments
and feedback.

> I still need byte-code analysis for finding the hook and code for making =
the hook
> writable in AKARI/CaitSith due to lack of EXPORT_SYMBOL_GPL(security_add_=
hooks).
> I wonder when I can stop questions like https://osdn.net/projects/tomoyo/=
lists/archive/users-en/2022-September/000740.html
> caused by https://patchwork.kernel.org/project/linux-security-module/patc=
h/alpine.LRH.2.20.1702131631490.8914@namei.org/ .

As has been discussed before, this isn't so much an issue with the
__ro_after_init change, it's really more of an issue of running
out-of-tree kernel code on pre-built distribution kernels, with
"pre-built" being the most important part.  It is my understanding
that if the user/developer built their own patched kernel this would
not likely be an issue as the out-of-tree LSM could be patched into
the kernel source.  The problem comes when the user/developer wants to
dynamically load their out-of-tree LSM into a pre-built distribution
kernel, presumably to preserve a level of distribution support.
Unfortunately, to the best of my knowledge, none of the major
enterprise Linux distributions will provide support for arbitrary
third-party kernel modules (it may work, but if something fails the
user is on their own to triage and resolve).

Beyond the support issue, there are likely to be other problems as
well since the kernel interfaces, including the LSM hooks themselves,
are not guaranteed to be stable across kernel releases.

> Last 10 years, my involvement with Linux kernel is "fixing bugs" rather t=
han
> "developing security mechanisms". Changes what I found in the past 10 yea=
rs are:
>
>   As far as I'm aware, more than 99% of systems still disable SELinux.

I would challenge you to support that claim with data.  Granted, we
are coming from very different LSM backgrounds, but I find that number
very suspect.  It has been several years since I last looked, but I
believe the latest published Android numbers would give some support
to the idea that more than 1% of SELinux based systems are running in
enforcing (or permissive) mode.  Significantly more.

>   People use RHEL,
>   but the reason to choose RHEL is not because RHEL supports SELinux.

Once again, if you are going to make strong claims such as this,
please provide data.  I know of several RHEL users that are only able
to run SELinux based systems as it is the only LSM which meets their
security requirements.

>   Instead, Ubuntu users are increasing, but the reason people choose Ubun=
tu is not because
>   Ubuntu supports AppArmor. Maybe because easy to use container environme=
nt. Maybe because
>   available as Windows Subsystem for Linux.

I suspect IBM/RH's decision to change CentOS' relationship to RHEL
also resulted in a number of users moving to Ubuntu, and that has
nothing to do with the LSMs.

>   However, in many cases, it seems that whether the OS is Windows or Linu=
x no longer
>   matters. Programs are written using frameworks/languages which develope=
rs hardly care
>   about Windows API or Linux syscall. LSM significantly focuses on syscal=
ls, but the
>   trend might no longer be trying to solve in the LSM layer...

Every LSM is different, that is partly why it is so interesting as a
security framework.  Look at Yama, look at AppArmor, look at Smack,
look at the BPF LSM ... there is no one security model, and claiming
that the LSM focuses on syscalls is misleading.  If you had to pick
only one concept that the LSM focuses on, I believe it would be
providing visibility and access controls for security relevant
interactions between entities on the system.  Processes opening files,
processes executing other processes, processes talking to each other
both across the network and on the local system.  Some of these things
involve syscalls, but as most of us know, making meaningful access
control decisions often involves much more than just the syscall.

> Also, Linux servers started using AntiVirus software. Enterprise AntiViru=
s software uses
> loadable kernel module that rewrites system call table rather than using =
LSM interface.
> It seems that people prefer out-of-the-box security over fine grained acc=
ess control rule
> based security.

I would caution against confusing the security policy driven access
controls provided by many in-tree LSMs with out-of-tree antivirus
software.  They have different goals, different use cases, and
different user groups (markets).

I think that is about the nicest thing I can think to say about those
antivirus products ;)

--
paul-moore.com
