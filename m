Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70022C2BA83
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 17:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DCE2168B
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 17:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6cMLBiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgBLROe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:14:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48144 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727054AbgBLROe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 12:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581527673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZlzwEzNiccH3o0niIX8xD7eyzL1HDM0gYSAdm/M/+bg=;
        b=P6cMLBiMj4104Lsx8izYBFc3rdJz+hGSI7rbZ1TYyx7fF9VS08TO5sXjDm4nbGm7nQBWOQ
        Cbp/MTCkuBTL0M7gAac6kT//0oSCbdporqY6JuT/hyheTV/oXMUIiQrj0xbeK6Eooe8jhG
        s+4GiiU8bSkQS6zuoZWV5vh4ObWUhLc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-cBwGwtucOPmAqvBhjIo27A-1; Wed, 12 Feb 2020 12:14:21 -0500
X-MC-Unique: cBwGwtucOPmAqvBhjIo27A-1
Received: by mail-qk1-f198.google.com with SMTP id b23so1776122qkg.17
        for <selinux@vger.kernel.org>; Wed, 12 Feb 2020 09:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZlzwEzNiccH3o0niIX8xD7eyzL1HDM0gYSAdm/M/+bg=;
        b=o27MekrdTXt597PwEfcijnMsmdb34Iro8rupvX4r+cCeyIxVPiJpmuXOwhX8hzbaE8
         gwWH/UBpKy9ug7latZ6d7Cs/WQhSrpdJqtBs1oLXnoMmweeYa4zFrM8FST6drpDCqDEq
         vF9NrlWHm2tQj71r2WsOteBTwHY2Tw4jGiwNcwsrF/T3W1/4Rrkx9ftyZ3DkVAorn3Ln
         7PIv9hdcWZ84jlewLAoHU4J/GD1Ykfly6eHbX4A4mmuRajV0eQIaiklcsHVDs7LEkzdQ
         0gPW8lBe7Pj9ylKs+scZ8BYOTV/uKFpglBnNaV2cJOa59bucMSv3gzXwC/6i8EeSE9RT
         9DSw==
X-Gm-Message-State: APjAAAXaQF0+4pZnld1KsefMeGzehj+LK/PHepG9XozigiRt7Rj4hh1Y
        Y80c4vimSaVAjpLiMWwqihpq5eo8lXKXWoirvuWhh4IrgrYHACPcuAvmAypVhkJoMK2Le9qQ2Uh
        BQGMqf1KhN5q4Lx0XgQ==
X-Received: by 2002:a05:620a:222d:: with SMTP id n13mr11979653qkh.268.1581527660853;
        Wed, 12 Feb 2020 09:14:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkBuso307AexlODAGhzhSt7xIaqCNCooqpP0T3zyoh42+euME4eIvwxrDj9MwaFP9lZlCvOQ==
X-Received: by 2002:a05:620a:222d:: with SMTP id n13mr11979579qkh.268.1581527659873;
        Wed, 12 Feb 2020 09:14:19 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id t16sm511565qkg.96.2020.02.12.09.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 09:14:19 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:14:16 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] Harden userfaultfd
Message-ID: <20200212171416.GD1083891@xz-x1>
References: <20200211225547.235083-1-dancol@google.com>
 <202002112332.BE71455@keescook>
 <CAG48ez0ogRxvCK1aCnviN+nBqp6gmbUD7NjaMKvA7bF=esAc1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0ogRxvCK1aCnviN+nBqp6gmbUD7NjaMKvA7bF=esAc1A@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 12, 2020 at 05:54:35PM +0100, Jann Horn wrote:
> On Wed, Feb 12, 2020 at 8:51 AM Kees Cook <keescook@chromium.org> wrote:
> > On Tue, Feb 11, 2020 at 02:55:41PM -0800, Daniel Colascione wrote:
> > >   Let userfaultfd opt out of handling kernel-mode faults
> > >   Add a new sysctl for limiting userfaultfd to user mode faults
> >
> > Now this I'm very interested in. Can you go into more detail about two
> > things:
> [...]
> > - Why is this needed in addition to the existing vm.unprivileged_userfaultfd
> >   sysctl? (And should this maybe just be another setting for that
> >   sysctl, like "2"?)
> >
> > As to the mechanics of the change, I'm not sure I like the idea of adding
> > a UAPI flag for this. Why not just retain the permission check done at
> > open() and if kernelmode faults aren't allowed, ignore them? This would
> > require no changes to existing programs and gains the desired defense.
> > (And, I think, the sysctl value could be bumped to "2" as that's a
> > better default state -- does qemu actually need kernelmode traps?)
> 
> I think this might be necessary for I/O emulation? As in, if before
> getting migrated, the guest writes some data into a buffer, then the
> guest gets migrated, and then while the postcopy migration stuff is
> still running, the guest tells QEMU to write that data from
> guest-physical memory to disk or whatever; I think in that case, QEMU
> will do something like a pwrite() syscall where the userspace pointer
> points into the memory area containing guest-physical memory, which
> would return -EFAULT if userfaultfd was restricted to userspace
> accesses.
> 
> This was described in this old presentation about why userfaultfd is
> better than a SIGSEGV handler:
> https://drive.google.com/file/d/0BzyAwvVlQckeSzlCSDFmRHVybzQ/view
> (slide 6) (recording at https://youtu.be/pC8cWWRVSPw?t=463)

Right. AFAICT QEMU uses it far more than disk IOs.  A guest page can
be accessed by any kernel component on the destination host during a
postcopy procedure.  It can be as simple as when a vcpu writes to a
missing guest page which still resides on the source host, then KVM
will get a page fault and trap into userfaultfd asking for that page.
The same thing happens to other modules like vhost, etc., as long as a
missing guest page is touched by a kernel module.

Thanks,

-- 
Peter Xu

