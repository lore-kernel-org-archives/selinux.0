Return-Path: <SRS0=q6rH=QU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E97C4360F
	for <selinux@archiver.kernel.org>; Wed, 13 Feb 2019 21:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC78420842
	for <selinux@archiver.kernel.org>; Wed, 13 Feb 2019 21:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kBU+Jd0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfBMVfZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:35:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42998 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbfBMVfZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Feb 2019 16:35:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so2934370lfh.9
        for <selinux@vger.kernel.org>; Wed, 13 Feb 2019 13:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2+7cAkZjb0EpLI0oNagTM30oUolGQDJ6mTqrPIDH5AA=;
        b=kBU+Jd0Y4H3rTfxmYQ6KNEEfSckWdvcajkmWU+GQGPe/70f9p0V2Ph612CupKwtCkW
         fwFn4c/z1ZLhQyiuahgdeD1XcwVlP8dsWDnGCVv/vfyJrja8yujsemivgc+XtU3AVgZM
         fyMWwC8t4Ci2F0pUze9Rrv9h6HZK+ASmaPUhSfbrHpAzLUym9IcJGKgHoLQnENyNDu2Z
         ACE1iulLuQ8r/bB5kKis7SHZI4I6qG2rXWOTM8+xeT4f85BDAfNo0I2a9WuqJ4Yt6+WX
         TcVoYiZLkVRuzunMBip1c2R6LukrMObFt3UqmWZjFR5CW5+KKCtzdeZNEL5HeRZ6Udjs
         ML0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2+7cAkZjb0EpLI0oNagTM30oUolGQDJ6mTqrPIDH5AA=;
        b=E9SDmFUFqbWmVm8muL8grMhi/tQca413qx843fXqTkixb/fh/MaF1G6nDcwLU9RV7S
         mW8/GD/Zd1PYIfVW7eF8g7gfwzPMOjL17hhTVOlH+Qs0aSbFpRu8dRUmjSKG+de93hqZ
         7iWBrd925xKzqZ2m1Q4bRbo2O7ui68720vo2uWF4c0mvmHePBM2nglP8qOI4XFRzMie2
         2n8/AtmS0bxXFusV7KzlqpVT15VREpP6SpJ2mjDEF8/Un/a9lIHEBKSXM0L1ysoIdwrX
         erlwf7HWLVdJNHTkZRHZxBzTWpQp6/sV3YIcmnGG238hwEBTj7QqRDqVYYv5C26CP6sZ
         mnmw==
X-Gm-Message-State: AHQUAuYacp9FPYSXw7V7sfWHCvAE/CutNJfAQd6ci0gcq/C1jdvm+NhY
        08M1uVyTdTmLNWYRAXedNgNh4aeq6NirvnkUnjXepisyLA==
X-Google-Smtp-Source: AHgI3IYkF83kGyoCoAqt+UOg5hHJAmPvLx0AJ1FeNoTimmvIwIR2zFOCO+1g2VeLTMydy8mYTMwCpApDpB8+e6z1J6Q=
X-Received: by 2002:a19:384c:: with SMTP id d12mr130348lfj.105.1550093722741;
 Wed, 13 Feb 2019 13:35:22 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Feb 2019 16:35:11 -0500
Message-ID: <CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbgxSL1v04mouWw@mail.gmail.com>
Subject: IB pkey policy problem found via the selinux-testsuite
To:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Cc:     Lukas Vrabec <lvrabec@redhat.com>, danielj@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

On a fully up-to-date Rawhide system you need the following line added
to the policy/test_ibpkey.te file to get a clean run of the
selinux-testsuite:

  allow test_ibpkey_access_t self:capability { ipc_lock };

The breakage doesn't appear to be due to a kernel change (previously
working kernels now fail), or a Fedora Rawhide policy change (nothing
relevant changed since the last clean run), but I did notice that my
libibverbs package was updated just prior to the breakage.  I haven't
had the time to dig into the library code, but I expect that to be the
source of the problem.

-- 
paul moore
www.paul-moore.com
