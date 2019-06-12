Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6098DC31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 19:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2247E20B7C
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 19:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muog1iJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbfFLT5t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:57:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36671 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbfFLT5t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jun 2019 15:57:49 -0400
Received: by mail-it1-f194.google.com with SMTP id r135so12625274ith.1
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TMFbRFD8BTBt6FLIPcDKzz+3eh7SPO6IVKD+VliDng=;
        b=muog1iJONbpGvtwqPY/H3xKhTgn3SIXWBho2cVVsgEt3PWAVcQ9kScD9sQmlF8V7Oi
         VOPIRR/oefojLh9VWeJ2NwIaG8OdQcx7W4YCy+HDQMIX9mxa2LjvCS5k3bOckJOgCjLZ
         w01RmvmiPFeFle5EUsTdW68c3C/NQs3wRkI5lhwgWN+rwjvPFqAx54idFIT4xx9yvW5D
         gnY+Cfr7QqHMUZKu3ytZhNeXTeN49Bnk+lsOeYq5sC/dyzhOGEzt83e5/+uHeJg7/D/e
         yjej6Ein/z69elm+iHMPiKEJ4mXO1qPmClQP8O80YbzgfxJx84SyKdgZu7t3z/niZq0g
         Nm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TMFbRFD8BTBt6FLIPcDKzz+3eh7SPO6IVKD+VliDng=;
        b=hg2TaanNHyb1C/KWdg0wSJtUznkY3+U3uxPxe+dOmITlF5Km5k7lsB/eRAZVHJ10tp
         upiZDVokFrFg97NSH5ULXG+BVSu2EBPs/zZoT7XpfT03/EtXCwz2oprCihkP6Vpvslpb
         RLbTzZSon9fPXhAphg2XY6MlrOyNKtPuHqZYnDHFOUA8SPYqlxMZ/j0v6Y/9xmM9WUhJ
         fWgz+pJ1vvIvgP5g1WIPI+sZPMbJPeBG2GqJLbhFgqbAOd6u/WpfckUYPrFsUFsQ+x/T
         BYGDGKcFAFh+bH7nW43v85i2+eBCZU3pU3QhxJ4vtMg4lXeHt/IZn2VesWHmKIntOyIK
         06NQ==
X-Gm-Message-State: APjAAAUq0uPBVfrL4iqCaMgdkQonozqvmp1p2ifL20VqURTPFj1nsrpF
        SY4izsVKefkHp05CmTq6GWHZxUnOQt+ofIWPtEU=
X-Google-Smtp-Source: APXvYqxk3j4frSf/mKUmD42scE6uAiwsg42bbIIoHQnvsqVxmuSHDA5H3eoqadpiiVOTQugOjlx39iD2wcY2NqSpSS4=
X-Received: by 2002:a02:4e05:: with SMTP id r5mr38945030jaa.27.1560369468656;
 Wed, 12 Jun 2019 12:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190612080404.4529-1-jzarsky@redhat.com>
In-Reply-To: <20190612080404.4529-1-jzarsky@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 12 Jun 2019 12:57:36 -0700
Message-ID: <CAFftDdrV3uf826jqrFE8hBzJ7a3uJGuA02J9p+ce+GCqwT7+8w@mail.gmail.com>
Subject: Re: [PATCH 00/11] libsemanage: add tests
To:     Jan Zarsky <jzarsky@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 12, 2019 at 1:44 AM Jan Zarsky <jzarsky@redhat.com> wrote:
>
> This series adds new test suites for libsemanage. In the first patch, common
> helper functions are added. The other patches are independent and each adds a
> new test suite.
>
> The test suites are testing only the public API and aim for line coverage. They
> test only correct usage of the functions. Together with valgrind, the test
> suites can be used for detecting memory leaks.
>
> The tests run fine in Travis CI and do not require an SELinux-enabled system.
>
> I welcome any suggestions.
>
> Jan Zarsky (11):
>   libsemanage: add helper functions to tests
>   libsemanage: test semanage_handle_* functions
>   libsemanage: test semanage_bool_* functions
>   libsemanage: test semanage_fcontext functions
>   libsemanage: test semanage_iface_* functions
>   libsemanage: test semanage_ibendport_* functions
>   libsemanage: test semanage_node_* functions
>   libsemanage: test semanage_port_* functions
>   libsemanage: test semanage_user_* functions
>   libsemanage: test semanage_context_* functions
>   libsemanage: test semanage_msg_default_handler
>
>  libsemanage/tests/.gitignore            |    1 +
>  libsemanage/tests/Makefile              |   11 +-
>  libsemanage/tests/libsemanage-tests.c   |   18 +
>  libsemanage/tests/test_bool.c           |  932 +++++++++++++++++++++++++++
>  libsemanage/tests/test_bool.cil         |   24 +
>  libsemanage/tests/test_bool.h           |   31 +
>  libsemanage/tests/test_fcontext.c       | 1045 +++++++++++++++++++++++++++++++
>  libsemanage/tests/test_fcontext.cil     |   25 +
>  libsemanage/tests/test_fcontext.h       |   30 +
>  libsemanage/tests/test_handle.c         |  329 ++++++++++
>  libsemanage/tests/test_handle.cil       |   21 +
>  libsemanage/tests/test_handle.h         |   30 +
>  libsemanage/tests/test_ibendport.c      |  525 ++++++++++++++++
>  libsemanage/tests/test_ibendport.cil    |   28 +
>  libsemanage/tests/test_ibendport.h      |   30 +
>  libsemanage/tests/test_iface.c          |  666 ++++++++++++++++++++
>  libsemanage/tests/test_iface.cil        |   28 +
>  libsemanage/tests/test_iface.h          |   30 +
>  libsemanage/tests/test_node.c           |  807 ++++++++++++++++++++++++
>  libsemanage/tests/test_node.cil         |   28 +
>  libsemanage/tests/test_node.h           |   30 +
>  libsemanage/tests/test_other.c          |  120 ++++
>  libsemanage/tests/test_other.h          |   30 +
>  libsemanage/tests/test_port.c           |  909 +++++++++++++++++++++++++++
>  libsemanage/tests/test_port.cil         |   27 +
>  libsemanage/tests/test_port.h           |   30 +
>  libsemanage/tests/test_semanage_store.c |    2 +-
>  libsemanage/tests/test_user.c           |  690 ++++++++++++++++++++
>  libsemanage/tests/test_user.cil         |   27 +
>  libsemanage/tests/test_user.h           |   30 +
>  libsemanage/tests/utilities.c           |  254 +++++++-
>  libsemanage/tests/utilities.h           |   53 +-
>  32 files changed, 6831 insertions(+), 10 deletions(-)
>
>
Ack
Staged: https://github.com/SELinuxProject/selinux/pull/159
