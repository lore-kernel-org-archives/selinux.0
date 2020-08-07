Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFF1C433DF
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD19220866
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 15:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="H1CiFcZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGPgw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:36:52 -0400
Received: from mailomta31-sa.btinternet.com ([213.120.69.37]:45975 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726061AbgHGPgw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 11:36:52 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20200807153649.KOGP26847.sa-prd-fep-043.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 7 Aug 2020 16:36:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1596814609; 
        bh=T48dMSpMKjA5KLHpGZbOa6mzgmOCiMrX8onl4UQrqCI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=H1CiFcZ1VxcnKkb7iHaL1J90ikqWPni0WQT+Ijpm15WjioL7Py3P/Rqw5Cm+tqOBUPsH5mzW7njjKeaP4mGP0FsaugLQw91HX9a8EwUYXHwshzr1lNQIhpWSXntUCjdBjqGWKCzXM7ZI9XTgml63yY4erhYBDTrCSWHHp9PjdDzo10QSonjV8xt55utdwvu6avWjVUC/Ky7GKha6LhfdMXJIJkEFCL7K8zRxRL/AGr/wcS+5r6/UeredhkO5Yuxe/3o+6tYx4ZjbE58EELBw3DxfocoM4j5VhUeBUVIYTXha5Rw0Su2DHnmmtmvAiVHSsuS+r9v7K0kYpIv1f9NI3A==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [213.122.112.2]
X-OWM-Source-IP: 213.122.112.2 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrkedvgdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeeftdffkeeikedugedvkeejheeiffevveelgedtleduteevudelffdugffgieenucfkphepvddufedruddvvddrudduvddrvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepvddufedruddvvddrudduvddrvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsthgvphhhvghnrdhsmhgrlhhlvgihrdifohhrkhesghhmrghilhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (213.122.112.2) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0AA33882; Fri, 7 Aug 2020 16:36:49 +0100
Message-ID: <092acafdcde69e7365e3995fc3697294c755e409.camel@btinternet.com>
Subject: Re: [RFC PATCH] selinux-notebook: mls_mcs.md convert and update text
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        paul@paul-moore.com, selinux@vger.kernel.org
Date:   Fri, 07 Aug 2020 16:36:42 +0100
In-Reply-To: <80e38828-1473-5bc5-1b23-067cd242125a@gmail.com>
References: <20200807144025.11668-1-richard_c_haines@btinternet.com>
         <80e38828-1473-5bc5-1b23-067cd242125a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2020-08-07 at 11:27 -0400, Stephen Smalley wrote:
> On 8/7/20 10:40 AM, Richard Haines wrote:
> 
> > This is an RFC patch to get some feedback as:
> > 1) Table 1 is now a pipe table, however it still has <br> codes to
> >     break up the text. Also updated styles.html.css to match the
> > pdf version
> >     to allow correct HTML rendering.
> > 2) Table 2 is now a pipe table with updated text.
> > 
> > Add a TOC to aid navigation
> > Add text to clarify MCS/MLS
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > 
> > @@ -48,6 +56,18 @@ The sections that follow discuss the format of a
> > security level and
> >   range, and how these are managed by the constraints mechanism
> > within
> >   SELinux using dominance rules.
> >   
> > +### MLS or MCS Policy
> > +
> > +From an SELinux perspective:
> > +
> > +-   An MLS policy has more than one security level with zero or
> > more categories.
> > +    It is generally used in systems that require the 'Read Down'
> > and 'Write Up'
> > +    services, whether it be for files, network services etc..
> > +-   An MCS policy has a single security level with zero or more
> > categories.
> > +    Example uses are virtualization (see the
> > +    [**Virtual Machine Support**](vm_support.md#selinux-virtual-
> > machine-support)
> > +    section) and container security.
> > +
> 
> To be clear, SELinux (i.e. the code/mechanism) only knows of MLS,
> i.e. 
> it has a MLS engine in the security server and a MLS portion of the 
> policy configuration that drives that engine.  That MLS engine has
> been 
> leveraged by two different types of policies, the original MLS 
> configuration modeled after Bell-LaPadula and the later-introduced
> MCS 
> configuration (which underwent a fundamental transformation from
> being 
> user-facing and somewhat discretionary to being a transparent
> isolation 
> mechanism for sandbox, container, and virtualization runtimes). The 
> number of sensitivities, number of categories, and the set of MLS 
> constraints used to determine whether a permission is allowed are 
> entirely up to the policy author. A level in SELinux is a combination
> of 
> a hierarchical sensitivity and a non-hierarchical (potentially
> empty) 
> category set. In practice MCS is used for simple isolation and
> therefore 
> doesn't employ sensitivities since there is no hierarchical
> relationship 
> to be enforced.
> 
Thanks for the clarification. I'll update the text in the next version

> 


