Return-Path: <SRS0=sd8A=UG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F78C2BCA1
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 16:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8AA2089E
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 16:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="GZfl7z+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfFGQow (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:44:52 -0400
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:25413 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbfFGQow (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Jun 2019 12:44:52 -0400
X-EEMSG-check-017: 220220810|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jun 2019 16:44:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559925888; x=1591461888;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Or+5gbvyYL8/DoLezT3eOUfpJ0gKRKy9a+K2Pmi7/nw=;
  b=GZfl7z+/CnVXdtAXHlUb55CtWfhfZ+3AYVoViITP6yc2a143QlhjC+NK
   nj6zFHn4JWsfNfE3XDl7BaZsMkNnF62p44wtivzRbAJw9pYiZk7WPH6CC
   rw48NTCwIebxnTq1AHfFf+/AGKYHFJwF1N1p/GlZXvC+4ZohhUh1+HoCi
   A7Wygq7fEB7UdmXavFYCyebSedCAL23HIdFklI9z4J+d2szTR3aBSnrCG
   hCn6hHIrBlqV+ozjYoGreG1ObR28A20mqMipCB36XFWY01FH3EGxr0lAI
   wiN6aFS2MP0Ck6Q7uZxpQvUALa1nYOAIT53PNp2YiIISmbcSgNaPimiLK
   w==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557187200"; 
   d="scan'208";a="24520301"
IronPort-PHdr: =?us-ascii?q?9a23=3A9Sm7QxVjU7e6HN1H/OpYjFXbBbLV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRCPt8tkgFKBZ4jH8fUM07OQ7/m5HzVcv93Y6CtKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sBjdutMLjYZtK6s9xQ?=
 =?us-ascii?q?bFrmdGdu9L2W5mOFWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW?=
 =?us-ascii?q?5YUspMSyBNHoawYo0BAOobOeZTspfzqV0AoxCjAQWgHePixztNinLwwKY00f?=
 =?us-ascii?q?kuERve0QI9AdwOvnTaotb7OqgcXu+6zrXHwzrYYvNK2jrw8pTEfgwvrPyOW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllietJDlMC2N1uQNrWeb6fdrW/+qi2E9rwFxpiagx8cxgY?=
 =?us-ascii?q?TOnYIa10vE+D5lwIc1OdK4SEl7bcSiEJtLrS6WLYR2QsQ8Q2xxvisx174IuY?=
 =?us-ascii?q?ajcSQXx5kqyATTZvyaf4SS/B7uW/idLS1liH9jZbmxnQy98VK6xe35TsS01V?=
 =?us-ascii?q?FKoTdbndTUrXAN0gDT6tCASvtg4ketwTaP2B7X6uFDOU00ibDUK4Qgwr4tjZ?=
 =?us-ascii?q?ofq1jDHy/ql0X2i6+abEMk9fSz6+v7eLnmo56cN4tshgH/NKQhhNC/DPwlPg?=
 =?us-ascii?q?UBUGWX4+Sx2KD58UHnT7hGkOc6nrTBvJDfP8sbp6q5AwFP0oYk7hayFyym38?=
 =?us-ascii?q?kDnXQcMFJEeA6Ij4juO13UJvD4Fu2wj06jkDds2fDKJqfhDYnVLnjfjLfheq?=
 =?us-ascii?q?5w5FNSyQUpydBf/JJUB6obIP3tR0DxtMbXDgMjPwOoxObnDc131pkCVmKXHq?=
 =?us-ascii?q?+ZLKTSvEeN5uIuP+mMfpQYuCzjJPc45/7hl2M5lUUBcqmu2JsdcGq4Eeh+I0?=
 =?us-ascii?q?WFfXrshc8MEXwUsQo6TezqjkCCUDFIanasUKIz+Cs7BJilDYjdXICthqKO3C?=
 =?us-ascii?q?OhEp1RfGBGBQPELXC9e5qNX+wMQDifLs9ojnoPUr3lA6og0Ra1sAbkg4Z9K+?=
 =?us-ascii?q?PfsnkdtI75/MJ46+3aiVc58jkiS4yG3mWMSXxktn0HSiVw361lp0F5jFCZ3v?=
 =?us-ascii?q?tWmftdQOdP6utJXwFyDpvVy+h3GpimQQ7aVsuYQ1ahBNO9CHc+ScxnkIxGWF?=
 =?us-ascii?q?p0B9j31kOL5CGtGbJA0uXWVZE=3D?=
X-IPAS-Result: =?us-ascii?q?A2ATBgB9k/pc/wHyM5BmHQEBBQEHBQGBZYFnKoE8MoQ9k?=
 =?us-ascii?q?0EBAQEBAQEGgQgtiVGRCQkBAQEBAQEBAQE0AQIBAYRAAoJqIzgTAQMBAQEEA?=
 =?us-ascii?q?QEBAQMBAWwogjopAYJnAQUjDwEFUQsYAgImAgJXBgEMCAEBgl8/gXcUp3iBM?=
 =?us-ascii?q?YVHgymBRoEMKItbF3iBB4E4gjYHLj6HToJYBKkkCYIQghuRIAYbgiSKfIlxj?=
 =?us-ascii?q?Q+BKZcbIYFYKwgCGAghD4MokG0jA4E2AQGPLQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Jun 2019 16:44:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x57Gik0w013787;
        Fri, 7 Jun 2019 12:44:46 -0400
Subject: Re: New Container vulnerability could potentially use an SELinux fix.
To:     dwalsh@redhat.com, Miloslav Trmac <mitr@redhat.com>,
        selinux@vger.kernel.org
References: <7ca438c7-4a41-4daa-fc3f-a46a2e0af945@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9313f92a-46cf-c65c-6cfb-1373917de02b@tycho.nsa.gov>
Date:   Fri, 7 Jun 2019 12:44:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7ca438c7-4a41-4daa-fc3f-a46a2e0af945@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/7/19 11:42 AM, Daniel Walsh wrote:
> We have periodic vulnerablities around bad container images having
> symbolic link attacks against the host.
> 
> One came out last week about doing a `podman cp`
> 
> Which would copy content from the host into the container.  The issue
> was that if the container was running, it could trick the processes
> copying content into it to follow a symbolic link to external of the
> container image.
> 
> The question came up, is there a way to use SELinux to prevent this. And
> sadly the answer right now is no, because we have no way to know what
> the label of the process attempting to update the container file system
> is running as.  Usually it will be running as unconfined_t.
> 
> One idea would be to add a rule to policy that control the following of
> symbolic links to only those specified in policy.
> 
> 
> Something like
> 
> SPECIALRESTRICTED TYPE container_file_t
> 
> allow container_file_t container_file_t:symlink follow;
> 
> Then if a process attempted to copy content onto a symbolic link from
> container_file_t to a non container_file_t type, the kernel would deny
> access.
> 
> Thoughts?

SELinux would prevent it if you didn't allow unconfined_t (or other 
privileged domains) to follow untrustworthy symlinks (e.g. don't allow 
unconfined_t container_file_t:lnk_file read; in the first place). 
That's the right way to prevent it.

Trying to apply a check between symlink and its target as you suggest is 
problematic; we don't generally have them both at the same point.  If we 
are allowed to follow the symlink, we read its contents and perform a 
path walk on that, and that could be a multi-component pathname lookup 
that itself spans further symlinks, mount points, etc.  I think that 
would be challenging to support in the kernel, subject to races, and 
certainly would require changes outside of just SELinux.

If you truly cannot impose such restrictions on unconfined_t, then maybe 
podman should run in its own domain.

