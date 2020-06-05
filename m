Return-Path: <SRS0=iV3B=7S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933FDC433DF
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 08:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E20C2074B
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 08:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUXqhYjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFEIWJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgFEIWI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Jun 2020 04:22:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506AFC08C5C2
        for <selinux@vger.kernel.org>; Fri,  5 Jun 2020 01:22:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so1026485ljv.5
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2020 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/DIfrI0/rns5u4/3xr+EAAFYQyYn6VngFI//lBX4OJE=;
        b=IUXqhYjQ2X0O9FjtICSd0UCuGjDrTDdfp2iUjvITxbAC7FDW5te7Iq29jTVlYD5QgA
         SlUIJNs1ilQdoMoL7ylsPXHddiF4qzakhCaxTCvihjsRCAXHlVnaI5JPrzQD6YSTVmpW
         oh1mmSf38h2a0aqPz6cBPQpNxWiL1Zl0UZ+2LFJMB7R91DgI9CBnow0f7IM0OlNrYGeL
         bL+IgFWCYLmL/rU4ejbN5+HjTLGArcK0xDPnJJgJ2Ioy2O36SpVPN/P0mwadj25o5eeJ
         XsXbUncyi6SyWK0F2mP/xQsFu12JPyvqttUaZJZv4ZyzZ04ekv54IoxjGzwNLamgGd0+
         WvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/DIfrI0/rns5u4/3xr+EAAFYQyYn6VngFI//lBX4OJE=;
        b=nxA/ju32dLwiSe7Scx07DoSM0RzcBPfBwRSOfF9ddnX3i0wQxYVA1LwdjcKkmhiuBp
         oNpMwptCvwPQRk7I7hEUme1DIpqXXdEktIM73pzfkPGUoe3kyZpukfqLzGLIrKoXyp9e
         Ucq1Z1qFXTQ5UFux0W81LCHNCMZhnXpcqh7Ov7J4lLbMEPtoZtsaJU5qf0lqDILqU8Sj
         6ZNR0jJ+wg/oDG31x6YNjXrQbbEaui+om06aZBd8dsgGJKGofg1JABIJnS6WoOlEO+vY
         UldrFzpB7JePhzPegweRXFtwdBgwqZc/WgX6soFBUdGQQWcOMIZYumbM4pyoIVivGsLg
         u9rw==
X-Gm-Message-State: AOAM531i2LaLQkZBB2mB5cztPFixVZtSEozuNh/VOVIC7nQWBi/gqjMz
        ivzyIFLLmlQ7qimm/4RJywf5BtYx
X-Google-Smtp-Source: ABdhPJzu0caAtDf7GTfpjfHLlsNI/dmSqjFfud5cx5Kc8PjCAV3nN1z9NV3R5vk7RdwmD1D1uUbFZg==
X-Received: by 2002:a2e:854c:: with SMTP id u12mr4113925ljj.422.1591345324598;
        Fri, 05 Jun 2020 01:22:04 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id c22sm589778lfi.79.2020.06.05.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 01:22:04 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v2] semanage: handle getprotobyname() failure case
Date:   Fri,  5 Jun 2020 11:19:53 +0300
Message-Id: <20200605081952.16278-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

At least on Debian, /etc/protocols, which is used by
socket.getprotobyname() to resolve protocols to names, does not
contain an entry for "ipv4". In that case, set the protocol number
used by audit logs for "ipv4" to a fixed value. To ensure audit log
compatibility, let's use the same numeric value as Fedora: 4, which is
actually understood by kernel as IP over IP.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
v2: don't change audit log format
---
 python/semanage/seobject.py | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 6e0b87f2..6a14f7b4 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1870,10 +1870,22 @@ class nodeRecords(semanageRecords):
         except:
             raise ValueError(_("Unknown or missing protocol"))
 
-        return newaddr, newmask, newprotocol
+        try:
+            audit_protocol = socket.getprotobyname(protocol)
+        except:
+            # Entry for "ipv4" not found in /etc/protocols on (at
+            # least) Debian? To ensure audit log compatibility, let's
+            # use the same numeric value as Fedora: 4, which is
+            # actually understood by kernel as IP over IP.
+            if (protocol == "ipv4"):
+                audit_protocol = socket.IPPROTO_IPIP
+            else:
+                raise ValueError(_("Unknown or missing protocol"))
+
+        return newaddr, newmask, newprotocol, audit_protocol
 
     def __add(self, addr, mask, proto, serange, ctype):
-        addr, mask, proto = self.validate(addr, mask, proto)
+        addr, mask, proto, audit_proto = self.validate(addr, mask, proto)
 
         if is_mls_enabled == 1:
             if serange == "":
@@ -1942,7 +1954,7 @@ class nodeRecords(semanageRecords):
         semanage_node_key_free(k)
         semanage_node_free(node)
 
-        self.mylog.log_change("resrc=node op=add laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, socket.getprotobyname(self.protocol[proto]), "system_u", "object_r", ctype, serange))
+        self.mylog.log_change("resrc=node op=add laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, audit_proto, "system_u", "object_r", ctype, serange))
 
     def add(self, addr, mask, proto, serange, ctype):
         self.begin()
@@ -1950,7 +1962,7 @@ class nodeRecords(semanageRecords):
         self.commit()
 
     def __modify(self, addr, mask, proto, serange, setype):
-        addr, mask, proto = self.validate(addr, mask, proto)
+        addr, mask, proto, audit_proto = self.validate(addr, mask, proto)
 
         if serange == "" and setype == "":
             raise ValueError(_("Requires setype or serange"))
@@ -1987,7 +1999,7 @@ class nodeRecords(semanageRecords):
         semanage_node_key_free(k)
         semanage_node_free(node)
 
-        self.mylog.log_change("resrc=node op=modify laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, socket.getprotobyname(self.protocol[proto]), "system_u", "object_r", setype, serange))
+        self.mylog.log_change("resrc=node op=modify laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, audit_proto, "system_u", "object_r", setype, serange))
 
     def modify(self, addr, mask, proto, serange, setype):
         self.begin()
@@ -1995,8 +2007,7 @@ class nodeRecords(semanageRecords):
         self.commit()
 
     def __delete(self, addr, mask, proto):
-
-        addr, mask, proto = self.validate(addr, mask, proto)
+        addr, mask, proto, audit_proto = self.validate(addr, mask, proto)
 
         (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
         if rc < 0:
@@ -2020,7 +2031,7 @@ class nodeRecords(semanageRecords):
 
         semanage_node_key_free(k)
 
-        self.mylog.log_change("resrc=node op=delete laddr=%s netmask=%s proto=%s" % (addr, mask, socket.getprotobyname(self.protocol[proto])))
+        self.mylog.log_change("resrc=node op=delete laddr=%s netmask=%s proto=%s" % (addr, mask, audit_proto))
 
     def delete(self, addr, mask, proto):
         self.begin()
-- 
2.26.2

