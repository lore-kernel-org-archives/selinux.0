Return-Path: <SRS0=wfIc=QP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E46C282CB
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 10:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1080A21919
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 10:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBHKwf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:52:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:35509 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHKwf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Feb 2019 05:52:35 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x18AqXt6062343;
        Fri, 8 Feb 2019 19:52:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Fri, 08 Feb 2019 19:52:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x18AqWMY062306
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 8 Feb 2019 19:52:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] LSM: Allow syzbot to ignore security= parameter.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@vger.kernel.org>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <8f48e1d0-c109-f8a9-ea94-9659b16cae49@i-love.sakura.ne.jp>
 <0d23d1a5-d4af-debf-6b5f-aaaf698daaa8@schaufler-ca.com>
 <201902070230.x172UUG6002087@www262.sakura.ne.jp>
 <6def6199-0235-7c37-974c-baf731725606@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <54c0ae39-f35c-bdcd-a217-8e62ef14e41b@i-love.sakura.ne.jp>
Date:   Fri, 8 Feb 2019 19:52:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <6def6199-0235-7c37-974c-baf731725606@schaufler-ca.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2019/02/08 1:24, Casey Schaufler wrote:
>>>> Then, I think that it is straightforward (and easier to manage) to ignore security= parameter
>>>> when lsm= parameter is specified.
>>> That reduces flexibility somewhat. If I am debugging security modules
>>> I may want to use lsm= to specify the order while using security= to
>>> identify a specific exclusive module. I could do that using lsm= by
>>> itself, but habits die hard.
>> "lsm=" can be used for identifying a specific exclusive module, and Ubuntu kernels would
>> have to use CONFIG_LSM (or "lsm=") for identifying the default exclusive module (in order
>> to allow enabling both TOMOYO and one of SELinux,Smack,AppArmor at the same time).
>>
>> Since "security=" can't be used for selectively enable/disable more than one of
>> SELinux,Smack,TOMOYO,AppArmor, I think that recommending users to migrate to "lsm=" is the
>> better direction. And ignoring "security=" when "lsm=" is specified is easier to understand.
> 
> I added Kees to the CC list. Kees, what to you think about
> ignoring security= if lsm= is specified? I'm ambivalent.
> 
> 

To help administrators easily understand what LSM modules are possibly enabled by default (which
have to be fetched from e.g. /boot/config-`uname -r`) and specify lsm= parameter when they need,
I propose changes shown below.

diff --git a/security/security.c b/security/security.c
index 3147785e..051d708 100644
--- a/security/security.c
+++ b/security/security.c
@@ -51,8 +51,6 @@
 static __initdata const char *chosen_lsm_order;
 static __initdata const char *chosen_major_lsm;
 
-static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
-
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
 static __initdata struct lsm_info *exclusive;
@@ -284,14 +282,22 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
+	const char *order = CONFIG_LSM;
+	const char *origin = "builtin";
 
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
 
-	if (chosen_lsm_order)
-		ordered_lsm_parse(chosen_lsm_order, "cmdline");
-	else
-		ordered_lsm_parse(builtin_lsm_order, "builtin");
+	if (chosen_lsm_order) {
+		if (chosen_major_lsm) {
+			pr_info("security= is ignored because of lsm=\n");
+			chosen_major_lsm = NULL;
+		}
+		order = chosen_lsm_order;
+		origin = "cmdline";
+	}
+	pr_info("Security Framework initializing: %s\n", order);
+	ordered_lsm_parse(order, origin);
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		prepare_lsm(*lsm);
@@ -333,8 +339,6 @@ int __init security_init(void)
 	int i;
 	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
 
-	pr_info("Security Framework initializing\n");
-
 	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
