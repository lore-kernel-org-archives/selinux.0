Return-Path: <SRS0=4+dM=3K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F0BC3F68F
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 15:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF39D24125
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 15:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="GZvRWeLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAUP7D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:59:03 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:65395 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbgAUP7D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jan 2020 10:59:03 -0500
X-EEMSG-check-017: 47999550|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="47999550"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Jan 2020 15:58:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579622340; x=1611158340;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=rQVJnH6cK9SUWWD0h4lMoie7U+H5IZ0jnpYq3pguPgQ=;
  b=GZvRWeLR6zUHcBsGMRL1fvadasFj/saBdtheCueXB29G31GrhDAD56LB
   ZNPRmJYdu1dOR7B9ruwlhFd9yom5hDtQY7nZmpVzBv+KZ91ZhBpqdpUdP
   lgafPMe/DRk+83KZSL9JJsbyEXc9fgvnFqFYRtWDGlRtY7E/EsfOmE4Qs
   /D+ZBgc9BvUi2KFTREhngZfzzdTHO9AOYRBEuRgV0QSPcsv2wydVT0AOl
   LoPn232hcdL1M8wzkk9TdWfCt+pvWNglwOREdZEbLQ4qnmpzmu/TvHtB7
   tHP1sT56sOtQiPkApJP2ijW5veyLarN9OHJ8VMdesTwi6fNZcjBAMUEHX
   g==;
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="38039405"
IronPort-PHdr: =?us-ascii?q?9a23=3AL1qD2B9xrZwex/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21OkcTK2v8tzYMVDF4r011RmVBNmdsqIP1Lqe8/i5HzBZutDZ6DFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sArcutMLjYZhJao8yB?=
 =?us-ascii?q?jEqWZMd+hK2G9kP12ekwvy68uq4JJv7yFcsO89+sBdVqn3Y742RqFCAjQ8NG?=
 =?us-ascii?q?A16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWT?=
 =?us-ascii?q?Sj9KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjZa7WY88USn?=
 =?us-ascii?q?RdUcZQTyxBA52zb40TD+oaIO1Uq5Dxq0YSoReiAAWhAu3gyiVMhnTrw6M01e?=
 =?us-ascii?q?ovGhzC0AA5Ed8DtHHYodPoP6kQTO+11rHFwyjdYfNY2Tnz64bGfR4urv6OQb?=
 =?us-ascii?q?1+ftHcyVUtGg7fklmctYLoMjGT2+8Qs2ab9e1gVee3hmA6twF+vCCvxscyhY?=
 =?us-ascii?q?nPm4kb11XE+j99wIYxO9K5SFNwbNm/EJRNrCGXLJd2Q8M+TGFovyY20LsGuY?=
 =?us-ascii?q?WhcyQQx5QnwADfZuWBfoOV4RzjTP6cLSp3iX9qYr6yhwu+/VK+xuDzSMW4yk?=
 =?us-ascii?q?tGoyxYmdfWrH8NzQbc6s2fR/t4+UeuxCiA2hjI6uFBPUA0ja3bK4M9wrIolp?=
 =?us-ascii?q?ocr0DDHijulUXqlqCWbEQk+vWz6+j9Y7XmoJGcN4hvig7gLqsigNC/AOQkPQ?=
 =?us-ascii?q?gOWGiX4+K826H4/ULlWrlKi/w2kq3BvJDbI8QUuLK5DhdI3oss5BuzFTer3M?=
 =?us-ascii?q?kCkXUZI19JZgiLg5XxN1HLOv/4DPO/g1q2kDdswvDLJqbhDYjWLnXYjLfgfa?=
 =?us-ascii?q?py605byAYpy9Bf/IhbBqsOIPL0RE/9rMbYAQMhMwyo3+bnD81w1pkfWW2TAq?=
 =?us-ascii?q?+WKrnSvkKQ6e0zO+aMZJUauDf7K/c7/P7jlmQ2mUMcfamvwZsYdmq4HvJ4LE?=
 =?us-ascii?q?WFe3bjntABEWIStAokUOPqkEGCUSJUZ3uqRKIz+DU7CIOgDYfeSYGgm6KB3C?=
 =?us-ascii?q?ilEZ1MfGxGCU6DEW3ud4qaX/cAciWSItVukm9Mab/0cY4q1Ri0uEfawrthI/?=
 =?us-ascii?q?GcrjcZvpLqztRC7NrTnBA0+CdcBdic1X2AVWd5giUDQDpgmOhkrEh8zEqT+b?=
 =?us-ascii?q?Z3juYeFtFJ4f5NFAAgOs3y1et/XuvuVxrBc9HBc1OvRtGrEHllVd4q68MfaE?=
 =?us-ascii?q?Z6XdO5h1bM2DT8UOxdrKCCGJFhqvGU5HP2Pcsoji+dhaQ=3D?=
X-IPAS-Result: =?us-ascii?q?A2APAwBSHyde/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASASKoQSiQOGZQEBBAaBEiWJbpFJCQEBAQEBAQEBATcBAYRAAoI2OBMCE?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMVUQsYAgImAgJXBgEMBgIBAYJjP?=
 =?us-ascii?q?4JLAwklriSBMoVKgzGBPoEOKowueYEHgTgMA4JdPoIbhT6CPCIEllFhRpdag?=
 =?us-ascii?q?kOCSZNiBhuad45enRcigVgrCAIYCCEPgydQGA2WZSMDMI4RAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 Jan 2020 15:58:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00LFvtwg053628;
        Tue, 21 Jan 2020 10:57:56 -0500
Subject: Re: [PATCH V7 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200119111740.61358-1-richard_c_haines@btinternet.com>
 <20200119111740.61358-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7403753e-78e8-62b3-3372-476864df8b57@tycho.nsa.gov>
Date:   Tue, 21 Jan 2020 10:59:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200119111740.61358-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/19/20 6:17 AM, Richard Haines wrote:
> Test filesystem permissions, setfscreatecon(3), file { quotaon } and
> changing file context via non and name-based type_transition rules.
> The name-based rules only apply to:
>    (MOD_POL_VERS >= 11 and POL_VERS >= 25 and MAX_KERNEL_POLICY >= 25)
> 
>  From kernels 5.5 filesystem { watch } is also tested.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   defconfig                                     |   6 +
>   policy/Makefile                               |   7 +
>   policy/test_filesystem.te                     | 373 +++++++
>   policy/test_filesystem_name_trans.te          |  20 +
>   tests/Makefile                                |   7 +
>   tests/filesystem/.gitignore                   |  11 +
>   tests/filesystem/Makefile                     |  16 +
>   tests/filesystem/check_file_context.c         |  75 ++
>   tests/filesystem/check_mount_context.c        | 127 +++
>   tests/filesystem/create_file.c                | 117 +++
>   tests/filesystem/create_file_change_context.c | 146 +++
>   tests/filesystem/fanotify_fs.c                |  79 ++
>   tests/filesystem/fs_relabel.c                 | 138 +++
>   tests/filesystem/grim_reaper.c                |  89 ++
>   tests/filesystem/mount.c                      | 130 +++
>   tests/filesystem/quotas_test.c                | 143 +++
>   tests/filesystem/statfs_test.c                |  65 ++
>   tests/filesystem/test                         | 968 ++++++++++++++++++
>   tests/filesystem/umount.c                     |  84 ++
>   19 files changed, 2601 insertions(+)
>   create mode 100644 policy/test_filesystem.te
>   create mode 100644 policy/test_filesystem_name_trans.te
>   create mode 100644 tests/filesystem/.gitignore
>   create mode 100644 tests/filesystem/Makefile
>   create mode 100644 tests/filesystem/check_file_context.c
>   create mode 100644 tests/filesystem/check_mount_context.c
>   create mode 100644 tests/filesystem/create_file.c
>   create mode 100644 tests/filesystem/create_file_change_context.c
>   create mode 100644 tests/filesystem/fanotify_fs.c
>   create mode 100644 tests/filesystem/fs_relabel.c
>   create mode 100644 tests/filesystem/grim_reaper.c
>   create mode 100644 tests/filesystem/mount.c
>   create mode 100644 tests/filesystem/quotas_test.c
>   create mode 100644 tests/filesystem/statfs_test.c
>   create mode 100755 tests/filesystem/test
>   create mode 100644 tests/filesystem/umount.c

[...]

