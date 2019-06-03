Return-Path: <SRS0=Kl1g=UC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BAAC28CC6
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 20:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7159726894
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 20:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LWgPBcYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfFCUIP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Jun 2019 16:08:15 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:34825
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbfFCUIO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Jun 2019 16:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559592493; bh=j0VQaJyxJfzr4oHwrwrbTjO4Ab5dsMmbOonZ2doB9Jc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=LWgPBcYUxmss48CvXeK0b3Kih6a71ajN+mdx1PwOVhjvgLVq0hWGT9+wCsiK+/B7oVeXqw5Ps2/TnovHajPlhOfWz+x+H48jA824ViGTzPcjNKRaUji468zQjJmxp3mXrNkOlnNADTZZfvTzBaDuCcM7VSW2vWTRf0EhOeWrCd7YnPdQ4Gvnujzo3uE086MeZrhx0lJtxaH0Ly5JDf0oMJAifRdy4kJqrX7SrGI3UBN/i8xkhsfq73GiW+KE4dQzyt8QsjNwdUkvwFTEBcAvMBdE7dvbvpp+Pq5eM6/e9hQtK7Ar9lEXIUpGtrSywRovSC0jidKFwsaUHqubPEmkNQ==
X-YMail-OSG: nc.9NQgVM1n_Sfe4fkgaCUIWPH0zqXuJnUBx4wTRQxWouCPFqHgwDRAhYwjomVf
 dLdftu0UsmSYW3ah2DHg4hMzUrdIDAgcM_0W7gmB3KYYUjaq_2OoQM645AGLLdncGRVcQC1eMM9i
 7LY_VjXpVK7mUF3lUGKgIsub3k_ikz0.3JD4SzD1Z8tPylNUabMvPmzRPtWoOcleDLeM5l973964
 iiPGJ13PF9XTYe_DbzRh2Z.bBuGRJ92TxBPA9o.goVMR.rFjfUu9jhk8zryLuPjcEVtngA9u5xmz
 AK06yG7JutpnPDk4qY0E.D2xPDTEIA0l3lPuE9P1Ppi6cvt5Np605ZqeJY0srm5G30IrUl_QhL6g
 5Q2qFk5_qV1kb.l9yPI0WzAOZJY0Cxuwj4O8TThNIhd7s8AMLio6UIS_M5zNP01F3enCVoh2MYG6
 OlLUtAdGuXdqJ4qfULCm5K9GGJQ8UtUc9_Gcki0aGE50WkvitYNPjHyGHwib_A6TwxGShgudtiMn
 rSIqEzJsb4L_vtfCzDIwW5VKgW8fGPgPiROFYSCu9foFoheQ27ofPRqehVgOAKvsawHjszIZMWXO
 Gi07q97C94.w_pKHx2TKO1fgdpAMKN0CcKenVIBTdsXl4Ggr4KUdJSsbr0YpyP4fkrQDTxHs3NJp
 l7tLPqxsBVSutqEzF_6D7lXfGtZH6KgY8wMyccFL75NQZTWudVBjaH3T_m5qPOe7J0y1Gh1Led8O
 mqgoB0ow7AaYqrsM8LmyKnTlpTWdoX43JXzaWejEhuPySTbPbcih53gVycbG096Piji6q_9qeVCy
 GkqwOTSKHTlWAppcYtjhAC5GXrVGOyFOyc02X8bBrRcM.h49bJPuLTiO9qoIJirr2cyCGk1GSNYq
 ibdQ1R02E4yKGVU0BABv4T1z_x8pA_iRx51Mtg8lLkjsfGvncXh9FTfKRjbA0OjNvbl_HKtZetq2
 jfS4mSeWpScxxPuF6qXlbQozGfJOieMq3ey7kz8VHIvavjmHHL_S7f4qdfG0.7B2XLba2Kec13rg
 PU1R3M9Q6urJ2kXc6pg1W8MveL0NSFli8zZ1ROEy3UCsHFhVDlK4OtMJ1fRmGqfqi_QSQJAazB5o
 TF4f67yjRatGHQO8svs8KIICgZWCnS6ycWarYfGrgtt8z3btBGQarVrEa2N_lwlgfyZUS1S4OkJu
 R.dQVYoBdFE7MzsD0KomdYhFJ4OQCnYJKj0AMms4MonG7I8V5QU0VNbVKOob9WfVE8MJnsE6Hkr2
 bScavmkB3iWnkRK5SmP35ybNsIg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 3 Jun 2019 20:08:13 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 02b499d82f272b8d2437882bc300523e;
          Mon, 03 Jun 2019 20:08:08 +0000 (UTC)
Subject: Re: [PATCH 04/58] LSM: Create an lsm_export data structure.
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-5-casey@schaufler-ca.com>
 <201906010822.03972E152B@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <0bff391c-8e68-10b9-be88-e91ca73ccec8@schaufler-ca.com>
Date:   Mon, 3 Jun 2019 13:07:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201906010822.03972E152B@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/1/2019 8:23 AM, Kees Cook wrote:
> On Fri, May 31, 2019 at 04:09:26PM -0700, Casey Schaufler wrote:
>> When more than one security module is exporting data to
>> audit and networking sub-systems a single 32 bit integer
>> is no longer sufficient to represent the data. Add a
>> structure to be used instead.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Thoughts below...
>
>> ---
>>  include/linux/security.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 49f2685324b0..81f9f79f9a1e 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -76,6 +76,18 @@ enum lsm_event {
>>  	LSM_POLICY_CHANGE,
>>  };
>> =20
>> +/* Data exported by the security modules */
>> +struct lsm_export {
>> +	u32	selinux;
>> +	u32	smack;
>> +	u32	apparmor;
>> +	u32	flags;
>> +};
> I think it might make more logical sent to leave flags at the start.
> While I don't expect to add more fields, I find it surprising that
> it is at the end. :)

Data structure randomization notwithstanding, it
doesn't matter to me, so I'll put the flags first.
This came about because I initially didn't think I'd
need flags, and they were add to the end when I determined
I did.

>
> -Kees
>
>> +#define LSM_EXPORT_NONE		0x00
>> +#define LSM_EXPORT_SELINUX	0x01
>> +#define LSM_EXPORT_SMACK	0x02
>> +#define LSM_EXPORT_APPARMOR	0x04
>> +
>>  /* These functions are in security/commoncap.c */
>>  extern int cap_capable(const struct cred *cred, struct user_namespace=
 *ns,
>>  		       int cap, unsigned int opts);
>> --=20
>> 2.19.1
>>

