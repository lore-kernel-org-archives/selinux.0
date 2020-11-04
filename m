Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A15CC4741F
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1192074B
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 16:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrblJo/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgKDQsR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730424AbgKDQsR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 11:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604508496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zL36dWMumhDo23U5UK88pQyUsQo/fdjGzI2rjYVfV6A=;
        b=NrblJo/eO6n9/YR/QsO+DiXnFceDrUBzD1lj+Lq60W8Dnu32lW+4k1/p81sthGnTW5kqsL
        vxos+3d0q/sdobxDozpe0Yx8KfQeZWcU2JnpSDxPIP87qgT0gMhSLXywMSqz4bZpXZqm2d
        dh9V9bYVqc/rOHUnprvPe5HuhMTWpQ0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-4o8S3N1MObKkVcKNh4-kaw-1; Wed, 04 Nov 2020 11:48:13 -0500
X-MC-Unique: 4o8S3N1MObKkVcKNh4-kaw-1
Received: by mail-lf1-f72.google.com with SMTP id 205so49086lfb.17
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2020 08:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zL36dWMumhDo23U5UK88pQyUsQo/fdjGzI2rjYVfV6A=;
        b=sUkGZ8tpYjN2OpkRNQltCnHilfIX08zNne7eQl/9IT9j8T4F3uhOVUd6tTYGXOpkCy
         ZPF0wJtCYoV5DYmmq47E1eSmijfH6Bt8M4T/lq8EyKdp2vpAagYUlSurqrGroWsBGQLs
         BdfuViPHHWKgz82pK7HYjrPsP9c3qPQHbusTDJSijOem58DASUPj3ws+xaBrsBX40+wZ
         H5wGLuffo3IBfZvv2d9l2xbb4yGCTCjIdVtxkyTA+3HnDkTYbJthaB5MOvUX6R1zxQQ0
         Z8nkXBEi6t5zgZn8aX6rCJTdup2TbfdGWUw5uBQ+8vdQw22fjtx8BOzYQwZtBtUvrSBF
         JncA==
X-Gm-Message-State: AOAM533Fhue/JIDshXAYlAEO9w69Fqfby9hQNulYEmWrU8YiU+ItSZn/
        xT8ND00HbeJY+GnSaNJcYLnBRIqE/GBYY6VcQTo+oj/xcL4Q5cksScvPlG93D0L+4vo1gsPc8pR
        5BDxLiLXkoyHQjCp+g3s1NGleHEnDjc7GIA==
X-Received: by 2002:a19:c8c1:: with SMTP id y184mr9396187lff.598.1604508491637;
        Wed, 04 Nov 2020 08:48:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxA8oto2QBjtj8rsxoiQSXv0NCxhjOrqf99u35glcmFItb8CIJAPpqiWTempkHYDh/yi1dm4af0IhmeZ+Y8Tes=
X-Received: by 2002:a19:c8c1:: with SMTP id y184mr9396149lff.598.1604508489965;
 Wed, 04 Nov 2020 08:48:09 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdo-jFy4anQaVvQqtYgjRvG8w-TNNLOUU5JL11gQF_rCpQ@mail.gmail.com>
In-Reply-To: <CAFftDdo-jFy4anQaVvQqtYgjRvG8w-TNNLOUU5JL11gQF_rCpQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 4 Nov 2020 17:47:59 +0100
Message-ID: <CAFqZXNsJ9Wnfe4cLpzq2-8_zCHOC=46swsRM7h7iX-kbgy3uLQ@mail.gmail.com>
Subject: Re: Changes to Travis Usage
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 4, 2020 at 4:35 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> TL;DR
> Travis is limiting us to 1000mins of build and we should file for an
> opensource exception so we don't have to pay/throttled. We may want to
> consider migrating to Github Actions.
>
> Travis is changing, as pointed out before:
>   - https://lore.kernel.org/selinux/CAFqZXNspH6MmB-o0wtJJwj-p0DKKrH-ZjfW2YkF_yQS_gCBwqQ@mail.gmail.com/T/#t
>
> We had to migrate from .org to .com. Apparently, their usage and
> billing changes are about to occur, see:
> https://blog.travis-ci.com/2020-11-02-travis-ci-new-billing

Yeah, I found out about it just today :(

>
> Dockerhub[1] *was* doing the same thing with pulls, but just switched
> their stance back. I recently changed some of my projects from
> dockerhub to Github Container Registry and used Github Actions to
> build the containers. Github Actions should be a replacement to
> Travis, and includes Ubuntu 16-04, 18-04, 20-04, Windows and Mac[2]. I
> am not sure if it has KVM enabled.

I tried it recently and unfortunately no, GH Actions don't have KVM
enabled :/ It should be usable for the other stuff, though.

>
> 1. https://www.docker.com/blog/what-you-need-to-know-about-upcoming-docker-hub-rate-limiting/
> 2. https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

