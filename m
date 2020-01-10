Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99853C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F102072E
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SoN2YmsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgAJOPR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:15:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53950 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgAJOPR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 09:15:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so2164257wmc.3
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 06:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYy6t1vC/vw9kUGpEpxIhpvBUQI0S0mxIu11GDRr2cg=;
        b=SoN2YmsJHG9IrKPBSB+ATpTGIEkevyHeL4UqpeqDXvjWgxOKokA6qwVspV6QGtuHCN
         y+Ahuqy0fAkxq2wok8BJOsQubm4Xk9YPGdvAg8Yo1CKNi8ysjLgZmGuT0/WhiXPpNCIP
         LFsBfG26Y5Eko7U+ZLFX9AUFRDgZEyUnH6D1xpx6lUAPUtjfFSfBIa36jFGl8MBd6fIC
         ESQCoXvRgKOlpF3T7W/P/Z2ydwzO7P5RyboYFLwoLbYUsdi3TD+67CVtsagoTVgKf7Jh
         FRGGsSOmC2vMVQavf2U4cgNQDGP411D/GkT0iURH5Mw2cqQNUzqUfb6vUp2+QO9G4JzU
         byqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYy6t1vC/vw9kUGpEpxIhpvBUQI0S0mxIu11GDRr2cg=;
        b=e4XmnR1YdiGYmsWT89M8WV3EYJaBWEvqKOaWQktJ9+zX1w2L6KsT2wAXp35Ps1J/M3
         ++YzaycDUJ4QMWN5iA6P7UTeyvgywZUWK0X7aAICfS0JqJZk1csdP/HGVK07lYUcCkP7
         /bpICka3fxz3Nonbm1yDeosHie765b9i2TI4bRZHi0pcMI09vHjGVdATuOXlH+YaPrPM
         J4QLkhEY0QUmdr70dzR7hcczaSQIl27KHNhgJWQ+yxTFz9GqbtfWNCWyNQuRfdmBP05B
         qpCuW05eOOmVFIeaKysABjTli26cI3sLpVpbOiSvkjOdUKoB+jU8px+tA+8abggoHim1
         6LBw==
X-Gm-Message-State: APjAAAUcTuMuH8AClVCVqluZ5DrlY5/dxxZRqq2vGHx0tuFLE9QqtBKR
        oMv8O4fRVSY1uX9qUTsiedS0Pb6Z
X-Google-Smtp-Source: APXvYqz8GYeqfC/B207hzO7rJUZM3Sq1qYcVKz7ISr6Lrawc6CqlYR7Zxn07t317o8dzXsdjvwYYOA==
X-Received: by 2002:a05:600c:290f:: with SMTP id i15mr4751779wmd.115.1578665715589;
        Fri, 10 Jan 2020 06:15:15 -0800 (PST)
Received: from desktopdebian.localdomain (x4d03413a.dyn.telefonica.de. [77.3.65.58])
        by smtp.gmail.com with ESMTPSA id q15sm2369509wrr.11.2020.01.10.06.15.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:15:15 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 0/3] Add policy capability for systemd overhaul
Date:   Fri, 10 Jan 2020 15:15:06 +0100
Message-Id: <20200110141509.21098-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.25.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Support a SELinux overhaul of systemd by adding a policy capability and
adding a library method to obtain a current state of a policy
capability.

The systemd patch can be found at
https://github.com/systemd/systemd/pull/10023
and has NOT yet been accepted.

This is just a rfc to test the water.

Christian Göttsche (3):
  libsepol: add policy capability for systemd overhaul
  libselinux: add security_is_policy_capabilty_enabled()
  libselinux: add policy capability test binary

 libselinux/include/selinux/selinux.h          |  3 +
 .../security_is_policy_capability_enabled.3   | 27 ++++++++
 libselinux/src/polcap.c                       | 64 +++++++++++++++++++
 libselinux/src/selinux_internal.h             |  1 +
 libselinux/src/selinuxswig_python_exception.i |  9 +++
 libselinux/utils/.gitignore                   |  1 +
 libselinux/utils/polcap_enabled.c             | 30 +++++++++
 libsepol/include/sepol/policydb/polcaps.h     |  1 +
 libsepol/src/polcaps.c                        |  1 +
 9 files changed, 137 insertions(+)
 create mode 100644 libselinux/man/man3/security_is_policy_capability_enabled.3
 create mode 100644 libselinux/src/polcap.c
 create mode 100644 libselinux/utils/polcap_enabled.c

-- 
2.25.0.rc2

