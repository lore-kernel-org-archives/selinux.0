Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55050C31E5B
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 17:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B1A2084E
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 17:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Dqwa0VZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbfFSRgP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:36:15 -0400
Received: from sonic316-12.consmr.mail.gq1.yahoo.com ([98.137.69.36]:42049
        "EHLO sonic316-12.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfFSRgP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 13:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560965774; bh=M8JeyNZutDxT4NYdywJFnxRlctNbinC7V9sASj8f8vc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Dqwa0VZlpOc1YPBxgsIx4McrdfdJb1G/j5W6XmS1tdwjS6RW0FFLIE/EYx8eyyXocpSbf4a9u4dxTB1leqxOYZ4ZQqX/0G3MEIFaS8xAXH4ITPkQEiCmDy3wXXy6kRumQ/H4R4Y7C0DXg2RUkcYMjpRMgU/8iZGzCAd/qAP2zXpahKbU1lKmXv0UTsIHpgZI30dBz19pm4AfwUPWdLp1ibwgHVu+LPFbFsiOOueeSEEk/4B5sYFoZzGgJWeHdmiMziTAhGdlQYFtn3gjgGmFu29LfkVpJmBFY8gxo/GkFqVixh+u7KrMEfZCFq23GTXFvvVKD6Z/Y+7tb/RcZzyXug==
X-YMail-OSG: CvPTCI0VM1nxtwkQoVCosEyDUqAkOiwyptcI3eAWuJ45QLrWKjsuiGAI8Psv.Jj
 4nsquehC0pDoB4XGD5yyZrIiu9Q65_7Qwybf7BZ5tdOHyEII8VbGzaeqtfeYtdmkUk1QGnv4e.JP
 frr7qs5sD8ZIOkCX9nKg76Bqln8erxQAV8szrBmq__5VkHhXOAmvDKLO_HJWAkIrXLyRmigt9Dz3
 7HRSH5qQbXCdXHB7kfIoOXUhdpIT_Yif4DyxdZ08od8b5H5HSoxcXh4O91gMpHiwKY0T.0Arh3Nl
 cvHhVWUGOxqTHjSIa7fxjr9JvjN_xs9Z.azEENvB29sbR6F55yoP0UlYOtp0AU3LRbq2i92H9fQP
 YMgABGHLdqVDEApxthDLCJYsPP.ltA9nfir6k8oGFeJG4IWlB3zJvsDbDWqvRAANPWvKUqDdF1Nj
 utkppsBXubuTuWwORcCfM73SJn0nlrX09oIjXJnoEnrBQv8KLBze95_rNaFB6rzebRD14c9ZRk3Q
 cKj3XbCJjKT6ztkNKIpO9g4mn49VRc0ifDAFYtVq0OrY4vfceaNPKJFMdTw_EaPXonQAMnW9iTKm
 vslhMWi24qBjIMkF9FIQprPVHnzHVPuM72cgaE9ob_01GrRj4xfDl4zIhigdi1MBdN2xU9Nr_C25
 O0IRUJrWi0l8HwPtcpbpj7djcj_m6mJdDzs.7EGoV6BCiSadYKGFQg3aR.GFgElv5UK0gUQADu.v
 xoIiSlYZs1XzeDSb9M0kfMQnpn0OzTNJAmOWxBxs.aPzT0nYv_DLknX0HHTHghJWymMAtGclVIv.
 mkFQ1tjO1vT6r.KM0Ivw05fIR7mgrHK_ufrPLmmnj9RyaquwRNw.RRzuGpxexVpX7ZhrknGiY4_X
 MlKNj4kUf8VKz2yWbYIHmd_jjkbPY96CtSe6Ze17uLJ8Ko9b6jl8_XQgH7q5dnGO5RILgJTVOpLj
 2aeogM0s.yyxwgPS.IlfPg2BqltHxMvaQp0RK_cpw1IO2TaFVevi5pAz_VzGF1HtRmTeQhsk6wfl
 IG29ptq9QbOO1zLUEWbhD_r0lsCmXyF8Uwd2JuItZPtdTEg1JV9nIMd2qhPWi6ooAF8.ZQBseMPC
 ymxXqrbKTV_bGCWbkzjo6RChRsjl2tDvpSjiH6GdMWmlBJxJqhLJctLspJw4bi51nhDLflCCK09O
 Kt.rVPZjyU_qtVS5zbIDhbOt61HEcHt2.RINYwY4HDJiqTBAKzLVhYAJ1ixXvUijbovmfAp5KmKe
 G6z7GXKNXZaBqMZBNJhZ3D6XGSUe85lpItjvgTA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Jun 2019 17:36:14 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 399fd95823ec0b6d81940d5ebc07d0d0;
          Wed, 19 Jun 2019 17:36:10 +0000 (UTC)
Subject: Re: [PATCH v2 24/25] Fix slotted list and getpeersec_d
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-25-casey@schaufler-ca.com>
 <201906182250.02BF2E47@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <0261afc4-ec88-788d-8800-c2bc51dcded0@schaufler-ca.com>
Date:   Wed, 19 Jun 2019 10:36:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <201906182250.02BF2E47@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/18/2019 10:50 PM, Kees Cook wrote:
> On Tue, Jun 18, 2019 at 04:05:50PM -0700, Casey Schaufler wrote:
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Was this supposed to be folded into patch 4?

The first hunk, yes. I'll do that in the next revision.

The second hunk I'm still debating whether this is the
right change, or whether the AppArmor socket_getpeersec_dgram
stub hook should just be deleted.

> -Kees
>
>> ---
>>  security/security.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/security.c b/security/security.c
>> index 5a23ccec7c7b..8aca43ab3e81 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -461,6 +461,8 @@ int __init security_add_hooks(struct security_hook_list *hooks, int count,
>>  		    hooks[i].head == &security_hook_heads.kernel_act_as ||
>>  		    hooks[i].head ==
>>  			&security_hook_heads.socket_getpeersec_dgram ||
>> +		    hooks[i].head == &security_hook_heads.getprocattr ||
>> +		    hooks[i].head == &security_hook_heads.setprocattr ||
>>  		    hooks[i].head == &security_hook_heads.secctx_to_secid ||
>>  		    hooks[i].head == &security_hook_heads.release_secctx ||
>>  		    hooks[i].head == &security_hook_heads.ipc_getsecid ||
>> @@ -2269,7 +2271,9 @@ int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
>>  			     list) {
>>  		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
>>  						      &l->secid[hp->slot]);
>> -		if (rc != 0)
>> +		if (rc == -ENOPROTOOPT)
>> +			rc = 0;
>> +		else if (rc != 0)
>>  			break;
>>  	}
>>  	return rc;
>> -- 
>> 2.20.1
>>
