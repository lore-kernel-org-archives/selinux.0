Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1C3C33CA9
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 18:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579BE207E0
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 18:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="VA/Y8Bd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMSxX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:53:23 -0500
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:40499 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMSxW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 13:53:22 -0500
X-EEMSG-check-017: 65565590|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="65565590"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jan 2020 18:53:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578941590; x=1610477590;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=6yGkTi7qdSgTexdq8IC+sKxC5FoRVSaOWV025mK2sNE=;
  b=VA/Y8Bd0bkfBQDUItiN87IAw59d9526/IAP9bAAfeMOI6y8MvPGcckky
   ruGINV+SniInR2lSeYglTomadbkx4LUeQYRu4a4EqLqHj7SgVJGmFfCIT
   8ZlrL/YvPZek//AEtIsogpsR43hmyGQkfRlgbkWeXEFZMDV26jwVNGb5S
   Md52AfWxeAbnGO8f8iTUipV+4Kp4s3hH/yc1cdzDFzw3Q6cw9o0CIgsH3
   OARC/9EMV98yiilF+8PRlif9OLIpsiWuC3RcYjo95d0+7e6qFekkLvglY
   zIhTFpOXHoFR778kwmRZHeuFOFNLyrINuTzq6pZbR1YgnwMqQQ8icM8i9
   A==;
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="31885861"
IronPort-PHdr: =?us-ascii?q?9a23=3A9y3PqBEAiCma9rR5pojJtJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p8m7bnLW6fgltlLVR4KTs6sC17ON9fq/ASdZuMrJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusQUnYduJbs9xg?=
 =?us-ascii?q?bGr3BVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHAehCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/bwgIgEdIAvnfaotr7O6gdU/y6wqbTwDXfbf5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSU0yqUetJ?=
 =?us-ascii?q?KmcyUHx44ryh7CZ/CdbYSF7QzvWPyMLTp+mXlrYqiwhwyo/kil0uD8U86030?=
 =?us-ascii?q?tUoSddidnMs2wN1wTU6siaVvtx5keh1iiL1wDU8uxEPVo7lbDaK5482b48jJ?=
 =?us-ascii?q?sTsULNHi/xg0X5krOZel84+umo9+vnYrLmqoWaN4BokQHxLr4imsm+AeQ8Kg?=
 =?us-ascii?q?QOXm6b9vqg1LD74EH0T7pHguc2n6XEqpzWO8sWqrCjDwNIyooj7gywDzai0N?=
 =?us-ascii?q?QWh3kHK1dFdQqcj4f0IFHDO+z4DPejjFSslzdn3fbGPqb7DZnXIXjDl6nhca?=
 =?us-ascii?q?5n60FA0Aoz0cxf55VMB7EbIfL8Rk/xu8bCDhAkKwO73/7oCNVn2YMfX2KAHL?=
 =?us-ascii?q?SZPbjJvl+U5+IvJfWMa5EPuDb7Nfcl++TigmM+mV8YZaOpx4cYaGikHvR6JE?=
 =?us-ascii?q?WUeWHsjckFEWcLuAo+UePrhUacUT5ceXmyRbgw5jIlB4K8C4fMWIStjKaG3C?=
 =?us-ascii?q?ehEZ1cfnpGBUyUEXf0a4WEXO8BaCWXIs9miTwEU6KuRJM/2hy1rg/11adoLu?=
 =?us-ascii?q?rO9S0Er57syN915+jLnxEo6TN0F9id032KT2xshmMHXSI23KRkrExl0FiDzK?=
 =?us-ascii?q?x4j+VdFdxU4PNJSBk1OYTAwOx9DtChEj7GK+2IQ1avWNnuITgwSN8qi4sUYk?=
 =?us-ascii?q?19Es+uuRv03yOrBbIOv7aXBZoo/7ja0mS3LMF4nTKOz6Qljl87UuNROmC8wK?=
 =?us-ascii?q?1y7Q7eA8jOiUrKubytcPEnwCPV9GqFhVGLtUVcXR84Bb7JRlgDd0DWqpL//U?=
 =?us-ascii?q?qEQLiwX+d0ejBdwNKPf/MZIubiik9LEbK6Y4XT?=
X-IPAS-Result: =?us-ascii?q?A2CcAgD2uxxe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhAyJA4ZtBoESJYluj2GBZwkBAQEBAQEBAQE3AQGEQAKCHDgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjBBE2CxALGAICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z+CSwMJJasCfzOFSYNRgT2BDiiMM3mBB4E4DAOCXT6CG4IWgyiCPCIElyVGl?=
 =?us-ascii?q?1GCQYJIk18GG4JHjEWLYI5bgUmbPiKBWCsIAhgIIQ+DJ1AYDYkoAQeNNSMDM?=
 =?us-ascii?q?IpcLIIXAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Jan 2020 18:53:09 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00DIqOks123033;
        Mon, 13 Jan 2020 13:52:26 -0500
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
 <956ad05b-9b1e-9d0b-75d1-02b02858a835@tycho.nsa.gov>
 <c3b50363-8307-0dcf-d8b4-ce2d4cc7563c@tycho.nsa.gov>
 <d4b6bba25680422ee686ca55761846e7394a1774.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <29e6e951-07a8-5335-5a11-6cf4ec7da0a0@tycho.nsa.gov>
Date:   Mon, 13 Jan 2020 13:54:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <d4b6bba25680422ee686ca55761846e7394a1774.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/13/20 1:00 PM, Richard Haines wrote:
> On Mon, 2020-01-13 at 09:07 -0500, Stephen Smalley wrote:
>> On 1/13/20 8:52 AM, Stephen Smalley wrote:
>>> On 1/12/20 11:04 AM, Richard Haines wrote:
>>>> On Fri, 2020-01-10 at 13:18 -0500, Stephen Smalley wrote:
>>>>> On 1/10/20 1:09 PM, Richard Haines wrote:
>>>>>> On Thu, 2020-01-09 at 12:19 -0500, Stephen Smalley wrote:
>>>>>>> On 1/9/20 10:07 AM, Richard Haines wrote:
>>>>>>>> Test filesystem permissions and setfscreatecon(3).
>>>>>>>>
>>>>>>>>     From kernels 5.5 filesystem { watch } is also tested.
>>>>>>>>
>>>>>>>> Signed-off-by: Richard Haines <
>>>>>>>> richard_c_haines@btinternet.com>
>>>>>>>> ---
>>>>>>>> diff --git a/policy/test_filesystem.te
>>>>>>>> b/policy/test_filesystem.te
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..2eee1fc
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/policy/test_filesystem.te
>>>>>>>> @@ -0,0 +1,324 @@
>>>>>>>> +#
>>>>>>>> +######### Test filesystem permissions policy module
>>>>>>>> ##########
>>>>>>>> +#
>>>>>>>> +attribute filesystemdomain;
>>>>>>>> +
>>>>>>>> +#################### Create a test file context
>>>>>>>> ######################
>>>>>>>> +type test_filesystem_filecon_t;
>>>>>>>> +unconfined_runs_test(test_filesystem_filecon_t)
>>>>>>>> +
>>>>>>>> +################# Test all functions
>>>>>>>> ##########################
>>>>>>>> +type test_filesystem_t;
>>>>>>>> +domain_type(test_filesystem_t)
>>>>>>>> +unconfined_runs_test(test_filesystem_t)
>>>>>>>> +typeattribute test_filesystem_t testdomain;
>>>>>>>> +typeattribute test_filesystem_t filesystemdomain;
>>>>>>>> +
>>>>>>>> +allow test_filesystem_t self:capability { sys_admin };
>>>>>>>> +allow test_filesystem_t self:filesystem { mount remount
>>>>>>>> quotamod
>>>>>>>> relabelfrom relabelto unmount quotaget };
>>>>>>>> +allow test_filesystem_t self:dir { mounton add_name
>>>>>>>> write };
>>>>>>>> +allow test_filesystem_t test_file_t:dir { mounton write
>>>>>>>> remove_name rmdir };
>>>>>>>> +# Create test file
>>>>>>>> +allow test_filesystem_t self:dir { add_name write };
>>>>>>>> +allow test_filesystem_t self:file { create relabelfrom
>>>>>>>> relabelto
>>>>>>>> };
>>>>>>>> +
>>>>>>>> +fs_mount_all_fs(test_filesystem_t)
>>>>>>>> +fs_remount_all_fs(test_filesystem_t)
>>>>>>>> +fs_unmount_all_fs(test_filesystem_t)
>>>>>>>> +fs_relabelfrom_all_fs(test_filesystem_t)
>>>>>>>> +fs_get_xattr_fs_quotas(test_filesystem_t)
>>>>>>>> +files_search_all(test_filesystem_t)
>>>>>>>> +# Required for mount opts
>>>>>>>> "rootcontext=system_u:object_r:test_filesystem_t:s0";
>>>>>>>> +fs_associate(test_filesystem_t)
>>>>>>>> +fs_getattr_xattr_fs(test_filesystem_t)
>>>>>>>> +
>>>>>>>> +# For running quotacheck(8)
>>>>>>>> +files_type(test_filesystem_t)
>>>>>>>> +# Update quotas
>>>>>>>> +fs_set_all_quotas(test_filesystem_t)
>>>>>>>> +allow test_filesystem_t self:file { quotaon };
>>>>>>>> +# Create test file and change context:
>>>>>>>> +fs_associate(test_filesystem_filecon_t)
>>>>>>>> +allow test_filesystem_t test_filesystem_filecon_t:file {
>>>>>>>> open
>>>>>>>> read
>>>>>>>> getattr relabelto write };
>>>>>>>> +dontaudit test_filesystem_t kernel_t:process { setsched
>>>>>>>> };
>>>>>>>
>>>>>>> Why do you need these dontaudit statements?  It seems like
>>>>>>> a
>>>>>>> kernel
>>>>>>> bug
>>>>>>> if something is triggering a setsched permission check on
>>>>>>> the
>>>>>>> kernel_t
>>>>>>> domain?  Something the kernel module is doing during
>>>>>>> initialization?
>>>>>>>
>>>>>>
>>>>>> I've tracked this down to them all being called from
>>>>>> block/ioprio.c
>>>>>> with: security_task_setioprio(task, ioprio) ->
>>>>>> selinux_task_setioprio
>>>>>>
>>>>>> Why the SECCLASS_PROCESS, PROCESS__SETSCHED I've no idea. The
>>>>>> following
>>>>>> also use SET/GETSCHED permission:
>>>>>>
>>>>>> selinux_task_getioprio, selinux_task_setnice,
>>>>>> selinux_task_movememory
>>>>>
>>>>> The confusing bit is that it is between test_filesystem_t and
>>>>> kernel_t.
>>>>> If the process was setting its own ioprio, then I'd expect to
>>>>> see
>>>>> the
>>>>> denial between test_filesystem_t and test_filesystem_t aka
>>>>> self.  If
>>>>> the
>>>>> process inserted a kernel module and the module initializer
>>>>> spawned
>>>>> a
>>>>> kernel thread that set its ioprio, I would expect it to be
>>>>> kernel_t
>>>>> to
>>>>> kernel_t.
>>>>
>>>> Some more info on who calls set_task_ioprio:
>>>>
>>>> fs/ext4/super.c calls 'set_task_ioprio' in two places using:
>>>>       set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
>>>> The return codes are not checked. This code was added 11 years
>>>> ago.
>>>>
>>>> fs/btrfs/reada.c also calls 'set_task_ioprio' in two places
>>>> using:
>>>>       set_task_ioprio(current, BTRFS_IOPRIO_READA);
>>>> The return codes are not checked.
>>>>
>>>> As can be seen the ext4 module does not use 'current'. I have
>>>> patched
>>>> kernel 5.5-rc5 to use 'current' and it now works as you expected.
>>>> Also
>>>> the kernel_t:process { setsched } rules can be removed.
>>>> As the problem will exist for some time, I've added to the test
>>>> policy:
>>>>       kernel_dontaudit_setsched(filesystemdomain)
>>>>
>>>> It appears that most of the refpolicy modules do the same.
>>>
>>> This seems like a kernel bug to me. I assume that these
>>> filesystems
>>> expect the I/O priority to be always set in these cases
>>> irrespective of
>>> the permissions of the current process.  Either they should be
>>> using
>>> some internal helper function ala a new set_task_ioprio_noperm()
>>> that
>>> skips permission checking or they should be temporarily overriding
>>> their
>>> cred to the init cred before doing this.  Probably a topic for
>>> linux-fsdevel and/or the respective per-filesystem mailing lists.
>>
>> Also, looks like kernel_dontaudit_setsched() isn't defined by
>> upstream
>> refpolicy so you'll need the usual ifdefery in test_policy.if to
>> allow
>> this to build against refpolicy to appease travis-ci.
>>
> 
> I'll change this to domain_setpriority_all_domains() in V4 as that is
> in both Fedora and Ref Policy.

That would likely break the task_setscheduler test.  Try 
kernel_setsched() instead, or if that fails, just use an ifdef as we do 
for other interfaces that don't exist in refpolicy.


