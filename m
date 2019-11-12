Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D5C43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AD8214E0
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Yayz1jeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKLPyp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:54:45 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:43032 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfKLPyp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 10:54:45 -0500
X-EEMSG-check-017: 49706186|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="49706186"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Nov 2019 15:54:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573574079; x=1605110079;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=xPiurd02g+7XqO1RYnKaRgglsReFc6dFe+F7hH6iBLw=;
  b=Yayz1jeEvv7OLZqtlAU2KwZKq851QBClihl96Z7ya9Uf905zRLblEkJY
   BjhAJsERzbVEXwCsNO4nhvUHeJkOBGoSNNsLv+lGS5Pi/zxfBrtu2A5bS
   J1xecstTWbPJtC/zKXj5DBBFGY5CFOM9026LuX7XFFv8IO+B3f9wjl2vB
   ++cMpynohTVq7pI5egJ28rVVXqh9MHkLXxFP2xBcDVQaREgrxff0Y03tK
   p1as+mynRypUHHMd1l72rLCYXxKIyVTLnMgQOEc1Lh46VObWwjxMfxPzL
   QKtBxUlKLXOHN0VGtKj+ZB3S/Ux7XPpwbFr2nW7NENOM5oQzjGqPr0Xml
   w==;
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="29996001"
IronPort-PHdr: =?us-ascii?q?9a23=3A1EfaPhQHQcggMmGNva1iVyMRP9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6ybR2N2/xhgRfzUJnB7Loc0qyK6vumADZRqsbY+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLq8Uan49vJqkyxx?=
 =?us-ascii?q?fUv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCAeoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/I3BIuH9wNvnraotr6O6UdXvy6wqTT0TXObOlb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lo?=
 =?us-ascii?q?YTsEvfHi/2n1/6jKmKeUU/5uek8eHnYrTippOENo90jB/xMrg2l8CiDuk1PR?=
 =?us-ascii?q?ICUmiG9eimyrHu8lP1TK9XgvEul6nWqpHaJcAVpq6jBA9V154u6w2iADe9y9?=
 =?us-ascii?q?kYgXkGI05FeBKAlYTpPUrOL+riAfewhFSsji9nx+raMb35HpXNMn/Dna/ifb?=
 =?us-ascii?q?Z67U5cxxE8wspe551ICrEBPej8WknqudzYEx82KQK1zPjmCNlnyoweXmePCL?=
 =?us-ascii?q?eDMKzOqV+I+v4vI+6UaY8Opjn9L/kl5/jzjX42glIdY6ap0oUNaHyiHfRpPV?=
 =?us-ascii?q?+ZYXzyjdcFC2sKuRA+TOO5wGGFBBRaZn2yQqs6rhI8Do3uWYTEQI+nib2K3D?=
 =?us-ascii?q?qyGLVWe2lZB1HKGnDtIcHMQPoIaSSPMud/nTEeE7usUYks0VeprgCp5aBgK7?=
 =?us-ascii?q?/v5iAAtZ/lnONw7unXmAB6oSd4FOyBwmqNSCdyhWpOSDgoivMs6Xdhw0uOhP?=
 =?us-ascii?q?Ary8dTEsZesrYQCVY3?=
X-IPAS-Result: =?us-ascii?q?A2DFAABM1Mpd/wHyM5BmGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXQsgUEyKoQpjwRUBoE2iWaRQwkBAQEBAQEBAQE0AQIBAYRAA?=
 =?us-ascii?q?oIdJDgTAg4BAQEEAQEBAQEFAwEBbIVDgjspAYJsAQEBAQMjBAsBBVEJAhUDA?=
 =?us-ascii?q?gImAgJXBgEMBgIBAYJfP4JTJZNMmn11fzOJAoFIgQ4ojBQYeIEHgTiCNgcuP?=
 =?us-ascii?q?odVgl4EjSGIToEmlnuCL4I2kwgGG5l5jkecByKBWCsIAhgIIQ+DJ1ARFJA/A?=
 =?us-ascii?q?xeOQSMDMIEFAQGQVwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Nov 2019 15:54:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xACFsbv1008759;
        Tue, 12 Nov 2019 10:54:37 -0500
Subject: Re: [PATCH] restorecond: Fix redundant console log output error
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Baichuan Kong <kongbaichuan@huawei.com>, selinux@vger.kernel.org
References: <20191112012328.2314-1-kongbaichuan@huawei.com>
 <fac0b04d-7d96-eedd-c083-31bc9b00597f@tycho.nsa.gov>
Message-ID: <acce2e1f-1deb-7a4a-9fca-6cc6c0a71c70@tycho.nsa.gov>
Date:   Tue, 12 Nov 2019 10:54:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <fac0b04d-7d96-eedd-c083-31bc9b00597f@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/12/19 10:47 AM, Stephen Smalley wrote:
> On 11/11/19 8:23 PM, Baichuan Kong wrote:
>> From: kong baichuan <kongbaichuan@huawei.com>
>>
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
>> Signed-off-by: kong baichuan <kongbaichuan@huawei.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

NB restore.c in restorecond was copied from policycoreutils/setfiles, 
which shares this same pattern, except that the separate r_opts 
declaration in setfiles.c is static.  We should likely fix it for 
setfiles as well.

> 
>> ---
>>   restorecond/restore.c | 40 ++++++++++++++++++----------------------
>>   1 file changed, 18 insertions(+), 22 deletions(-)
>>
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

