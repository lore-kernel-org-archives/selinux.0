Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DEECA0EC3
	for <selinux@archiver.kernel.org>; Tue, 12 Sep 2023 09:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjILJne (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Sep 2023 05:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjILJne (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Sep 2023 05:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9125C12E
        for <selinux@vger.kernel.org>; Tue, 12 Sep 2023 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694511767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cVoCYLTcjSC2jc7F8XlWo4MviAe+30+OkqwLC9JYpJg=;
        b=VkEfp4WkVZVeVDjtd2DL2lZvJ8wEeNA2kZJEHugvASJ5woagYeEUqPew+duPorH9D0J8mn
        XPz2iXL7ORAWiCiZfy+ysG/3Ix9oXntDUvcys9Q0XQGqpZBq9OBWR7r092aPt3jWXdiMbI
        ehwEKo3bU4xYeKpnUd7Yz1dPBDIq69M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-yAAzPs0qOMyQ3sNoMLlJ9Q-1; Tue, 12 Sep 2023 05:42:45 -0400
X-MC-Unique: yAAzPs0qOMyQ3sNoMLlJ9Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993eeb3a950so374694866b.2
        for <selinux@vger.kernel.org>; Tue, 12 Sep 2023 02:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694511764; x=1695116564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVoCYLTcjSC2jc7F8XlWo4MviAe+30+OkqwLC9JYpJg=;
        b=W4VyGDhX46XUtAaRUsd9Pfx92JiywtnEPGk8vxKaujo3edgCZMTz6KFxGBMfyAUmfs
         7w5rH8NKvzJAVyE4hlXFYE2mU0flMhXFU8bH6vp+kPfjjN4R7AYuDxBdx2T0b2de1RPu
         3C9joB9Z8JbK5EfzgzJLC3SOUNFpPu+puJZakku0iyRaMyoOEQN0/dUuc61ohtxpvz7s
         40evvd6trbNG2zS7hcuKz/lWkO37rBRhhckJpl6b9EmiU5kLVHtL3BkZi1gh+BU9gY8L
         mE+jr5ujoQIorngq4QeQirjDTtB7j+gn8l7pbeC4+HlPrEIImwg4JxyIgODRRFVBLutk
         hgiA==
X-Gm-Message-State: AOJu0Yw/KR7spn62FWjzr1suoxeW4/zUbw4nXM8DC/sg+M81HxfOO9DA
        p4NMsBDTYsF0HTo3gznNasdSJpSiSjnMNLQaVTJhq61ERyf4GyhNU4yb4vHTBAFbkQG0zF3Or/G
        j+Sm8V0x4jmnkRTjffIoFqNq/Iw==
X-Received: by 2002:a17:906:1db2:b0:9a2:2635:dab6 with SMTP id u18-20020a1709061db200b009a22635dab6mr11392149ejh.47.1694511764330;
        Tue, 12 Sep 2023 02:42:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPwgVxLVLD+LQPjJmM/1pFRmbeUrnulGbof3s1G8w8KCMzvJxdcgUDTLJupnK385ChWnqGzg==
X-Received: by 2002:a17:906:1db2:b0:9a2:2635:dab6 with SMTP id u18-20020a1709061db200b009a22635dab6mr11392139ejh.47.1694511764014;
        Tue, 12 Sep 2023 02:42:44 -0700 (PDT)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id lf28-20020a170907175c00b0099bcf1c07c6sm6573961ejc.138.2023.09.12.02.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 02:42:43 -0700 (PDT)
Message-ID: <84e73105-41b7-22b6-2030-627e0e551684@redhat.com>
Date:   Tue, 12 Sep 2023 11:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: generating new type name using CIL macro
Content-Language: en-US
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
References: <324bb6b0-3d6c-707d-c0d1-1fdc1f43e845@redhat.com>
 <87pm2ouk0s.fsf@defensec.nl>
From:   Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <87pm2ouk0s.fsf@defensec.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Dominick,
thank you for the suggestion. I know about block inheritance, but it 
produces type/role names that are not consistent with refpolicy ("." 
separating the new block name and it's content). My goal is to create 
new SELinux users and corresponding roles and it would be confusing for 
users to switch between roles with different naming schemes (e.g. 
"secadm_r" vs. "customuser.r"). Given that "typeinherit" statements 
don't seem to be supported, I'm trying my luck with macros to replicate 
interfaces.

Thank you,
Vit

On 9/12/23 05:50, Dominick Grift wrote:
> Vit Mojzis <vmojzis@redhat.com> writes:
>
>> Hello all,
>> while trying to recreate some selinux-policy templates using CIL
>> macros I got stuck on creating new type/role/attribute names.
>> For example consider ssh_role_template [1], which uses its first
>> parameter to create a new type $1_ssh_agent_t.
>>
>> Is there a way to recreate such functionality in a CIL macro (or
>> another CIL feature)?
> CIL uses blocks for it implementation of templating. If you want to leverage
> native CIL then look into blocks.
>
> Example:
>
> cat > mytest.cil <<EOF
> (typeattribute foo)
>
> (block t
> (blockabstract t)
> (type t)
> (typeattributeset .foo t))
>
> (block bar
> (blockinherit t))
>
> (block baz
> (blockinherit t))
>
> (allow .foo .foo (process (signal)))
> EOF
>
> sudo semodule -i mytest.cil
>
> seinfo -xafoo
>
> Type Attributes: 1
>     attribute foo;
>          bar.t
>          baz.t
>
> sesearch -A -s foo -ds
> allow foo foo:process signal;
>
>> Something along the lines of:
>> (macro new_type_macro ((string type_prefix))
>>    (type (type_prefix)_t)
>> )
>> which when called (call new_type_macro ("yolo")) would produce
>> (type yolo_t)
>>
>> I searched through CIL reference guide [2] and SELinuxProject CIL wiki
>> on github, but didn't find anything close (maybe there is a better
>> resource I don't know about).
>> I'd appreciate any hints or links to other resources related to CIL macros.
>>
>> Thank you,
>> Vit
>>
>> [1] -
>> https://github.com/TresysTechnology/refpolicy/blob/master/policy/modules/services/ssh.if#L301
>> [2] -
>> https://raw.githubusercontent.com/SELinuxProject/selinux-notebook/main/src/notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf
>> [3] - https://github.com/SELinuxProject/cil/wiki#macros
>>

