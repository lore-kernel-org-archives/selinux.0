Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB76DC433FE
	for <selinux@archiver.kernel.org>; Thu, 18 Nov 2021 08:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9312361B93
	for <selinux@archiver.kernel.org>; Thu, 18 Nov 2021 08:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbhKRIUh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Nov 2021 03:20:37 -0500
Received: from mailomta29-sa.btinternet.com ([213.120.69.35]:15268 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244372AbhKRISh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Nov 2021 03:18:37 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20211118081534.IUMX18908.sa-prd-fep-043.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 18 Nov 2021 08:15:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1637223334; 
        bh=ajo/99vsSb9KqgbHCNKNgLvl8T8mK/V1syJOjq4G+5s=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=rdNtRcAcy3HhPJtltCn+CMQt48RgyypiVa4aOdysgZAAupH9j5bB7bD5uk09AHHYIGtzbtzLpefwDBc//77Ot9oDFt49ARy5DkutlWqYcobI5YrOj55b/ZNuQigFSnWqkZWtUKcFNZvv3o8TD2n8hhclfaYH3/yRWHA2fug5r01WSEePmbD8LD4SomxX5pMN7ynUfC7sw11bk6zGYaCoyToQXU0kxqnOin2LDMi8iK24dpWMJKChmfykdZa2y4qcnCX3uBPr28to9/lHDatlfCjbh/+h7B+tE8iYMZevsihfPZf5S76L2blZZieCtk6oDFgMbMed1eVN+kmV2bJtYw==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6139452E0A5FA57D
X-Originating-IP: [81.154.250.252]
X-OWM-Source-IP: 81.154.250.252 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrfeehgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepjeehlefhgfeftddtgeekffdugeefieeiueffffejtefgkeejuedthfevleefheffnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppeekuddrudehgedrvdehtddrvdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudelkegnpdhinhgvthepkedurdduheegrddvhedtrddvhedvpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (81.154.250.252) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139452E0A5FA57D; Thu, 18 Nov 2021 08:15:34 +0000
Message-ID: <39a355a3d56b14d4f6b7323ad34e93b29666ffb7.camel@btinternet.com>
Subject: Re: [PATCH V2] netlabel: Update man page to clarify SELinux labeling
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org
Date:   Thu, 18 Nov 2021 08:15:34 +0000
In-Reply-To: <20211116163838.10888-1-richard_c_haines@btinternet.com>
References: <20211116163838.10888-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2021-11-16 at 16:38 +0000, Richard Haines wrote:
> Clarify how SELinux setsockcreatecon(3) and policy socket* class
> type_transition rules can impact domain:<domain> entries.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2: Clarify the labels returned using getsockopt(2)
> 
>  doc/man/man8/netlabelctl.8 | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/man/man8/netlabelctl.8 b/doc/man/man8/netlabelctl.8
> index bb00096..2a7852b 100644
> --- a/doc/man/man8/netlabelctl.8
> +++ b/doc/man/man8/netlabelctl.8
> @@ -57,7 +57,9 @@ Display the kernel's list of supported labeling
> protocols.
>  The domain mapping module is used to map different NetLabel labeling
> protocols
>  to either individual LSM domains or the default domain mapping.  It is
> up to
>  each LSM to determine what defines a domain.  With SELinux, the normal
> SELinux
> -domain should be used, i.e. "ping_t".  In addition to protocol
> selection based
> +domain should be used, i.e. "ping_t" (however see the
> +.B NOTES
> +section below regarding SElinux).  In addition to protocol selection
> based
>  only on the LSM domain, it is also possible to select the labeling
> protocol
>  based on both the LSM domain and destination address.  The network
> address
>  selectors can specify either single hosts or entire networks and work
> for both
> @@ -259,6 +261,31 @@ The static, or fallback, labels are only supported
> on Linux Kernels version
>  Linux Kernels 2.6.28 and later and CALIPSO/RFC5570 is only supported
> on Linux
>  Kernels 4.8.0 and later.
>  .P
> +When using the SELinux LSM, it is generally assumed that the
> +.I type
> +component of the process security label should be used as the
> +.I domain:<domain>
> +entry. However, NetLabel services actually use the socket security
> label to
> +determine labeling.  Normally this would be the same
> +.I type
> +component as the process (as by default the socket inherits the
> process
> +label).  There are cases where this matters, as it is possible with
> SELinux
> +to set a different label on the socket using the libselinux function
> +.BR setsockcreatecon (3),
> +or a policy socket* class
> +.I type_transition
> +rule.  Should these be used to change a socket label, then the new
> socket
> +.I type
> +must be used in the
> +.I domain:<domain>
> +entry instead.
> +If fallback labeling is configured and a new socket label is set on
> the
> +client, the server will show that label when
> +.BR getsockopt (2)
> +with
> +.I optname=SO_PEERSEC
> +is called.
> +.P
>  The NetLabel project site, with more information including the source
> code
>  repository, can be found at https://github.com/netlabel.  Please
> report any
>  bugs at the project site or directly to the author.

Are these really bugs or just features ?? The new tests in [1] treat
them as features.

[1] https://lore.kernel.org/selinux/20211117131450.41705-1-richard_c_haines@btinternet.com/
https://lore.kernel.org/selinux/20211117131450.41705-1-richard_c_haines@btinternet.com/

