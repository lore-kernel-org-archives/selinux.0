Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D464C433DB
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFE023A69
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 14:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbhANOX0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Jan 2021 09:23:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbhANOX0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Jan 2021 09:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610634119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbA7+M7N7BCmNRVplbM96pEQ/yIdTMrfouckwkGTKVE=;
        b=TX+0FWbxFvucRw6ifGTbEvA954mgN2RPElCX9DNZ9lq+z8NKqYX9p/ASMm9tw+s8M25S5x
        xuGkZHKOklhlVn1hwoHbMiQNifZ1phHv83UoKqbY+ud7of49OkksooykD5VMZb2O7BPVt2
        VPNF2EHWqmgpqUg5BWPN6/chjccAlR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-6YIEeP3fPFGKoY-9qcGBtQ-1; Thu, 14 Jan 2021 09:21:55 -0500
X-MC-Unique: 6YIEeP3fPFGKoY-9qcGBtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C97768066E0;
        Thu, 14 Jan 2021 14:21:54 +0000 (UTC)
Received: from localhost (unknown [10.40.195.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 542CC6F440;
        Thu, 14 Jan 2021 14:21:54 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: can't unmount /sys/fs/selinux
In-Reply-To: <87k0sga1jl.fsf@redhat.com>
References: <87wnwga4wm.fsf@redhat.com>
 <CAEjxPJ6jqHX+bSwLoKratsBD47_WNAoQ4OQQN9yWcMzTRoMbzA@mail.gmail.com>
 <87k0sga1jl.fsf@redhat.com>
Date:   Thu, 14 Jan 2021 15:21:53 +0100
Message-ID: <87czy7a9a6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
>> On Wed, Jan 13, 2021 at 4:52 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> we have few tests which uses `umount /sys/fs/selinux` trick to check how
>>> userspace works in SELinux "disabled" environment. But it's not possible
>>> with the current master:
>>>
>>>     # umount /sys/fs/selinux
>>>     umount: /sys/fs/selinux: target is busy.
>>>
>>>     # lsof /sys/fs/selinux
>>>     COMMAND      PID     USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
>>>     systemd        1     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>>>     systemd        1     root   55r   REG   0,21        0   19 /sys/fs/selinux/status
>>>     systemd-u    875     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>>>     systemd-u    875     root    6r   REG   0,21        0   19 /sys/fs/selinux/status
>>>     dbus-brok   1116     dbus  mem    REG   0,21        0   19 /sys/fs/selinux/status
>>>     dbus-brok   1116     dbus    5r   REG   0,21        0   19 /sys/fs/selinux/status
>>>     systemd-l   1134     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>>>     systemd-l   1134     root    4r   REG   0,21        0   19 /sys/fs/selinux/status
>>>     systemd     1643     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>>>     systemd     1643     root   28r   REG   0,21        0   19 /sys/fs/selinux/status
>>>     (sd-pam)    1645     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>>>     ...
>>>     sshd      218874     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>>>     sshd      218874     root    3r   REG   0,21        0   19 /sys/fs/selinux/status
>>>     sshd      218880 plautrba  mem    REG   0,21        0   19 /sys/fs/selinux/status
>>>     sshd      218880 plautrba    3r   REG   0,21        0   19 /sys/fs/selinux/status
>>>
>>> It seems to be caused by commit 05bdc03130d7 ("libselinux: use kernel
>>> status page by default") which replaced avc_netlink_open() in
>>> avc_init_internal() with selinux_status_open()
>>>
>>> In case of sshd process, /sys/fs/selinux/status seems to be mapped by
>>> selinux_check_access() which is called from pam_selinux and it's left
>>> open as there's no selinux_status_close() in selinux_check_access().
>>> The similar situations probably happen in systemd and dbus.
>>>
>>> So is it expected? Is it a bug? Do we need to change other components so
>>> that they would call selinux_status_close() when they use check access?
>>
>> What if we just close the fd after mmap and not keep it open?  I don't
>> see any use of selinux_status_fd beyond assignment and closing.
>> Tearing down the mapping and re-creating it on every access check
>> would defeat the purpose.
>
> Thanks for this hint! I've checked mmap(2) and it's there: After the
> mmap() call has returned, the file descriptor, fd, can be closed
> immediately without invalidating the mapping.
>
> I'll try it tomorrow.

https://patchwork.kernel.org/project/selinux/patch/20210114133910.282686-1-plautrba@redhat.com/

With this patch fd's are closed but the mapped memory is still there:

    # umount /sys/fs/selinux   
    umount: /sys/fs/selinux: target is busy.   
       
    # lsof /sys/fs/selinux   
    COMMAND   PID            USER  FD   TYPE DEVICE SIZE/OFF NODE NAME   
    systemd     1            root mem    REG   0,21        0   19 /sys/fs/selinux/status   
    systemd-u 363            root mem    REG   0,21        0   19 /sys/fs/selinux/status   
    systemd-r 393 systemd-resolve mem    REG   0,21        0   19 /sys/fs/selinux/status   
    dbus-brok 432            dbus mem    REG   0,21        0   19 /sys/fs/selinux/status
    ...


For now we have a workaround for our tests - `umount -l /sys/fs/selinux` works.

But we should document the side effect of selinux status page change in
release notes if there's no better solution.

Petr

