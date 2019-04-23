Return-Path: <SRS0=RjX6=SZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE31C10F14
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 04:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864F420843
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 04:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfDWEIx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Apr 2019 00:08:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48350 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfDWEIw (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 23 Apr 2019 00:08:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 25D7DCDD43B433BC305A;
        Tue, 23 Apr 2019 12:08:46 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.219) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Apr 2019
 12:08:38 +0800
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Paul Moore <paul@paul-moore.com>
References: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
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
 <5CB9DC75.7010600@huawei.com>
 <CAHC9VhQqxL+LsK8YTD6PpTHaZsZ-PxAq3atdZKQcZLQZQH7t4g@mail.gmail.com>
 <5CBACC8F.8010409@huawei.com>
 <CAHC9VhSZBh8B+1CPM=PdLdbSFq1ba1ffuOJTgnzE5oBLXUEDxQ@mail.gmail.com>
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
        SELinux <selinux@vger.kernel.org>, <yangyingliang@huawei.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5CBE8FC4.8060400@huawei.com>
Date:   Tue, 23 Apr 2019 12:08:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSZBh8B+1CPM=PdLdbSFq1ba1ffuOJTgnzE5oBLXUEDxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2019/4/23 3:48, Paul Moore wrote:
> On Sat, Apr 20, 2019 at 3:39 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>> I'm not sure you got my point.
> I went back and looked at your previous emails again to try and
> understand what you are talking about, and I'm a little confused by
> some of the output ...
>
>> --- a/kernel/acct.c
>> +++ b/kernel/acct.c
>> @@ -481,6 +481,7 @@ static void do_acct_process(struct bsd_acct_struct
>> *acct)
>>           flim = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
>>           current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
>>           /* Perform file operations on behalf of whoever enabled
>> accounting */
>> +       pr_info("task:%px new cred:%px real cred:%px cred:%px\n",
>> current, file->f_cred, current->real_cred, current->cred);
>>           orig_cred = override_creds(file->f_cred);
> Okay, with this patch applied we should the task/cred info when
> do_acct_process is called.  Got it.
>
>> Messages:
>> [   56.643298] task:ffff88841a9595c0 new cred:ffff88841ae450c0 real
>> cred:ffff88841ae450c0 cred:ffff88841ae450c0    //They are same.
> Okay, it looks like do_acct_process() was called and f_cred,
> real_cred, and cred are all the same.
This is a original message, without patch applied.
>
>> [   56.646609] Process accounting resumed
> It looks like do_acct_process() has called check_free_space() now.  So
> far so good.
>
>> [   56.649943] task:ffff88841a9595c0 new cred:ffff88841ae450c0 real
>> cred:ffff88841c96c300 cred:ffff88841ae450c0
> Wait a minute ... why are we seeing this again?  Looking at the task
> pointer and the timestamp, this is the same task exiting and trying to
> write to the accounting file, yes?  This output is particularly
> curious since it appears that real_cred has changed; where is this
> happening?
This is the message when the BUG_ON was triggered without applying any
fix patch.


If we apply this patch "proc: prevent changes to overridden 
credentials", program
runs like this:

1. As print message shows, before overriden, the pointer has the 
following value:
     real_cread=cred=0xffff88841ae450c0, f_cred=0xffff88841ae450c0
     override_creds() is called in do_acct_process():
     ...
     /* Perform file operations on behalf of whoever enabled accounting */
     orig_cred = override_creds(file->f_cred);
     ...


2. After override_creds(), if (current_cred() != current_real_cred()) is 
not work here,
we will call commit_creds()  in security_setprocattr().
     ...
     /* Prevent changes to overridden credentials. */
         if (current_cred() != current_real_cred()) {
             rcu_read_unlock();
         return -EBUSY;
     }
     ...


3. After commit_creds(), we have new cred and real_cred.
     security_setprocattr()    //commit_creds is called here

4. revert_creds() is called in in do_acct_process(), the cred
is reverted to the old value(0xffff88841ae450c0)
     ...
     current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
     revert_creds(orig_cred);

5. After reverting, cred and real_cred are not equal.
If it has a risk to trigger the BUG_ON, when doing another
commit_creds() ?



