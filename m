Return-Path: <SRS0=JJ8R=XP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE590C49ED7
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 12:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74C2206B6
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 12:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjhgOyQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438366AbfITM0S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:26:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41885 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438330AbfITM0S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Sep 2019 08:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568982376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrE91GiAZzckeyBkMDIyeImh0DsQ6LRpTQYZddV41kM=;
        b=OjhgOyQ53MKIVXt4/+GrTliayhR743nRCv4GrXkgt7ty9N8mfo3NAn+a9OureZgjCIcyfF
        z6dSEbA1GfsmobnSQkvhqscEvvhKLPJAdArYaoOWXFR9FB9YI5hyrAR5FyzTKC5/W3zm2M
        2732lvjPPS5PpkfElfs88D1t8p+mZFw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-H89qJLVmP5CGpeWPPZ3Uug-1; Fri, 20 Sep 2019 08:26:13 -0400
Received: by mail-oi1-f197.google.com with SMTP id r67so939627oif.18
        for <selinux@vger.kernel.org>; Fri, 20 Sep 2019 05:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nnEXZaEcgiZyPtoSBqILJuiRzQTx6HsbFA4Kautzh+I=;
        b=O4HEU0bwQb8SxYxBmzxoBd2oB7pn3depbqF4K2ap5ZGsN1zUXkhWZEjNkGrnceeagE
         f4kg/6g9qAEXtUF20L2wQy3zJo4E2yGIsbTnG8K1MHN/mMZxU1QT3CHZQfal/rovXljK
         ymEM8OnOMyEFwkvusFi1Pa2Qdhe19aL4fy8DlEeRQDfatin+qwpDeLqGf3Y0SvybvXgU
         XmcI3oj6YWcNqB11CqB4IO29ZNIQRVCvYHnrnum+wLJDt5pzcvA/eDyGXSgIzm6qew2l
         JJhcKvomSfVuUnUzL+PDhnlgAuw+jI2X6BHLquos70bdncsyLp3amVoFBo78GkG613D2
         2P+w==
X-Gm-Message-State: APjAAAU+Raq5XG5JAQz5VgOF0HUlblf6dMGOmhzsTPf6ZpwV9A2vku8r
        DT2kkZY5r9y2iFXkWOI6mGQ5tg4tSSAMedMkxQYAZ6BdWLF9/7QeoajmKvAXrDQGpD4O1UzIWKe
        WUAi2L3mjmh55CfCGvAJnjswFi4LSy5R3hQ==
X-Received: by 2002:aca:5781:: with SMTP id l123mr2662090oib.166.1568982372731;
        Fri, 20 Sep 2019 05:26:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyWEbctaO2ItPaW6dKtzrIZc09jpI8n2NM7YxPgbzlVbIraimMaQSA9Czr/V21Sd4tnqvyZ+y7AzPFSDTTzJCk=
X-Received: by 2002:aca:5781:: with SMTP id l123mr2662074oib.166.1568982372427;
 Fri, 20 Sep 2019 05:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190920101510.13907-1-omosnace@redhat.com>
In-Reply-To: <20190920101510.13907-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 20 Sep 2019 14:26:01 +0200
Message-ID: <CAFqZXNvWSEj=YOXG2XQaa2jVXQZVw1NoEgwr7_TsnzuZN0U=AA@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/2] RFE: remove special RHEL-5 and -4 policies
To:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: H89qJLVmP5CGpeWPPZ3Uug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 20, 2019 at 12:15 PM Ondrej Mosnacek <omosnace@redhat.com> wrot=
e:
> The first patch fixes a minor issue from a recent commit that breaks
> the task_setscheduler test on very old kernels (RHEL-5).
>
> The second patch then removes the special policies for RHEL-5 nad RHEL-4
> (see the log message for more details).

Looks like the second patch didn't make it to the mailing list...
probably because it is too big removing so many lines.

Please refer to the corresponding GH pull request for full patches:
https://github.com/SELinuxProject/selinux-testsuite/pull/66

>
> Verified that the testsuite still runs on Fedora Rawhide and a handful
> of RHELs after this change (RHEL-5 needs some workarounds to be applied
> to policy files - see the log message of patch 2).
>
> Ondrej Mosnacek (2):
>   tests/task_setscheduler: fix for old kernels
>   policy: remove RHEL-5 and RHEL-4 special policies
>
>  policy/Makefile                          |  55 ++++--------
>  policy/redhat/4/Makefile                 |  23 -----
>  policy/redhat/4/test_attrib.te           |  38 --------
>  policy/redhat/4/test_capable_file.te     |  46 ----------
>  policy/redhat/4/test_capable_net.te      |  30 -------
>  policy/redhat/4/test_capable_sys.te      |  15 ----
>  policy/redhat/4/test_dyntrace.te         |  35 --------
>  policy/redhat/4/test_dyntrans.te         |  20 -----
>  policy/redhat/4/test_entrypoint.te       |  17 ----
>  policy/redhat/4/test_execshare.te        |  24 -----
>  policy/redhat/4/test_exectrace.te        |  33 -------
>  policy/redhat/4/test_execute_no_trans.te |  20 -----
>  policy/redhat/4/test_fdreceive.te        |  52 -----------
>  policy/redhat/4/test_file.te             |  60 -------------
>  policy/redhat/4/test_global.te           |  77 ----------------
>  policy/redhat/4/test_inherit.te          |  41 ---------
>  policy/redhat/4/test_ioctl.te            |  25 ------
>  policy/redhat/4/test_ipc.te              |  63 -------------
>  policy/redhat/4/test_link.te             |  49 -----------
>  policy/redhat/4/test_mkdir.te            |  38 --------
>  policy/redhat/4/test_open.te             |  23 -----
>  policy/redhat/4/test_ptrace.te           |  28 ------
>  policy/redhat/4/test_readlink.te         |  22 -----
>  policy/redhat/4/test_relabel.te          |  28 ------
>  policy/redhat/4/test_rename.te           |  76 ----------------
>  policy/redhat/4/test_rxdir.te            |  21 -----
>  policy/redhat/4/test_setattr.te          |  21 -----
>  policy/redhat/4/test_setnice.te          |  23 -----
>  policy/redhat/4/test_sigkill.te          |  29 ------
>  policy/redhat/4/test_socket.te           |  92 -------------------
>  policy/redhat/4/test_stat.te             |  18 ----
>  policy/redhat/4/test_sysctl.te           |  21 -----
>  policy/redhat/4/test_task_create.te      |  39 ---------
>  policy/redhat/4/test_task_getpgid.te     |  22 -----
>  policy/redhat/4/test_task_getsched.te    |  22 -----
>  policy/redhat/4/test_task_getsid.te      |  22 -----
>  policy/redhat/4/test_task_setpgid.te     |  36 --------
>  policy/redhat/4/test_task_setsched.te    |  29 ------
>  policy/redhat/4/test_transition.te       |  20 -----
>  policy/redhat/4/test_wait.te             |  27 ------
>  policy/redhat/5/Makefile                 |  36 --------
>  policy/redhat/5/test_capable_file.te     |  64 --------------
>  policy/redhat/5/test_capable_net.te      |  61 -------------
>  policy/redhat/5/test_capable_sys.te      |  20 -----
>  policy/redhat/5/test_dyntrace.te         |  48 ----------
>  policy/redhat/5/test_dyntrans.te         |  32 -------
>  policy/redhat/5/test_entrypoint.te       |  21 -----
>  policy/redhat/5/test_execshare.te        |  43 ---------
>  policy/redhat/5/test_exectrace.te        |  51 -----------
>  policy/redhat/5/test_execute_no_trans.te |  26 ------
>  policy/redhat/5/test_fdreceive.te        |  65 --------------
>  policy/redhat/5/test_file.te             |  98 ---------------------
>  policy/redhat/5/test_global.te           |  85 ------------------
>  policy/redhat/5/test_inherit.te          |  64 --------------
>  policy/redhat/5/test_ioctl.te            |  44 ----------
>  policy/redhat/5/test_ipc.te              |  82 -----------------
>  policy/redhat/5/test_link.te             |  73 ----------------
>  policy/redhat/5/test_mkdir.te            |  59 -------------
>  policy/redhat/5/test_open.te             |  35 --------
>  policy/redhat/5/test_ptrace.te           |  47 ----------
>  policy/redhat/5/test_readlink.te         |  36 --------
>  policy/redhat/5/test_relabel.te          |  44 ----------
>  policy/redhat/5/test_rename.te           | 107 -----------------------
>  policy/redhat/5/test_rxdir.te            |  34 -------
>  policy/redhat/5/test_setattr.te          |  31 -------
>  policy/redhat/5/test_setnice.te          |  52 -----------
>  policy/redhat/5/test_sigkill.te          |  49 -----------
>  policy/redhat/5/test_stat.te             |  31 -------
>  policy/redhat/5/test_sysctl.te           |  29 ------
>  policy/redhat/5/test_task_create.te      |  53 -----------
>  policy/redhat/5/test_task_getpgid.te     |  31 -------
>  policy/redhat/5/test_task_getsched.te    |  31 -------
>  policy/redhat/5/test_task_getsid.te      |  31 -------
>  policy/redhat/5/test_task_setpgid.te     |  44 ----------
>  policy/redhat/5/test_task_setsched.te    |  38 --------
>  policy/redhat/5/test_transition.te       |  33 -------
>  policy/redhat/5/test_wait.te             |  41 ---------
>  policy/test_task_setsched.te             |   1 +
>  tests/task_setscheduler/test             |   2 +-
>  79 files changed, 18 insertions(+), 3134 deletions(-)
>  delete mode 100644 policy/redhat/4/Makefile
>  delete mode 100644 policy/redhat/4/test_attrib.te
>  delete mode 100644 policy/redhat/4/test_capable_file.te
>  delete mode 100644 policy/redhat/4/test_capable_net.te
>  delete mode 100644 policy/redhat/4/test_capable_sys.te
>  delete mode 100644 policy/redhat/4/test_dyntrace.te
>  delete mode 100644 policy/redhat/4/test_dyntrans.te
>  delete mode 100644 policy/redhat/4/test_entrypoint.te
>  delete mode 100644 policy/redhat/4/test_execshare.te
>  delete mode 100644 policy/redhat/4/test_exectrace.te
>  delete mode 100644 policy/redhat/4/test_execute_no_trans.te
>  delete mode 100644 policy/redhat/4/test_fdreceive.te
>  delete mode 100644 policy/redhat/4/test_file.te
>  delete mode 100644 policy/redhat/4/test_global.te
>  delete mode 100644 policy/redhat/4/test_inherit.te
>  delete mode 100644 policy/redhat/4/test_ioctl.te
>  delete mode 100644 policy/redhat/4/test_ipc.te
>  delete mode 100644 policy/redhat/4/test_link.te
>  delete mode 100644 policy/redhat/4/test_mkdir.te
>  delete mode 100644 policy/redhat/4/test_open.te
>  delete mode 100644 policy/redhat/4/test_ptrace.te
>  delete mode 100644 policy/redhat/4/test_readlink.te
>  delete mode 100644 policy/redhat/4/test_relabel.te
>  delete mode 100644 policy/redhat/4/test_rename.te
>  delete mode 100644 policy/redhat/4/test_rxdir.te
>  delete mode 100644 policy/redhat/4/test_setattr.te
>  delete mode 100644 policy/redhat/4/test_setnice.te
>  delete mode 100644 policy/redhat/4/test_sigkill.te
>  delete mode 100644 policy/redhat/4/test_socket.te
>  delete mode 100644 policy/redhat/4/test_stat.te
>  delete mode 100644 policy/redhat/4/test_sysctl.te
>  delete mode 100644 policy/redhat/4/test_task_create.te
>  delete mode 100644 policy/redhat/4/test_task_getpgid.te
>  delete mode 100644 policy/redhat/4/test_task_getsched.te
>  delete mode 100644 policy/redhat/4/test_task_getsid.te
>  delete mode 100644 policy/redhat/4/test_task_setpgid.te
>  delete mode 100644 policy/redhat/4/test_task_setsched.te
>  delete mode 100644 policy/redhat/4/test_transition.te
>  delete mode 100644 policy/redhat/4/test_wait.te
>  delete mode 100644 policy/redhat/5/Makefile
>  delete mode 100644 policy/redhat/5/test_capable_file.te
>  delete mode 100644 policy/redhat/5/test_capable_net.te
>  delete mode 100644 policy/redhat/5/test_capable_sys.te
>  delete mode 100644 policy/redhat/5/test_dyntrace.te
>  delete mode 100644 policy/redhat/5/test_dyntrans.te
>  delete mode 100644 policy/redhat/5/test_entrypoint.te
>  delete mode 100644 policy/redhat/5/test_execshare.te
>  delete mode 100644 policy/redhat/5/test_exectrace.te
>  delete mode 100644 policy/redhat/5/test_execute_no_trans.te
>  delete mode 100644 policy/redhat/5/test_fdreceive.te
>  delete mode 100644 policy/redhat/5/test_file.te
>  delete mode 100644 policy/redhat/5/test_global.te
>  delete mode 100644 policy/redhat/5/test_inherit.te
>  delete mode 100644 policy/redhat/5/test_ioctl.te
>  delete mode 100644 policy/redhat/5/test_ipc.te
>  delete mode 100644 policy/redhat/5/test_link.te
>  delete mode 100644 policy/redhat/5/test_mkdir.te
>  delete mode 100644 policy/redhat/5/test_open.te
>  delete mode 100644 policy/redhat/5/test_ptrace.te
>  delete mode 100644 policy/redhat/5/test_readlink.te
>  delete mode 100644 policy/redhat/5/test_relabel.te
>  delete mode 100644 policy/redhat/5/test_rename.te
>  delete mode 100644 policy/redhat/5/test_rxdir.te
>  delete mode 100644 policy/redhat/5/test_setattr.te
>  delete mode 100644 policy/redhat/5/test_setnice.te
>  delete mode 100644 policy/redhat/5/test_sigkill.te
>  delete mode 100644 policy/redhat/5/test_stat.te
>  delete mode 100644 policy/redhat/5/test_sysctl.te
>  delete mode 100644 policy/redhat/5/test_task_create.te
>  delete mode 100644 policy/redhat/5/test_task_getpgid.te
>  delete mode 100644 policy/redhat/5/test_task_getsched.te
>  delete mode 100644 policy/redhat/5/test_task_getsid.te
>  delete mode 100644 policy/redhat/5/test_task_setpgid.te
>  delete mode 100644 policy/redhat/5/test_task_setsched.te
>  delete mode 100644 policy/redhat/5/test_transition.te
>  delete mode 100644 policy/redhat/5/test_wait.te
>
> --
> 2.21.0
>


--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

