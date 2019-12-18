Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA5CC43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F2A218AC
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TyYbmSdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLRO2S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:28:18 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:34103 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfLRO2S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 09:28:18 -0500
Received: by mail-ed1-f50.google.com with SMTP id l8so1821258edw.1
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOf/lBys6Mc+yjb07ACjsYPNgf11EN65PlxHt40Th+o=;
        b=TyYbmSdnywO5xTCNfUN6K9NkcbIWzsNFjPd3MSMGjrZDAQgv26JPsY0eum3E1dioHd
         za0QgvrotuvquNwgbbZkEbYqM+v7z0Bu4OkC7s2V1BTaalyAY1g4Kygdj/6qR2Kr2niE
         HqvHH/L52nXz3784SExYmFlNFRWE1DeXB51O/ss9fm0c3pSW89C2IV92stVVGxroezV5
         eXam4OwWOpWx7bCxRm71htCxezJcFm+hObIvRKuwnQzBSMB2FkewvjZiDpSJHx6A2F18
         2qaA1J4A5HExbjTcXCTWAYPuEtcyJKPLNRGi/nr/XPsuCq0Jl2fKurPvBnN4Nd3xh1qk
         ZGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOf/lBys6Mc+yjb07ACjsYPNgf11EN65PlxHt40Th+o=;
        b=C1V4OaovkIgoXOCH2pW+BiLeNwZQ0lGoqen5lIFpOwqNVToS7A+wFw9qh3VHuiFaEb
         OhjpVOmFHQIWW1S5//BfYREJ0ddILW2KnMpl8BTU+C7Zrzz1CGFKs8uXShs6UVkjdfkk
         x79iNoLsEcam2zP04eG5manBLxPl8QdTbwMvS44allOT3XsW/uhHNo+i0mcHYL6afcVw
         J+PIbHc6j7hUy41K5ztsja5P60qBEmqoKr6OECQoeSIPtnFzlJePJDIJoRPnvQOvLhuk
         tG7MAMfNSQxE2Yp7tPkCWS4+eEJqFylL42hhgf2X7xJX5rI5kIcuZZhWNNMSucFznSSD
         zKVg==
X-Gm-Message-State: APjAAAVtnQY5S1Ty7JyHwCjaNw0glfy3LxB9kjlwfGdtZDnH9VgigrBT
        2i0OdY0HuDWqQk5Y1Qc/Fmim9JUf
X-Google-Smtp-Source: APXvYqztlAfoaFMSg1/btBVCJcZ+S9Gm6CXzMhz3rSKN62KS28fzl7TU7aevVikygo95xH+LfNIQ1w==
X-Received: by 2002:a50:fb02:: with SMTP id d2mr2667419edq.270.1576679296668;
        Wed, 18 Dec 2019 06:28:16 -0800 (PST)
Received: from desktopdebian.localdomain (x4d015122.dyn.telefonica.de. [77.1.81.34])
        by smtp.gmail.com with ESMTPSA id mh16sm96826ejb.46.2019.12.18.06.28.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:28:15 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 0/8] systemd: improve SELinux support
Date:   Wed, 18 Dec 2019 15:28:00 +0100
Message-Id: <20191218142808.30433-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Improve the SELinux support in systemd, especially re-adding checks for
unit file operations, like enable, mask...

The original pull request can be found at https://github.com/systemd/systemd/pull/10023

Patch 1 and 2 improve logging on failures in permissive mode.

Patch 3 adds the ability to obtain the context for a masked unit.

Patch 4 and 5 change several system und service checks. For better
distinction two new permissions are introduced: modify and listdynusers.

Patch 6 and 7 re-introduce checking unit file install operations.
They were dropped in 8faae625dc9b6322db452937f54176e56e65265a .
For consistency in the unexpected case while perforimg a service access
check no path can be gathered, now the check will still be executed on
the service security class (currently it switches to the system security
class).

Patch 8 adds some notes for adding future D-Bus interfaces.


Christian Göttsche (8):
  selinux-util: increase log severity
  selinux-access: log warning on context acquisition failure
  core: bookkeeping withdrawal path of masked units
  core: add missing SELinux checks for dbus methods
  core: make SELinux access permissions more distinct
  core: add support for MAC checks on unit install operations
  core: implement the sd-bus generic callback for SELinux
  core: add notes to D-Bus interfaces about adding SELinux checks

 src/analyze/analyze.c        |  11 ++-
 src/basic/selinux-util.c     |   4 +-
 src/core/dbus-automount.c    |   3 +
 src/core/dbus-cgroup.c       |   3 +
 src/core/dbus-device.c       |   3 +
 src/core/dbus-execute.c      |   3 +
 src/core/dbus-job.c          |   7 ++
 src/core/dbus-kill.c         |   3 +
 src/core/dbus-manager.c      | 164 ++++++++++++++++++++++++++++-------
 src/core/dbus-mount.c        |   3 +
 src/core/dbus-path.c         |   3 +
 src/core/dbus-scope.c        |   3 +
 src/core/dbus-service.c      |   3 +
 src/core/dbus-slice.c        |   3 +
 src/core/dbus-socket.c       |   3 +
 src/core/dbus-swap.c         |   3 +
 src/core/dbus-target.c       |   3 +
 src/core/dbus-timer.c        |   3 +
 src/core/dbus-unit.c         |  14 ++-
 src/core/load-fragment.c     |  10 +++
 src/core/manager.c           |  10 ++-
 src/core/manager.h           |   2 +
 src/core/selinux-access.c    |  44 ++++++++--
 src/core/selinux-access.h    |  28 +++++-
 src/core/unit.c              |  13 ++-
 src/core/unit.h              |   3 +-
 src/shared/install.c         | 101 +++++++++++++++++----
 src/shared/install.h         |  42 ++++++---
 src/shared/unit-file.c       |  52 ++++++++---
 src/shared/unit-file.h       |   1 +
 src/systemctl/systemctl.c    |  28 +++---
 src/test/test-install-root.c |  86 +++++++++---------
 src/test/test-install.c      |  38 ++++----
 src/test/test-unit-file.c    |   8 +-
 34 files changed, 543 insertions(+), 165 deletions(-)

-- 
2.24.1

