Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0981C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 15:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7049164F70
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 15:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhCDPEU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:04:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233116AbhCDPD4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 10:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614870150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C61b/3hmpTTmWPc5HtjS+UK+fBAersUrQWHFSrQolDM=;
        b=X/IPOu/hsqzmwuJlCkPnwhI++H1Ih7EToM1fXJI4bvPawK0HQ3lqrozFH5yE6+HNB3d54h
        yflz0ur2gYK5YXzRmso0EVXmTh8OqUm71Kd360T4JQpZDfvDfIrlmFnzmaBvFR+nWXSapn
        kgBEBzwOwze9yBShHBucnkF2b3Ff3Kg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-_N446qHCMSuq2KzObZfTvQ-1; Thu, 04 Mar 2021 10:02:29 -0500
X-MC-Unique: _N446qHCMSuq2KzObZfTvQ-1
Received: by mail-yb1-f199.google.com with SMTP id b127so18340863ybc.13
        for <selinux@vger.kernel.org>; Thu, 04 Mar 2021 07:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C61b/3hmpTTmWPc5HtjS+UK+fBAersUrQWHFSrQolDM=;
        b=pxpOPeOatwooNvcDHRgtR6FScISwA9jovKG+RjBAHOiloAhs9buyD06hPir5jcOD8p
         HOPZGMT8RSZ/HT91jFws0WX/h06tQH+NIn7PTCSz1qzn41UDVe5ABUiy/M03qYLR0frw
         NvDNc4cRp/PNWc+BGASbo2vl7giVI+7qeol6sMk61VfHXBXkWLRflcyNiWOaob3PjIVv
         IhgY1zCpY/N+Klw3EDV26PbPa4JlHds2X3BDBzqgWaNLpb1ry9APz8ehAUSa3BlzuaTu
         dYWjIlFJ6bsIK/4GU+4mmdtqBPOTMkruZdX/XXFuRe5+kG8UF3VFav9mYtArfwuXxnG8
         eDRw==
X-Gm-Message-State: AOAM533aXZm4/QouFO79YC0U0cANnVsVdGP2yUdSrAPXfJanZvbM5901
        3nywOkeWrRk/ozFHrMWSujhESUBKy5dhrdLZQfRhI7u5r+dZzYeJ4oPoF5dNnA6h2datKPFcARE
        o+asxB03FOVTXTFwLCZPOooquVUXxyKfINQ==
X-Received: by 2002:a25:d104:: with SMTP id i4mr7026595ybg.227.1614870148194;
        Thu, 04 Mar 2021 07:02:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWL3ZXZYsgDJtlytO4a354W81nJHXp6CnWxBs46Zo5L1g6ThA3lnVGXS9Ju1X5c5xNxBYCK/Wk0unZ4zBpIAo=
X-Received: by 2002:a25:d104:: with SMTP id i4mr7026562ybg.227.1614870147975;
 Thu, 04 Mar 2021 07:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20210301171922.321907-1-omosnace@redhat.com> <871rcv9dww.fsf@redhat.com>
In-Reply-To: <871rcv9dww.fsf@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 4 Mar 2021 16:02:16 +0100
Message-ID: <CAFqZXNuzTSEok=x3ZyVyQvUK_DsBS6Ykfxk6DrUPLpnF+TQGRw@mail.gmail.com>
Subject: Re: [PATCH userspace] fixfiles: do not exclude /dev and /run in -C mode
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 4, 2021 at 3:44 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> Ondrej Mosnacek <omosnace@redhat.com> writes:
>
> > I can't think of a good reason why they should be excluded. On the
> > contrary, excluding them can cause trouble very easily if some labeling
> > rules for these directories change. For example, we changed the label
> > for /dev/nvme* from nvme_device_t to fixed_disk_device_t in Fedora
> > (updating the allow rules accordingly) and after policy update they
> > ended up with an invalid context, causing denials.
>
> I guess that /dev/ is there in order to avoid relabeling tty devices and block
> the user from access:
>
> [root@localhost ~]# ls -Z /dev/tty1
> user_u:object_r:user_tty_device_t:s0 /dev/tty1
>
> [root@localhost ~]# matchpathcon /dev/tty1
> /dev/tty1       system_u:object_r:tty_device_t:s0

$ sudo chcon user_u:object_r:user_tty_device_t:s0 /dev/tty21
$ ll -Z /dev/tty21
crw--w----. 1 root tty user_u:object_r:user_tty_device_t:s0 4, 21 feb
26 15:13 /dev/tty21
$ sudo restorecon -v /dev/tty21
/dev/tty21 not reset as customized by admin to
user_u:object_r:user_tty_device_t:s0
$ ll -Z /dev/tty21
crw--w----. 1 root tty user_u:object_r:user_tty_device_t:s0 4, 21 feb
26 15:13 /dev/tty21

$ cat /etc/selinux/targeted/contexts/customizable_types
container_file_t
sandbox_file_t
svirt_image_t
svirt_home_t
svirt_sandbox_file_t
virt_content_t
httpd_user_htaccess_t
httpd_user_script_exec_t
httpd_user_rw_content_t
httpd_user_ra_content_t
httpd_user_content_t
git_session_content_t
home_bin_t
user_tty_device_t

restorecon also doesn't change the user portion of the label if I only
change that to user_u (leaving the type as tty_device_t).

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

