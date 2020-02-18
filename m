Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F3AC34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 15:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989A12176D
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 15:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hINXCKQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgBRPky (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:40:54 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:8051 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgBRPky (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 10:40:54 -0500
X-EEMSG-check-017: 56888226|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="56888226"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 15:40:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582040451; x=1613576451;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=PYP12ii9Jm9KKzAjIOR6c/DIuIo+Yb1fBkayJP4/cs8=;
  b=hINXCKQt1U2RzwlJz7dEXVcUAghiv2tQN5PbEP+y3MkaIeOp5MvNuPw0
   UJ2iPjxN3JKDhleza1F4BDWs2kENUJHqshwcW36cLLXtt6+l3zivPkTMo
   TduBHUMp6tNnlv3eHScfpLf2fbExzDMvZY16yS0I95KfiXeIV7Ox1ltZJ
   qJ/a4/6kxYMc57m279yly4++o+sN+U0Ljusx/E3rjLxIcCB5Kg7yBApUy
   PNoZGo+UCg2I4wPTfpJDyaC2CWuXLdVD3TKkkdyVdczHT+rYBFuvw2Amn
   aC654N9Gu8SxnFbKe63MgNvhuukf0MhiTBXjzjXkl1ROGu6YbJ1956k3N
   w==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="33155170"
IronPort-PHdr: =?us-ascii?q?9a23=3AJ5YFExTYIOf5xR2+JrL7hW3btdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6ybBaN2/xhgRfzUJnB7Loc0qyK6vymBjxLvsfJmUtBWaIPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sArcutMUjIZhJao8yB?=
 =?us-ascii?q?/EqWZUdupLwm9lOV2ckxHg68mq4ZVt6T5Qu/Uv985BVaX1YaE1RqFGATolLm?=
 =?us-ascii?q?44+tTluQHMQgWT6HQcVH4WkgdTDAje8B76RJbxvTDkued7xSKXINf5TbEwWT?=
 =?us-ascii?q?Sl8qdrVBrlgzoJOjIl7G3ajNF7g6xBoBKluhdx3Yjabo+IP/Z6Z6/Qc9cXSW?=
 =?us-ascii?q?9HU81MVSJOH5m8YpMSAeQBI+hYoYrzqVUAohSxBwajGOzhxyRUhnL1x6A2z/?=
 =?us-ascii?q?gtHA/E0QEmAtkAsG7UrNLwNKoKTO610LfHzS3Db/xI3zf29ZXGchU7rvGIWb?=
 =?us-ascii?q?J/b8rQwlQoGgPek1qQspfoPy+V1+sRs2ib6PBsVeS0i2E9sQ1xrT+vxtk1h4?=
 =?us-ascii?q?TPm4kbyUjE+D1kzIs6KtC0Uk52bcO+HJdOuCyWKZF6Tt4kTmp1oig10KcGto?=
 =?us-ascii?q?S+fCUSzZQnwAPQZOKffoiT5xLjSP6RITBlhHJ5YL6/hwi98UynyuDkSsm7yk?=
 =?us-ascii?q?xKritYktnXrHwN1hrT6saASvtm4EiuxSyD1xzT6+5YIUA0krDXK5g9zb4rip?=
 =?us-ascii?q?Ufq0HDHi7ymEnuja+WcFsr+vSw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7krLEv5DBPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jkywnzdkxvHGObvhDYvWLnXYn7fher?=
 =?us-ascii?q?F960FYyAUtyNBQ/ZNUCrUbLP3vXU/xscTSDgUlPAys3+bnFNJ925sFWW2RBq?=
 =?us-ascii?q?+ZMaXSsUKH5+80PemMa5EauCznJ/gm+fHul3k5lkEZfaWz2psXcn+4TbxaJB?=
 =?us-ascii?q?CyYWDtmcsAGGE9kZQiUPfhiFDKBTVcdXG0UrkU6TY8B4arCI7CQsamh7nXmG?=
 =?us-ascii?q?+gE5lXYH1WIk6DHG2udIieXfoILiWILZxPiDsBAIO9Rpch2Bfmjwrzz75qP6?=
 =?us-ascii?q?KA4SEDnY7y39hyoevInFc98iIiXJfV6H2EU2whxjBAfDQxxq0q5Bcsxw=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2CdBQD2BExe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXsCA?=
 =?us-ascii?q?YF6gWwBIBIqhBSJA4ZeAwaBN4lwiieHIwkBAQEBAQEBAQE3BAEBhEACgic5B?=
 =?us-ascii?q?Q0CEAEBAQUBAQEBAQUDAQFshUNCARABgWcpgwMBBSMPAQVRCxgCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgmM/gksDCSWscYEyiC8NYoE+gQ4qAYw9eYEHgTgPgl0+ghuFQII8I?=
 =?us-ascii?q?gSYGJdygkWCUJQDBhyCOZhtLY5AnVAhgVgrCAIYCCEPgydQGA2dASMDMIo5h?=
 =?us-ascii?q?jABAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Feb 2020 15:40:48 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IFdkjU026683;
        Tue, 18 Feb 2020 10:39:46 -0500
Subject: Re: [PATCH] libselinux: drop error return from is_selinux_enabled
 documentation
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20200207143744.9944-1-cgzones@googlemail.com>
 <20200214184751.8211-1-cgzones@googlemail.com>
 <c62a2099-fa22-2ff8-bf14-0350e786864d@tycho.nsa.gov>
Message-ID: <94dc24e7-be2b-c555-0bf0-9d98edf69204@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 10:41:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c62a2099-fa22-2ff8-bf14-0350e786864d@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/20 2:42 PM, Stephen Smalley wrote:
> On 2/14/20 1:47 PM, Christian Göttsche wrote:
>> Since commit e3cab998b48ab293a9962faf9779d70ca339c65d ("libselinux
>> mountpoint changing patch.") for version 20120216 is_selinux_enabled()
>> does never return -1; drop mentions in the man-page and header file.
>>
>> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks, applied.


