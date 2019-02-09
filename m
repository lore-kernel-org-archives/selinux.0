Return-Path: <SRS0=ywSy=QQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC479C169C4
	for <selinux@archiver.kernel.org>; Sat,  9 Feb 2019 00:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B0920821
	for <selinux@archiver.kernel.org>; Sat,  9 Feb 2019 00:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBIA2W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:28:22 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:27096 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfBIA2V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Feb 2019 19:28:21 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x190SIOO019237;
        Sat, 9 Feb 2019 09:28:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sat, 09 Feb 2019 09:28:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x190SEkZ019199
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 9 Feb 2019 09:28:18 +0900 (JST)
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
 <54c0ae39-f35c-bdcd-a217-8e62ef14e41b@i-love.sakura.ne.jp>
 <54f15845-f256-f503-98ce-64a1b88a5f9f@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3a775445-c161-f104-ebf6-5fa1c9e9dac8@i-love.sakura.ne.jp>
Date:   Sat, 9 Feb 2019 09:28:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <54f15845-f256-f503-98ce-64a1b88a5f9f@schaufler-ca.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2019/02/09 1:23, Casey Schaufler wrote:
> On 2/8/2019 2:52 AM, Tetsuo Handa wrote:
>> To help administrators easily understand what LSM modules are possibly enabled by default (which
>> have to be fetched from e.g. /boot/config-`uname -r`)
> 
> $ cat /sys/kernel/security/lsm
> 

/sys/kernel/security/lsm is list of "actually" enabled modules, isn't it?
What I want is "possibly" enabled modules. Ubuntu would chose from either

  (a) explicitly add security=apparmor to kernel command line

or

  (b) explicitly remove tomoyo from CONFIG_LSM at kernel config

in order not to enable TOMOYO for those who want to enable only one of 
SELinux/Smack/AppArmor. And for those who want to enable TOMOYO, I think
that (b) (in other words, add

  lsm="modules listed in CONFIG_LSM" + ",tomoyo"

) will retain compatibility when it becomes possible to enable more than
one of SELinux/Smack/AppArmor at the same time.

If we can know "possibly" enabled modules from dmesg, users don't need to
look at e.g. /boot/config-`uname -r`. It is not essential, but it's handy.

