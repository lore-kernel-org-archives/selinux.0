Return-Path: <SRS0=hhxa=X4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3FFC10F14
	for <selinux@archiver.kernel.org>; Thu,  3 Oct 2019 18:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D2820862
	for <selinux@archiver.kernel.org>; Thu,  3 Oct 2019 18:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="aDTqWMHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfJCSy4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:54:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39191 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbfJCSy4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Oct 2019 14:54:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id 72so2650667lfh.6
        for <selinux@vger.kernel.org>; Thu, 03 Oct 2019 11:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3sWrn1nsZUOsgloEW49mnqPaBuQFcjutkdg8lyw7+bM=;
        b=aDTqWMHVFrfXyeqlWE9FEYe+bwnaq7GCxK5wHDvgrwBC4E7v+eEmFIc53CsRnDGvv2
         /I2ybelEb7MHs2GwZtcflqzNj0DWVtl0gcx9mso5pOeVPBilZoj1Xgi7ToX3/YSX8N2X
         Kh1hPg56JU5qkzxaL9Qarj2Xhh9gn2CMoA3fLBWSe7O0NGuvZPsM7ZupFvcIbno4daAn
         IzVRMnIcrG+lYybPLOpsU+MUOuYZKAUlRoZdhPkdRzt5ICu3p8Ood3YCwOOGp9vyj5FS
         PTN7B+g3w/BhOCpboh7NsPV6/SfoYS+JNxc+Ys207y/KFKpEiKgYkRYDnr5IxZbO7KRr
         9sOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3sWrn1nsZUOsgloEW49mnqPaBuQFcjutkdg8lyw7+bM=;
        b=GSbYjxtPHyj1YimcgiyvqvbArTDjMx3ZYWRaPB1KKHk12FIlVzLC+C7YlMGNXyAdMS
         MI39l8qi0QbWVVAZXB6rMfEt5QNpEOs4A5ShB4o/bZNcbwMt7LyZL7Ldt2iuw6ZTW6uM
         Jqh3Kag7cbm1PlRiFJTki9s9/g3rGjsWkbDoV9Y3CUntzv144mOhSfjoQVVBaOV+lzX+
         CQRNt5Qqygn1j3typlk+EmKtcP50X3InVSJFmbmzvQa9mMl+UsifrkovHkrh06pBhsGS
         hLEjDMSPOfeREFdAC9tbQ/yuUS5SnpwrU5xEJDdqOri2DM5BHfJ2CPqiZZ9GXPxx0aOp
         ZkXw==
X-Gm-Message-State: APjAAAWVag1ZgV5OMonbqhFlDh4zRYkluLVa/a0PwT76v/3NQpuRx6FU
        /bEgS6cP5PAQjt+Y7uSlv+ebV73U1HtRtXdAhlhH
X-Google-Smtp-Source: APXvYqylrXESxnOOJZGIOsRlkbCa7IIAHmrz9qiSxya/YEsPdmqVQknKLw6z/eXsEiAJMGpahXaEOE3vlRchOOrNoJg=
X-Received: by 2002:a19:6517:: with SMTP id z23mr5995696lfb.31.1570128893508;
 Thu, 03 Oct 2019 11:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191003135922.29498-1-omosnace@redhat.com>
In-Reply-To: <20191003135922.29498-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Oct 2019 14:54:43 -0400
Message-ID: <CAHC9VhR5bTBC8nJnnU-7H6JTYLW7DTHyie2=c-U2DX1y2njcGA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix context string corruption in convert_context()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Milos Malik <mmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 3, 2019 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> string_to_context_struct() may garble the context string, so we need to
> copy back the contents again from the old context struct to avoid
> storing the corrupted context.
>
> Since string_to_context_struct() tokenizes (and therefore truncates) the
> context string and we are later potentially copying it with kstrdup(),
> this may eventually cause pieces of uninitialized kernel memory to be
> disclosed to userspace (when copying to userspace based on the stored
> length and not the null character).
>
> How to reproduce on Fedora and similar:
>     # dnf install -y memcached
>     # systemctl start memcached
>     # semodule -d memcached
>     # load_policy
>     # load_policy
>     # systemctl stop memcached
>     # ausearch -m AVC
>     type=3DAVC msg=3Daudit(1570090572.648:313): avc:  denied  { signal } =
for  pid=3D1 comm=3D"systemd" scontext=3Dsystem_u:system_r:init_t:s0 tconte=
xt=3Dsystem_u:object_r:unlabeled_t:s0 tclass=3Dprocess permissive=3D0 trawc=
on=3D73797374656D5F75007400000000000070BE6E847296FFFF726F6D000096FFFF76
>
> Reported-by: Milos Malik <mmalik@redhat.com>
> Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve per=
formance")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/services.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Thanks for finding and fixing this.  This looks like a good candidate
for stable so I went ahead and merged it into selinux/stable-5.4; if
any one has any objections to that, let me know by the end of the
week.

--=20
paul moore
www.paul-moore.com
