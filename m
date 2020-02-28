Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612A2C3F2D2
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372AB2469D
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzOnBZXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgB1PtI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:49:08 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:35589 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgB1PtI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 10:49:08 -0500
Received: by mail-pj1-f50.google.com with SMTP id q39so1459920pjc.0
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=vpD+qxQ0HuLs0ggqWOT+ZDQYfcLOukr5omhhZ6gRiyk=;
        b=qzOnBZXaM2bd6leyeQc8hTA2C6YnK09xu/mapIPu882ZNDX8ajo2mdDqWs+xfA5Xth
         ER+vWEb8wy4FttDnexmY/DiiHizIQ+Fb+www6Ylu/JgGgpxxES6JsQU/ghH0A15l7ISO
         WPunqXRDpkJgyEkEXtzd4wYVj8yuZEPrGvzMpZOGilYszTUQbHhggSCJggM8h+15SClQ
         IhsVoUBfe0t5UQuz/HyhBXMBMN6HR/SV7Sy5mOHyUeAm+NZFa3aoDoPr4qmbrMdBcHHC
         BEzQpSzCbx4F16wJwXeJ+a6VvF/UgXKa2M1gcCuvHdcJPtCrtZml6hBehOsTEhhQbKG4
         CdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=vpD+qxQ0HuLs0ggqWOT+ZDQYfcLOukr5omhhZ6gRiyk=;
        b=DKnlpfb2lMGzqt0hK9x881i1gZcuRxiFYLK/MKLD872BCa1LOdRZkMGmWawHVNqYBH
         IJP/DGQ09lA0RSf4khSDsgv3HpgFqfHfLlMbEXYdjqhny36i4bduY1bvqeXpRXEVr7qZ
         gXJyzE45utYwiubC+i3V3jqphjT21QIo4oSVjQtrQR1zU6KGVJ2/keJ9Xhal99FqRf4T
         W+JOFgDHuHw6DWQhkeeetG00NOnbrSCnvvwcxoUGIoT50ZZwrW/znZg2Y4K09oZ84/FN
         J/Knl+u31n5dgy/CXO/O3phDqIFa/NPw1WlcXMbQ9GQbSjfQlfgPgZ/ciz/cqynjtmb/
         7+fw==
X-Gm-Message-State: APjAAAWKrwg/S4toBGhJ4OTTiiMRke0b5dQBirBhKKiraIYqIuUbiQpW
        Punofn0Sx8oXGgNC3nV2qU8sJh+t
X-Google-Smtp-Source: APXvYqz+i/gygcGRRC1Yqh+qfBhcoLqgLkxPClGs4Hlot17IhtrjBn6TOtQ/eIf5nyVg5b/pJBmGDA==
X-Received: by 2002:a17:902:9b8a:: with SMTP id y10mr4431629plp.114.1582904945635;
        Fri, 28 Feb 2020 07:49:05 -0800 (PST)
Received: from localhost.localdomain ([134.134.137.79])
        by smtp.gmail.com with ESMTPSA id w18sm12091796pfq.167.2020.02.28.07.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:49:05 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org, drepper@redhat.com, omosnace@redhat.com,
        stephen.smalley.work@gmail.com, plautrba@redhat.com
Subject: [V3] libselinux: drop dso.h
Date:   Fri, 28 Feb 2020 09:48:53 -0600
Message-Id: <20200228154857.587-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227230129.31166-1-william.c.roberts@intel.com>
References: <20200227230129.31166-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Version 3:
  - Add more symbols that should be dropped from the dso:
    - map_class;
    - map_decision;
    - map_perm;

Version 2:
  - adds a version to the linker script LIBSELINUX_1.0
  - Adds a patch to drop some additional symbols from the dso:
    - dir_xattr_list
    - myprintf_compat
    - unmap_class
    - unmap_perm

This four part patch series drops the dso.h and hidden_*
macros.

The old dso.h functionality provided libselinux with both control over
external exported symbols as well as ensuring internal callers call into
libselinux and not a symbol with the same name loaded by the linker
earlier in the library list.

The functionality is replaced by a linker script that requires public
API to explicitly be opt-in. The old method required that internal API
be explicitly annotated, and everything else is public. This should help
make it easier to control libselinux DSO hygene going forward.

The second functionality is replaced by compiler option
-fno-semantic-interposition

Note that clang has this enabled by default, and thus doesn't need it.

See:
  - https://stackoverflow.com/questions/35745543/new-option-in-gcc-5-3-fno-semantic-interposition

[PATCH v3 1/4] dso: drop hidden_proto and hidden_def
[PATCH v3 2/4] Makefile: add -fno-semantic-interposition
[PATCH v3 3/4] Makefile: add linker script to minimize exports
[PATCH v3 4/4] libselinux: drop symbols from map

