Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C935BC282DA
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A236222AF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfDSSU6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:20:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727354AbfDSSUz (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 19 Apr 2019 14:20:55 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2A25BB1EB798E958E1E5;
        Fri, 19 Apr 2019 22:34:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.219) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Apr 2019
 22:34:31 +0800
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Paul Moore <paul@paul-moore.com>
References: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <20190415134331.GC22204@redhat.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com>
 <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com>
 <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com>
 <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
 <20190417162723.GK32622@redhat.com>
 <CAHC9VhT_nk1jmrTj3W=F+1gP1vU3iZsZ=UGOCwdiBLbUsOc9=w@mail.gmail.com>
 <0ca3f4cf-5c64-2fc0-1885-9dbcca2f4b47@schaufler-ca.com>
 <5CB7E5D4.2060703@huawei.com>
 <CAHC9VhQkrR+m9_dYLg4VG-26TdUnf8XFjbmuVQ70YCOp6DhN_g@mail.gmail.com>
 <5CB933C4.7000300@huawei.com>
 <CAHC9VhTdJ6uUOjyxrk=+iOkKe=VN+N9DMPtV=OchAY34x95g=w@mail.gmail.com>
CC:     Casey Schaufler <casey@schaufler-ca.com>,
        Oleg Nesterov <oleg@redhat.com>, <john.johansen@canonical.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>,
        "Jason Yan" <yanaijie@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>,
        Yangyingliang <yangyingliang@huawei.com>,
        Cheng Jian <cj.chengjian@huawei.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5CB9DC75.7010600@huawei.com>
Date:   Fri, 19 Apr 2019 22:34:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTdJ6uUOjyxrk=+iOkKe=VN+N9DMPtV=OchAY34x95g=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2019/4/19 21:24, Paul Moore wrote:
> On Thu, Apr 18, 2019 at 10:42 PM Yang Yingliang
> <yangyingliang@huawei.com> wrote:
>> On 2019/4/19 10:04, Paul Moore wrote:
>>> On Wed, Apr 17, 2019 at 10:50 PM Yang Yingliang
>>> <yangyingliang@huawei.com> wrote:
>>>> On 2019/4/18 8:24, Casey Schaufler wrote:
>>>>> On 4/17/2019 4:39 PM, Paul Moore wrote:
>>>>>> Since it looks like all three LSMs which implement the setprocattr
>>>>>> hook are vulnerable I'm open to the idea that proc_pid_attr_write() is
>>>>>> a better choice for the cred != read_cred check, but I would want to
>>>>>> make sure John and Casey are okay with that.
>>>>>>
>>>>>> John?
>>>>>>
>>>>>> Casey?
>>>>> I'm fine with the change going into proc_pid_attr_write().
>>>> The cred != real_cred checking is not enough.
>>>>
>>>> Consider this situation, when doing override, cred, real_cred and
>>>> new_cred are all same:
>>>>
>>>> after override_creds()    cred == real_cred == new1_cred
>>> I'm sorry, you've lost me.  After override_creds() returns
>>> current->cred and current->real_cred are not going to be the same,
>>> yes?
>> It's possible the new  cred is equal to current->real_cred and
>> current->cred,
>> so after overrides_creds(), they have the same value.
> Both task_struct.cred and task_struct.real_cred are pointer values,
> assuming that one uses prepare_creds() to allocate/initialize a new
> cred struct for use with override_creds() then the newly created cred
> should never be equal to task_struct.real_cred.  Am I missing
> something, or are you thinking of something else?
In do_acct_process(), file->f_cred may equal to current->real_cred, I 
confirm
it by adding some debug message in do_acct_process() like this:

--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -481,6 +481,7 @@ static void do_acct_process(struct bsd_acct_struct 
*acct)
         flim = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
         current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
         /* Perform file operations on behalf of whoever enabled 
accounting */
+       pr_info("task:%px new cred:%px real cred:%px cred:%px\n", 
current, file->f_cred, current->real_cred, current->cred);
         orig_cred = override_creds(file->f_cred);



Messages:
[   56.643298] task:ffff88841a9595c0 new cred:ffff88841ae450c0 real 
cred:ffff88841ae450c0 cred:ffff88841ae450c0    //They are same.
[   56.646609] Process accounting resumed
[   56.649943] task:ffff88841a9595c0 new cred:ffff88841ae450c0 real 
cred:ffff88841c96c300 cred:ffff88841ae450c0
[   56.653565] ------------[ cut here ]------------
[   56.655119] kernel BUG at kernel/cred.c:434!
[   56.656590] invalid opcode: 0000 [#1] SMP PTI
[   56.658033] CPU: 2 PID: 4169 Comm: syz-executor.15 Not tainted 
5.1.0-rc4-00034-g869e3305f23d-dirty #143
[   56.661077] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   56.664895] RIP: 0010:commit_creds+0x1eb/0x230
[   56.666344] Code: 43 1c 0f 85 08 ff ff ff e9 10 ff ff ff 8b 45 10 39 
43 10 0f 85 18 ff ff ff 8b 43 20 39 45 20 0f 85 0c ff ff ff e9 14 ff ff 
ff <0f> 0b 48 c7 c7 d0 d2 49 82 e8 17 3b 3e 00 0f 0b 48 c7 c7 c0 d2 49
[   56.672410] RSP: 0018:ffffc90003a17b20 EFLAGS: 00010287
[   56.674098] RAX: ffff88841a9595c0 RBX: ffff88841ae450c0 RCX: 
0000000000000000
[   56.676410] RDX: 0000000000000001 RSI: 0000000000000020 RDI: 
ffff88841c96ce40
[   56.678691] RBP: 0000000000000001 R08: 0000000000800000 R09: 
0000000000000000
[   56.680997] R10: ffff88841c9265a0 R11: ffffffff810d6940 R12: 
ffff88841a9595c0
[   56.681198] task:ffff88841a9195c0 new cred:ffff88841aeaa0c0 real 
cred:ffff88841aeaa0c0 cred:ffff88841aeaa0c0
[   56.683293] R13: 0000000000000040 R14: ffff88841c96ce40 R15: 
0000000000000040
[   56.683296] FS:  00007f5969a5c700(0000) GS:ffff88842fa80000(0000) 
knlGS:0000000000000000
[   56.683297] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.683299] CR2: 00007f82742214f0 CR3: 000000041cbc0005 CR4: 
00000000000206e0
[   56.683305] Call Trace:
[   56.683340]  selinux_setprocattr+0x17b/0x480
[   56.686513] Process accounting resumed
[   56.688849]  proc_pid_attr_write+0xc0/0xf0
[   56.688857]  __kernel_write+0x4f/0xf0
[   56.688866]  do_acct_process+0x538/0x750
[   56.703090]  ? __schedule+0x290/0x960
[   56.704311]  ? __queue_work+0x160/0x5c0
[   56.705571]  acct_pin_kill+0x1e/0x70
[   56.706743]  pin_kill+0x81/0x150
[   56.707813]  ? finish_wait+0x80/0x80
[   56.708985]  mnt_pin_kill+0x1e/0x30
[   56.710127]  cleanup_mnt+0x6e/0x70
[   56.711247]  task_work_run+0x8a/0xb0
[   56.712453]  do_exit+0x2e0/0xc80
[   56.713525]  do_group_exit+0x33/0xb0
[   56.714701]  get_signal+0x143/0x810
[   56.715865]  do_signal+0x36/0x610
[   56.716962]  ? __x64_sys_futex+0x134/0x180
[   56.718307]  ? _copy_to_user+0x22/0x30
[   56.719606]  exit_to_usermode_loop+0x80/0xe0
[   56.721003]  do_syscall_64+0x16c/0x180
[   56.722242]  entry_SYSCALL_64_after_hwframe+0x44/0xa9



