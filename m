Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A68C27C76
	for <selinux@archiver.kernel.org>; Wed, 25 Jan 2023 15:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjAYPfA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Jan 2023 10:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjAYPeu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Jan 2023 10:34:50 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15144367E2
        for <selinux@vger.kernel.org>; Wed, 25 Jan 2023 07:34:46 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n2so311962pfo.3
        for <selinux@vger.kernel.org>; Wed, 25 Jan 2023 07:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6hoV59cG+dZxPH2t8Rd/qNEp0CEA3/5G+e0nmm80vnI=;
        b=oPsKpgYDhmFMbYwzPpjHMK4gg/aiQwG6rkEMbtwAej8T9AwTQxfI83RKFK4xMSQJMc
         WUST1cNNdIlj6EU+mAMrzPXI54N+Y5RD5YXI7SNC/tqsWRX2jYGnFI8swiPbZ83z27pF
         sD2xGYN1aDsF5FwUnaseB6kc01JOE1CEUD4Rpzk79vXIZug7lGKn3eislO7plq/WnKcL
         GZmvMaboo2sFVQ+KCydpH5F62ulrA8O/3c86iq2TRpO88VcNSiK40ga0aEigE/AvmBf/
         gZeRq0KpRRozss0DBkvlb9zO0u5A+Fi9e0dAxpuWLNRpwC2LAi1AkMWViG74EmK4Xfm7
         o6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hoV59cG+dZxPH2t8Rd/qNEp0CEA3/5G+e0nmm80vnI=;
        b=lv1WqDJzeXBBxLUjGiQXeJZCcB+FFZS2PYF+GeJXYPx+N/oPlz3LwYgdkX6gTwZbQ3
         0ShwzdYd7zaXCWuLdOA65GJJvBLXK660+jQX35sQZRsQfa4N8WdsSMspaFyBVxwoWSDs
         AKVFDKdZgpyDFPb6vvLkOguf6AUws5yll0oX/mVq+Wz9rue9KVsWMSMk+9fKtX7T4LSs
         13J6PMMv8MuQEBUjjWuTOs9zc99pahcLrwL3lNygy1HY1C36EN9p67bCdx0gL7S0j2df
         PuUFft3C46r+JoJ8xrX9j7qr1YYwmgPB03ofmm77c9mrT8Va+ybOZNUN65kLhvWmQ4jt
         D/Aw==
X-Gm-Message-State: AFqh2krvtAXsDQZzeNBqrzjHB3kF8wjHIYjarJZDD9WYScvGbeIwy/t8
        GD7FN/6PsuxZL6h078E3bBoEE7dEZfQuRqBb2KChPDKk
X-Google-Smtp-Source: AMrXdXuF/P9MRoM/aaWXR3RWRPRT3j1KP4MdLVQSAWMlVWo5KEeklMeQCZPxst0GaT/F23ii6hVTkIzg4dsOQSamP84=
X-Received: by 2002:a62:ae10:0:b0:580:9b0b:4fde with SMTP id
 q16-20020a62ae10000000b005809b0b4fdemr3984093pff.49.1674660885506; Wed, 25
 Jan 2023 07:34:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhS1tSbP8s4QzVPB42O6_3wGX47=9HXBSyqwnHrW47965w@mail.gmail.com>
 <CAFqZXNvAsNBjACaoaH48wDEgKV-aKM1G9dwuozfhYvYmwCNcyQ@mail.gmail.com>
 <CAEjxPJ5VV3nXSW+AtiXkbUbJJUhsz0hFQz++aqP=LK1PicQq4Q@mail.gmail.com> <CAFqZXNtgOq8Bk_w7hBp0KrSb5FSzOnLebHTVCXNRH4WMnh_LgA@mail.gmail.com>
In-Reply-To: <CAFqZXNtgOq8Bk_w7hBp0KrSb5FSzOnLebHTVCXNRH4WMnh_LgA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 25 Jan 2023 10:34:34 -0500
Message-ID: <CAEjxPJ5ixsuqJWikfYgUw4m0PKkWww_f=f+vkwbkmGnCiPbQrA@mail.gmail.com>
Subject: Re: selinux-testsuite broken pipe noise
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 25, 2023 at 8:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Jan 25, 2023 at 12:50 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Jan 25, 2023, 4:29 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >>
> >> On Tue, Jan 24, 2023 at 8:39 PM Paul Moore <paul@paul-moore.com> wrote:
> >> > When running the selinux-testsuite manually today I noticed the
> >> > following noise in the filesystem tests:
> >> >
> >> > % make test
> >> > ...
> >> > chmod +x */test
> >> > chcon -R -t test_file_t .
> >> > Running as user root with context unconfined_u:unconfined_r:unconfined_t
> >> >
> >> > domain_trans/test ........... ok
> >> > entrypoint/test ............. ok
> >> > ...
> >> > perf_event/test ............. ok
> >> > filesystem/ext4/test ........ 1/76 yes: standard output: Broken pipe
> >> > yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ 14/76 yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ 20/76 yes: standard output: Broken pipe
> >> > yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ 22/76 yes: standard output: Broken pipe
> >> > yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ 24/76 yes: standard output: Broken pipe
> >> > yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ 30/76 yes: standard output: Broken pipe
> >> > yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ 34/76 yes: standard output: Broken pipe
> >> > yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ 40/76 yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ 43/76 yes: standard output: Broken pipe
> >> > yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ 49/76 yes: standard output: Broken pipe
> >> > yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ 55/76 yes: standard output: Broken pipe
> >> > yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ 64/76 yes: standard output: Broken pipe
> >> > filesystem/ext4/test ........ ok
> >> >
> >> > The test system was an updated Rawhide system with the following details:
> >> >
> >> > % uname -r
> >> > 6.2.0-0.rc5.20230123git2475bf02.38.1.secnext.fc38.x86_64
> >> > % rpm -q selinux-policy
> >> > selinux-policy-38.5-1.fc38.noarch
> >> >
> >> > ... and my selinux-testsuite build should be current:
> >> >
> >> > % git log --oneline | head -n 1
> >> > 2cc067f ci: limit VM reboot time to 5 minutes
> >>
> >> Yep, some change in Rawhide seems to have triggered this... The most
> >> straightforward solution seems to be to just silence the errors. As it
> >> is a trivial change, I have pushed it to the master branch:
> >>
> >> https://github.com/SELinuxProject/selinux-testsuite/commit/909f3aea627300a7e5ad2bc724d12c3560d34515
> >
> >
> > Are there any new denials audited, possibly requiring semodule -DB to make visible? Wondering if we are denying access to the inherited pipe fd and closing it? Denial would be on fd use or fifo file read/write.
>
> I did check now and there were no such denials. Most likely this has
> nothing to do with SELinux and it's just mkfs closing stdin before it
> exits or something like that.

Got it, thank you for checking!
