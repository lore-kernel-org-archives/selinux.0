Return-Path: <SRS0=kuBz=3Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018EAC35247
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE28A20674
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 15:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="JI+b2b8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBDPjQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:39:16 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:32015 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBDPjQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Feb 2020 10:39:16 -0500
X-EEMSG-check-017: 54086496|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,402,1574121600"; 
   d="scan'208";a="54086496"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Feb 2020 15:31:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580830290; x=1612366290;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gs0nSkbJQkf/VEtAgp330XvlFSh/7fT5YY9yO2wOFaU=;
  b=JI+b2b8i1J/hgKivQANGc4uOUgt4BD9RbigqOjQu6wPa7b0ojK49K+sd
   gTiVru4Mo8lcg+HMOQxi1+/K2IaDaMaJRDsypXL+SWFwCKLf2d5CYY4C+
   23KCf+Ag0CwP6FEuvlw1tNRoHF3Gck3bbgJ62ZE1B1fMwvZqqFy7QhRiw
   9lvIeZgQ4hlgULbXZmaU48h5lMwmRPlFROiTXlqbDte5UtHCxGt2TfsOZ
   Z6ZhMO00jzAWoL3uni7Q7TmWB1jwLzWAsYrOVOpiuB0Me45kVy7GEO8UW
   otRVlJFVglmiu/3xXQrizVC2k3BTOiysC/wNhL2GBP9QLlJp5Oc0djHCa
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,402,1574121600"; 
   d="scan'208";a="38646045"
IronPort-PHdr: =?us-ascii?q?9a23=3A0aY6kRQqq0M02pQmHJzo9pkdM9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZhaGt8tkgFKBZ4jH8fUM07OQ7/m8HzBRqsna+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTrXZFf+tayGFmKFmOmxrw+tq88IRs/ihNtf8t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ91cXDJdDIyic4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ks03O?=
 =?us-ascii?q?Q7FQHNwRIuEdQAvn/JqNn5LbkeXOSwwKTO0D7Nbe5Z2S3l5YbVbB4hr/GCU7?=
 =?us-ascii?q?F+f8XfxkYgFR/KgFqLpIz5PT6YzPgBv3SV4udiU++klm4pqxt2ojiq3soil5?=
 =?us-ascii?q?XJiZwNylDE6yp5xps+K8C9SEFhZd6kFIVftiGHPIZxWcMtXnpotT0myrwGpZ?=
 =?us-ascii?q?G7fC8KxI4hxx7EcfOLaYeI4hX9VOuIJzpzmXxreLW6hxmo8EigzPXxVsqq31?=
 =?us-ascii?q?ZQqCpKjN3MumoK1xzJ5ciLUvR9/ka92TaPygDc8ftILlwzlareLZMq370+lo?=
 =?us-ascii?q?ILvEjeESL7l1/6ga+Lekk+5OSl5Prrbq/7qpKaKoR6kBvxMr40lcy6Gek4Nw?=
 =?us-ascii?q?8OUHWF9umkz73j+FH5QK1Njv0rjqnVqJDaKtofpq6+GwJVzpws6wy+Dze7y9?=
 =?us-ascii?q?QUh3gHLFRLeBKAlIjmJU3BLOrkDfa/n1uskDBry+rAPrL9GZXCMmLPkLLgfb?=
 =?us-ascii?q?Z580JcyQwzws5D559MF70ML/3+VlXxudDFFBM1LQO5z/j9BNlgzo8eXHiAAq?=
 =?us-ascii?q?6dMKPcq1+I4ecvLvGXZIAIozbwMOQl5v7ygn85nl8RZ6+p3YANZ3yiEfRmJF?=
 =?us-ascii?q?uZbWL2gtgdCWcKohY+TOvyhV2FVD5TYG2yX6Qm6T4nFo2rFp3DSZ6wj7yBxi?=
 =?us-ascii?q?i7AodaaXxBClCJCX3obZmLW+8QaCKOJc9siiELWqa/S4I60RGvtAn6yrV5Ie?=
 =?us-ascii?q?vU5CIUr4/s28Zt7e3JiR4y7SB0D9ia02yVV2F7hH4IRzst0aBnu0N911OD3b?=
 =?us-ascii?q?F9g/xfEtxT/e1GXh0mOp7byuxwE8ryVR7ZfteVVFamRc2rASovQdI1wt8OZV?=
 =?us-ascii?q?t9Gtq5gxDd0CqlHaUVm6aIBJMq6KLc2Wb+J8Jnx3bBzqkhgEEsQtFTOm2+mq?=
 =?us-ascii?q?5/6w/TCpbNk0WYkaaqaKsd0DfO9Gid12qOul9XUAprXKXbUnAQeFHWoc765k?=
 =?us-ascii?q?zcVb+uD6ooMg9bxc6FMKtKZcXjjU9aS/f7JNTef2Wxln+qBRaJ2ryMbJDle3?=
 =?us-ascii?q?8A0yrFFEcLiwAT8myHNQg4GCihuHnTAydyFVLuZUPs7fdxqGm9TkAq0wGGdV?=
 =?us-ascii?q?Fu172w+k1dufvJbPUfxL8G8AImsDN9F1u+l4bRDt2boQNqcY1GbN896UsB3m?=
 =?us-ascii?q?Xc4V9TJJulept+i0YefgI/hEbn0xF6G80UisQxhG87xwp1b6SD2RVOcC3Ojs?=
 =?us-ascii?q?O4AaHeNmSnpEPnUKXRwFyLlY/Mq6o=3D?=
X-IPAS-Result: =?us-ascii?q?A2DQAABkjTle/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gRhUIRIqhBSJA4ZoBoESJYEBiG6RSQkBAQEBAQEBAQErDAEBhEACg?=
 =?us-ascii?q?ls4EwIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgwEBAQEBAgEjFUEFCwsOCgICJ?=
 =?us-ascii?q?gICVwYNBgIBAYJjPwGCVgUgD6wPdYEyhDUBgRSDP4E+gQ4qjDx5gQeBEScMA?=
 =?us-ascii?q?4IoNT6CZAKEdYI8IgSNVIJEhkBhRnuWaYJFgk6Ee450BhuDQJMChEaERJMEl?=
 =?us-ascii?q?EQigVgrCAIYCCEPgycJRxgNjigBF4NQhAiBDIVdIwMwjw0BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Feb 2020 15:31:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 014FUblg176210;
        Tue, 4 Feb 2020 10:30:38 -0500
Subject: Re: [PATCH RFC] selinux: policydb - convert filename trans hash to
 rhashtable
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Lucas Stach <dev@lynxeye.de>, Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
References: <20200116213937.77795-1-dev@lynxeye.de>
 <2d1a3d66-c2ee-f7ea-a884-11ac9150d994@tycho.nsa.gov>
 <CAFqZXNtJ2h-HPwzV9t1bizVB2=xWh=s3jY5aqXG1x86b+oEMYg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f821809b-548d-fd95-6574-7c74c634353e@tycho.nsa.gov>
Date:   Tue, 4 Feb 2020 10:32:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNtJ2h-HPwzV9t1bizVB2=xWh=s3jY5aqXG1x86b+oEMYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/4/20 10:01 AM, Ondrej Mosnacek wrote:
> On Fri, Jan 17, 2020 at 8:11 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 1/16/20 4:39 PM, Lucas Stach wrote:
>>> The current hash is too small for current usages in, e.g. the Fedora standard
>>> policy. On file creates a considerable amount of CPU time is spent walking the
>>> the hash chains. Increasing the number of hash buckets somewhat mitigates the
>>> issue, but doesn't completely get rid of the long hash chains.
>>>
>>> This patch does take the bit more invasive route by converting the filename
>>> trans hash to a rhashtable to allow this hash to scale with load.
>>>
>>> fs_mark create benchmark on a SSD device, no ramdisk:
>>> Count          Size       Files/sec     App Overhead
>>> before:
>>> 10000          512        512.3           147715
>>> after:
>>> 10000          512        572.3            75141
>>>
>>> filenametr_cmp(), which was the topmost function in the CPU cycle trace before
>>> at ~5% of the overall CPU time, is now down in the noise.
>>
>> Thank you for working on this.  IMHO, Fedora overuses name-based type
>> transitions but that's another topic. I haven't yet investigated the
>> root cause but with your patch applied, I see some test failures related
>> to name-based transitions:
>>
>> [...]
>> #   Failed test at overlay/test line 439.
>> overlay/test ................ 114/119 # Looks like you failed 1 test of 119.
>> [...]
>> filesystem/test ............. 3/70 File context error, expected:
>>          test_filesystem_filenametranscon1_t
>> got:
>>          test_filesystem_filetranscon_t
>>
>> #   Failed test at filesystem/test line 279.
>> File context error, expected:
>>          test_filesystem_filenametranscon2_t
>> got:
>>          test_filesystem_filetranscon_t
>>
>> #   Failed test at filesystem/test line 286.
>> filesystem/test ............. 68/70 # Looks like you failed 2 tests of 70.
>>
>> You can reproduce by cloning the selinux-testsuite from
>> https://github.com/SELinuxProject/selinux-testsuite, applying the
>> filesystem tests patch from
>> https://patchwork.kernel.org/patch/11337659/,
>> and following the README.md instructions.
> 
> I think I figured out what's wrong - see below.
> <snip>
>>> @@ -441,6 +442,39 @@ static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
>>>
>>>    }
>>>
>>> +static const struct rhashtable_params filename_trans_hashparams = {
>>> +     .nelem_hint             = 1024,
>>> +     .head_offset            = offsetof(struct filename_trans, hash_head),
> 
> You need to add:
> 
> +.hashfn = filenametr_hash,
> 
> here so that the key is correctly hashed on lookup. After applying
> this fix, the selinux-testuite passes for me with this patch.

Hmm..does that then make the .obj_hashfn assignment below unnecessary or 
is that required too?  I'm unclear on the difference.

> 
>>> +     .obj_hashfn             = filenametr_hash,
>>> +     .obj_cmpfn              = filenametr_cmp,
>>> +};
