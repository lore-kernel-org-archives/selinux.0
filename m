Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D229C00A89
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 12:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04010222B9
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 12:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="fB37B3Gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgKBMDF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 07:03:05 -0500
Received: from mailomta22-sa.btinternet.com ([213.120.69.28]:30880 "EHLO
        sa-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728339AbgKBMDF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 07:03:05 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-046.btinternet.com with ESMTP
          id <20201102120302.EMUX28150.sa-prd-fep-046.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Mon, 2 Nov 2020 12:03:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1604318582; 
        bh=8EVSCnxTP46BpWHz/iW0KvXB/ag2HTO+kgxZkbOGSCo=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=fB37B3GdizLPCMG4ORKg38irEF6CJwHwAR/uka6yzduZDnpzRrViRaCrEBir7wta+Hhb6ZKAGUSKjuazapE7NQP0TrYggyeV6HfGpsdPJR/KF7g/Hk3i7FgW5BmSioNInl98COvfwqzvq+S9ec62vDGciDwTIyPYNMF+Auoz3szQT5MiewvBC4B+rdo9P1r/7w4COa3U68UUCh8dmKaiqWRJZDQAGFaeJLkfZ538wTrDKvjcBUKMK7DbN3JxYwkeRakFLlkPZZJ9L6jVHQVBpsUnySfxFGO4Vy8c42L2YomAIFc4bW3YNRK+ZPsw2/J0nkyo1BWIMba97RuQ1uUr5Q==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9AA6E18C29C7B
X-Originating-IP: [109.155.32.143]
X-OWM-Source-IP: 109.155.32.143 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeeftdffkeeikedugedvkeejheeiffevveelgedtleduteevudelffdugffgieenucfkphepuddtledrudehhedrfedvrddugeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrdefvddrudegfedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.143) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AA6E18C29C7B; Mon, 2 Nov 2020 12:03:02 +0000
Message-ID: <7963858698dc5060170db74f70c5a9cb00b611db.camel@btinternet.com>
Subject: Re: [PATCH testsuite v2 1/4] README,travis: add e2fsprogs,
 jfsutils, and dosfstools to deps
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>
Date:   Mon, 02 Nov 2020 12:02:26 +0000
In-Reply-To: <20201102083516.477149-2-omosnace@redhat.com>
References: <20201102083516.477149-1-omosnace@redhat.com>
         <20201102083516.477149-2-omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-11-02 at 09:35 +0100, Ondrej Mosnacek wrote:
> They are needed for ext4, jfs, and vfat tests, which will become
> executed by default in an upcoming patch.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  README.md                  | 6 ++++++
>  travis-ci/run-testsuite.sh | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/README.md b/README.md
> index 838a082..1149f30 100644
> --- a/README.md
> +++ b/README.md
> @@ -58,6 +58,9 @@ similar dependencies):
>  * keyutils-libs-devel _(tools used by the keys tests)_
>  * kernel-devel _(used by the kernel module tests)_
>  * quota, xfsprogs-devel and libuuid-devel _(used by the filesystem
> tests)_
> +* e2fsprogs _(used by the ext4 filesystem tests)_
> +* jfsutils _(used by the jfs filesystem tests)_
> +* dosfstools _(used by the vfat filesystem tests)_
>  * nftables _(used by inet_socket and sctp tests if ver >= 9.3 for
> secmark testing )_
>  
>  On a modern Fedora system you can install these dependencies with
> the
> @@ -81,6 +84,9 @@ following command (NOTE: On Fedora 32 and below you
> need to remove
>  		quota \
>  		xfsprogs-devel \
>  		libuuid-devel \
> +		e2fsprogs \
> +		jfsutils \
> +		dosfstools \

I guess these should also be under Debian as well.

>  		nftables \
>  		kernel-devel-$(uname -r) \
>  		kernel-modules-$(uname -r)
> diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
> index 051f9d8..bd9073c 100755
> --- a/travis-ci/run-testsuite.sh
> +++ b/travis-ci/run-testsuite.sh
> @@ -38,6 +38,9 @@ dnf install -y \
>      quota \
>      xfsprogs-devel \
>      libuuid-devel \
> +    e2fsprogs \
> +    jfsutils \
> +    dosfstools \
>      kernel-devel-"$(uname -r)" \
>      kernel-modules-"$(uname -r)"
>  

