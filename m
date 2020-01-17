Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95554C33C9E
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 18:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4272072B
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 18:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="m7HxamDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAQSma (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:42:30 -0500
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:51894 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQSma (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 13:42:30 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jan 2020 13:42:29 EST
X-EEMSG-check-017: 67621014|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="67621014"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2020 18:35:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579286123; x=1610822123;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=VkkZI9EqR49EDkPcuCONnH/lv0ZfhYjWdRqBJ2iEqTg=;
  b=m7HxamDAAWANFnz8WoQhhT23Uk/HC8RxtW6PJQ98VfdLsjY/uUICh/p5
   PwORa6weSJM5/ZjYVefaFfvPZPGoq68NpYZw+S/3NtKy+vKeM1sFPfiu8
   3ZLfEeu3Cv77erSLO8VDO+Rn0be6TWLYRt7IpMarKc+kQ25FjCtZUTOWt
   WUdauyb4xcWvVhILZXY2CVQP9+dw+6qA/M0FmJcUKGEW1DKirs5BL3CrN
   SEgC/dkr9f0VzDXgXLngoNN2IMnszEkDsRbnvcpFJxoM0uQyuQrv98shS
   2ox0QjlVA3WLSllGCPLyqKfXn/UIk4jT3p1uHb3kas8HhayVDUQ84TvFB
   g==;
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="32087384"
IronPort-PHdr: =?us-ascii?q?9a23=3AmwFv6hOSs/nWweKcg7cl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/n/rarrMEGX3/hxlliBBdydt6sYzbKG+PmxESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4Nqo8yR?=
 =?us-ascii?q?TFrmZMdu9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
 =?us-ascii?q?41/srrtRfCTQuL+HQRV3gdnwRLDQbY8hz0R4/9vSTmuOVz3imaJtD2QqsvWT?=
 =?us-ascii?q?u+9adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYMgXTn?=
 =?us-ascii?q?RdUMlPSyNBA5u8b4oRAOoHIeZYtJT2q18XoRejGQWgGObjxzlGiX/s2a0xzv?=
 =?us-ascii?q?ovHwfI0gc9G94CqXTZodHwOKoUTOu7zrTHzS/bYv1Lxzn95ojGfBMvr/6CUr?=
 =?us-ascii?q?1/c9bex0Y0GgPZjFids5DpMy+b2+kPtWWQ8upuVfioi24iswxxoDauyds2hY?=
 =?us-ascii?q?nTmoIZ1E3P+CJ7wIc7OdK3UlR7YcK6HJZLqyGbN5d5QsMlQ21yviY60acJtY?=
 =?us-ascii?q?S0fCgN1pQq3hjSYOGEfYiQ+h/vSemcLDhiiH9lZb6znQi+/Ee+xuHmS8W51k?=
 =?us-ascii?q?tBoDBfndnWrH8N0gTe6s2ASvRg4EiswS2P1wXP6uFcJkA0iLbbJ4YhwrEukp?=
 =?us-ascii?q?oTtlzOHjPsl0Xsja+Wa14k9vKp6+ThbLXmoYScOJFohQ3kLqQvmtCwAeQ/Mg?=
 =?us-ascii?q?QUWWiU5f+826H58U38QbVKiuU6kqjfsJ/EOcQWvrO1DgBa34o56xuzEi2q3M?=
 =?us-ascii?q?oXkHUZNl5JZQqLj43zNFHPJPD4A+2/g1OpkDpzxfDHMKHuDY/XLnjfjrvsZq?=
 =?us-ascii?q?p96k5AxwozytBT/ZRUCqobL/7pVU/xs8LYAgcjMwOo2+bnFMl91oQGVG2SBa?=
 =?us-ascii?q?+ZNaLSsVmJ5u0zIOmAfoAVuCz8K/gr+/7jlmI2lkETfaa325sXc263Eeh8L0?=
 =?us-ascii?q?WfZXrmms0BHnsSvgoiUOzqj0WPUSVNaHa2XqI84Cw7CY29AIfdSYCinqaB0D?=
 =?us-ascii?q?24HpJIfGBGDE6DEXPye4WDQfcMZ3HaHsg0vjsBVL6gQIxp+guvuhOyn7ZgK+?=
 =?us-ascii?q?vS+yYb85351dZpz+Hemxw07jF/ScKZhSXFVGxwn2UVVxco061l509w0FGO1e?=
 =?us-ascii?q?5/mfMLO8ZU4qZLTQwzL4KGh7h4FNv7QB6bVsuYQ1ahBNO9CHc+ScxnkIxGWF?=
 =?us-ascii?q?p0B9j31kOL5CGtGbJA0uXWVZE=3D?=
X-IPAS-Result: =?us-ascii?q?A2DmBgA7/SFe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XuCDRIqhBGJA4gfmzcJAQEBAQEBAQEBNwEBghOCLQKCLjkFDQIQAQEBBAEBA?=
 =?us-ascii?q?QEBBQMBAWyFQ4I7KQGCeQEBAQECASMVRgsLCQ8CAiYCAlcGAQwGAgEBgmM/g?=
 =?us-ascii?q?lwgrEp1gTKFSoMwgT6BDiiNbkCBOA+CXT6HWYJeBIE/AYwQiWBGepVmdgaCP?=
 =?us-ascii?q?ZYqBhuaco5clx+FeCGBWCsKQYFogU5QGA2IOY4sIwMwjWcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Jan 2020 18:35:22 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00HIYjmZ250547;
        Fri, 17 Jan 2020 13:34:45 -0500
Subject: Re: [Non-DoD Source] Re: any reason why a class mapping is not able
 to solve permissionx?
To:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
References: <20200117173448.GA166208@brutus.lan>
 <20200117182405.GA182181@brutus.lan>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <21c6b770-0b7c-451e-501d-c7291858107e@tycho.nsa.gov>
Date:   Fri, 17 Jan 2020 13:36:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117182405.GA182181@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/20 1:24 PM, Dominick Grift wrote:
> On Fri, Jan 17, 2020 at 06:34:48PM +0100, Dominick Grift wrote:
>> For example this:
>>
>> (permissionx alg_socket_ioctl_except_SIOCGIFHWADDR (ioctl alg_socket (and (all) (not (0x8927)))))
>> (classmap all_sockets (ioctl_except_SIOCGIFHWADDR))
>> (classmapping all_sockets ioctl_except_SIOCGIFHWADDR alg_socket_ioctl_except_SIOCGIFHWADDR)
>>
>> (allowx a self (all_sockets (ioctl_except_SIOCGIFHWADDR)))
>>
>> Say's:
>>
>> <snip>
>> Building AST from Parse Tree
>> Destroying Parse Tree
>> Resolving AST
>> Failed to resolve classmapping statement at policy/base/class_maps.cil:994
>> Problem at policy/base/class_maps.cil:994
>> Pass 14 of resolution failed
>> Failed to resolve ast
>> Failed to compile cildb: -2
>> make: *** [Makefile:30: policy.32] Error 254
>>
>> Am i doing something wrong or is this unsupported?
> 

Class maps only support normal permissions, they do not support extended 
permissions.

> Are we supposed to be able to use allowx rules in macros?
> 

allowx rules are allowed in macros. I will see if I can reproduce the error 
below and figure out what's going wrong.

Jim

> This works when the tunable is set false:
> 
> (tunable no_mac_addr true)
> 
> (block bla1
>          (blockinherit system_agent_template)
> 
>          (macro stuff ((type ARG1))
>                  (tunableif no_mac_addr
>                    (true
>                        (allow ARG1 self create_except_ioctl_tcp_stream_socket_perms)
>                        (allowx ARG1 self tcp_socket_ioctl_except_SIOCGIFHWADDR))
>                    (false
>                        (allow ARG1 self create_tcp_stream_socket_perms)))))
> 
> (block blah2
>          (blockinherit system_agent_template)
> 
>          (call bla1.stuff (subj)))
> 
> But when the tunable is set true:
> <snip>
> Building AST from Parse Tree
> Destroying Parse Tree
> Resolving AST
> make: *** [Makefile:30: policy.32] Segmentation fault (core dumped)
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
