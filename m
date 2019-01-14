Return-Path: <SRS0=3kls=PW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7218DC43387
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 09:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4E32086D
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 09:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfANJ3V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:29:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35848 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfANJ3U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jan 2019 04:29:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so18718807otk.3
        for <selinux@vger.kernel.org>; Mon, 14 Jan 2019 01:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4ok1fnsEgHKhslzCrI4jsUzL5SmWxSmZofuP1ZRF64=;
        b=eb5BbvAykGApcDSdZw9SCWOkbUd8T5TM3qp6srvgCKH3GRClVDPSmn6GXpjTyVR/ST
         TuXLJ999VsCQXt+ZsnI4sfb9VgizExF03TB3vnbDC6Rj2SiEK1ALTlKG34hgdvtRagge
         JiUQDo8dOMVB2nfhvLJ2P/901c+voEL58XlB5JYqVID1m45aurVQz9W6AElBYVl6H1UJ
         /MEvrYCItysDMlh5RaTwUoQJQjVUTutXCwCD5O5fbEPfFaYU464lmQQb8z+cJ9UgHC//
         xw5aPBjs18wcjc8gLz3LKihFkkxV7sXKLSGm6XQExJbSQcPUJSf37gGhX6yMDKE0ZpmC
         RYAA==
X-Gm-Message-State: AJcUukfT97DdgvYGXk6MTga+OcAKSuHW6spyjXSSP9Th9j5WpRKvKN5n
        bFLweS+oFTsGsqhCcWlqhcJW24qL9ot4LEbxhkvvvbWbJgI=
X-Google-Smtp-Source: ALg8bN6mB87VsjEumq21zCgn14Sa46c+kPZWpFoAuy0m7XsEYJK4est6SqPerzhYLrpl7Xw+zzaeYXvCJgEJGsji+4U=
X-Received: by 2002:a9d:27e3:: with SMTP id c90mr15539878otb.21.1547458160358;
 Mon, 14 Jan 2019 01:29:20 -0800 (PST)
MIME-Version: 1.0
References: <20190109091028.24485-1-omosnace@redhat.com> <20190111205053.GV2509588@devbig004.ftw2.facebook.com>
 <CAFqZXNu-bHGmUi80UiyW3djcbedycC+0KUyiQuv9-8b+WmrYuA@mail.gmail.com>
In-Reply-To: <CAFqZXNu-bHGmUi80UiyW3djcbedycC+0KUyiQuv9-8b+WmrYuA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 14 Jan 2019 10:29:09 +0100
Message-ID: <CAFqZXNsxVpxXHQ4qOZQpnpck24O5ofskLgU-B0ahbDK8MgxGCA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow initializing the kernfs node's secctx based on
 its parent
To:     Daniel Walsh <dwalsh@redhat.com>
Cc:     selinux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 14, 2019 at 10:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> [...]
> [3] https://lore.kernel.org/selinux/CAFqZXNsxfjwDaCWDrqxP736y_3Jm-r=twaHtkkTDtMuym774Jw@mail.gmail.com/T/

Actually, this thread belongs to v1 of the patch series, which is archived here:
https://lore.kernel.org/selinux/CAFqZXNu-bHGmUi80UiyW3djcbedycC+0KUyiQuv9-8b+WmrYuA@mail.gmail.com/T/

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
