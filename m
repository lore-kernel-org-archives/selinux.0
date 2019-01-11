Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB60C43387
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 01:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE572133F
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 01:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ClvvaPny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfAKB5a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:57:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46892 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbfAKB5a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 20:57:30 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so11494034ljh.13
        for <selinux@vger.kernel.org>; Thu, 10 Jan 2019 17:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hscE/JZej9f3YLwX0dLd86JZIHcT7l6BrwwT9w3M78o=;
        b=ClvvaPnyc4vI3padnYMXc8L0MXoIH/eAegyeZW/tE+BBqI9Ss90l0fOBgMlj1MAfja
         uIp55UQ5IAse/bbjr0pVjpEyMX9YwAq/6gJstP18onU4B/wArO39aK/5vZiTtpHGSyNd
         jrSTtf7UMrrMHXFIfhreI7kQDZnO4DqBuwKL6ZXbXOEZd82CtyCpN2Yh7jg1XAEqGTC4
         nk/HalHzvWrXgaFoMEVBnzop3iR4E6x0NTj2WmqnifZQeiiov2c1jK4L52gWJKY//Ud7
         6SXAKYToIxWAMwkuvoXY57ETsc4Ve9BalMHEVXiek7w6+zRYjI/i96zGUhSGOiM79++M
         rIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hscE/JZej9f3YLwX0dLd86JZIHcT7l6BrwwT9w3M78o=;
        b=DaWIDQ0RrvZlg4QGlrs/jYdu0yzNj1uht+f5A1SMxumat1sk7dZc7ZdG/JbJXBdKV4
         iEdyK1AoZKZaNVjraortyJ7SGk7gbL2sOLanupM9c1d3qykidgv/JnbOZCFmq5rxRyjP
         fRGeX14iShtDAl53MIjUwYxY1wSagdh2v43JyWVLU3m3J9mtr4AkJ+zjQymC79msRW3m
         I1nmk1NYqilImyn/+nq6Po9NJ4Qy/GY3+fijzaZQIc4Xt22zEN0Ww5wqAfG3o9Z2fHCQ
         cAv8FyD30HujTuH53gKxs/NzQabqxVGKeM0N9jPGa4fVrLzAhVNnK5eMl403Q/qh3jb2
         mISA==
X-Gm-Message-State: AJcUukcwnyETypip/bkBVV5/fbkeFOeFvJbTyfJh9JeQIV9X8J1i7yvy
        U1aNXZJBstSXhNiSTbsU9CYaOMtWTG1utZPmyS4z
X-Google-Smtp-Source: ALg8bN6SBM29paG7MbH7+0Ry1H4CevYRgdSzOtWLkGEt+UPEii0lfDLwp907WLzAyF2el6TAPFS2fIRjuY/GZ4v15uo=
X-Received: by 2002:a2e:834a:: with SMTP id l10-v6mr7047287ljh.42.1547171848068;
 Thu, 10 Jan 2019 17:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20190109162830.8309-1-omosnace@redhat.com> <20190109162830.8309-2-omosnace@redhat.com>
 <cbe734fb-cd91-57a8-0de5-f4f0f8a1a2cd@schaufler-ca.com>
In-Reply-To: <cbe734fb-cd91-57a8-0de5-f4f0f8a1a2cd@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jan 2019 20:57:17 -0500
Message-ID: <CAHC9VhS6pGycbT1GET5CHjxgYCDu1KCrcPtcF0n==1oH15kAVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: Add new hook for generic node initialization
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 9, 2019 at 12:08 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
> > This patch introduces a new security hook that is intended for
> > initializing the security data for newly created pseudo filesystem
> > objects (such as kernfs nodes) that provide a way of storing a
> > non-default security context, but need to operate independently from
> > mounts.
> >
> > The main motivation is to allow kernfs nodes to inherit the context of
> > the parent under SELinux, similar to the behavior of
> > security_inode_init_security(). Other LSMs may implement their own logic
> > for handling the creation of new nodes.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++++
> >  include/linux/security.h  | 14 ++++++++++++++
> >  security/security.c       | 10 ++++++++++
> >  3 files changed, 54 insertions(+)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index aaeb7fa24dc4..3a2399d7721f 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -429,6 +429,31 @@
> >   *   to abort the copy up. Note that the caller is responsible for reading
> >   *   and writing the xattrs as this hook is merely a filter.
> >   *
> > + * Security hooks for special file-like objects
> > + *
> > + * @object_init_security:
>
> I don't like the name. There are too many things that are "objects"
> for this to be meaningful. I also dislike seeing names like
> security_object_init_security. How about init_from_parent? If there's
> never a chance that it will be used anywhere but with kernfs, it could
> be kernfs_node_init. The existing set of hook names are sufficiently
> confusing without adding to the mystery.

I like the naming similarity with inode_init_security(), that seems
helpful.  Although I somewhat understand you concern about the generic
"object".  Could you live with kernfs_init_security()?  If another fs
adopts it, we could always changing the name later if needed.

-- 
paul moore
www.paul-moore.com
