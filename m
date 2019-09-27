Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A76BC4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D952320872
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="X/t8H9sV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfI0OCC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:02:02 -0400
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:62010 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfI0OCC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 10:02:02 -0400
X-EEMSG-check-017: 28716899|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="28716899"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Sep 2019 14:01:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569592916; x=1601128916;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=RLkb9W0WYeAQ2hGkbo7KbM6HAkTEd7T+GckARHpy4+8=;
  b=X/t8H9sVay9q3+ugWsJmPqlSSXsyrMupYOsNzYcidYAkzPJmmMixtzBZ
   7tETv0oWhbmbN3Lo03mZonfRvpqe3DycpaeeTeqFXeKjuidyQjj7BhmF+
   FO6canZOnQo8e1GS4EL5ljnErSJxL5+wyEu5fBUTovkLwE3pAFCTxjPVY
   npTqFQyCAhjXEXYQMYRoLtZBNzkNY0AH1jbmehLDMhEy4rq3FJe21lNfm
   JeFhBjX0y8p6qc2Rw28V9+CZ7LR+kE/inJEU/1ni0bIBUt3dcNWHsQMPk
   a/pVjnJXQnSsvkPhBAM+1CHVfBUUcbjY0m96/ZbLgn8sDpm/57hneRnIy
   w==;
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="33443694"
IronPort-PHdr: =?us-ascii?q?9a23=3AOoTGxRAWavflMYnEJ6x5UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT7ocbcNUDSrc9gkEXOFd2Cra4d0KyN7eu+CCQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Nhu7oATeusQXhYZpN7o8xA?=
 =?us-ascii?q?bOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQbNXEDopPW?=
 =?us-ascii?q?Y15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RT?=
 =?us-ascii?q?iu86FmQwLmhycdMz4y7X/ZhMp+gqlGpB6tvgJzzo/RbIyTKfFwfL7SfckCSG?=
 =?us-ascii?q?RcQMhRWSxPDICyYYQBAOUOP/pXoYbmqlsSrxazHxWgCP/hxzJKgHL9wK000/?=
 =?us-ascii?q?4mEQHDxAEuAs4Ov2rMrNX1KqgSV/2+wrTNzTrZa/NW3Sny6YjVeR0muvGDQK?=
 =?us-ascii?q?lwfNHNyUgvCwzFjlKQpZbjPzOOzOsBqWeb7+1+Ve+2jWMstg9/oj+qxsg2i4?=
 =?us-ascii?q?nJgJoYykvZ9Spkx4Y6O8e4SFVhbd6/F5tcrzqaN5ZrTcMlWW1ptj06x7sbsp?=
 =?us-ascii?q?C4ZCgH0IkryhHQZvCdc4WE/wjvWPieLDtmnn5pZbSyjAuo/0e60O3zTMy03U?=
 =?us-ascii?q?5PripCj9bDqGgA1wfW6sibUvt9+Vqh2SqX2wDT9O5EJUc0mLLHK5E72L4wl4?=
 =?us-ascii?q?cTsV/ZEi/qmET5kK+WdkI+9uiu9+vneanpqoWZN491jgHyKqUumsqhDuQkKg?=
 =?us-ascii?q?UCQmeW9Oum2LDj4EH1WqtGg/IonqXDrZzWPcEbqbS4Aw9R3IYj8RG/DzK+3d?=
 =?us-ascii?q?QDgHYHN0lIeA6Hjof1O1HOJ+r0DfGkg1u2ijtryPfGPqP5DpXXMnfDiKvhfa?=
 =?us-ascii?q?p660NE0wo809Rf55NSCrEcL/P+QVHxtNPGAR8jKQC0wPjoCM971owAXWKDGK?=
 =?us-ascii?q?iZMLndsQzA2uV6OOSIZYkIqB7jJPU/of3jl3k0nRkaZ6b684EQbSWDAvl+I0?=
 =?us-ascii?q?ifKUHpi9MFHHZC6hEyV8T2mVaCVnhVfH/0UKUisGJoQLm6BJvOE9j+yIeK2z?=
 =?us-ascii?q?22S9gMOG0=3D?=
X-IPAS-Result: =?us-ascii?q?A2DUBgBvFY5d/wHyM5BmHAEBAQQBAQwEAQGBZ4F0Km1SA?=
 =?us-ascii?q?TIqhCKObk0BAQEBAQEGgTaJdYoJhTqBZwkBAQEBAQEBAQErCQECAQGEQAKDN?=
 =?us-ascii?q?yM4EwIMAQEBBAEBAQEBBQMBAWyFLQyCOimCaQEFIwQRUQsYAgIUDAYCAlcTC?=
 =?us-ascii?q?AEBgl8/AYF2FA+uD38zg0mCBIMzgUiBDCiMDhh4gQeBESeCaz6CSBkEGIEwZ?=
 =?us-ascii?q?oI8glgElgqXDYIsgi6EV44ABhuDKZYLLZYLkxghgVgrCAIYCCEPgycJRxAUj?=
 =?us-ascii?q?DGBWoIkJQMwgQYBAYwOgjABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Sep 2019 14:01:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8RE1stD012359
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 10:01:56 -0400
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
To:     selinux@vger.kernel.org
References: <20190927075507.GA20555@seamus.lan>
 <0fb7bf1f-f13b-3bec-7b91-53460dfbe265@tycho.nsa.gov>
 <20190927130805.GA22281@seamus.lan>
 <1aefe0bf-ab82-3b41-7f49-5a540ab8f7f9@tycho.nsa.gov>
 <20190927134908.GB22281@seamus.lan>
 <caf2c1c0-682b-1ff6-aee9-cc91dd6ad8a6@tycho.nsa.gov>
 <20190927135745.GC22281@seamus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fd32479f-cce0-b39a-f708-b7e1a1b27fd7@tycho.nsa.gov>
Date:   Fri, 27 Sep 2019 10:01:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927135745.GC22281@seamus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/27/19 9:57 AM, Dominick Grift wrote:
> On Fri, Sep 27, 2019 at 09:51:26AM -0400, Stephen Smalley wrote:
>> On 9/27/19 9:49 AM, Dominick Grift wrote:
>>> On Fri, Sep 27, 2019 at 09:33:06AM -0400, Stephen Smalley wrote:
>>>> On 9/27/19 9:08 AM, Dominick Grift wrote:
>>>>> On Fri, Sep 27, 2019 at 08:59:26AM -0400, Stephen Smalley wrote:
>>>>>> On 9/27/19 3:55 AM, Dominick Grift wrote:
>>>>>>> sudo does not reset the role of my tty properly [1], and i was wondering if anyone is able to determine what is causing this [2]
>>>>>>>
>>>>>>> [1] https://bugzilla.sudo.ws/show_bug.cgi?id=898
>>>>>>> [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c
>>>>>>
>>>>>> Are you sure sudo is calling selinux_restore_tty()?
>>>>>>
>>>>>>
>>>>>
>>>>> running sudo with:
>>>>>
>>>>> Debug sudo /var/log/sudo_debug all@debug
>>>>> Debug sudoers.so /var/log/sudo_debug all@debug
>>>>>
>>>>> Yields:
>>>>>
>>>>> grep selinux /var/log/sudo_debug
>>>>> Sep 27 15:06:29 sudo[3417] <- sudo_new_key_val_v1 @ ../../../lib/util/key_val.c:61 := selinux_role=sysadm.role
>>>>> Sep 27 15:06:29 sudo[3417]     7: selinux_role=sysadm.role
>>>>> Sep 27 15:06:29 sudo[3447] -> selinux_setup @ ../../src/selinux.c:349
>>>>> Sep 27 15:06:29 sudo[3447] -> get_exec_context @ ../../src/selinux.c:274
>>>>> Sep 27 15:06:29 sudo[3447] <- get_exec_context @ ../../src/selinux.c:328 := 0x564eed3621b0
>>>>> Sep 27 15:06:29 sudo[3447] -> relabel_tty @ ../../src/selinux.c:160
>>>>> Sep 27 15:06:29 sudo[3447] <- relabel_tty @ ../../src/selinux.c:253 := 0
>>>>> Sep 27 15:06:29 sudo[3447] -> audit_role_change @ ../../src/selinux.c:76
>>>>> Sep 27 15:06:29 sudo[3447] <- audit_role_change @ ../../src/selinux.c:98 := 6
>>>>> Sep 27 15:06:29 sudo[3447] <- selinux_setup @ ../../src/selinux.c:395 := 0
>>>>> Sep 27 15:06:29 sudo[3447] -> selinux_execve @ ../../src/selinux.c:405
>>>>> Sep 27 15:06:29 sudo[3417] -> selinux_restore_tty @ ../../src/selinux.c:114
>>>>> Sep 27 15:06:29 sudo[3417] <- selinux_restore_tty @ ../../src/selinux.c:142 := 0
>>>>
>>>> Ok, so you entered and exited selinux_restore_tty() without error. No
>>>> warning messages of any kind in any of the sudo logs? Not sure where
>>>> sudo_warn() and sudo_warnx() messages go.
>>>
>>> No warnings or any other clues. I guess it must be this then:
>>>
>>>       if (se_state.ttyfd == -1 || se_state.new_tty_context == NULL)
>>> 	goto skip_relabel;
>>
>> That should only occur if there was no tty or security_compute_relabel()
>> didn't provide a new context to set in the first place. Not if it actually
>> relabeled the tty earlier.
>>
>> Does newrole work correctly with your policy?
> 
> Yes:
> 
> kcinimod@seamus:~$ id -Z
> wheel.id:wheel.role:wheel.subj:s0
> kcinimod@seamus:~$ ls -alZ `tty`
> crw--w----. 1 kcinimod tty wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27 15:55 /dev/pts/10
> kcinimod@seamus:~$ newrole -r sysadm.role
> Password:
> newrole: incorrect password for kcinimod
> kcinimod@seamus:~$ ls -alZ `tty`
> crw--w----. 1 kcinimod tty wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27 15:56 /dev/pts/10
> kcinimod@seamus:~$ newrole -r sysadm.role
> Password:
> kcinimod@seamus:~$ id -Z
> wheel.id:sysadm.role:sysadm.subj:s0
> kcinimod@seamus:~$ ls -alZ `tty`
> crw--w----. 1 kcinimod tty wheel.id:sysadm.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27 15:56 /dev/pts/10
> kcinimod@seamus:~$ exit
> logout
> kcinimod@seamus:~$ ls -alZ `tty`
> crw--w----. 1 kcinimod tty wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27 15:56 /dev/pts/10

Ok, so at least we know it is a bug in the sudo code somewhere.  I'd 
assume that for some reason ttyfd or new_tty_context are either not 
being set in the first place or are being unset somewhere?


