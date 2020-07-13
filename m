Return-Path: <SRS0=ArME=AY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9302C433E1
	for <selinux@archiver.kernel.org>; Mon, 13 Jul 2020 10:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A202077D
	for <selinux@archiver.kernel.org>; Mon, 13 Jul 2020 10:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="McgzIhzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgGMKpY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:45:24 -0400
Received: from mailomta7-sa.btinternet.com ([213.120.69.13]:33940 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727035AbgGMKpY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jul 2020 06:45:24 -0400
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20200713104520.JYOF26847.sa-prd-fep-043.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Mon, 13 Jul 2020 11:45:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1594637120; 
        bh=lpLhxUA+UiYDbgI91C3qpp0k3Isyuoiha5moPkYNvmU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=McgzIhzGA+ybynjtDx7UeJHM76KJUzVWVwnaHETl7OWRbq+WJlxLMUFxZqDbqyJYUqRGDTJe7j6qZBSfF+Ap/hI2vZYnAnRGOoFusvTcYadhpYhOqtmVDiwPjwV7NpZcep6lbS4mDzRxvw7iu43dswAMpb/oAdBccx8ITEuoYfUqoBFl7SxLnaI/8n62W6cks6phVaqtD8TPuqYdHpdciPQgvusMkfs21MvCl4n4/vMrosvCiR+SyHzJ5r2o5b8zYX3yMPxi5OscEvT/KQhck38HpO2hbhD5u9gWgHjy5qZSDM6YGuscsM4YiP9PZBo61DRZAXR9B6NsVEBKKGpQUw==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.160.185.198]
X-OWM-Source-IP: 86.160.185.198 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrvdekgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepkeegfedtffekieekudegvdekjeehieffveevleegtdeludetveduleffudfggfeinecukfhppeekiedrudeitddrudekhedrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirdduiedtrddukeehrdduleekpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoughomhhinhhitghkrdhgrhhifhhtseguvghfvghnshgvtgdrnhhlqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.160.185.198) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AA6E068165E4; Mon, 13 Jul 2020 11:45:20 +0100
Message-ID: <49c99d197b9badeff992e09361c452dcf12d7ca1.camel@btinternet.com>
Subject: Re: [SELinux-notebook PATCH v2] objects.md: some clarifications
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Date:   Mon, 13 Jul 2020 11:45:12 +0100
In-Reply-To: <20200710071431.107444-1-dominick.grift@defensec.nl>
References: <20200710070903.106482-1-dominick.grift@defensec.nl>
         <20200710071431.107444-1-dominick.grift@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2020-07-10 at 09:14 +0200, Dominick Grift wrote:
> v2: fixes patch description
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
>  src/objects.md | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 

Acked-by: Richard Haines <richard_c_haines@btinternet.com>

> diff --git a/src/objects.md b/src/objects.md
> index 58664ef..aadb539 100644
> --- a/src/objects.md
> +++ b/src/objects.md
> @@ -110,14 +110,20 @@ objects is managed by the system and generally
> unseen by the users
>  (until labeling goes wrong !!). As processes and objects are created
> and
>  destroyed, they either:
>  
> -1.  Inherit their labels from the parent process or object.
> +1.  Inherit their labels from the parent process or object. The
> policy
> +    default type, role and range statements can be used to change
> the
> +    behavior as discussed in the [**Default
> Rules**](default_rules.md#default-object-rules)
> +    section.
>  2.  The policy type, role and range transition statements allow a
>      different label to be assigned as discussed in the
>      [**Domain and Object
> Transitions**](domain_object_transitions.md#domain-and-object-
> transitions)
>      section.
>  3.  SELinux-aware applications can enforce a new label (with the
>      policies approval of course) using the **libselinux** API
> -    functions.
> +    functions. The `process setfscreate` access vector can be used
> to
> +    allow subjects to create files with a new label programmatically
> +    using the ***setfscreatecon**(3)* function, overriding default
> +    rules and transition statements.
>  4.  An object manager (OM) can enforce a default label that can
> either
>      be built into the OM or obtained via a configuration file (such
> as
>      those used by
> @@ -269,6 +275,20 @@ and manage their transition:
>  
>  `type_transition`, `role_transition` and `range_transition`
>  
> +SELinux-aware applications can enforce a new label (with the
> policies
> +approval of course) using the **libselinux** API functions. The
> +`process setexec`, `process setkeycreate` and `process
> setsockcreate`
> +access vectors can be used to allow subjects to label processes,
> +kernel keyrings, and sockets programmatically using the
> +***setexec**(3)*, ***setkeycreatecon**(3)* and
> +***setsockcreatecon**(3)* functions respectively, overriding
> +transition statements.
> +
> +The `kernel` and `unlabeled` **initial security identifiers** are
> used
> +to associate specified labels with subjects that were left unlabeled
> +due to initialization or with subjects that had their label
> +invalidated due to policy changes at runtime respectively.
> +
>  ### Object Reuse
>  
>  As GNU / Linux runs it creates instances of objects and manages the

