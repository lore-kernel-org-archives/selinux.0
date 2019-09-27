Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBFFC4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E990D217D9
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="K7FiZO8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfI0Ox3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:53:29 -0400
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:15352 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0Ox3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 10:53:29 -0400
X-EEMSG-check-017: 17729903|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="17729903"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Sep 2019 14:53:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569596004; x=1601132004;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9+VW1Cende8nSw5qbdWTWS+h2JiKf+BiHxoP9v15Ny8=;
  b=K7FiZO8KLMaV/gYqoISfaGUVJklXRkNKioXO4oKkCWOSfyAyQOjQPzFx
   sW0DEn81sWkaM6a0tpCsKUgaJxpONDwp0fYuTWbI9vGDybF9bIId7FRux
   A8AEPG0SwFQBqDAh8rXAZILsNdxUk1kn+Wb6pkJIyqJZiCznCe6O/tO5B
   01BA2pZN6dM4/LsICVVLCzaruJzbwmwMItdWBcP9s5Z6lkwqto/gKTgSJ
   /1y5eIU9wkYTD/vpftBrE31ABKNefEsfJ9VxcRKg+EIKU4UgJ97YEuTsL
   TxapnX7oc0Tq5qmnJ9JRnmVsP/6gLP8aTFzf3jjLsNMdtnFsIZrgVJvpu
   w==;
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="33447686"
IronPort-PHdr: =?us-ascii?q?9a23=3Au+dLXRArD2GeB8et1NNsUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT4pcbcNUDSrc9gkEXOFd2Cra4d0KyN7eu/CCQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Nhu7oATeusQUhYZpN7o8xA?=
 =?us-ascii?q?bOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQbNXEDopPW?=
 =?us-ascii?q?Y15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RT?=
 =?us-ascii?q?iu86FmQwLmhycdMz4y7X/ZhMp+gqlGpB6tvgFzzo7RbIyTKfFwfL7SfckCSG?=
 =?us-ascii?q?RcXshfSSJBDICyYYQBAOUOP/pXoYbmqlsSrhazHxWgCP/hxzJKgHL9wK000/?=
 =?us-ascii?q?4mEQHDxAEuAs4Ov2rMrNX1KqgSV/2+wrTNzTrZa/NW3Sny6YjVeR0muvGDQK?=
 =?us-ascii?q?lwfNHNyUgvCwzFjlKQpZbjPzOOzOsBqWeb7+1+Ve+2jWMstg9/oj+qxsg2i4?=
 =?us-ascii?q?nJgJoYykvZ9Spkx4Y6O8e4SFVhbd6/F5tcrzqaN5ZrTcMlWW1ptj06xqUCuZ?=
 =?us-ascii?q?GlZicK04ooxhDBZPOcaYSI5AzsVPqXLDxlh3xlYKqyiwu9/EWv0OHxVtS43E?=
 =?us-ascii?q?xUoidKjNXArG0B2hrO4cadUPR95F2u2TOX2gDW7eFLPF47mLLAK54k3r4wjp?=
 =?us-ascii?q?0TsVnfHiPumEX5kquWdkI89+i08evneLTmpoKHN4NulgH/Mrghmsy4AegiNA?=
 =?us-ascii?q?gBQ3Ob9vim2L3m/E35RK1GjvwwkqbHrJDXPdkXq6G2DgNP0osv9gyzAymp3d?=
 =?us-ascii?q?gGh3ULMUpJeBedgIjoP1HOLur4DfC6g1m0izdk2uvGM6b9ApTNMnfDkLDhca?=
 =?us-ascii?q?x7605H0gU/199f55VKCr0ZOvL8RlfxtMDEDh8+KwG02PjoCNF81oMYRGKODb?=
 =?us-ascii?q?SUML3dsVCW/OIjOeqMa5EPuDb7Nfcl4+TijXgjmV8SLuGV2s4MZXS5GOl2C1?=
 =?us-ascii?q?uWbGCqgdobF2oO+A0kQ7/EklqHBAVPam6yUqR03TQyDIarHM+XXYy2qKCQ1y?=
 =?us-ascii?q?e8WJtNbyZJDU7aQiSgTJmNR/pZMHHaGcRmiDFREOH8Rg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CrAQAnIY5d/wHyM5BmHAEBAQQBAQwEAQGBVgQBAQsBg?=
 =?us-ascii?q?XMqbVIBMiqEIo5uTQEBAQEBAQaBESWJdYoJhTqBZwkBAQEBAQEBAQErCQECA?=
 =?us-ascii?q?QGEQAKDNyM3Bg4CDAEBAQQBAQEBAQUDAQFshS0MgjopgmgBAQEBAgEjBAsBB?=
 =?us-ascii?q?UYLCQIYAgISAQEMBgICVxMGAgEBgl8/AYF2BQ8Pkk6aLBs1dX8zg0mFO4FIg?=
 =?us-ascii?q?QwoAYwNGHiBB4ERJwyCXz6CSA4LBBiBIBAXSAIFggI6glgErReCLIIuhFeJG?=
 =?us-ascii?q?IRoBhuDKZYLLZYLkxcigVgrCAIYCCEPgycJRxAUgVoXiCiCGIFagiQlAzABg?=
 =?us-ascii?q?QUBAYtqAg0VAoIuAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Sep 2019 14:53:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8RErMQT027607
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 10:53:22 -0400
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
From:   Stephen Smalley <sds@tycho.nsa.gov>
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
 <89af5658-c42c-21e9-f046-0df614a2bb7c@tycho.nsa.gov>
Message-ID: <6d9e359c-d0b1-f0f4-1800-9c56c58e42df@tycho.nsa.gov>
Date:   Fri, 27 Sep 2019 10:53:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <89af5658-c42c-21e9-f046-0df614a2bb7c@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/27/19 10:49 AM, Stephen Smalley wrote:
> On 9/27/19 10:28 AM, Dominick Grift wrote:
>> On Fri, Sep 27, 2019 at 10:17:16AM -0400, Stephen Smalley wrote:
>>> On 9/27/19 10:01 AM, Stephen Smalley wrote:
>>>> On 9/27/19 9:57 AM, Dominick Grift wrote:
>>>>> On Fri, Sep 27, 2019 at 09:51:26AM -0400, Stephen Smalley wrote:
>>>>>> On 9/27/19 9:49 AM, Dominick Grift wrote:
>>>>>>> On Fri, Sep 27, 2019 at 09:33:06AM -0400, Stephen Smalley wrote:
>>>>>>>> On 9/27/19 9:08 AM, Dominick Grift wrote:
>>>>>>>>> On Fri, Sep 27, 2019 at 08:59:26AM -0400, Stephen Smalley wrote:
>>>>>>>>>> On 9/27/19 3:55 AM, Dominick Grift wrote:
>>>>>>>>>>> sudo does not reset the role of my tty
>>>>>>>>>>> properly [1], and i was wondering if anyone
>>>>>>>>>>> is able to determine what is causing this
>>>>>>>>>>> [2]
>>>>>>>>>>>
>>>>>>>>>>> [1] https://bugzilla.sudo.ws/show_bug.cgi?id=898
>>>>>>>>>>> [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c
>>>>>>>>>>
>>>>>>>>>> Are you sure sudo is calling selinux_restore_tty()?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> running sudo with:
>>>>>>>>>
>>>>>>>>> Debug sudo /var/log/sudo_debug all@debug
>>>>>>>>> Debug sudoers.so /var/log/sudo_debug all@debug
>>>>>>>>>
>>>>>>>>> Yields:
>>>>>>>>>
>>>>>>>>> grep selinux /var/log/sudo_debug
>>>>>>>>> Sep 27 15:06:29 sudo[3417] <- sudo_new_key_val_v1 @
>>>>>>>>> ../../../lib/util/key_val.c:61 :=
>>>>>>>>> selinux_role=sysadm.role
>>>>>>>>> Sep 27 15:06:29 sudo[3417]     7: selinux_role=sysadm.role
>>>>>>>>> Sep 27 15:06:29 sudo[3447] -> selinux_setup @ 
>>>>>>>>> ../../src/selinux.c:349
>>>>>>>>> Sep 27 15:06:29 sudo[3447] -> get_exec_context @
>>>>>>>>> ../../src/selinux.c:274
>>>>>>>>> Sep 27 15:06:29 sudo[3447] <- get_exec_context @
>>>>>>>>> ../../src/selinux.c:328 := 0x564eed3621b0
>>>>>>>>> Sep 27 15:06:29 sudo[3447] -> relabel_tty @ 
>>>>>>>>> ../../src/selinux.c:160
>>>>>>>>> Sep 27 15:06:29 sudo[3447] <- relabel_tty @
>>>>>>>>> ../../src/selinux.c:253 := 0
>>>>>>>>> Sep 27 15:06:29 sudo[3447] -> audit_role_change @
>>>>>>>>> ../../src/selinux.c:76
>>>>>>>>> Sep 27 15:06:29 sudo[3447] <- audit_role_change @
>>>>>>>>> ../../src/selinux.c:98 := 6
>>>>>>>>> Sep 27 15:06:29 sudo[3447] <- selinux_setup @
>>>>>>>>> ../../src/selinux.c:395 := 0
>>>>>>>>> Sep 27 15:06:29 sudo[3447] -> selinux_execve @
>>>>>>>>> ../../src/selinux.c:405
>>>>>>>>> Sep 27 15:06:29 sudo[3417] -> selinux_restore_tty @
>>>>>>>>> ../../src/selinux.c:114
>>>>>>>>> Sep 27 15:06:29 sudo[3417] <- selinux_restore_tty @
>>>>>>>>> ../../src/selinux.c:142 := 0
>>>>>>>>
>>>>>>>> Ok, so you entered and exited selinux_restore_tty() without 
>>>>>>>> error. No
>>>>>>>> warning messages of any kind in any of the sudo logs? Not sure 
>>>>>>>> where
>>>>>>>> sudo_warn() and sudo_warnx() messages go.
>>>>>>>
>>>>>>> No warnings or any other clues. I guess it must be this then:
>>>>>>>
>>>>>>>        if (se_state.ttyfd == -1 || se_state.new_tty_context == NULL)
>>>>>>>      goto skip_relabel;
>>>>>>
>>>>>> That should only occur if there was no tty or 
>>>>>> security_compute_relabel()
>>>>>> didn't provide a new context to set in the first place. Not if
>>>>>> it actually
>>>>>> relabeled the tty earlier.
>>>>>>
>>>>>> Does newrole work correctly with your policy?
>>>>>
>>>>> Yes:
>>>>>
>>>>> kcinimod@seamus:~$ id -Z
>>>>> wheel.id:wheel.role:wheel.subj:s0
>>>>> kcinimod@seamus:~$ ls -alZ `tty`
>>>>> crw--w----. 1 kcinimod tty
>>>>> wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
>>>>> 15:55 /dev/pts/10
>>>>> kcinimod@seamus:~$ newrole -r sysadm.role
>>>>> Password:
>>>>> newrole: incorrect password for kcinimod
>>>>> kcinimod@seamus:~$ ls -alZ `tty`
>>>>> crw--w----. 1 kcinimod tty
>>>>> wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
>>>>> 15:56 /dev/pts/10
>>>>> kcinimod@seamus:~$ newrole -r sysadm.role
>>>>> Password:
>>>>> kcinimod@seamus:~$ id -Z
>>>>> wheel.id:sysadm.role:sysadm.subj:s0
>>>>> kcinimod@seamus:~$ ls -alZ `tty`
>>>>> crw--w----. 1 kcinimod tty
>>>>> wheel.id:sysadm.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
>>>>> 15:56 /dev/pts/10
>>>>> kcinimod@seamus:~$ exit
>>>>> logout
>>>>> kcinimod@seamus:~$ ls -alZ `tty`
>>>>> crw--w----. 1 kcinimod tty
>>>>> wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
>>>>> 15:56 /dev/pts/10
>>>>
>>>> Ok, so at least we know it is a bug in the sudo code somewhere.  I'd
>>>> assume that for some reason ttyfd or new_tty_context are either not
>>>> being set in the first place or are being unset somewhere?
>>>
>>> Can you provide your sudo package version so I can be sure I'm 
>>> looking at
>>> the right sources?  The line numbers in your debug output don't quite 
>>> align
>>> with the current upstream.
>>
>> root@seamus:~# apt info sudo
>> Package: sudo
>> Version: 1.8.27-1+b1
>> Priority: optional
>> Section: admin
>> Source: sudo (1.8.27-1)
>> Maintainer: Bdale Garbee <bdale@gag.com>
>> Installed-Size: 3,879 kB
>> Depends: libaudit1 (>= 1:2.2.1), libc6 (>= 2.27), libpam0g (>= 
>> 0.99.7.1), libselinux1 (>= 1.32), libpam-modules, lsb-base
>> Conflicts: sudo-ldap
>> Replaces: sudo-ldap
>> Homepage: http://www.sudo.ws/
>> Tag: admin::login, admin::user-management, implemented-in::c,
>>   interface::commandline, role::program, scope::utility,
>>   security::authentication, use::login
>> Download-Size: 1,244 kB
>> APT-Manual-Installed: yes
>> APT-Sources: http://mirror.nl.leaseweb.net/debian sid/main amd64 Packages
>> Description: Provide limited super user privileges to specific users
>>   Sudo is a program designed to allow a sysadmin to give limited root
>>   privileges to users and log root activity.  The basic philosophy is 
>> to give
>>   as few privileges as possible but still allow people to get their 
>> work done.
>>   .
>>   This version is built with minimal shared library dependencies, use the
>>   sudo-ldap package instead if you need LDAP support for sudoers.
> 
> Ok, I can match up the line numbers successfully.
> 
> I could be wrong since I am not especially familiar with sudo's internal 
> structure, but I'm wondering if the call to selinux_setup() is occurring 
> in a different process than the call to selinux_restore_tty().  If so, 
> then the use of global state by those functions like the se_state would 
> be broken.  Ask the sudo maintainers.   This probably wouldn't show up 
> under Fedora's default policies since I don't think they bother with 
> different types on ttys for the different user roles, so no relabeling 
> is needed.

Actually, looking back at your debug logs, that is evident from the 
different PIDs reported for the calls to selinux_setup() vs 
selinux_restore_tty().  Originally these were probably both called from 
the parent process, then someone must have re-factored and moved the 
selinux_setup() to the child?


