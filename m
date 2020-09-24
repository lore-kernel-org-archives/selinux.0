Return-Path: <SRS0=GjD/=DB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C21C4346E
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 08:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B520223772
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 08:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="MWgnDuMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgIXIvL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Sep 2020 04:51:11 -0400
Received: from mailomta29-sa.btinternet.com ([213.120.69.35]:13963 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726786AbgIXIvL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Sep 2020 04:51:11 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20200924085108.YTZS4112.sa-prd-fep-045.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Thu, 24 Sep 2020 09:51:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1600937468; 
        bh=+eHkuLCo6JYlNSmuEpLP3rF6vTsez5UF+hFCccX+n7M=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=MWgnDuMg9cBS/XUWyjHWiAkoA7wQgrfpMR2EQWRUtMEmOOnRYXHoRM2jSz+pl0UCJAEkLCIKDXWzDQ2pK0b6oleXdblYXxF1uenoG5OgqfSCGW+Yc0UWaOtlOePhbI7T966UkQ2rQ9KKK76NC3U0Ew5DPWDZcJMHkKCYqHYZ97j4OdtWAlCLWVVwZbXwxCBOEQlAcyUnrvc40EZvaEjMUlUk5tCp7WrDWDVMKr236mNI6shSZnUaIwy0DLvePXA/sJhFwrggZvq7cKqx3YlhhV/TOFminqfbQzkId/iCRvk16AzCBur2fW5qPIIRPyZvzYGzrfhCZITKg14hw/e5DQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.146.219.130]
X-OWM-Source-IP: 86.146.219.130 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudekgddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepfeduheeltedtvdfgveefhfduheethfelvdeltdejgfekvedugffgveetgeegjeegnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpohhsmhhotghomhdrohhrghenucfkphepkeeirddugeeirddvudelrddufedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegiedrvdduledrudeftddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehjmhhorhhrihhssehnrghmvghirdhorhhgqedprhgtphhtthhopeeolhgrfhhorhhgvgesghhnuhhmohhnkhhsrdhorhhgqedprhgtphhtthhopeeolhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehoshhmohgtohhmqdhnvghtqdhgphhr
        sheslhhishhtshdrohhsmhhotghomhdrohhrgheqpdhrtghpthhtohepoehprggslhhosehnvghtfhhilhhtvghrrdhorhhgqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshhtvghphhgvnhdrshhmrghllhgvhidrfihorhhksehgmhgrihhlrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.146.219.130) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE1282CEFF; Thu, 24 Sep 2020 09:51:08 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        osmocom-net-gprs@lists.osmocom.org
Cc:     stephen.smalley.work@gmail.com, paul@paul-moore.com,
        pablo@netfilter.org, laforge@gnumonks.org, jmorris@namei.org,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/3] Add LSM/SELinux support for GPRS Tunneling Protocol (GTP)
Date:   Thu, 24 Sep 2020 09:50:59 +0100
Message-Id: <20200924085102.5960-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These patches came about after looking at 5G open source in particular
the updated 5G GTP driver at [1]. As this driver is still under
development, testing the LSM/SELinux hooks on the current stable
version in kernel selinux-next [2] seems best. As [1] uses the same base
code as the current 3G version (except that it handles different packet
types) they should port over.

To test the GTP driver there is an RFC patch for the selinux-testsuite
that will be posted.

To enable the selinux-testsuite GTP tests, the libgtpnl [3] library and
tools needed to be modified to:
Return ERRNO on error to detect EACCES, Add gtp_match_tunnel function,
Allow gtp-link to specify port numbers for multiple instances to
run in the same namespace (not sure if this happens in real life).

A patch for libgtpnl is supplied in the selinux-testsuite patch as well
as setup/test instructions (libgtpnl is not packaged by Fedora)

These patches were tested on Fedora 32 with kernel [2] using the
'targeted' policy. They have not been tested on a any type of 3G setup.

[1] https://github.com/PrinzOwO/gtp5g
[2] https://github.com/SELinuxProject/selinux-kernel
[3] git://git.osmocom.org/libgtpnl.git

Richard Haines (3):
  security: Add GPRS Tunneling Protocol (GTP) security hooks
  gtp: Add LSM hooks to GPRS Tunneling Protocol (GTP)
  selinux: Add SELinux GTP support

 Documentation/security/GTP.rst      | 98 +++++++++++++++++++++++++++++
 Documentation/security/index.rst    |  1 +
 drivers/net/gtp.c                   | 49 ++++++++++++++-
 include/linux/lsm_hook_defs.h       |  3 +
 include/linux/lsm_hooks.h           | 16 +++++
 include/linux/security.h            | 19 ++++++
 security/security.c                 | 18 ++++++
 security/selinux/hooks.c            | 64 +++++++++++++++++++
 security/selinux/include/classmap.h |  2 +
 security/selinux/include/objsec.h   |  4 ++
 10 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/security/GTP.rst

-- 
2.26.2

