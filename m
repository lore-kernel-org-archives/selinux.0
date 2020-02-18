Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E891C34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 14:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF11121D56
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 14:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gibO0JJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBRO3l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:29:41 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:43944 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgBRO3l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 09:29:41 -0500
X-EEMSG-check-017: 78577997|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="78577997"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 14:29:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582036180; x=1613572180;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aqzC3uzgzz2S8n/iikHO7esxFfikHM0iT/vUhg8dbS0=;
  b=gibO0JJ9ifTQs2Frjg+RMGTuFQY0llBtB8TEjhg0/caYYNK15/qS4GX8
   NEd0Ya1FOd8yOG0v2dJT1XmXMucftlafXmBnSpq6+iDBxOsE6jK7VPGT1
   JpvpmG2v9Cbe9HI5bFkMCiGsxgPGmM4UyS+fPStlTcVyRvAHhwOoVrsaf
   7sEOUdThh145xEkfXKveQKb8XtrEwu1P9u2pgEh1PZhub7MqUN+UoystW
   kUq6lYtF2uvzOtN7nLNtjUcOl6vZmOR4DXjwqr0Iz1u69WVub0R9uj3B5
   1axu15t5AQDjTWpE/ssQybmghtThqg2+V2I/vs3zqkUxnfdRV+whgxyPF
   g==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="39221948"
IronPort-PHdr: =?us-ascii?q?9a23=3A6RT+JhbXQIvCaZU+/zXu1Br/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsu/bnLW6fgltlLVR4KTs6sC17OK9f+wEjJcqb+681k8M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi5oAnLtMQbgoRuJ6c+xx?=
 =?us-ascii?q?DUvnZGZuNayH9nKl6Ugxvy/Nq78oR58yRXtfIh9spAXrv/cq8lU7FWDykoPn?=
 =?us-ascii?q?4s6sHzuhbNUQWA5n0HUmULiRVIGBTK7Av7XpjqrCT3sPd21TSAMs33SbA0Xi?=
 =?us-ascii?q?mi77tuRRT1hioLKyI1/WfKgcFrkqlVvAyuqAB+w47MYYGaKvx+fr/GfdgHQW?=
 =?us-ascii?q?ZNR9tdWzBdDo+5aYYAAfABPeJFpIfjoVUAowa1CQ21CO7vzjJEg3n71rA43e?=
 =?us-ascii?q?s8CwHLxBEuEcwAsHrUr9v7OqkdXu+3w6bUwjvOdO9W1DXn5YTUbhwsr/OBUL?=
 =?us-ascii?q?RtesTR00kvEAbFg02Np4z5ITyVzuQNvHad7+F9SOyvjnQoqwV1ojexxsYnl4?=
 =?us-ascii?q?7EhpkIxVDf7ih53IY0KsG4SE58e9KkFoBQuDuAO4t5RcMiXXhltSAnwbMFoZ?=
 =?us-ascii?q?62ZDUGxZsoyhLFa/GLbpKE7gzsWeqPOzt0mXRoc6+liRmo60iv0Oj8W9Gx0F?=
 =?us-ascii?q?ZNsyVKjMHBtmsI1xzP8siHTeZ9/lu51TaPyQ/T7uZELFgolaXBMZ4hw6Mwlo?=
 =?us-ascii?q?EJvUTCGC/2lkL2jLSIeUo44OSo9+Tmbanmpp+bLYN0jB3xMr8ylcClBOQ4Mw?=
 =?us-ascii?q?wOU3Ca+eS6yrLj4VX0TKhFg/A5iKXUsI3WKd4FqqO2HQNZyJsv5w66Dzi80d?=
 =?us-ascii?q?QYmXcHLEhCeBKCl4XpIEzBIOvjAPejg1WjjDdrx/fcMr3nGZXCNGLPkLjmfb?=
 =?us-ascii?q?Zj80Jc0hY8zchD55JIDbEMOOjzWk7tu9zYFBA5KRG7zP77B9pl1oMRQ2OPAq?=
 =?us-ascii?q?mHP6PJqlKH/f4vI+iKZI8Jpjn9Mf4l6ODyjXMjhVAdeqyp14MNaH+kBvRmP1?=
 =?us-ascii?q?mZYX30j9caD2gKugs+TOr3iFyNSjNTeXmyULwm5j0hC4KpE53DRoazj7yFxi?=
 =?us-ascii?q?u7GYdWZm9eAFCWDXjob5mEW+sLaC+KOs9uiCEEVby6Ro85zx6uqQv6x6NiLu?=
 =?us-ascii?q?rT/S0Yr4zs2MJp6O3UkBFhvQBzWv6c2GGEVW08vmoJQTItlPRloEd9w02P5q?=
 =?us-ascii?q?NPg/VZE9FIz/lVUwEmOITawvA8ANf3DFHvZNCMHW26T82mDDd5ddc4x9sDcg?=
 =?us-ascii?q?4pANm5pgzS1CqtRbkOnvqEA4JiofGU5GT4O8sokyWO76ImlVRzB5ISZGA=3D?=
X-IPAS-Result: =?us-ascii?q?A2C4AwDX80te/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XuBbSAShD6JA4ZhBoE3iXCRSgkBAQEBAQEBAQE3BAEBhEACgic5BQ0CEAEBA?=
 =?us-ascii?q?QUBAQEBAQUDAQFshUOCOykBgwEBAQEBAgEjFUEFCwsYAgImAgJXBg0IAQGCY?=
 =?us-ascii?q?z+CVwUgq2N1gTKFSoNmgT6BDiqMPnmBB4ERJw+CXT6ELoMtgjwiBJdSRpdyg?=
 =?us-ascii?q?kWCUJQDBhybJqw9IYFYKwgCGAghD4MoTxgNnQEjA457gkIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Feb 2020 14:29:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IESapU267902;
        Tue, 18 Feb 2020 09:28:37 -0500
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Use native filesystem for fs
 tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com
References: <20200214085643.3119-1-richard_c_haines@btinternet.com>
 <0afb0459-f043-e075-b984-fad7366ca19c@tycho.nsa.gov>
 <3c5c193c0c40a8de86a6fe42d54b1941486fa7a4.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <186a0ca5-802d-44d8-7fbf-1fd918591fff@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 09:31:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3c5c193c0c40a8de86a6fe42d54b1941486fa7a4.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/18/20 9:18 AM, Richard Haines wrote:
> After more testing these definitely require 'unlabeled_t' when running
> NFS:
> #
> # These rules are required otherwise some nfs tests will fail when:
> # mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
> # And:
> # mount -t nfs -o
> vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0
> localhost:$TESTDIR /mnt/selinux-testsuite
> #
> allow test_filesystem_no_getattr_t unlabeled_t:dir search;
> allow test_filesystem_no_mount_t unlabeled_t:dir search;
> allow test_filesystem_no_remount_t unlabeled_t:dir search;
> allow test_filesystem_no_unmount_t unlabeled_t:dir search;
> allow test_filesystem_no_watch_mount_t unlabeled_t:dir search;
> allow test_filesystem_no_watch_sb_t unlabeled_t:dir search;
> allow test_filesystem_no_watch_t unlabeled_t:dir search;
> 
> Any idea why ??? Not required when rootcontext set.

I'd guess that this is a bug I've sometimes seen with labeled NFS, where 
the top-level mounted directory shows up with unlabeled_t initially and 
then later gets refreshed to a valid context.  If we can get a trivial 
reproducer it would be good to send it to the NFS developers, 
particularly those who have submitted fixes for labeled NFS previously, 
e.g. J. Bruce Fields, Scott Mayhew.

> Regarding xfs quotas - XFS supports quotas internally but does not call
> security_quotactl() or security_quota_on() hooks.
> I could ignore testing quotas on xfs or test. If tested they would fail
> when denying the quota permissions. Which would you prefer ?

IMHO, the tests should fail because there is a real gap in checking in 
xfs that should be addressed; it should call those hooks as appropriate 
if it has its own implementations of quotactl() / quota_on() and doesn't 
use fs/quota/*.c common code.
