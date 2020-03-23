Return-Path: <SRS0=0U01=5I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31654C3F2CD
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9F120722
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOwK2zGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCWRup (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:50:45 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:36041 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgCWRup (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Mar 2020 13:50:45 -0400
Received: by mail-pg1-f172.google.com with SMTP id j29so681130pgl.3
        for <selinux@vger.kernel.org>; Mon, 23 Mar 2020 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WbDxeH1K/sWmcDkTvX3d9TQYmsRDHg78J04OQzjtDk4=;
        b=jOwK2zGpRcmGPpj2ePPQVHesZ+yKyGVgv6oeK1ogAIfUBTthIar4iJFtFGkNd3lwfu
         Q7/qiI1NEZyKUvxV7pFmFqyJvNK5HZ3ZNZTtw86VYuNsJU9cZeqzWZpOUzgbMENAsSba
         7BChBxeOyD9+wi7bMPpHPpVwzfwY8U45Rkhr3JHBqPQYjJr7BJuSHjQOyGgeOnke70jx
         JgPz7kVdaX1Wn/0WA+LSc7qtPfxPT5n5ME9SrkTvNASWz0BPMJbTOudoLeUpeQzhWC72
         dLb4bDNYeqKrmXk+2oOBZvzB10cNOjZnD/H+0AwqUqkVdepxb3xk+Nm8nInAPhC+6/XE
         FxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WbDxeH1K/sWmcDkTvX3d9TQYmsRDHg78J04OQzjtDk4=;
        b=jMAH7x6Ib7oURm6f87dTFf8Wcilzgyj0Iq/HbRD8wddJ77XipjU2fRkchp6qhGjAbR
         Ol93x6HG6yRR8Js8DzGDDbrDdIFnpNsLHoiZ8SAI1w1V+rBm+7U8FkoSEa8a98rtLUJu
         bcEqTAgSF3vyy7ux+ZBngXrrEZstI0LQO9nQJecKvkUXIP4yCLAsIA1ETDVo3nxf8Qnm
         kDw90GC8Fg9rdajqy7iOXdBhDYW5XUxGEFm4eQFLlkaTA+dsjQxhqeOY3ZV8Ex9JVBeT
         zIYwhk0Joz7LPJ1FLE9PH+VmEuZhoqcu9cMForPkyBlkYyvTSpfN/09TaLuFJN5PSk/1
         YBdA==
X-Gm-Message-State: ANhLgQ0ggcQaFdx6r88a7BE8GCx5vGgF4DUpt56ShZIxnOwFFBC5MO9P
        mqpOKsIstD1K5bzXOMSghPQ=
X-Google-Smtp-Source: ADFU+vsHEYHo/zuPYOq1jsaxT1DUs9t+5EbngylxgR4Ufqa+maM5mlYI+Jd2hs50vNl3Etr/ENiQmQ==
X-Received: by 2002:a63:2d6:: with SMTP id 205mr5209122pgc.257.1584985844393;
        Mon, 23 Mar 2020 10:50:44 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id j126sm13963979pfg.60.2020.03.23.10.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:50:43 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     drepper@redhat.com, nicolas.iooss@m4x.org, omosnace@redhat.com,
        plautrba@redhat.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: libsemanage: drop dso infrastructure
Date:   Mon, 23 Mar 2020 12:50:33 -0500
Message-Id: <20200323175037.19170-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a follow up to the other DSO drop patch series for the
existing selinux userspace libraries. Like the previous patches,
it takes a granular approach at moving things, so you really need
all/most the patches to get the correct exported libsemanage
interface.

After applying one can test by doing a diff of the symbols between
old and new:

Get the old list of symbols:
nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map
    
Then creating a new one for this library after the patches are applied:
nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map

I think this just leaves CIL as the last of the dso hold outs, which I
will follow up after this one.

Thanks,
Bill

[PATCH 1/4] libsemanage: drop hidden
[PATCH 2/4] libsemanage/Makefile: add -fno-semantic-interposition
[PATCH 3/4] libsemanage: update linker script
[PATCH 4/4] libsemanage: cleanup linker map file

