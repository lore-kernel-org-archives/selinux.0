Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE916C33CAD
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 13:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78162214AF
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 13:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mzTGuKl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAMNvP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:51:15 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:14070 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgAMNvP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 08:51:15 -0500
X-EEMSG-check-017: 43667429|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="43667429"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jan 2020 13:51:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578923467; x=1610459467;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=huYaCJoecUz88eGf0jPqmvopPNdElLxc7Teo1sM3oJ4=;
  b=mzTGuKl1A0MbDCmDi4APagzSs7E9Xd7RbvkDRvZ5TL4DpMpVbbWhq1lG
   EJMiWsoZIKAC51qZ6nC0xkuNazzFIncoHZrydV0au/cr3seuZeXYebrwv
   7LXoxXrbneZI9ilLWcXI+zl/0ZwCW70h8ZSP691S2Y1Upt7tI0nPhLEPp
   rnEwZ50J2RcvPhXsgkjtlKpiUrYEs0KRi1TkijVRqrWr5AIV3kNNlymBh
   TAiSTUrmH0kFvdvYnUidpyAkz2/bc/ixZ61+CBqkf0JbZhdEGTEqf2M/t
   HcXJRHdD/RwLhrMKe3Gp3lMydaUps0BJHSYaLM8onflRqzmHQcm8eYv9p
   A==;
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="31864671"
IronPort-PHdr: =?us-ascii?q?9a23=3A0Z19kRLIzun7SoK/y9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKvjzrarrMEGX3/hxlliBBdydt6sfzbCJ6+u9AiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngu6oAfNusUZgYZvJLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ54gxL4wmJ?=
 =?us-ascii?q?0TsV/dESDqgkn2kK+XeVkk+uiv8ejnZKnppoSAOINujwH+M6AultS+AeQ+LA?=
 =?us-ascii?q?cOQ3CW9fmz2bDs50H0QKhGguconqTWrpzWP9kXqra8AwBP04Yj7xi/Dy2h0N?=
 =?us-ascii?q?QdhXQHN09KeAmcgoj1O1DBPPD4DfClj1Sqizdk3erKPrLmApXTNnTDiqvufa?=
 =?us-ascii?q?5h605Azwo+1cpf55NIBbEBOv3zQFL+u8TEARAhMwy72efnCNNj2YMFQm+AGb?=
 =?us-ascii?q?OZMKLUsV+U+O0vOe+Ma5EJuDrnN/cl4Pvuh2cjmVABZampwYcXaHegE/R9PU?=
 =?us-ascii?q?qZZXvsgtEcEWYFpQc+UuPqh0OYUTJJZHa9Qbg85jclB4KiF4vDQZqtgLOZ1i?=
 =?us-ascii?q?ehApJWfnxGCkyLEXrwcIWEXvAMaDmUIsB7jjMLS6OsS5U/2h6ztA/10aZnIv?=
 =?us-ascii?q?DI9S0fsJLpzMJ16PHLlREu6Tx0CNyQ03mXQGFpmmMFXCc207pioUx501uD1K?=
 =?us-ascii?q?94g/tCFdNN/f9GTgA6NZuPh9B9XurzUQLIZNvBaF+nRNi9SWUrT9kxysUCVE?=
 =?us-ascii?q?1KG9yjiB3Y9yC2ArkJmqaNCYBy+aXZiTy5PMt5ynDbxIE/gFQ8BMhCL2urgu?=
 =?us-ascii?q?h47QeAKZTOlhCii6uydakalBXI/WOHwHvG6FpUSyZsQK7FWjYZfUKQotPnsB?=
 =?us-ascii?q?CRB4SyAKgqZ1MSgfWJLbFHP5iw1gRL?=
X-IPAS-Result: =?us-ascii?q?A2AEAwBYdBxe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASASKoQMiQOGawaBN4luj2GBZwkBAQEBAQEBAQE3AQGEQAKCHDgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjBBE2CxALGAICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z+CSwMJJakNfzOFSYNPgT2BDiiMM3mBB4E4D4JdPoIbghaDKII8IgSXJUaXU?=
 =?us-ascii?q?YJBgkiTXwYbgkeMRYtgjluBSZs+IoFYKwgCGAghD4MnUBgNiSgBB401IwMwi?=
 =?us-ascii?q?lssghcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Jan 2020 13:51:06 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00DDoSIs238938;
        Mon, 13 Jan 2020 08:50:29 -0500
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com, Paul Moore <paul@paul-moore.com>
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
 <20200109150709.360345-2-richard_c_haines@btinternet.com>
 <aa333bd1-9fd8-b4a4-eba2-aa8d722cbc7e@tycho.nsa.gov>
 <f2cebe3fcb2960a2b51638d457ae07781896a12c.camel@btinternet.com>
 <c2cc9f48-4dd3-cdf4-8c4e-3575ffc05aaf@tycho.nsa.gov>
 <f863a91987c1926a4351f3edf968c9003197fead.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <956ad05b-9b1e-9d0b-75d1-02b02858a835@tycho.nsa.gov>
Date:   Mon, 13 Jan 2020 08:52:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <f863a91987c1926a4351f3edf968c9003197fead.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/12/20 11:04 AM, Richard Haines wrote:
> On Fri, 2020-01-10 at 13:18 -0500, Stephen Smalley wrote:
>> On 1/10/20 1:09 PM, Richard Haines wrote:
>>> On Thu, 2020-01-09 at 12:19 -0500, Stephen Smalley wrote:
>>>> On 1/9/20 10:07 AM, Richard Haines wrote:
>>>>> Test filesystem permissions and setfscreatecon(3).
>>>>>
>>>>>    From kernels 5.5 filesystem { watch } is also tested.
>>>>>
>>>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>>>> ---
>>>>> diff --git a/policy/test_filesystem.te
>>>>> b/policy/test_filesystem.te
>>>>> new file mode 100644
>>>>> index 0000000..2eee1fc
>>>>> --- /dev/null
>>>>> +++ b/policy/test_filesystem.te
>>>>> @@ -0,0 +1,324 @@
>>>>> +#
>>>>> +######### Test filesystem permissions policy module ##########
>>>>> +#
>>>>> +attribute filesystemdomain;
>>>>> +
>>>>> +#################### Create a test file context
>>>>> ######################
>>>>> +type test_filesystem_filecon_t;
>>>>> +unconfined_runs_test(test_filesystem_filecon_t)
>>>>> +
>>>>> +################# Test all functions
>>>>> ##########################
>>>>> +type test_filesystem_t;
>>>>> +domain_type(test_filesystem_t)
>>>>> +unconfined_runs_test(test_filesystem_t)
>>>>> +typeattribute test_filesystem_t testdomain;
>>>>> +typeattribute test_filesystem_t filesystemdomain;
>>>>> +
>>>>> +allow test_filesystem_t self:capability { sys_admin };
>>>>> +allow test_filesystem_t self:filesystem { mount remount
>>>>> quotamod
>>>>> relabelfrom relabelto unmount quotaget };
>>>>> +allow test_filesystem_t self:dir { mounton add_name write };
>>>>> +allow test_filesystem_t test_file_t:dir { mounton write
>>>>> remove_name rmdir };
>>>>> +# Create test file
>>>>> +allow test_filesystem_t self:dir { add_name write };
>>>>> +allow test_filesystem_t self:file { create relabelfrom
>>>>> relabelto
>>>>> };
>>>>> +
>>>>> +fs_mount_all_fs(test_filesystem_t)
>>>>> +fs_remount_all_fs(test_filesystem_t)
>>>>> +fs_unmount_all_fs(test_filesystem_t)
>>>>> +fs_relabelfrom_all_fs(test_filesystem_t)
>>>>> +fs_get_xattr_fs_quotas(test_filesystem_t)
>>>>> +files_search_all(test_filesystem_t)
>>>>> +# Required for mount opts
>>>>> "rootcontext=system_u:object_r:test_filesystem_t:s0";
>>>>> +fs_associate(test_filesystem_t)
>>>>> +fs_getattr_xattr_fs(test_filesystem_t)
>>>>> +
>>>>> +# For running quotacheck(8)
>>>>> +files_type(test_filesystem_t)
>>>>> +# Update quotas
>>>>> +fs_set_all_quotas(test_filesystem_t)
>>>>> +allow test_filesystem_t self:file { quotaon };
>>>>> +# Create test file and change context:
>>>>> +fs_associate(test_filesystem_filecon_t)
>>>>> +allow test_filesystem_t test_filesystem_filecon_t:file { open
>>>>> read
>>>>> getattr relabelto write };
>>>>> +dontaudit test_filesystem_t kernel_t:process { setsched };
>>>>
>>>> Why do you need these dontaudit statements?  It seems like a
>>>> kernel
>>>> bug
>>>> if something is triggering a setsched permission check on the
>>>> kernel_t
>>>> domain?  Something the kernel module is doing during
>>>> initialization?
>>>>
>>>
>>> I've tracked this down to them all being called from block/ioprio.c
>>> with: security_task_setioprio(task, ioprio) ->
>>> selinux_task_setioprio
>>>
>>> Why the SECCLASS_PROCESS, PROCESS__SETSCHED I've no idea. The
>>> following
>>> also use SET/GETSCHED permission:
>>>
>>> selinux_task_getioprio, selinux_task_setnice,
>>> selinux_task_movememory
>>
>> The confusing bit is that it is between test_filesystem_t and
>> kernel_t.
>> If the process was setting its own ioprio, then I'd expect to see
>> the
>> denial between test_filesystem_t and test_filesystem_t aka self.  If
>> the
>> process inserted a kernel module and the module initializer spawned
>> a
>> kernel thread that set its ioprio, I would expect it to be kernel_t
>> to
>> kernel_t.
> 
> Some more info on who calls set_task_ioprio:
> 
> fs/ext4/super.c calls 'set_task_ioprio' in two places using:
>      set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
> The return codes are not checked. This code was added 11 years ago.
> 
> fs/btrfs/reada.c also calls 'set_task_ioprio' in two places using:
>      set_task_ioprio(current, BTRFS_IOPRIO_READA);
> The return codes are not checked.
> 
> As can be seen the ext4 module does not use 'current'. I have patched
> kernel 5.5-rc5 to use 'current' and it now works as you expected. Also
> the kernel_t:process { setsched } rules can be removed.
> As the problem will exist for some time, I've added to the test policy:
>      kernel_dontaudit_setsched(filesystemdomain)
> 
> It appears that most of the refpolicy modules do the same.

This seems like a kernel bug to me. I assume that these filesystems 
expect the I/O priority to be always set in these cases irrespective of 
the permissions of the current process.  Either they should be using 
some internal helper function ala a new set_task_ioprio_noperm() that 
skips permission checking or they should be temporarily overriding their 
cred to the init cred before doing this.  Probably a topic for 
linux-fsdevel and/or the respective per-filesystem mailing lists.
