Return-Path: <SRS0=r+0f=YV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E185CA9EBC
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 10:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FE720873
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 10:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbfJ1KMI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Oct 2019 06:12:08 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:52830 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732895AbfJ1KMI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Oct 2019 06:12:08 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E9B3A560664
        for <selinux@vger.kernel.org>; Mon, 28 Oct 2019 11:12:02 +0100 (CET)
Received: by mail-il1-f181.google.com with SMTP id y5so7675369ilb.5
        for <selinux@vger.kernel.org>; Mon, 28 Oct 2019 03:12:02 -0700 (PDT)
X-Gm-Message-State: APjAAAVZ6nRdlerwFlbsYOFZ9+DwO7dxBhaF+HqFYqA9TJU7lzFNTunk
        yuVZpcGL7Rc7BgiIg6V8jSk5M5tQXjcKumA1jjE=
X-Google-Smtp-Source: APXvYqx0Iw2xY/AD1jYbG7wdRdLzr/z0rwTDp+Yhkc5MBrProKuQ/jB+lJXrgG9ACnL9zk1F/QvZdI8pkVEWvjIpf6U=
X-Received: by 2002:a92:d0a:: with SMTP id 10mr18290924iln.129.1572257521967;
 Mon, 28 Oct 2019 03:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <bded2b55-30eb-e039-19cd-4e834ad5ca28@gmail.com>
In-Reply-To: <bded2b55-30eb-e039-19cd-4e834ad5ca28@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 28 Oct 2019 11:11:50 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==g3ZWQxUnJKiYt1wZrviZYVgqhu5Kaya3ncPvHUZ9o7Q@mail.gmail.com>
Message-ID: <CAJfZ7==g3ZWQxUnJKiYt1wZrviZYVgqhu5Kaya3ncPvHUZ9o7Q@mail.gmail.com>
Subject: Re: Add portcon rule to existing policy module
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Oct 28 11:12:03 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 28, 2019 at 2:07 AM Ian Pilcher <arequipeno@gmail.com> wrote:
>
> I have a policy module that consists of a .te and an .fc file.  I would
> like to add a "portcon" rule to this module, which (AFAIK) can only be
> done in CIL "format."
>
> What I've got today is:
>
> 1. Build a "traditional" .pp file
>     (make -f /usr/share/selinux/devel/Makefile).
>
> 2. Use /usr/libexec/selinux/hll/pp to convert the .pp file to a .cil
>     file.
>
> 3. Add the port context rule to the .cil file.
>
> Is this the best/only way to do this?

"portcon" is what is used in refpolicy's corenetwork module:
corenetwork.te.in [1] contains lines such as:

network_port(http, tcp,80,s0, tcp,443,s0, tcp,488,s0, tcp,8008,s0,
tcp,8009,s0, tcp,8443,s0)

and "network_port" is a macro defined in corenetwork.te.m4 [2], that
expands to lines similar to:

type http_port_t, port_type, defined_port_type;
portcon tcp 80 gen_context(system_u:object_r:http_port_t,s0)
portcon tcp 443 gen_context(system_u:object_r:http_port_t,s0)
...

I have not tested whether these statements are supported in policy
modules other that in the "base" module (if I remember correctly,
"base" is no longer a special module but there could be things I
missed). What led you to state that "portcon" rules can only be done
in CIL? (For example did you encounter an error while building the .pp
module?)

Thanks,
Nicolas

[1] https://github.com/SELinuxProject/refpolicy/blob/RELEASE_2_20190609/policy/modules/kernel/corenetwork.te.in
[2] https://github.com/SELinuxProject/refpolicy/blob/RELEASE_2_20190609/policy/modules/kernel/corenetwork.te.m4

