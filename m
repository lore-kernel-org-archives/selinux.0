Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A23EB64D9
	for <selinux@archiver.kernel.org>; Tue, 27 Jun 2023 14:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjF0OfX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjF0OfV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Jun 2023 10:35:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B32D6A
        for <selinux@vger.kernel.org>; Tue, 27 Jun 2023 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687876475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwIj+qmHfmi718S3G20ZEU5A/ZS/0YBTtp5/ZbzUXRM=;
        b=dvtJVe43IaIcTGmAHwW6eDONaxIi9a+hGDe+WjMODpkat98HLQdGppdZTtv9K5q+WtsO4S
        K+BLs2BMQ9kww7gM7ksJ5VOXc5rsHv7Ya3qzX1xG7W/s+UtXC4Zux4nvq0r2KUtLplds1E
        HjY6r0O6+PlzZIbQ4OrQx9LxBObhMtY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-crpwCzjENv-_wxAxRRsM9Q-1; Tue, 27 Jun 2023 10:34:27 -0400
X-MC-Unique: crpwCzjENv-_wxAxRRsM9Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-262c488c1d3so1604156a91.3
        for <selinux@vger.kernel.org>; Tue, 27 Jun 2023 07:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876465; x=1690468465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwIj+qmHfmi718S3G20ZEU5A/ZS/0YBTtp5/ZbzUXRM=;
        b=MIWVmiL0utOxZXkleChX7PYbFLjcGGeNR5wEjRbdMGkDBSHD3FzKs8vCGKnts35ND7
         FIlg74ao2TcEiz9bj9V4Oc3J/BVr+y/vapl+FAP7z612FDc9mt02B0WvRYN4gOgdAuwL
         lCN78FdldMQEJ9M1+HWtEj+tN8Kl/03wf5vvHv80Qsummi7CUkMHIu+/A7KjyUIRSrT5
         /IgbNKiTSMkmmWl/GoAkf3otw75mzwtwLi6AtTx3QYL13s9TTaqRR8H7Fgg7sWV0vimm
         yIyaAhmxpilmCMF4pZgz7/35dvVSzQISI1Xa2g8T0//5pxsocQTXlT6wceA+qn8sTXbe
         QIHg==
X-Gm-Message-State: AC+VfDyJQvudR2+Wr47P+Npk5zVhwRHx03GrOLryTmzQEa/SNyCZe6oI
        7NKDoERYpwp/bLSIBhlL22j23Ef4RAhdnVXWNZBnyxu6QWEHDLlayts34qQCf6YennUZXHU0/7/
        eRU0LBjKsMVq5Y65hotTjLLfZh/YJNyOTuvioS5D2XHTu
X-Received: by 2002:a17:90a:ea0c:b0:262:c7ae:e622 with SMTP id w12-20020a17090aea0c00b00262c7aee622mr5954248pjy.17.1687876465136;
        Tue, 27 Jun 2023 07:34:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OrMmR/3fj4+xq+NySr9iocH8pB3Z5du+9vgbGoal9uJP/xg99Bx5roQ7GssUeygXCYfzWiTsLHM5kjYVnM1s=
X-Received: by 2002:a17:90a:ea0c:b0:262:c7ae:e622 with SMTP id
 w12-20020a17090aea0c00b00262c7aee622mr5954232pjy.17.1687876464782; Tue, 27
 Jun 2023 07:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRpBZpqwJ4J+sPHr=ZMmkpd5qmLW-a+B+GGKre=NSU-AA@mail.gmail.com>
In-Reply-To: <CAHC9VhRpBZpqwJ4J+sPHr=ZMmkpd5qmLW-a+B+GGKre=NSU-AA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 27 Jun 2023 16:34:13 +0200
Message-ID: <CAFqZXNs+VW44pa2kMLDqcOMRaudNXgZCuGy2Zt51KhR2fD7QOg@mail.gmail.com>
Subject: Re: RFC: style/formatting changes for SELinux kernel code
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 9, 2023 at 4:24=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Hello all,
>
> Over the past few weeks, as time allowed, I've been working on adding
> some automation to my Linux Kernel workflows.  Most of this has been
> scripting various maintainer tasks, e.g. reviewing and merging
> patches, which I expect is not very interesting to most people reading
> this, but I think there is one aspect of these automations that might
> be interesting for a wider audience: basic patch sanity/verification
> tests.  These tests are intended to mimic the sanity tests I perform
> when reviewing patch submissions, things like "run checkpatch", "make
> sure it builds without error", "ensure the style/formatting is
> reasonable", etc.  For those that are curious, you can see the current
> tests in the repo below, but I will caution you that there are surely
> problems with the scripts, they are still very new and barely tested;
> expect changes.  I should also note that I haven't published the
> tool/framework which I use to run these tests just yet, but the tests
> are intended to be standalone so there should still be value as-is.
> My thinking is that by sharing these scripts, and keeping them
> updated, it will help keep the developers and reviewers sync'd as to
> what is expected from a SELinux kernel patch.  Much like checkpatch, I
> don't expect these scripts to represent a perfect, ideal standard but
> I think they represent a "good enough" example where the accepted
> verification failures should be relatively few.
>
> * https://github.com/pcmoore/git-verification_scripts

This looks like a nice step forward. Are you also looking into
integrating these checks into patchwork? I noticed that e.g. in the
netdev project patches get tagged with similar sanity checks (netdev)
and even test results (bpf). Perhaps you could even reuse some of the
tooling/infra they use.

> With all of the above in mind, I wanted to get everyone's opinions on
> the style/formatting suggested by the scripts above.  As anyone who
> has looked at the SELinux kernel code knows, the style is somewhat
> inconsistent, both with respect to the SELinux subsystem, and the
> kernel as a whole.  That unfortunately means that if we want to be
> able to start vetting the style of new code changes, we really need to
> properly (re)format the existing code first.  Before I went too far
> with this I wanted to see what it might look like when applied to one
> of our ugliest source files, security/selinux/hooks.c; you can see the
> results in the commit below:
>
> * https://github.com/pcmoore/misc-linux_kernel/commit/3f94fd77b46522a038e=
b6771b63d0a6d36ca3547
>
> I'd like to hear what everyone thinks about making a change like this.
> I personally think it is a positive step forward, but I do acknowledge
> that those who have to do backports will likely feel some occasional
> pain.  As the backport pain will eventually subside, and the benefits
> of nicer-looking code and improved/shared patch verification will
> continue, I'm leaning towards reformatting the code, but I do *really*
> want to hear what people have to say before we do this.

Regarding the impact on backports: yes, this will be potentially
*very* painful for us (Red Hat engineering), depending on how it's
done. What would help is if you could split the change into many small
commits - ideally something close to per-function (with some closely
related functions/declarations/definitions maybe combined together). I
know it would be a lot of commits and a non-trivial amount of extra
work, but from a consumer's perspective I don't really see any
downsides vs. a single big commit. From a pure upstream perspective I
definitely support the change, so hopefully we can come to a
compromise such that we are both happy with the result :)

As for the proposed style, it looks mostly good to me. One minor
concern I have is that it removes some visually helpful alignment
after '=3D'/':' in selinux_sb_clone_mnt_opts(), selinux_syslog(),
selinux_fs_parameters, and selinux_nf_ops. Not something I would lose
sleep over, but would be nice if it can be somehow preserved.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

