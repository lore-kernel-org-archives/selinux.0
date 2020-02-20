Return-Path: <SRS0=5MQ6=4I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2280C11D0C
	for <selinux@archiver.kernel.org>; Thu, 20 Feb 2020 18:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1802467A
	for <selinux@archiver.kernel.org>; Thu, 20 Feb 2020 18:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="O4duGARd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgBTSKh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:10:37 -0500
Received: from mailomta20-re.btinternet.com ([213.120.69.113]:38451 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726699AbgBTSKh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Feb 2020 13:10:37 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20200220181034.MGGB15162.re-prd-fep-049.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Thu, 20 Feb 2020 18:10:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1582222234; 
        bh=22Go1tvo5JB66+aZkVivMVo/98BRlLtg4ElYbUY40d8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=O4duGARdZAUEztYkZD0VHwUSF3Q88daM9RsgxbO8CpzU0RWwxzrQ+2X3cb5/fFsqZNTi42eN5dIXgcck5qXA5wIDg41q+m29JoXllXm6m/nu+FrASE7CH5CoRLuJNWfrqwTi1n0xVZfrRXU8VTTHkXrTF+iQJbSI3DGseDlUNaA4zI3NSsxDbbGPEBWN1i4B70bFS9XyCF2doJtFr4eB+Vpyze7qYOLYrM0yVz0/On9cOpgYPqaBh+KOWVErri0cn45dwh6V7F7FWwJEta2c0deDydw9usAw3cRm6v/W6M1WOncc0OZjJc8wPGdSjsAl7kmrIOt2qiVuNHd2LoUXUw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.4.49]
X-OWM-Source-IP: 86.134.4.49 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrkedvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdegrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdegrdegledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.4.49) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A181A026A5EB1; Thu, 20 Feb 2020 18:10:34 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     dhowells@redhat.com
Cc:     selinux@vger.kernel.org, sds@tycho.nsa.gov, paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1] selinux: Add support for new key permissions
Date:   Thu, 20 Feb 2020 18:10:30 +0000
Message-Id: <20200220181031.156674-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I've been running this patch on my system for a few weeks now with no
problems, therefore I conclude that the key service only passes one
permission at a time.

Listed below is the output from the kernel logs regarding the permission
translations.

key_perms polcap = 0
entry_perm: 0x0001 exit_perm: 0x0001 view
entry_perm: 0x0002 exit_perm: 0x0002 read
entry_perm: 0x0004 exit_perm: 0x0004 write
entry_perm: 0x0008 exit_perm: 0x0008 search
entry_perm: 0x0010 exit_perm: 0x0010 link
entry_perm: 0x0020 exit_perm: 0x0020 setsec
entry_perm: 0x0040 exit_perm: 0x0008 inval/search
entry_perm: 0x0080 exit_perm: 0x0004 revoke/write
entry_perm: 0x0100 exit_perm: 0x0008 join/search
entry_perm: 0x0200 exit_perm: 0x0004 clear/write
entry_perm: 0x0400 exit_perm: 0x0010 parent_join/link

key_perms polcap = 1
entry_perm: 0x0001 exit_perm: 0x0001 view
entry_perm: 0x0002 exit_perm: 0x0002 read
entry_perm: 0x0004 exit_perm: 0x0004 write
entry_perm: 0x0008 exit_perm: 0x0008 search
entry_perm: 0x0010 exit_perm: 0x0010 link
entry_perm: 0x0020 exit_perm: 0x0020 setsec
entry_perm: 0x0040 exit_perm: 0x0080 inval
entry_perm: 0x0080 exit_perm: 0x0100 revoke
entry_perm: 0x0100 exit_perm: 0x0200 join
entry_perm: 0x0200 exit_perm: 0x0400 clear
entry_perm: 0x0400 exit_perm: 0x0200 parent_join/join

<---     key.h       ---->   <-- av_permissions.h -->
KEY_NEED_VIEW        0x001   KEY__VIEW    0x00000001U
KEY_NEED_READ        0x002   KEY__READ    0x00000002U
KEY_NEED_WRITE       0x004   KEY__WRITE   0x00000004U
KEY_NEED_SEARCH      0x008   KEY__SEARCH  0x00000008U
KEY_NEED_LINK        0x010   KEY__LINK    0x00000010U
KEY_NEED_SETSEC      0x020   KEY__SETATTR 0x00000020U
KEY_NEED_INVAL       0x040   KEY__INVAL   0x00000080U
KEY_NEED_REVOKE      0x080   KEY__REVOKE  0x00000100U
KEY_NEED_JOIN        0x100   KEY__JOIN    0x00000200U
KEY_NEED_CLEAR       0x200   KEY__CLEAR   0x00000400U
KEY_NEED_PARENT_JOIN 0x400   KEY__JOIN    0x00000200U

Richard Haines (1):
  selinux: Add support for new key permissions

 security/selinux/hooks.c            | 123 ++++++++++++++++------------
 security/selinux/include/security.h |  10 +--
 security/selinux/ss/services.c      |   4 +-
 3 files changed, 76 insertions(+), 61 deletions(-)

-- 
2.24.1

