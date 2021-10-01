Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C47DC433EF
	for <selinux@archiver.kernel.org>; Fri,  1 Oct 2021 22:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367B361ABF
	for <selinux@archiver.kernel.org>; Fri,  1 Oct 2021 22:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJAXAS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Oct 2021 19:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhJAXAR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Oct 2021 19:00:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621AAC0613E2
        for <selinux@vger.kernel.org>; Fri,  1 Oct 2021 15:58:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e15so44321821lfr.10
        for <selinux@vger.kernel.org>; Fri, 01 Oct 2021 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQM3XM8xdLXddRKZW1XX+RPtGmZTJVt7CAVEe+7hVj0=;
        b=HrPYP0UEVwuiTywHkbK3uNSlC5jNJRCt7l8EaoQMi0GpVMSFINwhrAt0s6xN2VsWnd
         Myc5mNipqTNZcxOhUQEgTc+wNrFHHij90mG+lt2XElY+2NHha97StErPB8G12+Q/FdL7
         kv/yBjF0tdcFFbh62Zzs85vTUFMkD27saQD001r+EBb1yzThD0/29HuX9TwewcOvoPID
         6NmUoW0KSr6AgRtw5foBD1kqg7x7DEk0pD9byZrdGV8vM4cRAhBOa6eltRHMuoC79vmd
         2qSPM4v3FgGl7AoaJFBY9KUW1L0pWlhtgS3WiXRLGRjfXTBWphGxNH6YWjpddXQ9JqG2
         uaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQM3XM8xdLXddRKZW1XX+RPtGmZTJVt7CAVEe+7hVj0=;
        b=NM6cuI+E35mIbjUc3PsgaTuFaX4LeNc2YWYceqArPPinPeW/svwN4rj7u0Vxtsdlc0
         nTkm9ZdJMgBud3O0dVSHKQywgdr1I4wUp8qg7PLBKGCq5RNYjIg6/IaW6IL0i/fsaksh
         2GDajRkbxp8comLwjofFG4wAxEJTZDiGnKm179LaH6N7ZDvgk1Y+VG3HoyGUo+s48TTA
         hUrRgDgchGk5hn1A7dX4xwPrC+wLitvBycDXqx+7gpo4s/CuX4LiYK9invbkXHFahfgK
         ENiZeXtEVdmJQj0QGtyPIvawveaDu4q3FjkIsox0ovKiE1m9SqE2+RVr5yESuC3hYY1W
         d0lQ==
X-Gm-Message-State: AOAM533jFmnHj7DftJuJGhfEE7xeHFI+683j5XNdpSbM9pdN8AMeQGh2
        b/NjBJhkE/FzTd2C+Uatj3B47zeJBTJw8KRhrCbXow==
X-Google-Smtp-Source: ABdhPJxDRqKz8OAWDsnkLn4xH3d0hvk5cFN9OA2tx3QD1FlVd+hZKPEVe8R6GTnDW2zwiLwPxa2Ij4nuoD+ZhZ0oE9A=
X-Received: by 2002:a05:6512:20cb:: with SMTP id u11mr633226lfr.237.1633129110528;
 Fri, 01 Oct 2021 15:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211001175521.3853257-1-tkjos@google.com> <c6a650e4-15e4-2943-f759-0e9577784c7a@schaufler-ca.com>
 <CAG48ez2tejBUXJGf0R9qpEiauL9-ABgkds6mZTQD7sZKLMdAAQ@mail.gmail.com>
 <CAG48ez1SRau1Tnge5HVqxCFsNCizmnQLErqnC=eSeERv8jg-zQ@mail.gmail.com> <f59c6e9f-2892-32da-62f8-8bbeec18ee4c@schaufler-ca.com>
In-Reply-To: <f59c6e9f-2892-32da-62f8-8bbeec18ee4c@schaufler-ca.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 2 Oct 2021 00:58:04 +0200
Message-ID: <CAG48ez0yF0u=QBLVL2XrGB8r8ouQj-_aS9SScu4O4f+LhZxCDw@mail.gmail.com>
Subject: Re: [PATCH v2] binder: use cred instead of task for selinux checks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Todd Kjos <tkjos@google.com>, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, keescook@chromium.org, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 1, 2021 at 10:10 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/1/2021 12:50 PM, Jann Horn wrote:
> > On Fri, Oct 1, 2021 at 9:36 PM Jann Horn <jannh@google.com> wrote:
> >> On Fri, Oct 1, 2021 at 8:46 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>> On 10/1/2021 10:55 AM, Todd Kjos wrote:
> >>>> Save the struct cred associated with a binder process
> >>>> at initial open to avoid potential race conditions
> >>>> when converting to a security ID.
> >>>>
> >>>> Since binder was integrated with selinux, it has passed
> >>>> 'struct task_struct' associated with the binder_proc
> >>>> to represent the source and target of transactions.
> >>>> The conversion of task to SID was then done in the hook
> >>>> implementations. It turns out that there are race conditions
> >>>> which can result in an incorrect security context being used.
> >>> In the LSM stacking patch set I've been posting for a while
> >>> (on version 29 now) I use information from the task structure
> >>> to ensure that the security information passed via the binder
> >>> interface is agreeable to both sides. Passing the cred will
> >>> make it impossible to do this check. The task information
> >>> required is not appropriate to have in the cred.
> >> Why not? Why can't you put the security identity of the task into the creds?
> > Ah, I get it now, you're concerned about different processes wanting
> > to see security contexts formatted differently (e.g. printing the
> > SELinux label vs printing the AppArmor label), right?
>
> That is correct.
>
> > But still, I don't think you can pull that information from the
> > receiving task. Maybe the easiest solution would be to also store that
> > in the creds? Or you'd have to manually grab that information when
> > /dev/binder is opened.
>
> I'm storing the information in the task security blob because that's
> the appropriate scope. Today the LSM hook is given both task_struct's.

Which is wrong, because you have no idea who the semantic "recipient
task" is - any task that has a mapping of the binder fd can
effectively receive transactions from it.

(And the current "sender task" is also wrong, because binder looks at
the task that opened the binder device, not the task currently
performing the action.)

> It's easy to compare to make sure the tasks are compatible.

It would be, if you actually had a pair of tasks that accurately
represent the sender and the recipient.

> Adding the
> information to the cred would be yet another case where the scope of
> security information is wrong.

Can you elaborate on why you think that?
