Return-Path: <SRS0=MPXq=TJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B025C04AB1
	for <selinux@archiver.kernel.org>; Thu,  9 May 2019 21:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BD521744
	for <selinux@archiver.kernel.org>; Thu,  9 May 2019 21:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Jpb6DoyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEIVRN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 May 2019 17:17:13 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:52140 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfEIVRN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 May 2019 17:17:13 -0400
X-EEMSG-check-017: 16017516|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 May 2019 21:17:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1557436624; x=1588972624;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=I+h/xO3uFilGofibDry2/v8IZJ8M9rN+uA5XXRiUqEo=;
  b=Jpb6DoyBe1H/DQ+d2gZpWjWboGnRbde6znwg+sjdqHDHinmYzadLChIG
   nBVda9d0Ti1Gx3t2MaQW27NzEDSMS4toeSf5cvMoGuBOMfsD0JfaJjdol
   z/Ky3j/9+yK1a1DKY6VS1JFo9dXMXXb6qB+ZKrOh0yVsl86ai9k4x6HdT
   3SJyKAmNhqeCeR3Gy1HxcH/lTZnIF6O/Uuz/LxKLl+/2+CY6MYv2oNnRT
   yaIUzGNV5Dhi6qmqypn52cGPzJZ1sqGDvu6twCOYoWXPbcGaOZbqXoCuf
   u0VoA5QzhgE+/2O/AS73Bbqf31MPZS5ADfC7v47Ww08CpjwMfgun2JIw5
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,450,1549929600"; 
   d="scan'208";a="27362918"
IronPort-PHdr: =?us-ascii?q?9a23=3A9iMOZRDYCPBjyiDFeHl2UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37ocSwAkXT6L1XgUPTWs2DsrQY0rOQ4/6rCDJIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK5+IA+1oAjQucUbhYpvIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQG?=
 =?us-ascii?q?ZMWMheVzZFAoihcYUBCeQPNvtco4Xkp1YDqR6yCA+xD+3t1zBInGf707Ak3e?=
 =?us-ascii?q?QvEQ/I3wIuENwBv3vWsNr7O7wfUfy3waTS0TnPc/1b1DX75YPVch4hu/aMXb?=
 =?us-ascii?q?dofMTM1UkgCRvFjlWOpozjIjiby+ENvHKf7+pkS+2ui3MspgZqojey3cchkZ?=
 =?us-ascii?q?XJh4IJxVDE8iV12oA1JcaiR0Jhbt6kF4VQujicOoBrQc0iW3lltDs1x7AJo5?=
 =?us-ascii?q?K2fDUGxI45yxPQdfCLaZWE7xT+X+iLOzh4nmhqeLeniha39kiv1/PzW9Gv0F?=
 =?us-ascii?q?ZPsipFit7Mtm0R1xDL6siIVP99/kC51DaTzQ/T8OBEIV0vlabBN54gwqI/lp?=
 =?us-ascii?q?oUsUjZGC/5hF72g7OMekUh++io7/zrYrTgppCCK495khzyP6shl8ClAek0Lx?=
 =?us-ascii?q?ICU3aU9OiizrHv4FX1QLBQgf03lqnZvoraJcMepqOhGA9az50j5g2jDzamzN?=
 =?us-ascii?q?sYnX4HIEhDeBKclYflIV7OIPfmDfunmVSjjC9rx+zaPr3mGpjNLGbMkLnvfb?=
 =?us-ascii?q?Zj8ENcxw0zzddQ55JQFL4NOu78Wkj0tNbAFB82LxS0w/r7CNV6zo4eQnyAAq?=
 =?us-ascii?q?uYMKPUrF+J6fkiI/eDZIALojbxMfsl6OD0jX8/h1AdebOl3ZwNaHC3Bv5mOV?=
 =?us-ascii?q?mWYWLwgtcdFmcHpgg+TOPwh12GTzFTYW2yX6U65jwgB4KmCoDDRo+pgLOfxi?=
 =?us-ascii?q?u0AppWZmVeAFCWDXjob5mEW+sLaC+KOs9hliYLVaW9S487zh6hrhT3y6B5Ie?=
 =?us-ascii?q?XJ+i0Xr47j2MJp6O3UkBFhvQBzWuaQ3W+XQnA8oGoOSzIslJtjpkFlggOB3K?=
 =?us-ascii?q?Z2ndRXEttc4/4PWQA/Y9qU1OF+CtbvSirfcdqTDlWrWNOrBXc2VN11i/0Jbk?=
 =?us-ascii?q?I1NNymgxbY2CziV70anriGAocz9IrT2H/+I8s7wHHDgu1pt1Q6WINrPHC6nK?=
 =?us-ascii?q?R2/AibU5bNmliFjayjXb4R0C7E6CGIym/Y729CVwslarnIRXASYAPtqN394k?=
 =?us-ascii?q?7TB+u1Ba8PLhpKycnELLBDLNLukwMVF7/YJN3CbjfpyC+LDhGSy+bJNde7dg?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DMDgA1mNRc/wHyM5BkHAEBAQQBAQcEAQGBZQKBZSqBO?=
 =?us-ascii?q?jOEOZNdAQEBAQEBBoE1iU2RAQkBAQEBAQEBAQE0AQIBAYRAAoIIIzgTAQMBA?=
 =?us-ascii?q?QEEAQEBAQMBAWwoQhYBgWEpAYJnAQUjFVELGAICJgICVwYBDAgBAYJfP4F3F?=
 =?us-ascii?q?K1IgS+FR4MlgUaBCycBi04XeIEHgTiCaz6HToI2IgSTFJQxCYILggaQSAYbl?=
 =?us-ascii?q?VmMJZcFIYFXKwgCGAghD4MoghoXjjsjA4E2AQGIeoV9AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 09 May 2019 21:17:03 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x49LH1UH024116;
        Thu, 9 May 2019 17:17:03 -0400
Subject: Re: Mislabeled /proc/<pid>/ns/mnt files?
To:     Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org,
        Joel Galenson <jgalenson@google.com>,
        Petr Lautrbach <plautrba@redhat.com>
References: <CABXk95D-4v2aT=sZk9NoeGJBGTy=7NTQ8+yKv5E4RvaODJgWLA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fdcf1946-2151-4502-9755-3a10d0646399@tycho.nsa.gov>
Date:   Thu, 9 May 2019 17:11:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABXk95D-4v2aT=sZk9NoeGJBGTy=7NTQ8+yKv5E4RvaODJgWLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/9/19 3:56 PM, Jeffrey Vander Stoep wrote:
> I expected files here would have the process's context, but they
> don't. The files are actually all symlinks so it's entirely possible
> that the they shouldn't have the process's context. If that's the
> case, how can I provide different labels for them? Neither "proc" nor
> "unlabeled" are appropriate.
> 
> On a device with a 3.18 kernel they have the "proc" context:
> sailfish:/ # ls -LZ1 /proc/1/ns
> u:object_r:proc:s0 mnt
> u:object_r:proc:s0 net
> 
> On a device with the 4.9 kernel the have the "unlabeled" context:
> blueline:/ # ls -LZ1 /proc/1/ns
> u:object_r:unlabeled:s0 cgroup
> u:object_r:unlabeled:s0 mnt
> u:object_r:unlabeled:s0 net

First, ls -L dereferences symlinks so you are going to get the context 
of the object referenced by the symlink, not the context of the symlink 
itself.

Second, the task context is only assigned to proc inodes created via 
proc_pid_make_inode(), which has never been the case of /proc/pid/ns 
inodes - those have their own implementations and operations.

Third, /proc/pid/ns migrated from proc to its own pseudo filesystem, 
nsfs, which requires a corresponding fs_use or genfscon rule in policy 
or they will be unlabeled.  refpolicy has a genfscon rule. Confusingly 
there appears to be both in Fedora policy, a fs_use_task and a genfscon 
rule, and it appears that fs_use_task is being applied here.  I don't 
know why or what exactly that means.  It won't be the task context for 
the task associated with that /proc/pid directory but instead would be 
whichever task context instantiates the inode.

