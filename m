Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA4AC31E5B
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6240B2187F
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzpBI+5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfFSQD4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:03:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44061 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFSQD4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 12:03:56 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so36616iob.11
        for <selinux@vger.kernel.org>; Wed, 19 Jun 2019 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0rwFt/FANGO1BazDqs/w2ZPfykGevi5X6dxwSTkaxI=;
        b=fzpBI+5sesbq+5Wj8J+BmuHbJluu02pgkLvXLIHbIAPlji1jsntOCAzgxXsn4f0X0g
         cqpgOFKpM2v3wyNABL0O7JJpv0aN2XfcEQ4agj00QjUTE0JtPx6+Mg2rqd5+5ItMS9wZ
         7Cpr7ONSuYlVYGvhTykVBT0zoV7hUjCW2ud2y981PI7tCiAXdd0yxpe3n9rN7QraeUto
         qLowy3uFSpYMn+CtQKUxmGAs8222/2O93cMcGlNdXHsI0hzuSWtUmnkFxVOJ2KpFFmoe
         wyyiXLaMVkMe0m2ySrwXWZe9ug3qU5ehboUfeHSzhS0WIuYncJs/8Phtf7tLZPTafDUS
         n/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0rwFt/FANGO1BazDqs/w2ZPfykGevi5X6dxwSTkaxI=;
        b=NgnmzltKjhU9euJZouAxVbtdZdyij9UwpYTNYxc0W8pAuW+cXLjrDV5OCW4G8R6ApK
         IXyWsIHyn0CP3B7gKtkq8TzxI0R0hguV1FynyyK13jcVxAzSVb23VJKeSDE4cH8CehqL
         n9zXIsLhz1AsUMoPsEnVGRXoF651cUKg4OSKMZV41xhM4UuH/6s0xLnZ8AD4X5naE9pd
         lPk2213JlZStmJH5eCWsMxiM5DaCx/A74706+GIrMWan6XTHvbTVn48csdlmYGrCNJhE
         /PnXHSH09VreGf+YLL3THRsaWFNjWhPT1D2KoNt02eYG55FmSwQmXLEuZiX7EdBQFdlI
         byBg==
X-Gm-Message-State: APjAAAWpfvcSnYXv45N8MYHSMtzrzCTJ+/39vPirEryb0buG1bxjWZ4J
        zdkS071BF5dPQoM2PEEJyevqIv/7lzn381GubOURMQUi
X-Google-Smtp-Source: APXvYqxTd2Kg/zCdBMfG8p0hF+dcnqDuHEchT8IyiC7k6cR8qj4i6UemUd/fNtLumm5VlpXHtnDAXzLr3keD643Bpk4=
X-Received: by 2002:a05:6638:38a:: with SMTP id y10mr11594879jap.104.1560960234823;
 Wed, 19 Jun 2019 09:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190612080404.4529-1-jzarsky@redhat.com> <CAFftDdrV3uf826jqrFE8hBzJ7a3uJGuA02J9p+ce+GCqwT7+8w@mail.gmail.com>
In-Reply-To: <CAFftDdrV3uf826jqrFE8hBzJ7a3uJGuA02J9p+ce+GCqwT7+8w@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 19 Jun 2019 09:04:20 -0700
Message-ID: <CAFftDdpD3Y3D3QgCRF8+LAAcch=y63E2OYQArzqiytT83Pqp1g@mail.gmail.com>
Subject: Re: [PATCH 00/11] libsemanage: add tests
To:     Jan Zarsky <jzarsky@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

merged

On Wed, Jun 12, 2019 at 12:57 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Wed, Jun 12, 2019 at 1:44 AM Jan Zarsky <jzarsky@redhat.com> wrote:
> >
> > This series adds new test suites for libsemanage. In the first patch, common
> > helper functions are added. The other patches are independent and each adds a
> > new test suite.
> >
> > The test suites are testing only the public API and aim for line coverage. They
> > test only correct usage of the functions. Together with valgrind, the test
> > suites can be used for detecting memory leaks.
> >
> > The tests run fine in Travis CI and do not require an SELinux-enabled system.
> >
> > I welcome any suggestions.
> >
> > Jan Zarsky (11):
> >   libsemanage: add helper functions to tests
> >   libsemanage: test semanage_handle_* functions
> >   libsemanage: test semanage_bool_* functions
> >   libsemanage: test semanage_fcontext functions
> >   libsemanage: test semanage_iface_* functions
> >   libsemanage: test semanage_ibendport_* functions
> >   libsemanage: test semanage_node_* functions
> >   libsemanage: test semanage_port_* functions
> >   libsemanage: test semanage_user_* functions
> >   libsemanage: test semanage_context_* functions
> >   libsemanage: test semanage_msg_default_handler
> >
> >  libsemanage/tests/.gitignore            |    1 +
> >  libsemanage/tests/Makefile              |   11 +-
> >  libsemanage/tests/libsemanage-tests.c   |   18 +
> >  libsemanage/tests/test_bool.c           |  932 +++++++++++++++++++++++++++
> >  libsemanage/tests/test_bool.cil         |   24 +
> >  libsemanage/tests/test_bool.h           |   31 +
> >  libsemanage/tests/test_fcontext.c       | 1045 +++++++++++++++++++++++++++++++
> >  libsemanage/tests/test_fcontext.cil     |   25 +
> >  libsemanage/tests/test_fcontext.h       |   30 +
> >  libsemanage/tests/test_handle.c         |  329 ++++++++++
> >  libsemanage/tests/test_handle.cil       |   21 +
> >  libsemanage/tests/test_handle.h         |   30 +
> >  libsemanage/tests/test_ibendport.c      |  525 ++++++++++++++++
> >  libsemanage/tests/test_ibendport.cil    |   28 +
> >  libsemanage/tests/test_ibendport.h      |   30 +
> >  libsemanage/tests/test_iface.c          |  666 ++++++++++++++++++++
> >  libsemanage/tests/test_iface.cil        |   28 +
> >  libsemanage/tests/test_iface.h          |   30 +
> >  libsemanage/tests/test_node.c           |  807 ++++++++++++++++++++++++
> >  libsemanage/tests/test_node.cil         |   28 +
> >  libsemanage/tests/test_node.h           |   30 +
> >  libsemanage/tests/test_other.c          |  120 ++++
> >  libsemanage/tests/test_other.h          |   30 +
> >  libsemanage/tests/test_port.c           |  909 +++++++++++++++++++++++++++
> >  libsemanage/tests/test_port.cil         |   27 +
> >  libsemanage/tests/test_port.h           |   30 +
> >  libsemanage/tests/test_semanage_store.c |    2 +-
> >  libsemanage/tests/test_user.c           |  690 ++++++++++++++++++++
> >  libsemanage/tests/test_user.cil         |   27 +
> >  libsemanage/tests/test_user.h           |   30 +
> >  libsemanage/tests/utilities.c           |  254 +++++++-
> >  libsemanage/tests/utilities.h           |   53 +-
> >  32 files changed, 6831 insertions(+), 10 deletions(-)
> >
> >
> Ack
> Staged: https://github.com/SELinuxProject/selinux/pull/159
