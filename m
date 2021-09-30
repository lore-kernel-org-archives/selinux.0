Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BE5C433EF
	for <selinux@archiver.kernel.org>; Thu, 30 Sep 2021 08:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C515961139
	for <selinux@archiver.kernel.org>; Thu, 30 Sep 2021 08:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348471AbhI3Ieg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Sep 2021 04:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348472AbhI3Ief (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Sep 2021 04:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632990772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sY/1LU0W2idJxhA9OQR/bbtr7x+gKXDH9LWZBr2tuio=;
        b=CaqouuG6MpzHD6CGvu2D58EDSYaD6um2MxUzBoqz9HajOsY28Sn3J2CcXR1KnsescX8RqX
        UCtquErrk1oZ2uk5XzB+VQ3EnwTRjPk0ZfYaidTGqoYoKGJoSLhr4ptTdBwN+139PjYLGX
        TIJdsGrlBTlxY5qm9tBGe1MNburrJic=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-72qcltF7OSqQsWJtjQJziA-1; Thu, 30 Sep 2021 04:32:51 -0400
X-MC-Unique: 72qcltF7OSqQsWJtjQJziA-1
Received: by mail-yb1-f199.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso7343456ybq.10
        for <selinux@vger.kernel.org>; Thu, 30 Sep 2021 01:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sY/1LU0W2idJxhA9OQR/bbtr7x+gKXDH9LWZBr2tuio=;
        b=dwrpo5Xpdf2Vp+EzezVRs6rvJGw5AHuYWgNKwbxjtKVemq9vBHio2q9nbAx01ULAZR
         eV0OF9f9VMVopMxvpNtgZCrxxo58YgSVSs9SfCUgmHRvRDaXjndRacJ0zIzR0bk/X6we
         CNAb/ZDZlaFTGdU+aSAQHCjPBAy50hZCg00n6d9PIaDuP0Ss4R5UvNZBltA1JTOrdVys
         7TAExL0f2yejUqNLAwFN4LVq6orcYcPQEkjHAQCyGbo78ffmPkYSvUPcZFSR0FRJ0awM
         CIr27zggsJ5iwyxonGmthB0poF5q17SWVoes6X7evVxFfV1wnjqVMIKr88CXCq7a90cO
         YA0A==
X-Gm-Message-State: AOAM531IahMxzkm3wJLQ48S7hT/LyMob5EPcNZzJRc6fKYfbxYbgKGUp
        Tgrft+KG5H43CFHtuIG1beQoXNmNBVg8zqsP4XlVmG8rl1XocG2O37wuN98scWUl1PRAaa1Qxgg
        EdLlvUQ8Ax32UkXELA4dxglw1NOWSo+M1lw==
X-Received: by 2002:a5b:88a:: with SMTP id e10mr5374163ybq.467.1632990770512;
        Thu, 30 Sep 2021 01:32:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgj1WymmlrSeFc6fpBfEbPEPVGIzRRXy9kYu8T24iknq1idYI/jIb3PYVDD2zBVz0kL8JnUxQEY3YGuAJGcng=
X-Received: by 2002:a5b:88a:: with SMTP id e10mr5374145ybq.467.1632990770273;
 Thu, 30 Sep 2021 01:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <163292547664.17566.8479687865641275719.stgit@olly>
In-Reply-To: <163292547664.17566.8479687865641275719.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 30 Sep 2021 10:32:39 +0200
Message-ID: <CAFqZXNuYt8f3-H3Dx8q-b9Ce9eUcoEmVPxJtbZZpc4mwvMpZCg@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the SELinux lockdown implementation
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 29, 2021 at 4:24 PM Paul Moore <paul@paul-moore.com> wrote:
> NOTE: This patch intentionally omits any "Fixes:" metadata or stable
> tagging since it removes a SELinux access control check; while
> removing the control point is the right thing to do moving forward,
> removing it in stable kernels could be seen as a regression.
>
> The original SELinux lockdown implementation in 59438b46471a
> ("security,lockdown,selinux: implement SELinux lockdown") used the
> current task's credentials as both the subject and object in the
> SELinux lockdown hook, selinux_lockdown().  Unfortunately that
> proved to be incorrect in a number of cases as the core kernel was
> calling the LSM lockdown hook in places where the credentials from
> the "current" task_struct were not the correct credentials to use
> in the SELinux access check.
>
> Attempts were made to resolve this by adding a credential pointer
> to the LSM lockdown hook as well as suggesting that the single hook
> be split into two: one for user tasks, one for kernel tasks; however
> neither approach was deemed acceptable by Linus.  Faced with the
> prospect of either changing the subj/obj in the access check to a
> constant context (likely the kernel's label) or removing the SELinux
> lockdown check entirely, the SELinux community decided that removing
> the lockdown check was preferable.
>
> The supporting changes to the general LSM layer are left intact, this
> patch only removes the SELinux implementation.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

I would probably also remove LSM_AUDIT_DATA_LOCKDOWN, but I don't care
enough to argue about it :)

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

/me goes off to prepare a patch to remove the lockdown test from the
testsuite...

> ---
>  security/selinux/hooks.c            |   30 ------------------------------
>  security/selinux/include/classmap.h |    2 --
>  2 files changed, 32 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6517f221d52c..11ebbbd65823 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7013,34 +7013,6 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>  }
>  #endif
>
> -static int selinux_lockdown(enum lockdown_reason what)
> -{
> -       struct common_audit_data ad;
> -       u32 sid = current_sid();
> -       int invalid_reason = (what <= LOCKDOWN_NONE) ||
> -                            (what == LOCKDOWN_INTEGRITY_MAX) ||
> -                            (what >= LOCKDOWN_CONFIDENTIALITY_MAX);
> -
> -       if (WARN(invalid_reason, "Invalid lockdown reason")) {
> -               audit_log(audit_context(),
> -                         GFP_ATOMIC, AUDIT_SELINUX_ERR,
> -                         "lockdown_reason=invalid");
> -               return -EINVAL;
> -       }
> -
> -       ad.type = LSM_AUDIT_DATA_LOCKDOWN;
> -       ad.u.reason = what;
> -
> -       if (what <= LOCKDOWN_INTEGRITY_MAX)
> -               return avc_has_perm(&selinux_state,
> -                                   sid, sid, SECCLASS_LOCKDOWN,
> -                                   LOCKDOWN__INTEGRITY, &ad);
> -       else
> -               return avc_has_perm(&selinux_state,
> -                                   sid, sid, SECCLASS_LOCKDOWN,
> -                                   LOCKDOWN__CONFIDENTIALITY, &ad);
> -}
> -
>  struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>         .lbs_cred = sizeof(struct task_security_struct),
>         .lbs_file = sizeof(struct file_security_struct),
> @@ -7349,8 +7321,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
>  #endif
>
> -       LSM_HOOK_INIT(locked_down, selinux_lockdown),
> -
>         /*
>          * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
>          */
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 084757ff4390..9859787e8e61 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -250,8 +250,6 @@ struct security_class_mapping secclass_map[] = {
>           { COMMON_SOCK_PERMS, NULL } },
>         { "perf_event",
>           { "open", "cpu", "kernel", "tracepoint", "read", "write", NULL } },
> -       { "lockdown",
> -         { "integrity", "confidentiality", NULL } },
>         { "anon_inode",
>           { COMMON_FILE_PERMS, NULL } },
>         { NULL }
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

