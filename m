Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6175CC433EF
	for <selinux@archiver.kernel.org>; Wed, 19 Jan 2022 16:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356160AbiASQfc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344646AbiASQfa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jan 2022 11:35:30 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC7C061574
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:35:30 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id u3so3305316qku.1
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6O7HZhf8M4WS1HQyaxnUB7CVn2aGYkez4ey9QPs9zQ=;
        b=Tx/y2zebkcHgCrE67LRWPz8BItXLBWtbc0UCWRq/w3YFMNlQAusZgn0PX9Y/NXSRtd
         wu58xbsT7Qge1m7i+UBu/UYsRck3tz6fdaxHHWiphzFvAHFZa+HqEXOhpNlo5YeE/pQT
         77K7CarfBdbEzNwDdHQrM3uOhVPKTWId9xEqf63s55o2TfWrVLqgMiYbRe7VPGIDBa3A
         FW/X/cWzRMiqszqkCAw7WsncUY6+q6N3JN/nP8IyzjnsVNXRYhUNUxuHGoyYmPbhMAns
         UF8f9KzjBdYgYecfph/U7oWtnVbvsgnj/52t0njCZCWHyx8qBFLW3pv4YC6dYXp9/321
         sH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6O7HZhf8M4WS1HQyaxnUB7CVn2aGYkez4ey9QPs9zQ=;
        b=6sjxG+BPDe6ZyHUKe0xYYp1ZXnBBmGTh0WF7Iq9g8g7PzcygCCP6+SOhAYMRZfkgD4
         j6XJlIskZHzHGfq5tl9liwlmVL+my2E2DH3JTkmG1okpuLdQLEoz0goi/KyZ2OFWEbUh
         TrTRb8IMbIhmI56RUybkqmso3+hQ7sRAzzf2KEUk7myaL60zYlfo7h5Uof0b/fD3Od/K
         IE/YccoZb/48toRAq6cwNycdMtAHJdIqFcaH1KCiOrTnZawwHfojhCBsfDsQvvKU4LGI
         itDMn+HBA4uuQJckDLI6H7VTzmk5UGG1rg/jpAMY5mzk2FP0shLDJhwhnNUBD6WvxzhA
         lt+Q==
X-Gm-Message-State: AOAM5319xUj6qNWKrqchrQluBIdREMWwGJaA6zPR2ufi1K/B0uUP8w6w
        sBHtlJI+ULNKmlwf5dsVBo/8pvnQ4JA=
X-Google-Smtp-Source: ABdhPJwiLoSGQmoc8dCd71W+JArwUIjZ0k6N7Z15MscjxTBPGEUNp68nM9WDzDOtvrk6rnejyGmqTA==
X-Received: by 2002:a37:6684:: with SMTP id a126mr1807867qkc.591.1642610129392;
        Wed, 19 Jan 2022 08:35:29 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id b200sm127231qkc.50.2022.01.19.08.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:35:29 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     j2468h@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/4 v2] libsepol/cil: Limit certain error and warning reports
Date:   Wed, 19 Jan 2022 11:35:14 -0500
Message-Id: <20220119163518.93780-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When reporting some errors or warnings, a search is made to find the
original or matching rule. Both neverallow and type bounds violations will
use cil_find_matching_avrule_in_ast() to find the rules in violation. For
context rules, the AST is walked to find the conflicting rule. If there are
a lot of errors or warnings, then this can take a lot of time. oss-fuzz has
generated policies that can abuse this reporting, so the desire is to limit
the reporting by default.

By using the new function, cil_get_log_level(), the error reporting for
neverallow and type bounds violations and the warnings for context rule
conflicts can be less by default while still allowing for everything to
be reported at higher log verbosity levels.


James Carter (4):
  libsepol/cil: Add cil_get_log_level() function
  libsepol/cil: Provide more control over reporting bounds failures
  libsepol/cil: Limit the neverallow violations reported
  libsepol/cil: Limit the amount of reporting for context rule conflicts

 libsepol/cil/src/cil_binary.c | 20 +++++++++---
 libsepol/cil/src/cil_log.c    |  5 +++
 libsepol/cil/src/cil_log.h    |  2 ++
 libsepol/cil/src/cil_post.c   | 57 ++++++++++++++++++++---------------
 4 files changed, 56 insertions(+), 28 deletions(-)

-- 
2.31.1

