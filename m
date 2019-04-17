Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087EBC282DA
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8DE2173C
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="m1A/AXAB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6PqlIAZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfDQQhg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:37:36 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60515 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732305AbfDQQhg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Apr 2019 12:37:36 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F366220A3
        for <selinux@vger.kernel.org>; Wed, 17 Apr 2019 12:37:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 17 Apr 2019 12:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        from:to:subject:date:message-id:in-reply-to:references; s=fm2;
         bh=08mjbBMNm2Vpsxtw3L7D5eVNdu/RAHn84rmXJMVouo0=; b=m1A/AXABfDwF
        JCO+W/3Ajizmh6FPtgiaj16KBzu4cZjlyJaG6jccI9b7eDgvPukKj/qWsjn8fOtn
        EzzRFz6n7Q4IG30Ol+I+bBJbMQMw5rp/G6gHXdyIn5fZWY8o+m+8IRUWbSpDriel
        80uQCrVs4gXv2l+YdoRwFM1qPqHOwToUQWFQqcpe9E9rKogs8bFVYZ1B0IGjZDkF
        hojdO2vNzBWjk7sXCtnxAcR2AdNswWSkuiuDWFZQ72NsFnjRGYsUUjSKmWUAy4xy
        qO1isTl3i+fxtY0Sutft2nTWq727xR+YhmNOEWLkSb8A2Fvub3meF8QnHIeDAqzg
        dHORgxk1TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=08mjbBMNm2Vpsxtw3L7D5eVNdu/RA
        Hn84rmXJMVouo0=; b=6PqlIAZ5b2fb4v24PfgFxXRoG8QMYwMfMFKEhVZ+uv7U8
        r8baaygLu37kxVDfbpm0ybTY46yKHAfNbWHAm8cb7KEfrAqYLGVNgbvaXsgDPW2h
        9qbEktjcgDbngTZ84qn4POwBKGSevnZ633xI7ndchG5CaqzXB2INP4vKLTlxjMin
        jFPrpW6sForr+TN8w/DslKf3wzn9hQKHm+4XCwQIMKMYPZmgPeI/XZ5vtbDgjCS9
        qGoPQ7iCUvo2Ov+iJS7z4o6bK5B8GdB9jz8n1bRZHuj2fUAx01yQ2H6SQxjhzFWI
        MI/W05/uLCaICci5Zsy/WibEDi5HmBkCYl4SFdFVw==
X-ME-Sender: <xms:T1a3XB6r8xrgKJ4DZluonqrNt4BoOIYg2E_htThqvhSm3CjJAXzrvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrfeefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhestddtredtre
    dttdenucfhrhhomhepifgrrhihucfvihgvrhhnvgihuceoghgrrhihrdhtihgvrhhnvgih
    sehfrghsthhmrghilhdrtghomheqnecukfhppeeivddrvdehgedruddvhedrvdeinecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgrghrhidrthhivghrnhgvhiesfhgrshhtmhgrihhl
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:T1a3XE5vuAGnBh0PT7MUsN6l60ky-4RcsGeta2N_PpNw1zRekuWm3Q>
    <xmx:T1a3XGFuuONIMLKm8yacGXW2de2p4bdcspY3IEk5zsa15VnMo2Noxw>
    <xmx:T1a3XFRu-K_ImGeubQ9vcSAJDuosgJi12Flc2Re-5L4EK8h6m9BlSg>
    <xmx:T1a3XOWvk3cP_0eYpzHW8VS-WHFlO8NTPzNc90PXn6j2qh8eL6ottw>
Received: from garyttierney.internal.digirati.co.uk (unknown [62.254.125.26])
        by mail.messagingengine.com (Postfix) with ESMTPA id 78164E44A1
        for <selinux@vger.kernel.org>; Wed, 17 Apr 2019 12:37:34 -0400 (EDT)
From:   Gary Tierney <gary.tierney@fastmail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] dismod: print policy version of loaded modules
Date:   Wed, 17 Apr 2019 17:37:31 +0100
Message-Id: <20190417163731.3434-3-gary.tierney@fastmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190417163731.3434-1-gary.tierney@fastmail.com>
References: <20190417163731.3434-1-gary.tierney@fastmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Gary Tierney <gary.tierney@fastmail.com>
---
 checkpolicy/test/dismod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index d5c7eeab093a..075bd85df4e6 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -903,14 +903,14 @@ int main(int argc, char **argv)
 	}
 
 	if (policydb.policy_type == POLICY_BASE) {
-		printf("Binary base policy file loaded.\n\n");
+		printf("Binary base policy file loaded.\n");
 	} else {
 		printf("Binary policy module file loaded.\n");
 		printf("Module name: %s\n", policydb.name);
 		printf("Module version: %s\n", policydb.version);
-		printf("\n");
 	}
 
+	printf("Policy version: %d\n\n", policydb.policyvers);
 	menu();
 	for (;;) {
 		printf("\nCommand (\'m\' for menu):  ");
-- 
2.17.2

