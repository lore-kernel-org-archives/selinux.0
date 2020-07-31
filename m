Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04776C433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 17:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6B921744
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgf9ELRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbgGaRdo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732970AbgGaRdo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 13:33:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E649BC061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 10:33:43 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m22so16376844pgv.9
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aLkgyjYvLKba13quiY6cHAyaAsOzwpq9+EPoPqJxNoc=;
        b=Vgf9ELRq3KeeXqXsAVjZfCu1dwRdj869KKNRIPRrmiRjyP9TIC1Pha6J5lvtn0O2RI
         L0RYx1aKebQLDIGqqvGwkNI3iBZ/VOBOrf4XhYYJVyYeeaKE7WxrHlpzI5DoPERKIsXv
         2qmxn01DNq9kAs4GklVPia6lOrFhYr4lk0B0E2IX15JhdV9ZA6E5h+yoJwj3lUX1JknH
         fX/Lf5mPWxmMHq/7Ac0Q+zBqw4KSo4L1Glc869N2Bm/AjqHra+K6IQTebnF6/H04K7iY
         KYq/D0Mn7hRkjWbgs8IMXRRtmCnJ9KBS0DHUI66ajmH8z/cWu53iEaDY9G2OUH5Ij8ia
         EVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aLkgyjYvLKba13quiY6cHAyaAsOzwpq9+EPoPqJxNoc=;
        b=ow8FUt+veddaHBsjnbEEKEnI0S9clmucehuoGchcmCabp1Q61Cwsjf5EWGLvzPWtWT
         rER0ZdKvR//IELwUSWkcMg9Xot0Ddsf7fXAhMNROUfvFCuuZQu9cjUYJOfWWwOShpDZ+
         BOCz1U5p2wgQtjbFoFlimGQ76ydMrGse6FwlLnk+G5feAPRkEco+fTl8O0pS81d9BDnu
         ojabtBIAnZ1NL1bTd/eMG8nIEsdV2mCftWNi0CPyZqwYMHdx7v51uqQtTPKJ8lW2bgAh
         sXnloLhCBw321gn3dHpgzhR3WriSYSRzylcb2ednRiiJUimT0gvJUzjKAXbaRb6aLX8z
         TWNw==
X-Gm-Message-State: AOAM533FOwn5M/2JNEwnF9creg8ZNvMIyxRXJAKNi8xTuCvUJnSunhXE
        8dsSpAmmUEzi/O0MWcSQ22Q=
X-Google-Smtp-Source: ABdhPJzDNxx8KFcOd4LTBU0OdAemDiDiLSdrNNFQRf1Ut1kfMHi2+fX45eyzq0f+WLkRexd0Sc9wEQ==
X-Received: by 2002:a63:4f05:: with SMTP id d5mr4477629pgb.298.1596216823060;
        Fri, 31 Jul 2020 10:33:43 -0700 (PDT)
Received: from wcrobert-MOBL1.netgear.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id r1sm7514838pgi.28.2020.07.31.10.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 10:33:42 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] scripts/ci: license as Apache 2.0
Date:   Fri, 31 Jul 2020 12:33:09 -0500
Message-Id: <20200731173309.31528-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFftDdo2XOU1iH1Gn1bf8UF7VLHVXF9wuop9SOHj44P4pet-kQ@mail.gmail.com>
References: <CAFftDdo2XOU1iH1Gn1bf8UF7VLHVXF9wuop9SOHj44P4pet-kQ@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

License the ci scripts with a permissive, OSI approved license, such as
Apache 2.0.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 scripts/ci/LICENSE               | 202 +++++++++++++++++++++++++++++++
 scripts/ci/fedora-test-runner.sh |   2 +-
 scripts/ci/travis-kvm-setup.sh   |   2 +-
 3 files changed, 204 insertions(+), 2 deletions(-)
 create mode 100644 scripts/ci/LICENSE

diff --git a/scripts/ci/LICENSE b/scripts/ci/LICENSE
new file mode 100644
index 000000000000..d64569567334
--- /dev/null
+++ b/scripts/ci/LICENSE
@@ -0,0 +1,202 @@
+
+                                 Apache License
+                           Version 2.0, January 2004
+                        http://www.apache.org/licenses/
+
+   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
+
+   1. Definitions.
+
+      "License" shall mean the terms and conditions for use, reproduction,
+      and distribution as defined by Sections 1 through 9 of this document.
+
+      "Licensor" shall mean the copyright owner or entity authorized by
+      the copyright owner that is granting the License.
+
+      "Legal Entity" shall mean the union of the acting entity and all
+      other entities that control, are controlled by, or are under common
+      control with that entity. For the purposes of this definition,
+      "control" means (i) the power, direct or indirect, to cause the
+      direction or management of such entity, whether by contract or
+      otherwise, or (ii) ownership of fifty percent (50%) or more of the
+      outstanding shares, or (iii) beneficial ownership of such entity.
+
+      "You" (or "Your") shall mean an individual or Legal Entity
+      exercising permissions granted by this License.
+
+      "Source" form shall mean the preferred form for making modifications,
+      including but not limited to software source code, documentation
+      source, and configuration files.
+
+      "Object" form shall mean any form resulting from mechanical
+      transformation or translation of a Source form, including but
+      not limited to compiled object code, generated documentation,
+      and conversions to other media types.
+
+      "Work" shall mean the work of authorship, whether in Source or
+      Object form, made available under the License, as indicated by a
+      copyright notice that is included in or attached to the work
+      (an example is provided in the Appendix below).
+
+      "Derivative Works" shall mean any work, whether in Source or Object
+      form, that is based on (or derived from) the Work and for which the
+      editorial revisions, annotations, elaborations, or other modifications
+      represent, as a whole, an original work of authorship. For the purposes
+      of this License, Derivative Works shall not include works that remain
+      separable from, or merely link (or bind by name) to the interfaces of,
+      the Work and Derivative Works thereof.
+
+      "Contribution" shall mean any work of authorship, including
+      the original version of the Work and any modifications or additions
+      to that Work or Derivative Works thereof, that is intentionally
+      submitted to Licensor for inclusion in the Work by the copyright owner
+      or by an individual or Legal Entity authorized to submit on behalf of
+      the copyright owner. For the purposes of this definition, "submitted"
+      means any form of electronic, verbal, or written communication sent
+      to the Licensor or its representatives, including but not limited to
+      communication on electronic mailing lists, source code control systems,
+      and issue tracking systems that are managed by, or on behalf of, the
+      Licensor for the purpose of discussing and improving the Work, but
+      excluding communication that is conspicuously marked or otherwise
+      designated in writing by the copyright owner as "Not a Contribution."
+
+      "Contributor" shall mean Licensor and any individual or Legal Entity
+      on behalf of whom a Contribution has been received by Licensor and
+      subsequently incorporated within the Work.
+
+   2. Grant of Copyright License. Subject to the terms and conditions of
+      this License, each Contributor hereby grants to You a perpetual,
+      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
+      copyright license to reproduce, prepare Derivative Works of,
+      publicly display, publicly perform, sublicense, and distribute the
+      Work and such Derivative Works in Source or Object form.
+
+   3. Grant of Patent License. Subject to the terms and conditions of
+      this License, each Contributor hereby grants to You a perpetual,
+      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
+      (except as stated in this section) patent license to make, have made,
+      use, offer to sell, sell, import, and otherwise transfer the Work,
+      where such license applies only to those patent claims licensable
+      by such Contributor that are necessarily infringed by their
+      Contribution(s) alone or by combination of their Contribution(s)
+      with the Work to which such Contribution(s) was submitted. If You
+      institute patent litigation against any entity (including a
+      cross-claim or counterclaim in a lawsuit) alleging that the Work
+      or a Contribution incorporated within the Work constitutes direct
+      or contributory patent infringement, then any patent licenses
+      granted to You under this License for that Work shall terminate
+      as of the date such litigation is filed.
+
+   4. Redistribution. You may reproduce and distribute copies of the
+      Work or Derivative Works thereof in any medium, with or without
+      modifications, and in Source or Object form, provided that You
+      meet the following conditions:
+
+      (a) You must give any other recipients of the Work or
+          Derivative Works a copy of this License; and
+
+      (b) You must cause any modified files to carry prominent notices
+          stating that You changed the files; and
+
+      (c) You must retain, in the Source form of any Derivative Works
+          that You distribute, all copyright, patent, trademark, and
+          attribution notices from the Source form of the Work,
+          excluding those notices that do not pertain to any part of
+          the Derivative Works; and
+
+      (d) If the Work includes a "NOTICE" text file as part of its
+          distribution, then any Derivative Works that You distribute must
+          include a readable copy of the attribution notices contained
+          within such NOTICE file, excluding those notices that do not
+          pertain to any part of the Derivative Works, in at least one
+          of the following places: within a NOTICE text file distributed
+          as part of the Derivative Works; within the Source form or
+          documentation, if provided along with the Derivative Works; or,
+          within a display generated by the Derivative Works, if and
+          wherever such third-party notices normally appear. The contents
+          of the NOTICE file are for informational purposes only and
+          do not modify the License. You may add Your own attribution
+          notices within Derivative Works that You distribute, alongside
+          or as an addendum to the NOTICE text from the Work, provided
+          that such additional attribution notices cannot be construed
+          as modifying the License.
+
+      You may add Your own copyright statement to Your modifications and
+      may provide additional or different license terms and conditions
+      for use, reproduction, or distribution of Your modifications, or
+      for any such Derivative Works as a whole, provided Your use,
+      reproduction, and distribution of the Work otherwise complies with
+      the conditions stated in this License.
+
+   5. Submission of Contributions. Unless You explicitly state otherwise,
+      any Contribution intentionally submitted for inclusion in the Work
+      by You to the Licensor shall be under the terms and conditions of
+      this License, without any additional terms or conditions.
+      Notwithstanding the above, nothing herein shall supersede or modify
+      the terms of any separate license agreement you may have executed
+      with Licensor regarding such Contributions.
+
+   6. Trademarks. This License does not grant permission to use the trade
+      names, trademarks, service marks, or product names of the Licensor,
+      except as required for reasonable and customary use in describing the
+      origin of the Work and reproducing the content of the NOTICE file.
+
+   7. Disclaimer of Warranty. Unless required by applicable law or
+      agreed to in writing, Licensor provides the Work (and each
+      Contributor provides its Contributions) on an "AS IS" BASIS,
+      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
+      implied, including, without limitation, any warranties or conditions
+      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
+      PARTICULAR PURPOSE. You are solely responsible for determining the
+      appropriateness of using or redistributing the Work and assume any
+      risks associated with Your exercise of permissions under this License.
+
+   8. Limitation of Liability. In no event and under no legal theory,
+      whether in tort (including negligence), contract, or otherwise,
+      unless required by applicable law (such as deliberate and grossly
+      negligent acts) or agreed to in writing, shall any Contributor be
+      liable to You for damages, including any direct, indirect, special,
+      incidental, or consequential damages of any character arising as a
+      result of this License or out of the use or inability to use the
+      Work (including but not limited to damages for loss of goodwill,
+      work stoppage, computer failure or malfunction, or any and all
+      other commercial damages or losses), even if such Contributor
+      has been advised of the possibility of such damages.
+
+   9. Accepting Warranty or Additional Liability. While redistributing
+      the Work or Derivative Works thereof, You may choose to offer,
+      and charge a fee for, acceptance of support, warranty, indemnity,
+      or other liability obligations and/or rights consistent with this
+      License. However, in accepting such obligations, You may act only
+      on Your own behalf and on Your sole responsibility, not on behalf
+      of any other Contributor, and only if You agree to indemnify,
+      defend, and hold each Contributor harmless for any liability
+      incurred by, or claims asserted against, such Contributor by reason
+      of your accepting any such warranty or additional liability.
+
+   END OF TERMS AND CONDITIONS
+
+   APPENDIX: How to apply the Apache License to your work.
+
+      To apply the Apache License to your work, attach the following
+      boilerplate notice, with the fields enclosed by brackets "[]"
+      replaced with your own identifying information. (Don't include
+      the brackets!)  The text should be enclosed in the appropriate
+      comment syntax for the file format. We also recommend that a
+      file or class name and description of purpose be included on the
+      same "printed page" as the copyright notice for easier
+      identification within third-party archives.
+
+   Copyright [yyyy] [name of copyright owner]
+
+   Licensed under the Apache License, Version 2.0 (the "License");
+   you may not use this file except in compliance with the License.
+   You may obtain a copy of the License at
+
+       http://www.apache.org/licenses/LICENSE-2.0
+
+   Unless required by applicable law or agreed to in writing, software
+   distributed under the License is distributed on an "AS IS" BASIS,
+   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+   See the License for the specific language governing permissions and
+   limitations under the License.
diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
index 569723387f6b..8d6a572eb094 100755
--- a/scripts/ci/fedora-test-runner.sh
+++ b/scripts/ci/fedora-test-runner.sh
@@ -1,5 +1,5 @@
 #!/usr/bin/env bash
-
+# SPDX-License-Identifier: Apache-2.0
 set -ev
 
 #
diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
index 8d4cfb79f7d7..275d05299971 100755
--- a/scripts/ci/travis-kvm-setup.sh
+++ b/scripts/ci/travis-kvm-setup.sh
@@ -1,5 +1,5 @@
 #!/usr/bin/env bash
-
+# SPDX-License-Identifier: Apache-2.0
 set -ev
 
 TEST_RUNNER="scripts/ci/fedora-test-runner.sh"
-- 
2.17.1

