Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03941C61D97
	for <selinux@archiver.kernel.org>; Wed, 22 Nov 2023 16:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjKVQBh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Nov 2023 11:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjKVQBf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Nov 2023 11:01:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77D98
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 08:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700668891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5BpmzWpcHiqLOtExuogWXIAoDOvTPxizAR7YsaDeoZc=;
        b=WLxcgfMnQeA0Jvze49d1QkYy8obJk6ChyyiLZNXQR872BlHMNn5j8PRa4A5HZr0v02tAeN
        t9K9XAI9IC7/wounC2tIhvTtqxt1/cxqJBX9hSw5sZUpKaiiELdWsp0Ugxoqi/1+YGJU+b
        2cHGKQ8w8Obuw4Rsy9rzPbH4jpP2EhY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-tP1DYb3uOTi_dCNkHF8zug-1; Wed, 22 Nov 2023 11:01:29 -0500
X-MC-Unique: tP1DYb3uOTi_dCNkHF8zug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45ED8101A529
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 16:01:29 +0000 (UTC)
Received: from localhost (unknown [10.45.226.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0861810F44
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 16:01:28 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.6-rc2 release
Date:   Wed, 22 Nov 2023 17:01:28 +0100
Message-ID: <87jzq9u693.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello!

The 3.6-rc2 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know.

User-visible changes
--------------------

* cil: Allow IP address and mask values to be directly written

* cil: Allow paths in filecon rules to be passed as arguments

* Bug fixes

Development-relevant changes
----------------------------

* ci: bump Fedora to version 39

* Drop LGTM.com and Travis CI configuration

Shortlog of the changes since 3.6-rc1 release
---------------------------------------------
Christian G=C3=B6ttsche (26):
      libsepol: use str_read() where appropriate
      libsepol: adjust type for saturation check
      libsepol: enhance saturation check
      libsepol: validate the identifier for initials SID is valid
      Drop LGTM.com configuration
      Drop Travis CI configuration
      scripts: ignore unavailable interpreters
      ci: bump Fedora to version 39
      libselinux: update Python binding
      Update Python installation on Debian
      scripts: update run-scan-build
      semodule_link: avoid NULL dereference on OOM
      libsepol: set number of target names
      libselinux: fix memory leak in customizable_init()
      libsepol: avoid leak in OOM branch
      libsepol: avoid memory corruption on realloc failure
      libsepol: update policy capabilities array
      github: bump action dependencies
      libsepol: validate common classes have at least one permissions
      libsepol: include length squared in hashtab_hash_eval()
      libsepol: use DJB2a string hash function
      libsepol/cil: use DJB2a string hash function
      libselinux: use DJB2a string hash function
      newrole: use DJB2a string hash function
      libsepol: avoid fixed sized format buffer for xperms
      libsepol: avoid fixed sized format buffer for xperms

Huaxin Lu (1):
      libsepol: add check for category value before printing

James Carter (11):
      libsepol/tests: Update the order of neverallow test results
      libsepol/cil: Use struct cil_db * instead of void *
      libsepol/cil: Refactor and improve handling of order rules
      libsepol/cil: Allow IP address and mask values to be directly written
      secilc/docs: Update syntax for IP addresses and nodecon
      libsepol/cil: Refactor Named Type Transition Filename Creation
      libsepol/cil: Allow paths in filecon rules to be passed as arguments
      secilc/docs: Fix and update the documentation for macro parameters
      libsepol/cil: Add pointers to datums to improve writing out AST
      libsepol/cil: Give warning for name that has different flavor
      libsepol/cil: Do not allow classpermissionset to use anonymous classp=
ermission

Petr Lautrbach (1):
      Update VERSIONs to 3.6-rc2 for release.

