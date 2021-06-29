Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8980C11F69
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 20:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9436861DC2
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 20:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhF2UbD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jun 2021 16:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235520AbhF2Ua6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Jun 2021 16:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624998510;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qe7cO7mpeKYSPAW3JclQzTAT82wV6nS1Y2KDeR28ebA=;
        b=Kr+qb14e9W1nLqcV7B8Y04b6qeAxD7lMiT17RZBFUxb6HEhF1t/dY/jMivEB1kUyotTg8F
        rN1r8wmiFf2PNuaOHzLyGGblmok4rIWX5unkm70CtkBkPZskez2DD5poRF6dCn0Spam6T4
        /wemQW2SiD1mmyrKyYU6BAja7YHJO58=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-vsB6iu8hNxGXXQd_jU9XjA-1; Tue, 29 Jun 2021 16:28:28 -0400
X-MC-Unique: vsB6iu8hNxGXXQd_jU9XjA-1
Received: by mail-qk1-f197.google.com with SMTP id o189-20020a378cc60000b02903b2ccd94ea1so21670461qkd.19
        for <selinux@vger.kernel.org>; Tue, 29 Jun 2021 13:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Qe7cO7mpeKYSPAW3JclQzTAT82wV6nS1Y2KDeR28ebA=;
        b=Bn/dBgLXzgpdNmEik4EGa9Ivkchpcc8ne1jTVFeEHC1Mj5+Ir8obEKUZDDjI5BhtOK
         kncEgMX3Tngq19JLKFkfczDvVGiEre1th9zQ5AvF+oOCK+0DRvCl0uFTy1rym8ZKA8aj
         eaSlxTq9NK0rf4XXNxHYsh3ogsczUWN89MTQEt9GNFSXf7JK6yoqHOPi1cdNKGPpGb8I
         7u5BOXmu/LICFRTNahhTPTZhRsmTR7RBtfRTbthcW1IgPAXc8c717Ny2dacHBbrF8vAw
         PxD+KYK5hgayRaKTKh3eBFD7ajTmJbGD/GkdPlCMq513wt38otS2ZY5wHQ+NFEIecnQ7
         uT3w==
X-Gm-Message-State: AOAM530fSa+5EyBQCJgJvpbHj6mugKLLQ19/Z9Y5vL6G+F0GFywfzuIz
        oUZqnIKwgodpnrR54FuPBY5Gn4p+zXZqy5uHIZT64mdg5xcilPz0NJYnERw6bHbc5k20xZem21k
        4mIzCKTgr4PjCsa39lN4sajeMMW47yE6ICQ+PfhfvNiJ9//WQJSj7rI1Ep0CRcvsNtqI=
X-Received: by 2002:a37:5646:: with SMTP id k67mr32407699qkb.333.1624998507581;
        Tue, 29 Jun 2021 13:28:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+y8RUwhLqAwixJVYSR0nEBkuaoQfKDwogR7bN19ijIyOgKyo2J6TkvVQredHzeCKP9yFU8A==
X-Received: by 2002:a37:5646:: with SMTP id k67mr32407667qkb.333.1624998507292;
        Tue, 29 Jun 2021 13:28:27 -0700 (PDT)
Received: from localhost.localdomain (cpe-74-65-150-180.maine.res.rr.com. [74.65.150.180])
        by smtp.gmail.com with ESMTPSA id k19sm8094710qta.90.2021.06.29.13.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 13:28:26 -0700 (PDT)
Reply-To: dwalsh@redhat.com
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
To:     Vivek Goyal <vgoyal@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
References: <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
From:   Daniel Walsh <dwalsh@redhat.com>
Organization: Red Hat
Message-ID: <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
Date:   Tue, 29 Jun 2021 16:28:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629173530.GD5231@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/29/21 13:35, Vivek Goyal wrote:
> On Tue, Jun 29, 2021 at 09:13:48AM -0700, Casey Schaufler wrote:
>> On 6/29/2021 8:20 AM, Vivek Goyal wrote:
>>> On Tue, Jun 29, 2021 at 07:38:15AM -0700, Casey Schaufler wrote:
>>>
>>> [..]
>>>>>>>> User xattrs are less protected than security xattrs. You are exposing the
>>>>>>>> security xattrs on the guest to the possible whims of a malicious, unprivileged
>>>>>>>> actor on the host. All it needs is the right UID.
>>>>>>> Yep, we realise that; but when you're mainly interested in making sure
>>>>>>> the guest can't attack the host, that's less worrying.
>>>>>> That's uncomfortable.
>>>>> Why exactly?
>>>> If a mechanism is designed with a known vulnerability you
>>>> fail your validation/evaluation efforts.
>>> We are working with the constraint that shared directory should not be
>>> accessible to unpriviliged users on host. And with that constraint, what
>>> you are referring to is not a vulnerability.
>> Sure, that's quite reasonable for your use case. It doesn't mean
>> that the vulnerability doesn't exist, it means you've mitigated it.
>>
>>
>>>> Your mechanism is
>>>> less general because other potential use cases may not be
>>>> as cavalier about the vulnerability.
>>> Prefixing xattrs with "user.virtiofsd" is just one of the options.
>>> virtiofsd has the capability to prefix "trusted.virtiofsd" as well.
>>> We have not chosen that because we don't want to give it CAP_SYS_ADMIN.
>>>
>>> So other use cases which don't like prefixing "user.virtiofsd", can
>>> give CAP_SYS_ADMIN and work with it.
>>>
>>>> I think that you can
>>>> approach this differently, get a solution that does everything
>>>> you want, and avoid the known problem.
>>> What's the solution? Are you referring to using "trusted.*" instead? But
>>> that has its own problem of giving CAP_SYS_ADMIN to virtiofsd.
>> I'm coming to the conclusion that xattr namespaces, analogous
>> to user namespaces, are the correct solution. They generalize
>> for multiple filesystem and LSM use cases. The use of namespaces
>> is well understood, especially in the container community. It
>> looks to me as if it would address your use case swimmingly.
> Even if xattrs were namespaced, I am not sure it solves the issue
> of unpriviliged UID being able to modify security xattrs of file.
> If it happens to be correct UID, it should be able to spin up a
> user namespace and modify namespaced xattrs?
>
> Anyway, once namespaced xattrs are available, I will gladly make use
> of it. But that probably should not be a blocker for this patch.
>
> Vivek
>
All this conversation is great, and I look forward to a better solution, 
but if we go back to the patch, it was to fix an issue where the kernel 
is requiring CAP_SYS_ADMIN for writing user Xattrs on link files and 
other special files.

The documented reason for this is to prevent the users from using XATTRS 
to avoid quota.

The CAP_SYS_RESOURCE capability is denfined to allow processes with this 
capability to ignore quota.

This PR allows processes with CAP_SYS_RESOURCE to create user Xattrs.

To me this makes sense.

Is there any argument against this?

