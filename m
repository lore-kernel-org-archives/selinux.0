Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27ABC2D0DB
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 13:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B8F20720
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 13:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="n5BOOz0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgA2NGE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:06:04 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:65213 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgA2NGD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 08:06:03 -0500
X-EEMSG-check-017: 51309602|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,377,1574121600"; 
   d="scan'208";a="51309602"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Jan 2020 13:05:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580303158; x=1611839158;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=nJXvONOsRIEWKtL4mJt4bfG2mDt7qD8W/iJSHsGwgBg=;
  b=n5BOOz0u8FZCEyoFu9+s23aWkFYi/MxmTOVryf2ZOc47Z0rPMUbJwLy6
   R5AFRB9oUFAG1DwIIEpbPpWXvgwDuP0yunUrZE1hoj2m50WmZj/HrgrcX
   /zZjojIohVAwk1/J5DGaqEQx0ulyAJvpZp8/D0NrxyqAsZ7Zd+2wT2A7h
   1ZLzGHthFTf01mgSeVl4WQIEGfYe1HFWVSDREqh5QzS5zsSoGuH+cXaXP
   uUGW55EP+yF19PJ7xw74rSrRm2mvkOxNByBGSAr7S4xNfo1we1YCMsAk7
   h/LO3+7a8LQsZf8I0SaRP7v+/ZxQ2LlENQuDF4mKTtntQ+lJ90MgMsd4y
   A==;
X-IronPort-AV: E=Sophos;i="5.70,377,1574121600"; 
   d="scan'208";a="38393021"
IronPort-PHdr: =?us-ascii?q?9a23=3AirVqEhIod4VNdeg1ANmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXK/n/rarrMEGX3/hxlliBBdydt6sYzbGI+Py9ESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4JKs8yx?=
 =?us-ascii?q?TFr3RIdu9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
 =?us-ascii?q?41/srrtRfCTQuL+HQRV3gdnwRLDQbY8hz0R4/9vSTmuOVz3imaJtD2QqsvWT?=
 =?us-ascii?q?u+9adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYMgXTn?=
 =?us-ascii?q?RdUMlPSyNBA5u8b4oRAOoHIeZYtJT2q18XoRejGQWgGObjxzlGiX/s2a0xzv?=
 =?us-ascii?q?ovHwfI0gc9G94CqXTZodHwOKoUTOu7zrTHzS/bYv1Lxzn95ojGfBMvr/6CUr?=
 =?us-ascii?q?1/c9bex0Y0GgPZjFids5DpMy+b2+kPtWWQ8upuVfioi24iswx/vySvydk0io?=
 =?us-ascii?q?nJmI0VzE3P+zh8wIkvId24TFB0YN65G5ZXrCGVKpB2T9g+Q2BopCk6yroGtY?=
 =?us-ascii?q?S9fCgR0psr3RHfa/uZc4WR5B/oSeWfIS9giX54d7+yiAy+/Ei9xuHmSMW530?=
 =?us-ascii?q?hGojBYntTKq3sDzQbc6tKdRft45kqh3DGP2B3N5excOkA0kLbbK4Ymwr4tip?=
 =?us-ascii?q?ofqUTDETHymEXxlKKWal8r+vKp6+T6ebXqvJ6cN4l6igH5KaQhhNCwDf4kMg?=
 =?us-ascii?q?kOQ2eb+eO82Kfl/ULlW7VFkuc6kqzYsJDePcgbp6i5DBFJ0os79hqyADir3M?=
 =?us-ascii?q?4YkHUaNl5JZh2Kg5bzN13TOPz4CO2wg1WokDdl3fDGObjhD43WLnfei7fsZq?=
 =?us-ascii?q?p96k5AxwozytBT/ZRUCqobL/7pVU/xs8LYAgcjMwOo2+bnFMl91oQGVGKVA6?=
 =?us-ascii?q?+WLKPSvkWS5u0yO+aDeJcauDbnJPgk4f7hk2Q5lEQGcqm13JsXbmy4Eep8I0?=
 =?us-ascii?q?Wff3Xsns0NHnsNvgo7VObqkkGNUSZPZ3auWKIx/io7B5yiDYfCQICtnbOA0T?=
 =?us-ascii?q?ylHp1ZeG9GEEqAEXT2eIWeXfcDdiaSLtVmkjweWrirU5Uh2g22tA/m17pnKf?=
 =?us-ascii?q?LZ+iodtZLkz9h14ffcmg0s+jFvFcSSzXyCT2FukWMUXTM5wKd/oUllwFeZza?=
 =?us-ascii?q?d4m+BYFcBU5/5RSgc1L4Pcz+hhBtDqQA3BY9OJRE+jQtWhBjExVMw+z8USbE?=
 =?us-ascii?q?Z6HtXxxizEihCrCL8cjbDDJJU19K/HlyzrJs19wmzK46IWj1AnRMZUHWe6h6?=
 =?us-ascii?q?hj+hLVCpKPmEKcweLibqkY3SjQ5E+dwmeU+kJVSgh9VePCR39bLmzQoc705A?=
 =?us-ascii?q?vnSKSoAL8qMUMVzsuFMa1DYdDBl1hKRP7/ft/ZZjT101+5GBLA47SLdoeiL3?=
 =?us-ascii?q?0UwSH1EEEZl0UW+nGcOE41ASL38EzECzk7Lk7ie0Ph96FFrXq/SkIlh1WRY1?=
 =?us-ascii?q?ZJy6u++hlTg+eVDfwUwORX628atzxoEQPljJrtAN2aql8kJfgNbA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CSAADIgTFe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gWwBIBKEPokDhlkGgTeJb5FJCQEBAQEBAQEBATcBAYRAAoJNNwYOA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjFVELGAICJgICVwYBDAgBAYJjP?=
 =?us-ascii?q?4JXJaxqgTKFSoMkgT6BDioBjDl5gQeBOA+CXT6ELoMrgjwiBI1SiWJGepZkg?=
 =?us-ascii?q?kOCTJNlBhuCSJg3jmCBSptTI4FYKwgCGAghDzuCbU8YDZ0BIwOMNYJCAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Jan 2020 13:05:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00TD55F4020490;
        Wed, 29 Jan 2020 08:05:08 -0500
Subject: Re: [PATCH V2 0/2] selinux-testsuite: Add fs*(2) API filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
References: <20200127093249.3143-1-richard_c_haines@btinternet.com>
 <29631d39-9d64-71b4-5fb7-8a0180466f73@tycho.nsa.gov>
 <a282f10df731b296be6575bb97ba76b15100203c.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <006305a6-f794-9a9b-7a56-c3661ecb8668@tycho.nsa.gov>
Date:   Wed, 29 Jan 2020 08:06:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a282f10df731b296be6575bb97ba76b15100203c.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/29/20 7:56 AM, Richard Haines wrote:
> On Mon, 2020-01-27 at 12:46 -0500, Stephen Smalley wrote:
>> On 1/27/20 4:32 AM, Richard Haines wrote:
>>> These patches update the current tests/filesystem to share code
>>> (patch 1)
>>> with the fs*(2) API filesystem tests (patch 2).
>>>
>>> V2 Changes:
>>> 1) If kernel patch [1] installed move_mount test for denying
>>> FILE__MOUNTON
>>>      should pass. If not installed, display 'Failed as kernel 5.x
>>> without
>>>      "selinux: fix regression introduced by move_mount(2) syscall"
>>> patch'
>>>      (as there is a regression that should be fixed).
>>>      Note: Kernels 5.2 - 5.5 will fail unless [1] backported. 5.6 is
>>> expected
>>>      to have [1].
>>> 2) Move policy changes to patch 2.
>>
>> These look ok to me; we'll see if anyone else objects to the error
>> message.
>>
>> One other item that occurred to me is that most of the current
>> filesystem and fs_filesystem tests are only exercising ext4
>> regardless
>> of the native filesystem in which you run the testsuite (e.g. if I
>> run
>> it on a labeled NFS mount most of the tests end up running in the
>> ext4
>> filesystem that is created and mounted rather than on labeled NFS
>> itself, and likewise if I run it on xfs or btrfs or ...).  For tests
>> where it does not matter (e.g. the type_transition tests) it might
>> be
>> better to run those on the host/native filesystem directly so we can
>> more readily reuse those tests.  Obviously the mount tests
>> themselves
>> require some other filesystem besides the one in which the testsuite
>> itself resides.  Don't know if people may want to make it easier to
>> substitute or add additional filesystem types for testing; you
>> already
>> provide a fs_type variable in the test script but that requires
>> patching
>> the script and still only supports testing one filesystem type at a
>> time.
> 
> I'll do some work on making the tests use the native filesystem and add
> an option to select a different one.
> I quess I could add a list of fs to run against from relevant
> proc/filesystems entries? (or something else)
> 
> I had a go with xfs and found Fedora is configured by default to use
> the xfs quota system, however that does not call security hooks
> security_quota_on or security_quotactl so not worth testing, otherwise
> apart from increasing the block size seems okay.
> 
> I also have another patch ready as I noticed that I missed these:
> hooks.c selinux_path_notify() FILE__WATCH_SB
> hooks.c selinux_path_notify() FILE__WATCH_MOUNT

Make any further changes relative to these patches because I expect one 
of us to merge these barring objections.

Lack of LSM quota-related hooks on xfs seems like a bug / gap in 
coverage that should be fixed.

At least some of the watch permissions are tested by tests/notify/* and 
further tests would logically go there I think.
