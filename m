Return-Path: <SRS0=mDct=7F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA87C433E1
	for <selinux@archiver.kernel.org>; Sat, 23 May 2020 04:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E460206DD
	for <selinux@archiver.kernel.org>; Sat, 23 May 2020 04:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhzY7J9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgEWE1y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 23 May 2020 00:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgEWE1x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 23 May 2020 00:27:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B6CC061A0E;
        Fri, 22 May 2020 21:27:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so5222299plr.2;
        Fri, 22 May 2020 21:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C2oaJ/TeH9h/Ses/5flX0t0+2GPRsirL3Ix59rT/3uo=;
        b=UhzY7J9+KCLeMXEB0x5/JYLsXcF2rLqnBYZsezjDmmaWeU2eXzSWAy7ExbfFinlt0h
         oD+/yx2FqLMUx6oYlhZZ1nAx2okSnaBGN0taiOxwFduM44/t5yL1HcdNYJNPojgy84gK
         tODEWzdeuhJi30XoaBQXn2nXsAVh7GLIA8aeEq98wBmbi31odtZj15cCH2VT3rnZvKcd
         gJVl9dVYI+EN9c7Svpj145az+WB83+msRP9vP2ypIcYVcmOdoTjq80jUu0mkQlx4iDYD
         JlssprdK89mPNrlVxz81XdkpvnHi+MqoPqYnP7WRkAPLA+mJg6SH3K8BQtlvRjI4RwuW
         rvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C2oaJ/TeH9h/Ses/5flX0t0+2GPRsirL3Ix59rT/3uo=;
        b=pBLJcHycROc4kxIOtgBnyhBLx8ZAS+mupeaHQ7KGeiNQUgWJvA4gNTCiRcolX4/mRH
         YuLHzKRR/a13F5XmUrz0dfYJ49a/Lbet/ov+RyfkREDeVVXiC7k+5yKngX17TfI1Qy9Q
         m7aFo9P45FBkGO7YoputSdnTwsHjeHJ7+8ulXE7R6CUMot6a8iqzeR3DnXFgge0nIolv
         7dGdpkKc9HxBoOyk0fBHp4SPF92uFyOj6alibcTXTNnUUiOHSy22QIr/2YKcG/iOWmEB
         pRsX3srTGFbdjBnTbaQdRiAdB68UhxPP2mNMpFCUsvutAQ8iqBhcAXVdlO/oS7CXGAt7
         8WVw==
X-Gm-Message-State: AOAM530MZ2kixJwtGfT2OeKYTg3yibwi83HEUC7d00IJiUzNab08IQTA
        nGzqSX8jLCFtygLZ6fXEBWsizXG7Q0eG1A==
X-Google-Smtp-Source: ABdhPJzGiSZlqt61UixW5UamCs2yESeKusCKau2NIDepW0lVjbXdkbJjigi7aqwO/6tCOiqfG9A5+g==
X-Received: by 2002:a17:902:848a:: with SMTP id c10mr17901055plo.124.1590208071913;
        Fri, 22 May 2020 21:27:51 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id t21sm7300922pgu.39.2020.05.22.21.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 21:27:51 -0700 (PDT)
Date:   Fri, 22 May 2020 21:27:49 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
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
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
Message-ID: <20200523042749.GA19115@gmail.com>
References: <20200522055350.806609-1-areber@redhat.com>
 <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 09:40:37AM -0700, Casey Schaufler wrote:
> On 5/21/2020 10:53 PM, Adrian Reber wrote:
> > There are probably a few more things guarded by CAP_SYS_ADMIN required
> > to run checkpoint/restore as non-root,
> 
> If you need CAP_SYS_ADMIN anyway you're not gaining anything by
> separating out CAP_RESTORE.
> 
> >  but by applying this patch I can
> > already checkpoint and restore processes as non-root. As there are
> > already multiple workarounds I would prefer to do it correctly in the
> > kernel to avoid that CRIU users are starting to invent more workarounds.
> 
> You've presented a couple of really inappropriate implementations
> that would qualify as workarounds. But the other two are completely
> appropriate within the system security policy. They don't "get around"
> the problem, they use existing mechanisms as they are intended.
> 

With CAP_CHECKPOINT_RESTORE, we will need to use the same mechanisms.

The problem is that CAP_SYS_ADMIN is too wide. If a process has
CAP_SYS_ADMIN, it can do a lot of things and  the operation of forking a
process with a specified pid isn't the most dangerous one in this case.
Offten security policies don't allow to grant CAP_SYS_ADMIN to any
third-party tools even in non-root user namespaces.

