Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B952C4332F
	for <selinux@archiver.kernel.org>; Mon, 13 Nov 2023 15:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjKMPfT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Nov 2023 10:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMPfT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Nov 2023 10:35:19 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE5EC2
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 07:35:15 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5bd099e3d3cso2660561a12.1
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 07:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699889715; x=1700494515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4vRBjI4k4e2tgdl01HUAoRsOjXO+mJplNO3zLj3m18=;
        b=MNnUK+nKGkm6+LoeLubMfNHj2AA1Toof9A7BdnmCig69O993jkCqKXAX9TEnKcHp/9
         GfVTG0XKanUWYvVqcqDbeZn9AIq3mj87JQQXVr17db53jtvo5zN1UCo1UNpW6p7ljxmz
         dy6A303xBbj7bg8Evz2OVLPHu+sh+mPXEhUtLLH7CxWLrtK7sI/xd0aK3nERhCfwZxrA
         UUs0sEqtWlF6cuFcaQaAVIvAadyh+LUXM44nOZ8MleUPO7P9s6B0RM6DxD2AobGwnzHV
         eDqahXHW4pq7L9gG/5aLVsc7ZKwnU29pqsNW8gOwW2yDHXUK8OpTvir6WIs84z3tGKJy
         DKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699889715; x=1700494515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4vRBjI4k4e2tgdl01HUAoRsOjXO+mJplNO3zLj3m18=;
        b=tSuIyhkdRpKGuljMkzF976QStiOmQlP3pBz/g8Kb3w/AwUWQ1/c2cGaw3s2N5DcAqw
         vH/9yftmuM6jQz6/Zlv+gbe6fEPg8IX75MR/YocyE73Rh7Jcz/X4P6MIpVJcw9blmQrg
         vWAUNUEMJQIme25vxP+84OXfA31cRqZL+IHnJJiwoblunxt+lKKydGZyyb0w4gI3y9a1
         Qxhy0I5dMn4RtKFB6fgh120EE/btjt+QjIEv43AHm6wrxQS1eoo8f6eD5/IHTx9rer8v
         8hBQBKDkoGzEj25Ry6zrSbs13tN5tpSXUhWxtbgU9vJppgprLOtBxlCurpmNmocshV1f
         kIEw==
X-Gm-Message-State: AOJu0YzX8A+YDRd4Rm8O6C39Ct7bznI3JeVdkDUMkyZnbqpk5DTFxmi6
        5BH6PTGI0X7RJ9EiRVQQw/LOcz+PZAQQhq5v0jqfwQLv
X-Google-Smtp-Source: AGHT+IEmXB/HK3bDNgZ6Y2+0UEZVpiDdU4gusiTUxXJmTs9a38oGhRMnUAb2wEqYNvlvPhpIId+ICzLf/FAopDHF78Q=
X-Received: by 2002:a17:90b:1a91:b0:283:2805:7c78 with SMTP id
 ng17-20020a17090b1a9100b0028328057c78mr4030802pjb.14.1699889714984; Mon, 13
 Nov 2023 07:35:14 -0800 (PST)
MIME-Version: 1.0
References: <da1d9efd-fdc1-4651-8a7a-30ae4a399926@linux.microsoft.com> <CAHC9VhSfTDoPee5_qXyh0QpjeMSsx5RmWOQgmk1NGC87kn0nsg@mail.gmail.com>
In-Reply-To: <CAHC9VhSfTDoPee5_qXyh0QpjeMSsx5RmWOQgmk1NGC87kn0nsg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 13 Nov 2023 10:35:03 -0500
Message-ID: <CAEjxPJ7xw=qN9n6qH3=b1a1khisUVVL79pt9tpi319ZViL57mQ@mail.gmail.com>
Subject: Re: Proposed feature: fine-grained file descriptors in SELinux
To:     Paul Moore <paul@paul-moore.com>
Cc:     Chris PeBenito <chpebeni@linux.microsoft.com>,
        SElinux mailing list <selinux@vger.kernel.org>,
        brauner@kernel.org, bluca@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Nov 12, 2023 at 11:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Nov 9, 2023 at 1:26=E2=80=AFPM Chris PeBenito
> <chpebeni@linux.microsoft.com> wrote:
> >
> > systemd is increasing usage of memfds, pidfds, etc.  This is resulting
> > in a need for wide inheritance of fds across the system.  For example i=
n
> > a lot of systemd interfaces that have a pid field now have a comparable
> > pidfd interface.  dbus-broker and polkit are similarly updated.
> >
> > Some references from an All Systems Go! talk:
> > https://cfp.all-systems-go.io/media/all-systems-go-2023/submissions/T3L=
JAM/resources/ASG_2023_PID_FD-ize_all_the_things_E98Zw9Q.pdf
> >   This is from a few months ago; the switch to PIDFDs is nearly
> > complete, and we're already seeing denials for this usage.
> >
> >
> > Since file descriptors are increasing use as references for various
> > operations, I think it would be useful to have a finer-grained fd class=
,
> > so we can limit file descriptor inheritance, particularly as it looks
> > like systemd/pid1 will need to inherit pidfd file descriptors from
> > possibly all domains.  Specifically, I propose adding new permissions t=
o
> > the fd class, such as use_pidfd and use_memfd.  Then systemd can use
> > pidfds from any domain, but only use regular fds from trusted domains.
> >
> > Thoughts?
>
> I think adding some granularity to the fd:use permission makes sense,
> although I'm wondering if we are better served by creating new object
> classes for these new types of reference fds, e.g. pidfd:use,
> memfd:user, etc.?  When I read "use_pidfd" my first thought is that we
> are encoding an object class in the permission.
>
> Have you looked at the associated kernel code yet?  I suspect we might
> need to augment the existing memfd/pidfd/etc. code paths with an
> additional LSM hook to be able to mark the fd's LSM/SELinux state with
> class info, but I'm not sure off the top of my head.

We don't actually store SECCLASS_FD in any security blobs currently
(i.e. there is no sclass field in the file_security_struct); we just
always check against SECCLASS_FD in file_has_perm(),
selinux_binder_transfer_file(), ioctl_has_perm(),
selinux_kernel_module_from_file(). As you note, we don't have a way of
knowing what kind of fd it is at those points so we would need to
somehow pass that information to selinux_file_alloc_security() and
save the class at that time, or otherwise introduce new hooks.

There are three approaches that could be taken here:
1. Introduce new permissions on the existing class, as proposed by Chris,
2. Introduce new classes, as you proposed,
3. Label different kinds of fds via type_transitions or similar so
that we can distinguish them by type in policy rather than needing
separate permissions or classes.

We've used all three approaches in the past for different kinds of
checks so it is more a question of what is optimal for this use case.
The last one is the heaviest approach since it imposes extra overhead
upon allocation/labeling that doesn't currently exist for fds.

All that said, I am not entirely sure how useful the current fd use
permission is, nor how useful these finer-grained checks will be.
Fedora policy by default allows every domain to use every other
domain's fds (controllable via domain_fd_use boolean, default is
true). Android I think is more selective.
