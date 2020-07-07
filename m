Return-Path: <SRS0=l4yV=AS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68429C433DF
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 14:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD97206E2
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 14:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlTPwUem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgGGOum (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:50:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51797 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728067AbgGGOum (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jul 2020 10:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594133441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L6dYnGxIK2WpTFqzm60T5Q4RMtjrHkNRZMnjrwAIS1I=;
        b=FlTPwUemMYT7EtWWO63TevP1cVjbkmqutkEN+8UjN6acB1nQxsvSF8MT4CEBreAGUBNTPc
        swWRzK4cI/WSkq/CXEXc8e4wag6TndaneIrOKQkRUSqXQAzRdGhsTO9SbZzEHIV3qevHwD
        ay+JRZBdAZvN0z5tFo9uY3iNYuNxGCk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-HXX--96bOSWO1WyavWq8Ug-1; Tue, 07 Jul 2020 10:50:39 -0400
X-MC-Unique: HXX--96bOSWO1WyavWq8Ug-1
Received: by mail-lj1-f199.google.com with SMTP id e3so25110565ljp.14
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2020 07:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6dYnGxIK2WpTFqzm60T5Q4RMtjrHkNRZMnjrwAIS1I=;
        b=EMU/+tnznyBdNVR36NBjKYTJLVZRwwL0ceR9Ar7KEbqDQPW/RiTy3mhuDH58+YGvQF
         Z37dnvkgxuA1vYoaR6h3mWtCGJnEMe9szzmAfmNWT+ryIOxvT4RlZTuPjDDYefaH9ZML
         s63c8XerdVgl7yXLtZHxp+KcXW+3b4tbfThmB0MYDsIUqEIOQlMS8DXg0iLKqIn4XoAb
         UEs9T84frYRWvXlis0MxrupA5FDy1qbZBwA51fySknmRmQSVleJs5pKMJ/nXaO5O5VB3
         1Zs2ZB2rtHx/r++0Iyj8UtsON4MuhwsIvn3EH/kjHbiR4ySrcd+iEYjD28GYlQ3aYYzG
         KrWQ==
X-Gm-Message-State: AOAM5312yRSQ1jjrlDJ5UKZUrZNPKRYM6SoBM8mSzWmlyZ4f3DCgfEKp
        44jWTQ8rnZJ+58EC/xyNU1PmtmN56xSVpP+LaI5kzJeqwoCafpfm3kWuLiC2A8YJxr6NXZTMiQz
        zsBS8xNS1Yw40ELiMQkU/epqixXvYk2rFXA==
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr15417084ljn.38.1594133437752;
        Tue, 07 Jul 2020 07:50:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSJJpNvVys4++M3/DyA2n6LhPCyYeWEKmq3hrHJXMonNEIrVyi6JQ0dHqLr406muuXR582dlOHkPU5u33DAXE=
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr15417065ljn.38.1594133437552;
 Tue, 07 Jul 2020 07:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200702143508.24143-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200702143508.24143-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 7 Jul 2020 16:50:26 +0200
Message-ID: <CAFqZXNt9BHra05Xuj6U7uMe6Qyf-Et65qWMCOqLCBp4hiXAB=w@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Remove unused sctp code
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 2, 2020 at 4:35 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Removed obsolete code that was used to test permissions that never made it
> to the final commit.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  tests/sctp/.gitignore          |   2 -
>  tests/sctp/Makefile            |   2 +-
>  tests/sctp/sctp_set_params.c   | 205 ---------------------------------
>  tests/sctp/sctp_set_pri_addr.c | 135 ----------------------
>  4 files changed, 1 insertion(+), 343 deletions(-)
>  delete mode 100644 tests/sctp/sctp_set_params.c
>  delete mode 100644 tests/sctp/sctp_set_pri_addr.c

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

