Return-Path: <SRS0=B9fV=UY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F84C48BD5
	for <selinux@archiver.kernel.org>; Tue, 25 Jun 2019 15:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5057B213F2
	for <selinux@archiver.kernel.org>; Tue, 25 Jun 2019 15:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jYFuzxI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfFYPAm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:00:42 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:14948 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbfFYPAl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jun 2019 11:00:41 -0400
X-EEMSG-check-017: 28069745|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Jun 2019 15:00:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1561474839; x=1593010839;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=UcOTDMZ23PheOZew/eECmgUTsdKsZOYG7lblofKauGs=;
  b=jYFuzxI1YEf7koam1L5WVlEk04Ls3GM1qTHLOS/tTRuDBTxq9TZzZYfI
   mR/4gLP4a10sMkodVWkz5dtrADITmg2PUnbG3qWq7GeLOujiUOBgOW1LI
   aLQiyM6aGMGlitlLPcEZR3Zr9zenzqT8kCCUpg18ZrAYJSQ0vFv7Y7b7o
   /rOvoaDpj8yGaajbsHvR7Ixi/e39S51ErY/6L1UYsHeawMkJqFmubeLRe
   v38IZZCR0g8AAONPlsYovnOJJOxaslLD62okRM7zXDuaizJ4h5Hv5rxQm
   2RqT21tigdmqONVJYgh8dyHmD8JWL1fkiqS/TJMfGGXJQ4hjt7bplfZlO
   w==;
X-IronPort-AV: E=Sophos;i="5.63,416,1557187200"; 
   d="scan'208";a="25091878"
IronPort-PHdr: =?us-ascii?q?9a23=3At56akh+JIOxfC/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+geIJqq85mqBkHD//Il1AaPAdyBrasYwLqP++C4ACpcuM/H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjPusUMnIdvJak9xx?=
 =?us-ascii?q?jUrnBVf+ha2X5kKUickhrh+8u85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBswCvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFA7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2MnqQ9wrSS1ycc2lo?=
 =?us-ascii?q?nFmJ8ex1fG9SR33Ik6P8e4SFJlbdO/DJtRtz2VN4txQs84RWFoozw1xqcJuZ?=
 =?us-ascii?q?68YigH0ZIqzAPRZfyAdoiH+BPjVOCJLDd7mn1lYrS/iAi28US6ze38TMa03E?=
 =?us-ascii?q?5FripEjtnMsmoC2AfJ5sebTft9+1+t2SqV1w/J9OFEIFs0mbPHJJ4g2LIwkY?=
 =?us-ascii?q?ATsUvbEi/5mUX2kK+Wdlg/9eSy9+vnZbDmq5mBPIF3kgHzKrkil8OwDOgiMg?=
 =?us-ascii?q?UCQnKX9fqz2bH950H1XbNHheAsnKbDqpDVP8Ebq7a8Aw9Sz4ks9Q6yDyyj0N?=
 =?us-ascii?q?QEhXkHK09FeA6fg4jpJV7OJPf4AO+jg1u2ijdrxu3GPqb7DpXRLnnMjLfhfb?=
 =?us-ascii?q?Fn505a1AUz1sxQ64hRCrEAJPL/Qk7xtNrGAR8lKwG43unqBdpn2o4eRG6DGL?=
 =?us-ascii?q?GVPazMvVOS++4jO+yMa5UUuDb5Jfgl/fnujXohlF8fc6imwYEYaGqkHvh4OE?=
 =?us-ascii?q?iZfXrtjcsBEWcNpAY+Svfqh0eYXT5cYHayQbow5isnB4K+EYfDWoetjaSG3C?=
 =?us-ascii?q?e+GZ1WfWZGBUqQHnj2bIiEQekDZz+SIsB7jjwIT6SuS4gk1Ru2rg/116JnLv?=
 =?us-ascii?q?bI+i0frZ/jz8Z65+nSlRE06Dx1AN+Q03+CT25qhGMEXTw2075loUx71FiD1b?=
 =?us-ascii?q?J0g/tCFdxctLt1VVIdM5LGwu4yLtfpXAvKc9TBHFGjRc6gCDo8Zsg8z98Hfw?=
 =?us-ascii?q?B2HND0yljY0i6rBaIFv6KECYZy8a/G2XX1YcFnxCXozq4k2ls5ScJVKTfu0q?=
 =?us-ascii?q?xg/AHJG9Thj1SSl6Hsc78VmiHK6jHQniK1oEhEXVsoAu3+VncFax6T9I6o6w?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ByFQAJNhJd/wHyM5BgBh0BAQUBBwUBgWeBbSpqUjIoh?=
 =?us-ascii?q?BaIe4l8gg+aYQkBAQEBAQEBAQEtBwECAQGCEoFoRgKCdSM4EwEDAQEBBAEBA?=
 =?us-ascii?q?QEEAQFsijcMgjopAYJnAQUjDwEFPBUJAgkFCgICJgICVwYBDAYCAQGCXz8Bg?=
 =?us-ascii?q?goPiWSbaoExhDIBgRSDJYFABoEMKItegVZAgREngms+gmECgVODGIJYBIEtA?=
 =?us-ascii?q?YpCnTlrBgOCF4V0XI0VBhuCKZUljSiBMIYFkWghgVgrCkGBaIEaATMTgmWDO?=
 =?us-ascii?q?YUUhVsjAzABAYEEAQGPEwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 25 Jun 2019 15:00:38 +0000
Received: from localhost.localdomain (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5PF0cG4031393;
        Tue, 25 Jun 2019 11:00:38 -0400
Subject: Re: [Non-DoD Source] [PATCH userspace v4 0/4] Remove redundant rules
 when building policydb
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190613114558.32621-1-omosnace@redhat.com>
 <bdb2280a-23f3-e386-2ffb-801f0ec35c34@tycho.nsa.gov>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <97f5c5c4-c5fe-afe7-51fa-841704c1f4dc@tycho.nsa.gov>
Date:   Tue, 25 Jun 2019 11:01:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bdb2280a-23f3-e386-2ffb-801f0ec35c34@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/21/19 10:11 AM, jwcart2 wrote:
> On 6/13/19 7:45 AM, Ondrej Mosnacek wrote:
>> Changes in v4:
>>   * fix deallocation in error path in build_type_map()
>>   * fix leaked cond nodes
>>   * also update the man pages
>>   * use UINT32_C for 0xFFFFFFFF constant
>>   * squash in the RFC patches & drop the semodule patch
>> v3: https://lore.kernel.org/selinux/20190529073759.20548-1-omosnace@redhat.com/T/
>>
>> Changes in v3:
>>   * fix bad patch squashing
>>   * rename secilc --optimize-policy option to --optimize (to be simpler
>>     and consistent with checkpolicy and semodule)
>> v2: https://lore.kernel.org/selinux/20190528145912.13827-1-omosnace@redhat.com/T/
>>
>> Changes in v2:
>>   * fix handling of dontaudit (AVTAB_DENY) rules
>>   * switch optimization from opt-out to opt-in everywhere
>>   * add a patch from jwcart2 that adds optimization support to
>>     checkpolicy as well
>>   * add two RFC modifications (see log messages for details):
>>     * one improves the optimization to detect also rules covered by the
>>       union of two or more other rules (on permission set level)
>>     * the other one drops libsemanage/semodule run-time enabling/
>>       disabling of optimization in favor of a global config option
>> v1: https://lore.kernel.org/selinux/20190523102449.9621-1-omosnace@redhat.com/T/
>>
>> This series implements an optional optimization step when building a
>> policydb via semodule or secilc, which identifies and removes rules that
>> are redundant -- i.e. they are already covered by a more general rule
>> based on the type attribute hierarchy.
>>
>> Since the optimization might not always be useful (e.g. when care is
>> taken to not have redundant rules or when the attributes are
>> aggressively expanded) and might even drastically increase policy build
>> times under some cicumstances (for example with the DSSP standard policy
>> [1]), the optimization is applied only when requested explictly.
>>
>> The optimization routine eliminates:
>>   * all allow/dontaudit/auditallow(/neverallow) rules (including xperm
>>     variants) that are covered by another more general rule (or by a
>>     union of other rules),
>>   * all conditional versions of the above rules that are covered by a
>>     more general rule either in the unconditional table or in the same
>>     branch of the same conditional.
>>
>> The optimization doesn't process other rules, since they currently do
>> not support attributes. There is some room left for more precise
>> optimization of conditional rules, but it would likely bring only little
>> additional benefit.
>>
>> Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/545184071
>>
>> Tested:
>>   * live on my Fedora 29 devel machine under normal use (no unusual AVCs
>>     observed with the optimized policy loaded)
>>   * using: https://gitlab.com/omos/selinux-misc/blob/master/opt_test.sh
>>     * tests also xperm rules
>>     * doesn't test conditionals
>>
>> [1] https://github.com/DefenSec/dssp2-standard
>>
>> James Carter (1):
>>    checkpolicy: add flag to enable policy optimization
>>
>> Ondrej Mosnacek (3):
>>    libsepol: add a function to optimize kernel policy
>>    libsemanage: optionally optimize policy on rebuild
>>    secilc: add flag to enable policy optimization
>>
>>   checkpolicy/checkpolicy.8                  |   3 +
>>   checkpolicy/checkpolicy.c                  |  16 +-
>>   libsemanage/man/man5/semanage.conf.5       |   5 +
>>   libsemanage/src/conf-parse.y               |  15 +-
>>   libsemanage/src/conf-scan.l                |   1 +
>>   libsemanage/src/direct_api.c               |   7 +
>>   libsemanage/src/semanage_conf.h            |   1 +
>>   libsepol/include/sepol/policydb.h          |   5 +
>>   libsepol/include/sepol/policydb/policydb.h |   2 +
>>   libsepol/src/libsepol.map.in               |   5 +
>>   libsepol/src/optimize.c                    | 378 +++++++++++++++++++++
>>   libsepol/src/policydb_public.c             |   5 +
>>   secilc/secilc.8.xml                        |   5 +
>>   secilc/secilc.c                            |  16 +-
>>   14 files changed, 460 insertions(+), 4 deletions(-)
>>   create mode 100644 libsepol/src/optimize.c
>>
> 
> Acked-by: James Carter <jwcart2@tycho.nsa.gov>
> 
> staged: https://github.com/SELinuxProject/selinux/pull/168
> 
Merged.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
