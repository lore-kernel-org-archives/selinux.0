Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100F6C38A24
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF5020736
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 14:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbM+Y7k3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgEGOyy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 10:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725969AbgEGOyy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 10:54:54 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22234C05BD43
        for <selinux@vger.kernel.org>; Thu,  7 May 2020 07:54:54 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t199so5401509oif.7
        for <selinux@vger.kernel.org>; Thu, 07 May 2020 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mb+jvqTPMEqdiUk9VbpZpic6kUskzCUoYUrma8hQ6zY=;
        b=gbM+Y7k3XEP899cXxbjbBgtfHdcUB448IoMp++Qf923bKiG8weEf0vm6GeuCXC4EXl
         xRmAVygnTGVIdW2FrQFuNCzwMi3yDatJ2Cau7r6TL3vTWVTn8npb9+60zGWKfRgHFKpc
         0pX4xLYNFRtqL/I3Oac7F03Enzx4JNEq1FCopx9slkAy8u5vOlQ+H8ll8S0LyuOFwsEI
         S1Sy8vouDbwlu864snQwVHSXv1J3eoDdATGQWd7yszqx/Nt2YBI5uJTukPxlPXsUIAyN
         qQhWBdpwyNf//lkTkdmYytuaYtPI7VYqs18u4nydp5bCjTNvgyM1XvWtX7t6PgsXQ4pC
         ecjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mb+jvqTPMEqdiUk9VbpZpic6kUskzCUoYUrma8hQ6zY=;
        b=F6IA1Vv30D4b9Xyel/ENUk2cV7j4wAp5gooAyIoOwMP3e48NJ4Zi14JnlP52m9waCz
         NUcKAZZTaLT8oMYAzmo0ZBl9Qlb4nHz9LDr7zmZIdBdB/DcTHSLQUYLEd26KpSc40q0h
         xjRNnTfnvY4TMEyPgFl1ZUxV0eDyoOUVG7QYGVs7gDHGZw0fqshiLTTdXOw/mmcYUVS+
         AJwA4FG7IxfFSKIdHL1D42gD6Zl7XonEU8Vg34pMjLZeP0wJF1LkyzfMgKqiRQZmymyL
         v6zRlbgFULivBAJvLk7pR7ufCWl7QwdSPvQnMyj+I32r4djDK0CVz93d2oveqStfiqsp
         0UqQ==
X-Gm-Message-State: AGi0PuY2T1HNS56ywkAoA8eSLFWNy1cjHij8PhqpKm9+3Rim32/GLz6W
        Mkr0EOeVgTjv+yVAuPgsSlSRjmxIYZoUNt+OKow=
X-Google-Smtp-Source: APiQypLg2UUCIxMjMP4R1wnJh9tErkSB3DKYNAMgMMOMdH/rKYfkJ8OT+Jwb3HAePCtpDHMc4apeySmvjauluuuowZs=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr6886885oib.140.1588863293357;
 Thu, 07 May 2020 07:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org> <1916523.qzzCliNl98@liv>
In-Reply-To: <1916523.qzzCliNl98@liv>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 7 May 2020 10:54:42 -0400
Message-ID: <CAEjxPJ7oXd5EM_hB1tdRKZKLKZoeOh_w8UYevivMC5d1D2G1+w@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Russell Coker <russell@coker.com.au>
Cc:     Laurent Bigonville <bigon@debian.org>,
        William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 7, 2020 at 10:49 AM Russell Coker <russell@coker.com.au> wrote:
>
> On Thursday, 7 May 2020 6:35:11 PM AEST Laurent Bigonville wrote:
> > If people are using preseed installations (kickstart equivalent), I
> > think that enabling SELinux in the installer shouldn't be too difficult
> > (installing the needed packages, modifying the files and relabeling with
> > fixfiles). It's obviously not user friendly, but the question is what's
> > the target here.
>
> If we want to do that properly then I guess we want SE Linux enabled in the
> kernel that the installer uses and then have the policy installed early in the
> installation so the files can have the correct labels from the start instead of
> having a relabel process afterwards.

That would be good but might be overreach for Debian since SELinux is
not the default there.  It isn't strictly necessary; ever since we
went to using extended attributes for file labels, you can set them on
a non-SELinux-enabled kernel, so the installer can always set them
even if its kernel doesn't enable SELinux.  Optimally they would be
set by the package manager based on file_contexts; that is what rpm
does in Fedora/RHEL.  Or you can always run setfiles after package
installation but before rebooting into the SELinux-enabled kernel.
You don't need to defer labeling until you have SELinux enabled.
