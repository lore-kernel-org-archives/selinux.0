Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6232FC433B4
	for <selinux@archiver.kernel.org>; Fri, 23 Apr 2021 13:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E250611AC
	for <selinux@archiver.kernel.org>; Fri, 23 Apr 2021 13:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbhDWNm0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Apr 2021 09:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231274AbhDWNmR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Apr 2021 09:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619185300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ze4ahKnbOCWiAxmHjTl9e5R83LN6smcdaohyYDqcddU=;
        b=fp7Oef53LaQhcuftmC4ubwd+u80b+Lm62u7sVrmBDO2RxLkvFOaIwDNifMmhsYplE43QQw
        SnyyNpa9/VNwpMAocQYr7jiChpt5qO81qyd7MqNOyF4rjA8cHKBM7Yp3oiQlQOvK7pyiPX
        Iws9inRj++ru3YyMO8zs+FDBBjKG1fI=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-ypHkmnYRPuSvOa0xHVKk9A-1; Fri, 23 Apr 2021 09:41:39 -0400
X-MC-Unique: ypHkmnYRPuSvOa0xHVKk9A-1
Received: by mail-yb1-f197.google.com with SMTP id s2-20020a5b07420000b02904eb842efc40so24116542ybq.3
        for <selinux@vger.kernel.org>; Fri, 23 Apr 2021 06:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ze4ahKnbOCWiAxmHjTl9e5R83LN6smcdaohyYDqcddU=;
        b=CaWo+eXqkGmluUqeX9bioNroQdm3u0QkoPl61ODJ2aSAgv8FwnkvlDvDdGH+IAoZQ0
         HxiUzQFtZZcwMWfyur/Pkr5GulVPEBVBO2RsvZiRC/8codjZbuKF3X/DXgO8VrI6RfIB
         k4IqypL0cXSsUWkWmtwcJ+zBcp4sCGVwPIsoMxElA/4pSv9ddlZ9Re8JZWp1ajUueYOO
         izOZRYwgkqtMM4szvM+3RipMuIGFu+LsoMWvNDiaDDbL+rg5yqv5UmEZQ85qCaryKzxQ
         Iy81emTnIIlt/nEJeHuOdUWyVhQxraEi/A3Kv0jnwHJsaZWioJFPz1+UQaVz9MnSvcqI
         nvsg==
X-Gm-Message-State: AOAM533/GqM58zpyb0lmLAx6LHp3YRsoM+2aPDBWM0fdeb3RHf1+7BgB
        IyxWNxbzvEv0i/NDhCUW2B1V9lusig9H+ULqfWFgA+QAf+7cXk1tCQgE3Aja95cvRifaRzTIi8R
        RPhpWYSdPDRPLMlwHULmyr8THSrGDqgNcuQ==
X-Received: by 2002:a25:9085:: with SMTP id t5mr4967908ybl.26.1619185298266;
        Fri, 23 Apr 2021 06:41:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXNaViuyykB129+lJhNJo0S+WHcmw5kglqQvAOEW3Lkacoqm9Vvdzv9iHggDm7UBpnmciENcf5DP8f3KFEXko=
X-Received: by 2002:a25:9085:: with SMTP id t5mr4967852ybl.26.1619185297789;
 Fri, 23 Apr 2021 06:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com> <20210421171446.785507-3-omosnace@redhat.com>
 <CAEjxPJ5ksqrafO8uaf3jR=cjU5JnyQYmn_57skp=WXz7-RcbVQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5ksqrafO8uaf3jR=cjU5JnyQYmn_57skp=WXz7-RcbVQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 23 Apr 2021 15:41:25 +0200
Message-ID: <CAFqZXNv4gKFN5FV_Z8U82cOzauBggaqPE0WZZUdnNRxCQ3PVPw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] selinux: add capability to map anon inode types
 to separate classes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 22, 2021 at 3:21 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Unfortunately, the approach chosen in commit 29cd6591ab6f ("selinux:
> > teach SELinux about anonymous inodes") to use a single class for all
> > anon inodes and let the policy distinguish between them using named
> > transitions turned out to have a rather unfortunate drawback.
> >
> > For example, suppose we have two types of anon inodes, "A" and "B", and
> > we want to allow a set of domains (represented by an attribute "attr_x")
> > certain set of permissions on anon inodes of type "A" that were created
> > by the same domain, but at the same time disallow this set to access
> > anon inodes of type "B" entirely. Since all inodes share the same class
> > and we want to distinguish both the inode types and the domains that
> > created them, we have no choice than to create separate types for the
> > cartesian product of (domains that belong to attr_x) x ("A", "B") and
> > add all the necessary allow and transition rules for each domain
> > individually.
> >
> > This makes it very impractical to write sane policies for anon inodes in
> > the future, as more anon inode types are added. Therefore, this patch
> > implements an alternative approach that assigns a separate class to each
> > type of anon inode. This allows the example above to be implemented
> > without any transition rules and with just a single allow rule:
> >
> > allow attr_x self:A { ... };
> >
> > In order to not break possible existing users of the already merged
> > original approach, this patch also adds a new policy capability
> > "extended_anon_inode_class" that needs to be set by the policy to enable
> > the new behavior.
> >
> > I decided to keep the named transition mechanism in the new variant,
> > since there might eventually be some extra information in the anon inode
> > name that could be used in transitions.
> >
> > One minor annoyance is that the kernel still expects the policy to
> > provide both classes (anon_inode and userfaultfd) regardless of the
> > capability setting and if one of them is not defined in the policy, the
> > kernel will print a warning when loading the policy. However, it doesn't
> > seem worth to work around that in the kernel, as the policy can provide
> > just the definition of the unused class(es) (and permissions) to avoid
> > this warning. Keeping the legacy anon_inode class with some fallback
> > rules may also be desirable to keep the policy compatible with kernels
> > that only support anon_inode.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> NAK.  We do not want to introduce a new security class for every user
> of anon inodes - that isn't what security classes are for.
> For things like kvm device inodes, those should ultimately use the
> inherited context from the related inode (the /dev/kvm inode itself).
> That was the original intent of supporting the related inode.

Hmm, so are you implying that anon inodes should be thought of the
same as control /dev nodes? I.e. that even though there may be many
one-time actual inodes created by different processes, they should be
thought of as a single "static interface" to the respective kernel
functionality? That would justify having a common type/label for all
of them, but I'm not sure if it doesn't open some gap due to the
possibility to pass the associated file descriptors between processes
(as AFAIK, these can hold some context)...

I thought this was supposed to resemble more the way BPF, perf_event,
etc. support was implemented - the BPF and perf_event fds are also
anon inodes under the hood, BTW - where each file descriptor is
considered a separate object that inherits the label of its creator
and there is some class separation (e.g. bpf vs. perf_event).

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

