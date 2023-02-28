Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BB7C64EC7
	for <selinux@archiver.kernel.org>; Tue, 28 Feb 2023 14:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjB1ONp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1ONo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Feb 2023 09:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8564EC6
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677593573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lr0bvVtOA6qktfG3G23Fb8WXEYMN9E9jFHxbJfUluX4=;
        b=O9mnVKOAWYaZLrmwkoR3O7reB3/mnEPSmSpL8Qxwo8Kk3zkorg4gbvjcYj6Gy9gJpl6wVR
        fNx3t/MwRT/Zq9LqgIFtZjpzAa6FihBHQ0Qm6grMf9PyDmoZtJPlsjKj3huIAL0fOsUleL
        sKCH5BGdiXn7/Sek5Klszm7WQbjEPGI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-INNlW6lfO1GIkVdcHZMhrw-1; Tue, 28 Feb 2023 09:12:51 -0500
X-MC-Unique: INNlW6lfO1GIkVdcHZMhrw-1
Received: by mail-wm1-f70.google.com with SMTP id z6-20020a7bc7c6000000b003e0107732f4so3671495wmk.1
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 06:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lr0bvVtOA6qktfG3G23Fb8WXEYMN9E9jFHxbJfUluX4=;
        b=DPBdyCyfBUTeQzbx0sy6ZQkli0wcSBxNpS5rWoCXegmcy5C3YyWFXJtt7s/G02mdmH
         yfLRqWzmB80FfYMTvukPVkGpuskoDQclNMUVXR4DvIXzu9+AMdMxNo8Iq+TJc92xu3s7
         ZLQkgFZ6o3jDYGALgQ2qC3boT+gSK25w/uuOIbnqMvWLHJyS5dQA5/6yAQgGAw2SJoeJ
         h3YDtAAVuKzAFqq43HFq877esMeoTl4WGKtk0DFMbmxwz1Tf4asmG+OutMU0LdCm2nV/
         kyzHaWNdl2YkdPZ1qwZssYZ9jVvY9k9a76+vBurhJkDksU97ZKO2+RxxzkcY7nICJVWV
         YXuQ==
X-Gm-Message-State: AO0yUKUTNSuU4GGNNEE3V/hlpxr0NofWLP+ecoluI7tZ+TRomw5wT4Mz
        /smYJGS5ytF69Zlk+Xlkv/0c3moiIxXT5ICnuIzVVf4GZ/QnVnMf/GYq14EDJk3XPcfdC/xbsP0
        okTl2xfUn5+jrCivP9JocPS75SJtg5WwjOXQ48xE6oAdlESyT7D2d4UITgLF7JGvKR7+YDrw+HW
        v3Mw==
X-Received: by 2002:a05:600c:2ed3:b0:3ea:e4bb:33ef with SMTP id q19-20020a05600c2ed300b003eae4bb33efmr2671240wmn.9.1677593569735;
        Tue, 28 Feb 2023 06:12:49 -0800 (PST)
X-Google-Smtp-Source: AK7set//LDXGkemCwAkv2HX92sljnHm2RY7Lea8Q2gC+S+ZM9UsT0jSnKhK6z1Ycx6Ryg8nCK2nf+Q==
X-Received: by 2002:a05:600c:2ed3:b0:3ea:e4bb:33ef with SMTP id q19-20020a05600c2ed300b003eae4bb33efmr2671214wmn.9.1677593569284;
        Tue, 28 Feb 2023 06:12:49 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g14-20020a7bc4ce000000b003eb20d4d4a8sm12161129wmk.44.2023.02.28.06.12.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:12:48 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 0/3] Infiniband test fixes/improvements
Date:   Tue, 28 Feb 2023 15:12:44 +0100
Message-Id: <20230228141247.626736-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add missing policy rule needed on systems with strict resource limits,
add another missing rule to reduce AVC noise, and simplify how IB tests
are activated.

Tested on an aarch64 machine with an IB device and RHEL-8.7 installed.

Ondrej Mosnacek (3):
  policy: make sure test_ibpkey_access_t can lock enough memory
  policy: allow test_ibpkey_access_t to use RDMA netlink sockets
  tests/infiniband*: simplify test activation

 Vagrantfile                   |  1 +
 policy/test_ibpkey.te         |  3 +++
 tests/Makefile                | 11 ++-------
 tests/infiniband_endport/test | 39 ++++++++++++++++++-------------
 tests/infiniband_pkey/test    | 44 ++++++++++++++++++++---------------
 5 files changed, 54 insertions(+), 44 deletions(-)

-- 
2.39.2

