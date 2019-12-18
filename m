Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B818BC43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 15:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A80F218AC
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 15:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="H7g4gaWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfLRPfL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:35:11 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:24531 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfLRPfK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 10:35:10 -0500
X-EEMSG-check-017: 61960519|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="61960519"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 15:35:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576683307; x=1608219307;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=APw/pirXoDeQ6LcTTfjmL/Nje+cIwEhjjXMhJmZodRo=;
  b=H7g4gaWlnZ3IfZD+QSwF4105It/+Xzb+NhXsdkPnZkpCPPSgVk5LEGWL
   PAAI1AywMNP2FNdlzNUDMpfSgtNKekcnPIakwFQnS/CmoeET8GPhWLpP9
   A8Wo5AOM8+uGPYQBuquiwCDND6oNrJpRleRqm2vtTlDaC5E9V5pCEU5ue
   aigcDvhV78oDlDS55cCtc3uGlZbBeVSPxoeRHW3QBJRIE1oTfB6CaF3P4
   yaRrKnx2K5xUKNvzqfIFW7iFyF/F8TChuJkSCRDRXOhUtf5qy2vLkHa2K
   WhJya+rEayY/uQIKogK+f3aADuf9mCJGyhfbqrw7Y5Gg3MajGfdf/G3Eu
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="31234985"
IronPort-PHdr: =?us-ascii?q?9a23=3AnGIooRCj1jqV0Aeo15LHUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37osywAkXT6L1XgUPTWs2DsrQY0rGQ6fixEjNbqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsswndqs0bjYRgJ6s/1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBu6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzi/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTW9vuCY/0LIGuJ?=
 =?us-ascii?q?i7cTAXx5s52R7fauCIfJaT4h75UuaePyt4iXR4c7y8nxa/6VWsx+LzW8Wu0F?=
 =?us-ascii?q?tGszBJnsfDu3wTzRDf986KQeZn8Ei7wzaAzQXT5/lBIUAziKXUNYYswqU1lp?=
 =?us-ascii?q?oPqUTDGTL2mFnugK+WaEok/u+o5vz7Yrr8vJ+cNpJ0ihrkPqQvnMy/D+M4Mh?=
 =?us-ascii?q?MQUGeH4+i8yL3i8lH5QLVNlPE2lLXWsIvGKsgBo665AgtV3p4i6xa5ETimzM?=
 =?us-ascii?q?wVkWQIIV9KYh6Kj5XlN0vQLP33E/uzmUmgnC9ux//cP73hBpvNLmLEkLfkZb?=
 =?us-ascii?q?t98FNTyBEowNBD55NbFrEBIPXpVk/3r9zXFAU1MwOzw+b5ENl9zJ8RWXqTAq?=
 =?us-ascii?q?+FN6PfqUOH5u0uIumLYo8api39JuMq5/7pin85llsdcres3ZQNaXC4Gu5qLF?=
 =?us-ascii?q?meYXrpmt0BC3sFvhIiTOz2j12PSSVTaGi2X6I94DE7FY2nAJzdRoCinrOBxj?=
 =?us-ascii?q?23Hp5IaWBcDFCDD3Poe5+DW/cWZyKYOtVhnSAcVbi9V48h0gmjtAj/y7pgNe?=
 =?us-ascii?q?rU/DcXuo7929Vu/e3ciww99TxuAMSByW2CU2Z0nmZbDwMxiYt/u01m1laK15?=
 =?us-ascii?q?9XHeBEDtdT6rsdWQgoMpjR1MR1DNf9Xg/Ed9aNDl2hR4PiSSo8StM33s8mfU?=
 =?us-ascii?q?lwAZOhgwrF0i7sBKUa0/SsApAu/6CU+n/qIc92xnWOgK4kiEIgS8BCHXeriq?=
 =?us-ascii?q?52607YAIufwGuDkKP/TrgRxC7A8i+4yGOKuExJGFprXb7tQWEUZkyQq8/woE?=
 =?us-ascii?q?zFUen9WvwcLgJdxJvaeeNxYdrzgAADHaqyNQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CzAwBLRvpd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXyBd?=
 =?us-ascii?q?oFtIBKELokDhlQBAQEBAQaBN4lqiS+IFgkBAQEBAQEBAQE3AQGEQAKCPTgTA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjDwEFUQsYAgImAgJXBgEMCAEBg?=
 =?us-ascii?q?l8/glMlrXSBMoVPgzuBQYEOKIwyeYEHgTgPgl0+h1mCXgSXVJc1gj+CQ4cRj?=
 =?us-ascii?q?DkGG5pOjk6cXyKBWCsIAhgIIQ+DKE8YDY0eF45BIwOPUAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Dec 2019 15:35:06 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIFYi9W269285;
        Wed, 18 Dec 2019 10:34:46 -0500
Subject: Re: incorrect sysfs contexts
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
References: <CAJ2a_Ddz0dXzuhyyO_SNNZRc==8K7Nba0N6Rh_u+yig6c7w3tQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ed8c325b-f8e8-3e91-81cf-1db5c59e2bc0@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 10:35:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJ2a_Ddz0dXzuhyyO_SNNZRc==8K7Nba0N6Rh_u+yig6c7w3tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/18/19 10:13 AM, Christian Göttsche wrote:
> Hi,
> 
> I am trying to refine contexts of sysfs.
> 
> When using genfscon statements like:
>      genfscon sysfs /  system_u:object_r:sysfs_t:s0
>      genfscon sysfs /class/net  system_u:object_r:net_sysfs_t:s0
>      genfscon sysfs /devices  system_u:object_r:generic_device_sysfs_t:s0
>      genfscon sysfs /devices/system/cpu  system_u:object_r:cpu_sysfs_t:s0
>      genfscon sysfs /devices/system/cpu/online
> system_u:object_r:cpu_online_sysfs_t:s0
>      genfscon sysfs /firmware  system_u:object_r:firmware_sysfs_t:s0
>      genfscon sysfs /module/apparmor  system_u:object_r:apparmor_sysfs_t:s0
> 
> and file context definitions like:
>      /sys(/.*)?
> gen_context(system_u:object_r:sysfs_t,s0)
>      /sys/module/apparmor(/.*)?
> gen_context(system_u:object_r:apparmor_sysfs_t,s0)
>      /sys/devices/system/cpu(/.*)?
> gen_context(system_u:object_r:cpu_sysfs_t,s0)
>      /sys/devices/system/cpu/online          --
> gen_context(system_u:object_r:cpu_online_sysfs_t,s0)
>      /sys/firmware(/.*)?
> gen_context(system_u:object_r:firmware_sysfs_t,s0)
>      /sys/devices(/.*)?
> gen_context(system_u:object_r:generic_device_sysfs_t,s0)
>      /sys/devices/.*/sd[a-z](/.*)?
> gen_context(system_u:object_r:harddrive_sysfs_t,s0)
>      /sys/devices/.*/hwmon(/.*)?
> gen_context(system_u:object_r:hwmon_sysfs_t,s0)
>      /sys/class/net(/.*)?
> gen_context(system_u:object_r:net_sysfs_t,s0)
>      /sys/devices/.*/net(/.*)?
> gen_context(system_u:object_r:net_sysfs_t,s0)
> 
> with a systemd tmpfiles entry:
>      #Type Path        Mode UID  GID  Age Argument
>      Z     /sys        -    -    -    -   -
> 
> I still get incorrect labeled entries after boot:
> 
> $ restorecon -v -R -n /
> Would relabel /sys/devices/platform/intel_rapl_msr.0/subsystem from
> system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> Would relabel /sys/devices/pci0000:00/0000:00:05.0/0-0:AD1980/subsystem
> from system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC0/device
> from system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC0/subsystem
> from system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c/device
> from system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c/subsystem
> from system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c/device
> from system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c/subsystem
> from system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/device
> from system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/subsystem
> from system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p/device
> from system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p/subsystem
> from system_u:object_r:sysfs_t:s0 to
> system_u:object_r:generic_device_sysfs_t:s0
> 
> Using auditallow statements reveals no accesses.
> 
> How can I enforce these entries to be created with correct labels?

kernel version? v5.2 introduced improved sysfs/kernfs support for 
inheritance of SELinux labels, circa commit 
e19dfdc83b60f196e0653d683499f7bc5548128f ("kernfs: initialize security 
of newly created nodes").
