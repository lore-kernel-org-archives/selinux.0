Return-Path: <SRS0=lyW+=Z2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C200C43603
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 08:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBDC20674
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 08:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/KnGLrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLDIhd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:37:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20219 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725839AbfLDIhc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Dec 2019 03:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575448651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JLlCDVAB5dinWjYxCp5RED2SFYlpi+9bn2onoO1AYXA=;
        b=g/KnGLrGppotvixX6bCklmyfDiWxQnN5PWosa3fxxQkfUxMGjYGYci6u6Dwt/Tz+KWz/fv
        l7zrYEOGTB6ftdGLoHDap0rf4kJN3pf73hCPyqtqdXAn8G/7bI2wDMu2CBpsmRD5cXYacq
        C0lCX+qYEvfrquUi5XikbIEuJHhcP1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-V2h5ZPg5P2eXSgKrmaiPDw-1; Wed, 04 Dec 2019 03:37:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77697800D5E
        for <selinux@vger.kernel.org>; Wed,  4 Dec 2019 08:37:29 +0000 (UTC)
Received: from localhost (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 223111001925
        for <selinux@vger.kernel.org>; Wed,  4 Dec 2019 08:37:28 +0000 (UTC)
User-agent: mu4e 1.2.0; emacs 26.2
From:   Petr Lautrbach <plautrba@redhat.com>
To:     "SELinux list" <selinux@vger.kernel.org>
Subject: ANN: SELinux userspace release 2019-12-04 / 3.0
Date:   Wed, 04 Dec 2019 09:37:27 +0100
Message-ID: <pjdwobctrjs.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: V2h5ZPg5P2eXSgKrmaiPDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


The 2019-12-04 / 3.0 release for the SELinux userspace is now=20
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Thanks to all the contributors to this release!

User-visible changes:

* Optional support for kernel policy optimization (enable with
optimize-policy=3Dtrue in /etc/selinux/semanage.conf for modular policy or =
-O
option to checkpolicy/secilc for monolithic policy); this is optional becau=
se it
provides relatively small savings with non-trivial policy compile-time over=
head
for some policies e.g. Android.

* New digest scheme for setfiles/restorecon -D; instead of a single hash of=
 the
entire file contexts configuration stored in a security.restorecon_last xat=
tr on
only the top-level directory, use a hash of all partial matches from file
contexts stored in a security.sehash xattr on each directory,

* Support for default_range glblub in source policy (.te/policy.conf and CI=
L)
and kernel policy version 32,

* New libselinux APIs for querying validatetrans rules,

* Unknown permissions are now handled as errors in CIL,

* security_av_string() no longer returns immediately upon encountering an
unknown permission and will log all known permissions,

* checkmodule -c support for specifying module policy version,

* mcstransd reverted to original color range matching based on dominance,

* Support for 'dccp' and 'sctp' protocols in semanage port command,

* 'checkpolicy -o -' writes policy to standard output,

* 'semodule -v' sets also cil's log level

* Python 2 code is not be supported in this project anymore and new Python =
code
should be written only for Python 3.

* Messages about the statement failing to resolve and the optional block be=
ing
disabled are displayed at the highest verbosity level.

* Fixed redundant console log output error in restorecond

Issues fixed:

* https://github.com/SELinuxProject/selinux/issues/61
* https://github.com/SELinuxProject/selinux/issues/137
* https://github.com/SELinuxProject/selinux/issues/138
* https://github.com/SELinuxProject/selinux/issues/167
* https://github.com/SELinuxProject/selinux/issues/169
* https://github.com/SELinuxProject/selinux/issues/170
* https://github.com/SELinuxProject/selinux/issues/176

