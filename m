Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8648C282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 15:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEC220678
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DBt0C10I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgAHPEP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:04:15 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:46378 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHPEO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 10:04:14 -0500
X-EEMSG-check-017: 43846617|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="43846617"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2020 15:04:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578495851; x=1610031851;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zRwR5KFA6P5H4e/guqSX8emWX9/He44s4yZwDUYvmi4=;
  b=DBt0C10ID2fNoVI6bfBjZFPfGlqLrbzIVWpDFkueR/rwyqLJvdgFhQvi
   OZNyZZgcwInznznN8qEpXId5cT8X9mmGWam00khYA4PsqthkYzylht83l
   wBWJssDLJGe0KijF4wG0xS5WwK3xUvJD6ZMJA3y2AaOi5jCxdeS5LBgny
   oc4ZOV/jWm8a0uil47neeQFFtPpaHXlEVGz/lrCaVlWFZUEY9sC9kyNrB
   n/1fdbTEwpy62mG+ZNmkq8W/SNdl0AEjsMsVSQAes2d+6fQIX5gXGGOzC
   yvodNp7AmFKOR+YWImx94aYcwfVLGFGnSCw9KXix/5NY18HaeHtl1kRFW
   g==;
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="31718673"
IronPort-PHdr: =?us-ascii?q?9a23=3A6FwEHhfu4XkJjEZYe9Q0wKTglGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcWyZB7h7PlgxGXEQZ/co6odzbaP6Oa6BDxLv8fJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusQWgoZuJac8xx?=
 =?us-ascii?q?/UqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezBQ2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjAdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmtiE6yrgctp?=
 =?us-ascii?q?66eigH0IkoyADBa/yGb4eH/AnjWPyXIThmmHJofq+0iRWq8UW41+HxWca53E?=
 =?us-ascii?q?xKoyZYiNXAqH8A2wLJ5sSaTPZ2412v1iyV1w/J7+FJOUU0la3GJJE/2rMwjZ?=
 =?us-ascii?q?8TsVjbHi/xhUX2kLeadkU69eis7OTqeqnmqYWGN491lwH+Kb4ims25AeQ2NQ?=
 =?us-ascii?q?gORHaU9vim2L3//Uz2XLVKjvosnqnfrJ/aPtgUqrS8Aw9U1oYv8xe/DzG439?=
 =?us-ascii?q?QEhXQLMV1IdR2dg4XpJl3COu70APihj1i2jTtn3/XGMafgApXJIHjDirDhfb?=
 =?us-ascii?q?Nl5k5H1QUz1stS545UC74dIPLzXVX9tNrDDhAjKQC0zOHnCMtl2oMERW2PGr?=
 =?us-ascii?q?OZML/VsVKQ4eIvJu6MZJQTuDnnN/cq+eXjjWUnllAAfammx4cXZGqkEfRhJk?=
 =?us-ascii?q?WTeWDsjcsZEWcWogo+S/Tnh0GNUT9SYHayWbwz5iogBYKpCofDQY+tgLif0y?=
 =?us-ascii?q?e+BJJWZ2RGBkqQHnfvcoWOQ+0MZz6KIs99jjwEUqCsS5Q/2hGqtQ/6zadnL+?=
 =?us-ascii?q?XP9y0GupLsysJ16/fQlR4s7zx0CdqS02WXQ2FzhGMISGx+4Kcqhkpx0FqBmY?=
 =?us-ascii?q?1/mPpRHtFQr6dOVwAhM5fXwsRgBtzyUx6HddCMHgWIWNKjVAotQ8oxztlGWE?=
 =?us-ascii?q?N0H9Gvn1iXxCaxK6MEnLyMQpov++TT2GandJU18GrPyKR01wpuecBIL2Dzw/?=
 =?us-ascii?q?cipgU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BsCADP7hVe/wHyM5AaAUsdAQEBCQERBQUBgXwCgXuBb?=
 =?us-ascii?q?SASKoQJiQOGZwEBAQEBAQaBEiWJbokxiBcJAQEBAQEBAQEBNwEBhEACgg44E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIw8BBUEQCw4KAgImAgJXBg0GA?=
 =?us-ascii?q?gEBgl8/glMljhadYIEyhU+DOoE9gQ4oAYwyeYEHgTgMA4JdPodZgl4Elj2BJ?=
 =?us-ascii?q?5dDgkCCRYcZjD4GG5piq04igVgrCAIYCCEPgydQGA2NHheOQSMDMJB7AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Jan 2020 15:04:09 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 008F3XOC260441;
        Wed, 8 Jan 2020 10:03:34 -0500
Subject: Re: incorrect sysfs contexts
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
References: <CAJ2a_Ddz0dXzuhyyO_SNNZRc==8K7Nba0N6Rh_u+yig6c7w3tQ@mail.gmail.com>
 <ed8c325b-f8e8-3e91-81cf-1db5c59e2bc0@tycho.nsa.gov>
 <CAFqZXNtEubfR_HQFZyjG0A2vbHMkqe5jnvo7jVxCCZE_2QgR2A@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b2575c0d-afec-1631-ea19-a34bee688b34@tycho.nsa.gov>
Date:   Wed, 8 Jan 2020 10:04:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNtEubfR_HQFZyjG0A2vbHMkqe5jnvo7jVxCCZE_2QgR2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/8/20 8:34 AM, Ondrej Mosnacek wrote:
> On Wed, Dec 18, 2019 at 4:35 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 12/18/19 10:13 AM, Christian Göttsche wrote:
>>> Hi,
>>>
>>> I am trying to refine contexts of sysfs.
>>>
>>> When using genfscon statements like:
>>>       genfscon sysfs /  system_u:object_r:sysfs_t:s0
>>>       genfscon sysfs /class/net  system_u:object_r:net_sysfs_t:s0
>>>       genfscon sysfs /devices  system_u:object_r:generic_device_sysfs_t:s0
>>>       genfscon sysfs /devices/system/cpu  system_u:object_r:cpu_sysfs_t:s0
>>>       genfscon sysfs /devices/system/cpu/online
>>> system_u:object_r:cpu_online_sysfs_t:s0
>>>       genfscon sysfs /firmware  system_u:object_r:firmware_sysfs_t:s0
>>>       genfscon sysfs /module/apparmor  system_u:object_r:apparmor_sysfs_t:s0
>>>
>>> and file context definitions like:
>>>       /sys(/.*)?
>>> gen_context(system_u:object_r:sysfs_t,s0)
>>>       /sys/module/apparmor(/.*)?
>>> gen_context(system_u:object_r:apparmor_sysfs_t,s0)
>>>       /sys/devices/system/cpu(/.*)?
>>> gen_context(system_u:object_r:cpu_sysfs_t,s0)
>>>       /sys/devices/system/cpu/online          --
>>> gen_context(system_u:object_r:cpu_online_sysfs_t,s0)
>>>       /sys/firmware(/.*)?
>>> gen_context(system_u:object_r:firmware_sysfs_t,s0)
>>>       /sys/devices(/.*)?
>>> gen_context(system_u:object_r:generic_device_sysfs_t,s0)
>>>       /sys/devices/.*/sd[a-z](/.*)?
>>> gen_context(system_u:object_r:harddrive_sysfs_t,s0)
>>>       /sys/devices/.*/hwmon(/.*)?
>>> gen_context(system_u:object_r:hwmon_sysfs_t,s0)
>>>       /sys/class/net(/.*)?
>>> gen_context(system_u:object_r:net_sysfs_t,s0)
>>>       /sys/devices/.*/net(/.*)?
>>> gen_context(system_u:object_r:net_sysfs_t,s0)
>>>
>>> with a systemd tmpfiles entry:
>>>       #Type Path        Mode UID  GID  Age Argument
>>>       Z     /sys        -    -    -    -   -
>>>
>>> I still get incorrect labeled entries after boot:
>>>
>>> $ restorecon -v -R -n /
>>> Would relabel /sys/devices/platform/intel_rapl_msr.0/subsystem from
>>> system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/0-0:AD1980/subsystem
>>> from system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC0/device
>>> from system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC0/subsystem
>>> from system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c/device
>>> from system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c/subsystem
>>> from system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c/device
>>> from system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c/subsystem
>>> from system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/device
>>> from system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/subsystem
>>> from system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p/device
>>> from system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p/subsystem
>>> from system_u:object_r:sysfs_t:s0 to
>>> system_u:object_r:generic_device_sysfs_t:s0
>>>
>>> Using auditallow statements reveals no accesses.
>>>
>>> How can I enforce these entries to be created with correct labels?
>>
>> kernel version? v5.2 introduced improved sysfs/kernfs support for
>> inheritance of SELinux labels, circa commit
>> e19dfdc83b60f196e0653d683499f7bc5548128f ("kernfs: initialize security
>> of newly created nodes").
> 
> That's correct, since v5.2 the full-name genfs labeling will not work,
> you will have to substitute these rules with filename type transitions
> (or set the labels manually).

Wait...is that really true?  If so, that's a kernel-userspace interface 
regression, which isn't permitted.  New kernel with old policy must 
continue to provide the same behavior. Android certainly relies upon 
extensive labeling of sysfs nodes.




