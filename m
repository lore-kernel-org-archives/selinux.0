Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133A9C10DCE
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40ED21655
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7BctBVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgCJVJE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:09:04 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:44886 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCJVJD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Mar 2020 17:09:03 -0400
Received: by mail-pl1-f179.google.com with SMTP id d9so5813plo.11
        for <selinux@vger.kernel.org>; Tue, 10 Mar 2020 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r5vCOhYS9sLF1iTm50Fe9u7RdKRePAYdYk9TVvEGfn4=;
        b=t7BctBVBYD8LgnbNgIsL1dfykknCL++JoH8lwoEhzQfTTOYSyzDtw646iaH7EPfwRy
         Dd8/Pw3mXkvtwMGqfPQYTIZ5hprBn5HrVysHAzL2PFN/oBXHWcnj80t9w7brFI3uVo3l
         nBUgidZAsUYLxnzWF/JIdPKm+Mn8q5+fNA7Kydg8tz9EVo1fWqjqi/S1s75CGtUYQpmR
         Ih6IocRbkR2msoNLHPHKEw6Hdm8OqrGHa/FyGT4UjkpzgArixf8008ssQbGlZu46xCN8
         EO11NJC0MK+2v7DQGUdnDyAj79m02MPEaiugpQXYutwWFOoN7nJINGxu0KG++b7sp8oG
         Bgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r5vCOhYS9sLF1iTm50Fe9u7RdKRePAYdYk9TVvEGfn4=;
        b=t5Z+DuuB1Wa9XPWa0CDNYKO4WUCGhX9BssuhikstHG22aRJCnzVBMFqZkSdwvrv6BL
         5MGiiSRYbfRvEWHefckHt+Hd5hDDDBdFV3KavkW8WCFoRkmTcNOhPOi+hkYdL+6KD+5S
         XWjdTKsSPxmHpWbISEI0bXHNDKOEhRavnqXajp5zFC91nMQ7IUIZUsmjbAaxycWOhxHR
         sR2cprwCE7ozm0csUmQLBw3rwB4bM7DrYajMuXWlPVPtYlNR+IlTChwuel9ZhxEkMSXP
         lv5MfQCblkdKbGh2UOaCL8q4/qrjExQz28NzXWRAC0vunsszX38kiRjcUzsI/oHNlYRp
         IsYA==
X-Gm-Message-State: ANhLgQ1GejOe2Af8kAKZdl3VwtP8o/Of5jTdRt/msZAckaeb09z8s6FI
        HkkaBlmj3WhWaErJV5FEGdtmNmTkgFk=
X-Google-Smtp-Source: ADFU+vt2bdv4H70bHnqfdb0okgK6NOAPuyOXktw+l/Xj6ZNQqv9t7RH2U+JOlFejI6tHzJ9k5gBVqg==
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr3523796pjk.135.1583874539907;
        Tue, 10 Mar 2020 14:08:59 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id s11sm19378807pfh.7.2020.03.10.14.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:08:59 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org, selinux@vger.kernel.org
Cc:     bill.c.roberts@gmail.com, drepper@redhat.com, omosnace@redhat.com,
        plautrba@redhat.com, stephen.smalley.work@gmail.com,
        william.c.roberts@intel.com
Subject: V2 libsepol drop dso.h
Date:   Tue, 10 Mar 2020 16:08:51 -0500
Message-Id: <20200310210854.466-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309152539.8581-1-william.c.roberts@intel.com>
References: <20200309152539.8581-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

V2:
  - Add a third patch that removes the wildcard from the map file
    and gets the exported symbol diff between master clean.

Following up with the dso.h drop, this follows in the same footsteps
using -fno-semantic-interposition and a linker map script. Libsepol
already had a linker map, but was using wild cards. So a patch to
drop the wildcards and explicitly add the exported routines was
needed. Since that patch to the map file is so large, I also sorted
the list so its easy to follow. Additionally, like the other pathes
for libselinux, add the -fno-semantic-interposition. Also, in keeping
with similair behavior to libselinux, I set the option on the
overridable CFLAGS.

[PATCH v2 1/3] libsepol/dso: drop hidden_proto and hidden_def
[PATCH v2 2/3] libsepol/Makefile: add -fno-semantic-interposition
[PATCH v2 3/3] lbespol: remove wild cards in mapfile

