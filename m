Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF08AC433F5
	for <selinux@archiver.kernel.org>; Thu, 13 Jan 2022 14:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiAMOjs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jan 2022 09:39:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235708AbiAMOjr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jan 2022 09:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642084786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8Kkh/A9AgmVC1FEXLhwMDcYlQGF0jUc3IHgwqiMQKrI=;
        b=b8+aOW6F7tiWxgtcQE7VKjI3sVFpHrAOz+lYIl4elfWa9bEEaW2EXnQpURd6mXO7GyHyie
        Rhs/jIBkoGwQ9T+5vWe9u1HHLArKBGy6/y64Sy2+S6JBSqq2JeZLAOFwp7LJgUhoJtnGgg
        TB8r/Ge57paaGbaZHt++EYSs1EnuO4Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492--_i0n9APOteWQjbaSVP8Bg-1; Thu, 13 Jan 2022 09:39:45 -0500
X-MC-Unique: -_i0n9APOteWQjbaSVP8Bg-1
Received: by mail-ed1-f70.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so5492077edc.9
        for <selinux@vger.kernel.org>; Thu, 13 Jan 2022 06:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Kkh/A9AgmVC1FEXLhwMDcYlQGF0jUc3IHgwqiMQKrI=;
        b=RJc0DeQbsgKcC7FnJ93nkwwaaTXUixg8YLGjfZt4/DRwHtmMb8VdJhkxJH7ivLpqBl
         90T850TZllEpQlSExL+Uml5D7LJj9JI2ST64aw2jn5SO6BzQVRWyxU92KThEq72sbsBy
         QFALAI4aFDjSH88L2fzQjKkSRdS/rEBBjXB7L2SPsH5LFztLihuEotRTQ8GnMYzFCQOn
         LoekSfFZKhFkYz5Oy4W3q1hWY6HYkDlK9rOqFnYUDj3nvNbHtv71u0ZjuBMm6UZsXKnX
         46hhoaUL8l0tlOTEnLRTFCuiqJTXO1zyakIGCBqwBqQLZB7cSX2+9a41tu8kBdQtBHyp
         dHuQ==
X-Gm-Message-State: AOAM532R6/HhvMrY37Q15OF3J4TAK8u42syFFxtZ2XH1hW6h72XNXFxA
        SZKknZNPDXklTBIjIin2qDYo4letBMkd9YHtxp72Cz5LY+dGNZ0CD5/5qAVtgKoWOOGSz5qJ2gD
        lgyyNYJH+QEs+d+SiOm0cgeFZunSuCN9AVVUviRFpeJKyccMy+oA10pDl/yR0vLCoMPVz0Q==
X-Received: by 2002:a17:907:3d88:: with SMTP id he8mr3946648ejc.239.1642084784275;
        Thu, 13 Jan 2022 06:39:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCGoYzgKVaHrEPls71TlDDGX0YFUerIvm9o9VVoK/C4gidEUJsRnC/8SJpSykyf3kTPWCYnQ==
X-Received: by 2002:a17:907:3d88:: with SMTP id he8mr3946619ejc.239.1642084783948;
        Thu, 13 Jan 2022 06:39:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:d5c1:b1da:9874:b302])
        by smtp.gmail.com with ESMTPSA id sc7sm964242ejc.87.2022.01.13.06.39.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 06:39:43 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH userspace 0/5] Allow rebuilding policy store only if there were external changes to modules
Date:   Thu, 13 Jan 2022 15:39:30 +0100
Message-Id: <20220113143935.195125-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series extends libsemanage and semodule with optional capability to
detect external changes to modules and perform a rebuild if there are
any. See patch 4 for motivation and more details.

The first three patches are preparatory cleanup/refactoring, patch 4
implements the libsemanage side of the feature described above, and
patch 5 adds a command-line option to semodule that allows to turn on
the feature.

Default behavior of libsemanage and semodule is not changed (apart from
added checksum calculation on each transaction, which however seems to
add no noticeable overhead based on benchmarks - see patch 4 for
details).

I'm posting this as an RFC mainly because I'm unsure about naming of the
new function(s) and the command-line parameter. Suggestions on better
names are welcome, as are any reviews/comments.

Ondrej Mosnacek (5):
  libsemanage: add missing include to boolean_record.c
  semodule,libsemanage: move module hashing into libsemanage
  libsemanage: move compressed file handling into a separate object
  libsemanage: optionally rebuild policy when modules are changed
    externally
  semodule: add command-line option to detect module changes

 libsemanage/include/semanage/handle.h         |   5 +
 libsemanage/include/semanage/modules.h        |  25 +
 libsemanage/src/boolean_record.c              |   4 +-
 libsemanage/src/compressed_file.c             | 224 +++++++
 libsemanage/src/compressed_file.h             |  78 +++
 libsemanage/src/direct_api.c                  | 564 ++++++++----------
 libsemanage/src/direct_api.h                  |   4 -
 libsemanage/src/handle.c                      |  11 +-
 libsemanage/src/handle.h                      |   1 +
 libsemanage/src/libsemanage.map               |   5 +
 libsemanage/src/modules.c                     |  36 ++
 libsemanage/src/semanage_store.c              |  53 +-
 libsemanage/src/semanage_store.h              |   1 +
 .../src/semanageswig_python_exception.i       |   8 +
 .../semodule => libsemanage/src}/sha256.c     |   0
 .../semodule => libsemanage/src}/sha256.h     |   0
 policycoreutils/semodule/Makefile             |   2 +-
 policycoreutils/semodule/semodule.c           |  74 +--
 18 files changed, 704 insertions(+), 391 deletions(-)
 create mode 100644 libsemanage/src/compressed_file.c
 create mode 100644 libsemanage/src/compressed_file.h
 rename {policycoreutils/semodule => libsemanage/src}/sha256.c (100%)
 rename {policycoreutils/semodule => libsemanage/src}/sha256.h (100%)

-- 
2.34.1

