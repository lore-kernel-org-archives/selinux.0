Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C837C433EF
	for <selinux@archiver.kernel.org>; Wed, 18 May 2022 06:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiERGxj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 May 2022 02:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiERGxi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 May 2022 02:53:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325EA1D320;
        Tue, 17 May 2022 23:53:37 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L33bJ0tMDzhZ5T;
        Wed, 18 May 2022 14:53:00 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 14:53:35 +0800
Received: from [10.67.108.157] (10.67.108.157) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 14:53:35 +0800
Message-ID: <6e2534c3-9af1-0c84-96ac-79075f79ab39@huawei.com>
Date:   Wed, 18 May 2022 14:53:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] selinux: add __randomize_layout to selinux_audit_data
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>, <selinux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20220518092137.141626-1-gongruiqi1@huawei.com>
 <CAHC9VhTj365p3SJvX+8eBqRO3wddnj0sXtRDp=jEhSdADwiGrg@mail.gmail.com>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <CAHC9VhTj365p3SJvX+8eBqRO3wddnj0sXtRDp=jEhSdADwiGrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2022/05/18 9:39, Paul Moore wrote:
> On Tue, May 17, 2022 at 9:21 PM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
>>
>> Randomize the layout of struct selinux_audit_data as suggested in [1],
>> since it contains a pointer to struct selinux_state, an already
>> randomized strucure.
>>
>> [1]: https://github.com/KSPP/linux/issues/188
>>
>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>> ---
>>  security/selinux/include/avc.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
>> index 2b372f98f2d7..5525b94fd266 100644
>> --- a/security/selinux/include/avc.h
>> +++ b/security/selinux/include/avc.h
>> @@ -53,7 +53,7 @@ struct selinux_audit_data {
>>         u32 denied;
>>         int result;
>>         struct selinux_state *state;
>> -};
>> +} __randomize_layout;
> 
> I'll apologize in advance for the stupid question, but does

Not at all :)

> __randomize_layout result in any problems when the struct is used in a
> trace event?  (see include/trace/events/avc.h)
> 

No, as least it doesn't in the testing I did. I believe we can use the
struct tagged with __randomize_layout as normal except that 1) it should
be initialized with a designated initializer, and 2) pointers to this
type can't be cast to/from pointers to another type. Other operations
like dereferencing members of the struct (as in
include/trace/events/avc.h) shouldn't be a problem.

I did a testing to the patch on a qemu vm by running the selinux
testsuite with tracing events "avc:selinux_audited" enabled. The
testsuite completed successfully and from the tracing log I saw nothing
abnormal with my bare eyes. You can do more testing if you want or you
have other ideas of how to do so ;)
