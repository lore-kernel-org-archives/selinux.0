Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA52C433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 03:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E9520714
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 03:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aq+MFU9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgHUDtL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgHUDtF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 23:49:05 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D644C061387
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 20:49:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s1so450918iot.10
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YD6EeTnsT2wy78rPM62cWU7iNSgM0HOqIQD7wF0JrbY=;
        b=Aq+MFU9KfwsZ6o2zwcEjbLvshHLnaZ6+vHTfx0cyGPVPvcdPDwWcejYGYyDqS3xjHG
         McomnkZUutkTmLbcxfQyj/9Da7L6YBAqC3T/66zupxF23Yvl/gjon8spfexymNQ7S1px
         iSStKpkFx0XXuhE79pL51BmzeTXHk+JpFXgaGli36qLoxMCyzzLpP0FZS+iNL5ZdUC2x
         xMnP0ex12um7i+J6B9RgoAtiZzv0bvjkzB5GaNC9TccJNFCnfnZMTsKBrSE5u+jdN7yI
         B4PsPDzSC31jiX+amsUT7YPuPBq+uS50qXN5DIZ+mHEs9kbz+ElK6ekebmV8mEMH6F5O
         R1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YD6EeTnsT2wy78rPM62cWU7iNSgM0HOqIQD7wF0JrbY=;
        b=VPr1HDoKy1Xs5zlT1VCZaWrdxr+QBOFsfhs5dtpVtmLGqVCCsp/lO8ipW81gBiu/8w
         kL3sCsMu6jXPwT4jki6Ewzprji/+f5y+kFeTX51/EQB0q9ZT9RLRXpiI2CzvrX+hbrT0
         CObDvjkpq3VsJZ3ZhFdoE+8vae5jWdfkjP9AhVPq6pMC1BEzE8Ki/8naENRKAfTGSOnE
         rTiZL2NVmn87G3qPx1vIQbb1S3XFXQrPSeU36C/TDS2K6IVZ0vEGd4Cf3xKZkvZFtGud
         kqyJw/FMv5vevJdi6JbwRjerwlP8VhrEv06cYscDetvtspjHBIw91NXFx6TqEsKovTDg
         mO2w==
X-Gm-Message-State: AOAM531XXBSPgS6Gt+aJYckZb+cGIUQZPsmWDQxieKFFK/JPN85dNCIK
        mA6OooSyChGgVUybjTdvCCLzuhAf70QZN9IFKxaBnQ==
X-Google-Smtp-Source: ABdhPJxsfUIfpYKTijmSzZMn/3bzl+PiJKaMjoCHFOVRg+kLNgbYqegwT2dpCaQupytAQ40v4lUIluDFJfph+PDjmzo=
X-Received: by 2002:a05:6602:45a:: with SMTP id e26mr880042iov.168.1597981744082;
 Thu, 20 Aug 2020 20:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200807224941.3440722-1-lokeshgidra@google.com> <alpine.LRH.2.21.2008210433591.29407@namei.org>
In-Reply-To: <alpine.LRH.2.21.2008210433591.29407@namei.org>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu, 20 Aug 2020 20:48:52 -0700
Message-ID: <CA+EESO5u89hEqgmBZMKq9njHvAKyWJJusVtkSLFHoQpv8rBzMg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] SELinux support for anonymous inodes and UFFD
To:     James Morris <jmorris@namei.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 20, 2020 at 11:36 AM James Morris <jmorris@namei.org> wrote:
>
> On Fri, 7 Aug 2020, Lokesh Gidra wrote:
>
> > Userfaultfd in unprivileged contexts could be potentially very
> > useful. We'd like to harden userfaultfd to make such unprivileged use
> > less risky. This patch series allows SELinux to manage userfaultfd
> > file descriptors and in the future, other kinds of
> > anonymous-inode-based file descriptor.  SELinux policy authors can
> > apply policy types to anonymous inodes by providing name-based
> > transition rules keyed off the anonymous inode internal name (
> > "[userfaultfd]" in the case of userfaultfd(2) file descriptors) and
> > applying policy to the new SIDs thus produced.
>
> Can you expand more on why this would be useful, e.g. use-cases?
>
With SELinux managed userfaultfd file descriptors, an administrator
can control creation and movement of them. In particular, handling of
a userfaultfd descriptor by a different process is essentially a
ptrace access into the process, without any of the
corresponding security_ptrace_access_check() checks. For privacy, the
admin may want to deny such accesses,
which is possible with SELinux support.

I'll add this use case in the cover letter too in the next version.
