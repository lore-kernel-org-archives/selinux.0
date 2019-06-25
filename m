Return-Path: <SRS0=B9fV=UY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3411AC48BD5
	for <selinux@archiver.kernel.org>; Tue, 25 Jun 2019 15:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CACA2146E
	for <selinux@archiver.kernel.org>; Tue, 25 Jun 2019 15:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oIkOGE2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfFYPak (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:30:40 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:44358
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729260AbfFYPak (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jun 2019 11:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561476638; bh=FnPWufeLeQr0hI3+/yRaQrxAzEWJRWUBrvGSKpKp0UM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=oIkOGE2oBvIUiuhlUqkiLsAglTLFEnkOvBzwMXoZUvaFMkJLGV2+Lj81y6zgbOLzoNuusDOKKCimpsjUli5PqM0lWa3szpf8EbPmoImdZcsGhF8kVFHllGaxBo0R/+S5jjZ5X3mHR8oAQ29F7TIVh0ny1HqYAgkfH5JvCzvvxipvVZTjKVJ+hJSxYqZZaotlaBEhEB1CuHmFULR6x+xaaxgNd38lbMswV6NXqNUZPbuv0cVCRjk/KAkOQWpKPpmv9bFix+A4wYAjMwQEzFIH85oN0XcmGplU2bRJUc61q4UXcqQ0MwnHhYGqXqmaSwVbjHmf/1/Zu5DZy4Iwid44Ig==
X-YMail-OSG: Sd1tFWAVM1mF7.szlHt.SMirUFE7h1lDWy08VsWvVOWkDIYjsXruzLpwMzDVb9L
 XCXoGqLWPhXzgp6nJbSD8ixtn7BKLRfV4GXIqEYgXWB5tjrZJLqo00L.EdwJjfi86Gb1AbrOtCzY
 Sd9GnPMm17SecyKRa3rjWcVr7SluRGS62mIyZRNkPXn9K1q0UFzrvusW_W7tXlC6EeVfOYAUDXJ9
 35nglXzPJYaiePRs8bj9BcfkJEJA6O49qoVChVpkow7WL4I6SG_wiRQc8Gu1WekDrSEojgGxYmsg
 7YZ.cMJCJD7wp0w_GjXdn_TJvMVGZLmw5LhMl_jr_7NxlPfBHgfg3AfAb1nXrrhYXJLzUj6rQwJ7
 eRRiJufvEIyAt2WU6F8xI_LDrogG31DIwUBLKDUU.9y7ne1GNcae6HnVqH5d0D7K.2fEqXCaZ8El
 aEtGQXkhu0S9ZjBNuDT_Z3.KIJ2.MjRaqduMrviK4BGwn4DQcYqkZT2xW_WwKpGs5Q_5MCc_GZhV
 gF1IkAAx7pifEYZcOkZO1cjQ2OOFVrB1TvDcyslfsmhtfJPLcI3eQT7RnatXXWZHzs6aWgyVyEpW
 71TGjr6UjXTMbsHEHJVN76Rr95h7g8bZpUXr2kCJ8oqO7DUOINkxEkJs_OFbc9k.XuIZsOmrV.dn
 tp4dISvUAxNkcAKPlebfN0n7QA5zaxBuJz..UsDcUIGKuyBCjiOIkTwGN9_hsa8.XDtaSag6KJ2x
 _RnANiBQVrw0QvgvJtUHp554HzM9of5pZvENYG1dYx8yUjIHJejU.Bt3U4jFiUoVlUvylR_vj4No
 OwnvSEsonCtOL9rAYmKQ5YRYUorUS7HKGIAsB2SuFPv05lBnpP7RNdPHSb_l7HeJe_o_V2n3YG.Q
 csh0Cb6vJ_pC2HVD_j9aB_UhCHD6XdBNTmi07sw4DO3ngnBcv4MKsWuhlZAv8ItfuUG.RC4wSNMa
 VUqsJJoq6nmn8L0zcroZBze_W0qJqgYU5lw.ywj68B_2iAeYQy34achOMudlmLN_dhgIY3_65P5.
 WcRJBPf4_kSDkwQV3hFVeqjAfvdyf5bUNDSpDKI0HB1rvTOL4qK3jkVcPCp88RpvT29DzSOBat3s
 GkVVXMvyLy0Pfll4g2PICUzlhUzroq75JVRlnTtFCuW0p..pbP9OiJ8ke9Q0TCE.Wved7GuafoV1
 HdGvqo7841EhKpSdQRNFhN3MDEiG0jmoFRiv1qqqe_WdxhekrI4zNZfCMeWQOLXzvbCT93eAwc9B
 w.emr8pZBmwBsB85_CVh6tQ1RUF3HoITvj0nVaTvS.Xc5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 25 Jun 2019 15:30:38 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5dd7601bc46a4923afb7c89cf89f33a9;
          Tue, 25 Jun 2019 15:30:36 +0000 (UTC)
Subject: Re: [PATCH v3 21/24] Audit: Store LSM audit information in an lsmblob
To:     Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        casey@schaufler-ca.com
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-22-casey@schaufler-ca.com>
 <79cd4a92-c221-eda4-58ba-730b5c2680d7@canonical.com>
 <0ad8f906-16ff-61af-ce7c-0ea1e9760d03@schaufler-ca.com>
 <CAHC9VhSSwCY8L71x4WTr7kJhF1f_oyQ1NcwyXCAgW7ruKACQdQ@mail.gmail.com>
 <41f99313-1aa4-bacc-6767-8ee1389ca220@canonical.com>
 <CAHC9VhSSMjCdT8gfB03gh8VvJngTHnsUsDCpseMUiEPQM9z_FQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <c231726e-5235-1dae-8fb9-6f89db406260@schaufler-ca.com>
Date:   Tue, 25 Jun 2019 08:30:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSSMjCdT8gfB03gh8VvJngTHnsUsDCpseMUiEPQM9z_FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/24/2019 7:42 PM, Paul Moore wrote:
> On Mon, Jun 24, 2019 at 10:15 PM John Johansen
> <john.johansen@canonical.com> wrote:
>> On 6/24/19 6:46 PM, Paul Moore wrote:
>>> On Mon, Jun 24, 2019 at 9:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 6/24/2019 2:33 PM, John Johansen wrote:
>>>>> On 6/21/19 11:52 AM, Casey Schaufler wrote:
>>>>>> Change the audit code to store full lsmblob data instead of
>>>>>> a single u32 secid. This allows for multiple security modules
>>>>>> to use the audit system at the same time. It also allows the
>>>>>> removal of scaffolding code that was included during the
>>>>>> revision of LSM interfaces.
>>>>>>
>>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>> I know Kees raised this too, but I haven't seen a reply
>>>>>
>>>>> Eric (Paul is already CCed): I have directly added you because of
>>>>> the question below.
>>>>>
>>>>> In summary there isn't necessarily a single secid any more, and
>>>>> we need to know whether dropping the logging of the secid or
>>>>> logging all secids is the correct action.
>>>> It is to be considered that this is an error case. If
>>>> everything is working normally you should have produced
>>>> a secctx previously, which you'll have included in the
>>>> audit record. Including the secid in the record ought to
>>>> be pointless, as the secid is strictly an internal token
>>>> with no meaning outside the running kernel. You are providing
>>>> no security relevant information by providing the secid.
>>>> I will grant the possibility that the secid might be useful
>>>> in debugging, but for that a pr_warn is more appropriate
>>>> than a field in the audit record.
>>> FWIW, this probably should have been CC'd to the audit list.
>>>
>> hrmm indeed, sorry
>>
>>> I agree that this is an error case (security_secid_to_secctx() failed
>>> to resolve the secid) and further that logging the secid, or a
>>> collection of secids, has little value the way things currently work.
>>> Since secids are a private kernel implementation detail, we don't
>>> really display them outside the context of the kernel, including in
>>> the audit logs.  Recording a secid in this case doesn't provide
>>> anything meaningful since secids aren't recorded in the audit record
>>> stream, only the secctxs, and there is no "magic decoder ring" to go
>>> between the two in the audit logs, or anywhere else in userspace for
>>> that matter.
>> Okay, thanks. Casey I am good with just a pr_warn here. I just didn't
>> have context of why it was going to the audit_log and didn't want
>> to change that without some more input.
> Hmm.  Actually, let me change my comments slightly ... perhaps what we
> should do here is keep the audit_log_format(), but change it from
> audit_log_format("osid=%u",...) to audit_log_format("obj=?").  The "?"
> is used in audit when we can't determine a piece of information, but
> we normally log it.  It wasn't used very widely originally, which is
> probably why it isn't in this piece of code.

Works for me. I'll make the change. Thank you.
??

