Return-Path: <SRS0=MU1A=5P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE4C43331
	for <selinux@archiver.kernel.org>; Mon, 30 Mar 2020 06:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FA820786
	for <selinux@archiver.kernel.org>; Mon, 30 Mar 2020 06:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBO8Ul+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgC3GNp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:13:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38813 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgC3GNo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Mar 2020 02:13:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so16735276ljh.5
        for <selinux@vger.kernel.org>; Sun, 29 Mar 2020 23:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jLzvyQvOYjTk3IL7IL6uXnFn1PRQWqWKhhej8bk5L3Q=;
        b=hBO8Ul+nD3oaR5c+a0LHM9ATeTvNn0xVVuI1So3KofSpmFpIxI6OZbtL/0pWmCNPeK
         pAi4De8sZbpJPmIzPo6X76rvK2gXxkNWJGwB9c9rE/5Q4D6TRIGxBL/6gXFvRPjyf4hJ
         Ue78ea9hwJR1MhYnJB7ZhIEpZu75uIwNU41Ldcdxd4ypmSCHaIvE4Z8Bf1fb7BzkP30m
         +aN4zZJBy3Z6TOQawHthzd28OSC7z0E2ibaxWrDcrArTtIJ7j3UWqOebhDlDN4tL72T9
         SbGe3yraeV1+3+LWupCymUOKqmB4tSGUGYU6EoveS3SywnqJErSbt4HGfLT58hyICisO
         CVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jLzvyQvOYjTk3IL7IL6uXnFn1PRQWqWKhhej8bk5L3Q=;
        b=oPKeO2/cWtxn9skM51SZHdNWj6dlqE8f1Kd/Ks/qipGy0aNuxaA6W23Oksp1umjitk
         Lihs3LJDvoUW2pzA3+w+gnOJLiM3AP0MbPbYCIreEUhICNbHApjiMbA2Ve2vrrPPE+bH
         nZLNmLeIyEeg4HkfnEpmvJogbG8enSIAQtwyEgjnAqpv6IvNbIexTY1aJbVoWrYSfqOB
         kbGBXUoJLxb34u9aa9xW6tm6Y4qWM9qtvoaRBTL9uIrYq7s+PtIrbWG+9Z4ALeLVKWpH
         dNV5+BI84rxF3tXZJT/uTm3+Kiwd7+c30JcuXEX5bsjnXGGTlDK15X4QpkayCJMmEtYM
         +3lg==
X-Gm-Message-State: AGi0PuasFfJZla57JRHEdU1l2nfnGSvTybxG46lKBUadyRV+MNDK0ywr
        KSZhDkn0CGb/BmYdlk8h8YKNBnIm3cg=
X-Google-Smtp-Source: APiQypLOJ2eENszLCpve0Y1n7nirR3jk/mVBK8XJ83yB8umXuXQvLJSii7juM8fJ79xJIZzhaWCeJg==
X-Received: by 2002:a2e:88d4:: with SMTP id a20mr6049508ljk.119.1585548822830;
        Sun, 29 Mar 2020 23:13:42 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id q23sm429532lfj.96.2020.03.29.23.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 23:13:42 -0700 (PDT)
Subject: Re: [PATCH] libselinux: mount selinuxfs nodev,noexec,nosuid
To:     Stephen Smalley <stephen.smalley@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
References: <f4e6ddb4-66ac-45d1-04a6-67bfd9fd225e@gmail.com>
 <ypjla73zwlx4.fsf@defensec.nl>
 <33246601-c460-46c6-6a5a-fbcbd48d2858@gmail.com>
 <CAB9W1A3d7OyJESduertxmr=p0sN5j5JD=q01x8i8Vi5yKhs5Pg@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <50b369ba-cb70-b085-7b12-9c91be6a4e17@gmail.com>
Date:   Mon, 30 Mar 2020 09:13:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAB9W1A3d7OyJESduertxmr=p0sN5j5JD=q01x8i8Vi5yKhs5Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 29.3.2020 23.44, Stephen Smalley wrote:
> On Sun, Mar 29, 2020 at 7:30 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> On 29.3.2020 12.27, Dominick Grift wrote:
>>> Topi Miettinen <toiwoton@gmail.com> writes:
>>>
>>>> Mount selinuxfs with mount flags nodev,noexec and nosuid. It's not
>>>> likely that this has any effect, but it's visually more pleasing.
>>>
>>> will nodev interfere with this?
>>>
>>>     File: /sys/fs/selinux/null
>>>     Size: 0               Blocks: 0          IO Block: 4096   character special file
>>> Device: 15h/21d Inode: 23          Links: 1     Device type: 1,3
>>> Access: (0666/crw-rw-rw-)  Uid: (    0/    root)   Gid: (    0/    root)
>>> Context: sys.id:sys.role:null.isid:s0
>>> Access: 2020-03-28 13:04:05.578999988 +0100
>>> Modify: 2020-03-28 13:04:05.578999988 +0100
>>> Change: 2020-03-28 13:04:05.578999988 +0100
>>>    Birth: -
>>>
>>> /sys/fs/selinux/null: character special (1/3)
>>
>> That device does not give me joy. Yes, the patch prevents it from being
>> used. But I didn't see any problems in the logs, even with something
>> else mounted over it (adding InaccessiblePaths=/sys/fs/selinux/null to
>> systemd unit files). The device file was added pretty early to Linux,
>> perhaps it was needed then, but not anymore?
>>
>> Judging from internet searches, maybe it's only used by Android. They
>> seem to use a forked version of libselinux anyway.
> 
> /sys/fs/selinux/null is used by the kernel; SELinux closes any open
> file descriptors not authorized for the new process context upon a
> context-changing exec, and replaces them with a reference to
> /sys/fs/selinux/null.  This was introduced because /dev/null couldn't
> be guaranteed to exist or be available at all times. nodev likely has
> no effect on this usage because it is probably only checked when a
> userspace process tries to open it.

Perhaps then the device should not be visible to user space at all, or 
at least not usable (which is the effect of MS_NODEV)? The file 
descriptor replacement thing seems to work also when /sys{,/fs/selinux} 
is not mounted in the mount namespace of the process, at least I haven't 
seen any problems.

> That said, I don't really understand what you think you are gaining by
> adding these mount options to selinuxfs.  What threat are you
> mitigating?   It is a kernel pseudo filesystem that doesn't support
> dynamic file creation by userspace and whose contents are entirely
> determined by the kernel.

I don't think there's any change to threat situation (a process which 
shouldn't have access to /dev/null, gains access by using 
/sys/fs/selinux/null? Not very credible) or even any other effect from 
this change, but I don't like it when selinuxfs always shows up when I 
grep for filesystems without nodev/noexec/nosuid. So the gain is visual.

What's the purpose and gain of having the filesystem mounted with 
dev,exec,suid, which for other filesystems than selinuxfs are the more 
dangerous options?

-Topi
