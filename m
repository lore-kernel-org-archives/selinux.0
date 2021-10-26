Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F588C433EF
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806E860F21
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhJZL7O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Oct 2021 07:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231126AbhJZL7N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Oct 2021 07:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635249409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUM8H9PXnQ++RyKnVwkfCu362nXGKfA2/c8H9QdKfco=;
        b=T0mtcHqkx9AUpDJ/Su7H2ZbEWARKm+QUoln5nO3ak+BGipTvsVmLwoE/V+6G93LZ34aaHZ
        Y6m8Vzsce4e7VCBzmuylFCMnQwMYb12lXeHPE3SIwe22vn1CTIZhWiv3Pu2s/KN+OFSI0I
        0r3pgNGl/YxS2akvZJOdijXPWdGJ2Vk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-7UzAfT4TPeuwfJD7rzuicQ-1; Tue, 26 Oct 2021 07:56:48 -0400
X-MC-Unique: 7UzAfT4TPeuwfJD7rzuicQ-1
Received: by mail-yb1-f200.google.com with SMTP id x68-20020a25ce47000000b005c198858e6bso5801978ybe.21
        for <selinux@vger.kernel.org>; Tue, 26 Oct 2021 04:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rUM8H9PXnQ++RyKnVwkfCu362nXGKfA2/c8H9QdKfco=;
        b=WX4XmKTGoBFKpxcR9CJ42s+q46v9U9KTTmK0EdmmpqDkqnoxJLe8ws9wnGi4GUYZL6
         Pq4EWGq3eg4jdJ1z5Hkyog7ehYJFMyvrpF2Fo+MrGJXomHaOObCNrE+3clZzJRswJp7k
         KRHyomgi2S5J4s6JXXWUwxtnbNQAW6KI+L0J1R5v3YO/uu2BkMrEVHSWRCmQ9ZyBk4JU
         kjmLoxg8C5Ne6tcpPdnHmjkOL2Ybd9JJ/8H9PldY4DF8LFm7B6oCkl7sA8lLOZ2oBo1y
         ZIxPRZp4gxtN2xOvuv39uwpeSPX7lcP+mlJ0fUPjAUin5G2AMsnMy8enjryljtqZNQf6
         THVA==
X-Gm-Message-State: AOAM532X13vvUfmnD7foGrSsE1a7Zv5deT7+33hcUCkQHOKagrl5it5W
        I32QvlZD8ooJztqjZBiIgcdtLxsr4CjNfSXdBT7PfU16MYfTFRJnuFt2o9OfGUIMiJRc5GR8ZPW
        2Gv6tnu63Oy7P5xxJnxkHi4h4Hj364WRgxw==
X-Received: by 2002:a25:cb44:: with SMTP id b65mr19564829ybg.237.1635249407799;
        Tue, 26 Oct 2021 04:56:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx83Q00SvjqhYXBzao04k/QTEZqCipJzX6wzaRnQBmnru5rx6TjOCisWXfLUxA7HYDgSWUYksaxTjxM/3LtRFM=
X-Received: by 2002:a25:cb44:: with SMTP id b65mr19564794ybg.237.1635249407344;
 Tue, 26 Oct 2021 04:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211019150122.459722-1-omosnace@redhat.com> <CAJ2a_DeU=wo10JQ=98BHh3fNGKNY3d+SYfWoAzYMqeaQOU+OLQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DeU=wo10JQ=98BHh3fNGKNY3d+SYfWoAzYMqeaQOU+OLQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 26 Oct 2021 13:56:34 +0200
Message-ID: <CAFqZXNvG3wMsVK45A4kxE_JNZJuKcUDoQ6Ust6FmObnYP128YQ@mail.gmail.com>
Subject: Re: [PATCH userspace v3 0/7] Parallel setfiles/restorecon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 19, 2021 at 5:34 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Tue, 19 Oct 2021 at 17:01, Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> >
> > This series adds basic support for parallel relabeling to the libselinu=
x
> > API and the setfiles/restorecon CLI tools. It turns out that doing the
> > relabeling in parallel can significantly reduce the time even with a
> > relatively simple approach.
> >
> > The first patch is a small cleanup that was found along the way and can
> > be applied independently. Patches 2-4 are small incremental changes tha=
t
> > make the internal selinux_restorecon functions more thread-safe (I kept
> > them separate for ease of of review, but maybe they should be rather
> > folded into the netx patch...). Patch 5 then completes the parallel
> > relabeling implementation at libselinux level and adds a new function
> > to the API that allows to make use of it. Finally, patch 6 adds paralle=
l
> > relabeling support to he setfiles/restorecon tools.
> >
> > The relevant man pages are also updated to reflect the new
> > functionality.
> >
> > The patch descriptions contain more details, namely the last patch has
> > also some benchmark numbers.
> >
>
> There seems to be another data race, which however does not occur every t=
ime:
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: ThreadSanitizer: data race (pid=3D4189)
>   Read of size 8 at 0x7f72252e5908 by thread T3:
>     #0 is_context_customizable
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:70:7
> (libselinux.so.1+0x12d86)
>     #1 restorecon_sb
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:696:10
> (libselinux.so.1+0x24b41)
>     #2 selinux_restorecon_thread
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:943:12
> (libselinux.so.1+0x25695)
>
>   Previous write of size 8 at 0x7f72252e5908 by thread T1:
>     #0 get_customizable_type_list
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:58:11
> (libselinux.so.1+0x13027)
>     #1 is_context_customizable
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:71:7
> (libselinux.so.1+0x13027)
>     #2 restorecon_sb
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:696:10
> (libselinux.so.1+0x24b41)
>     #3 selinux_restorecon_thread
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:943:12
> (libselinux.so.1+0x25695)
>
>   Location is global 'customizable_list' of size 8 at 0x7f72252e5908
> (libselinux.so.1+0x000000036908)
>
>   Thread T3 (tid=3D4197, running) created by main thread at:
>     #0 pthread_create <null> (setfiles+0x44c6ed)
>     #1 selinux_restorecon_common
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1193:8
> (libselinux.so.1+0x22ba6)
>     #2 selinux_restorecon_parallel
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1310:9
> (libselinux.so.1+0x22da2)
>     #3 process_glob
> /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/resto=
re.c:94:8
> (setfiles+0x4c13b7)
>     #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/se=
tfiles/setfiles.c:463:14
> (setfiles+0x4c0938)
>
>   Thread T1 (tid=3D4195, running) created by main thread at:
>     #0 pthread_create <null> (setfiles+0x44c6ed)
>     #1 selinux_restorecon_common
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1193:8
> (libselinux.so.1+0x22ba6)
>     #2 selinux_restorecon_parallel
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1310:9
> (libselinux.so.1+0x22da2)
>     #3 process_glob
> /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/resto=
re.c:94:8
> (setfiles+0x4c13b7)
>     #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/se=
tfiles/setfiles.c:463:14
> (setfiles+0x4c0938)
>
> SUMMARY: ThreadSanitizer: data race
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:70:7
> in is_context_customizable
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: ThreadSanitizer: data race (pid=3D4189)
>   Read of size 8 at 0x7b080000c000 by thread T3:
>     #0 is_context_customizable
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:85:14
> (libselinux.so.1+0x12ddc)
>     #1 restorecon_sb
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:696:10
> (libselinux.so.1+0x24b41)
>     #2 selinux_restorecon_thread
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:943:12
> (libselinux.so.1+0x25695)
>
>   Previous write of size 8 at 0x7b080000c000 by thread T1:
>     [failed to restore the stack]
>
>   Location is heap block of size 32 at 0x7b080000c000 allocated by thread=
 T1:
>     #0 calloc <null> (setfiles+0x44b249)
>     #1 get_customizable_type_list
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:34:17
> (libselinux.so.1+0x12ed7)
>     #2 is_context_customizable
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:71:7
> (libselinux.so.1+0x12ed7)
>     #3 restorecon_sb
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:696:10
> (libselinux.so.1+0x24b41)
>     #4 selinux_restorecon_thread
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:943:12
> (libselinux.so.1+0x25695)
>
>   Thread T3 (tid=3D4197, running) created by main thread at:
>     #0 pthread_create <null> (setfiles+0x44c6ed)
>     #1 selinux_restorecon_common
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1193:8
> (libselinux.so.1+0x22ba6)
>     #2 selinux_restorecon_parallel
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1310:9
> (libselinux.so.1+0x22da2)
>     #3 process_glob
> /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/resto=
re.c:94:8
> (setfiles+0x4c13b7)
>     #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/se=
tfiles/setfiles.c:463:14
> (setfiles+0x4c0938)
>
>   Thread T1 (tid=3D4195, running) created by main thread at:
>     #0 pthread_create <null> (setfiles+0x44c6ed)
>     #1 selinux_restorecon_common
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1193:8
> (libselinux.so.1+0x22ba6)
>     #2 selinux_restorecon_parallel
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1310:9
> (libselinux.so.1+0x22da2)
>     #3 process_glob
> /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/resto=
re.c:94:8
> (setfiles+0x4c13b7)
>     #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/se=
tfiles/setfiles.c:463:14
> (setfiles+0x4c0938)
>
> SUMMARY: ThreadSanitizer: data race
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:85:14
> in is_context_customizable
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: ThreadSanitizer: data race (pid=3D4189)
>   Read of size 1 at 0x7b080000c040 by thread T3:
>     #0 strcmp <null> (setfiles+0x4545d4)
>     #1 is_context_customizable
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:86:7
> (libselinux.so.1+0x12df7)
>     #2 restorecon_sb
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:696:10
> (libselinux.so.1+0x24b41)
>     #3 selinux_restorecon_thread
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:943:12
> (libselinux.so.1+0x25695)
>
>   Previous write of size 8 at 0x7b080000c040 by thread T1:
>     [failed to restore the stack]
>
>   Location is heap block of size 17 at 0x7b080000c040 allocated by thread=
 T1:
>     #0 malloc <null> (setfiles+0x44b05d)
>     #1 strdup <null> (libc.so.6+0x8e4aa)
>     #2 get_customizable_type_list
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:41:15
> (libselinux.so.1+0x12f45)
>     #3 is_context_customizable
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:71:7
> (libselinux.so.1+0x12f45)
>     #4 restorecon_sb
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:696:10
> (libselinux.so.1+0x24b41)
>     #5 selinux_restorecon_thread
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:943:12
> (libselinux.so.1+0x25695)
>
>   Thread T3 (tid=3D4197, running) created by main thread at:
>     #0 pthread_create <null> (setfiles+0x44c6ed)
>     #1 selinux_restorecon_common
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1193:8
> (libselinux.so.1+0x22ba6)
>     #2 selinux_restorecon_parallel
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1310:9
> (libselinux.so.1+0x22da2)
>     #3 process_glob
> /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/resto=
re.c:94:8
> (setfiles+0x4c13b7)
>     #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/se=
tfiles/setfiles.c:463:14
> (setfiles+0x4c0938)
>
>   Thread T1 (tid=3D4195, running) created by main thread at:
>     #0 pthread_create <null> (setfiles+0x44c6ed)
>     #1 selinux_restorecon_common
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1193:8
> (libselinux.so.1+0x22ba6)
>     #2 selinux_restorecon_parallel
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1310:9
> (libselinux.so.1+0x22da2)
>     #3 process_glob
> /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/resto=
re.c:94:8
> (setfiles+0x4c13b7)
>     #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/se=
tfiles/setfiles.c:463:14
> (setfiles+0x4c0938)
>
> SUMMARY: ThreadSanitizer: data race
> (/home/debianuser/destdir/sbin/setfiles+0x4545d4) in strcmp
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: ThreadSanitizer: data race (pid=3D4189)
>   Read of size 8 at 0x7b080000c008 by thread T3:
>     #0 is_context_customizable
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:85:14
> (libselinux.so.1+0x12e07)
>     #1 restorecon_sb
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:696:10
> (libselinux.so.1+0x24b41)
>     #2 selinux_restorecon_thread
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:943:12
> (libselinux.so.1+0x25695)
>
>   Previous write of size 8 at 0x7b080000c008 by thread T1:
>     [failed to restore the stack]
>
>   Location is heap block of size 32 at 0x7b080000c000 allocated by thread=
 T1:
>     #0 calloc <null> (setfiles+0x44b249)
>     #1 get_customizable_type_list
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:34:17
> (libselinux.so.1+0x12ed7)
>     #2 is_context_customizable
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:71:7
> (libselinux.so.1+0x12ed7)
>     #3 restorecon_sb
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:696:10
> (libselinux.so.1+0x24b41)
>     #4 selinux_restorecon_thread
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:943:12
> (libselinux.so.1+0x25695)
>
>   Thread T3 (tid=3D4197, running) created by main thread at:
>     #0 pthread_create <null> (setfiles+0x44c6ed)
>     #1 selinux_restorecon_common
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1193:8
> (libselinux.so.1+0x22ba6)
>     #2 selinux_restorecon_parallel
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1310:9
> (libselinux.so.1+0x22da2)
>     #3 process_glob
> /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/resto=
re.c:94:8
> (setfiles+0x4c13b7)
>     #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/se=
tfiles/setfiles.c:463:14
> (setfiles+0x4c0938)
>
>   Thread T1 (tid=3D4195, running) created by main thread at:
>     #0 pthread_create <null> (setfiles+0x44c6ed)
>     #1 selinux_restorecon_common
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1193:8
> (libselinux.so.1+0x22ba6)
>     #2 selinux_restorecon_parallel
> /home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restore=
con.c:1310:9
> (libselinux.so.1+0x22da2)
>     #3 process_glob
> /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/resto=
re.c:94:8
> (setfiles+0x4c13b7)
>     #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/se=
tfiles/setfiles.c:463:14
> (setfiles+0x4c0938)
>
> SUMMARY: ThreadSanitizer: data race
> /home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable=
_type.c:85:14
> in is_context_customizable
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

True, I had to remove the -n parameter (i.e. enable actual relabeling)
to trigger it. Patch 5/8 of v4, which I have just posted, should fix
this one.

Thanks,

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

