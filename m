Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A0BC4332F
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 14:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjKNOQG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 09:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjKNOPu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 09:15:50 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0BF19B3
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 06:14:42 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41cd8bd5727so32799161cf.3
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 06:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1699971281; x=1700576081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hIR8twVwzjJe7NPxBjfR5NbRAJby3LLAxfSyr8l2Bk=;
        b=a9HWcCEbYdknVLfkYqwWjssvAizzb1U8X9F5DccOf93vDX9GcJ0+akwOrMyBKij8nD
         n8tUE0ZB4wXRUt37eWf3pmyC6ePY0qQNLU/1DeSB18cS2g2VmYGE/tbHDlXLqByij2HU
         Ufr6QaROgDFptsh26/RuLU3ljz+nxuPNuTxx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971281; x=1700576081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hIR8twVwzjJe7NPxBjfR5NbRAJby3LLAxfSyr8l2Bk=;
        b=ff3T2WT8SVPA18TdnJoEQVWU1kWUowrGzxEFoVjbFkBIWLrKWhHbyF7uNQ7d4gpHNU
         p8liiQFJ/WOa6LIn+uhGoojuCyACvxCTLCjs6ZqU+huaqzxV/sHfHygcy49pnEQZ2cAR
         Hve3OlJrXl63ni7w8EQTP+wxtM3jC71XVjqpP0xRxep6w7IWnKSoC4iVFgLl66jNT9n9
         pF5kJqp0Z6g3aDn5QONlls0ea+sAp4eASGchQwoJVNhJ4Fdw33o4d6w64XfWtz5+vIrX
         PVDqzIgjnskY9dKxj+TWGOFvtrxxKYoAo/Q0rgieRcfZ0n908lrcHKO9ULiMddtmWDGv
         ggdg==
X-Gm-Message-State: AOJu0YyxewoR0gBdCzdsDh0sLhxLoIxMoFSpTttgYnckoHikeO5gMYTM
        YdtvPTY3h302PJCA9lGeMLLVcg==
X-Google-Smtp-Source: AGHT+IGLE3djQFKoX1uJZRlxyP60cN3kXryXsjWSEdet5TvjEkYUrNHjdN2dv9v1DM2AXRuyYpJ3Vg==
X-Received: by 2002:a05:622a:1d5:b0:421:b997:968c with SMTP id t21-20020a05622a01d500b00421b997968cmr2846505qtw.24.1699971281401;
        Tue, 14 Nov 2023 06:14:41 -0800 (PST)
Received: from ?IPV6:2601:145:c200:960:39cb:b4c1:b091:2c5f? ([2601:145:c200:960:39cb:b4c1:b091:2c5f])
        by smtp.gmail.com with ESMTPSA id kr25-20020ac861d9000000b00421a0b66bd2sm2757280qtb.4.2023.11.14.06.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 06:14:40 -0800 (PST)
Message-ID: <aee59e7d-2a94-235a-a9dc-e1059660fcc7@ieee.org>
Date:   Tue, 14 Nov 2023 09:14:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Proposed feature: fine-grained file descriptors in SELinux
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Chris PeBenito <chpebeni@linux.microsoft.com>,
        SElinux mailing list <selinux@vger.kernel.org>,
        brauner@kernel.org, bluca@debian.org
References: <da1d9efd-fdc1-4651-8a7a-30ae4a399926@linux.microsoft.com>
 <CAHC9VhSfTDoPee5_qXyh0QpjeMSsx5RmWOQgmk1NGC87kn0nsg@mail.gmail.com>
 <CAEjxPJ7xw=qN9n6qH3=b1a1khisUVVL79pt9tpi319ZViL57mQ@mail.gmail.com>
Content-Language: en-US
From:   Chris PeBenito <pebenito@ieee.org>
In-Reply-To: <CAEjxPJ7xw=qN9n6qH3=b1a1khisUVVL79pt9tpi319ZViL57mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/2023 10:35 AM, Stephen Smalley wrote:
> On Sun, Nov 12, 2023 at 11:52 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Nov 9, 2023 at 1:26 PM Chris PeBenito
>> <chpebeni@linux.microsoft.com> wrote:
>>> systemd is increasing usage of memfds, pidfds, etc.  This is resulting
>>> in a need for wide inheritance of fds across the system.  For example in
>>> a lot of systemd interfaces that have a pid field now have a comparable
>>> pidfd interface.  dbus-broker and polkit are similarly updated.
>>>
>>> Some references from an All Systems Go! talk:
>>> https://cfp.all-systems-go.io/media/all-systems-go-2023/submissions/T3LJAM/resources/ASG_2023_PID_FD-ize_all_the_things_E98Zw9Q.pdf
>>>    This is from a few months ago; the switch to PIDFDs is nearly
>>> complete, and we're already seeing denials for this usage.
>>>
>>>
>>> Since file descriptors are increasing use as references for various
>>> operations, I think it would be useful to have a finer-grained fd class,
>>> so we can limit file descriptor inheritance, particularly as it looks
>>> like systemd/pid1 will need to inherit pidfd file descriptors from
>>> possibly all domains.  Specifically, I propose adding new permissions to
>>> the fd class, such as use_pidfd and use_memfd.  Then systemd can use
>>> pidfds from any domain, but only use regular fds from trusted domains.
>>>
>>> Thoughts?
>>
>> I think adding some granularity to the fd:use permission makes sense,
>> although I'm wondering if we are better served by creating new object
>> classes for these new types of reference fds, e.g. pidfd:use,
>> memfd:user, etc.?  When I read "use_pidfd" my first thought is that we
>> are encoding an object class in the permission.
>>
>> Have you looked at the associated kernel code yet?  I suspect we might
>> need to augment the existing memfd/pidfd/etc. code paths with an
>> additional LSM hook to be able to mark the fd's LSM/SELinux state with
>> class info, but I'm not sure off the top of my head.
>
> We don't actually store SECCLASS_FD in any security blobs currently
> (i.e. there is no sclass field in the file_security_struct); we just
> always check against SECCLASS_FD in file_has_perm(),
> selinux_binder_transfer_file(), ioctl_has_perm(),
> selinux_kernel_module_from_file(). As you note, we don't have a way of
> knowing what kind of fd it is at those points so we would need to
> somehow pass that information to selinux_file_alloc_security() and
> save the class at that time, or otherwise introduce new hooks.
> 
> There are three approaches that could be taken here:
> 1. Introduce new permissions on the existing class, as proposed by Chris,
> 2. Introduce new classes, as you proposed,
> 3. Label different kinds of fds via type_transitions or similar so
> that we can distinguish them by type in policy rather than needing
> separate permissions or classes.
> 
> We've used all three approaches in the past for different kinds of
> checks so it is more a question of what is optimal for this use case.
> The last one is the heaviest approach since it imposes extra overhead
> upon allocation/labeling that doesn't currently exist for fds.

Either new perms or new class works for me.  I like the new classes idea 
more than my original proposal; however, I'm unclear how a 
type_transition would work in this scenario.  What would the target type be?

type_transition foo_t ?:fd foo_pidfd_t;
type_transition foo_t ?:fd foo_memfd_t;


-- 
Chris PeBenito

