Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B794C433F5
	for <selinux@archiver.kernel.org>; Sun, 21 Nov 2021 20:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhKUUgR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Nov 2021 15:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhKUUgQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Nov 2021 15:36:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79D2C061574
        for <selinux@vger.kernel.org>; Sun, 21 Nov 2021 12:33:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id np3so12115958pjb.4
        for <selinux@vger.kernel.org>; Sun, 21 Nov 2021 12:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=008pw7L2WifbC3MTWNCzsUknYGJTEiQp8mdDUlhMinQ=;
        b=km6BqexqqH/Vivb0pYX/N2X4mDtI7f4Q0qfOhMvvLnTNlTntbnsSKal06/nV9qZU2e
         ZdqF9pWga8c/Lw0eQ0DMO1+ciYpSC2mzaNAy35c/07WBxFHLug0C0vgmQihv+ExGW9oq
         Ez/VhISl4tNZ+MPB5Mlv1aDCNpCwSVxSOD1tT0RXxS6TbSnj29jWpLqPMq3eoLYO0AxD
         x1HdyjDFTWeyWvURJrBgSI0P7W/PGLkdlg/SzJXo/I8c9TPa4y0jOA21sHjSBMi3jaae
         f2n9qBz+w/FKmcchT027kIo2lP/bdOq76McyoDogm+bTZubSivOlzMOu2uh5+JuD6Wke
         7DEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=008pw7L2WifbC3MTWNCzsUknYGJTEiQp8mdDUlhMinQ=;
        b=XwxAeZ7o0qolY5HYysod0ON72R31dayDgUk5TKKdehZS9EMtyqpfb+gkr/bOGRI9gx
         8s2NasNaf27IYVHEd8ji/b8UWEyqsIXQ1ZjumWMWctYJa5csutqvY6N7Zvq+X2rpHc18
         MdhuhBO4Ts8Ny0Y3JSxdSjmtJWXFImApqe83QpdgbgJhWrqm2SyifVyKe/VBbNcgLGOx
         0pkWoyhIHIwCl2YGwyPLeMX4bRAi3O5OGhRzPQ/5OFLN76M+V3/NpUXX+ZsudiGFsGCt
         C+rU0UZx87PryWCxxUIxSAFlAMTR2D0YpTPmNA4wVXVF+fC6Lq2a0+01aR1iKXWifkzD
         X+DA==
X-Gm-Message-State: AOAM530njTK/cgeq7AqDgSQ8/KB9YXu9+bT6aMRiSjfh15qPT+GAHmuH
        Gdm+/cKR0sV+Bwy0uKjnq8w64CxiieXxSvHz
X-Google-Smtp-Source: ABdhPJybabi93EQQ3dwjV+4DkDmutKeJHlhxAZTSYtkyOogzlGMMSDxUkiy9/dFA5XGDeFReGG3joQ==
X-Received: by 2002:a17:90b:3e8b:: with SMTP id rj11mr24487004pjb.63.1637526790975;
        Sun, 21 Nov 2021 12:33:10 -0800 (PST)
Received: from localhost (136-24-42-138.cab.webpass.net. [136.24.42.138])
        by smtp.gmail.com with ESMTPSA id o134sm5971396pfg.1.2021.11.21.12.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 12:33:10 -0800 (PST)
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Cc:     Jason Zaman <jason@perfinion.com>
Subject: [PATCH 2/2] dbus: Add filetrans for /tmp/dbus-* session socket
Date:   Sun, 21 Nov 2021 12:32:31 -0800
Message-Id: <20211121203231.3625-2-jason@perfinion.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211121203231.3625-1-jason@perfinion.com>
References: <20211121203231.3625-1-jason@perfinion.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policy/modules/services/dbus.te | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/policy/modules/services/dbus.te b/policy/modules/services/dbus.te
index f629d508d..576b29f03 100644
--- a/policy/modules/services/dbus.te
+++ b/policy/modules/services/dbus.te
@@ -247,7 +247,8 @@ userdom_user_home_dir_filetrans(session_bus_type, session_dbusd_home_t, dir, ".d
 
 manage_dirs_pattern(session_bus_type, session_dbusd_tmp_t, session_dbusd_tmp_t)
 manage_files_pattern(session_bus_type, session_dbusd_tmp_t, session_dbusd_tmp_t)
-files_tmp_filetrans(session_bus_type, session_dbusd_tmp_t, { dir file })
+manage_sock_files_pattern(session_bus_type, session_dbusd_tmp_t, session_dbusd_tmp_t)
+files_tmp_filetrans(session_bus_type, session_dbusd_tmp_t, { dir file sock_file })
 
 manage_dirs_pattern(session_bus_type, session_dbusd_runtime_t, session_dbusd_runtime_t)
 manage_files_pattern(session_bus_type, session_dbusd_runtime_t, session_dbusd_runtime_t)
-- 
2.32.0

