Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CC2C433F5
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 06:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49F160FDA
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 06:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343752AbhICGLg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Sep 2021 02:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244587AbhICGLf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Sep 2021 02:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630649435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GtHmaUO+0GEq+rNeAQMdkCRow+2wFofi089GURVjj/Q=;
        b=gQJDmi0ZU8d3SG75mSPC/Q3TRbN0HRcUjpw24ZTASDi5wUQGEh13rmgDgAkSnmZdSFyLyb
        7fD/utn1niZR2t5TqJ260091TCFE2duQ/wlhXWljTdakcVMWoRFVXcQPzkob7dnOHQH6cP
        PHeqTfG8Da0OUaprAhzOu1gvCfEx3nw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271--L1hGhr8PbOUlWZCgh6LOA-1; Fri, 03 Sep 2021 02:10:34 -0400
X-MC-Unique: -L1hGhr8PbOUlWZCgh6LOA-1
Received: by mail-pl1-f198.google.com with SMTP id a13-20020a170902b58d00b001326cab1084so1746480pls.2
        for <selinux@vger.kernel.org>; Thu, 02 Sep 2021 23:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=GtHmaUO+0GEq+rNeAQMdkCRow+2wFofi089GURVjj/Q=;
        b=EjVMqaqBMv82/pfwfVXxWXNJ7wh1YCzUDnC02aIIap4pLqcD1EnrY4e3qrm7uZLnXm
         +CWDH9IDiVizarbTxqZK77qVTYejy818bMq/cn+yBaTZU/HdoO6OwJzoivz3sFSZ3w/W
         UOQPpnZ+rJEfRfkUYZhzRtsYbiSnCu6Oob3mtk0jaUbb88uCRqhYHxavHhZ2ni5jfktH
         1ypzVjp/H3GtV+xazs9ilNetKKRjg+F4ZCEF3phXJIHKHLJKUCU3lBYqw/ewYCyC/QuY
         W2meaYZ5G8dJ7qclVhXSUOwFf2E2ASflINw7lCQQjGbQ72zUPhbTQ7f9aTUFMrZjUiPr
         ToLg==
X-Gm-Message-State: AOAM532nvGFXITTdvLFVJDzFawgURqtp4mWMIi9OneH2FZ73r5Gm+YZW
        JlNp5K35xrqSuj0qvDqxDLvQwnDqt4P9vjeeVH/V6Z8sHi4scx3ElU9kXm6yW8ihuynXnN6Gssg
        uTPBHJkNugeuK42OsGA==
X-Received: by 2002:a63:a4c:: with SMTP id z12mr2137191pgk.185.1630649433426;
        Thu, 02 Sep 2021 23:10:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJDGjsGTZPA4QMV/Zc6Gjp8iEfZR3XXkoNHMRJnENkybg32Bvzp9DhO/6VKy815DeLZNwpbQ==
X-Received: by 2002:a63:a4c:: with SMTP id z12mr2137158pgk.185.1630649433049;
        Thu, 02 Sep 2021 23:10:33 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h4sm3393427pjs.2.2021.09.02.23.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 23:10:32 -0700 (PDT)
Date:   Fri, 3 Sep 2021 14:31:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
Message-ID: <20210903063133.ld2benxs3vxemgnb@fedora>
Mail-Followup-To: Vivek Goyal <vgoyal@redhat.com>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com, viro@zeniv.linux.org.uk
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <YTDyE9wVQQBxS77r@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTDyE9wVQQBxS77r@redhat.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 02, 2021 at 11:47:31AM -0400, Vivek Goyal wrote:
> 
> xfstests: generic/062: Do not run on newer kernels
> 
> This test has been written with assumption that setting user.* xattrs will
> fail on symlink and special files. When newer kernels support setting
> user.* xattrs on symlink and special files, this test starts failing.
> 
> Found it hard to change test in such a way that it works on both type of
> kernels. Primary problem is 062.out file which hardcodes the output and
> output will be different on old and new kernels.
> 
> So instead, do not run this test if kernel is new and is expected to
> exhibit new behavior. Next patch will create a new test and run that
> test on new kernel.
> 
> IOW, on old kernels run 062 and on new kernels run new test.
> 
> This is a proposed patch. Will need to be fixed if corresponding
> kernel changes are merged upstream.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  tests/generic/062 |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> Index: xfstests-dev/tests/generic/062
> ===================================================================
> --- xfstests-dev.orig/tests/generic/062	2021-08-31 15:51:08.160307982 -0400
> +++ xfstests-dev/tests/generic/062	2021-08-31 16:27:41.678307982 -0400
> @@ -55,6 +55,26 @@ _require_attrs
>  _require_symlinks
>  _require_mknod
>  
> +user_xattr_allowed()
> +{
> +	local kernel_version kernel_patchlevel
> +
> +	kernel_version=`uname -r | awk -F. '{print $1}'`
> +	kernel_patchlevel=`uname -r | awk -F. '{print $2}'`
> +
> +	# Kernel version 5.14 onwards allow user xattr on symlink/special files.
> +	[ $kernel_version -lt 5 ] && return 1
> +	[ $kernel_patchlevel -lt 14 ] && return 1
> +	return 0;
> +}

I don't think this's a good way to judge if run or notrun a test. Many downstream
kernels always backport upstream features. I can't say what's the best way to
deal with this thing, I only can provide two optional methods:

1) Add new requre_* helpers to check if current kernel support to set xattr on
symlink and special files, then let this case only run on support/unsupport
condition.

2) Use _link_out_file() to link the .out file to different golden images (refer to
generic/050 etc), according to different feature implementation.

If anyone has a better method, feel free to talk :)

Thanks,
Zorro

> +
> +
> +# Kernel version 5.14 onwards allow user xattr on symlink/special files.
> +# Do not run this test on newer kernels. Instead run the new test
> +# which has been written with the assumption that user.* xattr
> +# will succeed on symlink and special files.
> +user_xattr_allowed && _notrun "Kernel allows user.* xattrs on symlinks and special files. Skipping this test. Run newer test instead."
> +
>  rm -f $tmp.backup1 $tmp.backup2 $seqres.full
>  
>  # real QA test starts here
> 

