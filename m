Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A590C3F68F
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 16:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FFE206ED
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 16:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dU204d41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgAJQob (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:44:31 -0500
Received: from sonic305-8.consmr.mail.bf2.yahoo.com ([74.6.133.47]:33934 "EHLO
        sonic305-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728837AbgAJQob (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 11:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578674669; bh=Z0yAe2gY+3u+oE07I9zx18MKpLJ8oAZm58GdLltCZbU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=dU204d418tuy5YC9SukmB4WpIhZTc09hVijV2EToUSHvFQNrJzERBuzQ991JxWe2tuiXFvpOKA9CJqPMVffg7kcZsNSQpO/+cPdt97oACeuSQ7bs3RaMStbekGeU+gh2dTj9f634Nb+nrDPJ4jY/CRmPDx461KNC6koGuO1rEVcb3O2Cdz26DQElxvdhy7OYsNqSUCQBkjxkgYVhfkljmdTH8trIaAVJXbcnlrbcmDi4Bw4VEaxXOIWkZsEBIHIzDQ3qHbaAkCGk/VnwOrTmbDK9g8kKW3zb1PLCCGeB0I59odURtkXy3Zgo0D+cyqoK0YDpOqEBLzCnawhU6Ukq4w==
X-YMail-OSG: eYJYnTsVM1nJy_nknd8jH_mItjhx1K6SWm73ZLdtdAuKOcMesbzqrDwM9jicR9y
 azkI0xpLtlaUNYDeM0n4BDl7lyMCEzK50jWo5oecv97FPMhFBGmU7DNI4h7nS6Vdf3UJUHjyfSf3
 WIZHmvWP3gRKqM_qbjm7CzicQKjs4NBUMpW29vNYkAa2uLJ67l8W8D6Q8xdWKkHzaYr0u6tzoEAu
 PHuzif.0DYGlYWRZvqooT1DG0Q.LfzK.SqqZNEJe.odzy8Xiu0LC9NzFT76Gvrk.t3yvFEZ2j6D2
 y.bZzc.hXh3DFKoLOajK0brzJTLBv8FNeVNHVSxBpeBZtAbdKxRA.vW1EDTDKwJK4hRDUwhGRJMu
 g8h6jjv4G5QHC4IP3rGE3Pa.gMa2Wab_23ATHzXdVAujvkCKaq49vIcap6Q_oeGaq.sy56TGCnrc
 ZNA.UB4eqliPSBQSpmwLIw_TDdY05x6NYYgFirjUJGqp9NwLMjy1i9QSAvgkzSu5azFpGdsf3RBG
 Ayl_Rbn6Hbl_Sj8egEDv7C9cwj82AixwnE10wzzpdYB97bWU7F7kU2jDC7AS2NBH37ez_ewNb96h
 wP69EE06w2NDcm7Hc7TO3I1sAPo20VH6ttYlyMZi8EkdyMgy9SkLWk.7xaADV9CySlB7x6rHRGZB
 sByOEq3FEWDicJVB6A6.M.aF6cF7P7PNo87qwFzxeXy32OobHdIqLdyrmc8u53z8R8as4A_jIyxt
 cc_6yEqtkVVBYXBF3UW2UZX13GjawCwGDdUSI_MVHG5kq_c0JlYb0cr1PV7f4rrCTdC3i8XFqoqW
 iXlKULZGEEcG8HAb7c0sI2w7rOA8J765GhpSxtLvwkDjNbzDVy.eLN_4pNLyzG96EDMb7QeIgHPE
 VS90rm_iRw8jWMZioAOgmbdW47zVWB4nhUhRAUAuhEHwuDn5fr.wdVi4TpnoMsYAAtBw3qvCdw4L
 WFxl_tuoXEa1kRwyvYFRB8t2Xt5ynTHScMuT_QchzUd6k1OGxY2TDmcWx8srAtCOzjrHsLA_n50I
 53vbbHAfQ6R3IUdAJVW7mQpj5oAYyc.uCaIXPMYZ1HpQI0wwjM2YFOPZusBISTvr2CBBJ4TamQjN
 3t3C2RZHvFHg4PK76an0Y_azin4g4AzU1MU16z4dA_EQyiRctODxFsczgqnlgBE71VSadWbhd37R
 2im95d3wxf5ljDdvrUZ0Gk.L8zoAyyAWd3D0HdWtOAFRBr55LVrc_UtrEWGCTedmxmDXyZD8QUXL
 S2gUV26dOSItYCbpk.AsumNmf8_SnC_UnoBJPhRK.Ast6CUliX570tekXA8x9cX2m12kYayPJUvq
 TRU5Ga8URHUpyUcCZvMUQlI3Pi4fJiRMrcbwRhkUCWLZ0aoYYYmigDTjqAPRZ3SUj5VZ1mUORvYp
 8rhJmESc6vD6_Gy0VIgsMt0LKmSw_wi9mjkBZR5hm
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 10 Jan 2020 16:44:29 +0000
Received: by smtp402.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8fd6bc7821c9c5592201a3e5de6585b4;
          Fri, 10 Jan 2020 16:44:26 +0000 (UTC)
Subject: Re: [PATCH] selinux: remove redundant msg_msg_alloc_security
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Huaisheng Ye <yehs2007@zoho.com>, paul@paul-moore.com,
        eparis@parisplace.org, jmorris@namei.org, serge@hallyn.com
Cc:     tyu1@lenovo.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200110095856.76612-1-yehs2007@zoho.com>
 <e71932ce-0687-02e5-5f34-980c0cad4ae9@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <e556e93a-9e2c-8045-b191-629f78dbb7fd@schaufler-ca.com>
Date:   Fri, 10 Jan 2020 08:44:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <e71932ce-0687-02e5-5f34-980c0cad4ae9@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/2020 7:13 AM, Stephen Smalley wrote:
> On 1/10/20 4:58 AM, Huaisheng Ye wrote:
>> From: Huaisheng Ye <yehs1@lenovo.com>
>>
>> selinux_msg_msg_alloc_security only calls msg_msg_alloc_security but
>> do nothing else. And also msg_msg_alloc_security is just used by the
>> former.
>>
>> Remove the redundant function to simplify the code.
>
> This seems to also be true of other _alloc_security functions, probably due to historical reasons.  Further, at least some of these functions no longer perform any allocation; they are just initialization functions now that allocation has been taken to the LSM framework, so possibly could be renamed and made to return void at some point.

That's something I've been eyeing. I'm not 100% sure that no module will
ever fail doing the new style initialization. The int to void and name
change will probably happen after the next round of modules come in and
we can see that failure of initialization isn't a rational situation.

>
>>
>> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>
>> ---
>>   security/selinux/hooks.c | 17 ++++++-----------
>>   1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 9625b99..fb1b9da 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -5882,16 +5882,6 @@ static void ipc_init_security(struct ipc_security_struct *isec, u16 sclass)
>>       isec->sid = current_sid();
>>   }
>>   -static int msg_msg_alloc_security(struct msg_msg *msg)
>> -{
>> -    struct msg_security_struct *msec;
>> -
>> -    msec = selinux_msg_msg(msg);
>> -    msec->sid = SECINITSID_UNLABELED;
>> -
>> -    return 0;
>> -}
>> -
>>   static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
>>               u32 perms)
>>   {
>> @@ -5910,7 +5900,12 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
>>     static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
>>   {
>> -    return msg_msg_alloc_security(msg);
>> +    struct msg_security_struct *msec;
>> +
>> +    msec = selinux_msg_msg(msg);
>> +    msec->sid = SECINITSID_UNLABELED;
>> +
>> +    return 0;
>>   }
>>     /* message queue security operations */
>>
>
>
