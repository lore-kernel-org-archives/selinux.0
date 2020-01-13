Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCD7C33CAD
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 14:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4830D20678
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 14:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="lQmyGTTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgAMOGc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:06:32 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:53547 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAMOGb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 09:06:31 -0500
X-EEMSG-check-017: 45011205|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="45011205"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jan 2020 14:06:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578924388; x=1610460388;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nnwZoX5fd8JsOkx+NO8Orr2SqRbKXC7WAtK0fsmIlPs=;
  b=lQmyGTTnI2Bl6WaHYkwAj4stjbbxnyllz3e7LNJRCeVbeOp7sVdlpDr6
   vDQXXK+rOLnXVAnqmmbRmG2NLcsXBn1AwnQCjnbhl7REyBMAsIV0Rf0d2
   bnxt6kO5CZRRQsM/w40rKV7RH9pNnIu34Xkz8N3mPKjYgUkHpf3wGtDc3
   ZKWKxSJLSfF3uJjkgPVLHHm//fhkJXN92b60o5y8L4EryjKILHGipXMbF
   gNbggmh0resNUh6J0JkPa8636nme49H/lM0fQDjc3HVAJA/59bHvw+kkN
   9Zj7bcNfMkK7VWYJX6I3HtulgV+8dJbY5MYqigUTDUcE0y6DaM6CCMsNN
   A==;
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="37678688"
IronPort-PHdr: =?us-ascii?q?9a23=3ADFBv3RH5xIVSYB02FpS/np1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p8iybnLW6fgltlLVR4KTs6sC17ON9fq/ASddsd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txvdu8sKjYdtKqs8yQ?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHwHY0gwuHNwAvnrbo9r3O6gOXu6417XIwDbZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9roCY30qAKtJ?=
 =?us-ascii?q?G0cSQQyJkr2gTTZ+KIfoSW+B7vSeCcKipiin1/YrKwnROy/FClyu37S8a7zk?=
 =?us-ascii?q?5HrjFAktnQrnAN0AHT6tSfRvt94Eih3TGP2hjP6u5eO0A0lLfbK4U7zr4xkJ?=
 =?us-ascii?q?oTv0PDHjTol0rqlqOWakUl9fSo6+TgeLnmoIOTN5RohQ3kN6Qum8i/Dfw5Mg?=
 =?us-ascii?q?gIQWeb5fyx2KDs8ED2WrlHjuA6nrPHvJ3VO8gXvLO1DxdQ0ok56ha/Czmm0M?=
 =?us-ascii?q?4fnXkCNF9FYw+Ij5PyNlHSIPH3Efe/g1O2nDdt3PDJJKftAprKLnjdiLvhZ6?=
 =?us-ascii?q?py61ZAyAovytBS/4hUCrAdL/LzQEDxrsHXAQclPAOsw+boEtR91oUAVmKUGa?=
 =?us-ascii?q?KWK7/SsV6O5uIzPeaMfokVtyjhK/Q/+/Huino5k0cHfaa1xZsXdGy4HvN+Lk?=
 =?us-ascii?q?WCf3XshtYBEWEXvgsxV+HqllKCXiBJZ3qoXKIz+Cs7CIS4AofHXIyth6aB3C?=
 =?us-ascii?q?ijFJ1Mem9GEkyMEWvvd4icXPcMbSWSItRnkjMeSbeuVZQs1QuwuwDny7poNP?=
 =?us-ascii?q?bU9jcEupLk0dh///fTmg0q9TxoE8Sd1HmAT3lukWMVQz87x7h/rlZgyleHyK?=
 =?us-ascii?q?R4hvtYFdtJ5/xXSAs1KZncz+kpQ+z1DzjAddeAUlruYtynBzwqBoYrwtQOal?=
 =?us-ascii?q?xxLN6VjhnC2SexK7UJlrqXCYYy/76a1H/0cYI10HvC1a88n3E4TcZVc26rnK?=
 =?us-ascii?q?hy807UHYGavV+ekvORaakE3CPLvFyGxG6KsVAQBBV8So3ZTHsfYQ3Qtt2/6U?=
 =?us-ascii?q?TcGez9QY87OxdMnJbRYpBBbcfk2BAfH6bu?=
X-IPAS-Result: =?us-ascii?q?A2AmBAA7eBxe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASASKoQMiQOGawaBEiWJbo9hgWcJAQEBAQEBAQEBNwEBhEACghw4EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQLAQU2CxAJAhgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgmM/gksDCSWNMJt0fzOJF4E9gQ4ojDN5gQeBOAwDgl0+ghuCFoMogjwiB?=
 =?us-ascii?q?Jdrl1GCQYJIk18GG4JHjEWLYI5bgUmbPiKBWCsIAhgIIQ+DJ1AYDYkoAQeNN?=
 =?us-ascii?q?SMDMIpbLIIXAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Jan 2020 14:06:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00DE5jgZ245703;
        Mon, 13 Jan 2020 09:05:50 -0500
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add filesystem tests
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com, Paul Moore <paul@paul-moore.com>
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
 <20200109150709.360345-2-richard_c_haines@btinternet.com>
 <aa333bd1-9fd8-b4a4-eba2-aa8d722cbc7e@tycho.nsa.gov>
 <f2cebe3fcb2960a2b51638d457ae07781896a12c.camel@btinternet.com>
 <c2cc9f48-4dd3-cdf4-8c4e-3575ffc05aaf@tycho.nsa.gov>
 <f863a91987c1926a4351f3edf968c9003197fead.camel@btinternet.com>
 <956ad05b-9b1e-9d0b-75d1-02b02858a835@tycho.nsa.gov>
Message-ID: <c3b50363-8307-0dcf-d8b4-ce2d4cc7563c@tycho.nsa.gov>
Date:   Mon, 13 Jan 2020 09:07:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <956ad05b-9b1e-9d0b-75d1-02b02858a835@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/13/20 8:52 AM, Stephen Smalley wrote:
> On 1/12/20 11:04 AM, Richard Haines wrote:
>> On Fri, 2020-01-10 at 13:18 -0500, Stephen Smalley wrote:
>>> On 1/10/20 1:09 PM, Richard Haines wrote:
>>>> On Thu, 2020-01-09 at 12:19 -0500, Stephen Smalley wrote:
>>>>> On 1/9/20 10:07 AM, Richard Haines wrote:
>>>>>> Test filesystem permissions and setfscreatecon(3).
>>>>>>
>>>>>>    From kernels 5.5 filesystem { watch } is also tested.
>>>>>>
>>>>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>>>>> ---
>>>>>> diff --git a/policy/test_filesystem.te
>>>>>> b/policy/test_filesystem.te
>>>>>> new file mode 100644
>>>>>> index 0000000..2eee1fc
>>>>>> --- /dev/null
>>>>>> +++ b/policy/test_filesystem.te
>>>>>> @@ -0,0 +1,324 @@
>>>>>> +#
>>>>>> +######### Test filesystem permissions policy module ##########
>>>>>> +#
>>>>>> +attribute filesystemdomain;
>>>>>> +
>>>>>> +#################### Create a test file context
>>>>>> ######################
>>>>>> +type test_filesystem_filecon_t;
>>>>>> +unconfined_runs_test(test_filesystem_filecon_t)
>>>>>> +
>>>>>> +################# Test all functions
>>>>>> ##########################
>>>>>> +type test_filesystem_t;
>>>>>> +domain_type(test_filesystem_t)
>>>>>> +unconfined_runs_test(test_filesystem_t)
>>>>>> +typeattribute test_filesystem_t testdomain;
>>>>>> +typeattribute test_filesystem_t filesystemdomain;
>>>>>> +
>>>>>> +allow test_filesystem_t self:capability { sys_admin };
>>>>>> +allow test_filesystem_t self:filesystem { mount remount
>>>>>> quotamod
>>>>>> relabelfrom relabelto unmount quotaget };
>>>>>> +allow test_filesystem_t self:dir { mounton add_name write };
>>>>>> +allow test_filesystem_t test_file_t:dir { mounton write
>>>>>> remove_name rmdir };
>>>>>> +# Create test file
>>>>>> +allow test_filesystem_t self:dir { add_name write };
>>>>>> +allow test_filesystem_t self:file { create relabelfrom
>>>>>> relabelto
>>>>>> };
>>>>>> +
>>>>>> +fs_mount_all_fs(test_filesystem_t)
>>>>>> +fs_remount_all_fs(test_filesystem_t)
>>>>>> +fs_unmount_all_fs(test_filesystem_t)
>>>>>> +fs_relabelfrom_all_fs(test_filesystem_t)
>>>>>> +fs_get_xattr_fs_quotas(test_filesystem_t)
>>>>>> +files_search_all(test_filesystem_t)
>>>>>> +# Required for mount opts
>>>>>> "rootcontext=system_u:object_r:test_filesystem_t:s0";
>>>>>> +fs_associate(test_filesystem_t)
>>>>>> +fs_getattr_xattr_fs(test_filesystem_t)
>>>>>> +
>>>>>> +# For running quotacheck(8)
>>>>>> +files_type(test_filesystem_t)
>>>>>> +# Update quotas
>>>>>> +fs_set_all_quotas(test_filesystem_t)
>>>>>> +allow test_filesystem_t self:file { quotaon };
>>>>>> +# Create test file and change context:
>>>>>> +fs_associate(test_filesystem_filecon_t)
>>>>>> +allow test_filesystem_t test_filesystem_filecon_t:file { open
>>>>>> read
>>>>>> getattr relabelto write };
>>>>>> +dontaudit test_filesystem_t kernel_t:process { setsched };
>>>>>
>>>>> Why do you need these dontaudit statements?  It seems like a
>>>>> kernel
>>>>> bug
>>>>> if something is triggering a setsched permission check on the
>>>>> kernel_t
>>>>> domain?  Something the kernel module is doing during
>>>>> initialization?
>>>>>
>>>>
>>>> I've tracked this down to them all being called from block/ioprio.c
>>>> with: security_task_setioprio(task, ioprio) ->
>>>> selinux_task_setioprio
>>>>
>>>> Why the SECCLASS_PROCESS, PROCESS__SETSCHED I've no idea. The
>>>> following
>>>> also use SET/GETSCHED permission:
>>>>
>>>> selinux_task_getioprio, selinux_task_setnice,
>>>> selinux_task_movememory
>>>
>>> The confusing bit is that it is between test_filesystem_t and
>>> kernel_t.
>>> If the process was setting its own ioprio, then I'd expect to see
>>> the
>>> denial between test_filesystem_t and test_filesystem_t aka self.  If
>>> the
>>> process inserted a kernel module and the module initializer spawned
>>> a
>>> kernel thread that set its ioprio, I would expect it to be kernel_t
>>> to
>>> kernel_t.
>>
>> Some more info on who calls set_task_ioprio:
>>
>> fs/ext4/super.c calls 'set_task_ioprio' in two places using:
>>      set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
>> The return codes are not checked. This code was added 11 years ago.
>>
>> fs/btrfs/reada.c also calls 'set_task_ioprio' in two places using:
>>      set_task_ioprio(current, BTRFS_IOPRIO_READA);
>> The return codes are not checked.
>>
>> As can be seen the ext4 module does not use 'current'. I have patched
>> kernel 5.5-rc5 to use 'current' and it now works as you expected. Also
>> the kernel_t:process { setsched } rules can be removed.
>> As the problem will exist for some time, I've added to the test policy:
>>      kernel_dontaudit_setsched(filesystemdomain)
>>
>> It appears that most of the refpolicy modules do the same.
> 
> This seems like a kernel bug to me. I assume that these filesystems 
> expect the I/O priority to be always set in these cases irrespective of 
> the permissions of the current process.  Either they should be using 
> some internal helper function ala a new set_task_ioprio_noperm() that 
> skips permission checking or they should be temporarily overriding their 
> cred to the init cred before doing this.  Probably a topic for 
> linux-fsdevel and/or the respective per-filesystem mailing lists.

Also, looks like kernel_dontaudit_setsched() isn't defined by upstream 
refpolicy so you'll need the usual ifdefery in test_policy.if to allow 
this to build against refpolicy to appease travis-ci.


