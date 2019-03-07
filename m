Return-Path: <SRS0=Plie=RK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB91C43381
	for <selinux@archiver.kernel.org>; Thu,  7 Mar 2019 09:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0682D20675
	for <selinux@archiver.kernel.org>; Thu,  7 Mar 2019 09:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCGJBH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:01:07 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36476 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJBH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Mar 2019 04:01:07 -0500
Received: by mail-oi1-f195.google.com with SMTP id t206so12300187oib.3
        for <selinux@vger.kernel.org>; Thu, 07 Mar 2019 01:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElYvV2fvCkLBraBf/ssGt1m5M7ChBwo7N0gPQyqJnBo=;
        b=Enxru+aJNoTFJ5XesT7Ja2OemRIEkHia70FJmL/PUi4oWDX+hTbXzfYuL+/FhYGX+a
         igMoOkF3JIT80x0JgOmnzFx6mYzJmWzpn82o6OCgGPBv/BsJmH7IempnljEg/J6tFKdT
         ZqZsplVZLlAzPUeQkpA0lmClisZ3WLRIpqmkduQCPlAedqq196SMZjAbCd//GgFATElh
         eKkNkhIpg4mhqW0CvFF8ozu6jf+3hCPYOzITPqk3XRx3NJyOD6/PvX7xRhfFOv75C+BS
         k74FfZg7qPGn/fm7IhrVwyy3FoU8Wcob6yh4sO9tNLHWwyFC4E99oIg9M8ZSzH64NDdE
         R+9g==
X-Gm-Message-State: APjAAAUop+jN8g3jx8sVr2uMKT8pQnAxDHpW5EDfFpYgE+p72/hkW9+O
        igCGmLq/02exJsbh+7V3wocen2XX5CgKk1SwPY6mmA==
X-Google-Smtp-Source: APXvYqw3uOHyjzfvwCSHqr+uoJAyjHPkJ7W2ZevYHUvRTAm6uUKO4wRRnTOXVnyvO3tpQqOhTdQXpBba9CpvZnmr174=
X-Received: by 2002:aca:3746:: with SMTP id e67mr4471451oia.103.1551949266422;
 Thu, 07 Mar 2019 01:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20190222145718.5740-1-omosnace@redhat.com> <CAFqZXNs28QAxHA3=vECuG17TQ-be0ywS=r9S48q_KNBYpzgJLg@mail.gmail.com>
 <CAHC9VhShXZasD8d3nF4PwaL38gkq3hKDbvRivHX5_oHeBROFKQ@mail.gmail.com>
In-Reply-To: <CAHC9VhShXZasD8d3nF4PwaL38gkq3hKDbvRivHX5_oHeBROFKQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 Mar 2019 10:00:55 +0100
Message-ID: <CAFqZXNs8s6K9nK80+6FE9UOktWLy5PdbJ864zZ3rCXE9K71LuQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Allow initializing the kernfs node's secctx based
 on its parent
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 6, 2019 at 5:20 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Mar 6, 2019 at 10:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Fri, Feb 22, 2019 at 3:57 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > [...]
> >
> > Ping about this series... Casey, are you OK with this new version?
>
> We've got two weeks, well one and a half weeks, to decide as the
> earliest I would merge this would be after the merge window closes :)

Sure, I just wanted to know early if there would be any more changes needed.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
