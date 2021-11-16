Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC90C433EF
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 16:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D17E60F22
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 16:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhKPQls (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Nov 2021 11:41:48 -0500
Received: from mailomta21-sa.btinternet.com ([213.120.69.27]:57404 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232177AbhKPQlr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Nov 2021 11:41:47 -0500
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20211116163848.UDJH20692.sa-prd-fep-045.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Tue, 16 Nov 2021 16:38:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1637080728; 
        bh=qnX/G/iWSpUrytGIt5/LoFK+tUFZ7dIONSfH3g7IM68=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=rujYH/m9FEUUY8IOSuKIuacWAkogz2vy/abgG0LCGr0J+ubklQZglOEnx2k6qdEH9usxqty0NE6p+jX3aYgdLc9Cb9W5r3VilL42ou09f+tGqdMu2T2V6+0dlRrrTI0cVnJ1Zb/BrCUl9kePCB+ueaDReLI8cGLKYkDMDueOiCP8bBtBtdKw2lPOg2CZ1NCR4ucQZwQ3Dz+xu+L18ZmqFC/nja9SjocZwl5cSf0HJs5kqfuxPhvPYQ7fsOL7DptqpLALN4KqE7gsjT6jXRyYI2MwGhbyYqn1BNitz9oTdkGr6rV8wFxVHGpij3iP8a+rdmiTeju+i6REkGnV4Beh2Q==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613943C60A19C8C0
X-Originating-IP: [86.184.97.245]
X-OWM-Source-IP: 86.184.97.245 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrfedvgdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedukeehieehkeeigeekieeiuefhleegueelvdeftdehkeefvdeggeegkedvhfdvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeirddukeegrdeljedrvdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeegrdeljedrvdeghedpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.184.97.245) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613943C60A19C8C0; Tue, 16 Nov 2021 16:38:48 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2] netlabel: Update man page to clarify SELinux labeling
Date:   Tue, 16 Nov 2021 16:38:38 +0000
Message-Id: <20211116163838.10888-1-richard_c_haines@btinternet.com>
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
V2: Clarify the labels returned using getsockopt(2)

 doc/man/man8/netlabelctl.8 | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/doc/man/man8/netlabelctl.8 b/doc/man/man8/netlabelctl.8
index bb00096..2a7852b 100644
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
@@ -259,6 +261,31 @@ The static, or fallback, labels are only supported on Linux Kernels version
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
+entry instead.
+If fallback labeling is configured and a new socket label is set on the
+client, the server will show that label when
+.BR getsockopt (2)
+with
+.I optname=SO_PEERSEC
+is called.
+.P
 The NetLabel project site, with more information including the source code
 repository, can be found at https://github.com/netlabel.  Please report any
 bugs at the project site or directly to the author.
-- 
2.33.1

