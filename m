Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16085C4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28B02146E
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="SZPMdlgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfI0ORT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:17:19 -0400
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:22250 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfI0ORT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 10:17:19 -0400
X-EEMSG-check-017: 28612285|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="28612285"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Sep 2019 14:17:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569593837; x=1601129837;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=T3G0ISySlS+sQxZfmUWL/4sNkxZCUwhdxhhsWW9RCXM=;
  b=SZPMdlgQypI16QHG7Rh4OwtG91dyG1UHAVPFqZy3GTFMeu2UB8yy01Ec
   wvyeDUfhXlX7mtbdw6BqCZ3Ga4csXb+EA3ExTUk6JjO+SaG4GHpWSYCA0
   tUtzvsCcRgGvlNjO0UVpVo/qgU5xfisEEyOuptZDXNyXC0KbeGwgqY0Qn
   0uP6TgYeXXvf5RpHPv7/Z80AJpDL4Msw9Zd2ZbmFbk0mE4MPRasuQuK0Q
   TCqeP4vvDRhfDc66mdq4YOG5ORalZBhESXOQWito2KTNanELHklKxPXul
   YOKg/Q6lYtx3teNByvnEJEW/w5lMO8D6jpbWE2QL8HvFnmqyu7epKjLfH
   g==;
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="28399609"
IronPort-PHdr: =?us-ascii?q?9a23=3A5K67jRx/ct2vBLbXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+oQIJqq85mqBkHD//Il1AaPAdyArakawLWM+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanb75/LRq6oAfPusILnYZsN6E9xw?=
 =?us-ascii?q?fTrHBVYepW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ7NWCjQmKH?=
 =?us-ascii?q?0169bwtRbfVwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXz?=
 =?us-ascii?q?mp8qlkSAXsiCwaKTA39m/ZgdF0gK5Cvh6sphlzzojJa4+XKfV+ZLvQc84aS2?=
 =?us-ascii?q?RfUMZfVCJPDY2zYIQNE+UPMv1Vr5X+qlYUsReyGQehCeHpxzRVhnH2x6o60+?=
 =?us-ascii?q?E5HA/bwAwvAcoOsHTKo9XzKawcTOW1w7PMzTXHcfxX2Sr25Y/Tch88uvGBRq?=
 =?us-ascii?q?5wcMrNxkkvEAPJlFOQqZf/MD+P2eQNtHab4vNmWOmyhWAnrARxrSKuxscqko?=
 =?us-ascii?q?TJnZ8VxU3D9Spn2oY1Pse0SFV8YdK8C5tQqjyVN4xsTsIsWGFlvjsxxL4euZ?=
 =?us-ascii?q?OjYSQHx5sqywTfZvCaaYSE/B3uWPiLLTtlgn9uZaixiAyo8Ue6z+3xTsy00F?=
 =?us-ascii?q?FXoSVbitTMrXUN1wDL6siAV/t94l+t2TaR2ADX7eFJOVw0mrDBK54g374wjY?=
 =?us-ascii?q?AfsVjDHyDqmEX2i7WadkM49eiz9+vreLDmpp6YN4NsiwH+NLohmtCnDOglPQ?=
 =?us-ascii?q?UDUHKX9OSh2LH540H0T6tGgucrnqXBtZDVP8Ubpqq3Aw9P1YYj7g6yDyy739?=
 =?us-ascii?q?QDhnQHMFJEdw6Hj4juIV3OJuv4Au2lj1Sjlzdr2ejKPqf9DZXVMnjDjLDhcK?=
 =?us-ascii?q?5m60FCzAozzNZf549bC7waPvLzVVH+tMbCAh86LQO02eDnB8t51o8EXmKPGK?=
 =?us-ascii?q?CZY+vutgqT6+YuJfScTJEatSy7KPU/4fPqy3gjlgwzZ66siKALZWi4E/IuGE?=
 =?us-ascii?q?CQZX7hk59VCmsRlhYvR+ztzluZWHhcYGjkDPF03S0yFI/zVdSLfYuqmrHUmX?=
 =?us-ascii?q?3lEw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DYBgBjGY5d/wHyM5BmHAEBAQQBAQwEAQGBZ4F0Km1SA?=
 =?us-ascii?q?TIqhCKObU0BAQEBAQEGgTaJdYoJhTqBZwkBAQEBAQEBAQErCQECAQGEQAKDN?=
 =?us-ascii?q?yM4EwIMAQEBBAEBAQEBBQMBAWyFLQyCOimCaQEFIwQLAQVRCQIYAgIUDAYCA?=
 =?us-ascii?q?lcTCAEBgl8/AYF2FA+SMZtxfzODSYU3gUiBDCiMDhh4gQeBESeCaz6CSBkEG?=
 =?us-ascii?q?IEwZoI8glgErReCLIIuhFeOAAYbgymWCy2WC5MYIYFYKwgCGAghD4MnCUcQF?=
 =?us-ascii?q?IwxgVqCJCUDMIEGAQGMDoIwAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Sep 2019 14:17:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8REHGla017371
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 10:17:16 -0400
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
Message-ID: <62b05709-3e3c-e333-5f2e-a18defb2b8cd@tycho.nsa.gov>
Date:   Fri, 27 Sep 2019 10:17:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <fd32479f-cce0-b39a-f708-b7e1a1b27fd7@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/27/19 10:01 AM, Stephen Smalley wrote:
> On 9/27/19 9:57 AM, Dominick Grift wrote:
>> On Fri, Sep 27, 2019 at 09:51:26AM -0400, Stephen Smalley wrote:
>>> On 9/27/19 9:49 AM, Dominick Grift wrote:
>>>> On Fri, Sep 27, 2019 at 09:33:06AM -0400, Stephen Smalley wrote:
>>>>> On 9/27/19 9:08 AM, Dominick Grift wrote:
>>>>>> On Fri, Sep 27, 2019 at 08:59:26AM -0400, Stephen Smalley wrote:
>>>>>>> On 9/27/19 3:55 AM, Dominick Grift wrote:
>>>>>>>> sudo does not reset the role of my tty properly [1], and i was 
>>>>>>>> wondering if anyone is able to determine what is causing this [2]
>>>>>>>>
>>>>>>>> [1] https://bugzilla.sudo.ws/show_bug.cgi?id=898
>>>>>>>> [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c
>>>>>>>
>>>>>>> Are you sure sudo is calling selinux_restore_tty()?
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> running sudo with:
>>>>>>
>>>>>> Debug sudo /var/log/sudo_debug all@debug
>>>>>> Debug sudoers.so /var/log/sudo_debug all@debug
>>>>>>
>>>>>> Yields:
>>>>>>
>>>>>> grep selinux /var/log/sudo_debug
>>>>>> Sep 27 15:06:29 sudo[3417] <- sudo_new_key_val_v1 @ 
>>>>>> ../../../lib/util/key_val.c:61 := selinux_role=sysadm.role
>>>>>> Sep 27 15:06:29 sudo[3417]     7: selinux_role=sysadm.role
>>>>>> Sep 27 15:06:29 sudo[3447] -> selinux_setup @ ../../src/selinux.c:349
>>>>>> Sep 27 15:06:29 sudo[3447] -> get_exec_context @ 
>>>>>> ../../src/selinux.c:274
>>>>>> Sep 27 15:06:29 sudo[3447] <- get_exec_context @ 
>>>>>> ../../src/selinux.c:328 := 0x564eed3621b0
>>>>>> Sep 27 15:06:29 sudo[3447] -> relabel_tty @ ../../src/selinux.c:160
>>>>>> Sep 27 15:06:29 sudo[3447] <- relabel_tty @ 
>>>>>> ../../src/selinux.c:253 := 0
>>>>>> Sep 27 15:06:29 sudo[3447] -> audit_role_change @ 
>>>>>> ../../src/selinux.c:76
>>>>>> Sep 27 15:06:29 sudo[3447] <- audit_role_change @ 
>>>>>> ../../src/selinux.c:98 := 6
>>>>>> Sep 27 15:06:29 sudo[3447] <- selinux_setup @ 
>>>>>> ../../src/selinux.c:395 := 0
>>>>>> Sep 27 15:06:29 sudo[3447] -> selinux_execve @ 
>>>>>> ../../src/selinux.c:405
>>>>>> Sep 27 15:06:29 sudo[3417] -> selinux_restore_tty @ 
>>>>>> ../../src/selinux.c:114
>>>>>> Sep 27 15:06:29 sudo[3417] <- selinux_restore_tty @ 
>>>>>> ../../src/selinux.c:142 := 0
>>>>>
>>>>> Ok, so you entered and exited selinux_restore_tty() without error. No
>>>>> warning messages of any kind in any of the sudo logs? Not sure where
>>>>> sudo_warn() and sudo_warnx() messages go.
>>>>
>>>> No warnings or any other clues. I guess it must be this then:
>>>>
>>>>       if (se_state.ttyfd == -1 || se_state.new_tty_context == NULL)
>>>>     goto skip_relabel;
>>>
>>> That should only occur if there was no tty or security_compute_relabel()
>>> didn't provide a new context to set in the first place. Not if it 
>>> actually
>>> relabeled the tty earlier.
>>>
>>> Does newrole work correctly with your policy?
>>
>> Yes:
>>
>> kcinimod@seamus:~$ id -Z
>> wheel.id:wheel.role:wheel.subj:s0
>> kcinimod@seamus:~$ ls -alZ `tty`
>> crw--w----. 1 kcinimod tty 
>> wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27 
>> 15:55 /dev/pts/10
>> kcinimod@seamus:~$ newrole -r sysadm.role
>> Password:
>> newrole: incorrect password for kcinimod
>> kcinimod@seamus:~$ ls -alZ `tty`
>> crw--w----. 1 kcinimod tty 
>> wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27 
>> 15:56 /dev/pts/10
>> kcinimod@seamus:~$ newrole -r sysadm.role
>> Password:
>> kcinimod@seamus:~$ id -Z
>> wheel.id:sysadm.role:sysadm.subj:s0
>> kcinimod@seamus:~$ ls -alZ `tty`
>> crw--w----. 1 kcinimod tty 
>> wheel.id:sysadm.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27 
>> 15:56 /dev/pts/10
>> kcinimod@seamus:~$ exit
>> logout
>> kcinimod@seamus:~$ ls -alZ `tty`
>> crw--w----. 1 kcinimod tty 
>> wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27 
>> 15:56 /dev/pts/10
> 
> Ok, so at least we know it is a bug in the sudo code somewhere.  I'd 
> assume that for some reason ttyfd or new_tty_context are either not 
> being set in the first place or are being unset somewhere?

Can you provide your sudo package version so I can be sure I'm looking 
at the right sources?  The line numbers in your debug output don't quite 
align with the current upstream.


