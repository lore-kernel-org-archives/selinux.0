Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EC1C282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 16:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171872175B
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 16:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Bx/IIEUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfBGQYe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:24:34 -0500
Received: from sonic302-27.consmr.mail.gq1.yahoo.com ([98.137.68.153]:42589
        "EHLO sonic302-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbfBGQYe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Feb 2019 11:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1549556673; bh=HbuGRpu6I7YIxZ4SNLsPqCYI80Aa+PLh8ijdAqJqYkI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Bx/IIEUmq4Kjd+ahXb4HSW26GP5xt4g5oZO6o8z18ZYM7E9e30otly9LRgnIentv51/mCn58vBTNxzx/KFzg2CM/Z6X0NPd/hfIUM8rkPYSfbxocvSlRkmm+ZO4X6e35hcKQFVJ+Cnl5LXkhBqVYIFfcp0aP7tzpN/OK6NCJseHCdyg4trKcJMDqXgR+8tdYPFYlYZ3/6cGeldGvOq+nqTVkdWWG83xi2PYAzB+UPFpemJpgVtFDxNpnPwzh8OM0+JhDDQp9euZmiYmvYFebJHm/N/nPcKZwziqWq18R16WVZqOubnPtW3gDrogB5uWw9dZAYlWCq3v4wqqlJzXGvw==
X-YMail-OSG: 5VfEtBgVM1loia6glQDjSvBugNjD1g5XLr40dSjiuZ_Tr_xRYpanKPik.PeznWj
 GCi9BjKXWbNG.4Q35ADVD546ZRrnjulHg52JR7BXrIZOEMFgpkipODe_25FYqmHKMrf82KzmWtlt
 kag8c0TBuTEWWNj23cxWjC.aCdW1RQAEREzvpGGbUfxjK8QzkCiM45ehNkB.vAY.FCmX0z_1SD8.
 Do9aa6BCvFWTLb4AL7rQGRLdcgVf3H1wl4vbZ2WeME9DukrGgXVqSxD2h.zDnQDB67s17J74JC0u
 GBNT8scUurZyy7R7f4E6c5AmOcs5RQSyRMRjpUWyyOq6GsGAR6P_DIVAwFP5HorlwbbK_8UMcbHd
 _gvUdTg08n58uo_F7EAtFiidwjQykRdSlJvktk73ecssfL2NyFd55wpluSKS9QfheSZWc8kqMqqb
 WheNyE5FCeBPBhM8DxTkxpgSfBGACSp4WYbDSf3Cx_AHgzU9JnQEfm5_eAHAn439BKO5_3Zyq0yp
 HYqEqqW7e2VN5txrw9sMBm8QAhPgCHuTNBjzujTMx1r9A9b59wMZX05B2DaqSi69L1co_AmTrSQ5
 bPd3sBKEVXEO9NNpEmhnpC7rkHnhgvCaXwSdE8ERwv6Zml8In0RZ6ev42R3XNNe7gcSbYO2E__Na
 sXZQdDSS57DhfgqfguKBgvxavYJlTKstilKKqCfRAOhz4lmbfssfrUEbHtAk_ANMBz20rLylLF4d
 TTAVUi2gDck8INgQ7dty5PA1EDJx14ldDmpM61oECQLyOJRHWxtwcmNjdFvyOkMIAYoyrRVUkUDN
 eYLWcRfYG2uvPueFWArEUWJSCbdJYp__NIszOUhbmkbh_hPN25sSlCwu8Pwpf1adWE23QEBXT08q
 cx8eXiR7crQ1F07WBqEbC4L503yetlC2dBMK6aA2vDNIKTsl0ToHfuQenBLt9hT4sfRtB9Vhysma
 4E7GysdhExnND8ahJVaxHDn5ol1.22q9SuTPch8gHHXV2I.wFvURi0q5o1gz8A5aBthbe_gGqzHY
 4anFjhZyAKItLKZpJSuExDCLwwKzxDQwLPfnMYSzyDi1rm64psBWeazHFqrH__lm9_bmKgLhKtpR
 Q4FdXNSuX54_3EeajgYWr8H_h8_9mp0XavdgHveLhXJe_9XGoOw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 7 Feb 2019 16:24:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 44df19590cf964fcb3866ff781d6ea2e;
          Thu, 07 Feb 2019 16:24:28 +0000 (UTC)
Subject: Re: [PATCH] LSM: Allow syzbot to ignore security= parameter.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
References: <8f48e1d0-c109-f8a9-ea94-9659b16cae49@i-love.sakura.ne.jp>
 <0d23d1a5-d4af-debf-6b5f-aaaf698daaa8@schaufler-ca.com>
 <201902070230.x172UUG6002087@www262.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6def6199-0235-7c37-974c-baf731725606@schaufler-ca.com>
Date:   Thu, 7 Feb 2019 08:24:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <201902070230.x172UUG6002087@www262.sakura.ne.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/2019 6:30 PM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> On 2/6/2019 2:23 AM, Tetsuo Handa wrote:
>>> But as I update the documentation ( https://tomoyo.osdn.jp/2.6/chapter-3.html.en#3.6 ),
>>> I came to think that we should ignore security= parameter when lsm= parameter is specified.
>>>
>>> Currently, it is possible to enable TOMOYO and only one of SELinux/Smack/AppArmor. Therefore,
>>> it is possible to disable only TOMOYO by specifying security=selinux when we want to enable
>>> only SELinux, by specifying security=smack when we want to enable only Smack, by specifying
>>> security=apparmor when we want to enable only AppArmor. That is, we can use security= parameter
>>> in order to specify the other LSM module which should not be disabled.
>>>
>>> But when it becomes possible to enable TOMOYO and more than one of SELinux/Smack/AppArmor,
>>> we will no longer be able to selectively disable one LSM module using security= parameter, for
>>> security= parameter is intended for specifying only one LSM module which should be enabled.
>>> That is, we will need to use lsm= parameter in order to selectively disable LSM modules.
>> Yes. That is correct. The existing behavior of security= is maintained.
> But the existing behavior of CONFIG_DEFAULT_SECURITY is not maintained.

That's a developer interface, not a user interface. I realize
that may be splitting hairs, but it had to change.

> This might cause a problem like
>
>   commit e5a3b95f581da62e2054ef79d3be2d383e9ed664
>   Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>   Date:   Sat Feb 14 11:46:56 2009 +0900
>
>       TOMOYO: Don't create securityfs entries unless registered.
>
>       TOMOYO should not create /sys/kernel/security/tomoyo/ interface unless
>       TOMOYO is registered.
>
> for Ubuntu users because Ubuntu kernels are built with
>
>   CONFIG_SECURITY_SELINUX=y
>   CONFIG_SECURITY_SMACK=y
>   CONFIG_SECURITY_TOMOYO=y
>   CONFIG_SECURITY_APPARMOR=y
>   CONFIG_SECURITY_YAMA=y
>   CONFIG_DEFAULT_SECURITY="apparmor"
>
> . Due to CONFIG_DEFAULT_SECURITY="apparmor", majority of Ubuntu users are enabling
> only AppArmor without explicitly specifying "security=apparmor".
>
> Currently default CONFIG_LSM setting is
>
>   "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>
> but Ubuntu kernels would have to be built with non-default CONFIG_LSM setting like
>
>   "yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo"
>
> in order to make sure that AppArmor is by default chosen for the LSM_FLAG_EXCLUSIVE module.

Yes, and Yocto Project is likely to want Smack specified first.

> Now that TOMOYO becomes a !LSM_FLAG_EXCLUSIVE module, not specifying "security=apparmor" will
> automatically enable TOMOYO. And majority of Ubuntu users will unexpectedly encounter TOMOYO
> messages. But removing "tomoyo" from CONFIG_LSM setting in order to save majority of Ubuntu
> users from unexpectedly encountering TOMOYO messages also has a problem; Ubuntu users who want
> to enable only TOMOYO from LSM_FLAG_LEGACY_MAJOR modules can specify "security=tomoyo", but
> Ubuntu users who want to enable TOMOYO and one of SELinux,Smack,AppArmor (including syzbot)
> will have to explicitly specify "lsm=" because "security=" can't allow enabling multiple
> LSM_FLAG_LEGACY_MAJOR modules.

I believe we got general buy in from Ubuntu, and I understand
that the LSM list is awkward, but I don't see a rational alternate.
I know that I played with a half dozen, and nothing was closer to
maintaining the status quo.

>> The new behavior of lsm= is provided to allow general handling of a list
>> of security modules. It uses the same form of data as CONFIG_LSM.
>>
>>> Then, I think that it is straightforward (and easier to manage) to ignore security= parameter
>>> when lsm= parameter is specified.
>> That reduces flexibility somewhat. If I am debugging security modules
>> I may want to use lsm= to specify the order while using security= to
>> identify a specific exclusive module. I could do that using lsm= by
>> itself, but habits die hard.
> "lsm=" can be used for identifying a specific exclusive module, and Ubuntu kernels would
> have to use CONFIG_LSM (or "lsm=") for identifying the default exclusive module (in order
> to allow enabling both TOMOYO and one of SELinux,Smack,AppArmor at the same time).
>
> Since "security=" can't be used for selectively enable/disable more than one of
> SELinux,Smack,TOMOYO,AppArmor, I think that recommending users to migrate to "lsm=" is the
> better direction. And ignoring "security=" when "lsm=" is specified is easier to understand.

I added Kees to the CC list. Kees, what to you think about
ignoring security= if lsm= is specified? I'm ambivalent.

