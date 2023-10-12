Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88511C41513
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 15:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379487AbjJLPoh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379491AbjJLPof (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 11:44:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B332C6
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 08:44:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50305abe5f0so1570720e87.2
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697125471; x=1697730271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDBIpNkc9B2jkI01C/vWsUHuIM+u/pS6iEpruDTJSgk=;
        b=acqisB2TJjCcWFcNPoXmKRuS74mulN54DupUeBJu8NlShYCPGc72Rdy50nPlug5zjv
         cW0cwSi6S0p15YXUvNYzGJ2GpmnYG/Ywbp+7rycN1sZn7GGehbUCQ8pvXIgjXkJL1AzM
         wa10Kg+XcbnAK9wJRnLFfvZeMtC7bWLUxseFHaTSCXzXKC+UecaS4SPujpm+ZvoZf1Nn
         NNKUSN1NsmIShUx9BxX7cCJL3tGaBA4hOAzjXJIjeZCb9n5zjiMu4ZNWXTHR1Nkgrqac
         v2yypQBhoAPzacNlnLH4CkkIGSJbHMLr8YD2lwF0m3TwrJ9K5rx3jTcs4FUXwlC41LhJ
         WZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697125471; x=1697730271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDBIpNkc9B2jkI01C/vWsUHuIM+u/pS6iEpruDTJSgk=;
        b=FUiQ3TxXvweaS9qI8p3VkqaoxfvZSLzwWuz0QwRTjOHKL3MUm+5pDVY33j0tVKlohU
         W+/gkZcIyowqfByBCR83T4O1hakEBgsS6mpEwbd+hDJXiAgNQiQDzhhrSprLeYmZbj3a
         M/0J5/HP6eV7s7CPz0u9fZR9EtmjfZRgR0cByxv5tZKqoNiMpA/rBSS3VG7aIF09PaT0
         xe26VgpdqJ+K/Xe+OOYRESNHAiSD2A+T8nOandR9PkTIBADPHb5MTorY5lcZ7qKgn0YI
         U/nmqt7QnfswBFO1tgrH1FFOotuVQOubpM7TMS3I4qIuAx3ABiW7uuS8Rc+WstdylWhM
         L3pg==
X-Gm-Message-State: AOJu0Yxo6kBPAN2ac8nROmdfljANOgQXSJEDVxQIHYXWHUVS+SOnvSkO
        XRXq4S+6ewDSUd5h4jfYeGwMtpfr6pbUx7OAUTXZ2NSr
X-Google-Smtp-Source: AGHT+IFFBB/zqgnEi70FDQqgl68ixfl6cejUocsFJX7KH3sLZoIM5Rhv1PeyYcJo4jiJftmGPl60BttGtWXYuehoNmU=
X-Received: by 2002:ac2:5930:0:b0:507:9618:dc1f with SMTP id
 v16-20020ac25930000000b005079618dc1fmr952640lfi.69.1697125471036; Thu, 12 Oct
 2023 08:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRw9hfx8rBRj4R1e-EELAW2eB8GtkpTzbjqoKGF0Zu20g@mail.gmail.com>
In-Reply-To: <CAHC9VhRw9hfx8rBRj4R1e-EELAW2eB8GtkpTzbjqoKGF0Zu20g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 11:44:19 -0400
Message-ID: <CAP+JOzQiEt=SF_gvr9WwCSUM73TjYw8O5sGPZ+nLeY0TU+cUBQ@mail.gmail.com>
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

I like this idea.

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
>

I like this idea in general.

If a child namespace is sharing a filesystem, can it change labels? It
seems like allowing that could cause problems. At the very least, it
seems like we would want the option to be able to restrict the child
from changing labels.

This might be over-engineering things, but in general it seems like we
want to specify which namespace owns the labels on a filesystem and
whether parent or child namespaces see one label for the whole
filesystem or all the labels (and whether or not they can change
them).

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
> another namespace,

This seems different from what you described above. Above it seems to
say that if a parent mounted a filesystem and shared it with a child,
the child would see the labels. But here it looks like the parent can
mount a filesystem while specifying that it is the child that controls
the labels and the parent sees just one label. I think this is the
right approach.

> and establish a single label, similar to a context
> mount, that the mounting namespace would see instead of whatever
> labeling the filesystem would normally support.  The "selinuxns_owner"
> option would specify the domain label of the child namespace, granting
> that domain control over whatever labeling is supported by the
> filesystem.

This implies the immediate child. Thinking theoretically (I don't know
why you would do this) if you were planning on having four nested
SELinux namespaces, but wanted the very bottom child to control a
particular filesystem, its immediate parent would have to set it up.
That seems reasonable to me.

> In most normal use cases where the child namespace runs
> with a single domain/type from the parent's perspective I would expect
> "selinuxns_outer" and "selinuxns_owner" to be set to the same value,
> although that is not a requirement.
>
> Triggering the creation of a child SELinux namespace, the userspace
> API in general, and the implementation work needed to support multiple
> views of the same kernel entities is all still very TBD/hand-wavy.  I
> wanted to make sure the approach described here made sense first.
>
> THOUGHTS ON POLICY
>
> This is an area where I think the single-label parent view makes it
> much easier to develop policy for containing child namespaces.  Since
> we want the parent namespace to effectively bound the access of the
> child namespace, treating the namespace as a single domain allows the
> parent to develop policy independent of what the child's types and
> behaviors; the parent simply describes the allowed interactions and
> let's the child manage it's own policy and labeling.
>
> Filesystems shared across policy boundaries are somewhat interesting
> in that for it to be fully usable it requires every participating
> namespace to have the filesystem labels defined in their own policy,

Unless there is a way to share a filesystem, but with a single label.

> but it does not require each namespace to treat the files in the same
> manner.  However, it is important to note that regardless of what a
> child namespace might allow in a shared filesystem, it is still
> subject to the policy rules of any parent namespaces.

I think that this approach has merit. The devil is in the details of
course. I am curious to hear what others think.

Thanks,
Jim


>
> --
> paul-moore.com
