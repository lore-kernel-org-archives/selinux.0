Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6ECC83007
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 18:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465B3218AC
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 18:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0yJuH8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbgD1Syc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731467AbgD1Syb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 14:54:31 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E6CC03C1AB
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 11:54:30 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id i9so4936811ool.5
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHavDp1NNLq6ml7gGjtQ92G+lz5Bo7+5IRTll4f/n2A=;
        b=M0yJuH8lKyH7OWH7BpxD4kuODRQKwnzyBoNMIMNPeRY153W5iABuWKG3EsmJBwSaRv
         R64AQJa4SmInLOCXwOxTOc/zmF8CcsKm9YU9CooSUD8WQ5OIh5l5WG4ci7fzJCDLUTBK
         omUMJlnvH08csEaqbN3vF9ShNkea1pnXjp7OkOW0YwiMT8TQ5d2WxM7wXQUdPTfF3kO6
         hsc29EadIZ55hP2tScFnfCUTneqOsKTmIbccTvSK1n1A5U5Y2vtYvKcLMSTwQIbfWBxe
         yrCIVtuOPw8PApRFafp4C3W7qRzKTElS3a2SQRhk3CijoDpy7JvZFyUsMw2rxmQ0IURn
         1uDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHavDp1NNLq6ml7gGjtQ92G+lz5Bo7+5IRTll4f/n2A=;
        b=Vp6pdIyY196IYc4r76lkN4obzVkzmsoLop496+Bb5RePLHj0M9Lp77FBZ8yx0kXZLF
         T5xzxu6sZIyFbjA1R/VXQRlseCJJC9GqfVbNfzwQexJyeHqKe/4NRLJ09Ox8xzNZigdm
         +ZfmhGpkr/zyZD5J6DPcRGlg1ol9vk5nNRYm9sqnF8br0fMziRcDL9pRhD6Z6d4hyC7j
         0OgdtF9kXzWfHjhOLtBE1pMzw/cMzj0FFJOrvmlmnNmzB/0Q+pY2ZwowZePCqDJz59ry
         UWA7aX/d38dlkhdvUvl8GMUmTRqZnsIF66vXNnwC2FxtuQv4cWhX4ydCBpQQKAldiYsT
         qiIA==
X-Gm-Message-State: AGi0PuZukF8tn0jvlX+eTW48QoV/oHDfdpRhXwYTGeLq4VcUkP0wddPm
        oyOI0BbSyJgYaS8Wht8S1bN6fD2sbebLgHF1IwA=
X-Google-Smtp-Source: APiQypL8D6FHhLXsY8q6JqwA0HW35KJ/UzsCW0aJl4QlkSpSY1Ew8ibgMbK57LNnS42smI+q1btPkmovm0/3yUKyCJE=
X-Received: by 2002:a4a:92d1:: with SMTP id j17mr1874750ooh.13.1588100070146;
 Tue, 28 Apr 2020 11:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <d3abd210-928e-374f-1e9b-fddfaa203c53@linux.microsoft.com>
In-Reply-To: <d3abd210-928e-374f-1e9b-fddfaa203c53@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 28 Apr 2020 14:54:19 -0400
Message-ID: <CAEjxPJ5Gx+g5U4-iXyMjyGxrvSsGa32jvpjY3_PYS_cbToQTKA@mail.gmail.com>
Subject: Re: Race condition during policy load in kernel
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux list <selinux@vger.kernel.org>, james.morris@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 27, 2020 at 4:40 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> Hello all,
>
> We've noticed a few instances of strange failures in userspace object
> managers happening immediately after a policy load, that we believe
> we've traced to a race condition in the kernel, and wanted to get your
> thoughts on our diagnosis and the appropriate fix before creating a
> patch in case we've missed something.
>
> The issue is that userspace object managers rely on /sys/fs/selinux to
> determine the mapping of object class and permission strings to numeric
> identifiers, however immediately after a policy load,
> /sys/fs/selinux/{booleans,class,policy_capabilities}, are deleted and
> recreated.  This leaves a window where the object classes (etc) appear
> to be not defined, even if they are defined in both the old and new
> policies.
>
> We have observed this with both dbus and systemd userspace object
> managers, and it can be reproduced straightforwardly by running the
> following (borrowed from bug linked below):
>
> # (while true; do cat /sys/fs/selinux/class/service/index >/dev/null;
> done) &
> # while true; do sudo load_policy; echo -n .; sleep 0.1;done
>
> Periodically, we will get "No such file or directory" messages printed
> to stderr.  In the event of a userspace object manager using libselinux
> to check a userspace permission, that will result in a USER_AVC message
> indicating an unknown object class, and in the event that
> --handle-unknown is set to "deny", it will deny the access.
>
> It seems to me as though some sort of locking should occur in the
> selinuxfs to prevent access to the files being deleted and recreated
> during the policy load, so that userspace programs relying on them (in
> particular userspace object managers doing class lookups) get a
> consistent view of the classes, perms, booleans and capabilities in the
> loaded policy.
>
> This seems to be related to
> https://github.com/SELinuxProject/selinux-kernel/issues/42 but I believe
> it is a different case.  The deadlock in that bug seems to be related to
> the underlying filesystem functions, specifically around directory
> deletion while this is an issue the selinuxfs logic specifically. The
> above linked issue appears to have been fixed in recent upstream
> kernels, per the bug, but I have verified the issue I am discussing here
> in 5.7.0 rc3.
>
> It seems to me as though from the perspective of userspace that all of
> sel_make_policy_nodes (or at least all of each of its component
> functions) should be atomic.  There was some discussion in a previous
> thread
> (https://lore.kernel.org/selinux/20181002155810.GP32577@ZenIV.linux.org.uk/)
> around a significant refactor of policy loading in general.  It appears
> as though the direct issue there of access during the deletion has been
> resolved (commit d4f4de5e5ef8efde85febb6876cd3c8ab1631999), although the
> complete suggested fix of refactoring policy_load into two parts has not
> been done.  Would that refactor be the right approach to the problem I
> am trying to solve?  Would a patch for adding locking around the
> selinuxfs delete/recreate operation be considered? That wouldn't address
> all the concerns, (namely the potential to access a view of the policy
> that doesn't match the currently loaded policy and error recovery in the
> case that sel_make_nodes fails), but would improve the reliability of
> existing userspace object managers
>
> I'm happy to create and submit a patch, but I wanted to get the
> communities thought on the problem and correct approach first.

I think the best approach is the one sketched by viro but I recognize
that's a big lift.
Willing to help but not entirely clear on the interactions with the
dcache for atomically swapping
the new trees into place.

I suspect this is just being exposed now due to more recent changes in
userspace to try to fully support
changes in class/permission values at runtime.  Previously userspace
object managers tended to only
map them during initialization or on first use and then would just
keep using the cached values, whereas
now they try to map them lazily and flush their caches on a reload
notification.  Some of those changes
were in libselinux and others in the userspace object managers (e.g.
systemd, dbus-broker or dbusd).
Not sure exactly what versions of libselinux, systemd, and
dbusd/dbus-broker you are using.

selinuxfs itself does take a mutex around the entire policy load
including the delete/re-create sequence but
that only serializes with other policy operations (load, read,
booleans), not with dcache walk/lookup.

cc'ing Ondrej since he attempted to fix the earlier selinuxfs bug and
may have an opinion on the best way
forward for this issue.
