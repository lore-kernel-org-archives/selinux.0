Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCDDC2D0DB
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 15:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC2E20716
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 15:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="aWTrOx0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgA2POa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:14:30 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:5522 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgA2POa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 10:14:30 -0500
X-EEMSG-check-017: 51273549|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="51273549"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Jan 2020 15:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580310865; x=1611846865;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qN3M1ROQgsH33CGL/7iONVLW2dtNa9EGYUpkE7u7CAI=;
  b=aWTrOx0T5mdUd8wMBDfoQdFkeDzjxIKCY5tBOdp7+fS8LVYNTOW5odRl
   9dMmHChzKiHuz9T3vCaX2hGh5snqyfzBQHR6OPeyHeOkEwgL/2VElrYKY
   IihzgCWRqgTH1ybfzV05/MxggQy1aRD0lVzK36qPztS5/WO/Kq+lrD3MB
   Uhnn90V2isVcdT59KXwZCgeVxzEhnP/6YD7h8qngH9BY+9ypdULENKbof
   HHMaJ4nQcDsOoVB7+Cr6W7ZAKN87P4GKV5u1twSr2bU5ZSUVGleA/NuU1
   OOQptBwFo8MoS1wfifNkV6RIYaW22XytJ9nAQtERJuA076DiAlGtNUsS1
   w==;
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="32453826"
IronPort-PHdr: =?us-ascii?q?9a23=3AxCQ3XBElzgK3GIJpWX2X251GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zp8iwAkXT6L1XgUPTWs2DsrQY0raQ6P6rBjVIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrw/xx?=
 =?us-ascii?q?bIrXdFeflazn5sKV6Pghrw/Mi98INt/ihKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHS2?=
 =?us-ascii?q?VBRMJRXDFfDI26YYUEEu4NMf9YooT5olcDqwa1CwuxC+P10jJGm2H43aM63e?=
 =?us-ascii?q?oiHw/J0gMvENASv3rbt9j1KKUfXPqpwKXUwzjObfVb0ir95ojSdRAhpOmBU6?=
 =?us-ascii?q?9sccXP0UkvFx3KjlONooL4OjOazOANs2yF4OtgSOmijHUnpBxqojW02sctip?=
 =?us-ascii?q?XGhoISylze8yV525w6Kce3SE58f96pCZ1dvDyZOYtuWs4uXm5ltSkgxrAGpJ?=
 =?us-ascii?q?K3ZjYGxZs5yxLFdvCKdZWD7Aj5W+aLOzh4gWpoeLe4hxmv70et0vb8Vsyo0F?=
 =?us-ascii?q?ZSqSpFj8XMumgN1xPN7siHTeNw/lu71jaV1gDT9/pELVo1lardJZ4hxaUwmY?=
 =?us-ascii?q?QPvkjZAi/3mFn5jK+Rdkk+/Oin9//nban8qp+ZNo90jhnyMqUomsOhHeQ1Kh?=
 =?us-ascii?q?UCUmeU9Oim1LDv4Ff1TKtFg/EoiKXVrYjWJcEBqa64Bw9V3Jwj6xG6Dzq+y9?=
 =?us-ascii?q?QXgGIHIUlZeBOHk4fpO1bOLOr+DfekmVugijhrx/fYPrH5GJXCMmDDkKv9fb?=
 =?us-ascii?q?Z680Nc0xQ8zdRe55JSF7EAL+n+WlH+tNPGFB81KQ+0zPj9CNV7yIweXXiDAq?=
 =?us-ascii?q?iDMKPd4he04bc0Lu2NYpIFkCjyJuJj5PP0i3I931gHcvqHx5wSPUukE+xmLk?=
 =?us-ascii?q?PRWn/lhtMMAC9epQYlZPD7g12FFzhIbjC9WLxqtWJzM56vEYqWHtPlu7eGxi?=
 =?us-ascii?q?ruW8AHaw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ARBADSnzFe/wHyM5BmHQEBAQkBEQUFAYF7gX2BbAEgE?=
 =?us-ascii?q?iqEFIkDhlsGgTeJb5FJCQEBAQEBAQEBATcBAYRAAoJOOBMCEAEBAQQBAQEBA?=
 =?us-ascii?q?QUDAQFshUOCOymCewEFIxVBEAsYAgImAgJXEwYCAQGCYz+CVyWtG4EyhUqDK?=
 =?us-ascii?q?YE+gQ4qjDp5gQeBOA+CXT6HWYJeBJc0RpdegkOCTIo6iSsGG5p/q34igVgrC?=
 =?us-ascii?q?AIYCCEPgydQGA2OKRcVjiwjAzCMBi2CFAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 29 Jan 2020 15:14:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00TFDeNL092737;
        Wed, 29 Jan 2020 10:13:40 -0500
Subject: Re: [PATCH v2] libsepol,checkpolicy: support omitting unused initial
 sid contexts
To:     selinux@vger.kernel.org
Cc:     jwcart2@tycho.nsa.gov
References: <20200129150104.50720-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a8edd6f8-e783-6f66-7b39-99ff91b447a5@tycho.nsa.gov>
Date:   Wed, 29 Jan 2020 10:15:23 -0500
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
> v2 issues informational messages about missing initial SID contexts
> so that policy developers can detect unintended inconsistencies,
> and ensures that the entries are stripped before writing kernel policy
> rather than accepting them when reading.  Something isn't quite right
> here though; I see the messages when compiling monolithic policy with
> checkpolicy but not with a modular build (even upon make validate) or
> semodule -v -i of a modified base module that removes some initial
> SID contexts.

Never mind.  For modular build I was getting the messages while 
compiling the base module (just missed it in the output) and for 
semodule I needed to turn up verbosity sufficiently to get informational 
messages out of cil.  So it works as expected AFAICT.
