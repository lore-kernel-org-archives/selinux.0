Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDEBC43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 13:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F04322467
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 13:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="k1TmAwk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKMNNP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:13:15 -0500
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:49641 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfKMNNP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 08:13:15 -0500
X-EEMSG-check-017: 50007838|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,300,1569283200"; 
   d="scan'208";a="50007838"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Nov 2019 13:13:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573650793; x=1605186793;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=18Jxw0b++RJTfNQJ3Lr4nGh2P22FEQ7YTwh0fIFlrug=;
  b=k1TmAwk1ZJ9mg6f/PuZ0TU4pobv9ijU4tSKekvFaBOVlmhfKfAs/CLUk
   oHYYYeJBMzucK2v3iR2ro8YwtZ5rQxswtmX86ErXJ80nELzLe57n4cCQ3
   K0cAAvfFwdf9qmS2OYWEc+3Zei9ZdAeiuLCUj2ci6fNcFwGDKsqV5wnol
   tI2WOV/Uigc1Dl1il081qPgSTi0Wl5LHYF4c8UZqKLXmk7kGdmhzwK+gg
   e8f0/8nbiVQtIARKLUIbXW/mmgtuGsW2LlXT7LYWvjDxTtxE2deXesnzk
   W0CzlEmJYjvDZYSyK6OSDrN1HmeVaZPdKenTvY8yYuyegfTFdq0MqDnn9
   Q==;
X-IronPort-AV: E=Sophos;i="5.68,300,1569283200"; 
   d="scan'208";a="35447288"
IronPort-PHdr: =?us-ascii?q?9a23=3ApdBRtxD30w9bHY1lAeyRUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPTzosbcNUDSrc9gkEXOFd2Cra4d0KyP6PmrBT1IyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQjfq8UajoRvJ6IswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwIOSQ58GXKgcJuiqxVrg+qqxhmz4LKZIyZMfxzdb7fc9wHX2?=
 =?us-ascii?q?pMRttfWTJPAo28bIUBAeQOMulaoIbhqFUDtge+CAq2Ce/z1jNFiH370Ksn2O?=
 =?us-ascii?q?ohCwHG2wkgEsoTvnTIstr1LKcSXv6zzKLV0DvDaulZ2TP56IfWchEqvPaBXa?=
 =?us-ascii?q?ltfsrK0kQvCwPEgUmQqYziJT+V0P8NvHKB4+pvUuKvlXcqpgdsqTas3schkp?=
 =?us-ascii?q?TFi40ax1ze9Sh13Zw5KcO3RUJle9KoDZ1dvDyAOYRsWMMtWWRotT4/yr0BpJ?=
 =?us-ascii?q?G0YjAHyI8ixx7Dc/yHdJWI4g77WOaRPzh4gHVldaqjhxmo60igy/D8VtKu3F?=
 =?us-ascii?q?ZWritKjtnMtncX2xzV9seHUedy8l2k2TaO0wDf8uBEIUYqmqrHM5Mt37E9m5?=
 =?us-ascii?q?UJvUnDAyP6glv6gaCIekk+5+Sk8+Hnba/npp+YOY90kAb+MqE2l8ykHOs4KR?=
 =?us-ascii?q?MDX3Sb+Oug1L3j+lf1QLNRjvIsiKXZv5faJdoDqq6jHwBVypoj6wq4Dzq+09?=
 =?us-ascii?q?QYmn8HLF1edx2djojmJ1HOIO3iAve5mFmskCpryOrIP7L/A5XBNGTMkLDkfb?=
 =?us-ascii?q?xl8U5T1BIzzcxD55JTErwBO+z8WkvwtNzeEx84PBe5w/joCNpjzIMSQ2GPDb?=
 =?us-ascii?q?GDMKPUr1CI4vgjI+6WZI8a637BLK0m4Pjhh3Y4kl8AdK/hiZgQbn+yF/VtI1?=
 =?us-ascii?q?iQZ1Lsn94eHGZMtQ07GqiiwkaPVT9VemaaQa0x/Hc4BZigAIOFQZqiyvTVxy?=
 =?us-ascii?q?q/H5tLdkhYBV2WV3TlbYOJX7ELci3EceF7lTlRbqSsU48s01mVsQb+z7d2Zr?=
 =?us-ascii?q?7P9jYwqYPo1N8z4fba0x4162onXIymz2iRQjQszSszTDgs0fU6+x1w?=
X-IPAS-Result: =?us-ascii?q?A2DtAgB6AMxd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0LIFAATIqhCmPC1QGgREliWaRQwkBAQEBAQEBAQE0AQIBAYRAAoIgJ?=
 =?us-ascii?q?DgTAg4BAQEEAQEBAQEFAwEBbIVDgjspgm0BAQEBAyMECwEFUQkCFQMCAiMDA?=
 =?us-ascii?q?gJGEQYBDAYCAQGCXz+CUyWUEZp9dX8zhU6DO4FIgQ4ojBQYeIEHgTgMgioHL?=
 =?us-ascii?q?j6HVYJeBI0iiE6BJpZ/gjKCNooGiQUGG5l+jkecDSKBWCsIAhgIIQ+DJ1ARF?=
 =?us-ascii?q?JEjAxeOQSMDMIEFAQGQXAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Nov 2019 13:13:11 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xADDDAtn007006;
        Wed, 13 Nov 2019 08:13:10 -0500
Subject: Re: [PATCH] restorecond: Fix redundant console log output error
To:     kongbaichuan <kongbaichuan@huawei.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
References: <20191112012328.2314-1-kongbaichuan@huawei.com>
 <fac0b04d-7d96-eedd-c083-31bc9b00597f@tycho.nsa.gov>
 <acce2e1f-1deb-7a4a-9fca-6cc6c0a71c70@tycho.nsa.gov>
 <29DB54BD44962C418560B9F4D8E964C41B2BDCF9@DGGEML522-MBX.china.huawei.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <283867b7-3495-2ba8-ff4b-d73cf0183396@tycho.nsa.gov>
Date:   Wed, 13 Nov 2019 08:13:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <29DB54BD44962C418560B9F4D8E964C41B2BDCF9@DGGEML522-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/19 1:36 AM, kongbaichuan wrote:
> The situation in policycoreutils/setfiles is different with restorecond.
> Two same-name varibales r_opts in policycoreutils/setfiles is not effected with each other,
> so it is not necessary to fix.

I understand it isn't a problem in practice right now, but it is a 
maintainability issue; it can create confusion in the future and if 
someone were to ever change the one instance to be non-static in order 
to access it from another source file, we would have exactly the same 
bug.  Hence, I would favor fixing it now.

> 
> 
> -----邮件原件-----
> 发件人: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> 发送时间: 2019年11月12日 23:55
> 收件人: kongbaichuan <kongbaichuan@huawei.com>; selinux@vger.kernel.org
> 主题: Re: [PATCH] restorecond: Fix redundant console log output error
> 
> On 11/12/19 10:47 AM, Stephen Smalley wrote:
>> On 11/11/19 8:23 PM, Baichuan Kong wrote:
>>> From: kong baichuan <kongbaichuan@huawei.com>
>>>
>>> When starting restorecond without any option the following redundant
>>> console log is outputed:
>>>
>>> /dev/log 100.0%
>>> /var/volatile/run/syslogd.pid 100.0%
>>> ...
>>>
>>> This is caused by two global variables of same name r_opts. When
>>> executes r_opts = opts in restore_init(), it originally intends to
>>> assign the address of struct r_opts in "restorecond.c" to the pointer
>>> *r_opts in "restore.c".
>>>
>>> However, the address is assigned to the struct r_opts and covers the
>>> value of low eight bytes in it. That causes unexpected value of
>>> member varibale 'nochange' and 'verbose' in struct r_opts, thus
>>> affects value of 'restorecon_flags' and executes unexpected
>>> operations when restorecon the files such as the redundant console
>>> log output or file label nochange.
>>>
>>> Signed-off-by: kong baichuan <kongbaichuan@huawei.com>
>>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
> NB restore.c in restorecond was copied from policycoreutils/setfiles, which shares this same pattern, except that the separate r_opts declaration in setfiles.c is static.  We should likely fix it for setfiles as well.
> 
>>
>>> ---
>>>    restorecond/restore.c | 40 ++++++++++++++++++----------------------
>>>    1 file changed, 18 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/restorecond/restore.c b/restorecond/restore.c
>>> index f6e30001..b93b5fdb 100644
>>> --- a/restorecond/restore.c
>>> +++ b/restorecond/restore.c
>>> @@ -12,39 +12,36 @@
>>>    char **exclude_list;
>>>    int exclude_count;
>>> -struct restore_opts *r_opts;
>>> -
>>>    void restore_init(struct restore_opts *opts)
>>>    {
>>>        int rc;
>>> -    r_opts = opts;
>>>        struct selinux_opt selinux_opts[] = {
>>> -        { SELABEL_OPT_VALIDATE, r_opts->selabel_opt_validate },
>>> -        { SELABEL_OPT_PATH, r_opts->selabel_opt_path },
>>> -        { SELABEL_OPT_DIGEST, r_opts->selabel_opt_digest }
>>> +        { SELABEL_OPT_VALIDATE, opts->selabel_opt_validate },
>>> +        { SELABEL_OPT_PATH, opts->selabel_opt_path },
>>> +        { SELABEL_OPT_DIGEST, opts->selabel_opt_digest }
>>>        };
>>> -    r_opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
>>> -    if (!r_opts->hnd) {
>>> -        perror(r_opts->selabel_opt_path);
>>> +    opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
>>> +    if (!opts->hnd) {
>>> +        perror(opts->selabel_opt_path);
>>>            exit(1);
>>>        }
>>> -    r_opts->restorecon_flags = 0;
>>> -    r_opts->restorecon_flags = r_opts->nochange | r_opts->verbose |
>>> -               r_opts->progress | r_opts->set_specctx  |
>>> -               r_opts->add_assoc | r_opts->ignore_digest |
>>> -               r_opts->recurse | r_opts->userealpath |
>>> -               r_opts->xdev | r_opts->abort_on_error |
>>> -               r_opts->syslog_changes | r_opts->log_matches |
>>> -               r_opts->ignore_noent | r_opts->ignore_mounts;
>>> +    opts->restorecon_flags = 0;
>>> +    opts->restorecon_flags = opts->nochange | opts->verbose |
>>> +               opts->progress | opts->set_specctx  |
>>> +               opts->add_assoc | opts->ignore_digest |
>>> +               opts->recurse | opts->userealpath |
>>> +               opts->xdev | opts->abort_on_error |
>>> +               opts->syslog_changes | opts->log_matches |
>>> +               opts->ignore_noent | opts->ignore_mounts;
>>>        /* Use setfiles, restorecon and restorecond own handles */
>>> -    selinux_restorecon_set_sehandle(r_opts->hnd);
>>> +    selinux_restorecon_set_sehandle(opts->hnd);
>>> -    if (r_opts->rootpath) {
>>> -        rc = selinux_restorecon_set_alt_rootpath(r_opts->rootpath);
>>> +    if (opts->rootpath) {
>>> +        rc = selinux_restorecon_set_alt_rootpath(opts->rootpath);
>>>            if (rc) {
>>>                fprintf(stderr,
>>>                    "selinux_restorecon_set_alt_rootpath error: %s.\n",
>>> @@ -75,7 +72,6 @@ int process_glob(char *name, struct restore_opts *opts)
>>>        size_t i = 0;
>>>        int len, rc, errors;
>>> -    r_opts = opts;
>>>        memset(&globbuf, 0, sizeof(globbuf));
>>>        errors = glob(name, GLOB_TILDE | GLOB_PERIOD |
>>> @@ -90,7 +86,7 @@ int process_glob(char *name, struct restore_opts *opts)
>>>            if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
>>>                continue;
>>>            rc = selinux_restorecon(globbuf.gl_pathv[i],
>>> -                    r_opts->restorecon_flags);
>>> +                    opts->restorecon_flags);
>>>            if (rc < 0)
>>>                errors = rc;
>>>        }
>>>
>>
> 

