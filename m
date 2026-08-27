Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3D483802
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843501; cv=none; b=IBH7+z5XBbLuZ6vJC7GNyoh9Nf/wqVlFzRL1QVxLd6VQ3fqqwUK76l9TCEke1iy/uD6B7Bi6jzfUvpRJ2GyPsp97YcPOgN582bPGCtql47ihMWchRBMbpGHjTQnMJBtJ8X/Hg9S4v3iAigNIDhYnAG8t/gmBl8rpICyMZMH2z30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843501; c=relaxed/simple;
	bh=6pdMZP6qFF2+B0N+2v2HuExIDmRVTe5O84Kznca+NYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GIFrMhLVkTrPdqb5cOCT6SGVWZqStMSM3Ieh7xMIkZTZqktEW3Rus/F9IDsu8ThLIq8YgYfxLyh2oz2jQGL5EQDKlOoKt7bHEkb/EiVMDA5Wl7qiDggI0MyFWlDyWhpHow0cDruUIs/Of2q2NVbhEb4iq0BtWcWzFF9Fb+kdzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AWYCcaj0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AWYCcaj0"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9387752a4d0so82127185a.2
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 08:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787843497; x=1788448297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KYGMFCU8TuWd9R/BPMvAqU2px2NU9+5o33+qPDsvJ3A=;
        b=AWYCcaj04nAygppWv+fvPi+DvAL4BDHt9fGuFv/c3up0XHQ2RXxtu4z6mUbb1mYC9k
         iFAX2qfEKwl9hVUWeV5aAdb0fSJ1DJS0lxasc+DhA8V/cAPZ9fi05LcHUtBXqaH5uC51
         1r6yPSSAVlWCVlSteWRt1QgmrIz0h4VFzrNE0TOQmyWlrwb/WnTPNdQxOCjzekFOH+77
         Za2616eO7ctdEfagnW0EhCKmSfq0SD8W87X86HC00zUNojQQf6T/tbFD6CQrRVy6adnx
         TNyRhCwTsRYvwsvKKxc6ZT+2gO/W1cSgGQjF+w2YadYo8VvegyuCylfB0+EKA4eQnrGD
         4fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787843497; x=1788448297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KYGMFCU8TuWd9R/BPMvAqU2px2NU9+5o33+qPDsvJ3A=;
        b=LqmMYN+tNOTxP2dC9Dtp/1HAT6wZkpr85mJsY5OchvvV0khP5YG5YkyHxbRNjqTgoq
         bXU5KiQ+sbi+eGKBboZNvbzbZ2cseACCB8nKV61n1bZzBZhhhWtoEHAzykqcT4BNhPtt
         Zv82Sdzy8PPpafEHeIy67ykGEs6kGlK1p8ajA4mjv1zDaxuKDYw2PRVON01Wa3BqiinL
         1B4eAHI3Hl0W5oqklkQ8MOZDiEOxlf93t1N+pP2Jz16W+VYNuYN8wIlJLJ5Y4A//CJQ9
         b0JgacAzhWxQp1XeggSQp0JFVzUPanRWu1wNKYd/ELbxradsx9c0Ivi22tyXp2bDGKFb
         v04g==
X-Gm-Message-State: AFuF++nyQkH/s9CMYWJmIkf8Sr6274B1Goz7SYNq80ujJe9Hm4utseiz
	15LKYn/JANLCz/YENo9Uz9zqePTlCuLiQ3PtR7lDsBmM5sr56nt7hyOixo28sC0ApOBOXMuWkFl
	QG9gwIA==
X-Gm-Gg: AR+sD12ZHpHgvGG7nK0lWt6ztkbNog/AERyJ//1omvqVttBKpHhG0iq3DSZQgiEZ2oU
	2LFHwoe3FzC9zpdU+xNGwKqg+5qhuFTPne3eGVH1pu/fxE6Elvy04eR4vNCfPbeb7w4w6NfXa5/
	zszLMXSmyGyDX5DNG1cIESC+1XeqGLqLRQuKNc8DN8Z3037HBu1XVnfKRCdXalueqi2TzrcR/Ai
	sgvqJ4FWfLE1YQ5b50VEa+H+lkG1/VJbiSknBK/SUTyMOplghGvmH8+8wXrz3M3OFRLhbPgh+m3
	WhtoRIoq707Ikc+ce6It7BUubG7zRvwHGTsMcVkkiSCSIFlvox12R/Z5GonSjQdkJjY8hX8/SCT
	G+qUYw7EC3gIWMca7ExyKSWXWOlpbYHr/6zOhvlleAEKzkTwtN6Ct3etsr2ZsWkWIEXH9xYbkVE
	FDL6ck7aW1Sam/nrpIueTkoYPQHy2tlRP/T/J+UqzgQyZ2oK1u2CtnKz/B1j5Loj9s7VTRE8H55
	N/tFXPSl/RvH5CSmL06dPmPRmuEFuNcULGbHSQHzUwP
X-Received: by 2002:a05:620a:f0d:b0:930:f337:ebeb with SMTP id af79cd13be357-93780130181mr1512787285a.12.1787843497424;
        Thu, 27 Aug 2026 08:11:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd73e3dbesm18663846d6.30.2026.08.27.08.11.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:11:36 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: fix BPF token permission checks
Date: Thu, 27 Aug 2026 11:11:27 -0400
Message-ID: <20260827151126.107545-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3468; i=paul@paul-moore.com; h=from:subject; bh=6pdMZP6qFF2+B0N+2v2HuExIDmRVTe5O84Kznca+NYM=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqkFOenMB+VswgvorLi7sZfsyB5D6gXFJlfwKGb 9l5Asj0Sf2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCapBTngAKCRDqIPLalzeJ c5xlD/wLhiQ/RwWX0JBiGonszI6vhemsQcFtZMqkDFbnfLKafnhaysy6c7101IPVr7gvcLzhwlq i5Du+mjUoliADevFJW8+ClfGmSrtBTS+WfNQLg1kTL1Z6tdB/IS/YnJrnrQavhHbUMc/QF4oNdc DQIN4GziPwuegvmgkKbX9WXeoD3mwoSCBkqd+0EE1iqFBeXjqWQaYVkP6z67XvDcQmgDXwvr3JV w3fYX0P8DZABBusm5p9jFTLYf+4BasEEY+sQU/3B5v01OGD8jyZ5e/+R0RUDxw6BYlZdFKEFuTa kIMFJH84yGiJEAhLiXVjI6JbzbnwGYNx6QTqCeXKtOA2REKYMh6XIQZJYcw3Uy8eYoH2BaGkgi4 eoV7ySciBQ+0q62OInbUkkz+9HtC/G5rL54S5pHiKOe6tfaYTR0eJC2BREnnt30ZvW6EK3CcKWw 7qWTVTk2E2DZYnA1rGBR96mKWIdVXubMp5cgUWuVjG9hhbCQW8GNVohdhE7ZgLjvO/T0P6nyf9z BuHnkNWZYpDNbAmL9z+2etyZMUUD60l7S2cWG8xtYP/7TkTvbp6he81FKapXdf6JxDJjEUddkL5 IC0KM8yavytIsNnezCpf9e9u3ETqYtUs/amuYOffrPJMX2LWbtbn5Ty+dhWl2V583Pkb7GyiEsW 7k4ujWcmQNbguIw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Avoid multiple lookups of the bpffs creator SID using the token's file
descriptor when the same information can be found via the resolved
path/dentry (in selinux_bpf_token_create()) or the token itself (in
selinux_bpf_map_create() and selinux_bpf_prog_load()).  Not only does
this simplify the code, it avoids potential TOCTOU issues if the user
changes the token file descriptor passed into the kernel.

Cc: stable@vger.kernel.org
Fixes: 5473a722f782 ("selinux: add support for BPF token access control")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 035aaf113d1d..e5e17f100aae 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7267,24 +7267,6 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 			    BPF__PROG_RUN, NULL);
 }
 
-static u32 selinux_bpffs_creator_sid(u32 fd)
-{
-	struct path path;
-	struct super_block *sb;
-	struct superblock_security_struct *sbsec;
-
-	CLASS(fd, f)(fd);
-
-	if (fd_empty(f))
-		return SECSID_NULL;
-
-	path = fd_file(f)->f_path;
-	sb = path.dentry->d_sb;
-	sbsec = selinux_superblock(sb);
-
-	return sbsec->creator_sid;
-}
-
 static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
 				  struct bpf_token *token, bool kernel)
 {
@@ -7297,7 +7279,7 @@ static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
 	if (!token)
 		ssid = bpfsec->sid;
 	else
-		ssid = selinux_bpffs_creator_sid(attr->map_token_fd);
+		ssid = selinux_bpf_token_security(token)->grantor_sid;
 
 	return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__MAP_CREATE,
 			    NULL);
@@ -7315,7 +7297,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 	if (!token)
 		ssid = bpfsec->sid;
 	else
-		ssid = selinux_bpffs_creator_sid(attr->prog_token_fd);
+		ssid = selinux_bpf_token_security(token)->grantor_sid;
 
 	return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__PROG_LOAD,
 			    NULL);
@@ -7329,12 +7311,14 @@ static int selinux_bpf_token_create(struct bpf_token *token,
 				    const struct path *path)
 {
 	struct bpf_security_struct *bpfsec;
-	u32 sid = selinux_bpffs_creator_sid(attr->token_create.bpffs_fd);
+	struct superblock_security_struct *sbsec;
 	int err;
 
+	sbsec = selinux_superblock(path->dentry->d_sb);
+
 	bpfsec = selinux_bpf_token_security(token);
 	bpfsec->sid = current_sid();
-	bpfsec->grantor_sid = sid;
+	bpfsec->grantor_sid = sbsec->creator_sid;
 
 	bpfsec->perms = 0;
 	/**
@@ -7343,15 +7327,15 @@ static int selinux_bpf_token_create(struct bpf_token *token,
 	 * in the allowed_cmds bitmap.
 	 */
 	if (bpf_token_cmd(token, BPF_MAP_CREATE)) {
-		err = avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF,
-				   BPF__MAP_CREATE_AS, NULL);
+		err = avc_has_perm(bpfsec->sid, bpfsec->grantor_sid,
+				   SECCLASS_BPF, BPF__MAP_CREATE_AS, NULL);
 		if (err)
 			return err;
 		bpfsec->perms |= BPF__MAP_CREATE;
 	}
 	if (bpf_token_cmd(token, BPF_PROG_LOAD)) {
-		err = avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF,
-				   BPF__PROG_LOAD_AS, NULL);
+		err = avc_has_perm(bpfsec->sid, bpfsec->grantor_sid,
+				   SECCLASS_BPF, BPF__PROG_LOAD_AS, NULL);
 		if (err)
 			return err;
 		bpfsec->perms |= BPF__PROG_LOAD;
-- 
2.55.0

