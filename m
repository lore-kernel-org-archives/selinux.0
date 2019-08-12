Return-Path: <SRS0=1Vb5=WI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319F1C31E40
	for <selinux@archiver.kernel.org>; Mon, 12 Aug 2019 22:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0468B206C2
	for <selinux@archiver.kernel.org>; Mon, 12 Aug 2019 22:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JpXZDChc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfHLWE6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:04:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39589 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfHLWEx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Aug 2019 18:04:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so21556269lfn.6
        for <selinux@vger.kernel.org>; Mon, 12 Aug 2019 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0Z17ppWLL4n1GB6wiiHS5duSRi0ZG/2i5oK1/nFtDI=;
        b=JpXZDChc8Io1Ofe98GO2vIXYGFHSdLztgOlANhWXT2ZPC/wTqEY+9Sm3jSgwteJe3k
         4ztNbBgKLqSNduRmg3AZrTJ0fVoNoPn/ct6mr/0LysEdFz29fSbLbGCIc9g2suCECKGF
         bPz4iBJsm4GXG7aW2hNSDXGzbMJ8fo7OsWOhbEutgkMB5HGdJvcRErop+0q5srrewsG5
         GNArPd0eMhQAvXKAEOUatnTfkqapawdEQmWMobL0DUG1gbwFyVdUd9N//QnOJIpZRN8p
         zLJNLOifwMDERbToNFUQ+usXLlvU0ZIFlUxqXiTVNQD0GJhDsTqs+VW13lNw7PrIuCpC
         T3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0Z17ppWLL4n1GB6wiiHS5duSRi0ZG/2i5oK1/nFtDI=;
        b=sZGA2UBAvy14mEutRjPgNqGLWSCoYEjkCA5+AdQQ18eJ3UnpQmPl8fWdI7zWCFibav
         EEAeAsDmG8gWip8fT8invxmjQsHo1hypd6Qc4qaq2hr6BEjycg3wzHHQYsvs8NLCVoOB
         kQyZKgX2fGePNfFwrq5PLofIYezTQyWFQboDIrxL4jyWow7QAyLzrbyFefTgIBvlRcY4
         csRxyyeBl5htyhLx3YKrVQIvhjSgsUtoGpEU8u4AIta5imRxhGIQnVXMSQJOHHLxF/v1
         k9/5dhX+OdkH4TapJFuNix2wGj8pgMdFHMB+ZM11MDwT/MVo2rxhv0x7td6spLMqrBpv
         HjHQ==
X-Gm-Message-State: APjAAAVXzj9CTqcTZ6WCC9acj5zL7UmCOiOtD0BGEwEygZT8m470lNdD
        j10QZk0Iu2TSiUFkZF9SEp55bwPwsILaWVjbOR7M
X-Google-Smtp-Source: APXvYqzHVFIpiZj5TDqXqB7VtO7B7a8OmuD6etx3tF9XL3ZH+sKwKCEGSlcK8SadZOQ62zlbUoaZAmo18jcs2qXMh7U=
X-Received: by 2002:a19:5e10:: with SMTP id s16mr20448721lfb.13.1565647490303;
 Mon, 12 Aug 2019 15:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190812152000.18050-1-acgoide@tycho.nsa.gov>
In-Reply-To: <20190812152000.18050-1-acgoide@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Aug 2019 18:04:39 -0400
Message-ID: <CAHC9VhRTBiDNCCDOkqHxyfoNskiCNrJBJGr767Ur0yuEaBjKbg@mail.gmail.com>
Subject: Re: [PATCH v3] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
To:     Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 12, 2019 at 11:20 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
> As of now, setting watches on filesystem objects has, at most, applied a
> check for read access to the inode, and in the case of fanotify, requires
> CAP_SYS_ADMIN. No specific security hook or permission check has been
> provided to control the setting of watches. Using any of inotify, dnotify,
> or fanotify, it is possible to observe, not only write-like operations, but
> even read access to a file. Modeling the watch as being merely a read from
> the file is insufficient for the needs of SELinux. This is due to the fact
> that read access should not necessarily imply access to information about
> when another process reads from a file. Furthermore, fanotify watches grant
> more power to an application in the form of permission events. While
> notification events are solely, unidirectional (i.e. they only pass
> information to the receiving application), permission events are blocking.
> Permission events make a request to the receiving application which will
> then reply with a decision as to whether or not that action may be
> completed. This causes the issue of the watching application having the
> ability to exercise control over the triggering process. Without drawing a
> distinction within the permission check, the ability to read would imply
> the greater ability to control an application. Additionally, mount and
> superblock watches apply to all files within the same mount or superblock.
> Read access to one file should not necessarily imply the ability to watch
> all files accessed within a given mount or superblock.
>
> In order to solve these issues, a new LSM hook is implemented and has been
> placed within the system calls for marking filesystem objects with inotify,
> fanotify, and dnotify watches. These calls to the hook are placed at the
> point at which the target path has been resolved and are provided with the
> path struct, the mask of requested notification events, and the type of
> object on which the mark is being set (inode, superblock, or mount). The
> mask and obj_type have already been translated into common FS_* values
> shared by the entirety of the fs notification infrastructure. The path
> struct is passed rather than just the inode so that the mount is available,
> particularly for mount watches. This also allows for use of the hook by
> pathname-based security modules. However, since the hook is intended for
> use even by inode based security modules, it is not placed under the
> CONFIG_SECURITY_PATH conditional. Otherwise, the inode-based security
> modules would need to enable all of the path hooks, even though they do not
> use any of them.
>
> This only provides a hook at the point of setting a watch, and presumes
> that permission to set a particular watch implies the ability to receive
> all notification about that object which match the mask. This is all that
> is required for SELinux. If other security modules require additional hooks
> or infrastructure to control delivery of notification, these can be added
> by them. It does not make sense for us to propose hooks for which we have
> no implementation. The understanding that all notifications received by the
> requesting application are all strictly of a type for which the application
> has been granted permission shows that this implementation is sufficient in
> its coverage.
>
> Security modules wishing to provide complete control over fanotify must
> also implement a security_file_open hook that validates that the access
> requested by the watching application is authorized. Fanotify has the issue
> that it returns a file descriptor with the file mode specified during
> fanotify_init() to the watching process on event. This is already covered
> by the LSM security_file_open hook if the security module implements
> checking of the requested file mode there. Otherwise, a watching process
> can obtain escalated access to a file for which it has not been authorized.
>
> The selinux_path_notify hook implementation works by adding five new file
> permissions: watch, watch_mount, watch_sb, watch_reads, and watch_with_perm
> (descriptions about which will follow), and one new filesystem permission:
> watch (which is applied to superblock checks). The hook then decides which
> subset of these permissions must be held by the requesting application
> based on the contents of the provided mask and the obj_type. The
> selinux_file_open hook already checks the requested file mode and therefore
> ensures that a watching process cannot escalate its access through
> fanotify.
>
> The watch, watch_mount, and watch_sb permissions are the baseline
> permissions for setting a watch on an object and each are a requirement for
> any watch to be set on a file, mount, or superblock respectively. It should
> be noted that having either of the other two permissions (watch_reads and
> watch_with_perm) does not imply the watch, watch_mount, or watch_sb
> permission. Superblock watches further require the filesystem watch
> permission to the superblock. As there is no labeled object in view for
> mounts, there is no specific check for mount watches beyond watch_mount to
> the inode. Such a check could be added in the future, if a suitable labeled
> object existed representing the mount.
>
> The watch_reads permission is required to receive notifications from
> read-exclusive events on filesystem objects. These events include accessing
> a file for the purpose of reading and closing a file which has been opened
> read-only. This distinction has been drawn in order to provide a direct
> indication in the policy for this otherwise not obvious capability. Read
> access to a file should not necessarily imply the ability to observe read
> events on a file.
>
> Finally, watch_with_perm only applies to fanotify masks since it is the
> only way to set a mask which allows for the blocking, permission event.
> This permission is needed for any watch which is of this type. Though
> fanotify requires CAP_SYS_ADMIN, this is insufficient as it gives implicit
> trust to root, which we do not do, and does not support least privilege.
>
> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Jan Kara <jack@suse.cz>
> ---
> v3:
>   - fixed comment style in security hook
>
> v2:
>   - move initialization of obj_type up to remove duplicate work
>   - convert inotify and fanotify flags to common FS_* flags
> ---
>  fs/notify/dnotify/dnotify.c         | 15 +++++++--
>  fs/notify/fanotify/fanotify_user.c  | 19 ++++++++++--
>  fs/notify/inotify/inotify_user.c    | 14 +++++++--
>  include/linux/lsm_hooks.h           |  9 +++++-
>  include/linux/security.h            | 10 ++++--
>  security/security.c                 |  6 ++++
>  security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  5 +--
>  8 files changed, 113 insertions(+), 12 deletions(-)

Merged into selinux/next, thanks everyone!

-- 
paul moore
www.paul-moore.com
