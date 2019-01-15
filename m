Return-Path: <SRS0=jgNJ=PX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BD2C43612
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 14:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC8620866
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 14:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="N9Z5fWrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfAOOet (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:34:49 -0500
Received: from uhil19pa10.eemsg.mail.mil ([214.24.21.83]:10012 "EHLO
        uhil19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729775AbfAOOet (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jan 2019 09:34:49 -0500
X-EEMSG-check-017: 375454073|UHIL19PA10_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Jan 2019 14:34:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547562886; x=1579098886;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OB9VpZtlNDs+VjrHv/fQi0RVJvbnnYvmdw2sLFfEvdA=;
  b=N9Z5fWrdVUYaV+Q3Qk4PSvEeOVULUStsKxXU7DindL7m8BGO1vQUpBW6
   OWfXphrEQnr/a4Fux7eptR4wuTjhDAMljQksVtVDwN4WAp62gFTT4nbWf
   b5qGZqMoLdXtR+cW41whcM4hxgQTQ66YAXu6rGfMBcZ2tM+ffA1z4dMRF
   XZ5ZibW/Jt5eWM6PnNMjaXPDy5TZ4NIX/sdaFCHACgYDRF78wFtR3QI+n
   aHaZq8t8qCp4oOvHoP5LzopQTNNDfM0RLMGWZh83H7c8BQAl0I1awOT79
   NCW/wo5ozJbRlBSWkzMs6f+Bs4NZVPOh4bh1PtZ5k5V4jIVdspkBltUKf
   g==;
X-IronPort-AV: E=Sophos;i="5.56,481,1539648000"; 
   d="scan'208";a="22678798"
IronPort-PHdr: =?us-ascii?q?9a23=3AAmHTJheHGyMLYSEn1hmiKB+LlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc25YhON2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhEo4X4oVYFsBmwChS2BO731zFGmHH206053e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4Nr0fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJd8Gqa6iGAJVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2IHI0hfdBKIiIjpJUnCIOrkAvenn1SsjDBryujaPr3jGZjNLWbMkK3nfb?=
 =?us-ascii?q?lj705Q0g0zzcpQ55hMELEOPOrzWlPttNzfFhI5NAm0w+H8CNV7zIwRRXyAD7?=
 =?us-ascii?q?SDMKzMrFCI5vggI/WWaIAJvzb9LuAv5+Tygn8hhV8dYa6p0IMMaH+mGvRmIk?=
 =?us-ascii?q?OZYWfjg9oaD2cKsRQxTPbwhF2BTzFTfXCyULw45j0hD4KmF4jDTJi3gLOdxC?=
 =?us-ascii?q?e7AoFWZmdeB1CUC3joaoGEVuwUaC2IP89hliUIVb2mS48mzxGhqhX2xKZgLu?=
 =?us-ascii?q?rR4icYr47s1MBp5+3PkhE/7Th0D8Wb02GQQGB4h3gISCEq06Biu0x9y0uD0K?=
 =?us-ascii?q?hhj/xdEtxc+u5JUgMkOpPH0ex6BM79WhjbcteKVlmmWNOmDi81Tt4rxN8OeU?=
 =?us-ascii?q?l9Ec24jh/fxyqqH6MVl7uTCZw76KLTwXfxJ8V9y3vd0Kkhjl8mQtZANG2oga?=
 =?us-ascii?q?5/6g7TCJPTnEWFlqaqcqIc0DTK9GeZwmqEpFtYXxJoUaXZQXAfYVPbrdD45k?=
 =?us-ascii?q?PEUr+vBq0rMgVaycGfNKRKdMPmjVFdSff9N9TRfXixl32zBRmW3LOMapTle2?=
 =?us-ascii?q?EH0CXaEkgEnBgZ/WyaOggmGiehv2XeASRyGlLgeUPs9vR+qGugTkIv0QGKYF?=
 =?us-ascii?q?Nu16Cv9h4Wm/OcUfUT0awAuCs7rDV0Blm91crMC9WcvwphYLlcYdQl7VdFy2?=
 =?us-ascii?q?3ZuQJ9PoK7IqBtgV4edAt3v0fw2BltFopAls0qpmswzAVuMaKYzE9BdzSA0J?=
 =?us-ascii?q?/tNLzYMG3y/Auva6PNwFHRzsuZ+qcV5/QksVnsoAapFk9xu0lghuVY0Waarr?=
 =?us-ascii?q?XHC0JGTZDZUUst8RV+4bbAbX95r6TS2WdhM+GRtSTE0tkkB6NxzROnZNFWO6?=
 =?us-ascii?q?6sDgL+E8QGQcOpLbp5tUKua0c/IO1K9KMyd/ijfv+C1b/jaP1shxq6nG9H58?=
 =?us-ascii?q?Z7yUvK+C1iHL2bl60Zyu2Vi1PUHwz3i02s54Wuw9hJ?=
X-IPAS-Result: =?us-ascii?q?A2DRAAAq7j1c/wHyM5BjGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?YE1M4QolAxSBoE1iS+IWYdvOAGEQAKCQiI4EgEDAQEBAQEBAgFsKII6KQGCZ?=
 =?us-ascii?q?wEFIxUvEhALDgoCAiYCAlcGAQwIAQGCXz+BdQ2sd4EvhUKEcIELizQXeIEHg?=
 =?us-ascii?q?TiCa4gKglcCiUqGejiRCQmIaokdBhiBZIUminaJeJJVIYFWKwgCGAghD4Mok?=
 =?us-ascii?q?HkhA4E1AQGKIgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Jan 2019 14:34:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0FEYe11032295;
        Tue, 15 Jan 2019 09:34:41 -0500
Subject: Re: [PATCH 0/3] Allow initializing the kernfs node's secctx based on
 its parent
To:     Tejun Heo <tj@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Daniel J Walsh <dwalsh@redhat.com>
References: <20190109091028.24485-1-omosnace@redhat.com>
 <20190111205053.GV2509588@devbig004.ftw2.facebook.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fe933a61-78a4-081c-7da1-fd68b189481e@tycho.nsa.gov>
Date:   Tue, 15 Jan 2019 09:36:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111205053.GV2509588@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/11/19 3:50 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jan 09, 2019 at 10:10:25AM +0100, Ondrej Mosnacek wrote:
>> The main motivation for this change is that the userspace users of cgroupfs
>> (which is built on kernfs) expect the usual security context inheritance
>> to work under SELinux (see [1] and [2]). This functionality is required for
>> better confinement of containers under SELinux.
> 
> Can you please go into details on what the expected use cases are like
> for cgroupfs?  It shows up as a filesystem but isn't a real one and
> has its own permission scheme for delegation and stuff.  If sysfs
> hasn't needed selinux support, I'm having a bit of difficulty seeing
> why cgroupfs would.

Just to clarify with respect to your last point about sysfs, sysfs 
selinux support was first introduced in commit ddd29ec6597125c830f7 
("sysfs: Add labeling support for sysfs") for use by libvirt, and this 
support was carried over into kernfs, and is extensively used 
particularly in Android for controlling access to sysfs files.  The 
patch set in this series is extending that support to enable inheritance 
of security labels set via setxattr from parent to child when 
appropriate, which has particularly been requested for cgroup but would 
also be useful for sysfs.
