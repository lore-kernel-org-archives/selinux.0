Return-Path: <SRS0=3kls=PW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5131AC43387
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 09:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB872086D
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 09:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfANJCH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:02:07 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33965 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfANJCH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jan 2019 04:02:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id r62so17284037oie.1
        for <selinux@vger.kernel.org>; Mon, 14 Jan 2019 01:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOIatw4SDxXlMhwoMxxKnNLegq1MeDbiRrhaVNYfQ8g=;
        b=iY+Yxd0bzskiFpPMIxpJu9GKPyemJuT2mI2cMm5bL2xXkzOrABGldayEYXNAeptIb8
         ZfDZ0JcmJ1W5/fdkR30rZlobaPxkOE+8gpAwdRINLzOPwvpWumGys5lI05AySTHgtqNw
         78pIl6R3g4wI3otQzJlj8yGj0/q7w1nII2XXuSnrClfiPwJuieRkDddeHkki5syRmDAp
         wLaXt76ZDALttx3bMlQSznNqhG+ojUjX8t8wu0KcaYM/k79+cZ5gCB2C70MWm2r6bKOA
         waqg5g0p4zSnqcycjLMBmKdZrnnNiQe+hvIKeWaB6dbfuDGv7ieZ26tmUSYEcLmmfIK5
         gJjA==
X-Gm-Message-State: AJcUukfbxenUn0bHWDgAQrPuhJEQ6HcFJvZQvML0qe4ehEkwfO6ejTY+
        UDgM7oq3QB85UrHZIlRM9NR/2bRy/wSYfnwb8fLWYA==
X-Google-Smtp-Source: ALg8bN4YjX+3nucIkM+ERdxv0qMahRKKDlduj1VhLSNsa1EB2VnnNzCTF/ybeDEhvl+v9iX76L97c5mMFM40bsKNWQs=
X-Received: by 2002:aca:3b43:: with SMTP id i64mr15806119oia.156.1547456526855;
 Mon, 14 Jan 2019 01:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20190109162830.8309-1-omosnace@redhat.com> <20190109162830.8309-2-omosnace@redhat.com>
 <cbe734fb-cd91-57a8-0de5-f4f0f8a1a2cd@schaufler-ca.com> <CAHC9VhS6pGycbT1GET5CHjxgYCDu1KCrcPtcF0n==1oH15kAVA@mail.gmail.com>
In-Reply-To: <CAHC9VhS6pGycbT1GET5CHjxgYCDu1KCrcPtcF0n==1oH15kAVA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 14 Jan 2019 10:01:56 +0100
Message-ID: <CAFqZXNse5Vijo_Vicqs0x=9sbO95MzssBKrAtyW9u=OP-ESK7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: Add new hook for generic node initialization
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 11, 2019 at 2:57 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Jan 9, 2019 at 12:08 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
> > > This patch introduces a new security hook that is intended for
> > > initializing the security data for newly created pseudo filesystem
> > > objects (such as kernfs nodes) that provide a way of storing a
> > > non-default security context, but need to operate independently from
> > > mounts.
> > >
> > > The main motivation is to allow kernfs nodes to inherit the context of
> > > the parent under SELinux, similar to the behavior of
> > > security_inode_init_security(). Other LSMs may implement their own logic
> > > for handling the creation of new nodes.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++++
> > >  include/linux/security.h  | 14 ++++++++++++++
> > >  security/security.c       | 10 ++++++++++
> > >  3 files changed, 54 insertions(+)
> > >
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index aaeb7fa24dc4..3a2399d7721f 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -429,6 +429,31 @@
> > >   *   to abort the copy up. Note that the caller is responsible for reading
> > >   *   and writing the xattrs as this hook is merely a filter.
> > >   *
> > > + * Security hooks for special file-like objects
> > > + *
> > > + * @object_init_security:
> >
> > I don't like the name. There are too many things that are "objects"
> > for this to be meaningful. I also dislike seeing names like
> > security_object_init_security. How about init_from_parent? If there's
> > never a chance that it will be used anywhere but with kernfs, it could
> > be kernfs_node_init. The existing set of hook names are sufficiently
> > confusing without adding to the mystery.

TBH, I wasn't completely satisfied with the name either, I was hoping
to get some better suggestions along the way.

>
> I like the naming similarity with inode_init_security(), that seems
> helpful.  Although I somewhat understand you concern about the generic
> "object".  Could you live with kernfs_init_security()?  If another fs
> adopts it, we could always changing the name later if needed.

I decided to leave out kernfs out of the name, since it ended up
looking quite generic (nothing particularly kernfs-specific in the
argument list). On second thought, I'm starting to prefer
kernfs_init_security(), considering the very low likelihood that it
would be useful elsewhere and that it will likely end up having some
more arguments tailored specifically for kernfs in the next revisions
(w.r.t. the cover letter discussion).




--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
