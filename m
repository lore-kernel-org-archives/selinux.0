Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D41DCDB47E
	for <selinux@archiver.kernel.org>; Fri, 13 Oct 2023 19:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJMTkY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Oct 2023 15:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJMTkX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Oct 2023 15:40:23 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC50891
        for <selinux@vger.kernel.org>; Fri, 13 Oct 2023 12:40:20 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7be88e9ccso30590867b3.2
        for <selinux@vger.kernel.org>; Fri, 13 Oct 2023 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697226020; x=1697830820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT0doD88+VRedodiRFqzaN5EsOKrx/BsyQMjdVAkSkY=;
        b=SSn3tYR55bSM4AoDf5oa1grejKPf59TFMj2rue4QQuf9KEQUyzA7GookwFSrp4LeDO
         iPbFdbFQNlnK8SWyDjvmz5C+ZCOHvQnQ3x02YYC2LRv1niFIS1ujtdtB65YfY3RNAxOZ
         v6hGHrBwNguylvuJSgnXDwBP8NsLwCep+034W7hwjIeheiZrPz6Auh/LS0erLK/eT5rp
         e6JZA3ZgeJ9mIOF9CZ3ccE/AznOC01FqrFgoX7uaaotAniHf/oeqEHTxI25OBdTOkv49
         2Xycxp11Ye5l9DLOjGVudyDVGby7cP69B2p3gVlu91J5mYkrPEt2GwsadwBMYDVLiJTs
         lLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697226020; x=1697830820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT0doD88+VRedodiRFqzaN5EsOKrx/BsyQMjdVAkSkY=;
        b=u6F2loiwhDDw9Ue5Lg0gGO6NPg8vxBVImy9jc1qYRJVlcp0zbUj5KIKBTponcuHNEv
         zJgAHMX6lJ1xvH44Ik/iub3YTjr2xUW4hqphbusycoA+8/D/uMvoLqPbrBTDWWyzVGIP
         2BxtpRxX4s9y/HESINl/LTaEje7ljBHeI6uydFoLeExsKYvzENtqNPAELRm4HgBhTgQp
         cwlW5QejqJRQCRiI1Q1TXjcQg6ViufgxDRQKHgfJK4nLLWlusvM1XvmhAKoV8Gk2/GdV
         IapgzN4PamlonGXxqsdAWoBU7jR31cSVdz3mGsvxvoiIzztHl9vor6oiygsLa7Z5DViZ
         ytlw==
X-Gm-Message-State: AOJu0Yyu1b/6OhFAUxwuFfLPuSShe8pJ2M17z/pcQUEVuwQ90ioJdcKE
        04ln9A0afNQBwdwyNFp0FghbzFh7D/MGVRXPHZ5k1lmNzVxZjvI=
X-Google-Smtp-Source: AGHT+IEWxkNaG0wAkLDYYpnjA2TxHYRT4hSgiNWGy0SZqgeSS28B9OFEhSvdjUleanDbrYEXsMEiYvC5LySakkROLOo=
X-Received: by 2002:a25:2f81:0:b0:d9a:3f9b:cf93 with SMTP id
 v123-20020a252f81000000b00d9a3f9bcf93mr13179338ybv.43.1697226019976; Fri, 13
 Oct 2023 12:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRw9hfx8rBRj4R1e-EELAW2eB8GtkpTzbjqoKGF0Zu20g@mail.gmail.com>
 <CAEjxPJ691iV2_z3YxCGDqyu-kTU_6D7AEjksfmGmRzvVcJh9gg@mail.gmail.com>
In-Reply-To: <CAEjxPJ691iV2_z3YxCGDqyu-kTU_6D7AEjksfmGmRzvVcJh9gg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 13 Oct 2023 15:40:09 -0400
Message-ID: <CAHC9VhRNF8vo3s_jSkVUHmgWWSgAE6QChmJoQbhdfH+uNRpFVA@mail.gmail.com>
Subject: Re: RFC: thoughts on SELinux namespacing
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 13, 2023 at 12:16=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Oct 11, 2023 at 6:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Hello all,
> >
> > The SELinux namespace effort has been stuck for several years as we
> > try to solve the problem of managing individual file labels across
> > multiple namespaces. Our only solution thus far, adding namespace
> > specific xattrs to each file, is relatively simple but doesn't scale,
> > and has the potential to become a management problem as a namespace
> > specific identifier needs to be encoded in the xattr name.  Having
> > continued to think about this problem, I believe I have an idea which
> > might allow us to move past this problem and start making progress on
> > SELinux namespaces.  I'd like to get everyone's thoughts on the
> > proposal below ...
> >
> > THE IDEA
> >
> > With the understanding that we only have one persistent label
> > per-file, we need to get a little creative with how we represent a
> > single entity's label in both the parent and child namespaces.  Since
> > our existing approach towards SELinux policy for containers and VMs
> > (sVirt) is to treat the container/VM as a single security domain,
> > let's continue this philosophy to a SELinux namespace: a child
> > namespace will appear as a single SELinux domain/type in the parent
> > namespace, with newly created processes and objects all appearing to
> > have the same type from the parent's point of view.  From the child
> > namespace's perspective, everything will behave as they would
> > normally: processes would run in multiple domains as determined by the
> > namespace's policy, with files labeled according to the labeling rules
> > defined in the namespace's policy (e.g. xattrs, context mounts, etc.).
>
> I don't have any problems with the idea. However, where I got stuck
> with the original selinux namespace patches was not per-namespace
> filesystem security xattrs (which was James' contribution) ...

Thanks for taking a look and reviewing the idea.

The multiple xattr approach is okay-ish if you need *something* to get
past the labeling hurdle so you can work on other aspects of the
implementation, but it is not a viable solution upstream.  The scaling
and management difficulties make it a non-starter in my opinion.

> ... but rather
> the need to support per-namespace in-core inode and superblock
> security blobs.

I didn't get into any implementation details because I was still
wrestling with the design issue of how do we deal with only a single
on-disk label.  In my mind that needed to be solved before we could
spend time thinking about how to implement it in a reasonable manner.

Regardless, you bring up a good point: there are still a number of
implementation challenges with namespacing SELinux.  There is the
issue of supporting multiple labels on kernel entities such as
superblock, inodes, tasks, etc., but I have a hunch that the more
challenging issue is going to be the various LSM/SELinux external
"things" that deal with a single secid/secctx.  We will have to see
how things develop with the LSM stacking effort, but that might end up
helping us in that area, we'll have to see how that goes.

> You'd have to go back to my original posted patch
> series or the older selinuxns branches of my github repo to see my
> attempt at supporting those because they were dropped from the
> working-selinuxns branch due to the ongoing reworking of LSM to handle
> blob allocation by the security framework rather than by the
> individual security modules. I couldn't figure out how to make that
> work safely and efficiently, and AFAICT that still has to be addressed
> for the above idea to work.

Agreed, supporting multiple different views of an entity and mapping
that a namespace in a quick and efficient manner is probably going to
be one of the larger technical challenges.  I won't pretend to have a
answer for this yet, but I do believe we can figure something out.

> > THOUGHTS ON MAKING IT WORK
> >
> > One of the bigger challenges here is how to handle the case of the
> > parent mounting a filesystem for full use by the child namespace
> > (per-file labeling, etc.).  Above I talked about how filesystems would
> > be labeled according to the mounting namespace, so if we want to
> > delegate labeling of the filesystem to a child namespace (without
> > allowing the child to perform the mount) we need to have a mechanism
> > to indicate that the mounting namespace is deferring labeling to a
> > different namespace.  I think the obvious solution to that would be to
> > add two new mount options: "selinuxns_outer=3D<label>" and
> > "selinuxns_owner=3D<label>".  The "selinuxns_outer" option would
> > accomplish two things: mark the filesystem for deferred labeling by
> > another namespace, and establish a single label, similar to a context
> > mount, that the mounting namespace would see instead of whatever
> > labeling the filesystem would normally support.  The "selinuxns_owner"
> > option would specify the domain label of the child namespace, granting
> > that domain control over whatever labeling is supported by the
> > filesystem.  In most normal use cases where the child namespace runs
> > with a single domain/type from the parent's perspective I would expect
> > "selinuxns_outer" and "selinuxns_owner" to be set to the same value,
> > although that is not a requirement.
>
> So with my earlier patch set (the one in my older selinuxns branch),
> one could already do the equivalent of selinuxns_outer just using the
> existing context=3D mount option. This is because it allowed for
> per-namespace superblock security blobs, so you could context mount in
> the parent namespace while still selecting per-file labeling in the
> child. That said, it had the issues I referenced above wrt safety and
> efficiency.

I'm open to other ideas on how to make this work, but I do think it is
important to separate a context mounted filesystem that is shared
across multiple namespaces from a "selinuxns_outer" (or whatever we
want to use) mounted filesystem that appears like a context mount to
the mounting namespace while supporting native labeling for a child
namespace.  If there is a clever way to do that with existing mount
options that's even better.

> For selinuxns_owner, I'm not clear on where/how that would
> be used.

My idea behind the "selinuxns_owner" owner was to provide an easy way
to identify which domains in the mounting/parent namespace would have
the ability to enable native filesystem labeling in their own child
namespace.  It seemed like a reasonable way to simplify the SELinux
namespace API by not needing to specify all of the mounted filesystems
that the child namespace would have labeling control over when the
child namespace was initiated.

> Note that the context you assign to files will quite often
> differ from the context assigned to the processes; hence, if
> selinuxns_owner is meant to be the context of a process, it usually
> won't be the same as selinux_outer.

That came up in some offline discussions too.  When I was kicking
things around in my mind it was easier to reason about things,
especially nested namespaces, if the child namespace was represented
by a single type in the parent namespace.  Unfortunately that
simplification ended up leaking out into my email.  If it makes things
easier to read/understand, I would recommend simply removing that
sentence from my email, it shouldn't affect the design either way.

--=20
paul-moore.com
