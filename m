Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8756EC7618A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 07:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCTHYI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 03:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCTHYH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 03:24:07 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA47914492
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 00:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1679297039;
        bh=4ByaJAnTQ98G237xtCML/mHefNTpC96i91BmJ8WaPfg=;
        h=From:To:Subject:Date:From;
        b=d07P53T/cr7QhgF6FyzVFjo1wleD9GllddJD0l+tYAxcznLJB2kRiaIlCQSQdHjZs
         0STv/wcAcCKJDrLhLJoxkuYfcPUvxz1j1k//JbNLq8R+PLXFPYy5CFWj1FSYGSkJZ5
         TUPSbA0oOkWmcFomJ1Ra1sPXLu6BQOQOzGxIXDYo=
Received: from paulus (paulus.lan [IPv6:2a10:3781:2099::515])
        by markus.defensec.nl (Postfix) with ESMTPSA id 6A50534F
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 08:23:59 +0100 (CET)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: cgroup2 labeling question
Date:   Mon, 20 Mar 2023 08:23:58 +0100
Message-ID: <87mt47ga29.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Hi,

I was reading this pull request [1] and looked into how I might be able
to implement this in policy but there seem to be some technical
difficulties.

* I already use getfscon to seperate the systemd user.slice because the
  system manager delegates the user.slice to the user manager.

  (genfscon "cgroup2" "/user.slice" cgroupfile_context)

  In the past the proved to be a racy where systemd attempts to
  write before the object has the context associated with the genfscon.
  I decided to dontaudit attempts to write to the mislabeled object and
  it *seems* as if systemd retries until it can write it i.e. when the
  object carries the expected label and so that seems to work eventually
  but it looks fragile.

* The challenge with memory pressure implementation [2] is that these
  "memory.pressure" files end up in random locations under
  "/system.slice" for example:

  /sys/fs/cgroup/system.slice/systemd-journald.service/memory.pressure

  Where in the above systemd-journald.service might be
  templated (systemd-journald@FOO.service). Point is that the path is
  random. genfscon does not support regex and glob. I can't do for example:

  (genfscon "cgroup2" "/system.slice/.*/memory.pressure"
  cgroupfile_context)

  Fortunately cgroup2fs supports relabeling but if systemd has to
  manually relabel the cgroup files then I would imagine that this is
  racy as well, and that does not really solve the underlying issue.

  I am looking for ideas and suggestions

[1] https://github.com/SELinuxProject/refpolicy/pull/607
[2] https://github.com/systemd/systemd/blob/main/docs/MEMORY_PRESSURE.md
-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
