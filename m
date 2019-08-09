Return-Path: <SRS0=nXDU=WF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AB4C31E40
	for <selinux@archiver.kernel.org>; Fri,  9 Aug 2019 16:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CCE2086A
	for <selinux@archiver.kernel.org>; Fri,  9 Aug 2019 16:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="mPwFfaOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407499AbfHIQ4D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:56:03 -0400
Received: from mailomta21-re.btinternet.com ([213.120.69.114]:64563 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407474AbfHIQ4C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Aug 2019 12:56:02 -0400
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20190809165600.DTDQ6048.re-prd-fep-045.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Fri, 9 Aug 2019 17:56:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1565369760; 
        bh=+CMFNPx0TyjdqAjXzCA6+DYOKDY2VoB1F5901qGxiwM=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=mPwFfaObIKKQyj10q7tib0aPECnaa+fd8BlmDbF8C5l7WWo3pcuZhSoYQojmP6uV4uq8oNxDM9210JI3o8ecoOjWjoE6PDTmdNjcvpbxnkFMstePJI0a5pAGRycAi3TRkiqgW7a7vN8sq7DcT2DHwL1Cc/nZOaR6dDIWQ4IwqTVi7QMpO/S2dat2En2ryQRjtweUhBRR1f87EMmMK6Kr2miboze4paYYaetA1V8nDzzR6UlQBKVc4mA8YZ0eog0W2sH30Gl3zStqrs+MqyCQOlLxf2Ll/zzxOZIv/cu49vrOBL8bHOasgrsR16h3X4wPYSZXxcEmvECWRQQgebLXiw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.35]
X-OWM-Source-IP: 86.134.6.35 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddruddujedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedriedrfeehnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirdefhedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.35) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.335.01) (authenticated as richard_c_haines@btinternet.com)
        id 5D3F9015013BC15C; Fri, 9 Aug 2019 17:56:00 +0100
Message-ID: <5a668ff82b2d3786ec0b816f78fc058012ee470f.camel@btinternet.com>
Subject: Re: [PATCH V2 1/2] selinux-testsuite: Add BPF tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Date:   Fri, 09 Aug 2019 17:55:58 +0100
In-Reply-To: <CAHC9VhS+76AW-qVO_DRGaGdVz25mX0hbiz1V2dGAX7mEyi3yXQ@mail.gmail.com>
References: <20190801111232.5589-1-richard_c_haines@btinternet.com>
         <CAHC9VhS+76AW-qVO_DRGaGdVz25mX0hbiz1V2dGAX7mEyi3yXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2019-08-09 at 11:22 -0400, Paul Moore wrote:
> On Thu, Aug 1, 2019 at 7:12 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > This adds basic BPF tests for map and prog functions.
> > 
> > The check-syntax script has been modified to exclude files listed
> > in tools/chk_c_exclude. This is because of macros in bpf_common.c
> > that get horribly reformatted by check-syntax.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > V2 Change - Split BPF code into bpf_common.c for others to use.
> > 
> >  README.md              |  4 +-
> >  defconfig              |  5 +++
> >  policy/Makefile        |  4 ++
> >  policy/test_bpf.te     | 77 ++++++++++++++++++++++++++++++++
> >  tests/Makefile         |  4 ++
> >  tests/bpf/.gitignore   |  2 +
> >  tests/bpf/Makefile     | 12 +++++
> >  tests/bpf/bpf_common.c | 99
> > ++++++++++++++++++++++++++++++++++++++++++
> >  tests/bpf/bpf_test.c   | 83 +++++++++++++++++++++++++++++++++++
> >  tests/bpf/test         | 57 ++++++++++++++++++++++++
> >  tools/check-syntax     |  2 +-
> >  tools/chk_c_exclude    |  1 +
> >  12 files changed, 348 insertions(+), 2 deletions(-)
> >  create mode 100644 policy/test_bpf.te
> >  create mode 100644 tests/bpf/.gitignore
> >  create mode 100644 tests/bpf/Makefile
> >  create mode 100644 tests/bpf/bpf_common.c
> >  create mode 100644 tests/bpf/bpf_test.c
> >  create mode 100755 tests/bpf/test
> >  create mode 100644 tools/chk_c_exclude
> 
> ...
> 
> > diff --git a/tools/check-syntax b/tools/check-syntax
> > index 7f9768d..5b7c211 100755
> > --- a/tools/check-syntax
> > +++ b/tools/check-syntax
> > @@ -11,7 +11,7 @@
> >  #
> > 
> >  CHK_C_LIST="$(find tests/ -name "*.c") $(find tests/ -name "*.h")"
> > -CHK_C_EXCLUDE=""
> > +CHK_C_EXCLUDE="$(cat tools/chk_c_exclude)"
> > 
> >  CHK_PERL_LIST="$(find tests/ -name "*.pl") $(find tests/ -name
> > "test")"
> >  CHK_PERL_EXCLUDE=""
> > diff --git a/tools/chk_c_exclude b/tools/chk_c_exclude
> > new file mode 100644
> > index 0000000..20facbf
> > --- /dev/null
> > +++ b/tools/chk_c_exclude
> > @@ -0,0 +1 @@
> > +tests/bpf/bpf_common.c
> 
> Why are we excluding bpf_common.c from the style checks?

Because check-syntax reformats a macro and it is not neat and tidy said
Mr Neat to Mr Tidy
 
> 

