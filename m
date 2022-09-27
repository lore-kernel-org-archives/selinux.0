Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB18C07E9D
	for <selinux@archiver.kernel.org>; Tue, 27 Sep 2022 22:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiI0W4M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiI0W4K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Sep 2022 18:56:10 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFD17C18D
        for <selinux@vger.kernel.org>; Tue, 27 Sep 2022 15:56:08 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-130af056397so15214425fac.2
        for <selinux@vger.kernel.org>; Tue, 27 Sep 2022 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9+Jx85fgaqaAStRSzFRkJSSNinfz1K6AEIp4ZvGpbG4=;
        b=w22laipt6SnchnrW53rfT+Dasmf440bgioQZNocnEfArNJuD3q1Hp2gEwv478388pW
         wAyCeVgxk/hzcI1vl1leGvjYVlEv5KwDWU5OH6oV6WEpxCmIIM+MomVLjBTje1E60UlO
         2zCzhFNVrj1i/bQugey8fcs84ah2KXfXUWgpu5kXV/oIyrJW1q6EAZmjTeYP4De8pNI0
         HcjvGrhEQtsCWUgr1hv/t/47HfVpuaJbVOp7LbFoyWmSBUVpnYxjP3ctzU4WGwFjRBY9
         Ffdfy27DEuzcNnF0q0MIRt+/yogSEL3ukxKNfPXNVXfa1zx+HwBBZL2NVcKskNLSFAzK
         YUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9+Jx85fgaqaAStRSzFRkJSSNinfz1K6AEIp4ZvGpbG4=;
        b=0CGTxEx5Y7Bo+yJ4kqYAE96VXzlJtkPS6GvYXxaYU5bD8sJoxJBC0oBiG/mv/MtIFI
         Zw3Ri65oieL5TLbQw+TMHIib5v+DmntZEUtO0LdYOrTjWbOQaw7mXBAoKPIwW5jvPse9
         8jAzPEmQ0JvUIbWFbnJd5JsM9ua6ujHDto8EcDHrszM60iHnvhCLKNCHXLbEYos7h2Je
         D2VMJ3h5e146YWk4WnL8AfrCbtfObTwIr9rhk1ouENoiUuCM4Xz4VH637LTHHWJRSpxr
         rwS/2TNqhvB3U6L4mZZ/kIPoPf39/3iPPXOf/Wb5PdcJarMwH6ZrhipyKhkGP11JNnDS
         z/3A==
X-Gm-Message-State: ACrzQf2eciazIBhe+zMhUzeMv3ktz9soONhzJWHyyy/Uwafz87vGYIFZ
        cKXKv3KrabSVL28q4r1cyI7Q9T6cFvi8xKmbbmj1
X-Google-Smtp-Source: AMsMyM60hc7MUnHu2+NDON4rHOHcLCd4aT7+cO4Hmo5M+igbZUxBmpl981qkwEl1ByGXgnGzrljXtzNtz+pjMB3lReo=
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id
 z11-20020a05687041cb00b001319656cc30mr1656334oac.51.1664319367636; Tue, 27
 Sep 2022 15:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-12-brauner@kernel.org>
In-Reply-To: <20220926140827.142806-12-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:55:56 -0400
Message-ID: <CAHC9VhQDBc2-grqDnQeHaE9xXhOWNyyXfgpQXLSd2DeUUrGtAQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/30] selinux: implement set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 26, 2022 at 10:09 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> So far posix acls were passed as a void blob to the security and
> integrity modules. Some of them like evm then proceed to interpret the
> void pointer and convert it into the kernel internal struct posix acl
> representation to perform their integrity checking magic. This is
> obviously pretty problematic as that requires knowledge that only the
> vfs is guaranteed to have and has lead to various bugs. Add a proper
> security hook for setting posix acls and pass down the posix acls in
> their appropriate vfs format instead of hacking it through a void
> pointer stored in the uapi format.
>
> I spent considerate time in the security module infrastructure and
> audited all codepaths. SELinux has no restrictions based on the posix
> acl values passed through it. The capability hook doesn't need to be
> called either because it only has restrictions on security.* xattrs. So
> this all becomes a very simple hook for SELinux.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>  security/selinux/hooks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
