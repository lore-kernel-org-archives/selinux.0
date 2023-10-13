Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EC3CDB47E
	for <selinux@archiver.kernel.org>; Fri, 13 Oct 2023 16:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjJMQU2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Oct 2023 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjJMQUQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Oct 2023 12:20:16 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3140761B8
        for <selinux@vger.kernel.org>; Fri, 13 Oct 2023 09:16:03 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c665b2469dso1417097a34.0
        for <selinux@vger.kernel.org>; Fri, 13 Oct 2023 09:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697213762; x=1697818562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30Nu0IKyPrENSZfNRwzvVIizAtgNB0nJbRaimA98MzI=;
        b=hsLPtBjWjB3i4cXOwUMuyReBi4anz26wrPkzIJDIzGSNoMP6E/RIg3CyYuCpE7PIYS
         kNLgbvvhnjhx4sg0Ms6xYhLTTVcSvwDmC2tN7UTWFXxLXTYtHi+0iXUmMxjYA+bT3B1g
         BHjDEggH7U13rs4vUxY3vbZtLSZQpiqiyVy1wiijhFUIYZCgUHG9jxWj0+lvzI7neYRr
         /qjBoYzbI4q2bJixDu+s5CgjxxE1lSNA2FKNBNlWgUae02rwUwy2pTZBmRRpOgkQJSUw
         EDWIBluTdnrNfKwwku4vwf38CLcaSQ0mom+F13hgBLitK4Dp3jThubjmoPYFhoFxENnq
         IxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213762; x=1697818562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30Nu0IKyPrENSZfNRwzvVIizAtgNB0nJbRaimA98MzI=;
        b=TlivIGODOdstnGwfFHaRIiqZmhy0r/rePiwI4anPweYYDk0VGOpBbMlHaOiDzIyKsj
         j3XFJJujj6EU/YEg6+0ZIyfI1/cRpqU8B8v9gDYHzt/5FfBuS12JDmBIHoOldOE8orjs
         G6HkFFtMc1+5eqqWBADtTa2jE+lKUmNO04CQjmPU2J5Q+E87dyPSL6O/I5Fk2MpS0uz/
         Yrey0wXjtA3R9RXAtnYQgq3gV/aIhiIoV6/sbkVqDlzc3W0xtBHUOuYgc8SgmNN+TAQD
         fE1X3Q1aO0G6L1BvJk64DgJh3zzWn0k0ywxImAi3ohZicQ4z5Mbwl5JfLNCmUynRWfT9
         GG4Q==
X-Gm-Message-State: AOJu0YzT88Gptrs72ITXzkQFukGa5W3weiukclU4/V9tH74HptC7+Yno
        4SXNa3LuETbHk8nlSq7BVrp+pSaA9YLIjerXHPGafllXs68=
X-Google-Smtp-Source: AGHT+IFxlpTSHq06HGEji51OYSLyuOae9LWFZZpEOzuHubSDbZwmcHQGZ+zeUo2d+ylny8MRgrdtcCp3kKX2/TMeCw8=
X-Received: by 2002:a9d:7d83:0:b0:6c4:d2a8:b789 with SMTP id
 j3-20020a9d7d83000000b006c4d2a8b789mr28069718otn.35.1697213762245; Fri, 13
 Oct 2023 09:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRw9hfx8rBRj4R1e-EELAW2eB8GtkpTzbjqoKGF0Zu20g@mail.gmail.com>
In-Reply-To: <CAHC9VhRw9hfx8rBRj4R1e-EELAW2eB8GtkpTzbjqoKGF0Zu20g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 13 Oct 2023 12:15:51 -0400
Message-ID: <CAEjxPJ691iV2_z3YxCGDqyu-kTU_6D7AEjksfmGmRzvVcJh9gg@mail.gmail.com>
Subject: Re: RFC: thoughts on SELinux namespacing
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 11, 2023 at 6:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Hello all,
>
> The SELinux namespace effort has been stuck for several years as we
> try to solve the problem of managing individual file labels across
> multiple namespaces. Our only solution thus far, adding namespace
> specific xattrs to each file, is relatively simple but doesn't scale,
> and has the potential to become a management problem as a namespace
> specific identifier needs to be encoded in the xattr name.  Having
> continued to think about this problem, I believe I have an idea which
> might allow us to move past this problem and start making progress on
> SELinux namespaces.  I'd like to get everyone's thoughts on the
> proposal below ...
>
> THE IDEA
>
> With the understanding that we only have one persistent label
> per-file, we need to get a little creative with how we represent a
> single entity's label in both the parent and child namespaces.  Since
> our existing approach towards SELinux policy for containers and VMs
> (sVirt) is to treat the container/VM as a single security domain,
> let's continue this philosophy to a SELinux namespace: a child
> namespace will appear as a single SELinux domain/type in the parent
> namespace, with newly created processes and objects all appearing to
> have the same type from the parent's point of view.  From the child
> namespace's perspective, everything will behave as they would
> normally: processes would run in multiple domains as determined by the
> namespace's policy, with files labeled according to the labeling rules
> defined in the namespace's policy (e.g. xattrs, context mounts, etc.).

I don't have any problems with the idea. However, where I got stuck
with the original selinux namespace patches was not per-namespace
filesystem security xattrs (which was James' contribution) but rather
the need to support per-namespace in-core inode and superblock
security blobs. You'd have to go back to my original posted patch
series or the older selinuxns branches of my github repo to see my
attempt at supporting those because they were dropped from the
working-selinuxns branch due to the ongoing reworking of LSM to handle
blob allocation by the security framework rather than by the
individual security modules. I couldn't figure out how to make that
work safely and efficiently, and AFAICT that still has to be addressed
for the above idea to work.

> The one exception to this would be existing mounted filesystems that
> are shared between parent and child namespaces: shared filesytems
> would be labeled according to the namespace which mounted the
> filesystem originally (the parent, grandparent, etc.), and those file
> labels would be shared across all namespace boundaries.  If a
> particular namespace does not have the necessary labels defined in its
> policy for a shared filesystem, those undefined labels will be
> represented just as bogus labels are represented today
> ("unlabeled_t").  For this to work well there must be shared
> understanding/types between the parent and child namespace SELinux
> policies, but if the namespaces are already sharing a filesystem this
> seems like a reasonable requirement.

Yes, this also seems sane to me and works well for e.g. sharing
read-only OS images across containers.

> I'll leave this as an exercise for the reader, but this approach
> should also support arbitrary nesting.
>
> THOUGHTS ON MAKING IT WORK
>
> One of the bigger challenges here is how to handle the case of the
> parent mounting a filesystem for full use by the child namespace
> (per-file labeling, etc.).  Above I talked about how filesystems would
> be labeled according to the mounting namespace, so if we want to
> delegate labeling of the filesystem to a child namespace (without
> allowing the child to perform the mount) we need to have a mechanism
> to indicate that the mounting namespace is deferring labeling to a
> different namespace.  I think the obvious solution to that would be to
> add two new mount options: "selinuxns_outer=3D<label>" and
> "selinuxns_owner=3D<label>".  The "selinuxns_outer" option would
> accomplish two things: mark the filesystem for deferred labeling by
> another namespace, and establish a single label, similar to a context
> mount, that the mounting namespace would see instead of whatever
> labeling the filesystem would normally support.  The "selinuxns_owner"
> option would specify the domain label of the child namespace, granting
> that domain control over whatever labeling is supported by the
> filesystem.  In most normal use cases where the child namespace runs
> with a single domain/type from the parent's perspective I would expect
> "selinuxns_outer" and "selinuxns_owner" to be set to the same value,
> although that is not a requirement.

So with my earlier patch set (the one in my older selinuxns branch),
one could already do the equivalent of selinuxns_outer just using the
existing context=3D mount option. This is because it allowed for
per-namespace superblock security blobs, so you could context mount in
the parent namespace while still selecting per-file labeling in the
child. That said, it had the issues I referenced above wrt safety and
efficiency. For selinuxns_owner, I'm not clear on where/how that would
be used. Note that the context you assign to files will quite often
differ from the context assigned to the processes; hence, if
selinuxns_owner is meant to be the context of a process, it usually
won't be the same as selinux_outer.

My old patches can be seen here:
https://github.com/stephensmalley/selinux-kernel/commit/efb2ddadfdd0e10e75b=
6aa5da2ed9841df6ef2f6
https://github.com/stephensmalley/selinux-kernel/commit/3378718ef7d4a837f32=
c63bdfcc0b70342cdd55d
