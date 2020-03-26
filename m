Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EDDC43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E052073E
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BXhjDA9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgCZP1N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:27:13 -0400
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:48968 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgCZP1N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 11:27:13 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 11:27:12 EDT
X-EEMSG-check-017: 92394058|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,308,1580774400"; 
   d="scan'208";a="92394058"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Mar 2020 15:18:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585235920; x=1616771920;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YjRwbhfVitgBG37Hu86QmSmz7RP7EteWc6/78cgvmlc=;
  b=BXhjDA9D/21tPWm6j5iGFPPyL5AXa9wVjms3ydIbDlHcrQfPFB7vOOgn
   Rjj4AV3KFU06XFVOb4+5Lr+HImsns8JrLJGyqHq5JnZQ1GNbT2paH2Gmv
   tBemMFw7EfXERV+p9ihNoE1y41kqSx1+mSRytFTaJhhMiX8AlKFRjfIQX
   wi8t6es1DYeiRIALKnvFZxG+ncgndsru3hYckrz6SqoyI7cG0D7b4+xQp
   PHiWm4E28Cj7EawSsld5RwEnsgXVTLDFaWhSBAvODZa84RenmiKRlxIXV
   qVEyufhRqHkqlWZg/umhHlX8S/K83ldE4Bpy8x/B89mRDV26kKo6AG8iJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.72,308,1580774400"; 
   d="scan'208";a="41078747"
IronPort-PHdr: =?us-ascii?q?9a23=3Ap6xlABM/JpL5jJMgegEl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/T+rarrMEGX3/hxlliBBdydt6sYzbOL7Ou4CCQp2tWojjMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIxi6txjdu8kUjIdtNqo8zg?=
 =?us-ascii?q?bCr2dVdehR2W5nKlWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW?=
 =?us-ascii?q?5YUspMSyBNHoawYo0BAOobOeZTspfzqV0AoxCjAQWgHe3ixztNinLwwKY00f?=
 =?us-ascii?q?kuERve0QI9AdwOvnTaotb7OqgcXu+6zrXHwzrYYvNK2zrw8pTEfgwvrPyOW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllietJDlMC2N1uQNrWeb6fdrW/+qi2E9rwFxpiagx8cxgY?=
 =?us-ascii?q?TOnYIa10vE+D5lwIc1OdK4SEl7bcSiEJtLrS6WLYR2QsQ8Q2xxvisx174IuY?=
 =?us-ascii?q?ajcSQXx5kqyATTZvyaf4SS/B7uW/idLS1liH9jZbmxnQy98VK6xe35TsS01V?=
 =?us-ascii?q?FKoTdbndTUrXAN0gDT6tCASvtg4ketwTaP2B7X6uFDOU00ibDUK4Qgwr4tjZ?=
 =?us-ascii?q?ofq1jDHy/ql0X2i6+abEMk9fSz6+v7eLnmo56cN4tshgH/NKQhhNC/DPwlPg?=
 =?us-ascii?q?UBUGWX4+Sx2KD58UHnT7hGkOc6nrTBvJDfP8sbp6q5AwFP0oYk7hayFyym38?=
 =?us-ascii?q?kDnXQcMFJEeA6Ij4juO13UJvD4Fu2wj06jkDds2fDKJqfhDYnVLnjfjLfheq?=
 =?us-ascii?q?5w61RdyAUvzdBQ/YhUBawZL/3vQkDxtMbXDh4/MwOq2ObqE85y1p8fWWKJHq?=
 =?us-ascii?q?+WLrnSsVmW6eIzOeWDeIgVuDPlIfg/+/HulWM5mUMafaSxxpsYdnS4HvVgI0?=
 =?us-ascii?q?WEbnvhmckBEWgUsQokVuDqi0ONUSRVZ3msW6Iw/DY7CJipDY3bXICinKSB3D?=
 =?us-ascii?q?unHp1Rfm1GEVWMHm3odoWERfgNZjmfItV/nTMZVbiuUZMh2Quyuw/9zro0Zt?=
 =?us-ascii?q?bTrxcZvpLqztQ9x+TSkxwpvWhuDs+d2nuBeGpDnmoJQTIt9KpjoEphx02F3L?=
 =?us-ascii?q?Q+iPtdQ5gb/P5NUwEnJbbCwOFgTdP/QATMepGOUln1bM+hBGQKUt8pw9IIK3?=
 =?us-ascii?q?14EtGmgwGLizGmGJcJhreLA9oy6aua0H/vcZUug03a3bUs2gF1CvBEMner0+?=
 =?us-ascii?q?smrFne?=
X-IPAS-Result: =?us-ascii?q?A2AUAACWxnxe/wHyM5BmGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFqAgEBAQELAYF8LGxVMiqEGo9RBoE3iXqRTQoBAQEBAQEBAQEjE?=
 =?us-ascii?q?QECBAEBhEQCgi8kNwYOAhABAQEFAQEBAQEFAwEBbIVWDII7KQGCfwEFIxVBE?=
 =?us-ascii?q?AsYAgImAgJXBgEMBgIBAYJjPwGCSwMJJa1sgTKFS4NegT6BDioBjC4aeYEHg?=
 =?us-ascii?q?TgPgl4+ghswhRGCPCIEmACYVYJGglaFCY8kBh2CO5kkhFCKQZ4FI4FYKwgCG?=
 =?us-ascii?q?AghD4MnCUcYDZhhhCAlAzCBBgEBjh0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Mar 2020 15:18:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02QFIx8L082776;
        Thu, 26 Mar 2020 11:18:59 -0400
Subject: Re: [PATCH V2 1/2] selinux-testsuite: Use native filesystem for tests
 - Part 1
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     smayhew@redhat.com
References: <20200325130900.15047-1-richard_c_haines@btinternet.com>
 <20200325130900.15047-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3252199b-fadf-227f-251b-4b42a2dc267b@tycho.nsa.gov>
Date:   Thu, 26 Mar 2020 11:19:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325130900.15047-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/25/20 9:08 AM, Richard Haines wrote:
> Use the filesystem type that the selinux-testsuite is running from to be
> used for tests/filesystem. Tested types: ext4, xfs, vfat and nfs.
> 
> If testing locally -f <fs_type> can be used to test a specific type.
> 
> For NFS the following example shows how this should be run:
>      ./tools/nfs.sh filesystem -v
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

