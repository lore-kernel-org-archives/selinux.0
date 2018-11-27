Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53872C43441
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 10:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232F320873
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 10:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232F320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeK0VgK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:36:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43919 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeK0VgK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Nov 2018 16:36:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so22103234wrs.10
        for <selinux@vger.kernel.org>; Tue, 27 Nov 2018 02:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/3wOQa7ywukxZKNWtxtpKXIiMO9Q7Wl8m20sxv7KNs=;
        b=pjttig/vfRyz/Q6tAt0gYKooSoWbkPg1xkzO9vA1swLUBlBe6XUtwKrPIm5/0QglWd
         5wIpd8MXws1WxtY1ubivtEiRnIY7njz5cPDmetsQZY4C2IPu/tjHdqk6H4XGRQzaDS36
         MB581oOnWnk/ETrmb6aIVquoWI2Lu7d8Iz39oBqYiSqNacAPyi8Z/jojF9rH1d9CDMYG
         htb28Q0ZP15zB8nAHpAO5h+5jFZ1gD+/UfBO3ryWHwXIjtaUOk4I/SWlsV4VNqyLSvkh
         zLeHUHZFAB+zDwiLkdobcSZYyyoqnT1pUw9MPZwLY/b8DOhuKzekkhKJXEetlADfxoj7
         M5Bw==
X-Gm-Message-State: AA+aEWY+FG0T76ITAeMujhpWbtkqbUEaj+p45IFeG02eU+dcwB4OXbLC
        nuu/iIM9bP0O9wgH9K5XtehgXNPWxHzvjA==
X-Google-Smtp-Source: AFSGD/UfT8cmlFQKKWI1dUA9QQiZofwl7ALYU04QZxVUQwOEccPlVv5G0f80KIs1f2DtmgC7RsMcyg==
X-Received: by 2002:adf:8421:: with SMTP id 30mr27781424wrf.153.1543315120168;
        Tue, 27 Nov 2018 02:38:40 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f18sm2870765wrs.92.2018.11.27.02.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 02:38:38 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH v2 0/4] Fix ENOMEM errors during policy reload
Date:   Tue, 27 Nov 2018 11:36:01 +0100
Message-Id: <20181127103605.32765-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset is a second iteration of this patchset:
https://lore.kernel.org/selinux/20181113135255.26045-1-omosnace@redhat.com/T/

The patches that have "[squash]" in the subject are posted separately for ease
of review but will be folded into the previous patch in the final posting.

Changes in v2:
- dropped the first patch since it is already merged in -next
- fixed initial SID table to not reserve an entry for SECSID_NULL
- added back an equivalent of the reverse lookup cache
- fixed checkpatch.pl errors and some warnings

Notes on the reverse lookup cache:
I updated the sidtab insertion measurements [1] with data for the new patchset
(the difference being the cache addition) and I also measured the base code
with the reverse lookup cache removed [3] for comparison. Note that in this
case (adding a new context) the cache will never give a hit so this only
measures the overhead of traversing the whole cache. It seems that both cache
implementations have similar overhead, the new one being a bit slower (but it
has one entry more so it is expected).

I don't have any data on how the cache helps during regular reverse lookups,
since I couldn't come up with any good way to measure that.

Testing:
A Fedora 29 kernel with this patchset applied passes selinux-testsuite
and fixes GH issue #38 [2]. Additionaly, I decided to eat my own dog food and I
have now been running this kernel on my F29 work machine for several days. So
far everything runs smoothly and I haven't noticed any functional or
performance issues.

[1] https://docs.google.com/spreadsheets/d/e/2PACX-1vRUArNJR6kckm2SEs4dRZlijNVdCTmsNuWRGe7X3fC01YkBHpxXHnmcssxEiMF3Z7ivtXN2L5MC0ry-/pubhtml
[2] https://github.com/SELinuxProject/selinux-kernel/issues/38
[3] https://gitlab.com/omos/linux-public/commit/2c1ebcb8fbdcc6400734ba8d1c3015bd446e6fa5

Ondrej Mosnacek (4):
  selinux: use separate table for initial SID lookup
  [squash] do not store entry for SECSID_NULL
  selinux: overhaul sidtab to fix bug and improve performance
  [squash] add back reverse lookup cache to sidtab

 security/selinux/ss/mls.c      |  23 +-
 security/selinux/ss/mls.h      |   3 +-
 security/selinux/ss/policydb.c |  10 +-
 security/selinux/ss/services.c | 170 +++++----
 security/selinux/ss/services.h |   2 +-
 security/selinux/ss/sidtab.c   | 616 +++++++++++++++++++++------------
 security/selinux/ss/sidtab.h   |  95 +++--
 7 files changed, 560 insertions(+), 359 deletions(-)

-- 
2.19.1

