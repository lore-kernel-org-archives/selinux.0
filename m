Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C177DC28CBC
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 13:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE4320752
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 13:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmB8Y8T/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgEFNow (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 09:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725966AbgEFNov (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 May 2020 09:44:51 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AA3C061A0F
        for <selinux@vger.kernel.org>; Wed,  6 May 2020 06:44:51 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e20so1341307otk.12
        for <selinux@vger.kernel.org>; Wed, 06 May 2020 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=kq4MeA8nUyqtfoMjAnQ/9n+0bYtyIXKgnsjvZnAzBoA=;
        b=RmB8Y8T/5xP3sgtSp9eOR0sw445VMPsMgm8sofyPFSv3TKu3YsoVejxde2qnSH4ghN
         tpNgrTUd23Sx/LQfjxGRh37xrfeLkpdWzYMt4TuCxtA9msay4KXcsXmv9r7sxTebskcD
         ig+50hY51XwSxP8p/gBZESgjGenAcXBk5+10p4guR7emWj9L0a27y6ldZgZCGReoVmSH
         TQXunaSSvTPGH0C6LB8818GEaHH7qcMxqvvoaR/3xBph+MmiMM0xGXKcxh8TlnC9/rzE
         Oh6XBO8UPrqtD3nOgypJaIViT+OcGRjkcmpb5BRnyD21qVL43pRdxoOpqu8Kcjfwr5eJ
         BGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=kq4MeA8nUyqtfoMjAnQ/9n+0bYtyIXKgnsjvZnAzBoA=;
        b=R4RDi7t7zJAU17ZRCNXVyc0PmEf2M5pw/inOJIrUcFBW2gGCn9QidlIHhu4laukOcZ
         xN7ShhIuLjJ4ZPPP+zRc7YXi2lVaQEh1t7RMUJvmOOC69MisMCbT+E3I2wvW3rdORqPR
         unDQ4Vxe8avDwgeTWLSwPBlbAMNA1i8jdTjdPXzqsbmQC3G3DzA+M+aRZFceoghgkP0r
         BrN5s1l0PIp8jRV0/E0NHkLq0fvm2EBUvBdKJuSsuelDIx50+ihUFriNYB2HJJ+IkMeW
         I11kw2rJkqXc4l+eqwuORg/UwX3+7ghJkqv4zQXT08NgQ1reU8zV0buZmJf+lZ2U0bpR
         v8PQ==
X-Gm-Message-State: AGi0PuY0zYtGi1lTyERWVb32sedHSg2BpLOD4PUxGd4N/s6781NXCrv7
        f6zulDqNCyiSnfH9V4UDjiSKiFDIj/zz3Oas9XJXaMkAtag=
X-Google-Smtp-Source: APiQypIvWNpKMepSs5BMaqSNjRUvYf+g9OQIjo+sF1DRx4ibFHRRMyKY8hQjkMh1afV/E4xWfnJKPahrQyKkuUETNz4=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr6362035otb.135.1588772690495;
 Wed, 06 May 2020 06:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 6 May 2020 09:44:39 -0400
Message-ID: <CAEjxPJ7GVYBTKyiQM8_XdnbXk26-Eq_cPAs1zrtK8Aj=FfZd_A@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 5, 2020 at 8:54 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Update the testsuite policy and code so that it builds and
> runs on Debian unstable and stable successfully (if one has
> already enabled SELinux on Debian).  Provide the necessary
> dependencies and instructions in the README.

A few notes for anyone trying to run this on Debian:

1) There is an open bug in Debian around gdm login shells running in
the wrong context (initrc_t instead of unconfined_t),
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=874191, due to the
/sys/fs/selinux/user ERANGE problem breaking pam_selinux for the
systemd --user instance and the lack of either a policy workaround (as
previously done in Fedora to limit outbound transitions from init_t to
only valid cases) or the recent libselinux fix (to stop using
/sys/fs/selinux/user altogether).  To permit testing without requiring
my own custom policy or libselinux, I simply ran the tests from a ssh
login rather than a graphical login.  Non-graphical console login
probably would have worked too but I didn't try. But I have escalated
the bug with the Debian SELinux maintainers in hopes of getting that
fixed.

2) In Debian unstable, I also had to setsebool -P ssh_sysadm_login=1
to allow ssh login as unconfined.  I let the Debian SELinux
maintainers know but it isn't clear they will change the default.

3) Debian policy package ships with /etc/selinux/config set to
permissive since the policy often doesn't work cleanly out of the box,
so I had to manually setenforce 1 before running the testsuite.  This
btw killed any gdm login sessions as well due to missing execmem and
other permissions so that's another reason to not do it from a gdm
login under their current policy.

4) The Debian stable kernel didn't enable CONFIG_NETLABEL so all of
the netlabel-dependent inet_socket tests failed on stable.  Debian
unstable kernel had CONFIG_NETLABEL enabled and they all passed there.
I didn't consider it worthwhile to build my own Debian stable kernel
for testing it; I just wanted to ensure that the policy worked, which
I consider the Debian unstable test to prove.

Interestingly, on Debian unstable, we end up running more tests than
on Fedora rawhide currently: 64 test scripts with 869 individual tests
versus 62 test scripts with 824 individual tests.  This is because
Debian unstable's policy (which is based on a recent snapshot of
refpolicy) has class and permission definitions for everything in its
kernel except the lockdown class, versus Fedora which lacks the watch*
permissions as well as the perf_event and lockdown classes.
