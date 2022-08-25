Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13680C04AA5
	for <selinux@archiver.kernel.org>; Thu, 25 Aug 2022 08:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiHYIHZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Aug 2022 04:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiHYIHY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Aug 2022 04:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0ED58B41
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661414842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AYjB174NI8e/xs/0pv7szPQ5VOSUY06YknH+YF5fE20=;
        b=PhBuWZWr7R59pmdc0hG1t2hzNndS2tHpeLKsRexdLQkMXBVo1u6cIkzAF6DIbitIpWQ6FW
        ue5zlMt8qjl8A27ru5nTfJ09XcrjPhxnAJkzJsv3epifWp4ToXt3xbPY58T11+sWEU39hU
        WQPU8WwW4sp5L1lDhgcm2NkoV0XdloU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-286-MscYGlb4Ow-m4kCi0APwkA-1; Thu, 25 Aug 2022 04:07:21 -0400
X-MC-Unique: MscYGlb4Ow-m4kCi0APwkA-1
Received: by mail-ed1-f70.google.com with SMTP id r20-20020a05640251d400b00446e3eee8a1so6599530edd.21
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 01:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AYjB174NI8e/xs/0pv7szPQ5VOSUY06YknH+YF5fE20=;
        b=XuOrupDsdyPCkiQnhrJijHP72qSoXPnCPO9049E2v/SItjHh83QB0XL7J3h18TEqRL
         x8IFnTmOLrnq8UR1HJdlTtoprdthB1x6ly00jx93hvBOD91LsNiG/Fb8FENDLZDA2qit
         eOZRJzWkKNTEujbQES8/yQ9nP8noBo0SKqVm1esOZw2xZPslXYgTtyFublpK0Tn7th07
         hVFP+ovHrKWvu5WKFZ0J2Z8pokoXeQzI5T70j9JP36qqRkoAfZ3KjZxghBv8rbqddtFr
         Ou0k8mMbCNyXOodxf5qdQfkh0kFZ9EKDdMwqTHXZQDT/3XVIc416TtglsHxWpro3Yo3k
         m3NA==
X-Gm-Message-State: ACgBeo0slNrFCyTiFJhXx6SiHDHzgUzM79/t2eOdP/S8qvHxg1A54ogY
        2OABtzyWkKblQhaesTjClnwCq2aDQTlJklbkciq/7/TG9dyYyJZMw90uqDyIMHxhqqhNdiHfcvi
        wjxvUnQnysXAFe8JY38YXCZ18yawC6WY7fg==
X-Received: by 2002:a17:906:8cb0:b0:739:4c35:75d8 with SMTP id qr48-20020a1709068cb000b007394c3575d8mr1580266ejc.711.1661414839409;
        Thu, 25 Aug 2022 01:07:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7I/Ra/ymGNvLz1Y8b6/GinvyYungjJdxgVfeX+M3/Bt9zJx6O7hX3lYg6nPqWT33hte6LIEC21UB5V8N004iM=
X-Received: by 2002:a17:906:8cb0:b0:739:4c35:75d8 with SMTP id
 qr48-20020a1709068cb000b007394c3575d8mr1580254ejc.711.1661414839172; Thu, 25
 Aug 2022 01:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <166135970524.184778.17486058814645360372.stgit@olly>
In-Reply-To: <166135970524.184778.17486058814645360372.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 25 Aug 2022 10:07:08 +0200
Message-ID: <CAFqZXNshMbqDhRVZrBg=fNRo0ORfD3s5ffqFMyz1Ds-GbNfSyA@mail.gmail.com>
Subject: Re: [PATCH] tests/filesystem/xfs: use a 300M xfs filesystem image
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 24, 2022 at 6:50 PM Paul Moore <paul@paul-moore.com> wrote:
> Recent versions of mkfs.xfs require at least a 300M image to work
> properly which unfortunately causes a large number of xfs test
> failures as the test suite only allocates 16M for a filesystem
> image.  This patch increases the xfs image size to 300M while
> leaving the existing 16M image size for all other filesystem types.
>
> This was first noticed with xfsprogs v5.19.0 but it is possible
> earlier versions are also affected.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tests/filesystem/Filesystem.pm |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
> index e3cd8ee..bd91a11 100644
> --- a/tests/filesystem/Filesystem.pm
> +++ b/tests/filesystem/Filesystem.pm
> @@ -122,10 +122,14 @@ sub attach_dev {
>
>  sub make_fs {
>      my ( $mk_type, $mk_dev, $mk_dir ) = @_;
> +    my $mk_size = 16;
> +    if ( $mk_type eq "xfs" ) {
> +        $mk_size = 300;
> +    }
>      print "Create $mk_dir/fstest with dd\n";
>      $result =
>        system(
> -        "dd if=/dev/zero of=$mk_dir/fstest bs=4096 count=4096 2>/dev/null");
> +        "dd if=/dev/zero of=$mk_dir/fstest bs=1M count=$mk_size 2>/dev/null");
>      if ( $result != 0 ) {
>          print "dd failed to create $mk_dir/fstest\n";
>      }
>

Thanks! I applied this with a minor edit in the patch description
(added upstream xfsprogs commit reference):

https://github.com/SELinuxProject/selinux-testsuite/commit/c592d7f49e5e8ca907d90cb1d6f54bb0d410d442

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

