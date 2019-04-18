Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=FUZZY_CREDIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4904C282DA
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 02:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAE42183E
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 02:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfDRCuH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:50:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732737AbfDRCuG (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 17 Apr 2019 22:50:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9A6E67DD53DE6614E2DF;
        Thu, 18 Apr 2019 10:50:04 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.219) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 18 Apr 2019
 10:49:57 +0800
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Oleg Nesterov <oleg@redhat.com>, <john.johansen@canonical.com>
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
CC:     "chengjian (D)" <cj.chengjian@huawei.com>,
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
        Cheng Jian <cj.chengjian@huawei.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5CB7E5D4.2060703@huawei.com>
Date:   Thu, 18 Apr 2019 10:49:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <0ca3f4cf-5c64-2fc0-1885-9dbcca2f4b47@schaufler-ca.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi, Casey

On 2019/4/18 8:24, Casey Schaufler wrote:
> On 4/17/2019 4:39 PM, Paul Moore wrote:
>> On Wed, Apr 17, 2019 at 12:27 PM Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 04/17, Paul Moore wrote:
>>>> On Wed, Apr 17, 2019 at 10:57 AM Oleg Nesterov <oleg@redhat.com> 
>>>> wrote:
>>>>> On 04/17, Paul Moore wrote:
>>>>>> I'm tempted to simply return an error in selinux_setprocattr() if
>>>>>> the task's credentials are not the same as its real_cred;
>>>>> What about other modules? I have no idea what smack_setprocattr() is,
>>>>> but it too does prepare_creds/commit creds.
>>>>>
>>>>> it seems that the simplest workaround should simply add the 
>>>>> additional
>>>>> cred == real_cred into proc_pid_attr_write().
>>>> Yes, that is simple, but I worry about what other LSMs might want to
>>>> do.  While I believe failing if the effective creds are not the same
>>>> as the real_creds is okay for SELinux (possibly Smack too), I worry
>>>> about what other LSMs may want to do.  After all,
>>>> proc_pid_attr_write() doesn't change the the creds itself, that is
>>>> something the specific LSMs do.
>>> Yes, but if proc_pid_attr_write() is called with cred != real_cred then
>>> something is already wrong?
>> True, or at least I would think so.
>>
>> Looking at the current tree there are three LSMs which implement
>> setprocattr hooks: SELinux, Smack, and AppArmor.  I know Casey has
>> already mentioned that he wasn't able to trigger the problem in Smack,
>> but looking at smack_setprocattr() I see the similar commit_creds()
>> usage so I would expect the same problem in Smack; what say you Casey?
>
> I say that my test program runs without ill effect. I call acct()
> with "/proc/self/attr/current", which succeeds and enables accounting
> just like it is supposed to. I then have the program open
> "/proc/self/attr/current" and read it, all of which goes swimmingly.
> When Smack frees a cred it usually does not free any memory of its
> own, so it is conceivable that I'm just getting lucky. Or, I may not
> have sufficient debug enabled.
>
>>   Looking at apparmor_setprocattr(), it appears that it too could end
>> up calling commit_creds() via aa_set_current_hat().
>>
>> Since it looks like all three LSMs which implement the setprocattr
>> hook are vulnerable I'm open to the idea that proc_pid_attr_write() is
>> a better choice for the cred != read_cred check, but I would want to
>> make sure John and Casey are okay with that.
>>
>> John?
>>
>> Casey?
>
> I'm fine with the change going into proc_pid_attr_write().
The cred != real_cred checking is not enough.

Consider this situation, when doing override, cred, real_cred and 
new_cred are all same:

after override_creds()    cred == real_cred == new1_cred
after prepare_creds()     new2_cred
after commit_creds()     becasue the check is false, so cred == 
real_cred == new2_cred
after revert_creds()        cred == new1_cred, real_cred == new2_cred

It will cause cred != real_cred finally.


Regards,
Yang



