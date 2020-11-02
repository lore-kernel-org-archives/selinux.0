Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D1C00A89
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 12:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5341D22226
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 12:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="svJGmzuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgKBMFE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 07:05:04 -0500
Received: from mailomta22-sa.btinternet.com ([213.120.69.28]:32416 "EHLO
        sa-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728253AbgKBMFD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 07:05:03 -0500
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20201102120501.HYTT8377.sa-prd-fep-049.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Mon, 2 Nov 2020 12:05:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1604318701; 
        bh=ech8KrjmteucTYhFXBBa1kPljRgnX4XctvyY1GkXy5w=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=svJGmzuYsbnD1e4NRx2FPZrqljSfDQdL3MF6dQIcQkLzKi9AA/+x94XI4z0eFxTkw6BN+VaFq1yIh3OQZBI8upfcithxetQSbwqLRn0LbSEXHyptjkVV/gVYUyMUTpHNz64HhwzX2U1wDXq+Kk7L/N+zE451hAu2cw65XY2EVXvnyDuZZRRwCe2BN5UfwPyHiZZ+PK9WDiF+Va5ioPE0CutzjD0FfQnJsQ3P8WMCEgsSIj5D3PimOout2wMRcOHjEIq7aZ1ZIzJrRgEHiljbJ0H6PUVCv4s1VS+ebLJ+3wrVf1J5YVA52dNruPix+hxv3uF33gWngnI8yfI/quhyoA==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9B66118C30F16
X-Originating-IP: [109.155.32.143]
X-OWM-Source-IP: 109.155.32.143 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeeftdffkeeikedugedvkeejheeiffevveelgedtleduteevudelffdugffgieenucfkphepuddtledrudehhedrfedvrddugeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrdefvddrudegfedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.143) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B66118C30F16; Mon, 2 Nov 2020 12:05:01 +0000
Message-ID: <83bf40215c21e67489a6379fcd1c89dcd7e2e031.camel@btinternet.com>
Subject: Re: [PATCH testsuite v2 0/4] Test all filesystems by default
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>
Date:   Mon, 02 Nov 2020 12:04:35 +0000
In-Reply-To: <20201102083516.477149-1-omosnace@redhat.com>
References: <20201102083516.477149-1-omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-11-02 at 09:35 +0100, Ondrej Mosnacek wrote:
> This series enables testing all filesystems currently supported by
> the
> testsuite (ext4, xfs, jfs, vfat) using the [fs_]filesystem subtests
> without the need to run the tests manually or move to a different
> filesystem. The filesystems not available on the tested kernel are
> automatically excluded.
> 
> The series also updates dependencies with the packages containing the
> required mkfs.* programs, fixes the mkfs.* invocation to not get
> stuck
> when testing jfs, and fixes error output appearing during a
> successful
> vfat test.
> 
> Note: The F32 CI will start failing after this and the kernel update
> patches are merged (the old kernel on the image doesn't have the XFS
> quota fix). It will be necessary to bump the stable Fedora testing to
> F33.
> 
> v2 changes:
>  - added a patch to fix the vfat tests output
>  - fixed behavior when fs tests are executed directly
>  - simplified the code changed/added by the last patch
> 
> Ondrej Mosnacek (4):
>   README,travis: add e2fsprogs, jfsutils, and dosfstools to deps
>   tests/filesystem: pipe "yes" to mkfs.* to fix jfs test
>   tests/[fs_]filesystem: fix unwanted error output when testing vfat
>   tests/[fs_]filesystem: test all filesystems


Apart from the minor nit in patch 1, all fs types tested okay so:

Acked-by: Richard Haines <richard_c_haines@btinternet.com>

> 
>  README.md                      |  6 ++++
>  tests/Makefile                 |  8 +++--
>  tests/filesystem/Filesystem.pm |  2 +-
>  tests/filesystem/ext4          |  1 +
>  tests/filesystem/jfs           |  1 +
>  tests/filesystem/test          | 58 +++++++++++++++---------------
>  tests/filesystem/vfat          |  1 +
>  tests/filesystem/xfs           |  1 +
>  tests/fs_filesystem/ext4       |  1 +
>  tests/fs_filesystem/jfs        |  1 +
>  tests/fs_filesystem/test       | 64 ++++++++++++++++--------------
> ----
>  tests/fs_filesystem/vfat       |  1 +
>  tests/fs_filesystem/xfs        |  1 +
>  travis-ci/run-testsuite.sh     |  3 ++
>  14 files changed, 83 insertions(+), 66 deletions(-)
>  create mode 120000 tests/filesystem/ext4
>  create mode 120000 tests/filesystem/jfs
>  create mode 120000 tests/filesystem/vfat
>  create mode 120000 tests/filesystem/xfs
>  create mode 120000 tests/fs_filesystem/ext4
>  create mode 120000 tests/fs_filesystem/jfs
>  create mode 120000 tests/fs_filesystem/vfat
>  create mode 120000 tests/fs_filesystem/xfs
> 

