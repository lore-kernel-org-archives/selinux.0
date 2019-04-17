Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598B1C282DA
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249C32173C
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eaBxPf4n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DS75l1f0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfDQQhf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:37:35 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52521 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731472AbfDQQhf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Apr 2019 12:37:35 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A4D4220E4
        for <selinux@vger.kernel.org>; Wed, 17 Apr 2019 12:37:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 17 Apr 2019 12:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        from:to:subject:date:message-id; s=fm2; bh=ItvTvLUiK/fwd71GzT47U
        6FTi88ANtyD9Zlm9A4FVy8=; b=eaBxPf4nqvz1X2724c54u+DoTeyv8m0Baxh89
        JtfV2RojyjJPKXxk+e+KxBxlw8miPFqN46tzQovnqwR5n1RjuGtlByt/VUrRVHdi
        t8jbN5PpA9+rD2mrUrTLFvYG/bp1ajOoD9y8mFRyXCMyn5LXXb0L46dESqRxwqnW
        sPNTZ6WKMf3alkeG3WfCnDei/78cCUfeRSKfJ9BOnhKhrueadeAuNdKBhUPrsspR
        w8/ZCPUN3zKQA/+Eo/kTOnT5WKEiTIdwgtYjO3+2HgwFarWk6aIDtk8GP84zCoFz
        R11neb3w5aaDzgLomyMQ7kWp4JcAswAxy+/PHq2iQ7H2o1USA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ItvTvLUiK/fwd71GzT47U6FTi88ANtyD9Zlm9A4FVy8=; b=DS75l1f0
        D2SjU8qQzT2muwLnSZQcYntMKkwtQ9EMx3GoVUmw8D30lQ4HjA/SGWlL9l2EJ8PP
        zGtycEYhDaAtokC0PlwFYmWSbGSN87D/picQdUG+8gLvygbZ1R0nwNYdW9haMak5
        AUZOUWQBYN0nGolkEwch6qEarU8XstE49JFNlPY/F/YjuGZ+ChZS65K15iMIWjVc
        NBNF0TERaIm8ztik0RTaICEcnA1IaF0eH65DAAUz10vegUD/X4dh/NrhZIp7Hsm6
        vLTx8GALgECdRBpMJ8yWE5HfaEPmzuoVqtQfFJqV38yB2TEfHXjqJaxIQhz+JLgF
        zIFcRzEpX/o9oA==
X-ME-Sender: <xms:TVa3XNL_ZdHKdeo1ByC1xvAaCu1BGzMwVJRKy5bWWYOZRSKWAOPWmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrfeefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofestddtredtredttd
    enucfhrhhomhepifgrrhihucfvihgvrhhnvgihuceoghgrrhihrdhtihgvrhhnvgihsehf
    rghsthhmrghilhdrtghomheqnecukfhppeeivddrvdehgedruddvhedrvdeinecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgrghrhidrthhivghrnhgvhiesfhgrshhtmhgrihhlrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:TVa3XAmQrm8KQEKNbBEeF3KIP4Yj7dFmkLmvdkxuefPSM_y7Yg4p9w>
    <xmx:TVa3XDFyhS3jSTaQVbbX4OQO6LT1grFbrxhwByTab5pNa6M57W2L8g>
    <xmx:TVa3XIEoYPI2Og9DU3UiMvESTs1gM3qTZqf3dUQeyX1TBHnjIYf0SQ>
    <xmx:Tla3XI-bn4KlUgdOIoGuZQAOHgWhLdB9OqOEkbU7E3_tZsbscxJx4A>
Received: from garyttierney.internal.digirati.co.uk (unknown [62.254.125.26])
        by mail.messagingengine.com (Postfix) with ESMTPA id 313F4E4649
        for <selinux@vger.kernel.org>; Wed, 17 Apr 2019 12:37:33 -0400 (EDT)
From:   Gary Tierney <gary.tierney@fastmail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 0/2] checkmodule: allow building modules of a specific version
Date:   Wed, 17 Apr 2019 17:37:29 +0100
Message-Id: <20190417163731.3434-1-gary.tierney@fastmail.com>
X-Mailer: git-send-email 2.17.2
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These changes come from a report by a user on the Freenode IRC channel that
they were unable to build policies for a machine that has an older version of
libsepol installed.

A new `-c` option that mirrors checkpolicy's own has been added to checkmodule,
and the output of a simple test is shown below:

$ cat > test.te <<EOF
module test 1.0;

require {
    type domain;
    type file_type;
    class file { read write };
}

allow domain file_type : file { read write };
EOF
$ obj/usr/bin/checkmodule -m -M -c 10 -o test.mod test.te
$ checkpolicy/test/dismod test.mod
Reading policy...
... snip ...
Binary policy module file loaded.
Module name: test
Module version: 1.0
Policy version: 10

Worthy of note, however, is that these policy version numbers differ from those
used by the kernel policy format.

Gary Tierney (2):
  checkmodule: add support for specifying module policy version
  dismod: print policy version of loaded modules

 checkpolicy/checkmodule.8 |  5 ++++-
 checkpolicy/checkmodule.c | 29 +++++++++++++++++++++++++++--
 checkpolicy/test/dismod.c |  4 ++--
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.17.2

