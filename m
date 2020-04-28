Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B264EC83000
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E6A2208FE
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 19:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6VNJnUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgD1Tea (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:34:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58235 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728474AbgD1Tea (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 15:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588102467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOnZAhxAkpoNwD21WQUMwXvU26NM+1emYC0Lrf1Z48c=;
        b=R6VNJnUWC5Ol3hxgxlqKOqnstLy3x55zuKi6mXK4PzcS1sLMQfBlM4DeygpCh10l+Gsprt
        Ma5YfX0tc3cRD94oBFli+AoE0qMN3Ya+kqja9NcI4FuENaaTowSM6QNtY3YRCjhogAvJg9
        fWRR9/g01z3HyDehlj6+4qk73nnaaxU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-8KolMd51MJ-RghgzG-_vYw-1; Tue, 28 Apr 2020 15:34:23 -0400
X-MC-Unique: 8KolMd51MJ-RghgzG-_vYw-1
Received: by mail-oo1-f69.google.com with SMTP id s185so21222820oos.11
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 12:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOnZAhxAkpoNwD21WQUMwXvU26NM+1emYC0Lrf1Z48c=;
        b=szaoJXh79le9FvyZ0PA7KEGXO4HTdgq8cWs/S0Ms9JALhIdWpun8EYpx5ijc/EaUDT
         N4YqxZ29p9bud0EsBh3f0DCG5PAFRMPRGPsbdxW8E/PTuSSmT17byLI/PT3dAqdlKWA0
         jQDbKBNkBh0lWPtFzVYSway4XhtzNo+jzd/ikfNvJfam7WMGWqle18qZxUvub/h4+f8R
         5BXoRUzhFaaNkOoCRCm9+A5nCA42cYKjeVnLfbBa4m8cSLh77CNQBM6DXqA+wfGDAj9J
         YFLlHpf93XbUhSf7Vfv5V4i0FzS+Z5sw5FE66ymQ3tS7T6IVX44gaQB8Mxz09f24O/QL
         xwng==
X-Gm-Message-State: AGi0PuYJ4GszhtF2GMmbtKZ736NGfdEEXEXKzVCWvGv5h6tJGrhW2iCJ
        V9OeMwxSjU34rt1ko0a2Yj4CeSbQeBkaX24uEI1ZlEBl5VWhq7kKq3L4lFliOs0AMGXgZeKD1x0
        CKhffQJZHMMsMRvxRYB+eJMxtCYEK0oRdaw==
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr23803386otq.66.1588102462207;
        Tue, 28 Apr 2020 12:34:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypLeEHuvLIkwOqdDGd5myY/Oe+LUXKiGKQXGvfN5sXBfqkZ0nepfdfFKfYU3go3rErTCSnkbpUyau4G5hzhb43Q=
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr23803355otq.66.1588102461838;
 Tue, 28 Apr 2020 12:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <d3abd210-928e-374f-1e9b-fddfaa203c53@linux.microsoft.com> <CAEjxPJ5Gx+g5U4-iXyMjyGxrvSsGa32jvpjY3_PYS_cbToQTKA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Gx+g5U4-iXyMjyGxrvSsGa32jvpjY3_PYS_cbToQTKA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 28 Apr 2020 21:34:10 +0200
Message-ID: <CAFqZXNs=UKNaS=xAW-R1v7o9KKR61vRjmv+90V29cG-xzn-bFw@mail.gmail.com>
Subject: Re: Race condition during policy load in kernel
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Daniel Burgener <dburgener@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>,
        selinux list <selinux@vger.kernel.org>,
        james.morris@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 28, 2020 at 8:54 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Apr 27, 2020 at 4:40 PM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
> >
> > Hello all,
> >
> > We've noticed a few instances of strange failures in userspace object
> > managers happening immediately after a policy load, that we believe
> > we've traced to a race condition in the kernel, and wanted to get your
> > thoughts on our diagnosis and the appropriate fix before creating a
> > patch in case we've missed something.
> >
> > The issue is that userspace object managers rely on /sys/fs/selinux to
> > determine the mapping of object class and permission strings to numeric
> > identifiers, however immediately after a policy load,
> > /sys/fs/selinux/{booleans,class,policy_capabilities}, are deleted and
> > recreated.  This leaves a window where the object classes (etc) appear
> > to be not defined, even if they are defined in both the old and new
> > policies.
> >
> > We have observed this with both dbus and systemd userspace object
> > managers, and it can be reproduced straightforwardly by running the
> > following (borrowed from bug linked below):
> >
> > # (while true; do cat /sys/fs/selinux/class/service/index >/dev/null;
> > done) &
> > # while true; do sudo load_policy; echo -n .; sleep 0.1;done
> >
> > Periodically, we will get "No such file or directory" messages printed
> > to stderr.  In the event of a userspace object manager using libselinux
> > to check a userspace permission, that will result in a USER_AVC message
> > indicating an unknown object class, and in the event that
> > --handle-unknown is set to "deny", it will deny the access.
> >
> > It seems to me as though some sort of locking should occur in the
> > selinuxfs to prevent access to the files being deleted and recreated
> > during the policy load, so that userspace programs relying on them (in
> > particular userspace object managers doing class lookups) get a
> > consistent view of the classes, perms, booleans and capabilities in the
> > loaded policy.
> >
> > This seems to be related to
> > https://github.com/SELinuxProject/selinux-kernel/issues/42 but I believe
> > it is a different case.  The deadlock in that bug seems to be related to
> > the underlying filesystem functions, specifically around directory
> > deletion while this is an issue the selinuxfs logic specifically. The
> > above linked issue appears to have been fixed in recent upstream
> > kernels, per the bug, but I have verified the issue I am discussing here
> > in 5.7.0 rc3.
> >
> > It seems to me as though from the perspective of userspace that all of
> > sel_make_policy_nodes (or at least all of each of its component
> > functions) should be atomic.  There was some discussion in a previous
> > thread
> > (https://lore.kernel.org/selinux/20181002155810.GP32577@ZenIV.linux.org.uk/)
> > around a significant refactor of policy loading in general.  It appears
> > as though the direct issue there of access during the deletion has been
> > resolved (commit d4f4de5e5ef8efde85febb6876cd3c8ab1631999), although the
> > complete suggested fix of refactoring policy_load into two parts has not
> > been done.  Would that refactor be the right approach to the problem I
> > am trying to solve?  Would a patch for adding locking around the
> > selinuxfs delete/recreate operation be considered? That wouldn't address
> > all the concerns, (namely the potential to access a view of the policy
> > that doesn't match the currently loaded policy and error recovery in the
> > case that sel_make_nodes fails), but would improve the reliability of
> > existing userspace object managers
> >
> > I'm happy to create and submit a patch, but I wanted to get the
> > communities thought on the problem and correct approach first.
>
> I think the best approach is the one sketched by viro but I recognize
> that's a big lift.
> Willing to help but not entirely clear on the interactions with the
> dcache for atomically swapping
> the new trees into place.
>
> I suspect this is just being exposed now due to more recent changes in
> userspace to try to fully support
> changes in class/permission values at runtime.  Previously userspace
> object managers tended to only
> map them during initialization or on first use and then would just
> keep using the cached values, whereas
> now they try to map them lazily and flush their caches on a reload
> notification.  Some of those changes
> were in libselinux and others in the userspace object managers (e.g.
> systemd, dbus-broker or dbusd).
> Not sure exactly what versions of libselinux, systemd, and
> dbusd/dbus-broker you are using.
>
> selinuxfs itself does take a mutex around the entire policy load
> including the delete/re-create sequence but
> that only serializes with other policy operations (load, read,
> booleans), not with dcache walk/lookup.
>
> cc'ing Ondrej since he attempted to fix the earlier selinuxfs bug and
> may have an opinion on the best way
> forward for this issue.

Well, I attempted a few times and each time failed miserably :)
Thankfully, hitting the bug via another fs eventually forced viro to
fix it (in a way I could probably never come up with myself). However,
I remember trying to originally fix the bug by means of making the
swapover atomic, but later I realized that these two are actually
independent issues. After that I didn't get back to atomizing the
swapover, but IIRC I had the impression that it might not be all that
difficult... (at least if I ignore possible failures during the new
dentry tree creation for now - it would still be unsafe, but it would
be a start). But knowing VFS, I bet when I actually try it will prove
to be much more tricky ;)

I'll try to find some time to sit down to it again, but at the moment
I'm juggling a bunch of higher priority stuff so it might be a while
before I get to it.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

