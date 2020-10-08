Return-Path: <SRS0=ZqYe=DP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20221C04EBE
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 14:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF34D2184D
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 14:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="armQ9Vd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgJHOIn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730175AbgJHOIn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Oct 2020 10:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602166121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aDrREu8JgYjM5C2pUxLMhMFJeWo9WdQPk6qfGuNUF4o=;
        b=armQ9Vd7eN0CNuMIQW3kaAMYa7PH/KVNdLPWdpC+aADDh3vojhIrzrnARPk3DkWWuaAJcG
        zrUd9EqfXQyHnx4glHko59uIEjyOPkDLHAkZPYCt/VYhfYbNQ1t0QRa5guoCVhHGz91du5
        2yL4cAP427OaxpUi6QxyZ1r2Y+0uJxs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-8nF5X_pGMxSRNu3LqFbMMA-1; Thu, 08 Oct 2020 10:08:39 -0400
X-MC-Unique: 8nF5X_pGMxSRNu3LqFbMMA-1
Received: by mail-lf1-f69.google.com with SMTP id v12so1081506lfo.0
        for <selinux@vger.kernel.org>; Thu, 08 Oct 2020 07:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDrREu8JgYjM5C2pUxLMhMFJeWo9WdQPk6qfGuNUF4o=;
        b=DyDN+TJbJQNK/Bet0SielqYsmjBJwFJuWXCkwxRnH8pHB49j7UUCjRnlhl6yb5ucmz
         /O6EzgqYRL636CfavTyb16R6jxsvv9YGXRZl4NWM+3/pqNIa06ICXwPBK5xCrTAPvrDL
         zv1+NF+ANUzobbhO1QkS8BM8uIwyvR6Apy3TI9owmTivCZYjuenwYxc0Ee0mR6urqg7M
         i+jl6WB8UIcRI2bno0fheEjmZf7ZjN1hoPE823iV62mng7O4UNYReHeqdu2KPuW3uRFa
         vlW7YZ24c6WOXnkDKyr/q0o1pB/89sQEe/aasmaLlJJCIuc2VpYqqY5gRUpQ6sOBGLF2
         uKTA==
X-Gm-Message-State: AOAM530/9hLyJEjIP5zsYNHgAe41Y4DpAIlZYrmLd0vv6RxbFwYqZbJb
        FL/U2iRdX0TbxG+QnV4hJqpkzPrBpWr0aAkVJoy6gPmIV5XDQdYYuML/4GY4p1qoURJnMEu4sUe
        PFQyx2Aj4+j6cAllORkov/LOf6RUwP/qBWQ==
X-Received: by 2002:a2e:99cb:: with SMTP id l11mr3196222ljj.123.1602166117325;
        Thu, 08 Oct 2020 07:08:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpBfCg43tlJRvWzMwyZ7ch5LdiqRzwF0++Hr1O762WWyHks7N/C/omz6fY1vfj0TJlpVgEU1clbbcltr0lcyI=
X-Received: by 2002:a2e:99cb:: with SMTP id l11mr3196215ljj.123.1602166117102;
 Thu, 08 Oct 2020 07:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com> <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
In-Reply-To: <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 8 Oct 2020 16:08:26 +0200
Message-ID: <CAFqZXNsG+B7OdmQimwNNVYCJM_Dc3jpNUFUpraoCEaicaoi+kQ@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 8, 2020 at 3:50 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> > > Hi folks,
> > >
> > > From some linux kernel module, is it possible to query and find out
> > > whether or not selinux is currently enabled or not?
> > >
> > > Thank you.
> >
> > [NOTE: CC'ing the SELinux list as it's probably a bit more relevant
> > that the LSM list]
> >
> > In general most parts of the kernel shouldn't need to worry about what
> > LSMs are active and/or enabled; the simply interact with the LSM(s)
> > via the interfaces defined in include/linux/security.h (there are some
> > helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
> > bit more on what you are trying to accomplish?
>
> Hi Paul,
>
> Thank you for the response. What I'm trying to accomplish is the
> following. Within a file system (NFS), typically any queries for
> security labels are triggered by the SElinux (or I guess an LSM in
> general) (thru the xattr_handler hooks). However, when the VFS is
> calling to get directory entries NFS will always get the labels
> (baring server not supporting it). However this is useless and affects
> performance (ie., this makes servers do extra work  and adds to the
> network traffic) when selinux is disabled. It would be useful if NFS
> can check if there is anything that requires those labels, if SElinux
> is enabled or disabled.

Isn't this already accomplished by the security_ismaclabel() checks
that NFS is already doing?

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

