Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA393C001DE
	for <selinux@archiver.kernel.org>; Tue,  1 Aug 2023 01:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjHABjJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jul 2023 21:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjHABjI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jul 2023 21:39:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DF419AE
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 18:39:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RFHnz2GgFz4f3prB
        for <selinux@vger.kernel.org>; Tue,  1 Aug 2023 09:39:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
        by APP3 (Coremail) with SMTP id _Ch0CgDH5CInYshkkPnZOA--.38043S4;
        Tue, 01 Aug 2023 09:39:03 +0800 (CST)
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org
Subject: [PATCH -next] selinux: cleanup obsolete comments for selinux_hooks[]
Date:   Tue,  1 Aug 2023 01:37:18 +0000
Message-Id: <20230801013718.270018-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDH5CInYshkkPnZOA--.38043S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4xur1rJr4rAr1DJw17Awb_yoW8Kw4Upa
        1aga1fJr45XFsrWr4DAa1IgFWag34ruFy7GrZ8K3WFyas7Ar18XFyvkr1FvFWDAry8XF1j
        ya12qrW7Gr4qy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0E
        Y4vE52x082I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWWlkUUUUU=
Sender: xiujianfeng@huaweicloud.com
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

After commit f22f9aaf6c3d ("selinux: remove the runtime disable
functionality"), the order in selinux_hooks[] does not affect
any selinux function, so remove the comments.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/selinux/hooks.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2906fdaf7371..ef813970cb9c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6951,21 +6951,6 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 }
 #endif /* CONFIG_IO_URING */
 
-/*
- * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
- * 1. any hooks that don't belong to (2.) or (3.) below,
- * 2. hooks that both access structures allocated by other hooks, and allocate
- *    structures that can be later accessed by other hooks (mostly "cloning"
- *    hooks),
- * 3. hooks that only allocate structures that can be later accessed by other
- *    hooks ("allocating" hooks).
- *
- * Please follow block comment delimiters in the list to keep this order.
- *
- * This ordering is needed for SELinux runtime disable to work at least somewhat
- * safely. Breaking the ordering rules above might lead to NULL pointer derefs
- * when disabling SELinux at runtime.
- */
 static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
@@ -7201,9 +7186,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(uring_cmd, selinux_uring_cmd),
 #endif
 
-	/*
-	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
-	 */
 	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
@@ -7211,9 +7193,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
 #endif
 
-	/*
-	 * PUT "ALLOCATING" HOOKS HERE
-	 */
 	LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
 	LSM_HOOK_INIT(msg_queue_alloc_security,
 		      selinux_msg_queue_alloc_security),
-- 
2.34.1

