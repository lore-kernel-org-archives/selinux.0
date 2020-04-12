Return-Path: <SRS0=FN9z=54=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56128C2BB55
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 17:35:24 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245A420708
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 17:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1KPVpPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245A420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgDLRfW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgDLRfV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Apr 2020 13:35:21 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB1DC0A3BF0
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 10:35:21 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id i75so6627774ild.13
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jh3fzj3UXhyV16x3ts4kS3oHN/lMgc1G9n9nVrSChQM=;
        b=X1KPVpPVZNr7mlpUT4Hois2O+fyP+FOtVkV4U8qX3RMJa7ksc9JNNPcmujpiPPO07W
         QltXM2lhIkzbrfRVl/VhsfycgZW9Tn1O5TPeotGODNc16uQUCRLrDTRDF1am8NoXK+6B
         7UxIFL5iNR59fY//6rRMGaV3IepMzerULlILFOlHWrB3V04DOU4ACo+cQGCs0VFS/jIG
         rIQQpWGpRWnd+lllFYNqB4W2xGUo5XXPWhcBVVBWrRNw8IKxmyABNXthACdnfmGJnSrA
         sR7H9mos/HLu3Wt4w/iQuq4wXfodyAW85c6K8MtoZFfuFatC5Oygoqr8mzoWoQneUjtp
         t5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jh3fzj3UXhyV16x3ts4kS3oHN/lMgc1G9n9nVrSChQM=;
        b=lAeKAJTzEdgdViLlEdYh+gZNWdbtMkaCLvlQZ176JFGLte1qzUilGkyjuSgzBaLpjv
         Aqoc4MWxvzXJgon0v43VabnGH3X7bFlofIH+jKQL7mjO6S9+q2QxK9eT8gsaDnOkDL50
         dOUGpBvuxHaBUwMltKxIJ52cEAy+XCHM1Hx9j26k5AR36pZh6VbllZpwAWMzvbViXNfc
         v0418vw8G5Kwfbq9DWzZFo00u6HREe+/0CHKTA0Ik57Wz8CcHYPSIF7eyaI5AOYV0DuB
         GppUf73wh3xhgs++mvYAFFMRwBf9QL6SNCJUbeFXNSxCo71Urd2/7194x2uSm25ZoauU
         CuPQ==
X-Gm-Message-State: AGi0PubrCc0Hba2qDjHjsoKJuoKH96oyKbO0LbD09glIMux8tUGlvu/M
        oQEqm+fzGIIAUxMIMDKVGUnvsbp9w7NmqTruwGN6KXWi
X-Google-Smtp-Source: APiQypIvbrE2Ilm4fpq5OBZMzxn2zgw/eQxC8kpu9V6osbCDvD0QKFD+hWmVszYeXnmIfN8POka/Ds4+eEFDa0/gLag=
X-Received: by 2002:a05:6e02:c62:: with SMTP id f2mr11540126ilj.163.1586712920393;
 Sun, 12 Apr 2020 10:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7=k9UsVjai1ZaBQUquQv6X3B-RkPGL4PikhtLyNGiGOnJQ@mail.gmail.com>
 <CAFftDdohqX3vdg=VCSEu_1BQhOUv0ry0vRYtchAFecYZOPK-qQ@mail.gmail.com>
In-Reply-To: <CAFftDdohqX3vdg=VCSEu_1BQhOUv0ry0vRYtchAFecYZOPK-qQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 12 Apr 2020 12:35:07 -0500
Message-ID: <CAFftDdrh65aF5u__w_6u8sFV+3Prij6AfuQryKGc1=XsFDDmJQ@mail.gmail.com>
Subject: Re: Duplicate versions of libsemanage symbols
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 12, 2020 at 11:45 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Sun, Apr 12, 2020 at 11:27 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Hello,
> > Since recent changes in libsemanage.so's linker script, I have been
> > experiencing issues. As I encountered these issues only when I was
> > using a build configuration which is slightly different from what is
> > in the repository, I wanted to spend time to investigate what was
> > going on before eventually submitting a proper bug report.
> > The issue I see is the following: when I compile with the gold linker
> > and a custom set of build options, linking libsemanage.so fails with
> > [1]:
> >
> > /usr/bin/ld.gold: warning: using 'LIBSEMANAGE_1.0' as version for
> > 'semanage_get_hll_compiler_path' which is also named in version
> > 'LIBSEMANAGE_1.1' in script
> > /usr/bin/ld.gold: warning: using 'LIBSEMANAGE_1.0' as version for
> > 'semanage_get_ignore_module_cache' which is also named in version
> > 'LIBSEMANAGE_1.1' in script
> > /usr/bin/ld.gold: warning: using 'LIBSEMANAGE_1.0' as version for
> > 'semanage_set_ignore_module_cache' which is also named in version
> > 'LIBSEMANAGE_1.1' in script
> > ...
>
> Does it actually fail or just print these warnings? IIRC, @sds replied with some
> superfluous linking warnings, but we ignored them. I tried looking
> through my mail
> and the archive but I couldn't find it.
>
> >
> > Looking back at a normal build of current git master (that succeeded),
> > I indeed have:
> >
> > $ objdump -T libsemanage/src/libsemanage.so | grep
> > semanage_get_hll_compiler_path
> > 000000000001b9b0 g    DF .text 000000000000021c  LIBSEMANAGE_1.0
> > semanage_get_hll_compiler_path
> >
> > The same command on libsemanage 3.0 (last release) gives:
> >
> > $ objdump -T /usr/lib/libsemanage.so | grep semanage_get_hll_compiler_path
> > 000000000001a3c0 g    DF .text 0000000000000224  LIBSEMANAGE_1.1
> > semanage_get_hll_compiler_path
> >
> > In short, semanage_get_hll_compiler_path is defined twice in
> > libsemanage/src/libsemanage.map [2] and the linker only provides the
> > first one. In fact, libsemanage.so built from git master has currently
> > only 2 functions in LIBSEMANAGE_1.1:
> >
> > $ objdump -T libsemanage/src/libsemanage.so | grep LIBSEMANAGE_1.1
> > 000000000001e1f0 g    DF .text 000000000000010d  LIBSEMANAGE_1.1
> > semanage_module_install
> > 000000000001eea0 g    DF .text 000000000000011f  LIBSEMANAGE_1.1
> > semanage_module_get_enabled
> >
> > These functions changed their API between versions 1.0 and 1.1, so
> > this is normal (there are .symver macros in the code and they work
> > properly). The issue is that all the other symbols went into
> > LIBSEMANAGE_1.0 instead of LIBSEMANAGE_1.1. Is this a bug or did I
> > misunderstand something? Should the duplicated functions be removed
> > from LIBSEMANAGE_1.0 in libsemanage.map?
>
> objdump -T is probably a better way to do this than what I had with
> readelf, as it shows the version.
>
> Let me roll a patch, I probably have to go through the others as well.
>
> >
> > Thanks,
> > Nicolas
> >
> > [1] https://travis-ci.org/github/fishilico/selinux/jobs/674002033#L2471
> > [2] https://github.com/SELinuxProject/selinux/blob/aa40067b7b86d5e4c951fccae1aa98baff148613/libsemanage/src/libsemanage.map
> >

FYI the other 2 projects I touched with these changes seem to check out:
 - libselinux checks out ok (it went from base to LIBSELINUX_1.0)
(a41dfeb55d vs current master)
 - libsepol identical (f8c110c8a6 vs current master)
