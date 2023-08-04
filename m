Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB3AC001DE
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 03:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjHDDsn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 23:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjHDDsa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 23:48:30 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5867B421E
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 20:48:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RHBWn3r7fz4f3kp3
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 11:48:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
        by APP2 (Coremail) with SMTP id Syh0CgBX_usIdcxk0RPPPQ--.45707S4;
        Fri, 04 Aug 2023 11:48:24 +0800 (CST)
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, xiujianfeng@huawei.com
Subject: [PATCH -next] selinux: update comment on selinux_hooks[]
Date:   Fri,  4 Aug 2023 03:46:52 +0000
Message-Id: <20230804034652.281266-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBX_usIdcxk0RPPPQ--.45707S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtryUGFyDJw18Zr13WryrXrb_yoWkWwcEkr
        1kCFWUXr45Aa1rAryxAF4F9F9agrWxZFyfW34rtrZrXr45Jrs5W3ykJr93Aw15XF4jkrsF
        kFn8Cayxuw1qqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
        WIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

After commit f22f9aaf6c3d ("selinux: remove the runtime disable
functionality"), the comment on selinux_hooks[] is out-of-date,
remove the last paragraph about runtime disable functionality.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/selinux/hooks.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2906fdaf7371..d0da19add17e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6961,10 +6961,6 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
  *    hooks ("allocating" hooks).
  *
  * Please follow block comment delimiters in the list to keep this order.
- *
- * This ordering is needed for SELinux runtime disable to work at least somewhat
- * safely. Breaking the ordering rules above might lead to NULL pointer derefs
- * when disabling SELinux at runtime.
  */
 static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
-- 
2.34.1

