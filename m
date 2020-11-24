Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EEFC2D0E4
	for <selinux@archiver.kernel.org>; Tue, 24 Nov 2020 20:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2AB220715
	for <selinux@archiver.kernel.org>; Tue, 24 Nov 2020 20:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7BMAGu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbgKXUop (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731289AbgKXUoo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Nov 2020 15:44:44 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3824BC061A4E
        for <selinux@vger.kernel.org>; Tue, 24 Nov 2020 12:44:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id k1so171021eds.13
        for <selinux@vger.kernel.org>; Tue, 24 Nov 2020 12:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/HM/8rFP5cAjqFnUXV5a+cyTGV1vdatCTE/hESO0uw=;
        b=U7BMAGu6Hb0hKnA/oSKvqajGoBWD0yncJV3rhU6KciqAw4fR6XDauq4KVuQDRvOaer
         P2lwNuAHrhxxVpgG6cjkfq6v70V4fwxSGaqHeHmFdAA1ED1uXEi7XEkplDoAYHnh1i7t
         rI8Gkx51MM8Ud4I/HO+LRhiIcFWnJBIWoXMJ/8jwSLXWyr/g7YkOrM4p0QiKS2bkquxt
         hkiqq9TGdbvwnVZg1znTFFF8rVLohdN4M1tv35av1QDiQxkdFSj6vgcgupUE6cMhxxI+
         9segr/KIrj5dzjboN76fh2uBXToaniri7zVHFaOs1shKitGqxPvNnu1UQKQJJkZbs8up
         2upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/HM/8rFP5cAjqFnUXV5a+cyTGV1vdatCTE/hESO0uw=;
        b=XR4SaHOOKi6H3/vcQex4cnx4MnUU581Sri+E5YwG74rNRfyBY4mXotBjwUBEdjBZiJ
         Aemqzq4WTRzAVPvGIziE/Rqu1ceJ1r36Vts6wXxEJWuu+iO0+HLNeJYHSydagEhAdD5D
         hF5EvxIXJHdyAwYtoiHo52Tc70TWPrr1ZPHtNHHVAXT7WTDlthk+GIw5lOQcKi//MI2o
         VnItju8zl7ojFTdjcgOim42zkaMfuMIq7unYEMRcXm4+SOPuIrL0fluwX6YA1hyopfew
         7BImqmY4THcEYEig7xYKToi9mHzc5cICrsj6qgFYFHH7Oc4kOehVQ7uel88uyq08eETC
         8YCw==
X-Gm-Message-State: AOAM530xjLo1lVnX/HCCHgKOukwIAH1q5o17n8CZx9S9+wa2qokvsvt0
        9cB2z761WIrS7SqYRJ10T/FxV+Tn6H33JKoJ8ZpcCg==
X-Google-Smtp-Source: ABdhPJwZTfPGl9sCT1BVU2GvADqbE6pDiG1Xc1mtvTA/GsapyKzaYnyIr5d4QUAp0ZBQ4ukQby3tNlpzSAg6JpSsySA=
X-Received: by 2002:a05:6402:176e:: with SMTP id da14mr311916edb.245.1606250681588;
 Tue, 24 Nov 2020 12:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-4-lokeshgidra@google.com> <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
 <CA+EESO7LuRM_MH9z=BhLbWJrxMvnepq-NSTu_UJsPXxc0QkEag@mail.gmail.com>
 <CAHC9VhQJvTp4Xx2jCDK1zMbOmXLAAm_+ZnexydgAeWz1eGKfUg@mail.gmail.com>
 <CA+EESO79Yx6gMBYX+QkU9f7TKo-L+_COomCoAqwFQYwg8xy=gg@mail.gmail.com>
 <CAHC9VhSjVE6tC04h7k09LgTBrR-XW274ypvhcabkoyYLcDszHw@mail.gmail.com>
 <CA+EESO7vqNMXeyk7GZ7syXrTFG54oaf1PUsC7+2ndEBEQeBpdw@mail.gmail.com>
 <CAHC9VhQn-E+kTzzwwAiSLLQVtm5u=m5bOz2n-q+oA+8quT2noQ@mail.gmail.com>
 <CA+EESO6qfCCZ5K1sWWrcBm6VM0w3LWkiOfAh3dhM-eVigVYYWA@mail.gmail.com> <CAHC9VhTtLj9QPqEqO5hHPDmMnWzUaD-2PwGw=bQ=SBxvV78Sxg@mail.gmail.com>
In-Reply-To: <CAHC9VhTtLj9QPqEqO5hHPDmMnWzUaD-2PwGw=bQ=SBxvV78Sxg@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 24 Nov 2020 12:44:30 -0800
Message-ID: <CA+EESO465UY7v5W4k6cqWHTDq6e6pb_NBnZZRMjawHPvfEOOLw@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] selinux: teach SELinux about anonymous inodes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
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
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 23, 2020 at 2:43 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Nov 23, 2020 at 2:21 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > On Sun, Nov 22, 2020 at 3:14 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Nov 18, 2020 at 5:39 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > I have created a cuttlefish build and have tested with the attached
> > > > userfaultfd program:
> > >
> > > Thanks, that's a good place to start, a few comments:
> > >
> > > - While we support Android as a distribution, it isn't a platform that
> > > we common use for development and testing.  At the moment, Fedora is
> > > probably your best choice for that.
> > >
> > I tried setting up a debian/ubuntu system for testing using the
> > instructions on the selinux-testsuite page, but the system kept
> > freezing after 'setenforce 1'. I'll try with fedora now.
>
> I would expect you to have much better luck with Fedora.

Yes. It worked!
>
> > > - Your test program should be written in vanilla C for the
> > > selinux-testsuite.  Looking at the userfaultfdSimple.cc code that
> > > should be a trivial conversion.
> > >
> > > - I think you have a good start on a test for the selinux-testsuite,
> > > please take a look at the test suite and submit a patch against that
> > > repo.  Ondrej (CC'd) currently maintains the test suite and he may
> > > have some additional thoughts.
> > >
> > > * https://github.com/SELinuxProject/selinux-testsuite
> >
> > Thanks a lot for the inputs. I'll start working on this.
>
> Great, let us know if you hit any problems.  I think we would all like
> to see this upstream :)
>
I have the patch ready. I couldn't find any instructions on the
testsuite site about patch submission. Can you please tell me how to
proceed.

> --
> paul moore
> www.paul-moore.com
