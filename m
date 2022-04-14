Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A0CC433EF
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 12:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbiDNMNF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 08:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243012AbiDNMM3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 08:12:29 -0400
Received: from re-prd-fep-043.btinternet.com (mailomta21-re.btinternet.com [213.120.69.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14411C91B
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 05:10:01 -0700 (PDT)
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20220414121000.LCWW3055.re-prd-fep-043.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Thu, 14 Apr 2022 13:10:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1649938200; 
        bh=g7d9fxhKMKILDTTKmjvoXj32aXm/MyqTyb0ey/mvK4M=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=LzZBvwiRwPCD2cNFtd/aIZdNx/a/+qVKksQUtgyC+evodb5qY+/7IXATpnOvQQxcJ4Z+Z+PkXH2I64pTr3xFuIq8FF3J/HwfxwklR+zFtlD5blBaH89cRZCS1+1B9lp87qsvEEuqD2NKunyZVaUerN9N9+cxXLDC1tzw54ahg56akf61XjWHl1YWAxoTQdGX63VyeCp2F4D5DfeQ+NoFQi288CLQ+dVjAN6zyJKfN/clbKj9nxLwfVMfCkti8Say3WzIDsiM22RqWFgGbJ2KOTPu5p8b3z4NYNiu03BBPNV11K47uQXDJUVApyDSCf5mHpJSyvEscex7atAb6b4slQ==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 61A69BAC12983E3B
X-Originating-IP: [86.133.207.109]
X-OWM-Source-IP: 86.133.207.109 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudelfedggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhkeegheduudeggfffkeehheettefgjedugefhhfevuedvveduhedtleejkeduveenucfkphepkeeirddufeefrddvtdejrddutdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpeekiedrudeffedrvddtjedruddtledpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepohhmohhsnhgrtggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (86.133.207.109) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 61A69BAC12983E3B; Thu, 14 Apr 2022 13:10:00 +0100
Message-ID: <2634e3d64c31ef611d93e2b13c03dbb542969426.camel@btinternet.com>
Subject: Re: [PATCH testsuite v4] tests/sctp: add client peeloff tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Date:   Thu, 14 Apr 2022 13:10:00 +0100
In-Reply-To: <20220413114734.1704750-1-omosnace@redhat.com>
References: <20220413114734.1704750-1-omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2022-04-13 at 13:47 +0200, Ondrej Mosnacek wrote:
> Currently the testsuite only verifies that SCTP peeloff works on the
> server side. However, it can just as well be used on the client side
> as
> well, which isn't being tested (and actually is buggy at the time of
> writing).
> 
> To correct this, add a simple SCTP peeloff client and a couple tests
> that verify that the client-side peeloff works well with SELinux.
> 
> The new tests are enabled on kernels 5.18+, where the fixes were
> introduced. While the fixes are now queued also for some stable
> streams,
> it's much simpler to just check the version against 5.18 and skip the
> test for all older kernels.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
> 
> v4: added a kernel version check
> v3: fixed uninitialized "sinlen" variable in sctp_peeloff_client.c
> v2: rebased and resolved a conflict
> 
>  tests/sctp/.gitignore            |   1 +
>  tests/sctp/Makefile              |   3 +-
>  tests/sctp/sctp_peeloff_client.c | 254
> +++++++++++++++++++++++++++++++
>  tests/sctp/test                  | 170 ++++++++++++++++++++-
>  4 files changed, 419 insertions(+), 9 deletions(-)
>  create mode 100644 tests/sctp/sctp_peeloff_client.c
> 

Tested on kernel 5.18-rc2

Tested-by: Richard Haines <richard_c_haines@btinternet.com>
