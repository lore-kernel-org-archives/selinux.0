Return-Path: <SRS0=kJrL=Y5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A38C47E49
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 19:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E657214B2
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 19:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XZhluYW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390845AbfKETTJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:19:09 -0500
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:43554 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390734AbfKETTI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Nov 2019 14:19:08 -0500
X-EEMSG-check-017: 45555536|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,271,1569283200"; 
   d="scan'208";a="45555536"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Nov 2019 19:19:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572981547; x=1604517547;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=woTzy/o65bioWI2tju32eclkR6IW+2/ALZnfD8I4TnA=;
  b=XZhluYW/QVJ9az7ksoFzioRSgIQDolQTlq4hStw+Oh4jvRzZzIHEQXtN
   wY9PZxIw3S+6/BSgHGsFS5nJBeJ0TIjD/q4LsqlIYusiSyeHJupT2xrGJ
   0QlfUm8MZnclQG846/ujcOUvcqvBeJVwO1hOXCw0dH3K46hjX63UFzPwv
   bGAh7h+ZmRfYU6odeYMiLcx4EXFF6pY1HxhSMyqAT3PTsQWfFkap/V0Uw
   BrQeAERfrSbxcqlEcbu6dkvr37tmq95aP6GmYri60BoJP3Y/JFSEeqv2Q
   FjkUolftelq/MbftOKLh5Ge5p0te/XowmEM5wVK9lVTjC15y9W+Wjw55w
   A==;
X-IronPort-AV: E=Sophos;i="5.68,271,1569283200"; 
   d="scan'208";a="29784449"
IronPort-PHdr: =?us-ascii?q?9a23=3AlUmXqRbYMvF7jiiQASNdzTP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8q5bnLW6fgltlLVR4KTs6sC17ON9fm5BCdZu8zJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/MusULgYZuJbs9xg?=
 =?us-ascii?q?XXrnBVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7W/YitZ0jKlGvhyvoRJxyJPQbI2MNPdzeqbRcNUHTm?=
 =?us-ascii?q?RDQ8lRTTRMDJ6iYYsBD+QPPuhWoIfyqFQMsRSwChKhBP/sxzJSmnP6waM33u?=
 =?us-ascii?q?YnHArb3AIgBdUOsHHModvoKKcdT/i1zKnWwjXFcvhYxDL955LMchAlv/6NXa?=
 =?us-ascii?q?97fM3KyUYyDAPIlUmQqIz5MDOV0eQBqW6b7/F6Wu61hG4nrB9xryGpy8wxiY?=
 =?us-ascii?q?fJnpoYxk3L+Ch22oo4JcC0RFRlbdOrDpdcrTyWOo1rSc04WW5oojw1yrgetJ?=
 =?us-ascii?q?6+eygF1YooygbEa/yCb4iI+hXjVPuNITtghHJqZra/hxGq/Ei80OL8TMi00E?=
 =?us-ascii?q?tRriZfjtnNtmwC1xzU6sSdTPty4lyh1iqV2wDW6+FEJVg4lavdK5E/3r49jo?=
 =?us-ascii?q?cfvEvMEyPsmEj6kbWaelsr9+S28ejrf63qppqGOI91jgH+PL4umsu6AekgKQ?=
 =?us-ascii?q?gBQnOb9P+g1Lzj4UL5QLJKgucwkqnCqp/WP8sbpqmnAwNNyIYs9w6/Dyu60N?=
 =?us-ascii?q?QfhXQIMF1FeROAj4jvJV7OO+v1Dfi4g1Srnzdrw+7JPrj7DZXMKnjPiqvufb?=
 =?us-ascii?q?F460RE0go80chf545ICrEGOP/zQVH+tNjZDh8/Lgy1zP3qCMty1owAQ2KDGK?=
 =?us-ascii?q?yZP73IsV+O+O0vJ/OAZIgPuDbyeLAZ4KvFjWU4gkMcdK+e8gULdGuzHvkud0?=
 =?us-ascii?q?6Wc33qj8wpHmANsQ4zSeXrjBuJVjsFIz6pUqY94CwrIJypAJ2FRY23hrGFmi?=
 =?us-ascii?q?ChEc54fGdDX2uQHG/oeoPMYPIFbCafM4c1iTAffaSwQI8mkxe1vUn1zKQxfb?=
 =?us-ascii?q?mcwTERqZ+2jIs93ObUjxxnsGElAg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AsAADHysFd/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBawUBAQELAYFzLIFAATKEU48UTgEBAQEBAQaBESWJZI9IgXsJAQEBAQEBA?=
 =?us-ascii?q?QEBNAECAQGEQAKEDiQ1CA4CDgEBAQQBAQEBAQUDAQFshUOCOymCbgEFIw8BB?=
 =?us-ascii?q?VELGAICJgICVwYBDAgBAYJfP4JTJbFPgTKFToMsgUiBDigBjBMYeIEHgTgMg?=
 =?us-ascii?q?jEuPodVgl4EjQGIW4ElcpYDgi6CNJMCBhuCPIwMiyGOQ5tYAzSBWCsIAhgII?=
 =?us-ascii?q?Q+DKE8RFIMSF45BIwOBNQEBkQwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 05 Nov 2019 19:19:03 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA5JJ1c0010116;
        Tue, 5 Nov 2019 14:19:02 -0500
Subject: Re: Odd systemd source context for non pid 1 process
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <CAJ2a_Df4Mwf8eiatG92fywoCoEDpozYGz+jvPLRN8vcXy2a70g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <57bbaee4-4338-30f2-3d12-bbf6a6aaabe6@tycho.nsa.gov>
Date:   Tue, 5 Nov 2019 14:19:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJ2a_Df4Mwf8eiatG92fywoCoEDpozYGz+jvPLRN8vcXy2a70g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/5/19 2:02 PM, Christian Göttsche wrote:
> While trying out a custom SELinux policy for systemd, some denials
> during system boot seem odd to me.
> systemd pid 1 runs as systemd_t and has no execute_no_trans permissions.
> The system runs in enforced mode, but systemd_t is currently a
> permissive domain.
> For debug purpose `auditallow systemd_t domain:process2 {
> nnp_transition nosuid_transition };` is active.
> 
> 
> <<<<<<<< log snippets
> 
> /var/log/messages
> 
> Nov  5 19:45:44 debian-test kernel: [    8.224135] audit: type=1400
> audit(1572979544.695:7): avc:  denied  { create } for  pid=446
> comm="(imesyncd)" name="timesync"
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=dir
> permissive=1
> Nov  5 19:45:44 debian-test kernel: [    8.225640] audit: type=1400
> audit(1572979544.695:8): avc:  denied  { setattr } for  pid=446
> comm="(imesyncd)" name="timesync" dev="tmpfs" ino=13506
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=dir
> permissive=1
> Nov  5 19:45:44 debian-test kernel: [    8.227405] audit: type=1400
> audit(1572979544.695:9): avc:  denied  { read } for  pid=446
> comm="(imesyncd)" name="timesync" dev="tmpfs" ino=13506
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=dir
> permissive=1
> Nov  5 19:45:44 debian-test kernel: [    8.229030] audit: type=1400
> audit(1572979544.695:10): avc:  denied  { open } for  pid=446
> comm="(imesyncd)" path="/run/systemd/timesync" dev="tmpfs" ino=13506
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=dir
> permissive=1
> Nov  5 19:45:44 debian-test kernel: [    8.229032] audit: type=1400
> audit(1572979544.695:11): avc:  denied  { getattr } for  pid=446
> comm="(imesyncd)" path="/run/systemd/timesync" dev="tmpfs" ino=13506
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=dir
> permissive=1
> Nov  5 19:45:44 debian-test kernel: [    8.235688] audit: type=1400
> audit(1572979544.707:12): avc:  denied  { mounton } for  pid=446
> comm="(imesyncd)" path="/run/systemd/unit-root/run/systemd/timesync"
> dev="tmpfs" ino=13506 scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=dir
> permissive=1
> 
> 
> ausearch -m avc,user_avc,selinux_err -i
> 
> ----
> type=AVC msg=audit(11/05/19 19:45:44.887:22) : avc:  granted  {
> nnp_transition } for  pid=446 comm=(imesyncd)
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:system_r:systemd_timesyncd_t:s0 tclass=process2
> ----
> type=PROCTITLE msg=audit(11/05/19 19:45:44.907:25) : proctitle=(crub_all)
> type=SYSCALL msg=audit(11/05/19 19:45:44.907:25) : arch=x86_64
> syscall=sched_setscheduler success=yes exit=0 a0=0x0 a1=SCHED_IDLE
> a2=0x7ffd35f38f50 a3=0x7ffd35f38f38 items=0 ppid=1 pid=475 auid=unset
> uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
> fsgid=root tty=(none) ses=unset comm=(crub_all)
> exe=/usr/lib/systemd/systemd subj=system_u:system_r:systemd_t:s0
> key=(null)
> type=AVC msg=audit(11/05/19 19:45:44.907:25) : avc:  denied  {
> setsched } for  pid=475 comm=(crub_all)
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:system_r:systemd_t:s0 tclass=process permissive=1
> ----
> type=PROCTITLE msg=audit(11/05/19 19:45:44.907:26) : proctitle=(crub_all)
> type=SYSCALL msg=audit(11/05/19 19:45:44.907:26) : arch=x86_64
> syscall=fcntl success=yes exit=0 a0=0x34 a1=F_SETLKW a2=0x7ffd35f38df0
> a3=0x0 items=0 ppid=1 pid=475 auid=unset uid=root gid=root euid=root
> suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none)
> ses=unset comm=(crub_all) exe=/usr/lib/systemd/systemd
> subj=system_u:system_r:systemd_t:s0 key=(null)
> type=AVC msg=audit(11/05/19 19:45:44.907:26) : avc:  denied  { lock }
> for  pid=475 comm=(crub_all) path=socket:[13561] dev="sockfs"
> ino=13561 scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:system_r:systemd_t:s0 tclass=unix_dgram_socket
> permissive=1
> ----
> type=PROCTITLE msg=audit(11/05/19 19:45:44.911:27) : proctitle=(crub_all)
> type=PATH msg=audit(11/05/19 19:45:44.911:27) : item=0
> name=/proc/self/ns/net inode=4026532232 dev=00:04 mode=file,444
> ouid=root ogid=root rdev=00:00 obj=system_u:object_r:nsfs_t:s0
> nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
> cap_frootid=0
> type=CWD msg=audit(11/05/19 19:45:44.911:27) : cwd=/
> type=SYSCALL msg=audit(11/05/19 19:45:44.911:27) : arch=x86_64
> syscall=openat success=yes exit=3 a0=0xffffff9c a1=0x55e784768331
> a2=O_RDONLY|O_NOCTTY|O_CLOEXEC a3=0x0 items=1 ppid=1 pid=475
> auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
> sgid=root fsgid=root tty=(none) ses=unset comm=(crub_all)
> exe=/usr/lib/systemd/systemd subj=system_u:system_r:systemd_t:s0
> key=(null)
> type=AVC msg=audit(11/05/19 19:45:44.911:27) : avc:  denied  { open }
> for  pid=475 comm=(crub_all) path=net:[4026532232] dev="nsfs"
> ino=4026532232 scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:object_r:nsfs_t:s0 tclass=file permissive=1
> type=AVC msg=audit(11/05/19 19:45:44.911:27) : avc:  denied  { read }
> for  pid=475 comm=(crub_all) dev="nsfs" ino=4026532232
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:object_r:nsfs_t:s0 tclass=file permissive=1
> ----
> type=PROCTITLE msg=audit(11/05/19 19:45:44.915:29) : proctitle=(crub_all)
> type=PATH msg=audit(11/05/19 19:45:44.915:29) : item=2
> name=/lib64/ld-linux-x86-64.so.2 inode=263996 dev=08:01 mode=file,755
> ouid=root ogid=root rdev=00:00 obj=system_u:object_r:ld_so_t:s0
> nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
> cap_frootid=0
> type=PATH msg=audit(11/05/19 19:45:44.915:29) : item=1 name=/bin/bash
> inode=263600 dev=08:01 mode=file,755 ouid=root ogid=root rdev=00:00
> obj=system_u:object_r:shell_exec_t:s0 nametype=NORMAL cap_fp=none
> cap_fi=none cap_fe=0 cap_fver=0 cap_frootid=0
> type=PATH msg=audit(11/05/19 19:45:44.915:29) : item=0
> name=/sbin/e2scrub_all inode=263379 dev=08:01 mode=file,755 ouid=root
> ogid=root rdev=00:00 obj=system_u:object_r:fsadm_exec_t:s0
> nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
> cap_frootid=0
> type=CWD msg=audit(11/05/19 19:45:44.915:29) : cwd=/
> type=EXECVE msg=audit(11/05/19 19:45:44.915:29) : argc=4 a0=/bin/bash
> a1=/sbin/e2scrub_all a2=-A a3=-r
> type=SYSCALL msg=audit(11/05/19 19:45:44.915:29) : arch=x86_64
> syscall=execve success=yes exit=0 a0=0x55e784f70b40 a1=0x55e78504dde0
> a2=0x55e78502a200 a3=0x55e784f71240 items=3 ppid=1 pid=475 auid=unset
> uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
> fsgid=root tty=(none) ses=unset comm=e2scrub_all exe=/usr/bin/bash
> subj=system_u:system_r:fsadm_t:s0 key=(null)
> type=AVC msg=audit(11/05/19 19:45:44.915:29) : avc:  granted  {
> nnp_transition } for  pid=475 comm=(crub_all)
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:system_r:fsadm_t:s0 tclass=process2
> ----
> type=PROCTITLE msg=audit(11/05/19 19:45:44.935:31) : proctitle=(d-logind)
> type=PATH msg=audit(11/05/19 19:45:44.935:31) : item=1
> name=/run/systemd/inhibit inode=14807 dev=00:15 mode=dir,755 ouid=root
> ogid=root rdev=00:00
> obj=system_u:object_r:systemd_logind_inhibit_runtime_t:s0
> nametype=CREATE cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
> cap_frootid=0
> type=PATH msg=audit(11/05/19 19:45:44.935:31) : item=0
> name=/run/systemd/ inode=11588 dev=00:15 mode=dir,755 ouid=root
> ogid=root rdev=00:00 obj=system_u:object_r:systemd_runtime_t:s0
> nametype=PARENT cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
> cap_frootid=0
> type=CWD msg=audit(11/05/19 19:45:44.935:31) : cwd=/
> type=SYSCALL msg=audit(11/05/19 19:45:44.935:31) : arch=x86_64
> syscall=mkdir success=yes exit=0 a0=0x55e784f6aeb0 a1=0755 a2=0x0
> a3=0x7 items=2 ppid=1 pid=481 auid=unset uid=root gid=root euid=root
> suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none)
> ses=unset comm=(d-logind) exe=/usr/lib/systemd/systemd
> subj=system_u:system_r:systemd_t:s0 key=(null)
> type=AVC msg=audit(11/05/19 19:45:44.935:31) : avc:  denied  { create
> } for  pid=481 comm=(d-logind) name=inhibit
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:object_r:systemd_logind_inhibit_runtime_t:s0
> tclass=dir permissive=1
> ----
> type=PROCTITLE msg=audit(11/05/19 19:45:44.959:35) :
> proctitle=/usr/sbin/vnstatd -n
> type=PATH msg=audit(11/05/19 19:45:44.959:35) : item=1
> name=/lib64/ld-linux-x86-64.so.2 inode=263996 dev=08:01 mode=file,755
> ouid=root ogid=root rdev=00:00 obj=system_u:object_r:ld_so_t:s0
> nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
> cap_frootid=0
> type=PATH msg=audit(11/05/19 19:45:44.959:35) : item=0
> name=/usr/sbin/vnstatd inode=262216 dev=08:01 mode=file,755 ouid=root
> ogid=root rdev=00:00 obj=system_u:object_r:vnstatd_exec_t:s0
> nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
> cap_frootid=0
> type=CWD msg=audit(11/05/19 19:45:44.959:35) : cwd=/
> type=EXECVE msg=audit(11/05/19 19:45:44.959:35) : argc=2
> a0=/usr/sbin/vnstatd a1=-n
> type=SYSCALL msg=audit(11/05/19 19:45:44.959:35) : arch=x86_64
> syscall=execve success=yes exit=0 a0=0x55e784fe5500 a1=0x55e78500df40
> a2=0x55e78501ae70 a3=0x55e784fe5580 items=2 ppid=1 pid=476 auid=unset
> uid=vnstat gid=vnstat euid=vnstat suid=vnstat fsuid=vnstat egid=vnstat
> sgid=vnstat fsgid=vnstat tty=(none) ses=unset comm=vnstatd
> exe=/usr/sbin/vnstatd subj=system_u:system_r:vnstatd_t:s0 key=(null)
> type=AVC msg=audit(11/05/19 19:45:44.959:35) : avc:  granted  {
> nnp_transition } for  pid=476 comm=(vnstatd)
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:system_r:vnstatd_t:s0 tclass=process2
> ----
> type=PROCTITLE msg=audit(11/05/19 19:45:45.099:37) : proctitle=(d-logind)
> type=PATH msg=audit(11/05/19 19:45:45.099:37) : item=1
> name=/lib64/ld-linux-x86-64.so.2 inode=263996 dev=08:01 mode=file,755
> ouid=root ogid=root rdev=00:00 obj=system_u:object_r:ld_so_t:s0
> nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
> cap_frootid=0
> type=PATH msg=audit(11/05/19 19:45:45.099:37) : item=0
> name=/lib/systemd/systemd-logind inode=268205 dev=08:01 mode=file,755
> ouid=root ogid=root rdev=00:00
> obj=system_u:object_r:systemd_logind_exec_t:s0 nametype=NORMAL
> cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 cap_frootid=0
> type=CWD msg=audit(11/05/19 19:45:45.099:37) : cwd=/
> type=EXECVE msg=audit(11/05/19 19:45:45.099:37) : argc=1
> a0=/lib/systemd/systemd-logind
> type=BPRM_FCAPS msg=audit(11/05/19 19:45:45.099:37) : fver=0 fp=none
> fi=none fe=0 old_pp=chown,dac_override,dac_read_search,fowner,fsetid,kill,setgid,setuid,setpcap,linux_immutable,net_bind_service,net_broadcast,net_admin,net_raw,ipc_lock,ipc_owner,sys_module,sys_rawio,sys_chroot,sys_ptrace,sys_pacct,sys_admin,sys_boot,sys_nice,sys_resource,sys_time,sys_tty_config,mknod,lease,audit_write,audit_control,setfcap,mac_override,mac_admin,syslog,wake_alarm,block_suspend,audit_read
> old_pi=none old_pe=chown,dac_override,dac_read_search,fowner,fsetid,kill,setgid,setuid,setpcap,linux_immutable,net_bind_service,net_broadcast,net_admin,net_raw,ipc_lock,ipc_owner,sys_module,sys_rawio,sys_chroot,sys_ptrace,sys_pacct,sys_admin,sys_boot,sys_nice,sys_resource,sys_time,sys_tty_config,mknod,lease,audit_write,audit_control,setfcap,mac_override,mac_admin,syslog,wake_alarm,block_suspend,audit_read
> old_pa=none pp=chown,dac_override,dac_read_search,fowner,linux_immutable,sys_admin,sys_tty_config,audit_control,mac_admin
> pi=none pe=chown,dac_override,dac_read_search,fowner,linux_immutable,sys_admin,sys_tty_config,audit_control,mac_admin
> pa=none frootid=0
> type=SYSCALL msg=audit(11/05/19 19:45:45.099:37) : arch=x86_64
> syscall=execve success=yes exit=0 a0=0x55e784fb9a40 a1=0x55e785050a20
> a2=0x55e78502e650 a3=0x55e784fb9840 items=2 ppid=1 pid=481 auid=unset
> uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
> fsgid=root tty=(none) ses=unset comm=systemd-logind
> exe=/usr/lib/systemd/systemd-logind
> subj=system_u:system_r:systemd_logind_t:s0 key=(null)
> type=AVC msg=audit(11/05/19 19:45:45.099:37) : avc:  granted  {
> nnp_transition } for  pid=481 comm=(d-logind)
> scontext=system_u:system_r:systemd_t:s0
> tcontext=system_u:system_r:systemd_logind_t:s0 tclass=process2
> 
>>>>>>>>> log snippets
> 
> 
> Somehow the source context is systemd_t, while the pid is not 1 (and
> the proctitle is not systemd).
> Is maybe the context transition in the `nnp_transition` case delayed?

No.  Not sure what it is that you are seeing.  Maybe auditallow 
execute_no_trans or double check that your policy isn't allowing it 
(e.g. sesearch -A -s systemd_t -p execute_no_trans)




