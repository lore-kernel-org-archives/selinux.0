Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF928EE3F0B
	for <selinux@archiver.kernel.org>; Tue, 12 Sep 2023 18:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjILSaS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjILSaR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Sep 2023 14:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2227189
        for <selinux@vger.kernel.org>; Tue, 12 Sep 2023 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694543377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CEh9WjnCx9HSNLiFh3Rm1Cv2peVp60ImMUD0LbtxFqQ=;
        b=MTihqq9Zf/Wt84YjaV2jmxI80IA3u0+icAlzt40Th9jM3N792vpsQm02Y2p3fEIZuVudN9
        Pu3ga8nW51esy+U56V8Iz96iJY7sA3oVpG5zvCcTDUOcacEQMfNIa9Au/mut3lPc8DyvJe
        YsRiU7JA3IAIb71oOuDVtYsz2iVgmYI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-HyuRepHvOSK8TOZeqyEW2w-1; Tue, 12 Sep 2023 14:29:35 -0400
X-MC-Unique: HyuRepHvOSK8TOZeqyEW2w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-402493d2997so43103675e9.0
        for <selinux@vger.kernel.org>; Tue, 12 Sep 2023 11:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694543374; x=1695148174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEh9WjnCx9HSNLiFh3Rm1Cv2peVp60ImMUD0LbtxFqQ=;
        b=fqa2AGjqMZ7R5I/i3Misd2McizOYCbmtFka0+K3YeQV1v17G0XyLiCPo2oarh7ATBk
         R2L7LydGSoeEp8ngZzI8u6HHxV8/orwHZx6QA14qtzf3WU9C0lYAY9md+BOGTXiP/slp
         MSXzIYv4yrK9TYnRL4+giVkmGi16N3qYhfPX9VM3vO1Z46OkI7bCdVDjFKSdK4dFAIMy
         jIT8vN0UrO3IF08xYm9pgsqHyV0S9cR80WImUKCBrT6Rdz6fMSdPL7B7niK+L39crdrZ
         VVCgDzrPKhRNe5oR324rwhPCoFVYll2AxKZNl4xsxcIkRGtT7duEQGHNijREmcR+qai2
         7WIA==
X-Gm-Message-State: AOJu0YznQ29qncFjEZHiRZmj/Y+BtKmCS1bDhBSANx1zKhVuteetwm4D
        vd8qUvw+QHOiLhxmty8HXvbiwyhmTih13xlfgEKnkOxgc+a/92eCsAxW0hI+G+oM2mQ3YB8D3+9
        xy3LFHxBBj0bRVyKkQw==
X-Received: by 2002:a1c:f701:0:b0:400:46db:1b68 with SMTP id v1-20020a1cf701000000b0040046db1b68mr224595wmh.35.1694543374229;
        Tue, 12 Sep 2023 11:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv3+XkZqY+KfEiq14+FkFxuU5nrXl05dsJDCNPuc9T7r9LVvQb+FM3mjTT/uDjr6PRPmXdDA==
X-Received: by 2002:a1c:f701:0:b0:400:46db:1b68 with SMTP id v1-20020a1cf701000000b0040046db1b68mr224588wmh.35.1694543373908;
        Tue, 12 Sep 2023 11:29:33 -0700 (PDT)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id j6-20020adfb306000000b003142c85fbcdsm8885589wrd.11.2023.09.12.11.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 11:29:33 -0700 (PDT)
Message-ID: <e26ceee7-3c67-7cf9-1333-2650d1d2734d@redhat.com>
Date:   Tue, 12 Sep 2023 20:29:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: generating new type name using CIL macro
Content-Language: en-US
To:     James Carter <jwcart2@gmail.com>,
        Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
References: <324bb6b0-3d6c-707d-c0d1-1fdc1f43e845@redhat.com>
 <87pm2ouk0s.fsf@defensec.nl>
 <CAP+JOzR7d7RfKWPaTt_BwEbEyWxGQhdnfAQ3fx5itL+xqshTLA@mail.gmail.com>
From:   Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <CAP+JOzR7d7RfKWPaTt_BwEbEyWxGQhdnfAQ3fx5itL+xqshTLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 9/12/23 15:13, James Carter wrote:
> On Tue, Sep 12, 2023 at 1:19 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>> Vit Mojzis <vmojzis@redhat.com> writes:
>>
>>> Hello all,
>>> while trying to recreate some selinux-policy templates using CIL
>>> macros I got stuck on creating new type/role/attribute names.
>>> For example consider ssh_role_template [1], which uses its first
>>> parameter to create a new type $1_ssh_agent_t.
>>>
>>> Is there a way to recreate such functionality in a CIL macro (or
>>> another CIL feature)?
> In CIL we wanted to get away from the m4 string mangling. The thought
> was that a higher-level language could do this if desired.
> CIL is very restrictive in that all the arguments in a call have to be
> already defined. You cannot even pass a string that will be used to
> declare a type--the type must already be defined.

Right, this complicates replicating interfaces even further.

BTW there is no error or warning when passing a string in an attempt to 
define a new entity inside the macro.
(macro define_type ((string t))
     (type t)
     (allow t t (process (setcap)))
)
(call define_type (yolo))

This installs without any complaints, but the type does not get defined 
and the rule gets silently ignored as well.

>
> As Dominick says below, we thought that blocks and inheritance would
> replace the string mangling, but, as you note, this does change how
> the type looks.

Yes, and since that is something I cannot ignore, I'll have to create 
some kind of simple abstraction as Dominick suggested.

Thank you both for the suggestions and explanations, you helped me a 
great deal.
Vit

>
> Jim
>
>> CIL uses blocks for it implementation of templating. If you want to leverage
>> native CIL then look into blocks.
>>
>> Example:
>>
>> cat > mytest.cil <<EOF
>> (typeattribute foo)
>>
>> (block t
>> (blockabstract t)
>> (type t)
>> (typeattributeset .foo t))
>>
>> (block bar
>> (blockinherit t))
>>
>> (block baz
>> (blockinherit t))
>>
>> (allow .foo .foo (process (signal)))
>> EOF
>>
>> sudo semodule -i mytest.cil
>>
>> seinfo -xafoo
>>
>> Type Attributes: 1
>>     attribute foo;
>>          bar.t
>>          baz.t
>>
>> sesearch -A -s foo -ds
>> allow foo foo:process signal;
>>
>>> Something along the lines of:
>>> (macro new_type_macro ((string type_prefix))
>>>    (type (type_prefix)_t)
>>> )
>>> which when called (call new_type_macro ("yolo")) would produce
>>> (type yolo_t)
>>>
>>> I searched through CIL reference guide [2] and SELinuxProject CIL wiki
>>> on github, but didn't find anything close (maybe there is a better
>>> resource I don't know about).
>>> I'd appreciate any hints or links to other resources related to CIL macros.
>>>
>>> Thank you,
>>> Vit
>>>
>>> [1] -
>>> https://github.com/TresysTechnology/refpolicy/blob/master/policy/modules/services/ssh.if#L301
>>> [2] -
>>> https://raw.githubusercontent.com/SELinuxProject/selinux-notebook/main/src/notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf
>>> [3] - https://github.com/SELinuxProject/cil/wiki#macros
>>>
>> --
>> gpg --locate-keys dominick.grift@defensec.nl (wkd)
>> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>> Dominick Grift
>> Mastodon: @kcinimod@defensec.nl

