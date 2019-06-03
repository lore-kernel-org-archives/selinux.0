Return-Path: <SRS0=Kl1g=UC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FA9C04AB5
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 22:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6AD2425A
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 22:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Nue9n/cC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfFCWXN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:23:13 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:41537 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbfFCWXN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Jun 2019 18:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559600591; bh=r609O5f5JDa4I4H9aTVfMVGdagumb6sGx1yOVn+JrP0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Nue9n/cC+XXiRuNFJkO42RXxUt5J7t/ADP1fGukuoKh+s1G3AgWmvqgwfKRihtEpwpq25o0nlo0f/i8vt1BF4X3NksK2P2YE0JzCZTy6gq7pbJj6fNl/rSPxje0d83tBhnrhOn7mPdDngiOLdnSfNpN3yeGlcasOwlKxp/w6vcKZjLzxa6qMhp+aZ6shyh23l4KD3AlZ8iF54Ebewg0eunfCZA26HlGDnRE1S17q9JBiFTTcYOEkz8HBaYD2fw568bkDNpo6T5ttYkn/3OXfCEMb8JANi/NRdRMkObjy7+n54bYRbot4lpJmr7KHNMPcqLtl+kQAFk6UKA2SOSIESw==
X-YMail-OSG: NTPHqDAVM1miK2iHMNLHdNrCZTJAHwi9Mf7h.1sRwzkcvcV5.7V3aQVcxlEl8bX
 HW4WaohU7Im3ZMBqHqWLFDzfM.CfU5P987N4jxLfQDrFMjEaFWaoyTNcFQs5Lgm3bQcyJ8xGuJqT
 UoFVxHZbee0C5Zx8o9ta4SdvuMUVJ8r5Kg0JTQmtyDWgSI2lFa.pcUy11XQJglArO2E1ib6U_Vhd
 L9k_oub2K6ye6zYNO5m8FYpxkD0KurKKTdDH.5o7qHIAyKIeDUmNE2D8F9od8RTjcidqXjCl0Au_
 Vy8yyzNPin08hwJ2aP2qUjLv0ZFRIL1DuqAlE1IbPz_TOQkIMSep7ag6rLNJ8mZSgXx60f2iq2Vr
 fXqW_NgSg0_HOufHPM2aHE7IQA5n4B8JE7P.cpj2IsLfZmEgI5UMVR2LdHWgLhGw385Lx.cyKNqE
 idM.RoCSJ4B6ri_3AzXg3F_L8U4a71Dn0jBdUArThateln4icV6E_Kn6YUxQAL0idOcQfpn119r8
 h.KiEf8UL7R5BCldHqRTcrsh.EhmvY9d0_TkUvnFepBiin6MlgoLGBt6UgGb.UV0ZYzFg76vYfyS
 rHpBwHzuq8zjCXgf9V.29AhvL6cz7.jxZy2QJ_9iTbmzZu58eQFjY7pOYqaC28fYf9BiDdkIV4vI
 YWErRTAdBZecwC1Lr8Q0Zam6wy_UqSF5_1r7QFa1ManB.p2bU0tA43tCNEgOXetJXZqLeykl_lYv
 1Ns2SLo4.Xh7a1Vsio8Qvq1pbQl9ii56kITWR0HkRB0CoQei3fVWitp3j4WXJjHLNqPPA1PBz8GH
 zdF3o9xyCdY.eNedq.NjWORSRNC.PFpha3TtJ8TfNmpNuALUXH8YFctsCweVzTFcWbXOmSbq0LnP
 wqyrO1Y5b04MnLflw7gv5elHCHmv5PoJKI98maNvOVTVieNE7UX6qtT6yN8sH58rB1.aIrqUSaKa
 pXPntGU6sW8dGBTOC2xFM90vDLuUJtyai4vBHdY6gMFLqbjYHnOWr7F1s16DtOFBB494Ps5hG8OR
 Sr6rsh2R4ZbNnXUDRI4jV5rwFwrAEPgXRVrIiD5lUT2mP9cdZMhltpzVEERl4v.iM9vAtBp0MWU6
 tV6EpSHxJHD3IyVm39N_wlIeU7jWJDpswenIwkySsJ915eNqKXvlmGxS_5EUPJk6yrg9.1xRPu3m
 .Bz18k5voFfg3Zu2WFcg6H3.E2mAkj3PWDqN8gkOQRKsd16iEFf3a0q4gqQpK2tYbH6WAnDJDIGl
 9ibgX2NzaJZ2OSTll6Mrrx9QBAYRvQH3yWjDU
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Mon, 3 Jun 2019 22:23:11 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8830bf5b93404fe5ac03dc1243e600c9;
          Mon, 03 Jun 2019 22:23:07 +0000 (UTC)
Subject: Re: [PATCH 22/58] Audit: Change audit_sig_sid to audit_sig_lsm
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-23-casey@schaufler-ca.com>
 <201906011900.143B72A@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <79cc3300-450f-5263-9b81-3186f84010f5@schaufler-ca.com>
Date:   Mon, 3 Jun 2019 15:23:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201906011900.143B72A@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/1/2019 7:03 PM, Kees Cook wrote:
> On Fri, May 31, 2019 at 04:09:44PM -0700, Casey Schaufler wrote:
>> Remove lsm_export scaffolding around audit_sig_sid by
>> changing the u32 secid into an lsm_export structure named
>> audit_sig_lsm.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/security.h |  7 +++++++
>>  kernel/audit.c           | 18 ++++++++----------
>>  kernel/audit.h           |  2 +-
>>  kernel/auditsc.c         |  3 +--
>>  4 files changed, 17 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 40aa7b9f3c83..e76d7a9dbe50 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -93,6 +93,13 @@ static inline void lsm_export_init(struct lsm_expor=
t *l)
>>  	memset(l, 0, sizeof(*l));
>>  }
>> =20
>> +static inline bool lsm_export_any(struct lsm_export *l)
>> +{
>> +	return (((l->flags & LSM_EXPORT_SELINUX) && l->selinux) ||
>> +		((l->flags & LSM_EXPORT_SMACK) && l->smack) ||
>> +		((l->flags & LSM_EXPORT_APPARMOR) && l->apparmor));
>> +}
> All of these helpers need kerndoc.

Point.

> Bikeshed on naming:
> - struct lsm_export renamed to lsm_secid

I want to get away from the expectation that what an
LSM exports has to be a u32 secid. It's not in any patchset
yet, but I plan to replace the Smack u32 with a struct smack_known *
at some point in the future. That will require a little work
in the secmark code, but will have significant performance
improvement in audit and UDS.

> - lsm_export_any renamed to lsm_secid_defined() or ..._is_set() or
>   ..._non_zero() ?

I'll admit lsm_export_any() isn't a great name. The state it has
to convey is "some LSM has set a value, and it isn't an error value."
Like "secid !=3D 0", except that it matters whether the 0 came from
secid having never been set, as opposed to it was set because something
went wrong. At the same time, I don't want it to imply that the value
is set for all LSMs, because it may not be. That's why I used "any".
Some LSM *has* set a value. That value may not be the one you're hoping
for, but you may need to call the subsystem (e.g.audit) that's going to
look.

Maybe lsm_export_is_interesting()?
I'd love to discover there's a convention I could adhere to.


