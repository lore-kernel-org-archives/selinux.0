Return-Path: <SRS0=onaf=UD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD7CC282CE
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 12:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8683C23E30
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 12:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="JOBbr+/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfFDM34 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:29:56 -0400
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:51515 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfFDM3z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Jun 2019 08:29:55 -0400
X-EEMSG-check-017: 712036393|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="712036393"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Jun 2019 12:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559651393; x=1591187393;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SnU/HVzMq8G1abbNaLmpYOfLUQ1A6yhNdlDDCbr+iLc=;
  b=JOBbr+/aJMAkwARYFV/cksYT7kOq5TOGWIcxKmOaxRlqJOy0oXpRyx8M
   bgC5KQ2lizQ65OA7Pg/+emXi4aiGMc+0sm1CtmnieO/XJejfFk29sxdxf
   Bmz9wyNvTYHilQP8aZ4xqe7d/34Zx/QsPJuAyVEI947gnojUCjfTrQ0J+
   wZL3C9K+jINpUgQ+Wg5t1JPn/98iXBP+1mgp314MAHWirY5CWvT6wADQD
   ddvO4acpELP+20RCR97QMh5Qm3IQDyW5z8VmWm2mVTQdUICjUvZgbpCzU
   lO4WcLz4SsZWJHlmgPakKH4TKRKNkvcbSlfdh0JJs81bm48Gy2Vwqwbee
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="24367092"
IronPort-PHdr: =?us-ascii?q?9a23=3AJ096RxEK+rAeY9cmKPwgtZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76o8W5bnLW6fgltlLVR4KTs6sC17OP9fm7CCddud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMRm6txjdu8cSjIdtKqs91g?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9mvyY6z6cJuZ?=
 =?us-ascii?q?+9fCUSx5QnxgLfa/yac4eT+B7sSOGRITJ+iXl4e7y/nw6//VWvx+DzTMW50E?=
 =?us-ascii?q?tGojBbntTDqHwBzQHf586aQfVn5EihwyyA1wXL5+FBJkA7iLTUJoY6wr41ip?=
 =?us-ascii?q?oTqUPDHjLqmEnujK+ZaEEk+u+w5uT7eLrmvJ6cN5Jvig3kLqQvmtCwAeQ/Mg?=
 =?us-ascii?q?QUWWiU5f+826H58U38QbVKiuU6kqjfsJ/EOcQWvrO1DgBa34o56xuzEi2q3M?=
 =?us-ascii?q?oXkHUZNl5JZQqLj43zNFHPJPD4A+2/g1OpkDpz3PDJI6bhD47RLnnDjLjhfb?=
 =?us-ascii?q?F951RayAoo199T/Z1UCrYfIP7rQE/+qMTYDgMlMwyz2+voFM9y1pgAVmOPGa?=
 =?us-ascii?q?KZK7/dsV+S6eIyLemMYJEauCzkJ/c5/fHil2M2mVgYfaOxx5sYdGi4Huh6I0?=
 =?us-ascii?q?WeeXfjns0OEXwUsQs+VuDqk0GNUT5JaHavUaI84i80CJi9AIfCQICtnKKO3C?=
 =?us-ascii?q?OhEpJKYWBGD0iGEW30eIWcR/cMdCWSL9djkjwBUrihUZUh1RC1tALhzbpoNO?=
 =?us-ascii?q?/U9TMZtZ7509h1/eLTnwko9TNoF8Sdz32NT2Zsk2MMRj822r1/oENkxleYz6?=
 =?us-ascii?q?d3n+FYFcZS5/NVUgY2LJvcz+tnBNDvXgLOYMyESEipQtq4GzE9VNExzMEUY0?=
 =?us-ascii?q?Z7BdqiigrP3y2wA78aj7aLHoA78rrA33jtIMZw023G27clj1knRMtPKGKni7?=
 =?us-ascii?q?Vh9wjcGYHJiV+Vl6W0eqQG2i7C6mODwXCJvEFCXw56Sb/FUmwHZkvKsdT54V?=
 =?us-ascii?q?vPT7ywBrs5KQtO1cmCKqxJatDykVpGRO3jONPbY2KwhmewAAyExrSWbIrlY2?=
 =?us-ascii?q?8dxjnSCFAYkwAP+naLLQo+BiCho2LYFjBuF1XvY0P2/ul4s3O0UEk0whqWYE?=
 =?us-ascii?q?J70bq1/RgVhf2ARPwJ2rIIojsuqzJxHFylxdLZF8KApxZ9fKVbed49+ElI1W?=
 =?us-ascii?q?TWtwxgP5ygKbluhl0AfARtuUPhyRF3B55BkcQzqHMqyxRyJryC3FNabTyY3o?=
 =?us-ascii?q?3wOqfNJWXo+hCgdbTa2lPG0NyO4KcA9Ow4q0n/vAGuDkci629o08RR03aH/p?=
 =?us-ascii?q?XFFhcSUZboXkYy8Bh6oKvabTcn64zI0n1sNPr8jjiX8NsyCfpt8R2gdspRNK?=
 =?us-ascii?q?6eXFv5GtYXFuC1I+wjhlatYwhBN+kU/6kxaYfufPKd1b/tJ+1glS+oiWldyI?=
 =?us-ascii?q?F7zk+IsSF7T6qA3ZMC2euZxSOBXjLxjRGmqM+z0YRFYywCW3GywjX+BZJAI6?=
 =?us-ascii?q?h1cZsPBE+wLMCtgNZznZjgXzhf7lHnT0gL3M6vZAq6cVPwx0tT2F4RrHjhnj?=
 =?us-ascii?q?G3nBJulDR8lbaSxCzDxazZcRMDPmNaDD15gUzEPZm/j9dcWlOhKQcuik32tg?=
 =?us-ascii?q?7B26FHqfEnfCHoSkBScn2zdjozXw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BqBAB6Y/Zc/wHyM5BmHAEBAQQBAQcEAQGBZYFnKmpSM?=
 =?us-ascii?q?iiEFJNUAQEBAQEBBoEICCWJUJEICQEBAQEBAQEBASsJAQIBAYRAAoJSIzgTA?=
 =?us-ascii?q?QMBAQEEAQEBAQMBAWwcDII6KQGCZgEBAQECASMVQQULCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/AYF2BQ8Ppz+BMYVHgy2BQAaBDCiLWhd4gQeBOAyCXz6CYQIChGmCW?=
 =?us-ascii?q?ASLTgOHUlSVDgmCEIIZhCiET4ggBhuCI4Z1hAKJXY0Khw6RJCGBWCsIAhgII?=
 =?us-ascii?q?Q+DJ4IbF4NNim8jAzABgQUBAZBKAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Jun 2019 12:29:52 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x54CToTs032668;
        Tue, 4 Jun 2019 08:29:51 -0400
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190602165101.25079-1-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f71388e9-a4c5-8935-137b-8eb50be7f833@tycho.nsa.gov>
Date:   Tue, 4 Jun 2019 08:29:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/2/19 12:50 PM, Casey Schaufler wrote:
> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.

Please explain the motivation - why do we want to allow AppArmor to 
stack with other modules, who would use it, how would it be used, what 
does it provide that isn't already possible in the absence of it. Also, 
Ubuntu fully upstreamed all of their changes to AppArmor, would this 
still suffice to enable stacking of AppArmor or do they rely on hooks 
that are not handled here?

Please explain the cost of the change - what do we pay in terms of 
memory, runtime, or other overheads in order to support this change?

> 
> A new process attribute identifies which security module
> information should be reported by SO_PEERSEC and the
> /proc/.../attr/current interface. This is provided by
> /proc/.../attr/display. Writing the name of the security
> module desired to this interface will set which LSM hooks
> will be called for this information. The first security
> module providing the hooks will be used by default.

Doesn't this effectively undo making the hooks read-only after init, at 
least for the subset involved?  What are the security implications thereof?

> The use of integer based security tokens (secids) is
> generally (but not completely) replaced by a structure
> lsm_export. The lsm_export structure can contain information
> for each of the security modules that export information
> outside the LSM layer.
> 
> The LSM interfaces that provide "secctx" text strings
> have been changed to use a structure "lsm_context"
> instead of a pointer/length pair. In some cases the
> interfaces used a "char *" pointer and in others a
> "void *". This was necessary to ensure that the correct
> release mechanism for the text is used. It also makes
> many of the interfaces cleaner.
> 
> https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v1-apparmor
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   drivers/android/binder.c                |  25 ++-
>   fs/kernfs/dir.c                         |   6 +-
>   fs/kernfs/inode.c                       |  31 ++-
>   fs/kernfs/kernfs-internal.h             |   3 +-
>   fs/nfs/inode.c                          |  13 +-
>   fs/nfs/internal.h                       |   8 +-
>   fs/nfs/nfs4proc.c                       |  17 +-
>   fs/nfs/nfs4xdr.c                        |  16 +-
>   fs/nfsd/nfs4proc.c                      |   8 +-
>   fs/nfsd/nfs4xdr.c                       |  14 +-
>   fs/nfsd/vfs.c                           |   7 +-
>   fs/proc/base.c                          |   1 +
>   include/linux/cred.h                    |   3 +-
>   include/linux/lsm_hooks.h               |  91 +++++----
>   include/linux/nfs4.h                    |   8 +-
>   include/linux/security.h                | 133 +++++++++----
>   include/net/af_unix.h                   |   2 +-
>   include/net/netlabel.h                  |  10 +-
>   include/net/scm.h                       |  14 +-
>   kernel/audit.c                          |  43 ++--
>   kernel/audit.h                          |   9 +-
>   kernel/auditfilter.c                    |   6 +-
>   kernel/auditsc.c                        |  77 ++++----
>   kernel/cred.c                           |  15 +-
>   net/ipv4/cipso_ipv4.c                   |  13 +-
>   net/ipv4/ip_sockglue.c                  |  12 +-
>   net/netfilter/nf_conntrack_netlink.c    |  29 ++-
>   net/netfilter/nf_conntrack_standalone.c |  16 +-
>   net/netfilter/nfnetlink_queue.c         |  38 ++--
>   net/netfilter/nft_meta.c                |  13 +-
>   net/netfilter/xt_SECMARK.c              |  14 +-
>   net/netlabel/netlabel_kapi.c            |   5 +-
>   net/netlabel/netlabel_unlabeled.c       | 101 +++++-----
>   net/netlabel/netlabel_unlabeled.h       |   2 +-
>   net/netlabel/netlabel_user.c            |  13 +-
>   net/netlabel/netlabel_user.h            |   2 +-
>   net/unix/af_unix.c                      |   6 +-
>   security/apparmor/audit.c               |   4 +-
>   security/apparmor/include/audit.h       |   2 +-
>   security/apparmor/include/net.h         |   6 +-
>   security/apparmor/include/secid.h       |   9 +-
>   security/apparmor/lsm.c                 |  64 +++---
>   security/apparmor/secid.c               |  42 ++--
>   security/integrity/ima/ima.h            |  14 +-
>   security/integrity/ima/ima_api.c        |   9 +-
>   security/integrity/ima/ima_appraise.c   |   6 +-
>   security/integrity/ima/ima_main.c       |  34 ++--
>   security/integrity/ima/ima_policy.c     |  19 +-
>   security/security.c                     | 338 +++++++++++++++++++++++++++-----
>   security/selinux/hooks.c                | 259 ++++++++++++------------
>   security/selinux/include/audit.h        |   5 +-
>   security/selinux/include/objsec.h       |  42 +++-
>   security/selinux/netlabel.c             |  25 +--
>   security/selinux/ss/services.c          |  18 +-
>   security/smack/smack.h                  |  18 ++
>   security/smack/smack_lsm.c              | 238 +++++++++++-----------
>   security/smack/smack_netfilter.c        |   8 +-
>   security/smack/smackfs.c                |  12 +-
>   58 files changed, 1217 insertions(+), 779 deletions(-)
> 

