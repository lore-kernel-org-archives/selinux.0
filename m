Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555CBC43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 21:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B382467B
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 21:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DBvv9GXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLSVoP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:44:15 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:44603
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbfLSVoP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 16:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576791853; bh=v66WuyTVUaX6OG3ox7vmPodGeM1PNJQrZv92B/pn1Wo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=DBvv9GXGW0ll7gW4oJu9YBpXNR7d7Ev2l2grGO4ZLlEZBHPDyrIWJv9vKFDsHePjkv1ld9x//xIr94nCPKe3Q0EwabEe2fubEXxxmC9PVdFvZ9BZkTrg5GMxlbkMRDUJ/7AEYxEnlmoSo6h+diS+eX8cnnZgdmaqdXEO/5dztQwyd3uqm160mwLXfgJMkKrNutwEMk0Ql0XS1Qd2NFJnZsO0qTMGSy82ejtj3SyvWfF0J9T9J62VLWu6Eu7py7venp+wNsb6txLNNJNHg2fRSldxVlC2J2TnRr+yMcK65AcGXJPQ7nNMcmTwcdtv/vY0k+F27aZwQpUmm/0wKhKrTg==
X-YMail-OSG: .fo38vcVM1lwx6mufN0Jn4tN8j9TF_QI66jsB4TishWnHoUk.Hc5__0rXHZ7iLB
 iiTRSlUtbEDAGd1MrSWU07OJ.zBm4WZXs1MFoUqw2zgf0rhs8cKuzZbvBkrYykirHJHqeruyCtjm
 pxp1or2Q0FTSrs.sBtGCv22nj9rjxwVtlguqmNTaPFTxPHtg2kWC6QwXo4YOzWpNmeF8oTsJYox0
 9rC_pW31ze8oBDn5zlPmoNTWGxZ15T0FQ8Cd.0dbzeYWELhpuEYYTm_YgGEili.ujFsMS3AWvf78
 YEf747vR6uUBAXrJYdeHzHL8pIB5Qt.8ZCEEj5I3JaVNYm2BCLEnlW4B9fUrBbr_6FZGVHQfie6D
 vuyrSHo5MeFiGjO5wn9fEgjNo95VGXxsznOo4iegConMKRWRykXdgUeu_0AV.iuRm5Wys0DVtDGm
 bjpvVetct8qBDiXoaYez2JWei8WfrApE8FiTVKgG_.cZS8d0kWt10SrUANXJTAQ5zrVZ50rveETJ
 kTXdtjM702WtOKO9C3vRvRKwr3HwnCjVVWgGmuzCK8akUFNZD9xDJ1SlZ6QONQMbjXOXiOADciFu
 kGIStZ6GdBm4zJngIvGQEeHJNkzHmIRbueIbq82IIKnGzF69ZK_RM8Ci7m8nSEaEjEPg47sQLAua
 5SziE1rKqRaGQE8n0O4nGRn10jY6bCjmGDR3YzBe3ZHWfHDBawtYK3VmYlZ6SjbUAVrVcKYAXVTF
 iiNE6QWQi0u5FqKm4DgEkUx5DNBhCHkx8c4MWQR5wqxBhyRA7knlosDX_iTDlm75JOMIedbet1rF
 jTNJRqznRpfYIv3UE8psmNGGPVqc5cEW6TWTB3sVlK3FW4eDkq8JzCjq4zBI8fxRKjKrHNp93yaY
 BYz2ilqxBbKteS2kdCj73g.PGIriCH_CmVEqFO3LHO0nckzYymUStF4orDQ27K5VgAnsAYpk0XtR
 71qCOk9MI07xFq1MG8d1y8HrIPNRcTC0LLRrw1JPgYwaVYlwe4z5rRjU5VwCopr13U1KTak1y6Lp
 XmxCkiqPJfa0Uc7tmLtjDVQsUfjeH6VlG4AV5vuH9zeG7Rf442ckFlJGrFQ1sD7bnO5_wdvJ6kwl
 wGuyKvhd_QCpR0wIRiGKcPdy5zzp1smZAh69DJoizgmPXUhut4Q5QedS5ErOK61Gfz.hdhhOW5kW
 940CVgl6R.B7kHFE6cd_xY5To5HjpLXYqbaoeO5.znfEMJK9AgCJJO8KEONHJLJiyDm_nqktP9qz
 yvECtEV4bC5bPu7nNOOQ7RalQmFOm290vb94B1DWKOpoW8WnS7sDTbECgJUqUcqDsT2ydN_E1tgj
 cTnTEHxqupnNHfJBkvoJpPeC_gi_8q1K3rsdDDkeu1i0Blv9qS6yYJ6u1mxHfc.3nvbis3HJqRiE
 jClP0AgqPRo2ssNpkyH9RZ9LHLDnNw9B7XbGjtpSrxJ4AI6MaGstQbLf8cy63xx1i
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 19 Dec 2019 21:44:13 +0000
Received: by smtp413.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 57146edacb5a882d36f6a55ae3d3e67d;
          Thu, 19 Dec 2019 21:44:11 +0000 (UTC)
Subject: Re: [PATCH v12 02/25] LSM: Create and manage the lsmblob data
 structure.
To:     Mimi Zohar <zohar@linux.ibm.com>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, Casey Schaufler <casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-3-casey@schaufler-ca.com>
 <1576789891.5660.3.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <b3370d56-241c-ccd5-1438-4266b8cec6a4@schaufler-ca.com>
Date:   Thu, 19 Dec 2019 13:44:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1576789891.5660.3.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/19/2019 1:11 PM, Mimi Zohar wrote:
> On Mon, 2019-12-16 at 14:35 -0800, Casey Schaufler wrote:
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
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h  | 12 ++++++--
>>  include/linux/security.h   | 58 ++++++++++++++++++++++++++++++++++++++
>>  security/apparmor/lsm.c    |  7 ++++-
>>  security/commoncap.c       |  7 ++++-
>>  security/loadpin/loadpin.c |  8 +++++-
>>  security/safesetid/lsm.c   |  8 +++++-
>>  security/security.c        | 28 ++++++++++++++----
>>  security/selinux/hooks.c   |  8 +++++-
>>  security/smack/smack_lsm.c |  7 ++++-
>>  security/tomoyo/tomoyo.c   |  8 +++++-
>>  security/yama/yama_lsm.c   |  7 ++++-
>>  11 files changed, 142 insertions(+), 16 deletions(-)
> security/lockdown/lockdown.c is missing.  I'm getting a compiler
> error.

Whoops. I'll add the new kid to the list.

>
> Mimi
>
