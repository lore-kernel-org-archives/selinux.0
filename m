Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E45DC433E0
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 18:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151452065C
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 18:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XGDtpJxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390090AbgEMS1N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 14:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733310AbgEMS1N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 14:27:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D717C061A0C
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 11:27:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id e2so324159eje.13
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=p4i5PCRdleYtSVb1Um0fvfBNEMNI517mLV/20fh+wpE=;
        b=XGDtpJxuXJgIPBunLQO3s0DNMbOym5+hsy9IoM1e0L+ZQROvuAmnEu8GK+y1pC7Tw3
         wznV0GSzzrvFxsgoFvGbhMg7h6qk1Q4wW9ZSZsdHgRReU7/e/1jJSfkD77Swujbqx3Tx
         +u9yBTLnJncIWG4fJSP4DC7ltb9hTwLZpMUUIQr1Hn+Gt9cU1RgpXl9r/iZiFl/QqUTx
         zzr307I2apuCj+osVAsLnQaB34Q9nGnuUT7Gwelh0lDHYCq/9ENoVgPJN1A2N1vo7pds
         Tty/LBzxrz4Bk3U58Wvnj5j3hVBOZrWolYbDZd+YQmCBaObBHptu8O1b+CdFBrHq4+m4
         qoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p4i5PCRdleYtSVb1Um0fvfBNEMNI517mLV/20fh+wpE=;
        b=HArLTpy71GtNzaiVAIK0N9V2yoUw4Pf6Q/jGVw1M3CuNfEanEV6wbtVb0kjaxf9QS9
         pwwWSSZHNayKyJRVgWHKD+Wqn3i5BLvytNrRaPASAFmWXDwBGDAvbK9MKrcXBqXGeAj5
         q7m3N5l+IhJc5nh2Or2rqk1idrSUVafGy61xiA23JmaIiOI4uProQHt7KxtONAnymDBd
         85YFL0vel3rVE8QVPfv+LjpDrzA5a3FdvawQ5WBjnTb129mMPmVI81slzH5P3a1HJrbT
         Yac7Ge8MmMP7WNR6yM8Vt+ib9acsIYE6GSMfFsYMOEPMvsri7TYpFCezzxyTH/YzZU1I
         xodw==
X-Gm-Message-State: AOAM5330/0Dkrn27U49W1Ao3bT6vvtWw5SPFQ/XCwBzjQU9E8FyN9KBD
        qTZNq2Qe9//4izVEFyWV2PQtL6HUnFoBJqB4QdPVHF5vgw==
X-Google-Smtp-Source: ABdhPJwYfJUQkVJZMqmknThca83ibioGwMbza6CWi/lvxFyIdW07dEELpry3yAkKxEZ7dEA5nSuppSyp47eZLArrMmw=
X-Received: by 2002:a17:906:35d0:: with SMTP id p16mr290581ejb.77.1589394431279;
 Wed, 13 May 2020 11:27:11 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 May 2020 14:27:00 -0400
Message-ID: <CAHC9VhRFGmyOk30ew=hTkBoW_A9N=fmv60WL8SWPpSbu1kHKxQ@mail.gmail.com>
Subject: The selinux/working-selinuxns branch has been rebased on top of selinux/next
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A quick note to let everyone know that the SELinux namespace
work-in-progress branch has been rebased on top of the current
selinux/next branch.  The branch is named "working-selinuxns" and can
be found both in the kernel.org SELinux git tree as well as the GitHub
mirror.

* git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
* https://github.com/SELinuxProject/selinux-kernel

-- 
paul moore
www.paul-moore.com
