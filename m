Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B259CC43217
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 15:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A69560EBC
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 15:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhKPP1K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:27:10 -0500
Received: from mailomta23-re.btinternet.com ([213.120.69.116]:26263 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238124AbhKPP1K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Nov 2021 10:27:10 -0500
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20211116152411.YVZI12369.re-prd-fep-042.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Tue, 16 Nov 2021 15:24:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1637076251; 
        bh=iEkA7/QFP2nOJChOwgq88lDrWRbr7jYL+z/W7ARQH/o=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=B90NvF6yfQS0isVsztW83/VhyvO7f4GRnmu8GCBrVHgpNCqb/avseK3sR05R3IvU+ukMdaUsyfDq1QKm8N1GSNmatMcikKA9vGNFD6VatzqkYNipIaL7bfR/VFiD0R10t762fUebz+G2SR+6vmBJe+i1vvm+3nOZMGfkQ1hw2CgGGEQqI8qnC1tGKkFLAAxhATKUjF/whFXk7o0LibR8aoCCk5kpc88lREwvxSouUDmex+W6/asFd9UThRpg5An45fQIeAbpFMnxPQx3ETfXLHrkn+5j0H+9zIcpCEapGlG9NwH614ovjYu5Geh3eEG/nPoONk+7h1OuNFN5avpWTA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A8CC30998839B
X-Originating-IP: [86.184.97.245]
X-OWM-Source-IP: 86.184.97.245 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrfedvgdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedukeehieehkeeigeekieeiuefhleegueelvdeftdehkeefvdeggeegkedvhfdvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeirddukeegrdeljedrvdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeegrdeljedrvdeghedpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.184.97.245) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A8CC30998839B; Tue, 16 Nov 2021 15:24:11 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] netlabel: Update man page to clarify SELinux labeling
Date:   Tue, 16 Nov 2021 15:23:54 +0000
Message-Id: <20211116152354.9943-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Clarify how SELinux setsockcreatecon(3) and policy socket* class
type_transition rules can impact domain:<domain> entries.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 doc/man/man8/netlabelctl.8 | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/doc/man/man8/netlabelctl.8 b/doc/man/man8/netlabelctl.8
index bb00096..a940c1c 100644
--- a/doc/man/man8/netlabelctl.8
+++ b/doc/man/man8/netlabelctl.8
@@ -57,7 +57,9 @@ Display the kernel's list of supported labeling protocols.
 The domain mapping module is used to map different NetLabel labeling protocols
 to either individual LSM domains or the default domain mapping.  It is up to
 each LSM to determine what defines a domain.  With SELinux, the normal SELinux
-domain should be used, i.e. "ping_t".  In addition to protocol selection based
+domain should be used, i.e. "ping_t" (however see the
+.B NOTES
+section below regarding SElinux).  In addition to protocol selection based
 only on the LSM domain, it is also possible to select the labeling protocol
 based on both the LSM domain and destination address.  The network address
 selectors can specify either single hosts or entire networks and work for both
@@ -259,6 +261,33 @@ The static, or fallback, labels are only supported on Linux Kernels version
 Linux Kernels 2.6.28 and later and CALIPSO/RFC5570 is only supported on Linux
 Kernels 4.8.0 and later.
 .P
+When using the SELinux LSM, it is generally assumed that the
+.I type
+component of the process security label should be used as the
+.I domain:<domain>
+entry. However, NetLabel services actually use the socket security label to
+determine labeling.  Normally this would be the same
+.I type
+component as the process (as by default the socket inherits the process
+label).  There are cases where this matters, as it is possible with SELinux
+to set a different label on the socket using the libselinux function
+.BR setsockcreatecon (3),
+or a policy socket* class
+.I type_transition
+rule.  Should these be used to change a socket label, then the new socket
+.I type
+must be used in the
+.I domain:<domain>
+entry instead.  Note that the new
+.I type
+will also be reflected in any peer labels returned using (for example)
+.BR getsockopt (2)
+with
+.I optname=SO_PEERSEC
+Also if fallback labeling is configured and a new socket label set,
+.BR getsockopt (2)
+will return the new socket label.
+.P
 The NetLabel project site, with more information including the source code
 repository, can be found at https://github.com/netlabel.  Please report any
 bugs at the project site or directly to the author.
-- 
2.33.1

