Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05763C61DA4
	for <selinux@archiver.kernel.org>; Thu, 23 Feb 2023 14:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjBWOPM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjBWOPL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Feb 2023 09:15:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040994AFD0
        for <selinux@vger.kernel.org>; Thu, 23 Feb 2023 06:15:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id iv11-20020a05600c548b00b003dc52fed235so8292424wmb.1
        for <selinux@vger.kernel.org>; Thu, 23 Feb 2023 06:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J79QArV4GmkHaPU6S0D4Reib3HVRTMsJpXZQ4heGCrg=;
        b=E6QtKWRYOn4xw8Ajx3TDFlUTyw7hFBpx2XJZKJ7jTF1bLgIAnrUZrmaf7LfVmVlB6+
         R5C6oqKiH3kBJYDROKSSJzCFsQx6kuY4l3N9qeAh3XB2o8V8y7rIU7xyGAoXJ3nya4yK
         KmhyaVamwUO9YQH66MxgpNf3swT47cJcY3ym6EmyXlwF1XncEFwQs889wOW2OllD+h5F
         uTA4y1EPDhQmEjMbHFYzn8wCsNsVp8phMVmlAYICogr+WTvWIa+TQzEhUrP+2hbfz60g
         RlwDm0/ctiaClrqr4WHKkx9YJWn5fiYjJDRmeIA5YcOKhGgX2580t7VmvUvJpvNUBm3g
         sNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J79QArV4GmkHaPU6S0D4Reib3HVRTMsJpXZQ4heGCrg=;
        b=HpECi93wp0FUgjf3b3n+svi3lchqFleLLGSp4gOB6e6dcBvAfEIdQdQXWtBZxGIX1C
         p7s2ZuTOd+rYGNvQN6q9O8QF49JR79T7NR+ufw8wypNWrkmlt6Sjoc7SCZGAm6Xr9CAv
         TV9jLPcBimLo7IRSGBIVyJjx4XAUpQhcRK40OI4Km3GbVW5JvyqNe5kTLyrKLSFrJnkg
         SbMFThhO5E2tFlKyQJvcz0yel0UszfcEQIO0n79aqXAHzHgrluATu0yGgdeTRo/1hp1n
         oibyEvKPacJEnvsRRCmgc7cUreF1EkGKXjDvkPIawhodzjSWnfdpq3SZ4/Kw9akk1rEx
         eCdA==
X-Gm-Message-State: AO0yUKV78JC5itWDuQoxq6X3bCroRGHjpZCYUPl/tsua4G8ISQAjJJAl
        btMLKg55xNO/cEVzzudhVBxL7F+rOQa/+Mc7RIenMQ==
X-Google-Smtp-Source: AK7set/PJcRFXj0DpNM4rt/Nt2HRrZU9vujVkqz9J3DQTP1/axbnOaT3e+dZxtJ1R7COL35ExDSo0Q==
X-Received: by 2002:a05:600c:43c6:b0:3e1:fc61:e0e1 with SMTP id f6-20020a05600c43c600b003e1fc61e0e1mr2707211wmn.11.1677161705980;
        Thu, 23 Feb 2023 06:15:05 -0800 (PST)
Received: from localhost (43.red-79-144-25.dynamicip.rima-tde.net. [79.144.25.43])
        by smtp.gmail.com with ESMTPSA id j29-20020a05600c1c1d00b003e204fdb160sm6200892wms.3.2023.02.23.06.15.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 06:15:05 -0800 (PST)
Date:   Thu, 23 Feb 2023 06:15:04 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.5 release
Message-ID: <Y/d06B8CEJM4bUEU@meriadoc.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello!

The 3.5 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/perfinion.gpg

Thanks to all the contributors, reviewers, testers and reporters!

With Kind Regards,
Jason Zaman

User-visible changes
--------------------

- Maintainer GPG fingerprints added to /SECURITY.md

- semodule option --rebuild-if-modules-changed was renamed to --refresh

- Remove dependency on the deprecated Python module distutils and install via pip

- libsepol: Stricter policy validation
- libsepol: do not write empty class definitions to allow simpler round-trip tests
- libsepol: reject attributes in type av rules for kernel policies

- libselinux: add getpidprevcon()
- libselinux: restorecon hashtable and other misc fixes
- libselinux: Add workaround to reduce pcre2 heap memory usage

- sepolicy: Several python and GTK updates
- sepolicy: Add missing booleans to man pages
- sepolicy: Cache queries to speed up manpage generation

- mcstrans: preserve runtime directory
- fixfiles: Unmount temporary bind mounts on SIGINT

- Large updates to translations and better handling for unsupported languages
- Translation updated and better handling for unsupported languages
- Translation updated for generated descriptions

- A lot of static code analysis issues, fuzzer issues and compiler warnings fixed
- Bug fixes

Development-relevant changes
----------------------------

- Install python modules via pip instead of setup.py
- ci: Run on Fedora36 instead of F34
- ci: Run on Python3.11 and drop py3.5, py3.6
