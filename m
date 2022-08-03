Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA285C19F28
	for <selinux@archiver.kernel.org>; Wed,  3 Aug 2022 08:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiHCIxz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Aug 2022 04:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiHCIxy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Aug 2022 04:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C15A512608
        for <selinux@vger.kernel.org>; Wed,  3 Aug 2022 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659516832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6/OmyFlwKgo1+IlQuFbjGCUtNX4/zpQJPfW/s0aUUpM=;
        b=WOslejriSRYIRw6fneU4HgFMjc7pxD9MD3z70MuxGgBKYL+CBWdvjEdb0ch3l/EmXVamFk
        0RLgwN3YIVozo29ygiic6dZTwSqZqiPxn4z7mdfE6xMVJtG/Ee33/bJZ7N0qH2PEudNTLU
        2aYcp5LUqV8kD0KcG2BIklobNdHRLsE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-yt6iAhPjPMyT1y2Zlq4m0w-1; Wed, 03 Aug 2022 04:53:51 -0400
X-MC-Unique: yt6iAhPjPMyT1y2Zlq4m0w-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-3230031a80fso131020317b3.5
        for <selinux@vger.kernel.org>; Wed, 03 Aug 2022 01:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6/OmyFlwKgo1+IlQuFbjGCUtNX4/zpQJPfW/s0aUUpM=;
        b=GDT72YZ/05bCDxc1w1A2MwDwywik9qsYbSiP2pKTzmmv1rdtBScSah7MiIxFe0ZlXU
         Eag9nANO7wbgGIoLhfP4a2dmGIp7ftAsBx8zKtQ39X6UqHmNInrlvh/lQtuMtdeGfWV3
         Tjov/BhSZoXYsKFV6hcZIxionGC0u7F1evDVtrHjcm6kVq9oO4OjjvlGMtfsmKcB8zmg
         zCJ/6mMqz92o+Jm9Sc2+9yegB5cAMb4rranNm+ht9ruoFeWXkXOiHoFqvBKkFyYEQ6cB
         WGGMFK1/9zxCYs91JAtGDCGXTbMYNusLgheY7eJ9yhYM8zMpPslMhfvo0Ty0jsT8nMc3
         Fy0A==
X-Gm-Message-State: ACgBeo1g7ttkt84c4PPfRi4MMiF4/uyGzAodIIh2m6I96T5mMaMD7K8u
        LuEntwA6V1f8C71yu0BrJlVlaTn9m1QpQJzf1Sa0FMXKtU6DpwouVzNqd37LiCu6w9WHivwI2/y
        xuuhall1SRK+ywpbHOllY6kukY8VddhrHzw==
X-Received: by 2002:a0d:c745:0:b0:324:8800:f63d with SMTP id j66-20020a0dc745000000b003248800f63dmr16049044ywd.106.1659516830837;
        Wed, 03 Aug 2022 01:53:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6/8hbKPbbbVuOiKW4HrjA9RXCPwCn3wg2keMOaFDzdRO7sbVJy9Q544GxoKl8JO1DxsQU82RV6qdkh10EpPJM=
X-Received: by 2002:a0d:c745:0:b0:324:8800:f63d with SMTP id
 j66-20020a0dc745000000b003248800f63dmr16049033ywd.106.1659516830590; Wed, 03
 Aug 2022 01:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220729120229.207584-1-omosnace@redhat.com> <20220729120229.207584-9-omosnace@redhat.com>
 <402ab967-1d76-40bc-f901-8c0339ef8b45@linux.microsoft.com>
In-Reply-To: <402ab967-1d76-40bc-f901-8c0339ef8b45@linux.microsoft.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 3 Aug 2022 10:53:39 +0200
Message-ID: <CAFqZXNtq5-BwaDFjGPX6fPbg304-Mm7eMo0mNy6PrpuK9B7eCQ@mail.gmail.com>
Subject: Re: [PATCH testsuite 08/24] policy: move userdom_sysadm_entry_spec_domtrans_to()
 to general policy
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 2, 2022 at 3:55 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
> On 7/29/2022 8:02 AM, Ondrej Mosnacek wrote:
> > This is good to have for pretty much all domains, so remove the
> > individual calls and move it to test_general.te.
> >
>
> For whatever reason, test_sysnice.te uses
>
> domain_transition_pattern(sysadm_t, test_file_t, setnicedomain)
>
> instead of userdom_sysadm_entry_spec_domtrans_to().  I think the access
> added in the global attribute here covers that and the
> domain_transition_pattern() there can be deleted as well.
>
> Between that and the change to test_setnice.te in Patch 9, this comment
> above those two lines seems obsolete and can probably be deleted:
>
> # Allow all of these domains to be entered from sysadm domain
> # via a shell script in the test directory or by....]

Oh, true... I did carefully search and remove all individual
references to unconfined* but not sysadm*. I'll try to clean those up,
too.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

