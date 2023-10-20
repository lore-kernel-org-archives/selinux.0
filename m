Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7CCCDB474
	for <selinux@archiver.kernel.org>; Fri, 20 Oct 2023 17:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjJTR3V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Oct 2023 13:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjJTR3V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Oct 2023 13:29:21 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8207613E
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 10:29:18 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2ea7cc821so754003b6e.1
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697822958; x=1698427758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eiKpRjoKVIY5FGPAPnIwGx0k6R3iWqobR1awAY3IQA=;
        b=gDSHXzVYD8s7VcpGJZ9wrVtjV8MRG4KXzZg4wHERAAasikyHqF1rir9Dvjfs4GyYiC
         Cr2ePNCCxRBfE4PL8nR2pdhMt0nW4ObEgqyoKYf8+c6dg6Y0Oy7xMbdsUPT0kD3Jcpwv
         hJoIgGvB2oqWbnPyVVpL6NKvDMuG5j++JuE9WrZ/vFuCgWvH2nmCFMYHIfSQ2q7Bmal6
         iKSTUtrUKn8W3ySt/eS7M6fb44WDTqFDypOt2FsmG9G8WLhVJTWsgRHzYqA8Uodx8mL2
         pZhi3xMZAqvU2STbZLrmE1F3PXyWpiC8YjAdtJU1SsSoPBwvbxOWik4iafXQ+DMP+HRF
         1SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822958; x=1698427758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eiKpRjoKVIY5FGPAPnIwGx0k6R3iWqobR1awAY3IQA=;
        b=Ca8rtlpbTQRbdHPZaKP11evEX4WPhTfjUqPDDOaVwjDlEXHDDM37cu4TMj6VxrmUuu
         JNdCwD5gjDcwKm2KazbOxtV8e0gsyzTpaT/TAAsTeZhMKm+E7kdpzeub51Nj+lE+SLNw
         wv3O7AZiEOhSx3ptvmScyeemVymnP0ZoW//mB6qF7CyZGtOWkz2zrwduSSnWv/Qf88zs
         GyUt1qjbRzt7ldHbh7SIf/yGTJGTV4YLiLtXR32WRNttVyM07iQqopRRCNc1sTKOVk2X
         /T7Cnh3djGvIESBaDAOcy4EjFyMFwMek0+cy1URK0/8jytFd1n7Lm7h3SUncTBMLZd8O
         5KkQ==
X-Gm-Message-State: AOJu0Ywx+lDTbyv/gf4QJ/jbO7CeDs0j3laTUVOtQUMew4VeSLejt8mu
        4HBzZv0M2VASQIBzrITWXCZgHKaz06GIgaZAaNoMkJd/MSM+zxs=
X-Google-Smtp-Source: AGHT+IGTF5Njt2zgYO1LKL4VfBtERvtUGCVE9rN8RjRNbAFOfe2HZAtZP4U/OWerfpKF9/im9WL0MbDgwdjJL06lh5k=
X-Received: by 2002:a54:441a:0:b0:3ad:ff3e:d25c with SMTP id
 k26-20020a54441a000000b003adff3ed25cmr2726268oiw.53.1697822957774; Fri, 20
 Oct 2023 10:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRw9hfx8rBRj4R1e-EELAW2eB8GtkpTzbjqoKGF0Zu20g@mail.gmail.com>
 <051cde5d-c6ef-4b44-ba0f-ebad382fa656@schaufler-ca.com>
In-Reply-To: <051cde5d-c6ef-4b44-ba0f-ebad382fa656@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Oct 2023 13:29:06 -0400
Message-ID: <CAHC9VhQDQ8nkoTfVEYY-7Kmykq84MkwuRssNDqvGor6c445Xdg@mail.gmail.com>
Subject: Re: RFC: thoughts on SELinux namespacing
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 20, 2023 at 12:16=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 10/11/2023 3:54 PM, Paul Moore wrote:
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
> >
> > I'll leave this as an exercise for the reader, but this approach
> > should also support arbitrary nesting.
>
> An SELinux label is currently made up of several components. You
> could add a new "subdomain" component. The subdomain component would
> be ignored unless the process is in a namespace, in which case it
> would be treated as an additional restriction.

I think the compatibility challenges with adding another field to a
SELinux label at this point in time, e.g.
namespace:user:role:type:mls, would make an already challenging task
almost impossible.  I'm also not sure how one would handle nested
namespaces with this approach, add additional namespace fields to the
label?

--=20
paul-moore.com
