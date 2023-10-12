Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38328CDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347486AbjJLRiS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441849AbjJLRiD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:38:03 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98BB10DE
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:35:49 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7c93507d5so14412507b3.2
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697132149; x=1697736949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9VTBwrXNgrAUTQuC+oIxgAdTkwaWEpHcW0LBZnWAnQ=;
        b=gbNOsicgSVodyUct4aaW2lhC3zdgLNTvqm7Y2e0MS8UHlKnBcuAkg+LOUFaw1ITDgg
         z/h+Ai5GKzlTlwSOYw+koQDMKMBkusa7wta/4TdIl3nOj6x8j30e1itN51HrD50SN4hf
         V+i6nX5WbxhbrW9YQJF/Bb9ETAx4cMt7btFBs5tSq6iigBE+ecQZyvXABc7QqU2CG0iF
         R+69tCSyJ+zw2L0MVe9a516r7I1L4U5PqjNBvQ5XxlxcpQmduIVYslPT9ZEvDDSbeBi5
         nND4qzGC8ObTuaU8mrAmxYsx06ehymE4VLULB44Ln1Ii7H3tHYPOUDVnCSFNtkGxwqDM
         IJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697132149; x=1697736949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9VTBwrXNgrAUTQuC+oIxgAdTkwaWEpHcW0LBZnWAnQ=;
        b=HMpHtdnWKDxPCj460O4T/y7ymeZpnzKN5O7Ft0WF1XRTMc6N21bI8nkDNYtlkWR5Jq
         TIIF1hdVIn+C5DiXIuKGc3zI+ryO6O86oxIRcRjH99M5VEfjP4bZqKxTXN3J84e7vJSr
         F7N1bwi1Ff2xArQBYKkZZXHLPVB32g1CmafyRR4GIA/tJWJhBWKWnAeG4WG3P8b6otan
         lMpr+o4LRx7szjXA/eVrkWd7R1CLy+E31Va4/pROk7s1rZHBBhyw0dEdJLN0XXPkgv9D
         alROAuw47V1BfTLCsPDEOCfniZZpulc1WGDV1y1XHh2S/mSIAjWYXtZqYRGfn3ZQAdoz
         8EzQ==
X-Gm-Message-State: AOJu0YzvDj13FwhooV6AzSjR1k4J8Hbms2GNr0pQUrCKQLzpb4qVYTz2
        3rPZkxM5nwcqUJ4K9j2dwyRgzGM8f8Bl0DDOSEM9tPsLxLD93II=
X-Google-Smtp-Source: AGHT+IGbMbZyeQjWFYNGgvBkWbLmqz+32iAGAajuIyrM2cZGKn3xlhk5fvlKUZtVubg1OF1YmdT5MwadeHXKyrtGfPI=
X-Received: by 2002:a25:d40c:0:b0:d9a:c13c:3363 with SMTP id
 m12-20020a25d40c000000b00d9ac13c3363mr3058471ybf.52.1697132148903; Thu, 12
 Oct 2023 10:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRw9hfx8rBRj4R1e-EELAW2eB8GtkpTzbjqoKGF0Zu20g@mail.gmail.com>
 <CAP+JOzQiEt=SF_gvr9WwCSUM73TjYw8O5sGPZ+nLeY0TU+cUBQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQiEt=SF_gvr9WwCSUM73TjYw8O5sGPZ+nLeY0TU+cUBQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Oct 2023 13:35:37 -0400
Message-ID: <CAHC9VhSMSfGAB=p57CS4KsvOi+7pDVZ64inU5M7TV7=a_QBOqw@mail.gmail.com>
Subject: Re: RFC: thoughts on SELinux namespacing
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 12, 2023 at 11:44=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
> On Wed, Oct 11, 2023 at 6:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
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
> I like this idea.

Thanks.  We've had such a tough history with namespacing that I'm a
little concerned it doesn't cover all of the corner cases, but
everytime I think of something new the idea still holds up.  I'm very
interested both to hear what everyone thinks and also to see if
someone can find any flaws in the concept.

> > The one exception to this would be existing mounted filesystems that
> > are shared between parent and child namespaces: shared filesytems
> > would be labeled according to the namespace which mounted the
> > filesystem originally (the parent, grandparent, etc.), and those file
> > labels would be shared across all namespace boundaries.  If a
> > particular namespace does not have the necessary labels defined in its
> > policy for a shared filesystem, those undefined labels will be
> > represented just as bogus labels are represented today
> > ("unlabeled_t").  For this to work well there must be shared
> > understanding/types between the parent and child namespace SELinux
> > policies, but if the namespaces are already sharing a filesystem this
> > seems like a reasonable requirement.
>
> I like this idea in general.
>
> If a child namespace is sharing a filesystem, can it change labels? It
> seems like allowing that could cause problems. At the very least, it
> seems like we would want the option to be able to restrict the child
> from changing labels.

I agree.  The permissions granted to the child namespace, including
the ability to relabel, would still be under control by policy in the
parent; if you don't want to grant the ability to relabel things don't
grant that permission in the parent.

> This might be over-engineering things, but in general it seems like we
> want to specify which namespace owns the labels on a filesystem and
> whether parent or child namespaces see one label for the whole
> filesystem or all the labels (and whether or not they can change
> them).

I agree on this point too, that is one of the reasons I think we need
the mount options below.  If you don't use the mount options all of
the namespaces share a common view of the filesystem labels, with each
namespace defining their own policy towards those labels while still
being bounded by the permissions of their parent's namespace.  If you
do use the mount options you can delegate who "owns" the native
filesystem labeling with the parent seeing only a single label similar
to a context mount.

Or am I missing something in your reply?

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
> > another namespace,
>
> This seems different from what you described above. Above it seems to
> say that if a parent mounted a filesystem and shared it with a child,
> the child would see the labels. But here it looks like the parent can
> mount a filesystem while specifying that it is the child that controls
> the labels and the parent sees just one label. I think this is the
> right approach.

Both are possible, it depends on if the proposed mount options are
used or not.  If you don't use the mount options you get a shared
view, if you do use the mount options you get a split view with
different labels in the parent and child.

> > and establish a single label, similar to a context
> > mount, that the mounting namespace would see instead of whatever
> > labeling the filesystem would normally support.  The "selinuxns_owner"
> > option would specify the domain label of the child namespace, granting
> > that domain control over whatever labeling is supported by the
> > filesystem.
>
> This implies the immediate child. Thinking theoretically (I don't know
> why you would do this) if you were planning on having four nested
> SELinux namespaces, but wanted the very bottom child to control a
> particular filesystem, its immediate parent would have to set it up.
> That seems reasonable to me.

I think so too.  It's also worth mentioning that in addition to the
immediate parent performing the mount, all of the prior parents
(grandparents, great-grandparents, etc.) would need to have policy
which allows mounting.

> > In most normal use cases where the child namespace runs
> > with a single domain/type from the parent's perspective I would expect
> > "selinuxns_outer" and "selinuxns_owner" to be set to the same value,
> > although that is not a requirement.
> >
> > Triggering the creation of a child SELinux namespace, the userspace
> > API in general, and the implementation work needed to support multiple
> > views of the same kernel entities is all still very TBD/hand-wavy.  I
> > wanted to make sure the approach described here made sense first.
> >
> > THOUGHTS ON POLICY
> >
> > This is an area where I think the single-label parent view makes it
> > much easier to develop policy for containing child namespaces.  Since
> > we want the parent namespace to effectively bound the access of the
> > child namespace, treating the namespace as a single domain allows the
> > parent to develop policy independent of what the child's types and
> > behaviors; the parent simply describes the allowed interactions and
> > let's the child manage it's own policy and labeling.
> >
> > Filesystems shared across policy boundaries are somewhat interesting
> > in that for it to be fully usable it requires every participating
> > namespace to have the filesystem labels defined in their own policy,
>
> Unless there is a way to share a filesystem, but with a single label.

In that case I would mount the filesystem using a context mount.

> > but it does not require each namespace to treat the files in the same
> > manner.  However, it is important to note that regardless of what a
> > child namespace might allow in a shared filesystem, it is still
> > subject to the policy rules of any parent namespaces.
>
> I think that this approach has merit. The devil is in the details of
> course. I am curious to hear what others think.

Thanks, me too :)

--=20
paul-moore.com
