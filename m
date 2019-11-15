Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9071C432C3
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965822073A
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 13:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YeIktHRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKONNA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:13:00 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:42582 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKONNA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 08:13:00 -0500
X-EEMSG-check-017: 27072883|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,308,1569283200"; 
   d="scan'208";a="27072883"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Nov 2019 13:12:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573823578; x=1605359578;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=DTODfvcEzBcQ70bjTVmGA8Z2PDuHLx3pIbMx9mNapg8=;
  b=YeIktHRhhT3YDp+I4GJnYKf/t4Q5NH3l+ntZ9I7lWUd89LpqrzJENhny
   NASjCYuHwT8lqGMwAejyYQLkvet8ECYv9Oroe54kDYehhDYSZxe1Ox5MV
   lFY/pdYUBiJcywp5bGSYhdG1PCNmF9Y8QolHac+1r156FXqGsKec590Wl
   m7H720dZJyeOmWKT3XIAQWJwwBi+HBIymenD15qNnfCCxmzhlH2LI9NKB
   c5mIzTKkVfhUOc8UTyzsmvzy2dio8wFQUW9qXZ7wmM1QgzK8d8kmnyZWN
   xjw+OjDDvFlAJgtmHOE8PwMrm6A6CFj2F9eDowK4Zb9a1XWATQZYJhpr5
   g==;
X-IronPort-AV: E=Sophos;i="5.68,308,1569283200"; 
   d="scan'208";a="30146795"
IronPort-PHdr: =?us-ascii?q?9a23=3AfsAX/BFX7kdBV6RcGL5+tJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zrsWwAkXT6L1XgUPTWs2DsrQY0rGQ6vu9EjBfqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmssAncuMkbjYRtJ6sz1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovER/I3AIjEdwAvnvbo9f6O7sdX+2u0KnFzi/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTWJwuCsi17ELtp?=
 =?us-ascii?q?G2cDIKxZg63RLTdfOKf5aS7h7+UuuaPC12i2h/eL2lgha/6U2gyurhWcaqyF?=
 =?us-ascii?q?tKtS9FksXUtnAKyhzT9tCLSvtj8Uel3jaCzxzT5fteIUA1iKrbMIQtwqIwl5?=
 =?us-ascii?q?UPsUTDGTX6mEPqg6+Nakoo4O2o6+XjYrn+p5+cMZF7ih3mP6gzlcGyDv40Pw?=
 =?us-ascii?q?gTU2SB5+ix26Pv8VfkTLlSi/05iKjZsJTUJcQBoa65BhdY0p0+5BakFDqmzN?=
 =?us-ascii?q?QZkmUHLFJCYh6HiZPpNEvULPD3Cve/nUygkC13yPDeIr3hHpLNI2DAkLfme7?=
 =?us-ascii?q?Z95FVTxxAyzd9D55JUF6sOIPToV0/xqdzXFBE4PBK1w+r9FNp90YYeU3qVAq?=
 =?us-ascii?q?CFKKPSrUOI5uU3LumXeoAVvDf9K/445//hlnI5h1Adcrez3ZcNa3C3AO5mI0?=
 =?us-ascii?q?OHbnromNsBFn0KvgVtBNDt3XeLUDVTen+0F4E74D5zXIGhC4jJT4GmgKGI2g?=
 =?us-ascii?q?+7A5RJa2EAAVeJRzOgbIiAWvEReAqMLcJ71D8JT76sT8kmzx79mhX9zu9cMu?=
 =?us-ascii?q?fM+iAe/anm3dxx6vybwQo+7hRoHs+d1CeLVGgykWQWEWxllJtjqFBwnw/QmZ?=
 =?us-ascii?q?NzhOZVQJkKvKJE?=
X-IPAS-Result: =?us-ascii?q?A2CwAAC+o85d/wHyM5BkGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXQsgUEyKoQpjwlRAQEBBoE2iWaRQwkBAQEBAQEBAQE0AQIBA?=
 =?us-ascii?q?YRAAoIjJDgTAg4BAQEEAQEBAQEFAwEBbIVDgjspAYJtAQUjBAsBBVEJAhgCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgl8/glMlk3abc38ziQ2BSIEOKIwVGHiBB4E4gj0uPodVg?=
 =?us-ascii?q?l4EjSSIU4EnlweCNII3kxAGG5oOjkicGSKBWCsIAhgIIQ+DJ1ARFJEjAxeOQ?=
 =?us-ascii?q?SMDMIEFAQGQXwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Nov 2019 13:12:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAFDCuf6004013;
        Fri, 15 Nov 2019 08:12:56 -0500
Subject: Re: [PATCH] restorecond: Fix redundant console log output error
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Baichuan Kong <kongbaichuan@huawei.com>, selinux@vger.kernel.org
References: <20191114024807.2371-1-kongbaichuan@huawei.com>
 <8a0e3293-db20-e0b0-603a-40fb3c6c4e04@tycho.nsa.gov>
Message-ID: <6eacd855-d59a-bfe7-2b80-2d5267d3b512@tycho.nsa.gov>
Date:   Fri, 15 Nov 2019 08:12:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <8a0e3293-db20-e0b0-603a-40fb3c6c4e04@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/14/19 10:18 AM, Stephen Smalley wrote:
> On 11/13/19 9:48 PM, Baichuan Kong wrote:
>> When starting restorecond without any option the following redundant
>> console log is outputed:
>>
>> /dev/log 100.0%
>> /var/volatile/run/syslogd.pid 100.0%
>> ...
>>
>> This is caused by two global variables of same name r_opts. When
>> executes r_opts = opts in restore_init(), it originally intends
>> to assign the address of struct r_opts in "restorecond.c" to the
>> pointer *r_opts in "restore.c".
>>
>> However, the address is assigned to the struct r_opts and covers
>> the value of low eight bytes in it. That causes unexpected value
>> of member varibale 'nochange' and 'verbose' in struct r_opts, thus
>> affects value of 'restorecon_flags' and executes unexpected operations
>> when restorecon the files such as the redundant console log output or
>> file label nochange.
>>
>> Cause restorecond/restore.c is copied from policycoreutils/setfiles,
>> which share the same pattern. It also has potential risk to generate
>> same problems, So fix it in case.
>>
>> Signed-off-by: Baichuan Kong <kongbaichuan@huawei.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks, applied.

> 
>> ---
>>   policycoreutils/setfiles/restore.c | 42 
>> +++++++++++++++++---------------------
>>   restorecond/restore.c              | 40 
>> ++++++++++++++++--------------------
>>   2 files changed, 37 insertions(+), 45 deletions(-)
>>
>> diff --git a/policycoreutils/setfiles/restore.c 
>> b/policycoreutils/setfiles/restore.c
>> index 9dea5656..d3335d1a 100644
>> --- a/policycoreutils/setfiles/restore.c
>> +++ b/policycoreutils/setfiles/restore.c
>> @@ -17,40 +17,37 @@
>>   char **exclude_list;
>>   int exclude_count;
>> -struct restore_opts *r_opts;
>> -
>>   void restore_init(struct restore_opts *opts)
>>   {
>>       int rc;
>> -    r_opts = opts;
>>       struct selinux_opt selinux_opts[] = {
>> -        { SELABEL_OPT_VALIDATE, r_opts->selabel_opt_validate },
>> -        { SELABEL_OPT_PATH, r_opts->selabel_opt_path },
>> -        { SELABEL_OPT_DIGEST, r_opts->selabel_opt_digest }
>> +        { SELABEL_OPT_VALIDATE, opts->selabel_opt_validate },
>> +        { SELABEL_OPT_PATH, opts->selabel_opt_path },
>> +        { SELABEL_OPT_DIGEST, opts->selabel_opt_digest }
>>       };
>> -    r_opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
>> -    if (!r_opts->hnd) {
>> -        perror(r_opts->selabel_opt_path);
>> +    opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
>> +    if (!opts->hnd) {
>> +        perror(opts->selabel_opt_path);
>>           exit(1);
>>       }
>> -    r_opts->restorecon_flags = 0;
>> -    r_opts->restorecon_flags = r_opts->nochange | r_opts->verbose |
>> -               r_opts->progress | r_opts->set_specctx  |
>> -               r_opts->add_assoc | r_opts->ignore_digest |
>> -               r_opts->recurse | r_opts->userealpath |
>> -               r_opts->xdev | r_opts->abort_on_error |
>> -               r_opts->syslog_changes | r_opts->log_matches |
>> -               r_opts->ignore_noent | r_opts->ignore_mounts |
>> -               r_opts->mass_relabel;
>> +    opts->restorecon_flags = 0;
>> +    opts->restorecon_flags = opts->nochange | opts->verbose |
>> +               opts->progress | opts->set_specctx  |
>> +               opts->add_assoc | opts->ignore_digest |
>> +               opts->recurse | opts->userealpath |
>> +               opts->xdev | opts->abort_on_error |
>> +               opts->syslog_changes | opts->log_matches |
>> +               opts->ignore_noent | opts->ignore_mounts |
>> +               opts->mass_relabel;
>>       /* Use setfiles, restorecon and restorecond own handles */
>> -    selinux_restorecon_set_sehandle(r_opts->hnd);
>> +    selinux_restorecon_set_sehandle(opts->hnd);
>> -    if (r_opts->rootpath) {
>> -        rc = selinux_restorecon_set_alt_rootpath(r_opts->rootpath);
>> +    if (opts->rootpath) {
>> +        rc = selinux_restorecon_set_alt_rootpath(opts->rootpath);
>>           if (rc) {
>>               fprintf(stderr,
>>                   "selinux_restorecon_set_alt_rootpath error: %s.\n",
>> @@ -81,7 +78,6 @@ int process_glob(char *name, struct restore_opts *opts)
>>       size_t i = 0;
>>       int len, rc, errors;
>> -    r_opts = opts;
>>       memset(&globbuf, 0, sizeof(globbuf));
>>       errors = glob(name, GLOB_TILDE | GLOB_PERIOD |
>> @@ -96,7 +92,7 @@ int process_glob(char *name, struct restore_opts *opts)
>>           if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
>>               continue;
>>           rc = selinux_restorecon(globbuf.gl_pathv[i],
>> -                    r_opts->restorecon_flags);
>> +                    opts->restorecon_flags);
>>           if (rc < 0)
>>               errors = rc;
>>       }
>> diff --git a/restorecond/restore.c b/restorecond/restore.c
>> index f6e30001..b93b5fdb 100644
>> --- a/restorecond/restore.c
>> +++ b/restorecond/restore.c
>> @@ -12,39 +12,36 @@
>>   char **exclude_list;
>>   int exclude_count;
>> -struct restore_opts *r_opts;
>> -
>>   void restore_init(struct restore_opts *opts)
>>   {
>>       int rc;
>> -    r_opts = opts;
>>       struct selinux_opt selinux_opts[] = {
>> -        { SELABEL_OPT_VALIDATE, r_opts->selabel_opt_validate },
>> -        { SELABEL_OPT_PATH, r_opts->selabel_opt_path },
>> -        { SELABEL_OPT_DIGEST, r_opts->selabel_opt_digest }
>> +        { SELABEL_OPT_VALIDATE, opts->selabel_opt_validate },
>> +        { SELABEL_OPT_PATH, opts->selabel_opt_path },
>> +        { SELABEL_OPT_DIGEST, opts->selabel_opt_digest }
>>       };
>> -    r_opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
>> -    if (!r_opts->hnd) {
>> -        perror(r_opts->selabel_opt_path);
>> +    opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
>> +    if (!opts->hnd) {
>> +        perror(opts->selabel_opt_path);
>>           exit(1);
>>       }
>> -    r_opts->restorecon_flags = 0;
>> -    r_opts->restorecon_flags = r_opts->nochange | r_opts->verbose |
>> -               r_opts->progress | r_opts->set_specctx  |
>> -               r_opts->add_assoc | r_opts->ignore_digest |
>> -               r_opts->recurse | r_opts->userealpath |
>> -               r_opts->xdev | r_opts->abort_on_error |
>> -               r_opts->syslog_changes | r_opts->log_matches |
>> -               r_opts->ignore_noent | r_opts->ignore_mounts;
>> +    opts->restorecon_flags = 0;
>> +    opts->restorecon_flags = opts->nochange | opts->verbose |
>> +               opts->progress | opts->set_specctx  |
>> +               opts->add_assoc | opts->ignore_digest |
>> +               opts->recurse | opts->userealpath |
>> +               opts->xdev | opts->abort_on_error |
>> +               opts->syslog_changes | opts->log_matches |
>> +               opts->ignore_noent | opts->ignore_mounts;
>>       /* Use setfiles, restorecon and restorecond own handles */
>> -    selinux_restorecon_set_sehandle(r_opts->hnd);
>> +    selinux_restorecon_set_sehandle(opts->hnd);
>> -    if (r_opts->rootpath) {
>> -        rc = selinux_restorecon_set_alt_rootpath(r_opts->rootpath);
>> +    if (opts->rootpath) {
>> +        rc = selinux_restorecon_set_alt_rootpath(opts->rootpath);
>>           if (rc) {
>>               fprintf(stderr,
>>                   "selinux_restorecon_set_alt_rootpath error: %s.\n",
>> @@ -75,7 +72,6 @@ int process_glob(char *name, struct restore_opts *opts)
>>       size_t i = 0;
>>       int len, rc, errors;
>> -    r_opts = opts;
>>       memset(&globbuf, 0, sizeof(globbuf));
>>       errors = glob(name, GLOB_TILDE | GLOB_PERIOD |
>> @@ -90,7 +86,7 @@ int process_glob(char *name, struct restore_opts *opts)
>>           if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
>>               continue;
>>           rc = selinux_restorecon(globbuf.gl_pathv[i],
>> -                    r_opts->restorecon_flags);
>> +                    opts->restorecon_flags);
>>           if (rc < 0)
>>               errors = rc;
>>       }
>>
> 

