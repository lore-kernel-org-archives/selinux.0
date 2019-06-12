Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B37C31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4982720684
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436770AbfFLIEk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:04:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfFLIEk (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 937EFC1EB1F4
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:40 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B22F783AC
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:39 +0000 (UTC)
From:   Jan Zarsky <jzarsky@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 00/11] libsemanage: add tests
Date:   Wed, 12 Jun 2019 10:03:53 +0200
Message-Id: <20190612080404.4529-1-jzarsky@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 12 Jun 2019 08:04:40 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series adds new test suites for libsemanage. In the first patch, common
helper functions are added. The other patches are independent and each adds a
new test suite.

The test suites are testing only the public API and aim for line coverage. They
test only correct usage of the functions. Together with valgrind, the test
suites can be used for detecting memory leaks.

The tests run fine in Travis CI and do not require an SELinux-enabled system.

I welcome any suggestions.

Jan Zarsky (11):
  libsemanage: add helper functions to tests
  libsemanage: test semanage_handle_* functions
  libsemanage: test semanage_bool_* functions
  libsemanage: test semanage_fcontext functions
  libsemanage: test semanage_iface_* functions
  libsemanage: test semanage_ibendport_* functions
  libsemanage: test semanage_node_* functions
  libsemanage: test semanage_port_* functions
  libsemanage: test semanage_user_* functions
  libsemanage: test semanage_context_* functions
  libsemanage: test semanage_msg_default_handler

 libsemanage/tests/.gitignore            |    1 +
 libsemanage/tests/Makefile              |   11 +-
 libsemanage/tests/libsemanage-tests.c   |   18 +
 libsemanage/tests/test_bool.c           |  932 +++++++++++++++++++++++++++
 libsemanage/tests/test_bool.cil         |   24 +
 libsemanage/tests/test_bool.h           |   31 +
 libsemanage/tests/test_fcontext.c       | 1045 +++++++++++++++++++++++++++++++
 libsemanage/tests/test_fcontext.cil     |   25 +
 libsemanage/tests/test_fcontext.h       |   30 +
 libsemanage/tests/test_handle.c         |  329 ++++++++++
 libsemanage/tests/test_handle.cil       |   21 +
 libsemanage/tests/test_handle.h         |   30 +
 libsemanage/tests/test_ibendport.c      |  525 ++++++++++++++++
 libsemanage/tests/test_ibendport.cil    |   28 +
 libsemanage/tests/test_ibendport.h      |   30 +
 libsemanage/tests/test_iface.c          |  666 ++++++++++++++++++++
 libsemanage/tests/test_iface.cil        |   28 +
 libsemanage/tests/test_iface.h          |   30 +
 libsemanage/tests/test_node.c           |  807 ++++++++++++++++++++++++
 libsemanage/tests/test_node.cil         |   28 +
 libsemanage/tests/test_node.h           |   30 +
 libsemanage/tests/test_other.c          |  120 ++++
 libsemanage/tests/test_other.h          |   30 +
 libsemanage/tests/test_port.c           |  909 +++++++++++++++++++++++++++
 libsemanage/tests/test_port.cil         |   27 +
 libsemanage/tests/test_port.h           |   30 +
 libsemanage/tests/test_semanage_store.c |    2 +-
 libsemanage/tests/test_user.c           |  690 ++++++++++++++++++++
 libsemanage/tests/test_user.cil         |   27 +
 libsemanage/tests/test_user.h           |   30 +
 libsemanage/tests/utilities.c           |  254 +++++++-
 libsemanage/tests/utilities.h           |   53 +-
 32 files changed, 6831 insertions(+), 10 deletions(-)


