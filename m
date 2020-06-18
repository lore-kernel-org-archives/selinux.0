Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51E6C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 14:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC3820739
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 14:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHO6wpiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgFROLv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbgFROLs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jun 2020 10:11:48 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51006C0613EF
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2020 07:11:48 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i8so3570396lfo.4
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2020 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5Y6VzjE46+NhDt4mg2S5o4yQ1/eLUcB29QBrcYK8BY=;
        b=ZHO6wpiR6gUAr5OGQL9Lcu20ukX5A8y/2szri0NCuxCituzyRMXuO27B9wEQfv/wQ5
         7y3MVf0+4hgPlF8bXFksP8xwoZ/vdomiLdQCze5oKFf1FVpZjnqtLbAF90IwWaEjJXG/
         EpRVw459oeG5ruYEteC2Hn9T3jUj4kAClnKwWVevZ84vGeUPcRYvg9I1AHJdTqokRt4m
         f6FsQmiMzanQ1mLDBRXYEX7MDQp15PeiDU3j7ZC7gsS6F8uYpQRyaYITm+DkUwUXCiUi
         V4DqGZdQUqb/MK6hJwnEqnj9NkzUXPW7bCYIBL1CBG2GkbeibvP2ImUPFA3HzMyvlCcC
         US4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5Y6VzjE46+NhDt4mg2S5o4yQ1/eLUcB29QBrcYK8BY=;
        b=XaZad87ux7kWJrGIc8ElsJbL1u911n2+ntkZ/SeZSFkzOnu+T6yQHiUtRTPYKbntjV
         uZxvhdCMpbsuOEaz2ilg4jGd1GHekD+y5S+QVWAGSIc2IGiWIgQmns6yNvjnqxpULMNi
         RM293XSymbEXUf707OHrhDhRUFuN4Q3cQA305kKRQeUmC3PjVr6zfWXaIiq8IyDZmjDC
         L5D/BsuTURUxKF/5P21oOe2Y+xKoak9CDt8S8yaDBd8GleJ0C0Jjsw9FcTSYLOjlK0nW
         nIPRE1nwgdHiO2oA/dHxWM+WYYn3kJqsX0d0t/JVkA8NENiQFPZNSMsxe6p+frlWDn6g
         /Byg==
X-Gm-Message-State: AOAM532gi0n6TikBaJTMwOvng161ArjPEJOIW3nsJ5rpgMdc9a09O86r
        N5eBqFmceLjYz0FclOWoIc1EC9nG6nnRU8ZnxJ5o3Q==
X-Google-Smtp-Source: ABdhPJy7kZ8D6qE5luLc9Fgfu8aDqrqhxjP3QuwJ2YEmh29DYhfXstHRsj34nRVydo3qZV0fE4Ml//GGY0Ob3NcQ6KU=
X-Received: by 2002:a19:be4b:: with SMTP id o72mr1872950lff.141.1592489506308;
 Thu, 18 Jun 2020 07:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200618134825.487467-1-areber@redhat.com> <20200618134825.487467-4-areber@redhat.com>
In-Reply-To: <20200618134825.487467-4-areber@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 18 Jun 2020 16:11:19 +0200
Message-ID: <CAG48ez1ocnFNSPdVDaVtB2-S+B4uBeLTLaekCYq=m1DuMyA-CA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] prctl: Allow ptrace capable processes to change exe_fd
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 18, 2020 at 3:50 PM Adrian Reber <areber@redhat.com> wrote:
> The current process is authorized to change its /proc/self/exe link via
> two policies:
> 1) The current user can do checkpoint/restore In other words is
>    CAP_SYS_ADMIN or CAP_CHECKPOINT_RESTORE capable.
> 2) The current user can use ptrace.
>
> With access to ptrace facilities, a process can do the following: fork a
> child, execve() the target executable, and have the child use ptrace()
> to replace the memory content of the current process. This technique
> makes it possible to masquerade an arbitrary program as any executable,
> even setuid ones.
>
> This commit also changes the permission error code from -EINVAL to
> -EPERM for consistency with the rest of the prctl() syscall when
> checking capabilities.
[...]
> diff --git a/kernel/sys.c b/kernel/sys.c
[...]
> @@ -2007,12 +2007,23 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>
>         if (prctl_map.exe_fd != (u32)-1) {
>                 /*
> -                * Make sure the caller has the rights to
> -                * change /proc/pid/exe link: only local sys admin should
> -                * be allowed to.
> +                * The current process is authorized to change its
> +                * /proc/self/exe link via two policies:
> +                * 1) The current user can do checkpoint/restore
> +                *    In other words is CAP_SYS_ADMIN or
> +                *    CAP_CHECKPOINT_RESTORE capable.
> +                * 2) The current user can use ptrace.
> +                *
> +                * With access to ptrace facilities, a process can do the
> +                * following: fork a child, execve() the target executable,
> +                * and have the child use ptrace() to replace the memory
> +                * content of the current process. This technique makes it
> +                * possible to masquerade an arbitrary program as the target
> +                * executable, even if it is setuid.

(That is not necessarily true in the presence of LSMs like SELinux:
You'd have to be able to FILE__EXECUTE_NO_TRANS the target executable
according to the system's security policy.)
