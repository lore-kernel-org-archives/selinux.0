Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EE6C2D0DB
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 20:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579B32173E
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 20:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="m0GEya52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgA1UmV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:42:21 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:31306 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgA1UmV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jan 2020 15:42:21 -0500
X-EEMSG-check-017: 50841256|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,375,1574121600"; 
   d="scan'208";a="50841256"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Jan 2020 20:41:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580244113; x=1611780113;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=YXEhh2sfUm8YvRGw9s8WM4mjzIy5kgq9JlHBX06ExkM=;
  b=m0GEya52Z8nqeak73j99o/PEz02FCLgXRxFOE8dxKBkKXoCuJ4ziQhcK
   NzY9HI+pVBFkONUah9uO5eVPh3i3MhM0WBX86xK3p6qwjhdzbB2vcXmek
   kA6WoO5A8kln37eWmJduyGuSZ0uAZJM5XqK9SAynAbsC8ZHFLO+go0Wit
   NftLpyFq23T2q3gar9+lOqkt4NAmp0dPnUaSOarZcahRQty49bv/9DjX9
   UK9J+S/iipualjJd1yyw/O3TjeUVf5VUbaIrfjO3mYgfCw2vfPBR+iRYt
   TTGksdLxuaeS8fF77HUvzv2hnJOP1ZLw0CfwvY9J/37c7ML+/RGZvKq3w
   w==;
X-IronPort-AV: E=Sophos;i="5.70,375,1574121600"; 
   d="scan'208";a="38370400"
IronPort-PHdr: =?us-ascii?q?9a23=3AbQFoWBSalc6xGObounIhGewQAdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yYBSN2/xhgRfzUJnB7Loc0qyK6vymAjBLuM3a+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTrHZFdOtayX5mKF+dgh3w4tu88IN5/ylfpv4s+dRMXbnmc6g9ULdVECkoP2?=
 =?us-ascii?q?cp6cPxqBLNVxGP5nwSUmUXlhpHHQ3I5wzkU5nyryX3qPNz1DGVMsPqQ780Xy?=
 =?us-ascii?q?+i77pwRx/zlCgHLT85/3rJhcF2kalWvQiupx17w47TfYGVKP9zdb7TcN8GWW?=
 =?us-ascii?q?ZMWNtaWCJbAoO4coABEewPM+hFpIX5vlcDrR+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTL1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsQHlotT4nxrAJtp?=
 =?us-ascii?q?O3ZigHxIk9yxLBZPGLbZKE7g/lWe2MOzl3nmhld6i6hxuq9EigzfDzWdes3V?=
 =?us-ascii?q?ZRqypFjsHMtncQ1xzP8sSHSuVy/kOm2TuXywDc8PtEIUEplarAMZIhw7gwlp?=
 =?us-ascii?q?QUsUTYACD5hF/6jLOWd0o4+uio7P7rYrP6qZ+HK4B4kAT+MqUqmsCnAOQ4NB?=
 =?us-ascii?q?YBX3SD9Oih27Du8lf1TbVXgvEsjKXUv47WKd4GqqKhBg9ayIcj6xKxDze819?=
 =?us-ascii?q?QYmGEKLElYdxKclIXpJ1HPL+z4Dfe4mVislixryOrcMr3uBZXNMGDPkK39cr?=
 =?us-ascii?q?Zl905c1A0zwMhE551KDrEBIfTzWlL+tdHDEB85PBK7w/z9BNV+yIweQ2SPDb?=
 =?us-ascii?q?GdMK/Itl+I/O0vcKGwY9oXpz30MeR/r6rsknQwg0NHVbW41psQLnajF7JpJF?=
 =?us-ascii?q?vPJTL3j9MAF3oalhQxQfasi1CYVzNXIXGoUPES/DY+Xbm6AJ/DS4blu7mI2C?=
 =?us-ascii?q?O2D9UCfWxdIkydGnfvMYOfUrEDbzzEcZwpqSANSbX0E9xp7hqprgKvjuc2Iw?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AFAwB4mzBe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YINEhYUhBSJA4g7iW+RSQkBAQEBAQEBAQE3AQGEQAKCSjgTAhABAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIVDgjspgnoBAQEBAgEjDwEFRgsLGAICJgICVwYBDAYCAQGCYz8rA?=
 =?us-ascii?q?YIrBSCtLHWBMoVKgzqBPoEOKow4ggCBOA+CKDU+h1mCXgSXepdegkOCTIo6i?=
 =?us-ascii?q?SsGG5p8jmCdHiKBWCsIAhgIIQ87gmxQGA2OKReOQSMDMI40AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Jan 2020 20:41:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00SKf5rA042391;
        Tue, 28 Jan 2020 15:41:07 -0500
Subject: Re: [PATCH] libsepol, checkpolicy: support omitting unused initial
 sid contexts
To:     jwcart2 <jwcart2@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20200128172600.12896-1-sds@tycho.nsa.gov>
 <ae10e60a-7a9d-b954-5bf5-23577a5feadc@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0fb1e3d4-eeb2-8f01-1c2f-09f8e0ad3f05@tycho.nsa.gov>
Date:   Tue, 28 Jan 2020 15:42:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ae10e60a-7a9d-b954-5bf5-23577a5feadc@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/28/20 2:45 PM, jwcart2 wrote:
> On 1/28/20 12:26 PM, Stephen Smalley wrote:
>> Remove restrictions in libsepol and checkpolicy that required all
>> declared initial SIDs to be assigned a context.  With this patch,
>> it is possible to build and load a policy that drops the sid <sidname>
>> <context> declarations for the unused initial SIDs.  It is still
>> required to retain the sid <sidname> declarations (in the flask
>> definitions) in order to preserve the initial SID ordering/values.
>> The unused initial SIDs can be renamed, e.g. to add an unused_
>> prefix or similar, if desired, since the names used in the policy
>> are not stored in the kernel binary policy.
>>
>> In CIL policies, the (sid ...) and (sidorder (...)) statements
>> must be left intact for compatibility but the (sidcontext ...)
>> statements for the unused initial SIDs can be omitted after this change.
>>
>> With current kernels, if one removes an unused initial SID context
>> from policy, builds policy with this change applied and loads the
>> policy into the kernel, cat /sys/fs/selinux/initial_contexts/<sidname>
>> will show the unlabeled context.  With the kernel patch to remove unused
>> initial SIDs, the /sys/fs/selinux/initial_contexts/<sidname>
>> file will not be created for unused initial SIDs in the first place.
>>
>> NB If an unused initial SID was assigned a context different from
>> the unlabeled context in existing policy, then it is not safe to
>> remove that initial SID context from policy and reload policy on
>> the running kernel that was booted with the original policy.  This
>> is because that kernel may have assigned that SID to various kernel
>> objects already and those objects will then be treated as having
>> the unlabeled context after the removal.  In refpolicy, examples
>> of such initial SIDs are the "fs" SID and the "sysctl" SID.  Even
>> though these initial SIDs are not directly used (in code) by the current
>> kernel, their contexts are being applied to filesystems and sysctl 
>> files by
>> policy and therefore the SIDs are being assigned to objects.
>>
>> NB The "sysctl" SID was in use by the kernel up until
>> commit 8e6c96935fcc1ed3dbebc96fddfef3f2f2395afc ("security/selinux:
>> fix /proc/sys/ labeling) circa v2.6.39.  Removing its context from
>> policy will break kernels < 2.6.39.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---

[...]

> I see that you don't do anything with ocontext_read_xen(), so Xen 
> policies still require initial sid contexts? If so, doesn't that mean 
> that CIL behavior needs to depend on whether or not a Xen policy is 
> being created?

On second thought, I don't think I need to change 
ocontext_read_selinux() or the kernel to accept/ignore these entries.  I 
just need to make sure that they are not included in the generated 
policy file in the first place.  It was already possible that the 
OCON_ISID list might not include every initial SID.  So I don't think it 
will need to be target-specific.
