Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DF1C25B4E
	for <selinux@archiver.kernel.org>; Mon, 23 Jan 2023 01:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjAWBmh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 22 Jan 2023 20:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjAWBmg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 22 Jan 2023 20:42:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245CB193DC
        for <selinux@vger.kernel.org>; Sun, 22 Jan 2023 17:42:36 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so5343512pjq.1
        for <selinux@vger.kernel.org>; Sun, 22 Jan 2023 17:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CspBM7DiZc3dHJpIwYiUxEPfYKIKKIesAVn0Yq5eeZQ=;
        b=qfDCyAvjaPNrCzfn8tqIkAwHJbw5tmIEvSGl8FKEMK3FAjA+3HA7zjiEacw+4AR8NN
         YYlfqhpORPdEVOKisXlvLdik+0LVZfWMO+fQbAyqrb/YgyJfTLgMr9TgpwfxtsiOUbMg
         oRKpyrmaaUVNqGA055DjeL6yQRAr4XTZifUuTO670+3b0FjoinS/Iq3Mpp7JYjNMC0pf
         gEqlw9N7+QM1nnm9++DkACFcQ4BUPyZjEHdVbvapYTdc5L4AmquRAifrPqbZMuDgkq0b
         Hs/ERuKfk8mFI26r+ggFPV9vl4Wz9nQAQ2JTWJOx+FJuC6vOWy3t/rWnJpy4iMkhkylr
         B3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CspBM7DiZc3dHJpIwYiUxEPfYKIKKIesAVn0Yq5eeZQ=;
        b=1w5X0gORfFbezObAqcLq9PNok4P70vPd+w4YRkYbpMlT/8COUkjZ9fvjVX44hxtvOV
         ly2iNXqlAYdSJ9ERXl7P2TBLgIxtG2dde7Z3QfjHsA3YXMrC3FCnw12o3M/YGE09jsyD
         TFcKaq8RasRQzkLZ4uxypc2O3Ez6foThm3TWdWWTQammrVwYDkWbNa5QVK8EMAUxflwg
         rjTzU7XRZlNICaH3rdxB46UAHHTh6gcq1LS3qYBkoKZyj4/ev95oj45E9rBxVRLVH3L8
         vuI3l6UXv45fuwSiNuroKrWhuT2svicOiJOou21iBJGdVoTN9dtGADsxGQdKyJgwRg8b
         Ym0w==
X-Gm-Message-State: AFqh2ko+oagy4O/IPHGjKG/H9QlT4tJTtflIKBdo0Ulhc+To7cI9Qo4i
        Cl5ZI+rTt89Z+Mr5bvQ+5TatHsv2QxA=
X-Google-Smtp-Source: AMrXdXtXQFGYtQ5QDdPcf792HLLglh8/VTCngSKgPlivKOA7mICGnNV4GcO39NODo3TtRN0Z5ylTXw==
X-Received: by 2002:a05:6a20:6f09:b0:a4:efdd:a9b9 with SMTP id gt9-20020a056a206f0900b000a4efdda9b9mr24144768pzb.44.1674438155279;
        Sun, 22 Jan 2023 17:42:35 -0800 (PST)
Received: from localhost.. (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id z18-20020a63c052000000b0049f2c7e59f5sm25857491pgi.27.2023.01.22.17.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 17:42:34 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/3] improve performance of pcre matches
Date:   Mon, 23 Jan 2023 01:40:44 +0000
Message-Id: <20230123014047.84911-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121180318.11853-1-carenas@gmail.com>
References: <20230121180318.11853-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The following series optimizes the way PCRE2 matches are done by using
more efficiently the match_data resources and shows over 30% reduction
in cpu utilization while only using 1/5 of the memory as shown in the
bug report[1] that started it all.

The first patch is just an administrative change that I found useful
while building and testing the code with a development version of PCRE2.

The second patch reverts the workaround merged in 30b3e9d2 (libselinux:
Workaround for heap overhead of pcre, 2023-01-12) while addressing the
increased memory utilization that it was trying to prevent by changing
the way the match_data required for each match was being handled.

The last patch changes the single threaded codepath to allow for a similar
performance improvement done to the multithreaded codepath by intentionally
leaking one match_data that could be reused for all matches.

Carlo Marcelo Arenas Belón (3):
  scripts: respect an initial LD_LIBRARY_PATH with env_use_destdir
  libselinux: improve performance with pcre matches
  libselinux: use a static match_data if single threaded

 libselinux/src/regex.c            | 111 +++++++++++++++++-------------
 libselinux/src/selinux_internal.h |   4 ++
 scripts/env_use_destdir           |   8 ++-
 3 files changed, 73 insertions(+), 50 deletions(-)

[1] https://github.com/PCRE2Project/pcre2/issues/194
-- 
2.39.0

