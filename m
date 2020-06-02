Return-Path: <SRS0=4SPy=7P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476DEC433DF
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 14:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19472207ED
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 14:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR136cl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgFBOTm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgFBOTl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Jun 2020 10:19:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F5C08C5C0
        for <selinux@vger.kernel.org>; Tue,  2 Jun 2020 07:19:41 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b6so12853018ljj.1
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2020 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKtsDAd4W3XCIhjshubOlwG/GFaSV1MxvKTTx6MGrvw=;
        b=IR136cl4i2Zxt+OhRF3c3hXYiJAJe5KEwpiZKZGWdbo5sop/cvbssXa/tTp0GvIG1r
         xYoqSOWstxhazkF2ggxeVJh+HZl2kXchKO760UM2kge9k/oYuT6CVaJpQMHD5kUCfHn7
         opXVRgOiOqq+bqQiLfApooqxZWrlaijxK4ATXUMnpdm4EZlsK/p1Lu5DjAe3T61487sU
         GZGE/Pr3kkUjD2SgpSnXyAv54vwgwoNWmPw7CycjwtL0R/Ati8HZ3Mv7IGZuni1B0vea
         p3+neO3zB6j2hfN6vJP0pxBd4/y8kiPVf8wH5I3eAPM7Th8gRvsI03irkouuMxOdZQfg
         1DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKtsDAd4W3XCIhjshubOlwG/GFaSV1MxvKTTx6MGrvw=;
        b=Cs5Iw8MVMLP0/1XGuFFhe9e5MC3msCH7+mDj0wMgU0trCg7K5YTLUlcoFokA1EchYI
         mo77xbZqNJV4INEsMgkGQGa+9ZvzaeZA5YSC0usOrrMvHIWzDI2cNYH+zWNXi3MpHnGo
         BWVEhcf4+HJlDgDLh1Jg63KnEIb72HQcDZqjsLeD8PNO6njU9WGm5IovAl6KV/11cUvh
         HEUkV9dfw/dZg/DxrcUkxs5N5dhHOg6YChcz2QUCDEv4Dg+JWFpmU574wkkVr8Fdqhyy
         tdPTyTtg29tqpgDjHXei0DPTHu/XlHJ7yVnohOXe/UOEoUbqZQEpq3aKe7pUpSqCsQ8w
         xuDg==
X-Gm-Message-State: AOAM532tUWQeEqc58MU0eygzbPc4YFzmGjwSoKeW8iWAEAi76PlKAMaV
        kZrzdUZWK/BpL7a7SNml2ol+9cP+
X-Google-Smtp-Source: ABdhPJyPu0tmqelhgc7QVp60gDbvy3WRJE9N9qPDjC1HM4s9WuKDUX5kOFGlggy2oL+qOPvIyKFl+w==
X-Received: by 2002:a2e:9193:: with SMTP id f19mr14163723ljg.44.1591107579150;
        Tue, 02 Jun 2020 07:19:39 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id a1sm846734lfi.36.2020.06.02.07.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 07:19:38 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] Avoid using getprotobyname()
Date:   Tue,  2 Jun 2020 17:19:35 +0300
Message-Id: <20200602141935.24722-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

At least on Debian, /etc/protocols, which is used by
socket.getprotobyname() to resolve protocols to names, does not
contain an entry for "ipv4", so let's avoid using
socket.getprotobyname() since the protocol names are not used in
socket context anyway.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 python/semanage/seobject.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 6e0b87f2..dfb165a2 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1942,7 +1942,7 @@ class nodeRecords(semanageRecords):
         semanage_node_key_free(k)
         semanage_node_free(node)
 
-        self.mylog.log_change("resrc=node op=add laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, socket.getprotobyname(self.protocol[proto]), "system_u", "object_r", ctype, serange))
+        self.mylog.log_change("resrc=node op=add laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, self.protocol[proto], "system_u", "object_r", ctype, serange))
 
     def add(self, addr, mask, proto, serange, ctype):
         self.begin()
@@ -1987,7 +1987,7 @@ class nodeRecords(semanageRecords):
         semanage_node_key_free(k)
         semanage_node_free(node)
 
-        self.mylog.log_change("resrc=node op=modify laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, socket.getprotobyname(self.protocol[proto]), "system_u", "object_r", setype, serange))
+        self.mylog.log_change("resrc=node op=modify laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, self.protocol[proto], "system_u", "object_r", setype, serange))
 
     def modify(self, addr, mask, proto, serange, setype):
         self.begin()
@@ -2020,7 +2020,7 @@ class nodeRecords(semanageRecords):
 
         semanage_node_key_free(k)
 
-        self.mylog.log_change("resrc=node op=delete laddr=%s netmask=%s proto=%s" % (addr, mask, socket.getprotobyname(self.protocol[proto])))
+        self.mylog.log_change("resrc=node op=delete laddr=%s netmask=%s proto=%s" % (addr, mask, self.protocol[proto]))
 
     def delete(self, addr, mask, proto):
         self.begin()
-- 
2.26.2

