Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD12C4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784B7217D7
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pQGFeTJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfI0Otm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:49:42 -0400
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:16365 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfI0Otl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 10:49:41 -0400
X-EEMSG-check-017: 17637523|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="17637523"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Sep 2019 14:49:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569595774; x=1601131774;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=CM/J48Gc/mGGPaasg456cSI8JHMNgNbB5Om3GW2zo8c=;
  b=pQGFeTJOjLcPKqHmw3hdtW8vyufGYXpxZBgBFWxI9e8njMkVs9AC9hdv
   VE+8734PMbsqarV6Aglh+1IRDF1EMYJH9H6t4hCBw/h5YjSkRPxDUMKTa
   c1XuOPgOJdSWjGd26b8SrieKZ9qhHeBdfL1A3uxLPGd3z60BhLsSnirNV
   X840yo45ZtBDFaONYxM8rh2JkQFJb1QD2BnrVe/Oxw7q1NRk+FiTiapei
   d3YEjvhKU6VrYdLQu3jPb4g1fIO/7knqu0gg8d1w4KIwHycG49xCeyfvg
   nAPDc6xmvUU9qThJYY7Rpw1D40dQ3YOajjyrPa8ehZb3M3eyf/V02vTlQ
   A==;
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="33447505"
IronPort-PHdr: =?us-ascii?q?9a23=3AnDhFTxwimDMK0i/XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+kUIJqq85mqBkHD//Il1AaPAdyArakawLWG+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanb75/LRq6oAfSu8ILnYZsN6E9xw?=
 =?us-ascii?q?fTrHBVYepW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ7NWCjQmKH?=
 =?us-ascii?q?0169bwtRbfVwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXz?=
 =?us-ascii?q?mp8qlkSAXsiCwaKTA39m/ZgdF0gK5CvR6spxlzzojJa4+XKfV+ZLvQc84ES2?=
 =?us-ascii?q?pPXshfVCJPDY2zYIQNE+UPMv1Vr5X+qlYUsReyGQehCeHpxzRVhnH2x6o60+?=
 =?us-ascii?q?E5HA/bwAwvAcoOsHTKo9XzKawcTOW1w7PMzTXHcfxX2Sr25Y/Tch88uvGBRq?=
 =?us-ascii?q?5wcMrNxkkvEAPJlFOQqZf/MD+P2eQNtHab4vNmWOmyhWAnrARxrSKuxscqko?=
 =?us-ascii?q?TJnZ8VxU3D9Spn2oY1Pse0SFV8YdK8C5tQqjyVN4xsTsIsWGFkoCI6xaMctp?=
 =?us-ascii?q?6gYicLxoooyAXFZ/yBbYeI/hTuX/uSLzdgnH9pZb2yihmo/UWg1+HwTNe43V?=
 =?us-ascii?q?lUoiZfj9XBsG0G2QbJ5cidUPR9+1+s2TOI1w/O9O5JOVs0la/HK545xb4wi4?=
 =?us-ascii?q?YTvVzDHiDonEX2i7ebdlk+9eiy6uTnf67mqoWAN450lg7+MqMulta5AeskKQ?=
 =?us-ascii?q?gBQ3KX+eG91L3n5UH5QbNKgeMqkqTBrZzXKssWqrS5DgNIyIov9RmyAym83N?=
 =?us-ascii?q?gFhXUHKUhKeBODj4jnIVHOJ/X4AO+kg1uxizdm3OzGP739DZXNKXjPirHhfa?=
 =?us-ascii?q?1n5EJGxwozys5f64pOCr4dOPLzRlPxtNvAAx8iLQO0x+fnCNNg1oIRQm+PHK?=
 =?us-ascii?q?CZP73IsVOS5eIgPfOMZIkLtzb5MfQl4OTujXBq0WMaKLKk2ZoRdWCQAPtrOQ?=
 =?us-ascii?q?OabGDqj9NHFn0F7SQkS+m/s0GPST5eYT6JWqs44jwqQNa9AZzrWpGmgLvH2j?=
 =?us-ascii?q?yyWJJReDYVWRi3DX70etDcCL83YyWIL5oky2EJ?=
X-IPAS-Result: =?us-ascii?q?A2CoAQAnIY5d/wHyM5BmHAEBAQQBAQwEAQGBVgQBAQsBg?=
 =?us-ascii?q?XMqbVIBMiqEIo5uTQEBAQEBAQaBNol1igmFOoFnCQEBAQEBAQEBASsJAQIBA?=
 =?us-ascii?q?YRAAoM3IzcGDgIMAQEBBAEBAQEBBQMBAWyFLQyCOimCaQEFIwQLAQVRCQIYA?=
 =?us-ascii?q?gISAQEMBgICVxMGAgEBgl8/AYF2FA+STposGzV1fzODSYIEgzeBSIEMKAGMD?=
 =?us-ascii?q?Rh4gQeBESeCaz6CSA4LBBiBIBAXSAIFggI6glgErReCLIIuhFeJGIRoBhuDK?=
 =?us-ascii?q?ZYLLZYLkxcigVgrCAIYCCEPgycJRxAUgVoXiCiCGIFagiQlAzABgQUBAYtqA?=
 =?us-ascii?q?g0VAoIuAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Sep 2019 14:49:17 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8REnFkO027565
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 10:49:15 -0400
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
To:     selinux@vger.kernel.org
References: <20190927075507.GA20555@seamus.lan>
 <0fb7bf1f-f13b-3bec-7b91-53460dfbe265@tycho.nsa.gov>
 <20190927130805.GA22281@seamus.lan>
 <1aefe0bf-ab82-3b41-7f49-5a540ab8f7f9@tycho.nsa.gov>
 <20190927134908.GB22281@seamus.lan>
 <caf2c1c0-682b-1ff6-aee9-cc91dd6ad8a6@tycho.nsa.gov>
 <20190927135745.GC22281@seamus.lan>
 <fd32479f-cce0-b39a-f708-b7e1a1b27fd7@tycho.nsa.gov>
 <62b05709-3e3c-e333-5f2e-a18defb2b8cd@tycho.nsa.gov>
 <20190927142835.GD22281@seamus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <89af5658-c42c-21e9-f046-0df614a2bb7c@tycho.nsa.gov>
Date:   Fri, 27 Sep 2019 10:49:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927142835.GD22281@seamus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/27/19 10:28 AM, Dominick Grift wrote:
> On Fri, Sep 27, 2019 at 10:17:16AM -0400, Stephen Smalley wrote:
>> On 9/27/19 10:01 AM, Stephen Smalley wrote:
>>> On 9/27/19 9:57 AM, Dominick Grift wrote:
>>>> On Fri, Sep 27, 2019 at 09:51:26AM -0400, Stephen Smalley wrote:
>>>>> On 9/27/19 9:49 AM, Dominick Grift wrote:
>>>>>> On Fri, Sep 27, 2019 at 09:33:06AM -0400, Stephen Smalley wrote:
>>>>>>> On 9/27/19 9:08 AM, Dominick Grift wrote:
>>>>>>>> On Fri, Sep 27, 2019 at 08:59:26AM -0400, Stephen Smalley wrote:
>>>>>>>>> On 9/27/19 3:55 AM, Dominick Grift wrote:
>>>>>>>>>> sudo does not reset the role of my tty
>>>>>>>>>> properly [1], and i was wondering if anyone
>>>>>>>>>> is able to determine what is causing this
>>>>>>>>>> [2]
>>>>>>>>>>
>>>>>>>>>> [1] https://bugzilla.sudo.ws/show_bug.cgi?id=898
>>>>>>>>>> [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c
>>>>>>>>>
>>>>>>>>> Are you sure sudo is calling selinux_restore_tty()?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> running sudo with:
>>>>>>>>
>>>>>>>> Debug sudo /var/log/sudo_debug all@debug
>>>>>>>> Debug sudoers.so /var/log/sudo_debug all@debug
>>>>>>>>
>>>>>>>> Yields:
>>>>>>>>
>>>>>>>> grep selinux /var/log/sudo_debug
>>>>>>>> Sep 27 15:06:29 sudo[3417] <- sudo_new_key_val_v1 @
>>>>>>>> ../../../lib/util/key_val.c:61 :=
>>>>>>>> selinux_role=sysadm.role
>>>>>>>> Sep 27 15:06:29 sudo[3417]     7: selinux_role=sysadm.role
>>>>>>>> Sep 27 15:06:29 sudo[3447] -> selinux_setup @ ../../src/selinux.c:349
>>>>>>>> Sep 27 15:06:29 sudo[3447] -> get_exec_context @
>>>>>>>> ../../src/selinux.c:274
>>>>>>>> Sep 27 15:06:29 sudo[3447] <- get_exec_context @
>>>>>>>> ../../src/selinux.c:328 := 0x564eed3621b0
>>>>>>>> Sep 27 15:06:29 sudo[3447] -> relabel_tty @ ../../src/selinux.c:160
>>>>>>>> Sep 27 15:06:29 sudo[3447] <- relabel_tty @
>>>>>>>> ../../src/selinux.c:253 := 0
>>>>>>>> Sep 27 15:06:29 sudo[3447] -> audit_role_change @
>>>>>>>> ../../src/selinux.c:76
>>>>>>>> Sep 27 15:06:29 sudo[3447] <- audit_role_change @
>>>>>>>> ../../src/selinux.c:98 := 6
>>>>>>>> Sep 27 15:06:29 sudo[3447] <- selinux_setup @
>>>>>>>> ../../src/selinux.c:395 := 0
>>>>>>>> Sep 27 15:06:29 sudo[3447] -> selinux_execve @
>>>>>>>> ../../src/selinux.c:405
>>>>>>>> Sep 27 15:06:29 sudo[3417] -> selinux_restore_tty @
>>>>>>>> ../../src/selinux.c:114
>>>>>>>> Sep 27 15:06:29 sudo[3417] <- selinux_restore_tty @
>>>>>>>> ../../src/selinux.c:142 := 0
>>>>>>>
>>>>>>> Ok, so you entered and exited selinux_restore_tty() without error. No
>>>>>>> warning messages of any kind in any of the sudo logs? Not sure where
>>>>>>> sudo_warn() and sudo_warnx() messages go.
>>>>>>
>>>>>> No warnings or any other clues. I guess it must be this then:
>>>>>>
>>>>>>        if (se_state.ttyfd == -1 || se_state.new_tty_context == NULL)
>>>>>>      goto skip_relabel;
>>>>>
>>>>> That should only occur if there was no tty or security_compute_relabel()
>>>>> didn't provide a new context to set in the first place. Not if
>>>>> it actually
>>>>> relabeled the tty earlier.
>>>>>
>>>>> Does newrole work correctly with your policy?
>>>>
>>>> Yes:
>>>>
>>>> kcinimod@seamus:~$ id -Z
>>>> wheel.id:wheel.role:wheel.subj:s0
>>>> kcinimod@seamus:~$ ls -alZ `tty`
>>>> crw--w----. 1 kcinimod tty
>>>> wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
>>>> 15:55 /dev/pts/10
>>>> kcinimod@seamus:~$ newrole -r sysadm.role
>>>> Password:
>>>> newrole: incorrect password for kcinimod
>>>> kcinimod@seamus:~$ ls -alZ `tty`
>>>> crw--w----. 1 kcinimod tty
>>>> wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
>>>> 15:56 /dev/pts/10
>>>> kcinimod@seamus:~$ newrole -r sysadm.role
>>>> Password:
>>>> kcinimod@seamus:~$ id -Z
>>>> wheel.id:sysadm.role:sysadm.subj:s0
>>>> kcinimod@seamus:~$ ls -alZ `tty`
>>>> crw--w----. 1 kcinimod tty
>>>> wheel.id:sysadm.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
>>>> 15:56 /dev/pts/10
>>>> kcinimod@seamus:~$ exit
>>>> logout
>>>> kcinimod@seamus:~$ ls -alZ `tty`
>>>> crw--w----. 1 kcinimod tty
>>>> wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
>>>> 15:56 /dev/pts/10
>>>
>>> Ok, so at least we know it is a bug in the sudo code somewhere.  I'd
>>> assume that for some reason ttyfd or new_tty_context are either not
>>> being set in the first place or are being unset somewhere?
>>
>> Can you provide your sudo package version so I can be sure I'm looking at
>> the right sources?  The line numbers in your debug output don't quite align
>> with the current upstream.
> 
> root@seamus:~# apt info sudo
> Package: sudo
> Version: 1.8.27-1+b1
> Priority: optional
> Section: admin
> Source: sudo (1.8.27-1)
> Maintainer: Bdale Garbee <bdale@gag.com>
> Installed-Size: 3,879 kB
> Depends: libaudit1 (>= 1:2.2.1), libc6 (>= 2.27), libpam0g (>= 0.99.7.1), libselinux1 (>= 1.32), libpam-modules, lsb-base
> Conflicts: sudo-ldap
> Replaces: sudo-ldap
> Homepage: http://www.sudo.ws/
> Tag: admin::login, admin::user-management, implemented-in::c,
>   interface::commandline, role::program, scope::utility,
>   security::authentication, use::login
> Download-Size: 1,244 kB
> APT-Manual-Installed: yes
> APT-Sources: http://mirror.nl.leaseweb.net/debian sid/main amd64 Packages
> Description: Provide limited super user privileges to specific users
>   Sudo is a program designed to allow a sysadmin to give limited root
>   privileges to users and log root activity.  The basic philosophy is to give
>   as few privileges as possible but still allow people to get their work done.
>   .
>   This version is built with minimal shared library dependencies, use the
>   sudo-ldap package instead if you need LDAP support for sudoers.

Ok, I can match up the line numbers successfully.

I could be wrong since I am not especially familiar with sudo's internal 
structure, but I'm wondering if the call to selinux_setup() is occurring 
in a different process than the call to selinux_restore_tty().  If so, 
then the use of global state by those functions like the se_state would 
be broken.  Ask the sudo maintainers.   This probably wouldn't show up 
under Fedora's default policies since I don't think they bother with 
different types on ttys for the different user roles, so no relabeling 
is needed.
