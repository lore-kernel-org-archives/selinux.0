Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4722EC433EF
	for <selinux@archiver.kernel.org>; Sat, 11 Dec 2021 16:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhLKQXW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Dec 2021 11:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhLKQXW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Dec 2021 11:23:22 -0500
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2001:985:d55d::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FA8C061714
        for <selinux@vger.kernel.org>; Sat, 11 Dec 2021 08:23:21 -0800 (PST)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id EBE6BFC045A
        for <selinux@vger.kernel.org>; Sat, 11 Dec 2021 17:23:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1639239798;
        bh=u4T6316Au+Oxo/pwHEzP1CoWFowj2YL+srb3hi9a1jo=;
        h=From:To:Subject:Date:From;
        b=AHwPCZ/RnoSEIdwcOtFsQlqsNgnTXMCOu2+HKc7PT9ig6/AT0y6OfYyTG33CO71Xl
         Xw+ZjOUA7Znvl+3w0uoDOuE9OfKHxdWdRycFI+IBPfKq86l+Yhrs9isTutRu9/svxv
         NDTGbwQXMZYdKfXpEUQrgktvZryXkjZd7fawv3ns=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: overlay userxattr seems to not adhere to defaultrole
Date:   Sat, 11 Dec 2021 17:23:17 +0100
Message-ID: <87lf0ri00a.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


I am playing with Podman and I hit a weird issue with "overlay
userxattr" (i think)

kcinimod@brutus ~ $ podman run --privileged -ti --security-opt label=type:unprivcontainer.subj --security-opt label=user:wheel.id --security-opt label=role:wheel.role --security-opt label=level:s0 docker.io/library/debian:bullseye-slim

overlay on / type overlay (rw,relatime,context=sys.id:sys.role:containers.state.file:s0,lowerdir=/home/kcinimod/.local/share/containers/storage/overlay/l/FPIF7LXLIM5QBYHUHAUCYFLEI2:/home/kcinimod/.local/share/containers/storage/overlay/l/KLTLS5C6XS5QGTXVJF3WR7C7QT,upperdir=/home/kcinimod/.local/share/containers/storage/overlay/c57e0d37827226729251593f1ae87cdf40eaa1615e29f5c76459dae33f00b940/diff,workdir=/home/kcinimod/.local/share/containers/storage/overlay/c57e0d37827226729251593f1ae87cdf40eaa1615e29f5c76459dae33f00b940/work,userxattr)

Dec 11 16:54:18 brutus conmon[167588]: touch: cannot touch 'test': Permission denied
Dec 11 16:54:18 brutus audit[167608]: AVC avc:  denied  { create } for  pid=167608 comm="touch" name="test" scontext=wheel.id:wheel.role:unprivcontainer.subj:s0 tcontext=wheel.id:sys.role:containers.state.file:s0 tclass=file permissive=0

Note how it tries to create "test" with sys.role (object_r) and how it
does not adhere to the hosts default_role rules:

root@brutus:~# seinfo --default | grep "role file"
   default_role file source;

It works fine for "defaultuser", and I assume for "defaultrange" as
well.

Does anyone recognise this behavior in the SELinux kernel code?

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
