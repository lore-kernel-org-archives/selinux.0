Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BF4C8300A
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C5E21974
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 12:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGmnd6SM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgD2Mcz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727777AbgD2Mcp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 08:32:45 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A8C03C1AE
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 05:32:45 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m18so1482151otq.9
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrclYa/Ch2l+XaUUv+QNjvfHXfdOIlLZ0UJQoPX/B+s=;
        b=oGmnd6SMMbQzrg6/15EMYouECtXbd+vrUSoHioCljtWgiCvstGEIp1DY0AHlUqxNUD
         4DytFLOfBCEvLJA8Qm5WfH7G+TfHO+pletVsBUv9SJgjgSnRhjbBgoGa69vwH7VMqUNG
         1B3dOylDXmad7M+MWnzbh9uEfsnAXOIGDIPybzPlCB+HlIbB6+DJWJngkaNwBxfCXmNK
         WuN1rVtdZYThDn9e9vtsQUABsyPkn05CgzY1ggBH7G7QPoli6xSf0fTWflY6kKeC7hQF
         33OCwZpxkUHdQyeqKDiiGtyZc7qNAuKnG0VjVPh3pQRwASzVCqG8VOWWOlEP05er1s9W
         3d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrclYa/Ch2l+XaUUv+QNjvfHXfdOIlLZ0UJQoPX/B+s=;
        b=C36ojVfUCfXXKtMJTOaDPeOPXhgJ7Hqp8PLdfUzy81P7p8HnR1cDwadWXQmTomkTnh
         4Q5ljcqNIm+q/bH17TCSYJNN9Rpb32JPkqcAIooxlRivvX8An+IQJoKIHl35BMAgRLff
         uphPtg6lxg8lDXsQl4q5GU3QtVRslluM+9yzMiEVOyxdbU8MWPFiF4sW3qvB5abBaTcR
         3wpt6GnCqNshj0KhsEqMzbUZk1sqmMo5iDOSffxpI+4yRvxUoBoULrcpQLl3/NyVtcdD
         dgxA5j0poIpN5WTCmHGwFyoaMntUvjEBsTVtsFBa/4ymzVsO45qNO2inLP3oQN37DlNv
         QqbQ==
X-Gm-Message-State: AGi0Pua8Cumu/nhnMja0dEnoEw+7WdGoCDwUao3J4Py/umtC6AFPiVdy
        EYak0776VsM3lS2oaEHHwtY/zxFKf1RtDHKrZrE=
X-Google-Smtp-Source: APiQypI2cFsv5tYRoHjxA2IJ2fOxIwljf/Y5Mi3bN07+dlL7TMA7PdZDQFnaj9XLejJROYi7gDpkFZyjKbCFmkAjIOg=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr26828057otb.135.1588163564570;
 Wed, 29 Apr 2020 05:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <d3abd210-928e-374f-1e9b-fddfaa203c53@linux.microsoft.com>
 <CAEjxPJ5Gx+g5U4-iXyMjyGxrvSsGa32jvpjY3_PYS_cbToQTKA@mail.gmail.com>
 <CAFqZXNs=UKNaS=xAW-R1v7o9KKR61vRjmv+90V29cG-xzn-bFw@mail.gmail.com> <fcb45f43-5814-8d7d-8f66-d770d092f826@linux.microsoft.com>
In-Reply-To: <fcb45f43-5814-8d7d-8f66-d770d092f826@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 29 Apr 2020 08:32:33 -0400
Message-ID: <CAEjxPJ61Bec8Hj8TzH-h_tvaWdGAHoR6ZMye2EazYQUViLfCwg@mail.gmail.com>
Subject: Re: Race condition during policy load in kernel
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        selinux list <selinux@vger.kernel.org>,
        james.morris@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 28, 2020 at 4:38 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 4/28/20 3:34 PM, Ondrej Mosnacek wrote:
> > On Tue, Apr 28, 2020 at 8:54 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> On Mon, Apr 27, 2020 at 4:40 PM Daniel Burgener
> >> <dburgener@linux.microsoft.com> wrote:
> >>> Hello all,
> >>>
> >>> We've noticed a few instances of strange failures in userspace object
> >>> managers happening immediately after a policy load, that we believe
> >>> we've traced to a race condition in the kernel, and wanted to get your
> >>> thoughts on our diagnosis and the appropriate fix before creating a
> >>> patch in case we've missed something.
> >>>
> >>> The issue is that userspace object managers rely on /sys/fs/selinux to
> >>> determine the mapping of object class and permission strings to numeric
> >>> identifiers, however immediately after a policy load,
> >>> /sys/fs/selinux/{booleans,class,policy_capabilities}, are deleted and
> >>> recreated.  This leaves a window where the object classes (etc) appear
> >>> to be not defined, even if they are defined in both the old and new
> >>> policies.
> >>>
> >>> We have observed this with both dbus and systemd userspace object
> >>> managers, and it can be reproduced straightforwardly by running the
> >>> following (borrowed from bug linked below):
> >>>
> >>> # (while true; do cat /sys/fs/selinux/class/service/index >/dev/null;
> >>> done) &
> >>> # while true; do sudo load_policy; echo -n .; sleep 0.1;done
> >>>
> >>> Periodically, we will get "No such file or directory" messages printed
> >>> to stderr.  In the event of a userspace object manager using libselinux
> >>> to check a userspace permission, that will result in a USER_AVC message
> >>> indicating an unknown object class, and in the event that
> >>> --handle-unknown is set to "deny", it will deny the access.
> >>>
> >>> It seems to me as though some sort of locking should occur in the
> >>> selinuxfs to prevent access to the files being deleted and recreated
> >>> during the policy load, so that userspace programs relying on them (in
> >>> particular userspace object managers doing class lookups) get a
> >>> consistent view of the classes, perms, booleans and capabilities in the
> >>> loaded policy.
> >>>
> >>> This seems to be related to
> >>> https://github.com/SELinuxProject/selinux-kernel/issues/42 but I believe
> >>> it is a different case.  The deadlock in that bug seems to be related to
> >>> the underlying filesystem functions, specifically around directory
> >>> deletion while this is an issue the selinuxfs logic specifically. The
> >>> above linked issue appears to have been fixed in recent upstream
> >>> kernels, per the bug, but I have verified the issue I am discussing here
> >>> in 5.7.0 rc3.
> >>>
> >>> It seems to me as though from the perspective of userspace that all of
> >>> sel_make_policy_nodes (or at least all of each of its component
> >>> functions) should be atomic.  There was some discussion in a previous
> >>> thread
> >>> (https://lore.kernel.org/selinux/20181002155810.GP32577@ZenIV.linux.org.uk/)
> >>> around a significant refactor of policy loading in general.  It appears
> >>> as though the direct issue there of access during the deletion has been
> >>> resolved (commit d4f4de5e5ef8efde85febb6876cd3c8ab1631999), although the
> >>> complete suggested fix of refactoring policy_load into two parts has not
> >>> been done.  Would that refactor be the right approach to the problem I
> >>> am trying to solve?  Would a patch for adding locking around the
> >>> selinuxfs delete/recreate operation be considered? That wouldn't address
> >>> all the concerns, (namely the potential to access a view of the policy
> >>> that doesn't match the currently loaded policy and error recovery in the
> >>> case that sel_make_nodes fails), but would improve the reliability of
> >>> existing userspace object managers
> >>>
> >>> I'm happy to create and submit a patch, but I wanted to get the
> >>> communities thought on the problem and correct approach first.
> >> I think the best approach is the one sketched by viro but I recognize
> >> that's a big lift.
> >> Willing to help but not entirely clear on the interactions with the
> >> dcache for atomically swapping
> >> the new trees into place.
> >>
> >> I suspect this is just being exposed now due to more recent changes in
> >> userspace to try to fully support
> >> changes in class/permission values at runtime.  Previously userspace
> >> object managers tended to only
> >> map them during initialization or on first use and then would just
> >> keep using the cached values, whereas
> >> now they try to map them lazily and flush their caches on a reload
> >> notification.  Some of those changes
> >> were in libselinux and others in the userspace object managers (e.g.
> >> systemd, dbus-broker or dbusd).
> >> Not sure exactly what versions of libselinux, systemd, and
> >> dbusd/dbus-broker you are using.
> >>
> >> selinuxfs itself does take a mutex around the entire policy load
> >> including the delete/re-create sequence but
> >> that only serializes with other policy operations (load, read,
> >> booleans), not with dcache walk/lookup.
> >>
> >> cc'ing Ondrej since he attempted to fix the earlier selinuxfs bug and
> >> may have an opinion on the best way
> >> forward for this issue.
> > Well, I attempted a few times and each time failed miserably :)
> > Thankfully, hitting the bug via another fs eventually forced viro to
> > fix it (in a way I could probably never come up with myself). However,
> > I remember trying to originally fix the bug by means of making the
> > swapover atomic, but later I realized that these two are actually
> > independent issues. After that I didn't get back to atomizing the
> > swapover, but IIRC I had the impression that it might not be all that
> > difficult... (at least if I ignore possible failures during the new
> > dentry tree creation for now - it would still be unsafe, but it would
> > be a start). But knowing VFS, I bet when I actually try it will prove
> > to be much more tricky ;)
> >
> > I'll try to find some time to sit down to it again, but at the moment
> > I'm juggling a bunch of higher priority stuff so it might be a while
> > before I get to it.
> >
> The weird thing about atomizing the swapover in isolation is that it's
> unclear what action to take on failure.  The existing code looks like it
> would leave a broken version of the selinuxfs laying around.  Completing
> the swapover even on failure would give us an atomic version of the
> current situation, but feels extra weird. If ignoring the failure case
> as Ondrej suggests would be acceptable in a patch, that sounds like the
> quickest way to addressing at least part of the problem (the refactor of
> security_load_policy by itself doesn't get us much by itself, since we
> can't roll back the selinuxfs after we've started in the current state.)

I don't entirely understand what you mean by the above, since viro's sketch
of a new policy load sequence does permit handling the error case in the middle
of the new selinuxfs directory/file creation by just throwing away the
new entries
altogether and leaving the old policydb/sidtab + old selinuxfs in
place.  That said
I'm not saying you have to do the whole thing at once.

> I'd be happy to start looking at either half, although I'd prefer to
> start with atomizing the tree swapover to solve my immediate problem if
> that would have a chance at getting merged by itself given the issues
> around the failure case.

Certainly willing to look at incremental improvements here.
