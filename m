Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D35C10F27
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 01:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FCD2146E
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 01:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TEMPWGRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgCJBWF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Mar 2020 21:22:05 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:44213
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbgCJBWE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Mar 2020 21:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583803323; bh=2dJEatgWIm8at7HR5lZ/YDdbAqVbkO8RiZwqtCMJJ5A=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=TEMPWGRP40JeqrI5M+U/a+/h+h2bMq8O4mMdIPg/gk5JcRHNDu4Wbin8Zc7M2LzzMZf1fpEe1FZQ8Znte4XyX6n8JboctbP/1qoG7rKFZ0/czNEPb5g5xlsv4S0bZjhobu4ForlB7pOM8+Z+FzJVfLb9ELkrnbh8Ousx8cTfm7QACGcfiHO5aFwggogPyudXrjSzGcD72bJVY9+qdJHxAJZ2ZyvUMIvRZQjqi+oGp2KtLcvScxM9Ff2oN1FVKL5mkvCQicqw5cW3CmQoI9/R2oqicSj2e5H1GvRFT5khJvLpZh7Jx7BukunqCO3DUXfSg5FLX1X53PtIPQfOxlCqRA==
X-YMail-OSG: GOAZxUYVM1lX2gAX_AnGzG3xdoxdyZtS8SQ.TNl4MKYUi3SgejLnrAyvUrYif0d
 nnzzPXFkpRdUfzjROX..SnzYtMvn06ZAYwWuVQLwwkP1NiCDSJdhXJJCy7DlKnINxs0wCd_bAqNt
 bvk0UoKkZcZVqDfiLDkAbU7i9kWXgvBZ.CACPoozKxn0NcgcgbA5H323EdJUoiATJnyjK4dFwGQ_
 UvKvJmsP1Rt3vQh3wwd_VPUu8bYLg6ERCxdv6Uvt2Se69Vo_HjvcDchlaZdLkpCTL7bmOb44RuDy
 adlCQRi_ERj41MBz_66NYW7wdNxPELyZx2SWo0SUwQsCafUhguBjfGyvpqZI5ULjSphXdBXL3WSu
 qFT3fpN.rzsiIYUqt7v1chgSouJdjzeg.PcKonENujSF7c1.5JaSMORB0zM61jrVB1PqetyR9ctw
 gmnGX1OQQF5OUEzdvf6BbZ3MireoeOLGg.aWh_T5OdejXfK2fYPSL7FDz7xuF9uUck6Mjt4JtEPD
 Mu6cathS90nFWJ2OfobRTZad1x38xXMHrfVBVANhtd3sPB_oQLBgEV3neHFneGD1DtQmsZcTkzIo
 T4BXWpMd0nM3ZhNO9DvGrVwy5btKaLx2RWULaWHICvDTmksYACFuhEBoV1noOdAAWKcVfEDrrAGY
 NvKzmfVXZJrwH0Wqa4oc_drgZBOgd5fGflfEyrq1NW8h9STpY0ti1FqIfVFgrRTGZuiQhN_P1_bs
 UkqmjwY9SmoRDMhYUkbnhxn.kuHFrAUkgAY1rxSl6JcPrFu1L6c9y1GQaO7neF.Aa1O0kfYfSzqy
 LpnV6SChFRYDVcSPkrG7hthF71L8br3oAfWzrdy9aJP.5tMG1YtNtD3QLfi0hvRSr.zGODrgBhOF
 VPUG.51VQz5wIQ01lN7rIUlLSnfQ.y8LgaOq_61aoSCk8t8HmNy8HLQ13P_S67iZymSK_LDqB8xL
 YxYTYXxLG_KzJNhWM.R_TzXFb4DjT.wXTkFspV52LYlR0W1wY91TxJalKUDKRqiqAxsMGlZKOgYG
 WU2.czC4WTFEQ0zam7NwVR3QuMQDJqk1HHD15MqMls_PWlEOIzuBJYVzZ57P8VYL7nFlBRiUVNHA
 SzD5IjZ98aJ8jwh9jkAEH4n2M_iwWN99tATAVJI8SXtiNpiR_vsjjcxSkIFV.iX9.kWCCcHkDSdy
 JMgCX1rWaCNFeE69BImR2hT3_HDYCWtxvZYWp4kfLZAOBwwm9UtCUj4cq9SozUFJ8CJqhChrX8WP
 sBnUJ6.0B1EVm.DNPZPLSt.EQeF6W7YJgdemxfZlAwqanKUN.Y7WYk85pb2uA48tFZ7JdCXiIFgT
 GfO1GAdLCYnxgLpjAuVP_DlYskPa4IsFvga4pswNWHRiq66_Z17D4VCc85DVPto1jiEtT6lc0bui
 cYn7pNUoJKNse8.GUaFKhv.6KQEyzzGtwtDcHZ5KdrA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Mar 2020 01:22:03 +0000
Received: by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ac2c737e3821ef1bba584ed02ba80dcb;
          Tue, 10 Mar 2020 01:21:59 +0000 (UTC)
Subject: Re: [PATCH v15 18/23] NET: Store LSM netlabel data in a lsmblob
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
 <20200214234203.7086-19-casey@schaufler-ca.com>
 <CAHC9VhREcdFNtJkXkUrwtbu8GA_h2T5CJ9hAQCU0PSpd5yLGgg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <aec459d8-368b-7a0b-f23c-4b315e1d2623@schaufler-ca.com>
Date:   Mon, 9 Mar 2020 18:21:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhREcdFNtJkXkUrwtbu8GA_h2T5CJ9hAQCU0PSpd5yLGgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15302 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/6/2020 6:14 PM, Paul Moore wrote:
> On Fri, Feb 14, 2020 at 6:45 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Netlabel uses LSM interfaces requiring an lsmblob and
>> the internal storage is used to pass information between
>> these interfaces, so change the internal data from a secid
>> to a lsmblob. Update the netlabel interfaces and their
>> callers to accommodate the change. This requires that the
>> modules using netlabel use the lsm_id.slot to access the
>> correct secid when using netlabel.
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/net/netlabel.h              |  8 ++--
>>  net/ipv4/cipso_ipv4.c               | 23 +++++++-----
>>  net/netlabel/netlabel_kapi.c        |  6 +--
>>  net/netlabel/netlabel_unlabeled.c   | 57 +++++++++++------------------
>>  net/netlabel/netlabel_unlabeled.h   |  2 +-
>>  security/selinux/hooks.c            |  2 +-
>>  security/selinux/include/security.h |  1 +
>>  security/selinux/netlabel.c         |  2 +-
>>  security/selinux/ss/services.c      |  4 +-
>>  security/smack/smack.h              |  1 +
>>  security/smack/smack_lsm.c          |  5 ++-
>>  security/smack/smackfs.c            | 10 +++--
>>  12 files changed, 59 insertions(+), 62 deletions(-)
> ...
>
>
>> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
>> index 376882215919..adb9dffc3952 100644
>> --- a/net/ipv4/cipso_ipv4.c
>> +++ b/net/ipv4/cipso_ipv4.c
>> @@ -106,15 +106,17 @@ int cipso_v4_rbm_strictvalid = 1;
>>  /* Base length of the local tag (non-standard tag).
>>   *  Tag definition (may change between kernel versions)
>>   *
>> - * 0          8          16         24         32
>> - * +----------+----------+----------+----------+
>> - * | 10000000 | 00000110 | 32-bit secid value  |
>> - * +----------+----------+----------+----------+
>> - * | in (host byte order)|
>> - * +----------+----------+
>> - *
>> + * 0          8          16                    16 + sizeof(struct lsmblob)
>> + * +----------+----------+---------------------+
>> + * | 10000000 | 00000110 | LSM blob data       |
>> + * +----------+----------+---------------------+
>> + *
>> + * All secid and flag fields are in host byte order.
>> + * The lsmblob structure size varies depending on which
>> + * Linux security modules are built in the kernel.
>> + * The data is opaque.
>>   */
>> -#define CIPSO_V4_TAG_LOC_BLEN         6
>> +#define CIPSO_V4_TAG_LOC_BLEN         (2 + sizeof(struct lsmblob))
> This isn't as bad as the sk_buff.cb limitation so I'm not going to
> worry too much about it, but just to be safe I think we should put a
> compile-time check to ensure that the local tag is within the bounds
> of the IPv4 option limit.  If we don't put a check I worry that there
> is a chance someone could get a very rude surprise at some point in
> the future (yes, this is highly unlikely, but still possible).

I hadn't thought about it, but that's a splendid idea.


>>  /*
>>   * Helper Functions
>> @@ -1467,7 +1469,8 @@ static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
>>
>>         buffer[0] = CIPSO_V4_TAG_LOCAL;
>>         buffer[1] = CIPSO_V4_TAG_LOC_BLEN;
>> -       *(u32 *)&buffer[2] = secattr->attr.secid;
>> +       memcpy(&buffer[2], &secattr->attr.lsmblob,
>> +              sizeof(secattr->attr.lsmblob));
>>
>>         return CIPSO_V4_TAG_LOC_BLEN;
>>  }
