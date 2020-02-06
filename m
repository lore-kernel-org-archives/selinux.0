Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB40C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 15:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC9E214AF
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 15:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hM5oLo4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgBFPpy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:45:54 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:22447 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgBFPpx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 10:45:53 -0500
X-EEMSG-check-017: 53449509|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="53449509"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 15:45:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581003952; x=1612539952;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mDZub8nnCsHitc2hxMNb7MT3aXJ5f8xXyLojiMK5NUw=;
  b=hM5oLo4A4swyOcSKiVXjeJcArjpA81ak2VTaLUAzojPDglaY0XLjN189
   iwZoja3GeLCDmHSeTdW1VIexi1c5wwsFC923/9bhRqcqtMVYOZsRF5m9j
   xQan23U6VgGkUy5NhF5kKX+hFnPMFzVTb1nFmg8hyM9U8//KhlZmtqxe1
   g1Gr0ZHL0zr7c8nfDBkeKNOuXcA7yJwQlqzvCwNGGlsqoCV67tWRyonwP
   9L1ZG6wzBLsYIs4kN/UbHseoqtTiabpxyE8G8m++1nOqQJbyMlZxLkWNA
   dnfuNmUvi0Y6anM78UC5vaxuv1lugDBVdtJHs9YpQuI16lqoOcSocOMhZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="38759739"
IronPort-PHdr: =?us-ascii?q?9a23=3A0E52rh9x5DrZmP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B30+4cTK2v8tzYMVDF4r011RmVBNmdtqkP1LWe8/i5HzBZutDZ6DFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sArcutMWjIZsJao8yB?=
 =?us-ascii?q?nEqWZMd+hK2G9kP12ekwvy68uq4JJv7yFcsO89+sBdVqn3Y742RqFCAjQ8NG?=
 =?us-ascii?q?A16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWT?=
 =?us-ascii?q?Sj9KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjcKzdZ9caTn?=
 =?us-ascii?q?dfUMhXWSJKH4ewY5IPAucFOOpVqZT2qVkTohukHQSiGf3hyjFIiHH106M13e?=
 =?us-ascii?q?suHgPa0wIvBN8OrHbZoc/pOKsOX+24zq/FxijDYfNM3jf97ZDFfA09of6SRb?=
 =?us-ascii?q?JwcdTeyU8yHA3Yi1Wfs4jlPzeL2eUNrmOW6PFgWv+0i2M8twFwoiSgxscrio?=
 =?us-ascii?q?XTgIIV0UrL+T92wIYyO921UUh2asOnHptIryyWKoR7T8w4T2xopSo20KMKtJ?=
 =?us-ascii?q?GlcCQQ1ZgqwQPUZeadfIiS+B3jUf6cITJ/hH14Zr2ynw2y8U28yu3kUcm0zU?=
 =?us-ascii?q?pKojJFktbSsnAN0ATe6tSdRftn/0ehxC2P2xrS6uFCL0A0krHbJIA9zbIqip?=
 =?us-ascii?q?oSsVjMHi/xmEnsiq+Zal4k9fSy5+TiY7XmooeQN45yig7gLqQjgtGzDOs3Pw?=
 =?us-ascii?q?QUX2WX5P6w2KPs8EHnWrlGk+U6kqzDv5DbIcQbqLS5AwhQ0os78BawEiym3c?=
 =?us-ascii?q?8EnXgHMF1FeBWHg5LvO1HVOv/0F/i/g1OykDtz3fDJIqXhAonRLnjEiLrhZq?=
 =?us-ascii?q?hy60pdyAo10NBe6IlZCq8OIP3tQE/9rt/YAQEjMwyy3ennDM9x1oQEWWKAUe?=
 =?us-ascii?q?elN/bJvFuJ4P8/C/eDaZVTuzvnLfUhofn0giwXg1gYKJK10IMXZXbwJfFvJ0?=
 =?us-ascii?q?GUcDK4mdsaOXsbtQo5CurxgRuNViAFNCX6ZL41+jxuUNHuNozEXI34xeHQ0Q?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AeAQBnNDxe/wHyM5BmHQEBAQkBEQUFAYFqBQELAYF8g?=
 =?us-ascii?q?WwhEiqEFYkDhmQBAQEGgTeJcJFLCQEBAQEBAQEBATcBAYRAAoJhNwYOAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspgwMBBSMVQRALGAICJgICVxMGAgEBgmM/glclr?=
 =?us-ascii?q?DGBMoVKg2mBPoEOKgGMPHmBB4E4D4JdPoUYgkOCXgSXPkaIMY82gkSCTopCi?=
 =?us-ascii?q?TAGG5sLrBUjgVgrCAIYCCEPgydQGA2OKRcVjiwjAzCOSgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Feb 2020 15:45:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016FixCE111542;
        Thu, 6 Feb 2020 10:44:59 -0500
Subject: Re: [PATCH v2] libsepol,checkpolicy: support omitting unused initial
 sid contexts
To:     selinux@vger.kernel.org
Cc:     jwcart2@tycho.nsa.gov
References: <20200129150104.50720-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <503fabdb-fe25-3bd2-dc4a-af0b4217bf72@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 10:46:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129150104.50720-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/29/20 10:01 AM, Stephen Smalley wrote:
> Remove restrictions in libsepol and checkpolicy that required all
> declared initial SIDs to be assigned a context.  With this patch,
> it is possible to build and load a policy that drops the sid <sidname>
> <context> declarations for the unused initial SIDs.  It is still
> required to retain the sid <sidname> declarations (in the flask
> definitions) in order to preserve the initial SID ordering/values.
> The unused initial SIDs can be renamed, e.g. to add an unused_
> prefix or similar, if desired, since the names used in the policy
> are not stored in the kernel binary policy.
> 
> In CIL policies, the (sid ...) and (sidorder (...)) statements
> must be left intact for compatibility but the (sidcontext ...)
> statements for the unused initial SIDs can be omitted after this change.
> 
> With current kernels, if one removes an unused initial SID context
> from policy, builds policy with this change applied and loads the
> policy into the kernel, cat /sys/fs/selinux/initial_contexts/<sidname>
> will show the unlabeled context.  With the kernel patch to remove unused
> initial SIDs, the /sys/fs/selinux/initial_contexts/<sidname>
> file will not be created for unused initial SIDs in the first place.
> 
> NB If an unused initial SID was assigned a context different from
> the unlabeled context in existing policy, then it is not safe to
> remove that initial SID context from policy and reload policy on
> the running kernel that was booted with the original policy.  This
> is because that kernel may have assigned that SID to various kernel
> objects already and those objects will then be treated as having
> the unlabeled context after the removal.  In refpolicy, examples
> of such initial SIDs are the "fs" SID and the "sysctl" SID.  Even
> though these initial SIDs are not directly used (in code) by the current
> kernel, their contexts are being applied to filesystems and sysctl files by
> policy and therefore the SIDs are being assigned to objects.
> 
> NB The "sysctl" SID was in use by the kernel up until
> commit 8e6c96935fcc1ed3dbebc96fddfef3f2f2395afc ("security/selinux:
> fix /proc/sys/ labeling) circa v2.6.39.  Removing its context from
> policy will cause sysctl(2) or /proc/sys accesses to end up
> performing permission checks against the unlabeled context and
> likely encounter denials for kernels < 2.6.39.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---

This is now applied.

[...]
