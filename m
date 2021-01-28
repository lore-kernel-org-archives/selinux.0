Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3947C433E6
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 14:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5AB64D9F
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 14:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhA1Oca (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Jan 2021 09:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhA1Oc3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Jan 2021 09:32:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C45C061573
        for <selinux@vger.kernel.org>; Thu, 28 Jan 2021 06:31:48 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id w1so8029638ejf.11
        for <selinux@vger.kernel.org>; Thu, 28 Jan 2021 06:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9n2cn566/8qrt88VjJ95yAK3WWFVv3Hu8qfr0IsyV3k=;
        b=gurBevB2e5u7ckNJTaQx7FytJPZyjDAjAHSglhKxKdjmyrBFEr+m79KXJTvoD9oWU4
         USBWuAUopJ+nJ/gqA+5/PZ292vGSJfJGNJo6x5EcfLaa+Mm5ZpCXpPhTZHRFoz1ux1Ff
         DPEdPEPT3vGqmRWzcfAi17ArJtzR/Y+9s96Q4CzhmGJlchV1JIyjEF7NNg7rx2sfC0RQ
         pMbFEBVSkUYFs2p0E03Q2ynHvSTObTqjfuCsw+zYeUr6Y16xOX3PV4fB3IxD8uHNKzlo
         qkDybmDx1JvKm9tbr4suk4AA6Es2wbKGuvg4iYZ4DVye/mbBoWuK3uaurYS+nWN6hsvH
         DC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9n2cn566/8qrt88VjJ95yAK3WWFVv3Hu8qfr0IsyV3k=;
        b=DRqobPrr7+3PhOKUQmKckUidzt0UQEgyrCrlu/YpoL5BxgduCw4i+KbgZgyE3eFdja
         W7L+kwFXMBbgc1oKln33QMaN/ymj+luol17e9FTOj7COs8JgSpVf0mdVhhuVdAsCmEsW
         Cb8xCknXb0X1r3HkR7S2v8jhCa3lEfwmGmDPzx1wram5pgpTeQSmQCVTk8zhw8mt8SAR
         EucDsYADeehqdi4FzFIvX3x/l7XiBRyG3zY8O829xsE3xlYrlvmaGqK5pc/Oq75m6AMf
         ytlGmYT49v/29F5Or8xoxwdNxiIc729dot1HEx5G00wvtlQ2OCqdgayYMbJx3kH4EvxA
         +yQA==
X-Gm-Message-State: AOAM533FIP0HUOedzSLeXL4TyG76IakdQ66smFJCrL+btLRpXBM0K0Qw
        +Qv5bB5CrjBAij6pNrWtYCuljMevoJRSfp+/ONk=
X-Google-Smtp-Source: ABdhPJwwH1KomIBRB5/V9uacEnUMFisXahEwCiHivnLpxd+k4GL9jcVBWbfhbm+kbgqK2K3wxn5ftgxybCORexd8cn4=
X-Received: by 2002:a17:906:4050:: with SMTP id y16mr5894951ejj.43.1611844307211;
 Thu, 28 Jan 2021 06:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20210106133449.193940-1-cgzones@googlemail.com>
 <CAJfZ7=kvVcix_qbTywWAF8v3HHrRx13qeAaW9GQrLHR83cDaow@mail.gmail.com> <87ft2o166n.fsf@redhat.com>
In-Reply-To: <87ft2o166n.fsf@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 28 Jan 2021 15:31:36 +0100
Message-ID: <CAJ2a_DcLzegmEqSO8jfAjPx-Axjt1jKh15Qvc0jjZb8U5SaVUg@mail.gmail.com>
Subject: Re: [PATCH] newrole: preserve environment variable XDG_RUNTIME_DIR
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Di., 26. Jan. 2021 um 08:57 Uhr schrieb Petr Lautrbach <plautrba@redhat.com>:
>
> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
> >
> > Hello,
> > I am quite uncomfortable with this approach of keeping only one more
> > variable: why is only XDG_RUNTIME_DIR added, and not also
> > XDG_DATA_DIRS, XDG_SESSION_ID, XDG_SESSION_PATH, etc.? For example
> > someone pointed out in
> > https://github.com/systemd/systemd/issues/18301#issuecomment-763933678
> > that DBUS_SESSION_BUS_ADDRESS could also need to be preserved, so
> > there seem to be a long list of items.
> >
> > Moreover I am wondering whether this would be fine to keep such
> > environment variables while newrole uses the information from another
> > user (i.e. when newrole is built with USE_AUDIT and
> > audit_getloginuid() != getuid() because the user changed their UID ;
> > in such a situation newrole resets $HOME and $SHELL to the HOME of
> > audit_getloginuid()).
> >
> > In my humble opinion, I also do not understand why TERM, DISPLAY and
> > XAUTHORITY are kept but not LANG, LC_ALL, and all other LC_...
> > variables. I understand that there exist dangerous environment
> > variables (LD_LIBRARY_PATH, LD_PRELOAD, ...), that resetting the
> > environment to a minimal one is nice, and that using "newrole
> > --preserve-environment" could seem dangerous. For information, sudo
> > has been maintaining a list of "bad" variables, of variables with
> > potential dangerous values and of variables preserved by default, in
> > https://github.com/sudo-project/sudo/blob/SUDO_1_9_5p1/plugins/sudoers/env.c#L134-L228.
> >
> > This being said, I have never really used newrole but to expose a bug
> > in "sudo -r" a few years ago
> > (https://bugzilla.sudo.ws/show_bug.cgi?id=611 "root user can change
> > its SELinux context without password"). Since then I have always used
> > sudo to change role, with the advantage that it can be configured to
> > keep some environment variables, so I am not really the best reviewer
> > for such a patch (and also I am a little bit confused about the
> > "isolation guarantees" that newrole implements, and I am not sure
> > whether keeping XDG_RUNTIME_DIR would not break such guarantees).
> >
> > TL;DR: can another maintainer more familiar with newrole review this
> > patch, please?
> >
> > Thanks,
> > Nicolas
>
> I think it does not make much sense to keep XDG_RUNTIME_DIR
>
> When you change a role, type or level, it's like changing a
> linux user and it should be completely new session.
>
> In Fedora, sysadm_t is not even allow to get status of
> staff_t units:
>
>     [staff@rawhide ~]$ echo $XDG_RUNTIME_DIR
>     /run/user/1001
>     [staff@rawhide ~]$ newrole -r sysadm_r
>     Password:
>     [staff@rawhide ~]$ export XDG_RUNTIME_DIR=/run/user/1001
>     [staff@rawhide ~]$ systemctl --user list-units
>     Failed to list units: Access denied
>
>     systemd[33326]: selinux: avc:  denied  { status } for auid=n/a uid=1001 gid=1001 cmdline="" scontext=staff_u:sysadm_r:sysadm_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023 tclass=system permissive=0
>     systemd[33326]: selinux: avc:  denied  { status } for auid=n/a uid=1001 gid=1001 cmdline="" scontext=staff_u:sysadm_r:sysadm_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023 tclass=system permissive=0
>
> There's also question why one would use newrole to control their a
> systemd user session when it's possible to control it directly.
>

Thanks for your comments.
Seems this uncommon use case is not worth the trouble at all, and one
can as fallback set environment variables via the user's shell
settings (~/.bashrc).
Please disregard this patch.
