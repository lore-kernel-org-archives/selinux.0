Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95790C3F2CD
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684392173E
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag+o+ebM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCBQlV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:41:21 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:50661 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBQlV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 11:41:21 -0500
Received: by mail-pj1-f51.google.com with SMTP id nm14so3940pjb.0
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 08:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HCi2a8zGj7mXzDbsnxEgyvHt6inPtTjPNGTOQkPOS+4=;
        b=ag+o+ebMgaArS4lD+GL3pnYxHk7j2mD/bzaKq49PUo38kztpndTfrAxEbwYQnQ8E+/
         KEJjY7GwOLbAf177ib5jF8wpsJ6uwsrkn/4UKzp3eetKj44D6b3bwp1bbo99ZrJMfjH4
         wKxzmla9JBFzx9/9v6XUIIMY5akT/H7KGUF0wjYlJRzMGcotVCqf+ukTbZpGG9cqE1O1
         p1bPzqlS2RZhKCT8YU+ZJ3FJd5a+BfRqdCaVYcB0BGdvc9iupDhtep8O2pUfe/Eoq84f
         WLFZQ3yoY+ogxWsnKrCBj8R7EjKFF6w+fArLfFGryiBuINVi0ft7bthskLBhvsDxHiYb
         LSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HCi2a8zGj7mXzDbsnxEgyvHt6inPtTjPNGTOQkPOS+4=;
        b=UgGSBp6nh/DfzQwTM88AprCcPK+xcGq6nj0A6IRvLZf7UU6ly0yQQqZH4decwK/Aj9
         /nBuMMPhg26MJDq6bIdaj2cYPL1Ark9SirIsYwRP0OuwHpMpQ5OCvefXo4sddfv/Eu/D
         RmtYfIPqfD/YvxGUn+sFRRlw0viSfZ1+fjFr2/lD6xNi0MIRNoJecfdKfOjee8z9yU9s
         TbsC/DFZ0yE02tawgWdOsSPJ9gspNWGX+Vy8UdmRXWQcQ4b8cvUPWKIFHqEVHhqKo9P9
         Kh2fDdwEFR9wJJzL8BxlcOCUgATKpESWN0TTckNEdnJN+Q3zmELvo5zXj/3/eKw2LFY6
         WcCQ==
X-Gm-Message-State: ANhLgQ3HglFAgvLgj9OENNFiEkO4IimoCxoOV8dAO+JvUbh36pZAbQd7
        0tTgpZTG8MBAtOrTNipR1dw=
X-Google-Smtp-Source: ADFU+vv5jOn23zAxMSZm6qlYdbh71Dv2hOFI3n1cRWVhCi6C3q+SE9kn9Ov6e8Zc9nBWmGKQMQA4EA==
X-Received: by 2002:a17:90a:af81:: with SMTP id w1mr509486pjq.14.1583167279075;
        Mon, 02 Mar 2020 08:41:19 -0800 (PST)
Received: from localhost.localdomain ([192.55.55.41])
        by smtp.gmail.com with ESMTPSA id o6sm23331087pfg.180.2020.03.02.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 08:41:18 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, drepper@redhat.com, omosnace@redhat.com,
        plautrba@redhat.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: [V4] libselinux: drop dso.h
Date:   Mon,  2 Mar 2020 10:41:08 -0600
Message-Id: <20200302164112.10669-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Version 4:
  - Fix linker option warnings.
  - Move map file to begining of options.

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

[PATCH v4 1/4] dso: drop hidden_proto and hidden_def
[PATCH v4 2/4] Makefile: add -fno-semantic-interposition
[PATCH v4 3/4] Makefile: add linker script to minimize exports
[PATCH v4 4/4] libselinux: drop symbols from map

