Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA32C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 13:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97898207FD
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 13:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="C3IH4lL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgA0NyR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:54:17 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:41085 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgA0NyR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 08:54:17 -0500
X-EEMSG-check-017: 73709000|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="73709000"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Jan 2020 13:54:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580133254; x=1611669254;
  h=subject:to:references:from:cc:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tnKDP9LmFNVrPLg/9EiUm0LEb0whPLqhhVPu9Mwy7UE=;
  b=C3IH4lL5CxmdEkCH1731ybzWCZ/GvL3jZBQL2tPHwnAR9YyW6GMs33xs
   MN8cjCsfSEFjBgO414UaVMNvMDTOUADvm/UFyKYpEUwmFYFhThxX+krQ/
   ZKJttNmNbppTIk4bT47RZaEXGc1BRxtpG11SIMXCsAbGWDsBotSe2ASTz
   LQ4knWTBHNmRbmd0xcFYbLlgBjz922M1+XzB2lghba7NlyEwyiMzLlvAw
   SIjLubAOenjE45gg5JiE9rXj5FSCQE9ooEfyBxrabIoiEqinjIWHyzjSC
   6cS+NZvib+zRhp59V7yyTSV7D62C37XLxN/8qwMgziocKlmLvrVXvf+A5
   g==;
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="32351382"
IronPort-PHdr: =?us-ascii?q?9a23=3APDMbehyykWYIGCrXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2u8XIJqq85mqBkHD//Il1AaPAdyHrakewLeL++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMj4ZuNKk9xx?=
 =?us-ascii?q?vJr3BVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBtwDvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFQ7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2Mpth1xrSa3xscslI?=
 =?us-ascii?q?bJgJ8exE3B9SpjxIY1IcO3SU5matOjC5tfqjqaOpBqQsIiX25ouCE6xqcAuZ?=
 =?us-ascii?q?6gZicG0psnxxnBa/GedYWD/xztVOGUIThihXJlfqqyhxmz8Ui8yu38S9K73E?=
 =?us-ascii?q?xWoSpCl9nBsG0G2R/L6sWfV/dw8Uis1SyP2gzO8O1IP085mbTBJ5I8xLM7i4?=
 =?us-ascii?q?Advl7ZHiDsnUX7lKqWdkI59ee28+nnebDmpoOEN49zlwH+LrwimsyhDuQ8NQ?=
 =?us-ascii?q?gDR3Sb9v6m1L3i4E35W69GjvwwkqnXt5DaPtoUqbKjDw9J0ocs9xa/DzC83N?=
 =?us-ascii?q?QegXYHN05KdAiCj4joP1HCOPH4DfGhjFSwiDpn2v/LM7L7DpjNM3TPiqntcL?=
 =?us-ascii?q?lj50JG1QY/1dVf6IhVCrEFLvLzQEjxtNnAAx8iLgO02P3qCMl914wCWWKPBb?=
 =?us-ascii?q?WVMKXJsVCS/O4vLO6MZJENtDbnN/cl/+LujWM+mVIFZqmmw58XaHG+HvR7LE?=
 =?us-ascii?q?SUemTsgtgfHmcQpAY+T/LliEeEUTFNY3a+RaU85is0CIi+F4fMWpitgKCd3C?=
 =?us-ascii?q?e8BpBZe2dGClWNEXfudoWLR/QMZDidIs97kzwEW6ShRpQ82h6wug/11bxnLv?=
 =?us-ascii?q?HK9SIEr57j0tx1tKXvkkQp+Dh1CdmN+3+CQnsynW4SQTIymqdlrh9T0FCGhJ?=
 =?us-ascii?q?NkjuRYGNob3PZAVgM3JNaI1OBhI8zjUQLGONGSQRCpRcvwUmJ5dc4439JbOx?=
 =?us-ascii?q?U1IN6llB2WmnPxUrI=3D?=
X-IPAS-Result: =?us-ascii?q?A2CHAABg6i5e/wHyM5BmHQEBAQkBEQUFAYFpBgELAYF8g?=
 =?us-ascii?q?RhVIBKEPokDhnwGgRIliW+PToF7CQEBAQEBAQEBASsMAQGEQAKCSDYHDgIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFNwyCOykBgnoBBSMVOgcQCxgCAiYCAlcTCAEBgmM/A?=
 =?us-ascii?q?YJWJQ+rNoEyhUqDNoE4BoEOKgGMN3mBB4E4DAOCXT6CZAKBPXOCQ4JeBJc0R?=
 =?us-ascii?q?pZodoJDgkyEdo5vBhuafJdElCoJKYFYKwgCGAghD4MoTxgNk3gXg1CKcSMDi?=
 =?us-ascii?q?3CCQgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Jan 2020 13:54:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00RDrRwU192395;
        Mon, 27 Jan 2020 08:53:29 -0500
Subject: Re: question about fs sid
To:     selinux@vger.kernel.org
References: <20200127125228.GA1998492@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Message-ID: <e09a265c-83ad-8422-a67b-24b265ab8381@tycho.nsa.gov>
Date:   Mon, 27 Jan 2020 08:55:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127125228.GA1998492@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/27/20 7:52 AM, Dominick Grift wrote:
> What is the fs sid used for exactly? What, if any, is its relationship with persistent file systems with xattr support.
> Were currently associating a type that is generally also associated with persistent filesystems that support xattr but i dont know why.
> Why would it not apply to other filesystems, for example tmpfs or vfat or whatever?
> 
> Is the fs sid still used and what do i need to consider when determining what context to associate with it?

Are you referring to the fs initial SID, or to the SID associated with 
each filesystem/superblock?

The former appears to be unused by any kernel code other than the 
declaration (grep -r SECINITSID_FS).  At one time, it was the default 
SID to use for the filesystem/superblock.  Looks like this has never 
been used in mainline Linux, just pre-mainline SELinux.  Sadly we cannot 
just remove obsolete initial SIDs until we fix 
https://github.com/SELinuxProject/selinux-kernel/issues/12

The latter is still relevant but the defaults are now determined through 
fs_use_* or genfscon statements, default to the unlabeled SID if there 
is no match, and can be overridden via the fscontext= mount option.  It 
is used in permission checks on the superblock/filesystem (e.g. mount, 
unmount, ...) and to limit what file contexts can be assigned to files 
within the filesystem (associate).
