Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8153368A7
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619513; cv=none; b=EtgnAKLXkzl2/zmc7v2dclryqG9j1/Bu2pF1ukPCg8VQHFiLqKXbVCA1952m+BD3r/Q3H9xFwCnYNxEUUiGKyzcHKATWVWCWqW/cTZ+/DEvq8Jo4oAwPgFW4knIefG46mXZgRdyCovAvYXQnyaxS1cTTCd5VLyjWgLQ/jplHRN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619513; c=relaxed/simple;
	bh=tW5CzPhoIVkjZJ/x4nMlMCAh7h4yD2cj95ssM96WJy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1WMvidNN+DDMXn5KJBc+Pwa3Z5fJ6Om3tB+9O+dYoj53BYrf58q/PUr6A7AU1VFpjZLo5IVVzMLX84DlD0RafW5RA7MMRCKJpj26Em3Y7eYrrngr8NtAv7kD7zHSAkf69XomTA0eMzUTIC7IjBKeJmk5PbKtY6Uk7i+dQbmcbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mA6Aqglh; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA6Aqglh"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ccf01ba514so46818876d6.0
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781619511; x=1782224311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8DQwwtJP2TKiL3PNztJY41ln+HVPWK4/TNScagnCYI=;
        b=mA6AqglhRUy7Wgx1upbdrwDFaTfkSbaZWD7Urrhx0VpByoAw4sWMXSwBlfrp5ZUQTZ
         w79wO+hMaf4MvvcwV8/0bvNCsRzJub/MbZHokZ7SKFPfrbk1g74uibtg1xHgrtsvZG18
         LuUOOHLj3nRnS03QTNN//ztHer5AgTUsZ7/7HJPVwU5B7mQUSpNnFWON6YUhoC6DjW+F
         SA6YK1LiRmE7rrY18zOLwQsE/Jr+alax3gTdQPZXqPMpRDaNOj6ioM+GkuhoPxDKQVes
         ++zbPyThcdPS1xxK6PSlQYFAMPK8aXDNno5T2/Iv1iK9ORdkck2bDSvoqreYxRly6CDo
         7Djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619511; x=1782224311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8DQwwtJP2TKiL3PNztJY41ln+HVPWK4/TNScagnCYI=;
        b=m5lf/kvsktGfcziav4IcMPVAEQ8dCWIoZd1BCoUQaMCVIadj664dTdceW5wRcjvbR4
         S0W0/9cY0pRqBN+LpYaXXN2r+m51AWvGwo2LVDUelCwlcrxc0CUhyprLOT1e8uz2kSQK
         v/UbbBIRIknRRebVurVlaptQ1V/i3Q81jNJrYDFwhEFXUJ/kHJdX8bh7+LabYYobRrPl
         gzihpVUkQcjv1hlpEN18El4OM+DRZJWO7Qtwv4yQOq/VFRnUZKghbr2Ts5VoUMJuKefj
         u5+u6aQmojEa/GswMe1qEBYigmSroLPM5EMShRrWCj9ebO733q8FY5OhW3G65/H/eiyh
         7Pjw==
X-Gm-Message-State: AOJu0YxpSTb50G+wUqLG9Uh2eHJCEOr5oHRB/tiWerc/XDJoI9V+zJQH
	5/rYFfjrLSOT4aANLvMA0Fq7lt7Ixur03oH1LW+IfMgmbkcCdcz3shcAEzXVuw==
X-Gm-Gg: Acq92OFf1M1coX58a6K7zyc205uD39dCY+0FMRwoI5cp3aipARbgFeCkPf0b5EDNHgS
	3QMeShlLQU7S2kBVnotjJGZHlOaXovqL5ZTjNuhn7KE8hRJ+3JbAXHZSm2oErhEnfoyyu0ee0rB
	xdq2TZqMlsnaqltGnO5ufNfg7sh4WDOG6tTYDLQmM6cibO4mfAC85HflI6sf6+A9RSc2+JUWFRR
	riClHUElP8VHXcWARh8cisFeWk6d9WoUNGEJ76Uet/Fjnmli98OkTsATl/RyuHhtVDiLEZNb+yH
	xfuWjkMG2sOqTqqjV2pfXjQGJTSwr/XvjVyhF4mtst2y80hLkqFAwCUKOaKReSoRjzkHGjfboIn
	kKZn+8A3UcftB+rX2eBwO8AitmXWYA0fiHfxjNsDB3bXe+qFNEKhBr/ZBHiranpcbUEFJlt/WOa
	WuLRAU7BWDY2IVb9KtDJ3p7wWjmikJPo9Q5DR1AWv65JGSdw==
X-Received: by 2002:a05:6214:3a85:b0:8cc:ea2c:f2b3 with SMTP id 6a1803df08f44-8da1d7006f7mr54796436d6.21.1781619511276;
        Tue, 16 Jun 2026 07:18:31 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f47408besm34075726d6.28.2026.06.16.07.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:18:30 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol: Check for proper length of addr and mask buffers
Date: Tue, 16 Jun 2026 10:18:19 -0400
Message-ID: <20260616141819.37971-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating an ocontext node the addr and mask buffers lengths
are not being checked that they are the correct value for the
protocol.

Verify that the addr and mask buffer lengths are the correct vaalue
for the protocol and output an error if they are not.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Use sizeof instead of 4 or 16

 libsepol/src/nodes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
index e3ad36a8..0596f387 100644
--- a/libsepol/src/nodes.c
+++ b/libsepol/src/nodes.c
@@ -34,10 +34,26 @@ static int node_from_record(sepol_handle_t *handle, const policydb_t *policydb,
 
 	switch (proto) {
 	case SEPOL_PROTO_IP4:
+		if (addr_bsize != sizeof(tmp_node->u.node.addr)) {
+			ERR(handle, "Wrong address size for IPv4 address");
+			goto err;
+		}
+		if (mask_bsize != sizeof(tmp_node->u.node.addr)) {
+			ERR(handle, "Wrong address size for IPv4 mask");
+			goto err;
+		}
 		memcpy(&tmp_node->u.node.addr, addr_buf, addr_bsize);
 		memcpy(&tmp_node->u.node.mask, mask_buf, mask_bsize);
 		break;
 	case SEPOL_PROTO_IP6:
+		if (addr_bsize != sizeof(tmp_node->u.node6.addr)) {
+			ERR(handle, "Wrong address size for IPv6 address");
+			goto err;
+		}
+		if (mask_bsize != sizeof(tmp_node->u.node6.addr)) {
+			ERR(handle, "Wrong address size for IPv6 mask");
+			goto err;
+		}
 		memcpy(tmp_node->u.node6.addr, addr_buf, addr_bsize);
 		memcpy(tmp_node->u.node6.mask, mask_buf, mask_bsize);
 		break;
-- 
2.54.0

