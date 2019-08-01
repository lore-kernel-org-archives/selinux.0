Return-Path: <SRS0=gk/B=V5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F48C433FF
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 12:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42E020665
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 12:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BCqrZFER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfHAMsK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:48:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41183 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbfHAMsK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Aug 2019 08:48:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so45285203lfa.8
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2019 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rl9gxlsQAmtdUucdCjHcN4IJXqqRSXnZiys3c1iAChM=;
        b=BCqrZFER2qt2tRS4BERTa8OYTuAczZw6Vu3z7uTZGQYFaSHcfqcuV5SQV52phXuR2o
         pc7vXSMcsbSyYQZoWwSHx+qcs5+KqXD1ix4QMDk1fiOe2f+Ey++TFVh4YlYS57d7nY/R
         +PJ/gd2ZVxTYilPY2dcgN2+QJY+52AFbAoy3305qeyBUImzo0UJUG1ndwMGZnl91xgKz
         NZSc6hvZbcgaGjMl71JYcOKdsjCyGbbYqmWeQxBn+au/dhacM3cMsu+jw8f7pJ2BZvPK
         ixzTT/jc3086+42k3lk1OU5aCakMaxf9AgMmj6t3GYjy8+6qb4n0kmkj+3oN88PiNKlA
         pQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rl9gxlsQAmtdUucdCjHcN4IJXqqRSXnZiys3c1iAChM=;
        b=Six0ICfWCaSvvRdkDBMWc2KpFOvmBllQF8iG4wfarz99gMn0RgLFx9k0S8sXeNhBuM
         m6It65E1iOs2HkbLa8eBLzw51KaLPfwR1QHxE7NiFy97KrLz8wWXBUywfMuDOVPaVpZi
         ROGOAmw8JpPyMii3yJ/4zRCtJHM0X0NU1bLr8pFf5/3g8FG4cOufY4MNKNDdufVHXIQc
         HAt1qckiqS0FVrA1+KSdF3JOM872SbR7BHe8PtWH/5laiObPCB/PlzCywSemGUBJCAeo
         Y2pzClrocBmfV3Q5C/uP/XwauK+18OlD5o2IcJtU050+uFj5AqDZ7EadUiDJwlWTVKMh
         kbXA==
X-Gm-Message-State: APjAAAUzN3T5mzcYEoLKUoJyOIgRyUhIUMunLbZiJJsAqvT/XYoZEQ30
        16cNgU7QtzfbdQghJoi3bASjCS5SqgzPNz7YMA==
X-Google-Smtp-Source: APXvYqxgr8PQjSzAdp7+U+PsgA9phbRv670CHsf3naEv6EhZF5kRfW6dfEe+5cBDHIT5XJU7QNpkLNvRclzntJy1hqs=
X-Received: by 2002:ac2:5559:: with SMTP id l25mr59946611lfk.175.1564663688296;
 Thu, 01 Aug 2019 05:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov> <1c62c931-9441-4264-c119-d038b2d0c9b9@schaufler-ca.com>
 <CAHC9VhS6cfMw5ZUkOSov6hexh9QpnpKwipP7L7ZYGCVLCHGfFQ@mail.gmail.com> <66fbc35c-6cc8-bd08-9bf9-aa731dc3ff09@tycho.nsa.gov>
In-Reply-To: <66fbc35c-6cc8-bd08-9bf9-aa731dc3ff09@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Aug 2019 08:47:56 -0400
Message-ID: <CAHC9VhQg_UCDZpm=hWTn5YFAYQJt1K_fRxxq+LzORekJ8p9zNg@mail.gmail.com>
Subject: Re: [PATCH] fanotify, inotify, dnotify, security: add security hook
 for fs notifications
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 1, 2019 at 7:31 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 7/31/19 8:27 PM, Paul Moore wrote:
> > On Wed, Jul 31, 2019 at 1:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 7/31/2019 8:34 AM, Aaron Goidel wrote:

...

> >>> +static int selinux_path_notify(const struct path *path, u64 mask,
> >>> +                                             unsigned int obj_type)
> >>> +{
> >>> +     int ret;
> >>> +     u32 perm;
> >>> +
> >>> +     struct common_audit_data ad;
> >>> +
> >>> +     ad.type = LSM_AUDIT_DATA_PATH;
> >>> +     ad.u.path = *path;
> >>> +
> >>> +     /*
> >>> +      * Set permission needed based on the type of mark being set.
> >>> +      * Performs an additional check for sb watches.
> >>> +      */
> >>> +     switch (obj_type) {
> >>> +     case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> >>> +             perm = FILE__WATCH_MOUNT;
> >>> +             break;
> >>> +     case FSNOTIFY_OBJ_TYPE_SB:
> >>> +             perm = FILE__WATCH_SB;
> >>> +             ret = superblock_has_perm(current_cred(), path->dentry->d_sb,
> >>> +                                             FILESYSTEM__WATCH, &ad);
> >>> +             if (ret)
> >>> +                     return ret;
> >>> +             break;
> >>> +     case FSNOTIFY_OBJ_TYPE_INODE:
> >>> +             perm = FILE__WATCH;
> >>> +             break;
> >>> +     default:
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>> +     // check if the mask is requesting ability to set a blocking watch
> >
> > ... in the future please don't use "// XXX", use "/* XXX */" instead :)
> >
> > Don't respin the patch just for this, but if you have to do it for
> > some other reason please fix the C++ style comments.  Thanks.
>
> This was discussed during the earlier RFC series but ultimately someone
> pointed to:
> https://lkml.org/lkml/2016/7/8/625
> where Linus blessed the use of C++/C99 style comments.  And checkpatch
> accepts them these days.

Yep, I'm aware of both, it is simply a personal preference of mine.
I'm not going to reject patches with C++ style comments, but I would
ask people to stick to the good ol' fashioned comments for patches
they submit.

> Obviously if you truly don't want them in the SELinux code, that's your
> call.  But note that all files now have at least one such comment as a
> result of the mass SPDX license headers that were added throughout the
> tree using that style.

FYI, the sky is blue.

It isn't just the license headers either, Al dropped one into hooks.c
:).  Just like I don't plan to reject patches due only to the comment
style, you don't see me pushing patches to change the C++ comments.

-- 
paul moore
www.paul-moore.com
