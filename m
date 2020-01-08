Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB1C282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 15:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C50E20673
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 15:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="or/WYfvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgAHP2O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:28:14 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:61100 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHP2O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 10:28:14 -0500
X-EEMSG-check-017: 42299168|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="42299168"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2020 15:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578497286; x=1610033286;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=t5kYI5Z0lUjnP+Xowu1ZuEf9CbnrctG8Mw3ghOUyDmo=;
  b=or/WYfvN97AcXMTjD3Cp/MRIHkk29KcseeJgCJ9Nbb0+iVoSI8PuhIKC
   UzbJiNrHYWsWjQ2YTMpL+qVGP57c6t2bYOabl3SIcPMFQNYpJuh8QxITr
   ZGUS9gCBkauBYb4z+ntp3s2k8fJ6W8NyvB/uOG/ThSLJi/PsHa+kafSWZ
   ZuH2msSMLyDrE2/L8lOQcxSdXGrQLxqEE3AR9pdDYMQJLrLWGVQZvRdhi
   XWotR0/9pmvvMeDO93/9F2kzPzgWdJ3sC598a0yr3LD4jjbq65Yut2xM8
   q0u0IQnLAHymh860N4gBzbKkcjVAB4mjIAj4ZEtbzqLFclOnks/8Qqrcx
   g==;
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="31720568"
IronPort-PHdr: =?us-ascii?q?9a23=3A3d1/BB0t5iAJe1aMsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMeKvad9pjvdHbS+e9qxAeQG9mCsLQe1rqd7PyocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBi2rgjducsbjIR/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwp18DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe221qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4TMQiQ2RytyY7zL0LoY?=
 =?us-ascii?q?O0czYUyJQm2xHQdeeHf5KO4h39SOacJypzinF9eL+nmhq//ketxvf8W8Wpyl?=
 =?us-ascii?q?pGsCVInsfWunwQ0RHY99KJReFn/ki73DaCzwXT6uZZLk8qjafbMJshwqIolp?=
 =?us-ascii?q?oUrETDAjf6mEXog6+ScUUp4vSo5P79YrXnu5+cLJV4igD4MqQgncy/Gvo3PR?=
 =?us-ascii?q?QUU2iH+eWzyL3j/UrjTLVMkvI2ibXWvIrfJcQaoq61Gw5V0oA95BajFzqqzd?=
 =?us-ascii?q?sVkHYdIF9FZR6LlZblNl7QLPziEPuzm1Gsny1qx/DCML3hGJLNLn3bnbf6YL?=
 =?us-ascii?q?l98FVRyBYzzN9D55JUDasNIPToWkDrrtDYARg5MxKsz+b9FNp9zp8eWX6IAq?=
 =?us-ascii?q?KBN6PStFiI5vkpI+aWeIAapi3wK+I76PHzjX82g0MdcbO10psQbXCyBu5mLF?=
 =?us-ascii?q?mBYXrwntcBFn8HsRYxTO3rj12CVyBcZ22pUqIz4TE7D42mDYPdSYComrOB3S?=
 =?us-ascii?q?O7EodKaWBBD1CGCW3oeJmcW/cQdCKSJddskicaWrilSo8h0wyutQDhxrp5Ie?=
 =?us-ascii?q?rb5DcYuYjg1Ndr/e3Tkw899ThuA8SayWGNQDI8omRdYDk6xq196Wl60VGK2q?=
 =?us-ascii?q?V7y6hfENtI4fpCXy8gOJLcxvA8ANf3DFHvZNCMHW26T82mDDd5ddc4x9sDcg?=
 =?us-ascii?q?4pANm5pgzS1CqtRbkOnvqEA4JiofGU5GT4O8sokyWO76ImlVRzB5ISZGA=3D?=
X-IPAS-Result: =?us-ascii?q?A2AMCgCe9BVe/wHyM5AaAUseAQscgX6Be4FtIBIqhAmJA?=
 =?us-ascii?q?4ZnAQEBAQEBBoE3iW6JMYgXCQEBAQEBAQEBATcBAYRAAoIOOBMCEAEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshUOCOykBgnoBBSMPAQVBEAsOCgICJgICVwYNBgIBAYJfP4JTJ?=
 =?us-ascii?q?Y4ZnV6BMoVPgzqBPYEOKAGMMnmBB4E4D4JdPodZgl4Elj2BJ5dDgkCCRYcZg?=
 =?us-ascii?q?xeJJwYbmmKrTiKBWCsIAhgIIQ+DJ1AYDY0eF45BIwMwkHsBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Jan 2020 15:28:04 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 008FRVDw009297;
        Wed, 8 Jan 2020 10:27:31 -0500
Subject: Re: incorrect sysfs contexts
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
References: <CAJ2a_Ddz0dXzuhyyO_SNNZRc==8K7Nba0N6Rh_u+yig6c7w3tQ@mail.gmail.com>
 <ed8c325b-f8e8-3e91-81cf-1db5c59e2bc0@tycho.nsa.gov>
 <CAFqZXNtEubfR_HQFZyjG0A2vbHMkqe5jnvo7jVxCCZE_2QgR2A@mail.gmail.com>
 <b2575c0d-afec-1631-ea19-a34bee688b34@tycho.nsa.gov>
 <CAFqZXNtanJdhVuK=zO=R9dJ8kxz0tRRLsqhaRe=mEm3_03uaLQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <89c4ca9d-a8a4-7ec0-64e2-d206f5f7001a@tycho.nsa.gov>
Date:   Wed, 8 Jan 2020 10:28:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNtanJdhVuK=zO=R9dJ8kxz0tRRLsqhaRe=mEm3_03uaLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/8/20 10:20 AM, Ondrej Mosnacek wrote:
> On Wed, Jan 8, 2020 at 4:04 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 1/8/20 8:34 AM, Ondrej Mosnacek wrote:
>>> On Wed, Dec 18, 2019 at 4:35 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 12/18/19 10:13 AM, Christian Göttsche wrote:
>>>>> Hi,
>>>>>
>>>>> I am trying to refine contexts of sysfs.
>>>>>
>>>>> When using genfscon statements like:
>>>>>        genfscon sysfs /  system_u:object_r:sysfs_t:s0
>>>>>        genfscon sysfs /class/net  system_u:object_r:net_sysfs_t:s0
>>>>>        genfscon sysfs /devices  system_u:object_r:generic_device_sysfs_t:s0
>>>>>        genfscon sysfs /devices/system/cpu  system_u:object_r:cpu_sysfs_t:s0
>>>>>        genfscon sysfs /devices/system/cpu/online
>>>>> system_u:object_r:cpu_online_sysfs_t:s0
>>>>>        genfscon sysfs /firmware  system_u:object_r:firmware_sysfs_t:s0
>>>>>        genfscon sysfs /module/apparmor  system_u:object_r:apparmor_sysfs_t:s0
>>>>>
>>>>> and file context definitions like:
>>>>>        /sys(/.*)?
>>>>> gen_context(system_u:object_r:sysfs_t,s0)
>>>>>        /sys/module/apparmor(/.*)?
>>>>> gen_context(system_u:object_r:apparmor_sysfs_t,s0)
>>>>>        /sys/devices/system/cpu(/.*)?
>>>>> gen_context(system_u:object_r:cpu_sysfs_t,s0)
>>>>>        /sys/devices/system/cpu/online          --
>>>>> gen_context(system_u:object_r:cpu_online_sysfs_t,s0)
>>>>>        /sys/firmware(/.*)?
>>>>> gen_context(system_u:object_r:firmware_sysfs_t,s0)
>>>>>        /sys/devices(/.*)?
>>>>> gen_context(system_u:object_r:generic_device_sysfs_t,s0)
>>>>>        /sys/devices/.*/sd[a-z](/.*)?
>>>>> gen_context(system_u:object_r:harddrive_sysfs_t,s0)
>>>>>        /sys/devices/.*/hwmon(/.*)?
>>>>> gen_context(system_u:object_r:hwmon_sysfs_t,s0)
>>>>>        /sys/class/net(/.*)?
>>>>> gen_context(system_u:object_r:net_sysfs_t,s0)
>>>>>        /sys/devices/.*/net(/.*)?
>>>>> gen_context(system_u:object_r:net_sysfs_t,s0)
>>>>>
>>>>> with a systemd tmpfiles entry:
>>>>>        #Type Path        Mode UID  GID  Age Argument
>>>>>        Z     /sys        -    -    -    -   -
>>>>>
>>>>> I still get incorrect labeled entries after boot:
>>>>>
>>>>> $ restorecon -v -R -n /
>>>>> Would relabel /sys/devices/platform/intel_rapl_msr.0/subsystem from
>>>>> system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/0-0:AD1980/subsystem
>>>>> from system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC0/device
>>>>> from system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC0/subsystem
>>>>> from system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c/device
>>>>> from system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c/subsystem
>>>>> from system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c/device
>>>>> from system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c/subsystem
>>>>> from system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/device
>>>>> from system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/subsystem
>>>>> from system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p/device
>>>>> from system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p/subsystem
>>>>> from system_u:object_r:sysfs_t:s0 to
>>>>> system_u:object_r:generic_device_sysfs_t:s0
>>>>>
>>>>> Using auditallow statements reveals no accesses.
>>>>>
>>>>> How can I enforce these entries to be created with correct labels?
>>>>
>>>> kernel version? v5.2 introduced improved sysfs/kernfs support for
>>>> inheritance of SELinux labels, circa commit
>>>> e19dfdc83b60f196e0653d683499f7bc5548128f ("kernfs: initialize security
>>>> of newly created nodes").
>>>
>>> That's correct, since v5.2 the full-name genfs labeling will not work,
>>> you will have to substitute these rules with filename type transitions
>>> (or set the labels manually).
>>
>> Wait...is that really true?  If so, that's a kernel-userspace interface
>> regression, which isn't permitted.  New kernel with old policy must
>> continue to provide the same behavior. Android certainly relies upon
>> extensive labeling of sysfs nodes.
> 
> Wait... actually I think it should work. I thought for a while that
> the xattr would be updated if a node's attribute would differ from its
> parent's, but that's not how the kernfs hook works. It will only
> explicitly change a child's xattr context if the parent's one has been
> explicitly set (which can usually be done only upon a request from
> userspace). Sorry for the false alarm.
> 
> Looking at the restorecon output above it looks like all the
> mislabeled files are symlinks, so this is likely also caused by the
> S_ISLNK() exception.

Ok, removing that exception likely requires making it conditional on a 
new policy capability in order to ensure compatibility with existing 
policies.

