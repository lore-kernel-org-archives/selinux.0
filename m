Return-Path: <SRS0=qhvK=DJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732F9C47423
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8B22065D
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 14:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUFS6qop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgJBOuR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388231AbgJBOuE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Oct 2020 10:50:04 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4553CC0613D0
        for <selinux@vger.kernel.org>; Fri,  2 Oct 2020 07:50:04 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id t3so398269ook.8
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2020 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48Q3MexAe8iryH+ZBQV6QGuL49fm0bwVXJA7s8wsFZM=;
        b=vUFS6qopaRmxX/XkCYmiXY5D27N2+vI2l6QwZsO8jR3mOk/Rh9rruEpW+nM7NtJOsr
         nzCvlrN/BGL148HppELHNF2LCsm0CgU/N/kd3NjzW3xGGOnLied3Caq2BLwvUrM+07pt
         Wu6f/KVQoz6EkbD4fchLH0ljHjlIpF+CdjO5fbc5QGsVECxf6+lWndNynf+F7J1GXb1q
         EIWPCmdDaga7zZUrBsghzQAAOUtUiABkkyh88UPKL82sgM7VX9r7IbEo5/g4+1t1rmzD
         dD+XxBLlJEBbQOUgItwpocgRhIao7xG+ysOnaTZ//4GUnyeoF6mxYfo6qKioMw2kSaVO
         jamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48Q3MexAe8iryH+ZBQV6QGuL49fm0bwVXJA7s8wsFZM=;
        b=Y2lJ1MCOt66MYl9MwNuWbPvWfv9TcGEv5zH8/NwLrkOeFZEodsip9pXeWm8CV7gr/Y
         7TDjle7Z0Ld0QfGAtBYh5rideYrkgBpTBE+aZp94yuk2xOlOIIMBH6CUBnkBhQ2Ygja9
         P/6dYj+PirLj81rNKEZeDLOfRLC+cpVEsMPMXqZPnsLstQLIUx2f72UQ09Waj1myQgd2
         6750rl3nrNz4O8NWIOhI5kHVHvN127Rggq+G0QYj6suKc4v26bO52tlSRW6LRyJ0RAd4
         XtLHn/Ps+uOP5g/zls6cEIUB+a7EwW1W0xv7R9QDm8iijf8uKRxi5CwjmcMPU6aQuRVp
         Pqkw==
X-Gm-Message-State: AOAM533VzREAsEnAcuDngzFM1GdwVSoToBkvjgmQmiOUWJUmipdcdvKh
        IWWVii6pKB9HkGJoPrCvvWb8D4k/pwvtCu4l/7pF7iGW7xk=
X-Google-Smtp-Source: ABdhPJzp0I+AxHK6ZCgzc1H9yPMgHPK1dlIy52YNiqO5M1kaoF+lQ+sIRjS+wEgb+bWP0QcjiyEtbtsn1BA49eyJNPM=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr2172491ooq.13.1601650203645;
 Fri, 02 Oct 2020 07:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200930145031.910190-1-plautrba@redhat.com> <20200930145031.910190-4-plautrba@redhat.com>
 <CAEjxPJ6PHe7DqYh6mLGu+mjMLY43r4tbQzoiXH0=wgSuyVSpcw@mail.gmail.com>
 <20200930155614.GA864960@fedora.redhat.com> <CAEjxPJ41ryHsDCnpX7qRLJNw5t=vYX_UEb1z=kW91O10Je6nDA@mail.gmail.com>
 <20201001165551.GA33342@localhost.localdomain> <CAEjxPJ7tsyBGm2hqiABF=HeJvX6PfWdT5BSn+L4-miqsqexo+A@mail.gmail.com>
 <20201001174837.GB33342@localhost.localdomain> <CAJfZ7=ksiWidL58wj2=qjvq4sWW9uxi-mF+YdZf_niuf8KHDBQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=ksiWidL58wj2=qjvq4sWW9uxi-mF+YdZf_niuf8KHDBQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 2 Oct 2020 10:49:17 -0400
Message-ID: <CAEjxPJ4cca3sMyWv=ZeWGc62vt-=s+WhWFW0Y2g7nQeOX21C3g@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 2, 2020 at 2:53 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Hello,
> I have another question: why is bumping the .so version needed? As we
> are not changing the ABI of a "linked symbol" (thanks to using
> versioned symbols, with .map files), if we do not bump the .so
> version, programs that were built with libsepol.so from years ago will
> just stop working due to missing symbols, with an error message which
> will be quite clear (and this only if they were using deprecated
> symbols). In my humble opinion, bumping the .so version is most
> required when the calling convention of a non-versioned symbol
> changes, but this leads to unexpected execution paths.
>
> Nevertheless I did not spend time to search for a document that would
> explain why bumping the .so version would be recommended when removing
> symbols. If you know one, could you please add a reference to it in
> the commit description ("Following guidelines from https://...) and/or
> to some documentation?
>
> >From a "distro maintainer point of view" (for Arch Linux), having just
> spent a considerable amount of time due to breaking changes in the
> last release of PAM, I am not eager to spend time dealing with finding
> clever ways to smoothly upgrade the system if there is no
> easy&straightforward way to do this. Introducing a transition package
> for each library which is bumped is acceptable to me, but if the
> release after the next one bumps the version again, introducing
> another set of transition packages will begin to be quite painful. In
> short: I agree to remove the deprecated functions in order to "bump
> the .so version only once", as suggested.

My original understanding of library ABI compat requirements came from
Ulrich Drepper's paper,
https://www.akkadia.org/drepper/dsohowto.pdf

Looks like Debian's policy is here:
https://www.debian.org/doc/debian-policy/ch-sharedlibs.html#run-time-shared-libraries

IIUC, if we follow the rules laid out by both, removing an old symbol
version entirely is incompatible and requires a SONAME change.  That
said, commit c3f9492d7ff05bdc8581817655ad05bc1e1174b8 ("selinux:
Remove legacy local boolean and user code") was technically an
incompatible change; it left the symbols in place but made them always
fail or ignore no-longer-used parameters, which isn't truly
compatible, and we didn't change the SONAMEs then.

I'd personally be ok with not changing the SONAME as long as these
interfaces were only ever used by the selinux userspace code itself or
only by really ancient code that is no longer in use by any supported
distribution but I don't think that flies with e.g. the Debian policy.
