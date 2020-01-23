Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C07C2D0DB
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 10:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC1924125
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 10:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="ZzlOMzp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWK23 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:28:29 -0500
Received: from mailomta22-sa.btinternet.com ([213.120.69.28]:55376 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgAWK22 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 05:28:28 -0500
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200123102826.ZNAL8432.sa-prd-fep-044.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Thu, 23 Jan 2020 10:28:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1579775306; 
        bh=lJfh+1+Fvn9kL52yfj602/u+Y5jk1/2ZSojLZezeeSM=;
        h=Message-ID:Subject:From:To:Cc:Date:MIME-Version;
        b=ZzlOMzp+W8IvswDT6vI/uvOAdODgd6F0UNLSY+zQXGFj4ecYzdG17D8jJNtTGIwE4iBLTQcgK7lZhkvK/5gVQ0O7Pgt0TRcvI64RRnqLAAjT1SGRpZfc/YkaQ17kFOlW5MbwA5xqG7WGUc1ViIR47i4WvTVU7rZfM03gIUGg+rG1OQkSfNesbSveodbHNlQOhCsYfv+zMIROgBAqiqBKnM6Nb0kGmpls2lw0ancxXYIK2w92MGRKoLBrvEs6UvPsYN/H1GwryBoLXtmTV2qIjrP/WbtEvY7yhEu+zfclghyV7LhbqIMFwU96rVgsVZyEbGpBdGr8+qiClw9A7hlGiQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.184]
X-OWM-Source-IP: 86.134.6.184 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvffftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudefgedriedrudekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirddukeegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoughhohifvghllhhssehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehkvgihrhhinhhgshesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.184) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5E1A306601D693D8; Thu, 23 Jan 2020 10:28:26 +0000
Message-ID: <8ee40192da117d9cdf4eab1e63ab5f77b359801c.camel@btinternet.com>
Subject: SELinux issue with 'keys-acl' patch in kernel.org's 'linux-next'
 tree
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     dhowells@redhat.com
Cc:     keyrings@vger.kernel.org, selinux@vger.kernel.org
Date:   Thu, 23 Jan 2020 10:28:25 +0000
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I see the 'keys-acl' [1] patch is now back in kernel.org's 'linux-next' 
tree.
After some investigation, I have a query on this that I've attempted to
explain below.

The keyutils tests work with this patch on standard Fedora policy
because the policy gives most domains access to all key permissions.
Also the polcy is built using 'hide_broken_symptoms' that adds 'allow
domain domain:key { link search };', therefore calls made by these
always pass:

keys/keyring.c - find_keyring_by_name():
Originally required: KEY_NEED_SEARCH
Now requires:        KEY_NEED_JOIN

keys/keyctl.c - keyctl_session_to_parent():
Originally required: KEY_NEED_LINK
Now requires:        KEY_NEED_JOIN

However if (as in the selinux-testsuite - test/keys), 'domain' is
replaced by a macro that excludes the { link search }, and allows each
permission to be tested, two tests fail. This is because:

1) keyctl_session_to_parent() requires KEY_NEED_JOIN translated to
KEY_NEED_LINK permission.
2) find_keyring_by_name() requires KEY_NEED_JOIN translated to
KEY_NEED_SEARCH permission.

The patch always translates KEY_NEED_JOIN to KEY_NEED_SEARCH
Any views on this as it seems a regression.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/security/selinux?h=next-20200122&id=a862a799537490b74a81e14a62623af502bdb25d


