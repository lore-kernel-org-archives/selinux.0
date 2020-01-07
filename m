Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE34AC33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 15:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDE12077B
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 15:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="b4zhX/3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgAGPaI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:30:08 -0500
Received: from mailomta27-re.btinternet.com ([213.120.69.120]:16773 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727944AbgAGPaI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 10:30:08 -0500
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20200107153005.FQJS28894.re-prd-fep-042.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Tue, 7 Jan 2020 15:30:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1578411005; 
        bh=0FGdVtBrygl90q/+AuKbqndxFsY1pcUViWFCHDndEng=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=b4zhX/3LV9gPAIlXW9miEvQpUSAU86xf53KIIstA+XCPgCava1TX6B5K8xwjYST4LRdUC7VaIE+OsJPDVCdC2QYRVzzrif7LPDjxDNxzLO2+e+l89crgPw/ylRlbSFiWM6/M88iVO4/0Ba+2AUgViYHZZzxFFI+34F/uY8leG3Z6w84Ao8LKSsQAQGSWocy9Bkq5u6ro/khiemaLbexoOszobYK7Wt0Yv0bLS7XrxBlpH3a44rkxUMmUl78IOJoSWzMSo54FCFTyXvDVR577OA/qBW/wCm31D2gE8ikBqa7OJxvAH5117dYZFdXJ6OUeaqInl+vyFN4E+18hQSG++w==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.57.177]
X-OWM-Source-IP: 31.49.57.177 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvdehgedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledrheejrddujeejnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledrheejrddujeejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.57.177) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DEE078D04E274C3; Tue, 7 Jan 2020 15:30:05 +0000
Message-ID: <c52431142e96c723c116d9de3769dada82b7ce9e.camel@btinternet.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Date:   Tue, 07 Jan 2020 15:30:05 +0000
In-Reply-To: <CAFqZXNvBocnc_VE0_pq5vSR2o5YA7uGDxZZJj4HMFnj_N5n4RA@mail.gmail.com>
References: <20191220101104.40865-1-richard_c_haines@btinternet.com>
         <20191220101104.40865-2-richard_c_haines@btinternet.com>
         <CAFqZXNvBocnc_VE0_pq5vSR2o5YA7uGDxZZJj4HMFnj_N5n4RA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-01-06 at 17:11 +0100, Ondrej Mosnacek wrote:
> On Fri, Dec 20, 2019 at 11:11 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Test filesystem permissions and setfscreatecon(3).
> > 
> > From kernels 5.5 filesystem { watch } is also tested.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> Please see a few inline comments below.

Thanks for flagging these REL6/7 issues as I only have access to
current Fedora plus Rawhide.
I'll send update later today.

Richard


