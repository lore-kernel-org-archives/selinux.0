Return-Path: <SRS0=wfIc=QP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3443C169C4
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 16:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC212084D
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 16:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gVd7DXHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBHQXm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:23:42 -0500
Received: from sonic315-14.consmr.mail.gq1.yahoo.com ([98.137.65.38]:43206
        "EHLO sonic315-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727379AbfBHQXm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Feb 2019 11:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1549643020; bh=IC3IiwCaqlr7p1SEalNKlIG0zEiTWg9gQZ5/fBeSm1s=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gVd7DXHX92ehR+jvCEROLXb0JTH5AFkgiWDSzZyKYKjcvV6DRDwOZzcd1k+pOE7hW0rfnyRkrMrHWF+FdAPaN2D7F5TnMMVvqI0EmW5EDNMCVaIBN8Rs9B5rlSsgQZtcKkrM2SA00J5orFE0a/NIoDVal+JTOoTZnAHep/fypy5htZWMqAGN1LhHpYUXxlVkWQ7DRYV9dvDrQsBiEGMNsux7KNd86xqT50+LijU+6FR6Z8kxW4U2IQqv1/ZbPU9cDM+DP8aC9wb3dSgGx0u9wIsaPTF7LrneTx4tX/0ezJTrATAa4z4FgzOw9ELMZ0kXUoFIR928tfFL+Zt+plO5oQ==
X-YMail-OSG: DsBtFVwVM1kxy5RZnl.ZYHAGzz9Jl5RvBDNm5uDx2XiT9Gh26iuhF_tVwTfJl6b
 CPqHytCH1ost.I49OMApNL4CdWtCpKoAfNeIEQaQXk2e7NvpQrcXJ4eVc0HDOA4jryYUsYOHksWc
 uyxQPsxe57gtwizIQTf9aA8xwvZgxIbRDz4dU_wRygETT9Z7ribPTQNe1nqCxUGyZFDKwvJBVWZa
 LVxZf1Q1v1V2MjySevuxcBGc7po6O6cerhttqwTxb4K84yoAOVN13AWsm18cdmePRgBXxnOWVwkd
 8Gdhb8f4gqiSsTmMTBSOEhbbDWQREJUgeZFS75UfbS9ucrIWKXJu8oALdIS4Zklmyyck0LASv1oP
 KPlcwvi7I387xf9_mfRf2Wga_8qTMAocZwx8YUKB3fmfQ5GpZ7.a8bk9O_afLX56uxRkUu8jVLhG
 H1jQzpthdTwMJGlv6eVXBzVhmY.fYTiurI4g_.xnjXWphsm_ZtOz3.275OZE6D1oT_ILjaik0ynH
 JcpxH69ns5AWNgcfoZCG5tZRhpUsVKt4_17vMAQtttSvRd3i8YyQQju6unQQuDQMXYq.F0m0cS9k
 zi1HMVptGAmGexRjmptWjuKa.c6md4sUIt5t6sSWrDXYRO2gTMbqHq8GO.4ugi1P14psAMpcc48a
 ewvBczDGr3d1O0OjJrwLK9ahW6WRyLR_Z6MZIEF9ayyxHYA1NorLYFZed1NIq5O.AC_igV6zWKc_
 vlquB29wBY_HFW3Yy.tDw.zO71oY5S6V5pR2jxx7rQnhgKzV3XWKwGMeK_jKgBrsja.qYKz5mOv.
 DPneyDDOvE1U5Nqbd8n9CdWH81ge4.D3gIyqC2gPW9Ih_fYo7We_xpvWr0Jts5mjggamAp5yAEoG
 m740oIGJbJAPpUpcyBElCExyH101v_SspuhgLILkNHS_rwklmgcJ5U0zF78JAdWlCCSqonP2RNfX
 mGfHTymp08o9Hnp3ZJcuqRdLCSp6yd0V05vLmLbf2bn2F34jK6i17CrN_HKae3gEFhHYiCIMBmLb
 klT_auBBWy_ptK1LILHDjGr0QPCputZzHFQxbw4vnISEke28VRHe_HtMuQ9LkwhPU3OuvFlRe_4f
 KJ_pSEctfeYsAg1Vgq5HChcva
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Fri, 8 Feb 2019 16:23:40 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f45be69ab64a31d2d3163059690a45a1;
          Fri, 08 Feb 2019 16:23:36 +0000 (UTC)
Subject: Re: [PATCH] LSM: Allow syzbot to ignore security= parameter.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
 <54c0ae39-f35c-bdcd-a217-8e62ef14e41b@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <54f15845-f256-f503-98ce-64a1b88a5f9f@schaufler-ca.com>
Date:   Fri, 8 Feb 2019 08:23:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <54c0ae39-f35c-bdcd-a217-8e62ef14e41b@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/8/2019 2:52 AM, Tetsuo Handa wrote:
> On 2019/02/08 1:24, Casey Schaufler wrote:
>>>>> Then, I think that it is straightforward (and easier to manage) to ignore security= parameter
>>>>> when lsm= parameter is specified.
>>>> That reduces flexibility somewhat. If I am debugging security modules
>>>> I may want to use lsm= to specify the order while using security= to
>>>> identify a specific exclusive module. I could do that using lsm= by
>>>> itself, but habits die hard.
>>> "lsm=" can be used for identifying a specific exclusive module, and Ubuntu kernels would
>>> have to use CONFIG_LSM (or "lsm=") for identifying the default exclusive module (in order
>>> to allow enabling both TOMOYO and one of SELinux,Smack,AppArmor at the same time).
>>>
>>> Since "security=" can't be used for selectively enable/disable more than one of
>>> SELinux,Smack,TOMOYO,AppArmor, I think that recommending users to migrate to "lsm=" is the
>>> better direction. And ignoring "security=" when "lsm=" is specified is easier to understand.
>> I added Kees to the CC list. Kees, what to you think about
>> ignoring security= if lsm= is specified? I'm ambivalent.
>>
>>
> To help administrators easily understand what LSM modules are possibly enabled by default (which
> have to be fetched from e.g. /boot/config-`uname -r`)

$ cat /sys/kernel/security/lsm

>  and specify lsm= parameter when they need,
> I propose changes shown below.
>
> diff --git a/security/security.c b/security/security.c
> index 3147785e..051d708 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -51,8 +51,6 @@
>  static __initdata const char *chosen_lsm_order;
>  static __initdata const char *chosen_major_lsm;
>  
> -static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
> -
>  /* Ordered list of LSMs to initialize. */
>  static __initdata struct lsm_info **ordered_lsms;
>  static __initdata struct lsm_info *exclusive;
> @@ -284,14 +282,22 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  static void __init ordered_lsm_init(void)
>  {
>  	struct lsm_info **lsm;
> +	const char *order = CONFIG_LSM;
> +	const char *origin = "builtin";
>  
>  	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
>  				GFP_KERNEL);
>  
> -	if (chosen_lsm_order)
> -		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> -	else
> -		ordered_lsm_parse(builtin_lsm_order, "builtin");
> +	if (chosen_lsm_order) {
> +		if (chosen_major_lsm) {
> +			pr_info("security= is ignored because of lsm=\n");
> +			chosen_major_lsm = NULL;
> +		}
> +		order = chosen_lsm_order;
> +		origin = "cmdline";
> +	}
> +	pr_info("Security Framework initializing: %s\n", order);
> +	ordered_lsm_parse(order, origin);
>  
>  	for (lsm = ordered_lsms; *lsm; lsm++)
>  		prepare_lsm(*lsm);
> @@ -333,8 +339,6 @@ int __init security_init(void)
>  	int i;
>  	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
>  
> -	pr_info("Security Framework initializing\n");
> -
>  	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
>  	     i++)
>  		INIT_HLIST_HEAD(&list[i]);

I'm not going to object to this, but I don't see it as important.

