Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746D0C433E6
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 23:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4475964E42
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 23:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhBKX3P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Feb 2021 18:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBKX3M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Feb 2021 18:29:12 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB729C061574
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 15:28:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bl23so12735014ejb.5
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 15:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZS/Kb4C0pmzvsqhMC2Ou+1Mu1lc/Bk7sljYJuO8Ll2w=;
        b=SX5PQG4/TxfGT8wYPOCEV4aXq9/ofAAsZMVMb2zXa6KzsqLTHFy9tk7ZfWyG/lbBMb
         ByfxPMXyH8vbbXKAZAa/+HBdV/lJmzYMOCxpt0i+DieCiBUCMPaG17u+0oUqpQoUceJx
         WH3JwHtylDgKuzSLsWSrEQLjKyf8iSrQQpxLgb3kKsTMOAXkIWtDyvyeatTcWGXFnB5d
         jcJKrijOoYejTBI1i1yKUOBx0ZB+CbgJ8dQXD3QCMxx1jzmQm9TxQvz1y7Al1IHuCKMS
         jn252ISvt4tlUMYr4ZMumbSTx5ro5K2/9IFBBE8iyAOr8SViLpPWhRfq5sv1x6RTylLe
         TYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZS/Kb4C0pmzvsqhMC2Ou+1Mu1lc/Bk7sljYJuO8Ll2w=;
        b=Ih5qhR2JbewyOqacVLJnrVwqm8wZ9oNrBQEZkdweimr96ERF7rLMGa3dBUq6mUk9Ke
         fVEkbOWlJ0/BUstX0smxSsYbPCir98VHL2HzxpNhB0PwbkIRaM4pTi01WcWOKFXlH55F
         Qnzz0QrsMwhe1AlgkZelSDai3m6+7jMlzwl+D7ntH9h5YKZWCM5+YJWi06HkjofLMMpK
         QKWbL90Ba/6bEe7SVaUS5ffb/l1TFv3ouo7jquaMQV74xBam8d7W06SuZbPkyMUThJ9l
         AKLxPxogoAPudJI+ydKZ2egtWQfpTbxeUMBX2krw2uMlmNPYPzz+fhGg8pr533WQWWu4
         tyjg==
X-Gm-Message-State: AOAM5314kWi8+kCdVa1qRzFL+KFnOkkFGhkwBlGZBChyFMyImlaimhEk
        rRCHDFqVFF/YgQENl2j64XOaoo1CG/EZXrnbcnFR
X-Google-Smtp-Source: ABdhPJyxPMR/IJw7yRDaz9hLSEwtwXj4pCxq52IrPU924l0yN/rZsCs+2HB5gkY9WMU4SXfZgK/Fu/CK1h1aMv7BQQY=
X-Received: by 2002:a17:906:1199:: with SMTP id n25mr62722eja.431.1613086110571;
 Thu, 11 Feb 2021 15:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20210211180303.GE5014@redhat.com> <CAHC9VhRM6MiF1m2aFpLJKb3CFWXcXEX_SY=EnkLaq7U_X2UTZw@mail.gmail.com>
 <bb7b8304-b0fe-f6a3-b1fa-c06193f9cc02@redhat.com>
In-Reply-To: <bb7b8304-b0fe-f6a3-b1fa-c06193f9cc02@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 11 Feb 2021 18:28:19 -0500
Message-ID: <CAHC9VhS_+VT5cSXg+msEajnMYNjegKfubLO0EggaSr2p+JfSuA@mail.gmail.com>
Subject: Re: [PATCH][v2] selinux: Allow context mounts for unpriviliged overlayfs
To:     Dan Walsh <dwalsh@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, selinux@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 11, 2021 at 5:41 PM Daniel Walsh <dwalsh@redhat.com> wrote:
> On 2/11/21 16:24, Paul Moore wrote:
> > On Thu, Feb 11, 2021 at 1:03 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >> Now overlayfs allow unpriviliged mounts. That is root inside a non-init
> >> user namespace can mount overlayfs. This is being added in 5.11 kernel.
> >>
> >> Giuseppe tried to mount overlayfs with option "context" and it failed
> >> with error -EACCESS.
> >>
> >> $ su test
> >> $ unshare -rm
> >> $ mkdir -p lower upper work merged
> >> $ mount -t overlay -o lowerdir=lower,workdir=work,upperdir=upper,userxattr,context='system_u:object_r:container_file_t:s0' none merged
> >>
> >> This fails with -EACCESS. It works if option "-o context" is not specified.
> >>
> >> Little debugging showed that selinux_set_mnt_opts() returns -EACCESS.
> >>
> >> So this patch adds "overlay" to the list, where it is fine to specific
> >> context from non init_user_ns.
> >>
> >> v2: Fixed commit message to reflect that unpriveleged overlayfs mount is
> >>      being added in 5.11 and not in 5.10 kernel.
> >>
> >> Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
> >> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> >> ---
> >>   security/selinux/hooks.c |    3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> > Thanks Vivek, once the merge window closes I'll merge this into
> > selinux/next and send a note to this thread.
>
> In order for us to take advantage of rootless overlay we need this
> feature ASAP.

It will get merged into selinux/next *after* this upcoming merge
window.  I'm sorry, but -rc7 is just too late for new functionality;
kernel changes need to soak before hitting Linus' tree and with the
merge window opening in about three days that simply isn't enough
time.  Come on Dan, even you have to know that ...

-- 
paul moore
www.paul-moore.com
