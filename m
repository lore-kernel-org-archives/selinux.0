Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6F0344DAD
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356766; cv=none; b=VWx2oX7zh/1wxfXIaRSVL1uPXyDZxvgwUjxrgsX2RZ1VtBYi26mM4033SmGzaYTYasw+O4BekyIUcDR2O0jy0piIkJuDWIVmxrtUHJwMgjCZaMiDNbXqQ81hnYPvdbsQGa6+OSD8urLz7dwhUb+PQeVW8ywuyzkoRzBTR9nBeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356766; c=relaxed/simple;
	bh=J5/BiK/lwIFRuvFQcpnw0TGqZxz2CQF3e8amza8np0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNgqZEybUB2fd/kRITdZZY4EJNvAciN+3IkaB9syWmzzjhXGVFrNelp7sli7xkG0IgcsIEbdYLdTFWpJ8qlaZRlXFlafZpMpEduXX3rNaWmvROKcdApeIJTmNPGbT7jPp9kjzRruQt361loX1j0/4GG/C4nA8vkohdLofLQHdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9sqTar0; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9sqTar0"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52fa9c055b5so29512791cf.1
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356764; x=1788961564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXy60JD+GiyAkmdOxFQlKJTClqf70V6K4WaugdKwxHI=;
        b=H9sqTar0v4+Q8Ydyp78sELlcda+KN43+cGmGCqDFJFh4buiylJp/UmDXR8syHpeyB1
         v+/9L9e3CFxm3KjVtQkNG+4P5sY9WOEy6fvOjpp3x/aphuFT15rJWPherUHavsyDCBxY
         4q/IMwQ/poB3CF9ZJk+pbzQj/1e7WBa8/ygAQoZhJ19xx9+pdyCW4SB1oAqVTrD4vBRX
         x7dhzupDBpNv0TTNfGhMsq+WMqoLoBblvMsaolCb2C61yCscsTsmiZRWQc4v9Gf0J6Vv
         IslVzwpwkGn2ieQM6hWbpZxhhA0E5/BwR9jNEG8GTXY9Juw4Ukw2/AWWGTqeOtDBs1yl
         f0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356764; x=1788961564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXy60JD+GiyAkmdOxFQlKJTClqf70V6K4WaugdKwxHI=;
        b=CIqj9qqg95PwJIov4gcxxCyAFphMhzzAEPwbOVtlsLyGFRt8oidS75z4cdx/Um6NGP
         Gpbmdgltpfu9g0xFpbke1xYWUJP/oBBnulPZkqlQuief/JEQ4LT30zWE2EWcW1YQAMfl
         wCc5h+U8tyNnNq9fka6QV7kGwCWK9L7W6VAKiVTN8mvvvn54vpskRLB2hp+c0rPp/JI7
         G+ilNLflB3iwaIt4R0ue6wRsL6Xb/RZC2xX9qfoPkUQGUHmo9+QPeUA1m+RegXKvTSsK
         kZEU+eIjnfSHwf4e5nyEXzD2SVk+OnEX2AQy5XjAbzzb/c0YVv5ksx/d15GT3M6MXnBG
         REmQ==
X-Gm-Message-State: AFuF++l9k/lG9H9e/Pcq1LkZL8cZIR8V5CqvDz52sG8S0Lx/qbjTi0vQ
	3s8Ztu7LluVBnbi4Z9tvoACHhbti2/Li1lhXO25P7AIHq2RNvKY16KYpA5QuxQ==
X-Gm-Gg: AR+sD12Acu8OeTIRYtbMghAgS4B7d9z2XsEDPkGq+II+kmOUeierZfLnEeA+Q5bf7Rs
	sTf4T7E11LUboHrtWvuMPbhCa9cwO6BygnjtCYetsWF8x2Pbw4gHaomkkURbnoLRzbro6vuFytA
	PCBUwS2j01Z4K2MlVPUrx31RdD7F3QKOKH3VqGwj/1WPLRGOb1dF3Qa0svHB1rjnNXx29uLAXBf
	QueGQHPoD0/9CQzOoQl51h451Ap+/BfnEgjBKcSx34oT6jREdGEt4Zygo8YHFwnEpTRlBLbz7XE
	Xp4GVJ7LSMnvp0x6Z/9BSDv0XkU+eZKqcB3iYA6mhIbrpX5Pg8GCTd2I5/2cLEPe0rsRnLJBNyd
	rDCM6+BAeZT0CcyG3QF7SKbPkSEFSwVC2llRa3Ji7ZrR1ai2TyAYObCSvOLNw956IpILODwSWFU
	YWOjYsG5bxPVXjzNuD1uraba9KqnSSnCGLTWF7B1V7lSO2pjm8WgojyA+kcJ6gAelewvdp7llfF
	NIiMUvRhIvXpa8kaxwG9DzN5Mow9ugbUTrKKUDfLfleib10DbOxigcby9C7Jxj7
X-Received: by 2002:a05:622a:558a:b0:52e:125b:9444 with SMTP id d75a77b69052e-5303a5b4966mr36008401cf.17.1788356764002;
        Wed, 02 Sep 2026 06:46:04 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5303325af1esm18686011cf.29.2026.09.02.06.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:46:03 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 7/9] libsemanage: refuse to remove or enable a module owned by a RO store
Date: Wed,  2 Sep 2026 09:33:15 -0400
Message-ID: <20260902133316.51981-9-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
References: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semodule -r <name> on a module that exists only in a read-only store
has nothing to unlink in the writable one. Detect that case in
semanage_direct_remove_key(), notify the user, and suggest using -d to
disable it instead. Removing a writable-store copy that shadows a
read-only one is still allowed and simply un-shadows the vendor
module.

semodule -e <name> when a read-only store carries the disabled marker
has no effect since get_module_info() reads the marker via
semanage_module_find_path(). After removing any writable marker,
re-probe; if a read-only marker remains, fail with an error message
pointing to its path as the cause.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index c856aa0b..c149384d 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2276,6 +2276,23 @@ static int semanage_direct_set_enabled(semanage_handle_t *sh,
 			}
 		}
 
+		/*
+		 * A read-only store may still carry a disabled marker for
+		 * this module; the writable store cannot override it.
+		 */
+		if (semanage_ro_root_count() > 0 &&
+		    semanage_module_find_path(sh, modinfo,
+					      SEMANAGE_MODULE_PATH_DISABLED, fn,
+					      sizeof(fn)) == 0 &&
+		    access(fn, F_OK) == 0) {
+			errno = 0;
+			ERR(sh,
+			    "Module %s is disabled by the read-only store at %s and cannot be enabled here.",
+			    modkey->name, fn);
+			status = -1;
+			goto cleanup;
+		}
+
 		break;
 	case -1: /* warn about ignored setting to default */
 		WARN(sh, "Setting module %s to 'default' state has no effect",
@@ -3058,6 +3075,29 @@ static int semanage_direct_remove_key(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
+	/*
+	 * A module that lives only in a read-only store has nothing to
+	 * remove in the writable one; disabling is the closest equivalent.
+	 * Removing a writable-store copy that shadows a read-only one is
+	 * still allowed and simply un-shadows the vendor module.
+	 */
+	if (semanage_ro_root_count() > 0 && access(path, F_OK) != 0) {
+		char ro_path[PATH_MAX];
+
+		if (semanage_module_find_path(
+			    sh, (const semanage_module_info_t *)modkey,
+			    SEMANAGE_MODULE_PATH_NAME, ro_path,
+			    sizeof(ro_path)) &&
+		    access(ro_path, F_OK) == 0) {
+			errno = 0;
+			ERR(sh,
+			    "Module %s at priority %d is provided by the read-only store at %s and cannot be removed; use -d to disable it.",
+			    modkey->name, modkey->priority, ro_path);
+			status = -2;
+			goto cleanup;
+		}
+	}
+
 	/* remove directory */
 	ret = semanage_remove_directory(path);
 	if (ret != 0) {
-- 
2.55.0

