Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75EAC282DA
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A103920835
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dhwxYMe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbfDQQmQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:42:16 -0400
Received: from sonic313-21.consmr.mail.bf2.yahoo.com ([74.6.133.195]:33735
        "EHLO sonic313-21.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730463AbfDQQmQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Apr 2019 12:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555519334; bh=3MM2CWsG+1KZRItt9dOySsdZCX9P8oSLNsyZBeCppkY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=dhwxYMe/fWjUCSTCdw2AIWWaJWlbA6Flo+q1btTqFPC+OcthqRw+dGgYRtdAtxX9I9xDdpcaArGzhAacD9s1cOXDRbE0xREUUCZHdebSkbbDeiq3GOUULngJJ60n6307gtVEy67W9VEZhdFBKEi1QXPBXd1AU76sFyl+VStdTH9i0oyKM+ers/ayZOG1Ju8/7jhTqZwUDljGOs7HTWfH6aO+4d+ffYuclowIx+j4RTCZJQwb2A2kRCbricB83RHH65EG6+1IUWlH/yewJgEJXsGXJ4VkqfclQ9v+pdWTTzJytWJNk7z3rPPgBNO/5PJrsoqb4uW5X8yXDZ94EEMp0Q==
X-YMail-OSG: K.6GFc0VM1neswhz_haptv_iiR9K5VoKZAPX0yN8uXKjWPnOLTONSKvQ0Mn_YsP
 HoA3Zg8hzAXK18DPM_zyPUMZOj7S6Pzn75nABZeQM6N7f.bjZfn.2sjWQD_ES83bwW7XQoK9Lnk5
 36jOXpiYteMVbMQJgvTYo2CLYuTUXf1Jv_4zTmatAOkE_dfolIR1yhXBaLl0jD1d3f5KECE0iC3n
 beYuxI3n.q474NSfnLrAR8UNSOalHtfnAYTNZ9haWRMzi4s_2hCcUU3msHiTBRgouPUvQ8_NHvvd
 W1Ejv.9UMZYb2PXlOb6FCmExvCzsmEiBAQmpafsTsrEPY8LyP3N0JyCCGuqMf06TV.D8aWEGA.wH
 O8GFI1c5BoL_CzAOT0qplVVC.hALu3a3Uw4kdfKdpOKnMug1I3hQ5IUNgjGgjz_w9ZwfY.prBBZV
 P4e34u0hm7Q6A6efeTiolGh3k2yQCOyCekS0b0dPVvRqNqtxueAAQQfEDzCrI3c_5bheZBT8c4hz
 1T07NCuhf3PXhqDdG4td8bI.NmhNM9rLVpY.q.JUB5hoTuOrXf2E_n4C4XBvJZu9rZFsJJSg8GTZ
 ZzcT75hiVElgWHZFgXq9aHXk29gf.QTvBfvuXMUbHWxJifuZjW2jvPBBFDfmDqNm.w2o5Fozqgk2
 PmMGzIQuOkvjVBzI82zQP3SAqpFVpU0gHw_2G.vKe99t.xnw0ljRNp70ixlCbY2MOa4L8bAUJYYF
 ujTasSnMHJ9wJMiaKT3Mk0kZnT01.5IaYdJ9udw4L8rjYpZgqtczI7Gf_sAVJMz0dGFB_Y6cIWog
 a7BdFz6EPTJxe3_r7oPhV_9KWeJdLtXPna3bDrdQK2LcuIL7Ly_ixoYdZAiSZ45U7ecoAdYFDf2Q
 520zsc3tOBEi3wD.cNEYsLDVZRgAjUxZZQ0cgJY2_sWCqmRADpZT8N8VvAW4PmB9Gb3HFX1uLirG
 XS.Kay4SeDHb46ykVWLrPDEkkwDeFsGFGC6zGAP0jbOHWng5ST1egesDhUK4OA2WcrfZYh_jEg6V
 _PErPOO_QR8bLw5mYUYyTuL1AEvUGO4DqSZQTr3ag_TCYvBZ0maPg5CWaHijgNJjy6j.vfgqM0_k
 2h93U16lBlR7XaqxGpfBxQmNu4A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Wed, 17 Apr 2019 16:42:14 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp412.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1f1ffef23e024c3542d30848c732eedf;
          Wed, 17 Apr 2019 16:42:13 +0000 (UTC)
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Oleg Nesterov <oleg@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>,
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
        SELinux <selinux@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        casey@schaufler-ca.com
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <939a45a6-fc1b-0ac3-759b-0e7c3ce3d670@schaufler-ca.com>
Date:   Wed, 17 Apr 2019 09:42:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417162723.GK32622@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/17/2019 9:27 AM, Oleg Nesterov wrote:
> On 04/17, Paul Moore wrote:
>> On Wed, Apr 17, 2019 at 10:57 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 04/17, Paul Moore wrote:
>>>> I'm tempted to simply return an error in selinux_setprocattr() if
>>>> the task's credentials are not the same as its real_cred;
>>> What about other modules? I have no idea what smack_setprocattr() is,
>>> but it too does prepare_creds/commit creds.
>>>
>>> it seems that the simplest workaround should simply add the additional
>>> cred == real_cred into proc_pid_attr_write().
>> Yes, that is simple, but I worry about what other LSMs might want to
>> do.  While I believe failing if the effective creds are not the same
>> as the real_creds is okay for SELinux (possibly Smack too), I worry
>> about what other LSMs may want to do.  After all,
>> proc_pid_attr_write() doesn't change the the creds itself, that is
>> something the specific LSMs do.
> Yes, but if proc_pid_attr_write() is called with cred != real_cred then
> something is already wrong?
>
> In fact, I think that something is already wrong if it is not called by
> user-space directly. Too late to ask, but why is this /proc/self/attr/
> magic not implemented via syscall(s) ?

Shell scripts, for one thing. It's a straightforward and appropriate
use of the /proc interface. System calls would require additional change
to existing programs, whereas using the /proc interface allows a good
deal to be done in the containing scripts.
  

