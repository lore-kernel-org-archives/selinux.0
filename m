Return-Path: <SRS0=Yzg2=BG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68848C433E8
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 21:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A0E20809
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 21:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SC9TNsmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgG0VEi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:04:38 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:43113
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbgG0VEf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 17:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595883875; bh=uffMMzGVMH/ibllR4wF7EUg+aig+89e+V3W5cKa9zpI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=SC9TNsmwPeMtg04RbkszoR1Ba7IzqLW32jfH20+8C44fgpVNbWxI4FR5Nrx8x/Xumhn8wGuxKqiMMcZw0DlWwzJS6ktXYOjy7NCtoRMF4qi0AYfClnLMANw+HSWAYJaaGBqkOqM6lpw7huWAdVLqx9v1bONOoFpnbM5KPCUah4Zf0vT0Ditf7Sx00lYQCTJtDrkXgm6JiqKW8HI+QfI9ei9qQ2iNtgwctbfNMTXM02peK6pdy5ihc/273GNYbQrXV6PQtJOKdsWLyVxs8JSfHauBFtFYT7e2HFg2gGw31WeLjb/cKy8mbMiLlegh1s4Mer42bc4mefQTAhyBEToepA==
X-YMail-OSG: JarmxxAVM1mMDnv3HlZ97NX4qK6nDNkjyZpVY7.9lD7IR.oWl4R_rTEWLcCCSIY
 RVFu4I7KDavx7.KQ1CyWJ.72ghbi8xLX6MY01IJDgKhFphYLBKnBHDZTzBE8J8u4hqGflp7SE5iE
 wSbvRUXtj9tYy7_YAqFT4AN_yD9n.viTAqcTQWJa6ZegCACqqaVTdv_AfXOVPteIaF_83qGCm42j
 kxomiVdI.Cam3SGGKlS9f0rjPMYKfqApVOSMHCiGfOUwC5.m1aC9QgFgD_w17OI1rfA9kwndnwWZ
 LsITA3aECA4Vc8b.WGkTVD7ojJgvoYD8rIgIBs8BdnIDxqMM9OghUQiTrrI7SpkE8sTAAI7A.Ngg
 MODGO_OkTR3neMLEQbdeUgrU9xlvGWk0ajW.G1qsyPSU7h32Zhyug39Ch.j.jEpAGrGK_zDJ31LO
 KVDtuTDISZqnM7Ia9Chcw0nUPxZ25rMzz5BekdYsufrVQ0yZn79xasQHKsoMkYdLzIgcfVzZv_Fk
 ak27N9P.t.uUzpJn2h_GBCDCDm7m38Gi6uos8NSRV1B_o0e5kWMgajz9GrATeviqLKj2Y4gsJtSy
 iasn6cjRuq1.AaYeW38.8CyaBlymPQr1zM6iaHW81O6qMeTWrsnJLfz5un3rvsqVdEEap2hWH.sU
 0cuYLkrdbRsUE2pG3O9Zv_yOLGb8NpTu_tzbNSUcFuMNlufwZL.xu32NlhaXPRecsCusFiQHrUR4
 QeEKo4jmgCKTbK4mKwkqYeU8_CQPKPLoiXpqhJ_2MdJMbzMEa_j126q_KZsccOa9fLqVAWbGZWBq
 LhGq74ca.j8OPy0LWhJkbnxpI86hD0piBEj_kYA.8uwvzViPJWOw5TisXKtJTWjuJZN5LYDGXW.9
 0oKNn_sy2oFflwlNRO7O1YEmTRpEYSjcmGS6gF46_MES9rZ6PDT3Uz40PliZC.0uj0BjL6HJ_aSm
 KOZR9Z6skBHWH6iwAPrX44bhYPJR0uHlFY3WyTfzowH6FS5VUjLh.98tAqDukyX147SWSRkGWNJ6
 0Ljh3KZXEa4Q6sPH6zMwWxzOkXQjbZDqYxpyoMXI8IzEMc4n0uHz8WqAu.gg1fRtUf5JGPG2GVYT
 wIJp87iWtGpXibh1pr4MPJKaoZYx6KPzWmKkqdAGXVwobUVf335kU3flxJRhjYcgflETdiCl4s45
 HvoE35ejx7X.mdI6uOdNc5Ji6GDwPmARtDchov1RPjH_KHD4mqbYJyVe5nBcrBGKKDPaCJxQ.nhY
 xgUqQG8wGKS10yPGyoGr8Sg.9WdvTCthqIRE4ht5zN.gYzEqpJBHz_WFhbl03QdsitjTS_muuwZS
 0ROlvUMB_leYbHOZfxKMAYLPdlt69pah0xCQWlrwrnQPAgW3_AJ1B7mItV0IMTf7QbOGe_v5JDGB
 cEGrqDKn8jcIhzHmqymnf25y1JcrSkOuj4fo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Jul 2020 21:04:35 +0000
Received: by smtp421.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 17477479602f8a087f902e3ee11d52e9;
          Mon, 27 Jul 2020 21:04:34 +0000 (UTC)
Subject: Re: [PATCH v19 02/23] LSM: Create and manage the lsmblob data
 structure.
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-audit@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200724203226.16374-1-casey@schaufler-ca.com>
 <20200724203226.16374-3-casey@schaufler-ca.com>
 <CAEjxPJ453W-8PmB4WPq2vZHfvvG6yWFmoqnuHtHvz5Y5MYaj1g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <4802a880-ce53-989f-8771-76349532b89c@schaufler-ca.com>
Date:   Mon, 27 Jul 2020 14:04:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ453W-8PmB4WPq2vZHfvvG6yWFmoqnuHtHvz5Y5MYaj1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16271 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/27/2020 9:12 AM, Stephen Smalley wrote:
> On Fri, Jul 24, 2020 at 4:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> When more than one security module is exporting data to
>> audit and networking sub-systems a single 32 bit integer
>> is no longer sufficient to represent the data. Add a
>> structure to be used instead.
>>
>> The lsmblob structure is currently an array of
>> u32 "secids". There is an entry for each of the
>> security modules built into the system that would
>> use secids if active. The system assigns the module
>> a "slot" when it registers hooks. If modules are
>> compiled in but not registered there will be unused
>> slots.
>>
>> A new lsm_id structure, which contains the name
>> of the LSM and its slot number, is created. There
>> is an instance for each LSM, which assigns the name
>> and passes it to the infrastructure to set the slot.
>>
>> The audit rules data is expanded to use an array of
>> security module data rather than a single instance.
>> Because IMA uses the audit rule functions it is
>> affected as well.
>>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> With CONFIG_BPF_LSM=y:

Thanks. I am surprised that this config option isn't
under security. No problem, an easy fix.

>
> security/bpf/hooks.c: In function ‘bpf_lsm_init’:
> security/bpf/hooks.c:18:63: error: passing argument 3 of
> ‘security_add_hooks’ from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>    18 |  security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
>       |                                                               ^~~~~
>       |                                                               |
>       |                                                               char *
> In file included from security/bpf/hooks.c:6:
> ./include/linux/lsm_hooks.h:1592:26: note: expected ‘struct lsm_id *’
> but argument is of type ‘char *’
>  1592 |           struct lsm_id *lsmid);
>       |           ~~~~~~~~~~~~~~~^~~~~
