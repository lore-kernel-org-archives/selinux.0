Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9C4C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 18:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0C32080D
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 18:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="UPN8myRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgAJSSE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:18:04 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:14481 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgAJSSE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 13:18:04 -0500
X-EEMSG-check-017: 44552114|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="44552114"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2020 18:18:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578680280; x=1610216280;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=u0cZvBBUBaQphqUkzRw3+hhlDjdcIZaoIienxwXG/pw=;
  b=UPN8myRdO4FWFA21Gd3TptHu4tbN5cFgoEatOIuWFRz30GyLOb1xitFk
   Z5zdGpkrRnOXyxG41v3eL9rOXbqoI5oqvO+JLDz0ruNzkglCqA0QMforE
   h62iTMIn/uWNhOgoGCNGnMC8qcuD9rjgC0tpIYIlUfAICYuxqhNVpOw6S
   HeKRRqiMgfRLu1aU3+pkOtZQ3+PVpKmOy9olqNIVWnP6XkmHz2f8G90Ol
   s4AHNO5zJwYgOjYSLMcu64atoaW9V9rJe6D/V3l5O7TOrhxkZXANmETWb
   fzNaUrxe8RjAC5AbRtgrmFcRxS9gPeB+IU+kOiE0hJ4si5/qLuDcOAXKL
   w==;
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="31824488"
IronPort-PHdr: =?us-ascii?q?9a23=3AQPbTSBWw8ytkAN972YyDsRLN3ZrV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbR2At8tkgFKBZ4jH8fUM07OQ7/m7HzZeut3Y6C1KWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMIjYZjJKs9xQ?=
 =?us-ascii?q?bFrmdIdu9L2W5mOFWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW?=
 =?us-ascii?q?5YUspMSyBNHoawYo0BAOobOeZTspfzqV0AoxCjAQWgHe3ixztNinLwwKY00f?=
 =?us-ascii?q?kuERve0QI9AdwOvnTaotb7OqgcXu+6zrXHwzrYYvNK2zrw8pTEfgwvrPyOW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllietJDlMC2N1uQNrWeb6fdrW/+qi2E9rwFxpiagx8cxgY?=
 =?us-ascii?q?TOnYIa10vE+D5lwIc1OdK4SEl7bcSiEJtLrS6WLYR2QsQ8Q2xxvisx174IuY?=
 =?us-ascii?q?ajcSQXx5kqyATTZvyaf4SS/B7uW/idLS1liH9jZbmxnQy98VK6xe35TsS01V?=
 =?us-ascii?q?FKoTdbndTUrXAN0gDT6tCASvtg4ketwTaP2B7X6uFDOU00ibDUK4Qgwr4tjZ?=
 =?us-ascii?q?ofq0XDHin4mEXxl6+ZaFkr9vK06+XnfrrmppicO5Vyig7iKaQhhtazAeE5Mg?=
 =?us-ascii?q?gKR2Sb+OK826P//UDhXblHgfI7nrPZvZzHP8gXuKG0DxFP3oo+8xq/Ci2p0N?=
 =?us-ascii?q?UcnXkJNlJFfxeHgpDyO17TO/D1Fuu/glSwnzdrwPDKJLvhAo7XIXTZn7fheq?=
 =?us-ascii?q?h951ZGyAUv1dBf+45UCrYZLfLpW0/+qNzYAQUjMwOp2+noFM1y1oMEVmKOBK?=
 =?us-ascii?q?+WLrjSvEST6eIzIumMYpMVtyjnK/gj+fHukWU1lkMafamsxZEXcmy3Hux6I0?=
 =?us-ascii?q?WFZnrhmswBHnkOvgo/SuzqlVKDXCVNZ3a9Qa08/Cs3CIG4AofZQICinriB0D?=
 =?us-ascii?q?28Hp1MaWBMEkqMHmvwd4WYR/cMbzqfIshkkjwDTrihTZUu2g2wuwLh0bpoMP?=
 =?us-ascii?q?fb+i0CupL/ztR6++rTlRRhvQBzWv6c2GGEVW08vmoJQTItlPRloEd9w02P5q?=
 =?us-ascii?q?NPg/VZE9FIz/lVUwEmOITawvA8ANf3DEaJZdqNSVC7Uv24DjwrCNE82dkDZw?=
 =?us-ascii?q?B6AdrxoArE2n+RH7INl7GNTKcx+6bY0mm5c91x0F7axaIhiB8gWcIJOmq40P?=
 =?us-ascii?q?0svzPPDpLExh3K352hcr4RiWuUrzaO?=
X-IPAS-Result: =?us-ascii?q?A2DtAAB2vxhe/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gWwBIBIqhAmJA4ZlAQEBAQEBBoE3iW6RSAkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCFjgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjBBFBEAsYAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJjP4JLAwklrGR/M4VJg02BPYEOKIwzeYEHgTgPgl0+ghuFPoI8I?=
 =?us-ascii?q?gSXI0aXToJBgkiTXwYbgkeMRYtejlqBSZs8IoFYKwgCGAghD4MnUBgNoTMjA?=
 =?us-ascii?q?zCRMAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Jan 2020 18:17:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00AIHKuH134832;
        Fri, 10 Jan 2020 13:17:21 -0500
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
 <20200109150709.360345-2-richard_c_haines@btinternet.com>
 <aa333bd1-9fd8-b4a4-eba2-aa8d722cbc7e@tycho.nsa.gov>
 <f2cebe3fcb2960a2b51638d457ae07781896a12c.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c2cc9f48-4dd3-cdf4-8c4e-3575ffc05aaf@tycho.nsa.gov>
Date:   Fri, 10 Jan 2020 13:18:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <f2cebe3fcb2960a2b51638d457ae07781896a12c.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 1:09 PM, Richard Haines wrote:
> On Thu, 2020-01-09 at 12:19 -0500, Stephen Smalley wrote:
>> On 1/9/20 10:07 AM, Richard Haines wrote:
>>> Test filesystem permissions and setfscreatecon(3).
>>>
>>>   From kernels 5.5 filesystem { watch } is also tested.
>>>
>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>> ---
>>> diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
>>> new file mode 100644
>>> index 0000000..2eee1fc
>>> --- /dev/null
>>> +++ b/policy/test_filesystem.te
>>> @@ -0,0 +1,324 @@
>>> +#
>>> +######### Test filesystem permissions policy module ##########
>>> +#
>>> +attribute filesystemdomain;
>>> +
>>> +#################### Create a test file context
>>> ######################
>>> +type test_filesystem_filecon_t;
>>> +unconfined_runs_test(test_filesystem_filecon_t)
>>> +
>>> +################# Test all functions ##########################
>>> +type test_filesystem_t;
>>> +domain_type(test_filesystem_t)
>>> +unconfined_runs_test(test_filesystem_t)
>>> +typeattribute test_filesystem_t testdomain;
>>> +typeattribute test_filesystem_t filesystemdomain;
>>> +
>>> +allow test_filesystem_t self:capability { sys_admin };
>>> +allow test_filesystem_t self:filesystem { mount remount quotamod
>>> relabelfrom relabelto unmount quotaget };
>>> +allow test_filesystem_t self:dir { mounton add_name write };
>>> +allow test_filesystem_t test_file_t:dir { mounton write
>>> remove_name rmdir };
>>> +# Create test file
>>> +allow test_filesystem_t self:dir { add_name write };
>>> +allow test_filesystem_t self:file { create relabelfrom relabelto
>>> };
>>> +
>>> +fs_mount_all_fs(test_filesystem_t)
>>> +fs_remount_all_fs(test_filesystem_t)
>>> +fs_unmount_all_fs(test_filesystem_t)
>>> +fs_relabelfrom_all_fs(test_filesystem_t)
>>> +fs_get_xattr_fs_quotas(test_filesystem_t)
>>> +files_search_all(test_filesystem_t)
>>> +# Required for mount opts
>>> "rootcontext=system_u:object_r:test_filesystem_t:s0";
>>> +fs_associate(test_filesystem_t)
>>> +fs_getattr_xattr_fs(test_filesystem_t)
>>> +
>>> +# For running quotacheck(8)
>>> +files_type(test_filesystem_t)
>>> +# Update quotas
>>> +fs_set_all_quotas(test_filesystem_t)
>>> +allow test_filesystem_t self:file { quotaon };
>>> +# Create test file and change context:
>>> +fs_associate(test_filesystem_filecon_t)
>>> +allow test_filesystem_t test_filesystem_filecon_t:file { open read
>>> getattr relabelto write };
>>> +dontaudit test_filesystem_t kernel_t:process { setsched };
>>
>> Why do you need these dontaudit statements?  It seems like a kernel
>> bug
>> if something is triggering a setsched permission check on the
>> kernel_t
>> domain?  Something the kernel module is doing during initialization?
>>
> 
> I've tracked this down to them all being called from block/ioprio.c
> with: security_task_setioprio(task, ioprio) -> selinux_task_setioprio
> 
> Why the SECCLASS_PROCESS, PROCESS__SETSCHED I've no idea. The following
> also use SET/GETSCHED permission:
> 
> selinux_task_getioprio, selinux_task_setnice, selinux_task_movememory

The confusing bit is that it is between test_filesystem_t and kernel_t. 
If the process was setting its own ioprio, then I'd expect to see the 
denial between test_filesystem_t and test_filesystem_t aka self.  If the 
process inserted a kernel module and the module initializer spawned a 
kernel thread that set its ioprio, I would expect it to be kernel_t to 
kernel_t.
