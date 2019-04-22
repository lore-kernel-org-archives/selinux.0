Return-Path: <SRS0=kuKh=SY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FCDC10F11
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 19:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128DE204EC
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 19:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NWZMaT2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfDVTtO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:49:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42162 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730748AbfDVTtN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Apr 2019 15:49:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id w23so9827435lfc.9
        for <selinux@vger.kernel.org>; Mon, 22 Apr 2019 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=puiu4I9lOL69QlYiimmTVYqiP4I+hDN4HbYt+NJIAD4=;
        b=NWZMaT2D9XPL5dMl6iAwPLIKN10E098gTACx1cBHLku+LqO8JCHkoE2ZHVTJ7j9Ish
         4sVc5c16N+ZyFV9gxAMPy3lbOlD5uhcTKkSvSNFnTS5gXlgK8U+dJ6D7l2YDpUrnYyMS
         yX+bIGMOqOPig+lGK0S7QnSFfIVYYVP2OvHzm2iVKtYF1ncdVTuswfO7L6aybk0r03N7
         eyWoBvR0GEvWcutK57BkGZ3q3zAXNAlolbfWfjo7pRYcptwEPE5j1t3Bb/7pMwWArSKz
         GC2yxaK6EJ14jRipgckrmBirmaYRHs2mlyGliDI4MK0uYDplhh+PugWiUw9TKPYm/f8P
         vG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puiu4I9lOL69QlYiimmTVYqiP4I+hDN4HbYt+NJIAD4=;
        b=U8sCN1Ra3WGZzXTrM/H3IaI0N5+Ni/uZBZlGmz6nFV8/7nkx0KHQGr2u+fcsZY12/E
         Z7trwvEfiD9VSdL6chdL3i5Ac/O8G9JwO9x5btAg+ZHeoGGmQyQKGsa4ZEHbHOd76NWG
         fH0Snx9UTaiCIyNi8BNM49lVLTw0KFp7iDc72311jeoK4aUIZ3HTNn7jM2w/ouXmUt9l
         4DAyHFwCHwkEvZU3YaepW8OrAEtYRwCvH77vjAAt01eon4xOgmxaow70ZLUnqSfCJ07O
         yMXIvrdHifdDCWSeXzS4rzmKAgkUjLKPVgSsNFFwAoBK97F33nuBBS4Xdp3QO5lqETBK
         YKew==
X-Gm-Message-State: APjAAAUilEKvC9OUgcENcmlsv33HbA98V52Z1VhEpZ2UY/fS4F5P7tzi
        Kas09Om7yb2RCfxExynqqG7Fn6BCwa2slzBNSOAi
X-Google-Smtp-Source: APXvYqzEUAwcfTJWLiQVgU/OFF4k51MYnvP+IVWebjavxYi8vsYvTIdr2/CUUYLYb7TWVlWWsPpn2e+uuj0XxKOLIqs=
X-Received: by 2002:a19:6b0d:: with SMTP id d13mr11154050lfa.79.1555962550518;
 Mon, 22 Apr 2019 12:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com> <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com> <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com> <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
 <20190417162723.GK32622@redhat.com> <CAHC9VhT_nk1jmrTj3W=F+1gP1vU3iZsZ=UGOCwdiBLbUsOc9=w@mail.gmail.com>
 <0ca3f4cf-5c64-2fc0-1885-9dbcca2f4b47@schaufler-ca.com> <5CB7E5D4.2060703@huawei.com>
 <CAHC9VhQkrR+m9_dYLg4VG-26TdUnf8XFjbmuVQ70YCOp6DhN_g@mail.gmail.com>
 <5CB933C4.7000300@huawei.com> <CAHC9VhTdJ6uUOjyxrk=+iOkKe=VN+N9DMPtV=OchAY34x95g=w@mail.gmail.com>
 <5CB9DC75.7010600@huawei.com> <CAHC9VhQqxL+LsK8YTD6PpTHaZsZ-PxAq3atdZKQcZLQZQH7t4g@mail.gmail.com>
 <5CBACC8F.8010409@huawei.com>
In-Reply-To: <5CBACC8F.8010409@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Apr 2019 15:48:58 -0400
Message-ID: <CAHC9VhSZBh8B+1CPM=PdLdbSFq1ba1ffuOJTgnzE5oBLXUEDxQ@mail.gmail.com>
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Oleg Nesterov <oleg@redhat.com>, john.johansen@canonical.com,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Apr 20, 2019 at 3:39 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> I'm not sure you got my point.

I went back and looked at your previous emails again to try and
understand what you are talking about, and I'm a little confused by
some of the output ...

> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -481,6 +481,7 @@ static void do_acct_process(struct bsd_acct_struct
> *acct)
>          flim = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
>          current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
>          /* Perform file operations on behalf of whoever enabled
> accounting */
> +       pr_info("task:%px new cred:%px real cred:%px cred:%px\n",
> current, file->f_cred, current->real_cred, current->cred);
>          orig_cred = override_creds(file->f_cred);

Okay, with this patch applied we should the task/cred info when
do_acct_process is called.  Got it.

> Messages:
> [   56.643298] task:ffff88841a9595c0 new cred:ffff88841ae450c0 real
> cred:ffff88841ae450c0 cred:ffff88841ae450c0    //They are same.

Okay, it looks like do_acct_process() was called and f_cred,
real_cred, and cred are all the same.

> [   56.646609] Process accounting resumed

It looks like do_acct_process() has called check_free_space() now.  So
far so good.

> [   56.649943] task:ffff88841a9595c0 new cred:ffff88841ae450c0 real
> cred:ffff88841c96c300 cred:ffff88841ae450c0

Wait a minute ... why are we seeing this again?  Looking at the task
pointer and the timestamp, this is the same task exiting and trying to
write to the accounting file, yes?  This output is particularly
curious since it appears that real_cred has changed; where is this
happening?

> [   56.653565] ------------[ cut here ]------------
> [   56.655119] kernel BUG at kernel/cred.c:434!
> [   56.656590] invalid opcode: 0000 [#1] SMP PTI
> [   56.658033] CPU: 2 PID: 4169 Comm: syz-executor.15 Not tainted
> 5.1.0-rc4-00034-g869e3305f23d-dirty #143
> [   56.661077] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [   56.664895] RIP: 0010:commit_creds+0x1eb/0x230
> [   56.666344] Code: 43 1c 0f 85 08 ff ff ff e9 10 ff ff ff 8b 45 10 39
> 43 10 0f 85 18 ff ff ff 8b 43 20 39 45 20 0f 85 0c ff ff ff e9 14 ff ff
> ff <0f> 0b 48 c7 c7 d0 d2 49 82 e8 17 3b 3e 00 0f 0b 48 c7 c7 c0 d2 49
> [   56.672410] RSP: 0018:ffffc90003a17b20 EFLAGS: 00010287
> [   56.674098] RAX: ffff88841a9595c0 RBX: ffff88841ae450c0 RCX:
> 0000000000000000
> [   56.676410] RDX: 0000000000000001 RSI: 0000000000000020 RDI:
> ffff88841c96ce40
> [   56.678691] RBP: 0000000000000001 R08: 0000000000800000 R09:
> 0000000000000000
> [   56.680997] R10: ffff88841c9265a0 R11: ffffffff810d6940 R12:
> ffff88841a9595c0
> [   56.681198] task:ffff88841a9195c0 new cred:ffff88841aeaa0c0 real
> cred:ffff88841aeaa0c0 cred:ffff88841aeaa0c0
> [   56.683293] R13: 0000000000000040 R14: ffff88841c96ce40 R15:
> 0000000000000040
> [   56.683296] FS:  00007f5969a5c700(0000) GS:ffff88842fa80000(0000)
> knlGS:0000000000000000
> [   56.683297] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   56.683299] CR2: 00007f82742214f0 CR3: 000000041cbc0005 CR4:
> 00000000000206e0
> [   56.683305] Call Trace:
> [   56.683340]  selinux_setprocattr+0x17b/0x480
> [   56.686513] Process accounting resumed
> [   56.688849]  proc_pid_attr_write+0xc0/0xf0
> [   56.688857]  __kernel_write+0x4f/0xf0
> [   56.688866]  do_acct_process+0x538/0x750
> [   56.703090]  ? __schedule+0x290/0x960
> [   56.704311]  ? __queue_work+0x160/0x5c0
> [   56.705571]  acct_pin_kill+0x1e/0x70
> [   56.706743]  pin_kill+0x81/0x150
> [   56.707813]  ? finish_wait+0x80/0x80
> [   56.708985]  mnt_pin_kill+0x1e/0x30
> [   56.710127]  cleanup_mnt+0x6e/0x70
> [   56.711247]  task_work_run+0x8a/0xb0
> [   56.712453]  do_exit+0x2e0/0xc80
> [   56.713525]  do_group_exit+0x33/0xb0
> [   56.714701]  get_signal+0x143/0x810
> [   56.715865]  do_signal+0x36/0x610
> [   56.716962]  ? __x64_sys_futex+0x134/0x180
> [   56.718307]  ? _copy_to_user+0x22/0x30
> [   56.719606]  exit_to_usermode_loop+0x80/0xe0
> [   56.721003]  do_syscall_64+0x16c/0x180
> [   56.722242]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

-- 
paul moore
www.paul-moore.com
