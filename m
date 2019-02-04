Return-Path: <SRS0=wOFf=QL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DABC282C4
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 15:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F255B20823
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 15:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfBDPVk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:21:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbfBDPVk (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 4 Feb 2019 10:21:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E07D98E67F;
        Mon,  4 Feb 2019 15:21:39 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9F6786FA7;
        Mon,  4 Feb 2019 15:21:39 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id BC2C51808855;
        Mon,  4 Feb 2019 15:21:39 +0000 (UTC)
Date:   Mon, 4 Feb 2019 10:21:39 -0500 (EST)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Message-ID: <1878855653.53268021.1549293699681.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190131210753.11221-1-nicolas.iooss@m4x.org>
References: <20190131210753.11221-1-nicolas.iooss@m4x.org>
Subject: Re: [PATCH 0/3] Support flake8 version 3.7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.112.230.141, 10.4.196.3, 10.5.101.130, 10.4.195.21]
Thread-Topic: Support flake8 version 3.7
Thread-Index: HGwAuzDgG3rY8zaNWIYF9Z6acMMg3w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 04 Feb 2019 15:21:40 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


flake8 3.7.0, 3.7.1, 3.7.2 and 3.7.3 were released on 2019-01-29 and
2019-01-30 (cf. http://flake8.pycqa.org/en/latest/release-notes/3.7.0.html).
These releases introduced new warnings, which broke building with
Travis-CI (cf. https://travis-ci.org/fishilico/selinux/builds/487098420).

Fix Travis-CI's builds by fixing the warnings that are now reported.
The first two commits are related to coding style and the third one is
a fix for an actual bug.


Nicolas Iooss (3):
  python: reindent lines that were over-indented
  python: use == or != when comparing a variable with a string or a
    integer
  python/sepolicy: fix variable name

 python/semanage/semanage                  | 118 ++++++------
 python/sepolgen/src/sepolgen/output.py    |   6 +-
 python/sepolgen/src/sepolgen/refparser.py |   2 +-
 python/sepolgen/src/sepolgen/yacc.py      | 214 +++++++++++-----------
 python/sepolicy/sepolicy/generate.py      |   4 +-
 python/sepolicy/sepolicy/gui.py           |   2 +-
 python/sepolicy/sepolicy/interface.py     |   8 +-
 python/sepolicy/sepolicy/manpage.py       |   4 +-
 8 files changed, 179 insertions(+), 179 deletions(-)



Acked-by: Petr Lautrbach <plautrba@redhat.com>
