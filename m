Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83340C28D13
	for <selinux@archiver.kernel.org>; Thu, 25 Aug 2022 13:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiHYNic (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiHYNic (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Aug 2022 09:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCEDB286A
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661434709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6508vxpOyjtz010sdDDb+rDWHhAGeoKmdnOC9tlGs4=;
        b=VbMAzvN1RCNzctOhH3/s44smQA2nf7lq1nbvfB5YnInR7QC+4FsW++UoFBWQywj/A8n+xm
        Aw1uK0TC9uLvVDzocZnZFK7/kXo9naxiwZOUNPNBWNV0u6vGhG6EXgoPdWFZNs7plLeDfp
        MBefjvVfHYdwr7Ed7y74RJh6DxNTw/A=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-552-1Z5rauRRMDi7rxBpGxq6Eg-1; Thu, 25 Aug 2022 09:38:27 -0400
X-MC-Unique: 1Z5rauRRMDi7rxBpGxq6Eg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-31f5960500bso342511607b3.14
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 06:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=j6508vxpOyjtz010sdDDb+rDWHhAGeoKmdnOC9tlGs4=;
        b=7mtPiEqdVdkm8vhgOXfDA1iKrXPSPaRJnmawIMy2hS/O7JpzcwY9HXgZF3+3Gm90HU
         eNB6RH13+l5O9+p6Uf/ZEsW/XAHQFjH5rm3y7XOajNs4PnqKyKF4O4BZUVDR6E/Nsqrk
         dJ+7a8pBfSode1ODENZCuiSBL7iyKkKh3546tpUJrykyO7FjGpCsW6XQKNenpSzvvf65
         wAEpnA91s34a5czFzpgws8CchY/xM/AFyJ03JfFBXFjagIXN8uds4O/1wFjJ6nMUdX9h
         lWGa1ydHY55sV+A9hmpIplfY3CBNaD5aIkx+AqLdIUycEhCM+NaVdd1HZypYcggc47/K
         Hmhw==
X-Gm-Message-State: ACgBeo3+xpOIpUzQhqvbYOJ6n0S9axXITeQsFuvf8hZSPPlNiKvfJPq9
        ZhiA/PWyH4Eth9v5UhwFtack5002aqfRHwhP4+VnqPKfwvC0J62sE4aSGmA7jqMAIbpZJbjtuJ2
        IOXM2bkRwCjapQNDbq8A4tbRCV1NbNMQnhA==
X-Received: by 2002:a0d:f1c4:0:b0:33b:a850:d900 with SMTP id a187-20020a0df1c4000000b0033ba850d900mr3970756ywf.77.1661434707138;
        Thu, 25 Aug 2022 06:38:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5p0mowCIJmJgSxBjFjoAe3FbV0Td6eWl+oL4xYeMp1C5pR6rA/Z62uwxnxfuOsY6x6u96+tUT1sV4u8blq2YA=
X-Received: by 2002:a0d:f1c4:0:b0:33b:a850:d900 with SMTP id
 a187-20020a0df1c4000000b0033ba850d900mr3970738ywf.77.1661434706957; Thu, 25
 Aug 2022 06:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220824111938.567993-1-omosnace@redhat.com> <20220824111938.567993-3-omosnace@redhat.com>
 <d1f0f2c6-6716-9678-361e-4abf03e3cc6b@linux.microsoft.com>
In-Reply-To: <d1f0f2c6-6716-9678-361e-4abf03e3cc6b@linux.microsoft.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 25 Aug 2022 15:38:16 +0200
Message-ID: <CAFqZXNuetZ+s_2PEGX2yqO418U-d3+u4mB4xpUGDARO9k3UdYQ@mail.gmail.com>
Subject: Re: [PATCH testsuite 2/2] test_userfaultfd.te: adapt to upcoming
 Fedora policy changes
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 24, 2022 at 4:10 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
> On 8/24/2022 7:19 AM, Ondrej Mosnacek wrote:
> > We plan to add automatic transitions for anon_inodes to the whole domain
> > attribute, which would conflict with the testsuite's userfaultfd test.
> > To avoid th conflict, use testsuite_domain_type_minimal() for the
> > userfaultfd test domains, which doesn't add the types to the domain
> > attribute.
>
> If you spin a second version, there's a minor typo in the commit message
> ("th conflict").

Yeah, I'll just fix that up locally before pushing to the upstream repo.

>
> Regardless, for both patches:
>
> Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>

Thanks :)

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

