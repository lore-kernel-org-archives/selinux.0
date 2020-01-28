Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D2DC2D0DB
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 18:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D527214AF
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 18:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="h+gnh2Q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgA1SMy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:12:54 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:65334 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgA1SMy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jan 2020 13:12:54 -0500
X-EEMSG-check-017: 49971697|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,374,1574121600"; 
   d="scan'208";a="49971697"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Jan 2020 18:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580235167; x=1611771167;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=enTIGEaq3runzAZ6QdCHIBXTfggn33Kj6gRBj51EjBk=;
  b=h+gnh2Q+qUSCaVCHGJJPWIdstHmVL1OH/v5POKTGbMhb+Nm0xaY52cEm
   Bi0eLHNrpyTZCAImmVKQKYf2E50bIhZCL5PkyoGorNyWjB0q9+wVrUj4e
   vqDT6vkgKV1NsoH0vRhlR4JkwsFAsxCKVTVQQj1HS2iNTTeipx0otFm05
   5hlfYik8F71oJnKO6+YeDDWs+l8NlkvuBFfIAMLxPNnBeNl7YhaYFEfOD
   3FN6W0MioJIfSnUu0ljU5069brXq9Z2dxsn9adFblXYs3PEYYH77v1ou3
   UsRR/Ch1hnTa6wW1N92fgi/OoJuaB8ABU7WEjAM3Q0ov1YE3XTb/zMxOb
   A==;
X-IronPort-AV: E=Sophos;i="5.70,374,1574121600"; 
   d="scan'208";a="38359333"
IronPort-PHdr: =?us-ascii?q?9a23=3AoQ4cNhXZXLJrSfMyLBbqctbJyN3V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRCOt8tkgFKBZ4jH8fUM07OQ7/m8Hzdcqs/Z6jhCKMUKC0?=
 =?us-ascii?q?Zez51O3kQJO42sMQXDNvnkbig3ToxpdWRO2DWFC3VTA9v0fFbIo3e/vnY4Ex?=
 =?us-ascii?q?T7MhdpdKyuQtaBx8u42Pqv9JLNfg5GmCSyYa9oLBWxsA7dqtQajZFtJ6osxR?=
 =?us-ascii?q?bFuHVFdutZyW91OV6fgQv36sOs8JJ+6ShdtO8t+sBaXanmY6g0SKFTASg7PW?=
 =?us-ascii?q?wy+MDlrwTIQxGV5nsbXGUWkx5IDBbA4RrnQJr/sTb0u/Rk1iWCMsL4Ub47WT?=
 =?us-ascii?q?K576d2UxDokzsINyQ48G7MlMN9ir9QrQ+7qBx+x47UZ5yVNOZ7c6jAc94WWX?=
 =?us-ascii?q?ZNU8BMXCNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTW9vuCY/0LIGuJ?=
 =?us-ascii?q?i7cTAFyJQm2x7fa+GHfJOS7h3/U+aRJDF1j29mdrKnnxu+7Eetx+LmWsS0zV?=
 =?us-ascii?q?pGtDRJn9bSunwXyhDe7NWMROFn8Ue7wzmP0hje6uRDIU8pi6XWM4Uhwrsslp?=
 =?us-ascii?q?oLtkTDAzP2lF32jKCIckUk/fCl6/j9bbX8p5+cKpR0hhv/MqQolMy/Bv84PR?=
 =?us-ascii?q?YSUGSB5eS91KHs/U3+QLlQiP05jrLZv4zAKcQep665BxdZ0ocl6xmhEzeryM?=
 =?us-ascii?q?kUkHYIIV5feB+LkpLlN0/BLfzmF/uznkygkDJxyPDHOr3hDI/NLn/GkLr5Zr?=
 =?us-ascii?q?Zy9lVcxREvzdFf+51UCrYBLOj1Wk/qrtPUFBA5Mwuqw+r/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7SqUWH5v8rI+SXfI8aoiv9K/w86/7rin85nkUdcrez0ZQLb3C4G+xsI1?=
 =?us-ascii?q?+Fbnr0ntcBDWAKsxIlTOP0jF2CUDhTZ2u9Xq8n+DE7B5ypDZ3ZSoCunrOBxi?=
 =?us-ascii?q?G7EYNSZmxcDVCMC3jofZ2eW/gQcCKSPtNhkjscWLimTo8h0gqutAngxLV7MO?=
 =?us-ascii?q?XZ4TcYuoz+29h1/eLTiQs++iBzD8SYgCmxSDRsl34Mbyc/waQ6pEt60FrF2q?=
 =?us-ascii?q?990NJCEtkG3O9ESgc3M9bnyuV+D93jElbacsyhVEetQtLgByo4CN023YldMA?=
 =?us-ascii?q?5GB9y+g0WbjGKRCLgPmunOX805?=
X-IPAS-Result: =?us-ascii?q?A2DVAAAYeDBe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gRhUIRIqhBSJA4Z7AwaBEiWJb5FJCQEBAQEBAQEBASsMAQGEQAKCS?=
 =?us-ascii?q?jcGDgIQAQEBBAEBAQEBBQMBAWyFNwyCOymCewEFIxVBEAsYAgImAgJXEwYCA?=
 =?us-ascii?q?QGCYz8BglYlD64lgTKFSoNCgTgGgQ4qAYw3eYEHgREnDAOCXT6CZAKCMIJDg?=
 =?us-ascii?q?l4EjVgEiHdhRpdegkOCTIR2jm8GG4JImDSQKocalDkjgVgrCAIYCCEPgydQG?=
 =?us-ascii?q?A2OKReDUIpxIwMwjjABAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Jan 2020 18:12:44 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00SIBtx6229598;
        Tue, 28 Jan 2020 13:11:56 -0500
Subject: Re: [PATCH] selinux: remove unused initial SIDs and improve handling
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
References: <20200127205507.3317-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <22a8f384-6799-5e61-df30-0dd3b251d0c3@tycho.nsa.gov>
Date:   Tue, 28 Jan 2020 13:13:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127205507.3317-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/27/20 3:55 PM, Stephen Smalley wrote:
> Remove initial SIDs that have never been used or are no longer
> used by the kernel from its string table, which is also used
> to generate the SECINITSID_* symbols referenced in code.
> Update the code to gracefully handle the fact that these can
> now be NULL. Stop treating it as an error if a policy defines
> additional initial SIDs unknown to the kernel, or if the policy
> leaves one of the unused initial SIDs without a defined context.
> Fix the incorrect usage of the name from the ocontext in error
> messages when loading initial SIDs since these are not presently
> written to the kernel policy and are therefore always NULL.
> 
> This is a first step toward enabling future evolution of
> initial SIDs. Further changes are required to both userspace
> and the kernel to fully address
> https://github.com/SELinuxProject/selinux-kernel/issues/12
> but this takes a small step toward that end.  NB Even with
> this change, one cannot yet add or remove initial SIDs in
> policy without breakage; separate changes to the policy
> compiler are still necessary.  Further, fully decoupling
> the policy and kernel initial SID values will require a policy
> format/version change to include the SID names in the
> kernel policy so that they can be dynamically mapped at
> policy load.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Review welcome but do not merge (should have marked it RFC); I have a v2 
in progress.

> ---
>   scripts/selinux/genheaders/genheaders.c       | 11 +++-
>   .../selinux/include/initial_sid_to_string.h   | 57 +++++++++----------
>   security/selinux/selinuxfs.c                  |  6 +-
>   security/selinux/ss/policydb.c                | 28 ++++++---
>   security/selinux/ss/services.c                | 26 ++++-----
>   5 files changed, 73 insertions(+), 55 deletions(-)

[...]
