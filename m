Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878D7C282DC
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AC5217D7
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Y3IOKO92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJ+Bu8Ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbfDQQhf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:37:35 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43757 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731959AbfDQQhf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Apr 2019 12:37:35 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B7F82096B
        for <selinux@vger.kernel.org>; Wed, 17 Apr 2019 12:37:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 17 Apr 2019 12:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        from:to:subject:date:message-id:in-reply-to:references; s=fm2;
         bh=BoIvZorM4QCR4JKjOot9F6fQqM5A7rF9Q4P9f91NTUo=; b=Y3IOKO92XjYa
        8xOUaOz9BcU4BFGHns3zrc6AjRG2Lq+YrhjCUDGZs5ltwGv2nu5yOU1634wsjJkV
        TDl1fsIwFx59V/MMbxUJSYFldOORIEqWgMLvEYxsZySUdX+aibPimnMteEmDuX+6
        H/P0ZSewm6EUrlUoncO+ijw6RRyKLLLxQjjb3Xw067hZudlZ7RCQZ8FuzEVswv8z
        AfYqvglRfkQKq/dtEWJJBBJL1z5eVD5SsyK6GZ+fxoQD3F8CIl3DTptJcdeHcPBr
        W0uzXsyMMHteVeQBmSfPyAJyrLASUCyE4EusLrQSZW1d6GcgFmzJWg+FHxa39PyJ
        aOIqUl5y+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=BoIvZorM4QCR4JKjOot9F6fQqM5A7
        rF9Q4P9f91NTUo=; b=WJ+Bu8EfhdUBeiHa0iqTgVax9Xj7OjTJB8abO4pwt6i0b
        6y2kQWjGbB9hhdhQXwP/IFkWpkCM7EbboKzf+IegRzzRa8CiPNHjlmEl3de+VrYR
        RBPxKUV8d4HUhYu2GWsxMS9ckCuxtOnLz1RdPoDYSnRwQ88yngcpk2z7XIUQvow5
        tLaGRk3+XWXDfN6p9vJecvQriRn+K5Me8JqFKY4GqlmoBZA2Y8H2Ddf5tttfz5l5
        7Td4gl259315s6pqO7nUhqE6HIHgS9TwfNHCfcWkR1RMaPUg3qbdVWqOkDslGepf
        jo/6DHZ9F6o7RpVcRbU3uFwy9qUpgpcnpL1dySoJg==
X-ME-Sender: <xms:Tla3XIJ5_xpXiT3YHxQDepDPeWvv60a3WGzoO5v0IrlJ8lebNipHnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrfeefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhestddtredtre
    dttdenucfhrhhomhepifgrrhihucfvihgvrhhnvgihuceoghgrrhihrdhtihgvrhhnvgih
    sehfrghsthhmrghilhdrtghomheqnecukfhppeeivddrvdehgedruddvhedrvdeinecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgrghrhidrthhivghrnhgvhiesfhgrshhtmhgrihhl
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Tla3XIQZhQgoHUoJQlQbWhK3QXDDDayLRUuUuY3KHujJX9VMfSFyCw>
    <xmx:Tla3XAKKfboa1_b2K-uINm0emf52NjBNXrnSCyab4mwRWozi3LM6VQ>
    <xmx:Tla3XL8uENQofvZbPFeOFEVfJi1hiBKj5elVqCnUsszx4IYJjhwqGg>
    <xmx:Tla3XD7zyIm6hs4KRoByG_Hp3XZWZHOKLicghDTihQKmV774IEpzkQ>
Received: from garyttierney.internal.digirati.co.uk (unknown [62.254.125.26])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB7F3E4753
        for <selinux@vger.kernel.org>; Wed, 17 Apr 2019 12:37:33 -0400 (EDT)
From:   Gary Tierney <gary.tierney@fastmail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] checkmodule: add support for specifying module policy version
Date:   Wed, 17 Apr 2019 17:37:30 +0100
Message-Id: <20190417163731.3434-2-gary.tierney@fastmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190417163731.3434-1-gary.tierney@fastmail.com>
References: <20190417163731.3434-1-gary.tierney@fastmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently checkpolicy can produce binary policies for earlier policy versions
to provide support for building policies on one machine and loading/analyzing
them on another machine with an earlier version of the kernel or libsepol,
respectively. However, checkmodule was lacking this capability.

This commit adds an identical `-c` flag that can be passed to checkmodule that
will build a modular policy file of the specified version.

Signed-off-by: Gary Tierney <gary.tierney@fastmail.com>
---
 checkpolicy/checkmodule.8 |  5 ++++-
 checkpolicy/checkmodule.c | 29 +++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index cf76591c24d0..e55582f30ec0 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -38,7 +38,7 @@ Generate a non-base policy module.
 Enable the MLS/MCS support when checking and compiling the policy module.
 .TP
 .B \-V,\-\-version
- Show policy versions created by this program.  Note that you cannot currently build older versions.
+Show policy versions created by this program.
 .TP
 .B \-o,\-\-output filename
 Write a binary policy module file to the specified filename.
@@ -47,6 +47,9 @@ and will not generate a binary module at all.
 .TP
 .B \-U,\-\-handle-unknown <action>
 Specify how the kernel should handle unknown classes or permissions (deny, allow or reject).
+.TP
+.B \-c policyvers
+Specify the policy version, defaults to the latest.
 
 .SH EXAMPLE
 .nf
diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 8edc1f8c7bbd..3bb9e5a4a6b3 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -142,6 +142,8 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 	printf("  -m         build a policy module instead of a base module\n");
 	printf("  -M         enable MLS policy\n");
 	printf("  -o FILE    write module to FILE (else just check syntax)\n");
+	printf("  -c VERSION build a policy module targeting a modular policy version (%d-%d)\n",
+	       MOD_POLICYDB_VERSION_MIN, MOD_POLICYDB_VERSION_MAX);
 	exit(1);
 }
 
@@ -163,7 +165,7 @@ int main(int argc, char **argv)
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "ho:bVU:mMC", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "ho:bVU:mMCc:", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'h':
 			usage(argv[0]);
@@ -194,7 +196,6 @@ int main(int argc, char **argv)
 			usage(argv[0]);
 		case 'm':
 			policy_type = POLICY_MOD;
-			policyvers = MOD_POLICYDB_VERSION_MAX;
 			break;
 		case 'M':
 			mlspol = 1;
@@ -202,6 +203,30 @@ int main(int argc, char **argv)
 		case 'C':
 			cil = 1;
 			break;
+		case 'c': {
+			long int n;
+			errno = 0;
+			n = strtol(optarg, NULL, 10);
+
+			if (errno) {
+				fprintf(stderr,
+					"Invalid policyvers specified: %s\n",
+					optarg);
+				usage(argv[0]);
+			}
+
+			if (n < MOD_POLICYDB_VERSION_MIN
+			    || n > MOD_POLICYDB_VERSION_MAX) {
+				fprintf(stderr,
+					"policyvers value %ld not in range %d-%d\n",
+					n, MOD_POLICYDB_VERSION_MIN,
+					MOD_POLICYDB_VERSION_MAX);
+				usage(argv[0]);
+			}
+
+			policyvers = n;
+			break;
+		}
 		default:
 			usage(argv[0]);
 		}
-- 
2.17.2

