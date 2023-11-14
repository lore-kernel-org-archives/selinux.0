Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD705C4167D
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 14:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjKNObY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 09:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNObX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 09:31:23 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2336FCA
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 06:31:20 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso4559986a12.0
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 06:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699972279; x=1700577079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMf0z5JF8mJBo76V0kEowqhqiYABtgT5AjIdLbPiN4M=;
        b=jKQepgtfZZjbnPPOfu9Y+PcyA6aNd8QABOvt6lmbfIxxvcNtxADms40GZqbpsyLxoi
         hXMGY0OykF1XCFNYufVCVkZtS1JZvUkY5O5UVilI8egGgpXURn2IPT7oDZgVtyamGtFJ
         RH4ox2cxTujLIZdKQtm9mPNHwLzsisgH05GE62ftUtQcsTnE5g/NcKQY2yIRqOHTEONE
         RFwfDDhJYHP1sjRTRP3TuArs3+vctFS+ZnH8EhuIQJo6M7IdxY85Q/Uhifs50RmrQ13J
         LIUhomCTCoTRjWEW+RR4V+X6BivY7q3P326SSgPbIZP8/z95rlC9L9ptI4Nieh7rdypU
         Gzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699972279; x=1700577079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMf0z5JF8mJBo76V0kEowqhqiYABtgT5AjIdLbPiN4M=;
        b=vS7vuqI7tiGlGdvCyDLfH73Kwn8Av1x6G/lGixlNATTthxehLgCn006S7cWtLWwW4e
         4LW1sy74gJDyaWJWaCM4vEmbxfRvjK0QeIk54JKmE5seETRfuTHQHOXAI+HbFZSF/TTU
         LzKyZuh1KkwKfzEnAwhX1IXZeJnLgWuv4L8kaAb+Ob5BK8duTr6ar0+GCv5tWPt9tdF0
         Y0a8fvr+elhf0PdJNNAfMTpwNvolj34r9NQE12EVBDuD/Me7PxONxAuVBR1zAfyJ17YL
         RYdXpd/qo5aGpaSa8Dziz81dM5rf235n5KpQueIufjeT1Vb/TBg3dpzmAB7ItR5QHUxT
         7AIA==
X-Gm-Message-State: AOJu0YxTTb+OBAqYXvgk5xl8FuszER4H2XJ0RbgoC50E6DqwteIIq94P
        DW9CIPUsPLtZ8AGb7V4mE8jjMCu/EEkZTldRpuU=
X-Google-Smtp-Source: AGHT+IElbzLWv5+U8tookY592+oMRvs/IC4tG0ZinqWpOiBQMdv7DA10GDoOxDHuu+h6IYvQZ1MwF+JeNkRNeoBvE6s=
X-Received: by 2002:a17:90a:1a05:b0:280:25e8:f7b4 with SMTP id
 5-20020a17090a1a0500b0028025e8f7b4mr10999241pjk.15.1699972279326; Tue, 14 Nov
 2023 06:31:19 -0800 (PST)
MIME-Version: 1.0
References: <da1d9efd-fdc1-4651-8a7a-30ae4a399926@linux.microsoft.com>
 <CAHC9VhSfTDoPee5_qXyh0QpjeMSsx5RmWOQgmk1NGC87kn0nsg@mail.gmail.com>
 <CAEjxPJ7xw=qN9n6qH3=b1a1khisUVVL79pt9tpi319ZViL57mQ@mail.gmail.com> <aee59e7d-2a94-235a-a9dc-e1059660fcc7@ieee.org>
In-Reply-To: <aee59e7d-2a94-235a-a9dc-e1059660fcc7@ieee.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 14 Nov 2023 09:31:07 -0500
Message-ID: <CAEjxPJ7jvYPENavhxdrT8y1cDrNSc4Cw5Q3Pny8e+P=4Lt=YBw@mail.gmail.com>
Subject: Re: Proposed feature: fine-grained file descriptors in SELinux
To:     Chris PeBenito <pebenito@ieee.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Chris PeBenito <chpebeni@linux.microsoft.com>,
        SElinux mailing list <selinux@vger.kernel.org>,
        brauner@kernel.org, bluca@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 14, 2023 at 9:14=E2=80=AFAM Chris PeBenito <pebenito@ieee.org> =
wrote:
>
> On 11/13/2023 10:35 AM, Stephen Smalley wrote:
> > On Sun, Nov 12, 2023 at 11:52=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >> On Thu, Nov 9, 2023 at 1:26=E2=80=AFPM Chris PeBenito
> >> <chpebeni@linux.microsoft.com> wrote:
> >>> systemd is increasing usage of memfds, pidfds, etc.  This is resultin=
g
> >>> in a need for wide inheritance of fds across the system.  For example=
 in
> >>> a lot of systemd interfaces that have a pid field now have a comparab=
le
> >>> pidfd interface.  dbus-broker and polkit are similarly updated.
> >>>
> >>> Some references from an All Systems Go! talk:
> >>> https://cfp.all-systems-go.io/media/all-systems-go-2023/submissions/T=
3LJAM/resources/ASG_2023_PID_FD-ize_all_the_things_E98Zw9Q.pdf
> >>>    This is from a few months ago; the switch to PIDFDs is nearly
> >>> complete, and we're already seeing denials for this usage.
> >>>
> >>>
> >>> Since file descriptors are increasing use as references for various
> >>> operations, I think it would be useful to have a finer-grained fd cla=
ss,
> >>> so we can limit file descriptor inheritance, particularly as it looks
> >>> like systemd/pid1 will need to inherit pidfd file descriptors from
> >>> possibly all domains.  Specifically, I propose adding new permissions=
 to
> >>> the fd class, such as use_pidfd and use_memfd.  Then systemd can use
> >>> pidfds from any domain, but only use regular fds from trusted domains=
.
> >>>
> >>> Thoughts?
> >>
> >> I think adding some granularity to the fd:use permission makes sense,
> >> although I'm wondering if we are better served by creating new object
> >> classes for these new types of reference fds, e.g. pidfd:use,
> >> memfd:user, etc.?  When I read "use_pidfd" my first thought is that we
> >> are encoding an object class in the permission.
> >>
> >> Have you looked at the associated kernel code yet?  I suspect we might
> >> need to augment the existing memfd/pidfd/etc. code paths with an
> >> additional LSM hook to be able to mark the fd's LSM/SELinux state with
> >> class info, but I'm not sure off the top of my head.
> >
> > We don't actually store SECCLASS_FD in any security blobs currently
> > (i.e. there is no sclass field in the file_security_struct); we just
> > always check against SECCLASS_FD in file_has_perm(),
> > selinux_binder_transfer_file(), ioctl_has_perm(),
> > selinux_kernel_module_from_file(). As you note, we don't have a way of
> > knowing what kind of fd it is at those points so we would need to
> > somehow pass that information to selinux_file_alloc_security() and
> > save the class at that time, or otherwise introduce new hooks.
> >
> > There are three approaches that could be taken here:
> > 1. Introduce new permissions on the existing class, as proposed by Chri=
s,
> > 2. Introduce new classes, as you proposed,
> > 3. Label different kinds of fds via type_transitions or similar so
> > that we can distinguish them by type in policy rather than needing
> > separate permissions or classes.
> >
> > We've used all three approaches in the past for different kinds of
> > checks so it is more a question of what is optimal for this use case.
> > The last one is the heaviest approach since it imposes extra overhead
> > upon allocation/labeling that doesn't currently exist for fds.
>
> Either new perms or new class works for me.  I like the new classes idea
> more than my original proposal; however, I'm unclear how a
> type_transition would work in this scenario.  What would the target type =
be?
>
> type_transition foo_t ?:fd foo_pidfd_t;
> type_transition foo_t ?:fd foo_memfd_t;

Sorry, perhaps I was unclear. The new classes proposal is just to use
a different security class i.e. fd, pidfd, memfd classes, such that
allow rules would be written accordingly, e.g. allow foo_t self:fd
use; allow foo_t domain:pidfd use; That was Paul's proposal. Using a
derived type via type_transition is the 3rd option, and that one would
require introducing logic into selinux_file_alloc_security() to call
security_transition_sid() and impose that overhead on all fd creation,
which is likely a non-starter.
