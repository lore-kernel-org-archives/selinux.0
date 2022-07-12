Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D1C43334
	for <selinux@archiver.kernel.org>; Tue, 12 Jul 2022 21:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiGLVRI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jul 2022 17:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiGLVQ7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jul 2022 17:16:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBBAD03BC
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 14:16:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h17so12943832wrx.0
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdOEioFO23wO9jT+v84Uq6yR/rM6WjphFOowXqeZg+8=;
        b=FGMgDJ/UWUUwxtjgAbMXHbpKlAFja3YZGN8NTh9r5gki2J1eTGIrihjn5kYu8Zp5m4
         6VTF06qBe97J1CxPU3T14bt6XIuwgM9FBXtDhrpqJEJRIUmhzBQG7IK+T7h8yE7VdA5a
         I70IGaN4H1bfFHKVCsYsxL34OJK1NRAnfx/0yh1pnxcRJXal4rH+p6RYOdQrahufvonY
         fWO0KQmvYb+As0YFoNmK/y+Vj75uZM2InxTtWMWRkuQ6q1O5gPBztxVzh4L3IWpslSUJ
         Y2NpYIgYdzc37H3yOAl5XR3vg+AuNRrMZP+8+WIw7tZouCd93viYtW4+bYH/RYk0XbUP
         D/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdOEioFO23wO9jT+v84Uq6yR/rM6WjphFOowXqeZg+8=;
        b=PWODjfiDU7xUdiiCTifmI47EYaOltdHX2aA4YOWaU/A0Nt6x+PKt24XJ4IVtgeOEOv
         0hEVKqy3ovYcvNscFaaq1FFvi5Ug/DsWWiXgIgpFWIaHij/fFoTTKZlD8Liw1mdfmBx2
         Td+7y0mI+CuzG2rUopCUwtiOCYSndtFGmZ+JAKSWaZNLN34jsxVxjfQEKVePC6SLIY/g
         5zI+o4ZZc4mV/dzUKd6L7n0KUqJ3vLpM6E/twEo1+6on4uCb0fUArwsdbkNrYLGw+5Sg
         WRnZ4KV/xIAP/Fnc3vX+F2e+LZK3xqviQH1PyixYyLVMRJpNCdvPfr2tpRhyMPIT1KYY
         khHA==
X-Gm-Message-State: AJIora8xyvLhgnV6HYXrLJmP9PKRkN+AdmCs8UD0/w7a8zKvyb5xZPLj
        PuZ9ujaIQdm+vA64TOWg0LzdmfdczV7wuNmYQd89
X-Google-Smtp-Source: AGRyM1t6+kJwHmyatPByBWwaapf9v8hUQbiKnGv5L2vOBVFV2hCN6Zjs9bYVu18D1T6dN31FclApp8UbXipJerOfjYM=
X-Received: by 2002:a5d:64a3:0:b0:21d:adaa:ce4c with SMTP id
 m3-20020a5d64a3000000b0021dadaace4cmr7514967wrp.161.1657660616240; Tue, 12
 Jul 2022 14:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220708093451.472870-1-omosnace@redhat.com> <Ys2DobolHlrXP4/M@xz-m1.local>
In-Reply-To: <Ys2DobolHlrXP4/M@xz-m1.local>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jul 2022 17:16:45 -0400
Message-ID: <CAHC9VhRv2VPvUAbpDo0D0oK9gEHL=vcOh84M9Fg+AN1c1SR0pA@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
To:     Peter Xu <peterx@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Robert O'Callahan" <roc@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 12, 2022 at 10:22 AM Peter Xu <peterx@redhat.com> wrote:
> On Fri, Jul 08, 2022 at 11:34:51AM +0200, Ondrej Mosnacek wrote:
> > Since userfaultfd doesn't implement a write operation, it is more
> > appropriate to open it read-only.
> >
> > When userfaultfds are opened read-write like it is now, and such fd is
> > passed from one process to another, SELinux will check both read and
> > write permissions for the target process, even though it can't actually
> > do any write operation on the fd later.
> >
> > Inspired by the following bug report, which has hit the SELinux scenario
> > described above:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1974559
> >
> > Reported-by: Robert O'Callahan <roc@ocallahan.org>
> > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks Peter.

-- 
paul-moore.com
