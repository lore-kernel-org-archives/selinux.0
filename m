Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E6408612
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488488; cv=none; b=rBRdt0nb/WCtvf7HOLYA+6/WMTXVzvCG5O3O7y5BPCZC6zz+BCMZ2U2Iz/HN/RYashZGu4CsJvF3CSCZamYVEUVoI1p71EHqJNHqxoEA9VmS7+RlxNQik0VWlMCcK5G8e0gs06wziAx6s68v+ih0IhVQNN3qtKrRNzDwrOQuSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488488; c=relaxed/simple;
	bh=SWscl4vaDMQdBVIdc2szP9ILxLCGmILSdvP0BOawJkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l62xTAH/he/LQnj5bozMv3VuXjWBQoW/r0YkU6mn4IXlNA2iMNFpfMnv8mZtvROPkmpXDyDca3fQqlzqGs11Yh3LdAwF0+Jca7eFv5/AmCiV87lqrKL+KyJ2rorKeEmwcdC66W3XhW4Op17C+FGbUs53uZdWu+TLbConmDFsLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsbXcZEB; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsbXcZEB"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso41677276d6.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488485; x=1790093285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EnQ2stnK9rv3zs7Ac8wbxM1DKTt7wqJKC3dydQNCdj4=;
        b=VsbXcZEB8COCDMTw9tyuh1citZTdBBiSm3+AD+vDzY7b7+MMVu01cjxQOci8OFKBYV
         v11ttjTutO4uoD67a/nUdbJeyhoY8CTSlwJ0LG7JS8EMI7BV2blNhQ8uy2elXqBXBDiK
         yGqzWjuRl9kOB7dT3hYYtAPXFVp8yvnxSOHMVL4J8RES85N4EMWLvD73fCPvZ5FfyFRU
         VjcLzqc1SXcy3vkuUly2SXJBjc5VIrd1r5+SkflK5JG1Riaz1hUqRnhbG39brOpYH0d6
         4EecjwxHtsGaoSzFs0EHp46eflvvTk/1jTkMCGoqoKYHLlgPmFo6Iu4AS5ZWjnO8TBkP
         d9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488485; x=1790093285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EnQ2stnK9rv3zs7Ac8wbxM1DKTt7wqJKC3dydQNCdj4=;
        b=bPwjnYeEQvwuRzdY2tblWo+h58pXX/kI59pfZ1IW3buefioLZQIsLsjglU5GYeGDp2
         XmONRCLKGpyRsbZrkhqrTQjHB4gQ3YSM4u3S88Gvfuf36Af9tEaWhZhKTxVvPgofuSPQ
         vqz7DFlv55dounUqaDlF3Qeskl1FnabtxgwX6to4iYfufeRcgKSoimFTeJxnpFEWGodH
         Z5LsX58Jz4qA5A+CJsCqr4W8UZ1xqiDL2CftjWqmUyIwfzCs//QdfgOaRyLSfK0CiZOr
         rZ86PSwpRtxM1TqwcjjS01HCqulSP+FFAiLLXViQMPTjPUw9efhXTybriTTKg5GzcRDI
         5Tcw==
X-Gm-Message-State: AFuF++mmHkp8v9llTgC0ZpUGr9whhh2HZKAPIYRb7P7oxviSb9536aaZ
	7cqS5/foXF1IrtpW8nX8ckHasezl17gZ6mqC4fa2Bd9P9KXlIW1J+dol9TvZGg==
X-Gm-Gg: AYBFou3MBLBJxmOVwRQg+e86rMtk1XnWbnXv4ax9Aj8PsDkAGDt4DdDaUGWOUTS7opL
	TbHZgIBElw9ooEmGmsAX9PEZGdpi6AGkcu2ovC/BBE3w1jGPO6pnY/zYi64I9n0aFJ1+nQiHglu
	nRunTIZM8f7sQVMJJbV6kwNMKiZk7nFDT7ODO/gZM1wTuwGyg/coRERu+vePIC7ur2u8Ybn7EgV
	T/XPwDT8Z7Ij7O2dz3J7bAKrX/wnOqQTGpXbN6zX/tOnACdyLEZeyWxQUEfQd9PGgKT3ucA+wUt
	kA2O0CVrkYQ2yjTl+0MNtvv0fb24rNxuemCPNonH7r3Y0BrTsBz1pOp7SANuoH3Z77jjLSV8MBT
	G5vdp+7lPoCglD3f5ov8lZ3Xv0jYghuvHs1lGyl/qKeMpvm2E7LsNJ52EbVdvBJ5FSyHjCxoQXG
	CW034DtJcmM96uks73SPx9rhmlz5CKdiNA1Mvzx81UK+Np8jU+s8bpij3mwtTu0sazLa/c+Rqrt
	PfaUdX9SxngjUbb67h3WlQ7ZU1B/eW26W9Xrr0/S87zADSojZo/7vp4qUV1nm/8o9RtF0e+FME=
X-Received: by 2002:a05:6214:406:b0:910:3452:d57f with SMTP id 6a1803df08f44-9122e664618mr142775926d6.31.1789488485094;
        Tue, 15 Sep 2026 09:08:05 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be7c885sm1961696d6.21.2026.09.15.09.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:08:04 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/4] libsepol: reject out-of-range OCON_PORT field at read time
Date: Tue, 15 Sep 2026 12:07:36 -0400
Message-ID: <20260915160738.46723-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The on-disk portcon record encodes protocol, low_port, and high_port
as 32-bit values, but ocontext_t stores them as uint8_t / uint_16_t.
ocontext_read_selinux() currently narrows without a range check, so a
crafted or corrupt policy with e.g. protocol 0x106 is silently read as
IPPROTO_TCP. policydb_validate() then sees only the truncated values
and accepts the entry, and checkpolicy -b re-emits it as protocol 6,
changing a binary the kernel would have rejected into one that will
load with a different meaning.

The kernel reader already bounds all three fields (U8_MAX / U16_MAX)
before the narrowing store, and OCON_IBPKEY / OCON_IBENDPORT do the
same in this function. Apply the same pattern to OCON_PORT.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 551bdad9..6a9254f3 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2741,17 +2741,29 @@ static int ocontext_read_selinux(const struct policydb_compat_info *info,
 					return -1;
 				break;
 			}
-			case OCON_PORT:
+			case OCON_PORT: {
+				uint32_t proto, port_lo, port_hi;
+
 				rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
 				if (rc < 0)
 					return -1;
-				c->u.port.protocol = le32_to_cpu(buf[0]);
-				c->u.port.low_port = le32_to_cpu(buf[1]);
-				c->u.port.high_port = le32_to_cpu(buf[2]);
+
+				proto = le32_to_cpu(buf[0]);
+				port_lo = le32_to_cpu(buf[1]);
+				port_hi = le32_to_cpu(buf[2]);
+
+				if (proto > UINT8_MAX || port_lo > UINT16_MAX ||
+				    port_hi > UINT16_MAX)
+					return -1;
+
+				c->u.port.protocol = proto;
+				c->u.port.low_port = port_lo;
+				c->u.port.high_port = port_hi;
 				if (context_read_and_validate(&c->context[0], p,
 							      fp))
 					return -1;
 				break;
+			}
 			case OCON_NODE:
 				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 				if (rc < 0)
-- 
2.55.0

