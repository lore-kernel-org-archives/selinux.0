Return-Path: <SRS0=i4eR=WH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72078C433FF
	for <selinux@archiver.kernel.org>; Sun, 11 Aug 2019 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBBC20880
	for <selinux@archiver.kernel.org>; Sun, 11 Aug 2019 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Y1IPvQAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfHKPdN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 11 Aug 2019 11:33:13 -0400
Received: from mailomta11-sa.btinternet.com ([213.120.69.17]:25062 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726424AbfHKPdN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 11 Aug 2019 11:33:13 -0400
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20190811153310.SZHA29969.sa-prd-fep-044.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Sun, 11 Aug 2019 16:33:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1565537590; 
        bh=ZWuv7yOoICTqgv4CnNC5bMBsvVk2wAn9ROUlRJiB1wQ=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=Y1IPvQAedCTL7gLarNyWL1Y+X1pUQJNzUhSNQydjM9uwixisYbIs45+AjJXxo2EKJsBTOBJxTS8pqULsGPvMmSE3C3+PK+NnDsvIajicKzaSdV8nhKoUmt69DAkXzQQgEubalnHy8rcD14loecXTajAMqqa30MDX4EgklcPENgR1QCvj/WYBAukOEAHsCjTKNUXs43pio1OQbY8tXLYj2cvcB07pDt0lhbvauG4DVL84Z08A4qrp0h7TZo7bMrtmW8OVRDGwwSM6W+BTmgV56rqsVmRnMbQ2zUw9MT0tjAjzBjy37QF6dxStSm+JEdX84krhgyPSETnJT6/XT5W+cg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.7.114]
X-OWM-Source-IP: 86.134.7.114 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddruddvvddgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdejrdduudegnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdejrdduudegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.7.114) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.335.01) (authenticated as richard_c_haines@btinternet.com)
        id 5D3F923401798279; Sun, 11 Aug 2019 16:33:10 +0100
Message-ID: <644be7b7811eb9d19a55af7a13602961d138cf47.camel@btinternet.com>
Subject: Re: [PATCH V2 1/2] selinux-testsuite: Add BPF tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Date:   Sun, 11 Aug 2019 16:33:08 +0100
In-Reply-To: <5a668ff82b2d3786ec0b816f78fc058012ee470f.camel@btinternet.com>
References: <20190801111232.5589-1-richard_c_haines@btinternet.com>
         <CAHC9VhS+76AW-qVO_DRGaGdVz25mX0hbiz1V2dGAX7mEyi3yXQ@mail.gmail.com>
         <5a668ff82b2d3786ec0b816f78fc058012ee470f.camel@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2019-08-09 at 17:55 +0100, Richard Haines wrote:
> On Fri, 2019-08-09 at 11:22 -0400, Paul Moore wrote:
> > On Thu, Aug 1, 2019 at 7:12 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > This adds basic BPF tests for map and prog functions.
> > > 
> > > The check-syntax script has been modified to exclude files listed
> > > in tools/chk_c_exclude. This is because of macros in bpf_common.c
> > > that get horribly reformatted by check-syntax.
> > > 
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > ---
> > > V2 Change - Split BPF code into bpf_common.c for others to use.
> > > 
> > >  README.md              |  4 +-
> > >  defconfig              |  5 +++
> > >  policy/Makefile        |  4 ++
> > >  policy/test_bpf.te     | 77 ++++++++++++++++++++++++++++++++
> > >  tests/Makefile         |  4 ++
> > >  tests/bpf/.gitignore   |  2 +
> > >  tests/bpf/Makefile     | 12 +++++
> > >  tests/bpf/bpf_common.c | 99
> > > ++++++++++++++++++++++++++++++++++++++++++
> > >  tests/bpf/bpf_test.c   | 83 +++++++++++++++++++++++++++++++++++
> > >  tests/bpf/test         | 57 ++++++++++++++++++++++++
> > >  tools/check-syntax     |  2 +-
> > >  tools/chk_c_exclude    |  1 +
> > >  12 files changed, 348 insertions(+), 2 deletions(-)
> > >  create mode 100644 policy/test_bpf.te
> > >  create mode 100644 tests/bpf/.gitignore
> > >  create mode 100644 tests/bpf/Makefile
> > >  create mode 100644 tests/bpf/bpf_common.c
> > >  create mode 100644 tests/bpf/bpf_test.c
> > >  create mode 100755 tests/bpf/test
> > >  create mode 100644 tools/chk_c_exclude
> > 
> > ...
> > 
> > > diff --git a/tools/check-syntax b/tools/check-syntax
> > > index 7f9768d..5b7c211 100755
> > > --- a/tools/check-syntax
> > > +++ b/tools/check-syntax
> > > @@ -11,7 +11,7 @@
> > >  #
> > > 
> > >  CHK_C_LIST="$(find tests/ -name "*.c") $(find tests/ -name
> > > "*.h")"
> > > -CHK_C_EXCLUDE=""
> > > +CHK_C_EXCLUDE="$(cat tools/chk_c_exclude)"
> > > 
> > >  CHK_PERL_LIST="$(find tests/ -name "*.pl") $(find tests/ -name
> > > "test")"
> > >  CHK_PERL_EXCLUDE=""
> > > diff --git a/tools/chk_c_exclude b/tools/chk_c_exclude
> > > new file mode 100644
> > > index 0000000..20facbf
> > > --- /dev/null
> > > +++ b/tools/chk_c_exclude
> > > @@ -0,0 +1 @@
> > > +tests/bpf/bpf_common.c
> > 
> > Why are we excluding bpf_common.c from the style checks?
> 
> Because check-syntax reformats a macro and it is not neat and tidy
> said
> Mr Neat to Mr Tidy

Just a thought - The patches run the fdreceive with bpf support before
the core bpf test. I could resubmit the patches to test core bpf first
?? (and allow Mr Messy to format the macros in bpf_common.c)
>  

