Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EEBC10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 02:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF022171F
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 02:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfDSCmZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:42:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbfDSCmZ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 18 Apr 2019 22:42:25 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8DE7C355CD7BCD18DF77;
        Fri, 19 Apr 2019 10:35:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.219) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Apr 2019
 10:34:54 +0800
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
        SELinux <selinux@vger.kernel.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5CB933C4.7000300@huawei.com>
Date:   Fri, 19 Apr 2019 10:34:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQkrR+m9_dYLg4VG-26TdUnf8XFjbmuVQ70YCOp6DhN_g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2019/4/19 10:04, Paul Moore wrote:
> On Wed, Apr 17, 2019 at 10:50 PM Yang Yingliang
> <yangyingliang@huawei.com> wrote:
>> On 2019/4/18 8:24, Casey Schaufler wrote:
>>> On 4/17/2019 4:39 PM, Paul Moore wrote:
>>>> Since it looks like all three LSMs which implement the setprocattr
>>>> hook are vulnerable I'm open to the idea that proc_pid_attr_write() is
>>>> a better choice for the cred != read_cred check, but I would want to
>>>> make sure John and Casey are okay with that.
>>>>
>>>> John?
>>>>
>>>> Casey?
>>> I'm fine with the change going into proc_pid_attr_write().
>> The cred != real_cred checking is not enough.
>>
>> Consider this situation, when doing override, cred, real_cred and
>> new_cred are all same:
>>
>> after override_creds()    cred == real_cred == new1_cred
> I'm sorry, you've lost me.  After override_creds() returns
> current->cred and current->real_cred are not going to be the same,
> yes?
It's possible the new  cred is equal to current->real_cred and 
current->cred,
so after overrides_creds(), they have the same value.
>
>> after prepare_creds()     new2_cred
>> after commit_creds()     becasue the check is false, so cred ==
>> real_cred == new2_cred
>> after revert_creds()        cred == new1_cred, real_cred == new2_cred
>>
>> It will cause cred != real_cred finally.


