Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52989ECAAA1
	for <selinux@archiver.kernel.org>; Mon,  5 Sep 2022 08:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIEI62 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiIEI61 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Sep 2022 04:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E465004C
        for <selinux@vger.kernel.org>; Mon,  5 Sep 2022 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662368302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vr9RIRRWrL6Ndi+I/5OhsHzaQvnpFYm5PW/9JS+U3vE=;
        b=hHV/vlwYxdOjYyoLCmHH6JR7ZV4da/pZ/jUtow/7E4DXwdbD7iOekACoYFszQW8LCDDVlg
        tgevH5lPaRyZ7lnf/FVWGzcjgsbGdYX77aw6nljtviJ/df0nUlzb0AfLQPt5rxC6d5OJ+o
        gEhABY+p8unN2u9EtNN5vc8mask2jIE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-489-QBqLiwzCPbaqcqaD554eAg-1; Mon, 05 Sep 2022 04:58:21 -0400
X-MC-Unique: QBqLiwzCPbaqcqaD554eAg-1
Received: by mail-pj1-f69.google.com with SMTP id y16-20020a17090aa41000b001fdf0a76a4eso3044157pjp.3
        for <selinux@vger.kernel.org>; Mon, 05 Sep 2022 01:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Vr9RIRRWrL6Ndi+I/5OhsHzaQvnpFYm5PW/9JS+U3vE=;
        b=dS31AElczlfOdbxzj/EyMn5QoGzgj4Vyz8mFII8uWzOledXyAGbLNiSskcOFRDRafX
         HGmcCSrz7O4XlV2rjE125em2JjyrylD+G7GyEO9TC0K6ugo7nyPi9IuE8IVYl70DJ5w3
         6j1UYPfSSVkVBrt0Bbb+zVbT7/qqT1dZekX/xH+VKxu5lsJz8qWvJRq4RAHHl8ekSyo5
         kMppS5btMqOccnt4oAgof2cV0rFbVid37ov71LgsST7R82AkyqwtBuAb+YhMnXDu9ixd
         O3y7uoefisW/Ax3xtWALnvKQJE1GThnB8yw/yOin/wq0+mexr7josAXsa5NMkWfKvHbS
         kXmA==
X-Gm-Message-State: ACgBeo2nO6TCGBf2m2yHc94jd+daC65BQF6/vV8RTem66vUdQduVsI/z
        xnr/LahcYGLw1AbSPvjM4HTIPD1Lx2Zz0QgukNcdXNNBcOvRek9d+6tWx94SRgcI6TCNE5uVMuF
        2Gvmxw6iy6uiltHZSxht/b7CcX2ekpOYrqA==
X-Received: by 2002:a17:90b:3a8e:b0:200:5585:4099 with SMTP id om14-20020a17090b3a8e00b0020055854099mr5885808pjb.70.1662368300307;
        Mon, 05 Sep 2022 01:58:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR65JiPoezoP2uXlHyhW+xyD+vJzvAChjzeGb2471qsgqgi3WYQoxLAV1FaHZTJESHCtDlU8yGqX8eW9JZCUXaw=
X-Received: by 2002:a17:90b:3a8e:b0:200:5585:4099 with SMTP id
 om14-20020a17090b3a8e00b0020055854099mr5885789pjb.70.1662368300045; Mon, 05
 Sep 2022 01:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220902084247.1042660-1-omosnace@redhat.com>
In-Reply-To: <20220902084247.1042660-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 5 Sep 2022 10:58:08 +0200
Message-ID: <CAFqZXNuFQRvPCUM2wx+y50EDcngz_d4YoaxXbh=DwQm53=9ArA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/Makefile: add missing condition for
 userfaultfd test
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Dennis Li <denli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 2, 2022 at 10:42 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The commit referenced below disables the test_userfaultfd.te policy when
> the anon_inode class is not defined in the system policy, but doesn't
> disable the test itself in this situation. Thus, on distros that don't
> define the class the test might be run and fail.
>
> Fix this by adding the same condition to tests/Makefile.
>
> Fixes: 2b6ea9d2bc96 ("policy: remove CIL workarounds for missing anon_inode class")
> Reported-by: Dennis (Zhuoheng) Li <denli@redhat.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index 8abd438..f473111 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -134,10 +134,12 @@ endif
>  endif
>
>  ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
> +ifeq ($(shell grep -q anon_inode $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  ifeq ($(shell test -e $(INCLUDEDIR)/linux/userfaultfd.h && echo true),true)
>  SUBDIRS += userfaultfd
>  endif
>  endif
> +endif
>
>  ifeq ($(shell grep -q vsock_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  ifeq ($(shell grep -qs VMADDR_CID_LOCAL $(INCLUDEDIR)/linux/vm_sockets.h && echo true),true)
> --
> 2.37.2
>

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/772446c98a922f771e80245f0115485428dd43a8

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

