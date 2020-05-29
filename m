Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D20AC433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C27207BC
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDIYoKlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgE2Nnc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 09:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2Nnc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 09:43:32 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D6CC03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:43:31 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 23so2564391oiq.8
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=JeWrZ49UnO3lWkc7Go5GxfceEjIa4A5C5/i+fNvZ6jc=;
        b=nDIYoKlQYEL6TS1KEyMOYuz15HOdw2nIxQUGo1+okA3+yB++laf3mWUYkeatZmP0Qn
         SCLeMG9FVrpk8p8xWNOsh2xvCNJJ745HfzGF03e/hLVaa3eQjdqpDjolDh3sbwTGap9z
         2togUQFIeWPcBDhBMF9pFs/VTgr2kX1CKrGpV2G7smaw8QuYZRs7JIw147mxp3ZOAwqL
         NhirAXKGkx2w3Cy6c1QKc8zRXNcYCexySXhXmwHOZSwvWOVdmp8o+5EdpeDsZz4Dfihu
         QFxINkFxHYG5WNGZechmksDnPCRIluab4cFSsFUe1Nb+niyi4z3kr9I9RQ1Z9KcQ5UgN
         pKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=JeWrZ49UnO3lWkc7Go5GxfceEjIa4A5C5/i+fNvZ6jc=;
        b=pxdsh8x9yLDN7/+5PrDvPpytSzRWoYbFH6KLkJ7HGjKyslE1eTBp0B5KvN5dn3+X4S
         V+mmk3gMnasgjpl6vXsqu6SDRI2zHeVr0wo0WfCJsTXFB4BvDYqGAmssA/Ji1OsvAUzP
         XX1hkkAVUyTjMn//CxcsUlF4qZSCjeUNwC6oaXCUqtm8lizY8h6j5Yt+Ezv0SOkgJOuv
         qsIEV+PkBuDHCjtcz97C3MD0OTyijjhYpm/zER0djNgTMXEyevE8qX1PegokVauFoW4L
         slrrrzsKF6IPqVlwq5iTqz6zx7pckMR9rYvv1BM4tsgCZF2I72T+1RRJQEPoCQvWoECu
         u6vQ==
X-Gm-Message-State: AOAM532kPAQcToAZf8HS3/r60EmTE8RRyRZf+UCtU75JFtCGSPgI4KQn
        FkK3DLk+yvTv+57uqfJtZgCnNAZoJ/5qUtW1dqgVQ3I8
X-Google-Smtp-Source: ABdhPJy7YNMfn3KK7L8u9+bpqj/efUEYH9i5fE/CcMJa3KMafhlCGM+Rip3ELVnVImBiSFr8XF5x/7FCE/ewR/SBTfg=
X-Received: by 2002:aca:c704:: with SMTP id x4mr5546476oif.92.1590759811185;
 Fri, 29 May 2020 06:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200525154959.GB31281@cmadams.net>
In-Reply-To: <20200525154959.GB31281@cmadams.net>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 09:43:20 -0400
Message-ID: <CAEjxPJ544aeakd5FFXj-JPU-OS3RfRDbnEtaF3P7Nz3kuRPwFA@mail.gmail.com>
Subject: Re: Issue with fixfiles excludes
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 25, 2020 at 11:57 AM Chris Adams <linux@cmadams.net> wrote:
>
> After an SELinux policy update on Fedora 31 triggered a fixfiles that
> ran for hours and hours, I looked into why.  It turns out that I have
> BackupPC backing up to a different location (separate filesystem mounted
> under /srv), so fixfiles was going through millions and millions of
> files/directories.
>
> There's a hard-coded exclude list in fixfiles that includes
> /var/lib/BackupPC, which seems weird (why BackupPC and no other backup
> program?).  Also, there's support for a separate local exclude list -
> it's in the man page, but IMHO a little buried towards the end of a
> paragraph.
>
> My suggestion would be:
>
> - Make the exclude documentation separated in the man page to make it
>   stand out more.
>
> - Make the exclude file a exclude.d directory, so packages can drop in
>   exclusions (maybe /etc/selinux/fixfiles.d/*.exclude or the like).
>
> - Remove most/all of the hard-coded exclusions from the script and move
>   them to relevant packages; could maybe keep the virtual FS like /sys
>   and /proc in the script, but even put things like /mnt and /home in a
>   fixfiles.d/default.exclude so they could be overridden by local
>   policy.  Then if BackupPC should be excluded, the BackupPC package
>   would include the config (which would be a little more obvious to see
>   if you move its storage).
>
> Is there any upstream interest in this?  It would all be
> straight-forward to change - I can submit a patch if there's a
> reasonable chance it would be accepted.

This sounds reasonable.  However, these days libselinux
selinux_restorecon(3) which gets used internally by
setfiles/restorecon (which is what fixfiles executes to perform
relabeling) should be automatically excluding any filesystems that do
not support security labeling based on /proc/self/mounts and the
seclabel option.  Hence, manual exclude lists should only be necessary
for filesystem types that support security labeling by userspace
and/or for running setfiles/fixfiles when SELinux is disabled (e.g. to
label before first booting with SELinux enabled).
