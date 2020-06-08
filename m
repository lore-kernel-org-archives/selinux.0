Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E1FC433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 02:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B6B2075A
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 02:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma1LGDHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgFHCKB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 7 Jun 2020 22:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgFHCKB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Jun 2020 22:10:01 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D65C08C5C3;
        Sun,  7 Jun 2020 19:09:59 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n6so3060072otl.0;
        Sun, 07 Jun 2020 19:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGfIVEEObayEQ8qL7hEZY++qwOcPSMpFns1BIw6npEs=;
        b=ma1LGDHvnbGHopULdudmm4/ulC9DKtWolC+sKArlDnN16fc4VyrdbAIE7u4hGQLt6A
         t+uEiBgoztuGeomxb5p7mVQW525mMGI2G86zSDdS10J0g1VHWmluvE+q04wGbo5EbaPN
         LQlpF3iuyCj7DBYVzGGYWuthrKT0jozXf2cFpTDykuT+mgvpgLBROlPOfY2o2hhxhbwT
         jhEKYKZ8uGnZDnQkiuKkXeXTvMlTafUjG7D+1Y0+Obkb1Xisil4aqxyMpHICYyFB3uhc
         ChNFAwnbziN+0ni4qPWG2o2+e13L06/pE689t0XsIwIPq3lSDEI5+Zw8/QYlWw26PEC6
         J8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGfIVEEObayEQ8qL7hEZY++qwOcPSMpFns1BIw6npEs=;
        b=b0ApwUxGyok8IsDszx/Y+Z1Pjom579EfdC+xXdkobJlo1GzKpL+aEr1Fk43AJStImK
         dhtTwySB9YhSMuvEbjL2DJtvxXTpd1eYnR7TmMkgYHx2Et5qF+DSAaTgps8cuj3+ijFq
         HN0DRmsrXUtnaD0hlOZuhZz8gfuxaHC6sse2khBIEs/haxZpAO3AQW6wLs+MEXHFj58Z
         GNEnZfwySQ2VQEo5OcyExCNmk08bkklKouO4da+cb4xWJgNIXBFioy0ArRTl8mh5Fc2+
         7/B/RO18JxkRcp52xwi16FmATn0ddJA5WrPtPfvX7V4G83Jfdl7WF6PKgaqvRDnfev5Z
         Zs7g==
X-Gm-Message-State: AOAM53146BOB9m4tKnh3Kh9yVkWc1xYmuSZgAPJOSj6dlfWfRYaAfFWe
        UC+U+cNAQ2p1nfHOcPMCuXBL1wubhdIkkIEzuqA=
X-Google-Smtp-Source: ABdhPJyPUztCLOK3ba7poCLnBp3nJ6rBJKfGsAMA5y6qITgE16Vy5DHZKBdca5046sg+z0NnE4pY23Zb0GIux0HTK2Q=
X-Received: by 2002:a9d:554d:: with SMTP id h13mr4530942oti.201.1591582198714;
 Sun, 07 Jun 2020 19:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200522055350.806609-1-areber@redhat.com> <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
 <20200525080541.GF104922@dcbz.redhat.com> <877dwybxvi.fsf@x220.int.ebiederm.org>
 <20200527141403.GC250149@dcbz.redhat.com> <20200527152955.jbbipgb6icb4nwgv@wittgenstein>
 <d5ecde0c94014a4fad090e44377e9852@EXMBDFT11.ad.twosigma.com> <20200528094839.gw7aqd3xs3kix273@wittgenstein>
In-Reply-To: <20200528094839.gw7aqd3xs3kix273@wittgenstein>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Sun, 7 Jun 2020 19:09:47 -0700
Message-ID: <CANaxB-zb9xSxkP+AThVUA_gxU2AOKhj=vOcFdquTjQpxH_J1og@mail.gmail.com>
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Adrian Reber <areber@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> >
> > I would argue that setting the current process exe file check should just be reduced to a "can you ptrace a children" check.
> > Here's why: any process can masquerade into another executable with ptrace.
> > One can fork a child, ptrace it, have the child execve("target_exe"), then replace its memory content with an arbitrary program.
>
> Then it should probably be relaxed to CAP_SYS_PTRACE in the user
> namespace and not CAP_CHECKPOINT_RESTORE. (But apparently you also have
> a way of achieving what you want anyway. Imho, it's not necessarily
> wrong to require a bit more work when you want something like fully
> unprivileged c/r that's a rather special interest group.)
>
> > With CRIU's libcompel parasite mechanism (https://criu.org/Compel) this is fairly easy to implement.
> > In fact, we could modify CRIU to do just that (but with a fair amount of efforts due to the way CRIU is written),
> > and not rely on being able to SET_MM_EXE_FILE via prctl(). In turn, that would give an easy way to masquerade any process
> > into another one, provided that one can ptrace a child.
> >

I think you misunderstand this. In the case of malicious processes,
when only one or two processes must be hidden, they can use this trick
with execve+ptrace and this is relatively simple. But in the case of
CRIU, where we need to restore a process tree with cow memory
mappings, shared mappings, file descriptors and etc, this trick with
execve+ptrace doesn't work at all. We are in a weird situation when
malicious processes can do some operations, but useful tools like CRIU
needed to be running with extra capabilities that actually reduces the
security of the entire system.
