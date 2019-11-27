Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0FBC432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 14:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072BC20678
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 14:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="C7lU6Vr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfK0O67 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:58:59 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:41889 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfK0O67 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 09:58:59 -0500
X-EEMSG-check-017: 55262778|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="55262778"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2019 14:58:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574866737; x=1606402737;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=VovbWJEwFo4iS0g6j6rw9uemeQsa9uSBMkgJXp4VDlU=;
  b=C7lU6Vr83C7KSN5LsR44p4c1bn+TQ5oj9ABWrNSWvOfut1zwDiD3za4z
   oDDggJwOydxROVAYqXBGkDEmaSfguFwAT6fFyfi+WJKfMHvkKGcmTSV8r
   nUKoTsX8F36DEtnjM8iT++ji27LyuP2VVPsa8gTUbN+BLJyXo3x5k0xk0
   h4xd9SJwKhibw3Vd5sEzpvPC+sdj+8a0idvivTCTViBz9X3vx8Lhwu/as
   qU3iMHSPOFQz2o3W8a0FvYxUOEkoz9NHqqPkjSZrAgZTobhoUT7uB279y
   yyR8hZ2RAPNRJfiKrtluCCZJI3se+Yso+m749h3h7LBkXn2DzDYHJp/EN
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="30557896"
IronPort-PHdr: =?us-ascii?q?9a23=3A+hzKphcPIoIWfoqjJ6XhutM5lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW+ZB7h7PlgxGXEQZ/co6odzbaP6Oa5BzFLv8nJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/MusQXgYZuJac8xx?=
 =?us-ascii?q?nUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezBQ2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwl5?=
 =?us-ascii?q?wTsUrEHi/thkr5kLWadlkk++e06+TnZa/qppmAOI9vlg7yKKEums27AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH+8kD0T69Gg/0rnqXDrpzXKtoXqrSkDwNN14Ys8Re/DzOo0N?=
 =?us-ascii?q?QCmnkHKUpIeAmagIjyIFzOPPD5Auu/g1SrijtrwevGMaf7DpXCKXjDjq/tfa?=
 =?us-ascii?q?xh5E5E1Aoz0ddf6opOCrEAPP3zWlX+tMbFARAhLwO72+bnB8981oMYR22PGb?=
 =?us-ascii?q?SUP7jOsV+J4OIvP/eDZJUTuDnjN/gp/eLhjXg8mVUFZ6mmwYMXaGykHvRhO0?=
 =?us-ascii?q?iZemTjgtMAEWcMowo/Q/fniEONUTFNfXa+RaE86S8hCIKgE4jDQpqhgLub3C?=
 =?us-ascii?q?e0TdVqYTV8C1uMGG3kP6WNWvEBc2rGOM5qkjUeWY+qfI8o1Bejryfw17thMu?=
 =?us-ascii?q?fO/CAE85nk0Y4xr/bekRA06CxcEcuQySeOQntyk2dOQCU5j45lpkko8UuOya?=
 =?us-ascii?q?h1hbRjENVX4/5YGlMhOYX00/1xC9e0XBnIONiOVgD1EZ2dHTgtQ4dpkJc1aE?=
 =?us-ascii?q?FnFoDn102S0g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BwAwDpjt5d/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX4Cg?=
 =?us-ascii?q?XKBbSAShFWJA4ZZBoESJYlpkUQJAQEBAQEBAQEBNwEBhEACgiQ5BQ0CEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgm4BBSMVUQsYAgImAgJXBgEMCAEBgl8/glMls?=
 =?us-ascii?q?kqBMoVPg0OBSIEOKAGML3mBB4E4DAOCXT6HWYJeBJZjRpcQgjeCOZMXBhuaH?=
 =?us-ascii?q?45InCYhgVgrCAIYCCEPgyhPERSGVBeBBAEEjTgjA45tAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Nov 2019 14:58:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAREwn7W267949;
        Wed, 27 Nov 2019 09:58:50 -0500
Subject: Re: [RFC PATCH] selinux-testsuite: Add TUN/TAP driver tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191127094702.3418-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <41aca6c1-7284-0226-3f20-6eb15f437c48@tycho.nsa.gov>
Date:   Wed, 27 Nov 2019 09:59:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127094702.3418-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/27/19 4:47 AM, Richard Haines wrote:
> Test TUN/TAP tun_socket permissions.
> 
> I've made this an RFC patch as TAP supports adding BPF prog file
> descriptors, therefore I've added a simple test that just checks that it
> works. However, there does not seem to be a requirement to test any
> additional SELinux functionality that the basic BPF tests do not
> already cover. Any views !!!

That seems reasonable to me.  Generally our focus is on ensuring test 
coverage of the LSM/SELinux hooks and SELinux kernel APIs, so anything 
that is already covered by an existing test doesn't need to be repeated. 
  In the case of tun/tap, likely only the tun_socket checks themselves 
are unique to these tests.

I would prioritize on 1) ensuring that we have test coverage of new 
security hooks, new functionality within existing hooks, or new SELinux 
kernel APIs as they get added to the kernel, e.g. the perf permission 
checks (github issue #71), the socketpair peer labeling support (#63), 
etc, and then 2) gradually expanding our test coverage of existing 
security hooks and kernel APIs to ensure that future kernels do not 
regress, e.g. it would have been nice to have had explicit tests for 
context mounts as per issue #20 to ensure that we didn't regress during 
the vfs new mount API overhaul (we happen to exercise context mounts as 
part of overlay testing and as part of binderfs testing but not as a 
separate test, not in a comprehensive way, and not for anything other 
than overlay mounts), and likewise for many of the tests identified as 
open github issues.

I haven't looked too closely at this yet, but I did have one minor 
comment on your test policy below.

<snip>
> diff --git a/policy/test_tap_bpf.te b/policy/test_tap_bpf.te
> new file mode 100644
> index 0000000..f921a5a
> --- /dev/null
> +++ b/policy/test_tap_bpf.te
> @@ -0,0 +1,30 @@
> +#
> +########### Test TAP/BPF - 'tun_socket' #################
> +#
> +attribute tapbpfdomain;
> +
> +# For CONFIG_TUN=m
> +kernel_request_load_module(tapbpfdomain)
> +
> +gen_require(`
> +	type tun_tap_device_t;
> +')

Any time you find yourself needing a require, look to see if there is a 
refpolicy interface you could use instead that would provide that 
require and the necessary rules.  In this case, I think you could have 
used corenet_rw_tun_tap_dev().
