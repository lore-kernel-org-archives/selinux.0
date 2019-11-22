Return-Path: <SRS0=8Pnr=ZO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0950C432C0
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 14:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C482C20706
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 14:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oi35VTTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKVOyW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:54:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37862 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726046AbfKVOyW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Nov 2019 09:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574434461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=drDe+UkQKC13oYcID7zhvkboOOWlBsPqLhGseBl1ji4=;
        b=Oi35VTTto+3mczl4cjAq/Q1y/Q1bNotBtQm13i6h8ALCIPx57/HPO7jM1fzyXaCc/9EBve
        UJjg1gccalbSkv9V05yFSJPokewWpq5kYLn+Kzv53Uvu2lMiZ33DOsAL7AafJPGhQHHHzC
        PscN1+QR2Eny2WpxJzKNWp3bcIzrZDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-JjJhaRSQPiejENqC3wAcmQ-1; Fri, 22 Nov 2019 09:54:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 863468064DA
        for <selinux@vger.kernel.org>; Fri, 22 Nov 2019 14:54:17 +0000 (UTC)
Received: from localhost (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E83260C41
        for <selinux@vger.kernel.org>; Fri, 22 Nov 2019 14:54:17 +0000 (UTC)
User-agent: mu4e 1.2.0; emacs 26.2
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SELinux list <selinux@vger.kernel.org>
Subject: ANN: SELinux userspace 3.0-rc2 release candidate
Date:   Fri, 22 Nov 2019 15:54:15 +0100
Message-ID: <pjd1ru0dkrs.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: JjJhaRSQPiejENqC3wAcmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A 3.0-rc2 release candidate for the SELinux userspace is now=20
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out=20
in release notes for packagers and users in the final release
announcement, let us know.=20

Thanks to all the contributors to this release candidate!

User-visible changes (since 3.0-rc1):

* Python 2 code is not be supported in this project anymore and new Python =
code
should be written only for Python 3.

* Messages about the statement failing to resolve and the optional block be=
ing
disabled are displayed at the highest verbosity level.

* Fixed redundant console log output error in restorecond

Issues fixed:

* https://github.com/SELinuxProject/selinux/issues/170

A shortlog of changes since the 3.0-rc1 release:

Baichuan Kong (1):
      restorecond: Fix redundant console log output error

James Carter (1):
      libsepol/cil: Report disabling an optional block only at high verbose=
 levels

Nicolas Iooss (3):
      libselinux,libsemanage: never create -.o in exception.sh
      libselinux,libsemanage: fix python_exception.i dependencies
      libselinux,libsemanage: check in python_exception.i files

Petr Lautrbach (5):
      Replace www.nsa.gov references by github.com/SELinuxProject
      python/sepolicy: Revert "Only invoke RPM on RPM-enabled Linux distrib=
utions"
      Travis-CI: Drop Python 2 from matrix
      dbus: Fix FileNotFoundError in org.selinux.relabel_on_boot
      Update VERSIONs to 3.0-rc2 for release.

Thomas Petazzoni (1):
      libselinux/src/Makefile: don't pass bogus -I and -L to python setup.p=
y build_ext


