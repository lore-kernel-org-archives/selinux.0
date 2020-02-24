Return-Path: <SRS0=m/sx=4M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E5C3567B
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 09:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A6520658
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 09:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFvjaSRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBXJRZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:17:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59402 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgBXJRZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 04:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582535843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/fKsDtxSAzMIh6BDAj358XjJ/ekm/gCjQo0tpt4kAQ=;
        b=YFvjaSRv+hUy3eb0EhTZAgBYTnSNKd7IplMC8zw/cyU6zPSX8zxocNUpVqYMqiBFDBhxGP
        oWv/opNDtG7YiqudMtXAK7X1V87jzHOJOFR5aIkFbuCmkLNMxeohsWzF2caMvliuUYCZFY
        euBwGjAgQo+dw3Okf7MbS9Z0+mggtqs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-Tx4sSqdAOT-gDAwj8wuG7g-1; Mon, 24 Feb 2020 04:17:18 -0500
X-MC-Unique: Tx4sSqdAOT-gDAwj8wuG7g-1
Received: by mail-ot1-f70.google.com with SMTP id d16so5711765otf.5
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 01:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N/fKsDtxSAzMIh6BDAj358XjJ/ekm/gCjQo0tpt4kAQ=;
        b=nYBVH5N6i61lLHtqKQaampwq4iV+aNUTqNqiPW/hnV//4vsa7rif1qqbC/1i3RRBGU
         p+nwifi7tIGTg87USatFSjNgXWVoJEgRSpA6+TTOKNT99RoVZml46xD2V9mGM+If9HqA
         efImMR1g34ge7g4uttRGsKPvZ7Dzn+u3gg//B7tZZcK1OwAy0ecHz6Z2tbTjw7D7ni1x
         O0zGrmyj6xJ3m13jkBsWROlJdCjQI/7gAOU64Px2AJYDKV3OerjiYJBJk649osrbV2Dl
         zq2XD0oHBETbMkgtiO2Xfo/y2hExW1UOvpzvNWQn0T8ffqvu3id0lXovVd1sPY2ZNdF4
         9SVw==
X-Gm-Message-State: APjAAAX5+094jEEFIul5m6BwCJ29YrEPww/kdcKcGUFvt27BeXccbhdj
        iArNU1Y8bwbUDS9g5n6dQCGtDQrhCLq7qg8eZA+5uAc4aZ7h5z2BZnALcfquy+2TsmdrOxhhyyr
        957yFwDS//xCI1dKTgI0AjJv+jPTcnZpm2w==
X-Received: by 2002:aca:514e:: with SMTP id f75mr12343821oib.103.1582535837631;
        Mon, 24 Feb 2020 01:17:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPLrq0wTOhHpLHGOtIpA4JFgxJILmp7yaf1lWt5isYMlJWblokNpIaxenEogKenazMafElLgv4QLAl5aFEHws=
X-Received: by 2002:aca:514e:: with SMTP id f75mr12343813oib.103.1582535837387;
 Mon, 24 Feb 2020 01:17:17 -0800 (PST)
MIME-Version: 1.0
References: <cki.C91ED894FB.V073T4NSBU@redhat.com>
In-Reply-To: <cki.C91ED894FB.V073T4NSBU@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 24 Feb 2020 10:17:06 +0100
Message-ID: <CAFqZXNvnywGVwqJhXcfwpmx2mmu8ajAUOdy0Ny8PvsT=Rg_3Qg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOKdjCBGQUlMOiBUZXN0IHJlcG9ydCBmb3Iga2VybmVsIDUuNC4yMi1yYzItYjBiNA==?=
        =?UTF-8?B?MTMwLmNraSAoc3RhYmxlKQ==?=
To:     CKI Project <cki-project@redhat.com>
Cc:     Linux Stable maillist <stable@vger.kernel.org>,
        Milos Malik <mmalik@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 23, 2020 at 10:44 PM CKI Project <cki-project@redhat.com> wrote=
:
> Hello,
>
> We ran automated tests on a recent commit from this kernel tree:
>
>        Kernel repo: git://git.kernel.org/pub/scm/linux/kernel/git/stable/=
linux-stable-rc.git
>             Commit: b0b41307fca1 - Linux 5.4.22-rc2
>
> The results of these automated tests are provided below.
>
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: FAILED
>
> All kernel binaries, config files, and logs are available for download he=
re:
>
>   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=3Dda=
tawarehouse/2020/02/23/453522
>
> One or more kernel tests failed:
>
>     ppc64le:
>      =E2=9D=8C selinux-policy: serge-testsuite
>      =E2=9D=8C Boot test
>
>     aarch64:
>      =E2=9D=8C selinux-policy: serge-testsuite
>
>     x86_64:
>      =E2=9D=8C selinux-policy: serge-testsuite

The SELinux testsuite failed due to the kernel headers being newer
than the running kernel itself. It is not (AFAICT) a bug in the
kernel. For more details see this patch, which should make the
testsuite work also in such situation:

https://github.com/SELinuxProject/selinux-testsuite/commit/859ccfd0a00970ab=
3f2459e19f2f3c3d950b8ed4

I need to test it and then I'll send it to the list for review.

>
> We hope that these logs can help you find the problem quickly. For the fu=
ll
> detail on our testing procedures, please scroll to the bottom of this mes=
sage.
>
> Please reply to this email if you have any questions about the tests that=
 we
> ran or if you have any suggestions on how to make future tests more effec=
tive.
>
>         ,-.   ,-.
>        ( C ) ( K )  Continuous
>         `-',-.`-'   Kernel
>           ( I )     Integration
>            `-'
[...]

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

