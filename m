Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27530C33CA9
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 16:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE262080D
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 16:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="RhUdFfCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgAMQRP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:17:15 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:9518 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgAMQRP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 11:17:15 -0500
X-EEMSG-check-017: 68806125|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="68806125"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jan 2020 16:17:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578932231; x=1610468231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gP5WbfMfhaaUa1KHv4N8zwwxWaToi9Qw7cJSJY+Oevk=;
  b=RhUdFfCYYRG0lnIB3mW46cfJ84oTW5tAUp770C+WM7NgWBHYQY1qKbgi
   URMTUn6BD20gvmH81v1EtkdA9qlV/OlAatj2IU6Nd710y7O7T5/jxdDsb
   bb1WARXXEosLyCOgS0Z84+ReL9dzGM3uVV10Gzjj2ZYToBySIrTtEKsFm
   cd+FFRG80DSeO4QHfqBptjNcWi6Hna/8vsHotCYawZzCXcrKRlCUZNgFG
   Ba3eJBru5Sh4mN5E0z5EEb2HhhxgxdN+5s+6JYWDRFDzRp+4YsMwWpvxr
   qSB12QydonD9sAqbB8iPg/4HS5koMQKjLo2mGH8+h3qXd11tCvoiM19ip
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="31875418"
IronPort-PHdr: =?us-ascii?q?9a23=3AFRsEnB2pdPlPjMrEsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesXLv3xwZ3uMQTl6Ol3ixeRBMOHsqkC0bWO+PC8EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm7rxndusYVjIZtN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhykdNz497WrZlMp+gqxGqx6lvhByw4rZbISTOfFjfK3SYMkaSH?=
 =?us-ascii?q?JBUMhPSiJPDICyYYwAAOQOJutUs4rwqkESoRakGQWgGOXiwSJIiH/s2q061v?=
 =?us-ascii?q?wsHxza3AM+B9IOsGrbrNPoP6kPVOC61q3IzTHdYPJWxDzw75PIfQ06ofyXQb?=
 =?us-ascii?q?JxcdbeyUkoFw/fiFWQspbqMyma1uQKrWiW9uxtXv+shW4/swx9vzeiy8g2ho?=
 =?us-ascii?q?TJm44Z0E7I+CpnzIovONG1TlNwb8S+H5tKrS6aMpN7QsYlQ251pik30qYGuZ?=
 =?us-ascii?q?unfCgSz5Qn2gLfZ+SHc4eW5hLjU/6cIStii3J/ebK/mg2y/VKhyu36WMm010?=
 =?us-ascii?q?1KoTRZndXWqnAM1wDc6siASvdn+EeuxS2P2BzJ5uFBIEA0kbLXK58nwrEuip?=
 =?us-ascii?q?oeqVnPEyD5lUnsjKKaa18o9van5uj5eLnqu4eQN4puhQH/NqQulNa/AeM9Mg?=
 =?us-ascii?q?UWRGiU5P+82ab//Uz5XLpKjvo2nrPfsJDBP8sXvKG5AwhL0oo78RawEy+m0M?=
 =?us-ascii?q?gEnXkANF9FYhOHgJTpO17UOvD3EO+wjEi0nzdr3f/GP7vhDYvWLnXYi7jhYb?=
 =?us-ascii?q?d960hAyAUt19Bf4YxbCq0bLP3vXU/xscTSDgUlPAys3+bnFNJ925scWWKKBa?=
 =?us-ascii?q?+ZKrnSsV6T5u80JemDfooVtyj8K/Q/4P7ul3A5k0cHfaa1xZsXdGy4HvN+Lk?=
 =?us-ascii?q?WdYHrshMoBEGgTsgolUuPllECCUSRSZ3auX6Mw/zQ7CIW7AofeQoCinqeM3D?=
 =?us-ascii?q?m0HpJIfGBKEFOMHmnyd4WCRfgMbDieIsh7kjwLTbKhUZMu1QmytA/mzLpqNv?=
 =?us-ascii?q?fb+i0ftZPtytd14+nTlQop+DxuEcuSzmGNQHtonm8SWzA226V/q1Rnylifya?=
 =?us-ascii?q?h4n+BYFdtL6vNOVwc6MoXcz+pgBN/uRA3MZc2JR0i7TdWmGz4xUsg9zMMJY0?=
 =?us-ascii?q?Z4A9+ilAzM3zK2A78JkLyGHIc0/bzY33jwIcZ91nnH2bI/j1kpXMRPL3eqhq?=
 =?us-ascii?q?1h+AjJAY7GjUGZm7ytdaQG0y7H7H2DwnaWvEFETA5wVr3IXWgFaUvLqdT0/V?=
 =?us-ascii?q?vCQKWzCbQjKwdBzMmCKqxQatL3l1lJWPDjONGNK162zn+5GBKg3rqRaM/vfG?=
 =?us-ascii?q?IH0WPWD01XvRoU+CO9KQUmBiqn61nbBThqGEOnN1jg6sFiuXi7SQky1AjMYE?=
 =?us-ascii?q?p/genmsiUJjOCRHqtAlokPvz0s/nApTVs=3D?=
X-IPAS-Result: =?us-ascii?q?A2AtAACulxxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWcHA?=
 =?us-ascii?q?QELAYF8gWwBIBIqjC9ghmwGiyWPTYF7CQEBAQEBAQEBARscAQGEQIIeNAkOA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIVDgjspgygLAUaBUYJnP4JXJasxM4kIgT2BNgGHP?=
 =?us-ascii?q?4RzeYEHgUeDG4UWhSEEl2uXUYJBgkiTWQwbmmsBLaseOYFYKwgCGAghD4MnU?=
 =?us-ascii?q?BgNiA0XjkEjAzCNHgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Jan 2020 16:17:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00DGGLFL046861;
        Mon, 13 Jan 2020 11:16:21 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com, dhowells@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        richard_c_haines@btinternet.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH] selinux: implement move_mount hook
Date:   Mon, 13 Jan 2020 11:18:00 -0500
Message-Id: <20200113161800.63865-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

commit 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
introduced a new move_mount(2) system call and a corresponding new LSM
security_move_mount hook but did not implement this hook for any existing
LSM.  This creates a regression for SELinux with respect to consistent
checking of mounts; the existing selinux_mount hook checks mounton
permission to the mount point path.  Provide a SELinux hook
implementation for move_mount that applies this same check for
consistency.  We may wish to consider defining a new filesystem
move_mount permission and/or a new dir(ectory) move_mount permission
and checking it in this hook in the future.

Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0606e107fca3..244874b103ff 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2766,6 +2766,19 @@ static int selinux_mount(const char *dev_name,
 		return path_has_perm(cred, path, FILE__MOUNTON);
 }
 
+static int selinux_move_mount(const struct path *from_path,
+			      const struct path *to_path)
+{
+	const struct cred *cred = current_cred();
+
+	/*
+	 *  TBD: Check new FILESYSTEM__MOVE_MOUNT permission to
+	 *  from_path->dentry->s_sb and/or new DIR__MOVE_MOUNT
+	 *  permission to from_path?
+	 */
+	return path_has_perm(cred, to_path, FILE__MOUNTON);
+}
+
 static int selinux_umount(struct vfsmount *mnt, int flags)
 {
 	const struct cred *cred = current_cred();
@@ -6943,6 +6956,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
 	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
 
+	LSM_HOOK_INIT(move_mount, selinux_move_mount),
+
 	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
 	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
 
-- 
2.24.1

