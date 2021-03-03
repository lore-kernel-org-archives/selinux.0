Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9385C433E9
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA21364EE6
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350687AbhCDAYY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231831AbhCCNFe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Mar 2021 08:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614776587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BVZiB1/GQlugvAsnQTL1qa8NmFMjdV8CZLSaiI2FjrA=;
        b=PW867ASbPIvQkew2Kwm9UJNo0QOKpzxgrORQlsGxhJKMYB7kAzwCdnS8D61vu323Xi6XJv
        6Q3A4ypuMeqoJJBBqOhf1bO+0/0CniTdD15MJfVaBQoqnxBkwSwfWIbc7qV6RjwwpF1ZV/
        WdiiHm2vP2v7TMBtcZL+8S+Zy4DZEzU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-bNUXpf3pO023tr9uCGeJcg-1; Wed, 03 Mar 2021 03:54:51 -0500
X-MC-Unique: bNUXpf3pO023tr9uCGeJcg-1
Received: by mail-yb1-f198.google.com with SMTP id s187so25986291ybs.22
        for <selinux@vger.kernel.org>; Wed, 03 Mar 2021 00:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVZiB1/GQlugvAsnQTL1qa8NmFMjdV8CZLSaiI2FjrA=;
        b=Yay11/EsCQumzumzGKlfSyA6jNEAv5ToJERePyB1/8XMq9kn2wQT6arVAbHe/fpIyQ
         YIc+m2vDGL8do6tgVhPBWfI4NLPEfzMzQL4WsE3eBX1W44v+Q6y8vHbMPYxM/uikp8J9
         hmnG+DKUcpbdVX7Z99uEMXyXLg77u2A6xKFp7mJ7A+FSEiPlAJ44K7XTz8CHXmX51CZf
         dAJve9l98hhtosOlFyuVsJnx+As8Rd074mXz+e13w2bU124eLN9WXR5HauG/gyptmN7c
         9lvm/QraAHFHLTizJlt5i0GiwMAYFrikKfZ4Uh4ANmJzxbQPSobYCaEWb1OrwAMhZj/k
         7oMQ==
X-Gm-Message-State: AOAM530VsTuWBTcZ/vk85pi5zwe3PgiDPcehLvzdPEgy8BN5ToYclnFB
        J8erdxsFy+YlU01q1yi2rxXClfIF7Rxf8GSn2wUTsqTBGQLAUxSTISBteq8nkWu4/5BaF/eqmhW
        bXShMEeoxYu7ANGXRGrEeQ/JDYyU7LEYG1Q==
X-Received: by 2002:a5b:4a:: with SMTP id e10mr38412087ybp.436.1614761690121;
        Wed, 03 Mar 2021 00:54:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvlo1g7I4SdAbFxwyb5XuOG5on3XfKAJ05I/qagaqJL+jLrnA6yXNx33mCmk33rFcLcIdZMA8uO9BmFkzWBhQ=
X-Received: by 2002:a5b:4a:: with SMTP id e10mr38412061ybp.436.1614761689784;
 Wed, 03 Mar 2021 00:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20210212185930.130477-1-omosnace@redhat.com> <20210212185930.130477-2-omosnace@redhat.com>
 <CAHC9VhQLJKjY0KSC+=f4b=8d8n-m29j_9J5r_VQ_1BpSY8WD2w@mail.gmail.com>
 <CAFqZXNuBYwAT2-vLaTM8_Zng=vh+XsY_EvnzPYM4Z=PoCydZ+A@mail.gmail.com>
 <CAHC9VhSzDVyipy2y8ONiR_Q0YG50FnCJxgHsoi9Nee09hN0WCA@mail.gmail.com> <20210303025558.GH6000@sequoia>
In-Reply-To: <20210303025558.GH6000@sequoia>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 3 Mar 2021 09:54:38 +0100
Message-ID: <CAFqZXNszZY-6Cg0ZaSUY1Y+EvfP-0QApVTJUOQkNt5jrTSgh5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: don't log MAC_POLICY_LOAD record on
 failed policy load
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 3, 2021 at 3:56 AM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> On 2021-02-28 13:52:52, Paul Moore wrote:
> > On Fri, Feb 26, 2021 at 9:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Thu, Feb 25, 2021 at 7:15 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Fri, Feb 12, 2021 at 1:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > >
> > > > > If sel_make_policy_nodes() fails, we should jump to 'out', not 'out1',
> > > > > as the latter would incorrectly log an MAC_POLICY_LOAD audit record,
> > > > > even though the policy hasn't actually been reloaded. The 'out1' jump
> > > > > label now becomes unused and can be removed.
> > > > >
> > > > > Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > ---
> > > > >  security/selinux/selinuxfs.c | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > > > > index 01a7d50ed39b..340711e3dc9a 100644
> > > > > --- a/security/selinux/selinuxfs.c
> > > > > +++ b/security/selinux/selinuxfs.c
> > > > > @@ -651,14 +651,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
> > > > >         length = sel_make_policy_nodes(fsi, newpolicy);
> > > > >         if (length) {
> > > > >                 selinux_policy_cancel(fsi->state, newpolicy);
> > > > > -               goto out1;
> > > > > +               goto out;
> > > >
> > > > This looks good, especially with AUDIT_MAC_POLICY_LOAD recording
> > > > "res=1".  However, now that I'm looking at the error path here, we
> > > > don't display anything if sel_make_policy_nodes() fails, do we?  If
> > > > security_load_policy fails we at least do a printk(), but if this
> > > > fails it silently kills the policy load; at the very least I think we
> > > > want a `pr_warn_ratelimited("SELinux: failed to load policy due to
> > > > selinuxfs failures")` or something similar.
> > >
> > > There are error messages in some error paths in
> > > sel_make_policy_nodes(), but not all. Those are pr_err()s, while in
> > > sel_write_load() there is a pr_warn_ratelimited(). Could we just unify
> > > the sel_make_policy_nodes() failure to a single message? (I don't
> > > think the information on which part has failed is very useful as the
> > > most likely cause here is a memory allocation failure, not bad
> > > policy.) If so, should it be a pr_warn() or pr_err()? Ratelimited or
> > > not?
> >
> > My personal opinion is that the kernel only needs to provide the error
> > details to userspace which can be useful in determining what wrong,
> > and how the user can fix it.  For example, if there is a memory
> > allocation failure in the kernel there is often little the user can do
> > (and it is often transient anyway due to loading and other factors),
> > so simply reporting that there was an allocation failure while
> > attempting X is sufficient.
> >
> > Beyond that, I think things can get a little fuzzy, e.g. pr_warn() or
> > pr_err?  Ratelimit or always emit the message?  I also think the
> > answers can change as userspace behaviors change over time.  If one of
> > the policy load error paths uses a pr_err() then we should probably
> > stick with that; it also seems appropriate as failing to (re)load a
> > SELinux policy *is* a serious matter.  As far as the rate limiting is
> > concerned, I'm not sure if that is an important difference here; if
> > the system is getting enough requests to reload the policy, and
> > repeatedly failing, such that the ratelimiting matters there are
> > likely other, much larger, issues at play on the system.
>
> I was a little surprised to see pr_warn_ratelimited() (from both the
> KERN_WARNING and ratelimited perspectives) used in the policy loading error
> path so I poked around a bit. The description of commit 4262fb51c9f5 ("selinux:
> log errors when loading new policy") explains the reasoning:
>
>     If the policy fails to be loaded from userspace then a warning message is
>     printed, whereas if a failure occurs after loading policy from userspace an
>     error message will be printed with details on where policy loading failed
>     (recreating one of /classes/, /policy_capabilities/, /booleans/ in the
>     SELinux fs).
>
> This seems like sound logic and would result in Ondrej using pr_err() in the
> sel_make_policy_nodes() error path.

The situation has changed a bit since that was written, though... Back
then after the policy had been loaded there was no way to turn back
and if sel_make_policy_nodes() failed, the new policy would stay and
selinuxfs would have been left behind in an inconsistent/broken state.
Now this issue is fixed and the new policy isn't actually applied
until the selinuxfs preparation succeeds. So from a certain POV, the
selinuxfs failure is no longer that fatal and could just print a
warning like the other error path, because the result is the same
after both failures (active policy and selinuxfs state remains
unchanged).

Paul (or Stephen if you are reading this and have time to comment),
what do you think?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

