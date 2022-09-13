Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AC1C6FA89
	for <selinux@archiver.kernel.org>; Tue, 13 Sep 2022 10:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiIMKru (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Sep 2022 06:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiIMKrq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Sep 2022 06:47:46 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783865F121
        for <selinux@vger.kernel.org>; Tue, 13 Sep 2022 03:47:44 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28DAlgA3041667;
        Tue, 13 Sep 2022 19:47:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Tue, 13 Sep 2022 19:47:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28DAlflt041664
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Sep 2022 19:47:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
Date:   Tue, 13 Sep 2022 19:47:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
 <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
 <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
 <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com>
 <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
 <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com>
 <e9ce6253-c8a3-19c3-1b71-f3a2e04539bc@I-love.SAKURA.ne.jp>
 <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/09/13 2:37, Casey Schaufler wrote:
> That doesn't give us a good answer for loadable modules. The last time I looked
> seriously at loadable modules I was considering that we'd need a security module
> that manages them, very much like BPF manages the eBPF programs. Loadable modules
> could use prctl, or some other mechanism, but they would have to be different
> from built-in modules. You can't require built-in modules to conform to the
> restrictions you'd have to impose on loadable ones.

What I'm requesting (in other words, the biggest barrier I want to solve) is

 security/security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/security.c b/security/security.c
index 4b95de24bc8d..ed34e25af22b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -73,6 +73,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 };
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+EXPORT_SYMBOL_GPL(security_hook_heads);
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
 
 static struct kmem_cache *lsm_file_cache;
-- 
2.18.4

and optionally (in other words, the second biggest barrier I want to solve is)

 security/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index ed34e25af22b..4cc09e6cb32a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -72,7 +72,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+struct security_hook_heads security_hook_heads;
 EXPORT_SYMBOL_GPL(security_hook_heads);
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
 
-- 
2.18.4

. A security module that manages loadable LSM modules cannot give us a good answer
if there is a kernel config option to disable the manager security module.

As long as the death sentence remains, being able to disallow loadable LSMs
is a very stupid decision. If a loadable kernel module were malicious, that
module can do what AKARI/CaitSith are doing today using more disguised code.
There should be a chance for ethical loadable LSM modules.

Kernels which seriously need security should be built with CONFIG_MODULES=n.
Kernels which want to use loadable modules (not limited to LSM) but still need to
remain secure should consider using e.g. CONFIG_MODULE_SIG=y.

I consider that real bugs which may crash/compromise the kernel are reported by
fuzz testing. Rather than disallowing loadable module LSMs, fixing real bugs
should be the way to proceed.

>                                                     The Loadable Module Security
> Module would have a static ID and somehow multiplex what lsm_self_attr() reports.

I don't think loadable module LSM have a static ID. TOMOYO/AKARI/CaitSith are already
working without "struct lsm_blob_sizes blob_sizes", without /proc/pid/attr/ interface,
without modification of userspace programs. TOMOYO/AKARI/CaitSith are designed to avoid
interface/resource conflicts you are trying to solve.

> I think it could be made to work. I can't say that it is something I am likely to
> get to soon.

The kernel config option and distribution's policy are preventing users from using
non-builtin LSMs in distributor's kernels. It is a trivial task to make TOMOYO work
in distributor's kernels if above-mentioned changes are accepted.

https://bugzilla.redhat.com/show_bug.cgi?id=542986

