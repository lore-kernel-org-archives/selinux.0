Return-Path: <SRS0=4oDv=3J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F57C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 12:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAD920678
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 12:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="e3jSJrCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgATMvy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:51:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40462 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATMvy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jan 2020 07:51:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id i23so23957520lfo.7
        for <selinux@vger.kernel.org>; Mon, 20 Jan 2020 04:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fGK30ptydnxrptyqZFAqNkrCG+MoVJR+T57pdWmCZs=;
        b=e3jSJrCLmRNA3qUc90AE2+9jFzm9WatyssWDYVJOn1VyoUNgbH/j3HiyXh9Xxp+zgM
         0wThJGl5Zrtj6OjPmYMjZTFypkPRmjlfpVNLqnK0F1XZw57SEyM0VEZaIZrdOb0DGqy7
         AAFc5PTHwNugC7v+/Lrh8+Pk3+gtXPx06Dmpl0cQ4lOqwbIRhQTMp1rQsnCm397l7dJr
         JpW6ZWsgnY+0rupyfd9tni3+4XeQ2vT5Wcdeukghv+cd7LGyHVYZ9e1I57aH50PPgPTF
         gMT83HMnq7zAL+qep1Mg6LipBKFrxj0xhk7x6/2LxfubQtIvI1bj05y6vZATJVXMJcu/
         wPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fGK30ptydnxrptyqZFAqNkrCG+MoVJR+T57pdWmCZs=;
        b=uDN8sdV9a2jJRLHeJoF3PVJhCTrKvYHylBXJEBnJJmEGH16UzWEqbrPMOwbkZCbl5C
         ilOg+oE9slfD10pG+osh1lUbYcIuFkIpjZ/V8a2PXmOsHU7DcSCHTuBAgokBIP//8Ilp
         ZUOmEw2Gk38XAxAxoKITrvoPsIUHtraxDxyLluuKRhfc11yTfAeBFzMuFo1OBiVD911E
         49MSd2X/ECbCCIVtX1vh0l3jVaJr8oUPuYMiwVA4mmRJt34GVwkWasijNnI1nmzuZMQU
         k30K2Ot12yBKXgrBl3zHSUFfLdivV5eC4l7vb5yV273SWTChiyiWeddGCteg4uPRumYa
         iaxg==
X-Gm-Message-State: APjAAAWSgFsH+A7Ni+ZIDCbNwOVNNarDBPKQP6QdCNSyIIV++2AoNqm7
        RwVOgX12tY5QCSepnj+vnVjP2aQrAZBIlSZIwXdS
X-Google-Smtp-Source: APXvYqy+MviKJW+xM9qrHe/2bYWina/IYQzooZaRS9jlXU7Iv8xddbUTZDJ3HM1C49ndzr2JQsoEwmspGc+gQmrldeo=
X-Received: by 2002:ac2:4946:: with SMTP id o6mr13606529lfi.170.1579524712147;
 Mon, 20 Jan 2020 04:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20200117202407.12344-1-sds@tycho.nsa.gov>
In-Reply-To: <20200117202407.12344-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Jan 2020 07:51:41 -0500
Message-ID: <CAHC9VhS+YxOEsfDRjiiwkT9PdAdFLigG-n7cyLHL1ykBQED-Hw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix regression introduced by move_mount(2) syscall
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 3:23 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> commit 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
> introduced a new move_mount(2) system call and a corresponding new LSM
> security_move_mount hook but did not implement this hook for any existing
> LSM.  This creates a regression for SELinux with respect to consistent
> checking of mounts; the existing selinux_mount hook checks mounton
> permission to the mount point path.  Provide a SELinux hook
> implementation for move_mount that applies this same check for
> consistency.  In the future we may wish to add a new move_mount
> filesystem permission and check as well, but this addresses
> the immediate regression.
>
> Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v2 drops the RFC prefix, changes the subject to make it more evident that
> this is a regression fix, and drops the TBD comment from the hook.
>
>  security/selinux/hooks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

This looks good to me too, thanks Stephen.  Because of the nature of
this fix, I'm going to merge this into next now, even though we are at
-rc7.  Since we are effectively treating this as another mount
operation, and reusing the file:mounton permission, I don't believe
there should be any widespread access denials on existing distros ...
I assume you've at least tested this on Fedora and everything looked
okay?

It also looks like the fs tests Richard is working on includes tests
for the move_mount() so I think we are covered as far as the
selinux-testsuite is concerned.

-- 
paul moore
www.paul-moore.com
