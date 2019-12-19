Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9EBC43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69A4206EC
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 15:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="SrV0lQv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLSPM6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:12:58 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:39428 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSPM6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 10:12:58 -0500
X-EEMSG-check-017: 37248581|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="37248581"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Dec 2019 15:12:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576768376; x=1608304376;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aufUvGkHiVYbdSy5R1Aq+7u4MHK6wTCPqPr2A7THTLg=;
  b=SrV0lQv0vsdxmCFWa9yH90BPbvUFDBIyqddfFyyG7D6iwDXUTHQKaPH6
   ZAKEPpvKw8PRQJ8jK898YqESerHzOugQ8SuTwvB4Bshk4Fu7Bb90W8rLT
   7FcdXHtIXtVM/DxxJaB9G82h/gbtRbu0URUzsdTyJhL4h6E5Zj7KFdUgo
   fQ5eiCow6KZSIhTYb2dhva8jfldKHIO4HXROenFiFW54elD1Gc0zeWaSr
   xMzMVHKWJKJ0YyPWy2Li9qnlSlGwLFSUqY4oePBsIlGbx4tmObTubcBQ6
   2/6Nk+GLalpirTrlf3MceXusS4bRr5Vx9Ml7t/oIrhXP0V/lL6xH593gC
   g==;
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="31279874"
IronPort-PHdr: =?us-ascii?q?9a23=3AVY5uQxA1R2T5HO7zmO7eUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37pMSwAkXT6L1XgUPTWs2DsrQY0rGQ6fm5EjNaqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsswndq9QajYRgJ6ov1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzi/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTW9vuCY/0LIGuJ?=
 =?us-ascii?q?i7cTAFyJQm2x7fa+GHfJOS7h3/U+aRJDF1j29mdrKnnxu+7Eetx+LmWsS0zV?=
 =?us-ascii?q?pGtDRJn9bSunwXyhDe7NWMROFn8Ue7wzmP0hje6uRDIU8pi6XWM4Uhwrsslp?=
 =?us-ascii?q?oLtkTDAzP2lF32jKCIckUk/fCl6/j9bbX8p5+cKpR0hhv/MqQolMy/Bv84PR?=
 =?us-ascii?q?YSUGSB5eS91KHs/U3+QLlQiP05jrLZv4zAKcQep665BxdZ0ocl6xmhEzeryM?=
 =?us-ascii?q?kUkHYIIV5feB+LkpLlN0/BLfzmF/uznkygkDJxyPDHOr3hDI/NLn/GkLr5Zr?=
 =?us-ascii?q?Zy9lVcxREvzdFf+51UCrYBLOj1Wk/qrtPUFBA5Mwuqw+r/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7drVCI5+MoI+mKeoAVoy3wK/ci5/7pgn85nUESfayz0psWbHC0BOhpI0?=
 =?us-ascii?q?KcYXD0mNcODX8KvhYiTOztkFCCSiBcZ3KzX6I6+zE6B5mrDZnMRo+zmryNxi?=
 =?us-ascii?q?S7EYNMZmBAFF+MFW3kd4KeW/cDcCiSONNukiQYVbi9TI8szQmuuxXny7pjNe?=
 =?us-ascii?q?fU4jcXtY/n1NRs4u3TkhYy9SZqAMiHz26NSGR0lHsSRzAqxKB/vVB9ylCb3K?=
 =?us-ascii?q?h/hvxYEsdT5/VTXQgmK5HR1PZ6BM7vVQLBZNiJVEyqTcmhATE0HZoNxIolY1?=
 =?us-ascii?q?x8AMmjhxb08LS2H6Qel7HDUJc74KXa0mPZKMF6xHLL0aAgix8tRc4ZZkO8ga?=
 =?us-ascii?q?sqzBTeH47ElQ2ikq+ucakNlHrW+Hyr0XuFvEYeVhV5F6rCQyZMNQPtsd3l6x?=
 =?us-ascii?q?aaHPeVArM9P14EkJXTJw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CDAwBWkvtd/wHyM5BlHQEBAQkBEQUFAYF8gXaBGFQBI?=
 =?us-ascii?q?BIqhAaJA4ZbBoE3iWyRRQkBAQEBAQEBAQErDAEBg3tFAoJAOBMCEAEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshTcMgjspAYJ6AQUjDwEFQRALGAICJgICVwYNBgIBAYJfPwGCU?=
 =?us-ascii?q?iUPrGKBMoVPg0WBNwaBDiiMM3mBB4E4D4JdPoJkAoRzgl4EjR5UiDyBJ5c2g?=
 =?us-ascii?q?j6CRIRujmAGG4JDmA6QF4cMlBAigVgrCAIYCCEPgydQGA2RBYpxIwMwkRYBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 19 Dec 2019 15:12:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBJFCTXi153783;
        Thu, 19 Dec 2019 10:12:31 -0500
Subject: Re: [RFC PATCH 4/8] core: add missing SELinux checks for dbus methods
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
References: <20191218142808.30433-1-cgzones@googlemail.com>
 <20191218142808.30433-5-cgzones@googlemail.com>
 <5dcd2838-33c5-db8a-5d85-e268fa2e0e89@tycho.nsa.gov>
 <CAJ2a_DcwmdPLe=CfaAEtw-4utTeM3ayegfj+K1-dacnX1A2EWA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7ccebe1a-9fa9-595d-0c58-a6cc1dea59b2@tycho.nsa.gov>
Date:   Thu, 19 Dec 2019 10:13:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJ2a_DcwmdPLe=CfaAEtw-4utTeM3ayegfj+K1-dacnX1A2EWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/19/19 9:49 AM, Christian Göttsche wrote:
> Am Mi., 18. Dez. 2019 um 21:05 Uhr schrieb Stephen Smalley <sds@tycho.nsa.gov>:
>>
>> On 12/18/19 9:28 AM, Christian Göttsche wrote:
>>> Add new SELinux permissions `modify` and `listdynusers` to the class `service`.
>>>     - modfiy checks altering operations, like `systemctl log-level debug` or `systemctl add-wants foo bar`.
>>>     - listdynusers checks obtaining dynamic users, which is very common on systems using nss-systemd.
>>>       Add a new permission to avoid undermining the `status` permission.
>>>
>>> Perform SELinux access checks for the following D-Bus exposed methods:
>>>
>>>     D-Bus interface         | c function name                    | SELinux permission verb
>>>
>>>     GetAfter / GetBefore    | bus_job_method_get_waiting_jobs    | status
>>>     LogTarget               | property_set_log_target            | modify
>>>     LogLevel                | property_set_log_level             | modify
>>>     RuntimeWatchdocUSec     | property_set_runtime_watchdog      | modify
>>>     ServiceWatchdogs        | bus_property_set_bool_wrapper      | modify
>>>     GetUnit                 | method_get_unit                    | status
>>>     GetUnitByPID            | method_get_unit_by_pid             | status
>>>     GetUnitByControlGroup   | method_get_unit_by_control_group   | status
>>>     LoadUnit                | method_load_unit                   | status
>>>     ListUnitsByNames        | method_list_units_by_names         | status
>>>     LookupDynamicUserByName | method_lookup_dynamic_user_by_name | listdynusers
>>>     LookupDynamicUserByUID  | method_lookup_dynamic_user_by_uid  | listdynusers
>>>     GetDynamicUsers         | method_get_dynamic_users           | listdynusers
>>>     AddDependencyUnitFiles  | method_add_dependency_unit_files   | modify
>>>     GetUnitFileLinks        | method_get_unit_file_links         | status
>>>     Unref                   | bus_unit_method_unref              | modify
>>
>> If we are going to introduce new permissions or change existing ones, we
>> may want to consider just defining a separate permission for every
>> logical interface.  Then we can let the policy writer decide what
>> matters to them and at what granularity they want to distinguish things,
>> using macros/interfaces as appropriate to avoid needing to specify them
>> all individually.
>>
>> Also, you may want to leverage the policy capability mechanism in
>> userspace to permit compatible evolution of permission checks in the
>> same manner it is presently used in the kernel for
>> extended_socket_class, network_peer_controls, open_perms,
>> nnp_nosuid_transition, etc.
>>
> 
> This might be an idea, to preserve full backward compatibility.
> While on it one could untangle the system security class.
> 
> Afaik this would require a SELinux userland and kernel update, to
> introduce a new policy capability identifier?

Correct.  I'd like to relax that requirement in the future (see 
https://github.com/SELinuxProject/selinux/issues/55) but for now you 
need a patched libsepol and a patched kernel.  This would be the first 
policy capability used by userspace instead of the kernel, so we'd also 
need/want libselinux functions for testing whether a given policy 
capability is enabled via selinuxfs.  People with existing kernels or 
policies would continue to operate with the old permission checks; it 
would require an upgrade of libsepol, kernel, and a policy that 
explicitly enables the new policy capability to cause the new permission 
checks to take effect.

