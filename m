Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A7EC433EF
	for <selinux@archiver.kernel.org>; Thu, 16 Sep 2021 14:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F2860F70
	for <selinux@archiver.kernel.org>; Thu, 16 Sep 2021 14:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbhIPOEW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Sep 2021 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbhIPOEU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Sep 2021 10:04:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A31C061574
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 07:02:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z94so17119762ede.8
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDQVWMVyDKOgzkZcDb3+rDqpvwcn3Jz4M4lERqwtKzQ=;
        b=wheUGG6/fAzYjxsJXBa4L1O+wb7bTADoVB+CUwozatY1vQ/2NdMTjizRYivhfTyJkg
         pS1x+m2nrE6B4UrUlOLxq19vsPD4nCphARChyopu2tcjbY2XWhKE+JsP84CxbioYR5KJ
         r1n+67Iqv0+jClRBE5ZW7aL8hOOxSv1aCPb1cB/oGXUEirOrcMz/oJL0EYjVlii/VEo/
         biQvKQpVGBddI1uiH96j/Rj97wnUbUjp7Vji5auoDqTuRmoErqTazNctcAHHUo3xVx/J
         A31eZ+59ej72qOfLZnJ4e/7DVEaJctSU5otIpFX5bJQ1cyi4+/2arABJXjgw8dj1PWNs
         WcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDQVWMVyDKOgzkZcDb3+rDqpvwcn3Jz4M4lERqwtKzQ=;
        b=Wlxm8rC9kksZ7zwaabZk1USFlf9n5jycfLeYTNBdqxWXwfsW55Kv2NNjBbG1wNBDQI
         VARbPPDzSVWY2Vyoq7Nw/a/HaE5TqYwI5Em2W1JqP18HEBGlZKx/g4atjU9EHqMFDfW0
         gDKzPwLUaTGPwFFNwldpu48+MfBro/cNkXT1f42QlP588ekNEmbgr5a+4V7ojzs8rlT4
         N/xnaMzbRYqHmiF+smtyZDnOkOQFAb3SjXQSd2lAV6OoxQ7DzsBTRzGLKRjZcud4Mrqb
         e9Lq13W3Y8Zt2xR1vm5sD2BytS9IJ/cXMnOmuuX34wRlyk7ydnQWrHXtJOKJbFpiuZLL
         ziaA==
X-Gm-Message-State: AOAM533orluPE422bLx3FyYjWlsR0xs2j04E2zys2HjLNGxLILqVZeCS
        feqyMYguWGe/RnEWQot1tb5mYEHQt0eoUXPx02bz
X-Google-Smtp-Source: ABdhPJz0VkhT+YrcNMCjIAvY4x3PjlwoxXE0lI4t6a/A0GhzgmqNamjP2Iy2IU4ZaGKEWzMctp3cK+KCxTBks/+ryQs=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr6444839eje.341.1631800966410;
 Thu, 16 Sep 2021 07:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <163172413301.88001.16054830862146685573.stgit@olly>
 <163172457152.88001.12700049763432531651.stgit@olly> <20210916133308.GP490529@madcap2.tricolour.ca>
In-Reply-To: <20210916133308.GP490529@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Sep 2021 10:02:35 -0400
Message-ID: <CAHC9VhSEj8b7+jH9Atkj3FH+SOdc5iwytxhS3_O1HmTahdj3dQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] audit,io_uring,io-wq: add some basic audit support
 to io_uring
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 16, 2021 at 9:33 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2021-09-15 12:49, Paul Moore wrote:
> > This patch adds basic auditing to io_uring operations, regardless of
> > their context.  This is accomplished by allocating audit_context
> > structures for the io-wq worker and io_uring SQPOLL kernel threads
> > as well as explicitly auditing the io_uring operations in
> > io_issue_sqe().  Individual io_uring operations can bypass auditing
> > through the "audit_skip" field in the struct io_op_def definition for
> > the operation; although great care must be taken so that security
> > relevant io_uring operations do not bypass auditing; please contact
> > the audit mailing list (see the MAINTAINERS file) with any questions.
> >
> > The io_uring operations are audited using a new AUDIT_URINGOP record,
> > an example is shown below:
> >
> >   type=UNKNOWN[1336] msg=audit(1630523381.288:260):
> >     uring_op=19 success=yes exit=0 items=0 ppid=853 pid=1204
> >     uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
> >     subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> >     key=(null)
> >     AUID="root" UID="root" GID="root" EUID="root" SUID="root"
> >     FSUID="root" EGID="root" SGID="root" FSGID="root"
> >
> > Thanks to Richard Guy Briggs for review and feedback.
>
> I share Steve's concerns about the missing auid and ses.  The userspace
> log interpreter conjured up AUID="root" from the absent auid=.
>
> Some of the creds are here including ppid, pid, a herd of *id and subj.
> *Something* initiated this action and then delegated it to iouring to
> carry out.  That should be in there somewhere.  You had a concern about
> shared queues and mis-attribution.  All of these creds including auid
> and ses should be kept together to get this right.

Look, there are a lot of things about io_uring that frustrate me from
a security perspective - this is one of them - but I've run out of
ways to say it's not possible to reliably capture the audit ID or
session ID here.  With io_uring it is possible to submit an io_uring
operation, and capture the results, by simply reading and writing to a
mmap'd buffer.  Yes, it would be nice to have that information, but I
don't believe there is a practical way to capture it.  If you have any
suggestions on how to do so, please share, but please make it
concrete; hand wavy solutions aren't useful at this stage.

As for the userspace mysteriously creating an AUID out of thin air,
that was my mistake: I simply removed the "auid=" field from the
example and didn't remove the additional fields, e.g. AUID, that
auditd appends to the end of the record.  I've updated the commit
description with a freshly generated record and removed the auditd
bonus bits as those probably shouldn't be shown in an example of a
kernel generated audit record.  I'm not going to repost the patchset
just for this small edit to the description, but I have force-pushed
the update to the selinux/working-io_uring branch.

-- 
paul moore
www.paul-moore.com
