Return-Path: <SRS0=kJrL=Y5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02955C5DF60
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 19:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69AE217F4
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 19:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ENNnpLmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390693AbfKETCx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:02:53 -0500
Received: from mail-vk1-f177.google.com ([209.85.221.177]:35632 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390514AbfKETCx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Nov 2019 14:02:53 -0500
Received: by mail-vk1-f177.google.com with SMTP id e205so4971614vke.2
        for <selinux@vger.kernel.org>; Tue, 05 Nov 2019 11:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5oX3iz34vuZLVZT+xhcIzhIi7OLhnohP7La1LwssBfY=;
        b=ENNnpLmKeYQLMRa9Vra4onecBeePteDcFeDwUBABrmX4qHUO7gznBuQkud90yGUdQ1
         zJjA5siZuuxZu2bnG+CvetMJdP2J9+bh8pUe6mQuL5bm+nQwrSey8yyb8Lu6hX1iWEjL
         y6DS8WVSx7+lN75uyYgiOmi0X+8lgu149VYR7WAf608uqlwHq8Oc8nfWWYJeybMQVyKP
         0LM2VoYSKKOIgby2oQljNYI3dFsCuyPOY2f9atzM3AkIplNgoZIE11w3+akrMLCpqgFd
         MdO3xh5RVz+mfOLIi3gB6ht+JudguKd3/bABX/AobYZVTaOKRmxdVwtUGWQbEE4X0GYF
         1/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5oX3iz34vuZLVZT+xhcIzhIi7OLhnohP7La1LwssBfY=;
        b=q3/48pQz3tPO8U7PykUoC7an7TYr5wvwY6TzbSlUJD27uerxmh0mxa/GPR67c8xd5j
         FEwju/xDXBojU2DIIlBCnkalltz3QhcE3gaGaYY5h40RUeqEhUaaPeARHBk2Z4owJfkM
         9/PYEjlZdmUgzl4zGoPbvoYcpueHksv1it8pQ0oBRuLQw9crtv0Cs7c+zkRDEM5n/TVJ
         BZP0ZUQXic1oJQxKld6XhaBr61Y1bv6HvBgKJLDILbGoHJlcDVUlcWMlXsin4Zatjuwp
         Wr5dWr4TpxqF2NHeCuWSGo8+idWnHCEQQrio94+pyHiPXqjCbb0fI2RLkpOEvUTxJ9ZG
         1Z2Q==
X-Gm-Message-State: APjAAAWIh0jsLKM8sp7y+KP4AI4P0ddmsLcwcD6iirVyWoJuB/XPBv4f
        mHFDA2EIp7WMkd2nA4O6yDnMxKoomJmlcsMuJnXd0KJ1
X-Google-Smtp-Source: APXvYqwZE5oyx9/LNKjuUXS4euJHL3swDrLCa2eMdqsevsruNHjp9DCJFuRfvPYgEXEH7OXXOskMCekpU9eScusPBxU=
X-Received: by 2002:a1f:a20e:: with SMTP id l14mr4301529vke.14.1572980571175;
 Tue, 05 Nov 2019 11:02:51 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 5 Nov 2019 20:02:39 +0100
Message-ID: <CAJ2a_Df4Mwf8eiatG92fywoCoEDpozYGz+jvPLRN8vcXy2a70g@mail.gmail.com>
Subject: Odd systemd source context for non pid 1 process
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While trying out a custom SELinux policy for systemd, some denials
during system boot seem odd to me.
systemd pid 1 runs as systemd_t and has no execute_no_trans permissions.
The system runs in enforced mode, but systemd_t is currently a
permissive domain.
For debug purpose `auditallow systemd_t domain:process2 {
nnp_transition nosuid_transition };` is active.


<<<<<<<< log snippets

/var/log/messages

Nov  5 19:45:44 debian-test kernel: [    8.224135] audit: type=3D1400
audit(1572979544.695:7): avc:  denied  { create } for  pid=3D446
comm=3D"(imesyncd)" name=3D"timesync"
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=3Ddir
permissive=3D1
Nov  5 19:45:44 debian-test kernel: [    8.225640] audit: type=3D1400
audit(1572979544.695:8): avc:  denied  { setattr } for  pid=3D446
comm=3D"(imesyncd)" name=3D"timesync" dev=3D"tmpfs" ino=3D13506
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=3Ddir
permissive=3D1
Nov  5 19:45:44 debian-test kernel: [    8.227405] audit: type=3D1400
audit(1572979544.695:9): avc:  denied  { read } for  pid=3D446
comm=3D"(imesyncd)" name=3D"timesync" dev=3D"tmpfs" ino=3D13506
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=3Ddir
permissive=3D1
Nov  5 19:45:44 debian-test kernel: [    8.229030] audit: type=3D1400
audit(1572979544.695:10): avc:  denied  { open } for  pid=3D446
comm=3D"(imesyncd)" path=3D"/run/systemd/timesync" dev=3D"tmpfs" ino=3D1350=
6
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=3Ddir
permissive=3D1
Nov  5 19:45:44 debian-test kernel: [    8.229032] audit: type=3D1400
audit(1572979544.695:11): avc:  denied  { getattr } for  pid=3D446
comm=3D"(imesyncd)" path=3D"/run/systemd/timesync" dev=3D"tmpfs" ino=3D1350=
6
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=3Ddir
permissive=3D1
Nov  5 19:45:44 debian-test kernel: [    8.235688] audit: type=3D1400
audit(1572979544.707:12): avc:  denied  { mounton } for  pid=3D446
comm=3D"(imesyncd)" path=3D"/run/systemd/unit-root/run/systemd/timesync"
dev=3D"tmpfs" ino=3D13506 scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:object_r:systemd_timesyncd_runtime_t:s0 tclass=3Ddir
permissive=3D1


ausearch -m avc,user_avc,selinux_err -i

----
type=3DAVC msg=3Daudit(11/05/19 19:45:44.887:22) : avc:  granted  {
nnp_transition } for  pid=3D446 comm=3D(imesyncd)
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:system_r:systemd_timesyncd_t:s0 tclass=3Dprocess2
----
type=3DPROCTITLE msg=3Daudit(11/05/19 19:45:44.907:25) : proctitle=3D(crub_=
all)
type=3DSYSCALL msg=3Daudit(11/05/19 19:45:44.907:25) : arch=3Dx86_64
syscall=3Dsched_setscheduler success=3Dyes exit=3D0 a0=3D0x0 a1=3DSCHED_IDL=
E
a2=3D0x7ffd35f38f50 a3=3D0x7ffd35f38f38 items=3D0 ppid=3D1 pid=3D475 auid=
=3Dunset
uid=3Droot gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=
=3Droot
fsgid=3Droot tty=3D(none) ses=3Dunset comm=3D(crub_all)
exe=3D/usr/lib/systemd/systemd subj=3Dsystem_u:system_r:systemd_t:s0
key=3D(null)
type=3DAVC msg=3Daudit(11/05/19 19:45:44.907:25) : avc:  denied  {
setsched } for  pid=3D475 comm=3D(crub_all)
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:system_r:systemd_t:s0 tclass=3Dprocess permissive=3D1
----
type=3DPROCTITLE msg=3Daudit(11/05/19 19:45:44.907:26) : proctitle=3D(crub_=
all)
type=3DSYSCALL msg=3Daudit(11/05/19 19:45:44.907:26) : arch=3Dx86_64
syscall=3Dfcntl success=3Dyes exit=3D0 a0=3D0x34 a1=3DF_SETLKW a2=3D0x7ffd3=
5f38df0
a3=3D0x0 items=3D0 ppid=3D1 pid=3D475 auid=3Dunset uid=3Droot gid=3Droot eu=
id=3Droot
suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tty=3D(none)
ses=3Dunset comm=3D(crub_all) exe=3D/usr/lib/systemd/systemd
subj=3Dsystem_u:system_r:systemd_t:s0 key=3D(null)
type=3DAVC msg=3Daudit(11/05/19 19:45:44.907:26) : avc:  denied  { lock }
for  pid=3D475 comm=3D(crub_all) path=3Dsocket:[13561] dev=3D"sockfs"
ino=3D13561 scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:system_r:systemd_t:s0 tclass=3Dunix_dgram_socket
permissive=3D1
----
type=3DPROCTITLE msg=3Daudit(11/05/19 19:45:44.911:27) : proctitle=3D(crub_=
all)
type=3DPATH msg=3Daudit(11/05/19 19:45:44.911:27) : item=3D0
name=3D/proc/self/ns/net inode=3D4026532232 dev=3D00:04 mode=3Dfile,444
ouid=3Droot ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:nsfs_t:s0
nametype=3DNORMAL cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
cap_frootid=3D0
type=3DCWD msg=3Daudit(11/05/19 19:45:44.911:27) : cwd=3D/
type=3DSYSCALL msg=3Daudit(11/05/19 19:45:44.911:27) : arch=3Dx86_64
syscall=3Dopenat success=3Dyes exit=3D3 a0=3D0xffffff9c a1=3D0x55e784768331
a2=3DO_RDONLY|O_NOCTTY|O_CLOEXEC a3=3D0x0 items=3D1 ppid=3D1 pid=3D475
auid=3Dunset uid=3Droot gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egi=
d=3Droot
sgid=3Droot fsgid=3Droot tty=3D(none) ses=3Dunset comm=3D(crub_all)
exe=3D/usr/lib/systemd/systemd subj=3Dsystem_u:system_r:systemd_t:s0
key=3D(null)
type=3DAVC msg=3Daudit(11/05/19 19:45:44.911:27) : avc:  denied  { open }
for  pid=3D475 comm=3D(crub_all) path=3Dnet:[4026532232] dev=3D"nsfs"
ino=3D4026532232 scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:object_r:nsfs_t:s0 tclass=3Dfile permissive=3D1
type=3DAVC msg=3Daudit(11/05/19 19:45:44.911:27) : avc:  denied  { read }
for  pid=3D475 comm=3D(crub_all) dev=3D"nsfs" ino=3D4026532232
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:object_r:nsfs_t:s0 tclass=3Dfile permissive=3D1
----
type=3DPROCTITLE msg=3Daudit(11/05/19 19:45:44.915:29) : proctitle=3D(crub_=
all)
type=3DPATH msg=3Daudit(11/05/19 19:45:44.915:29) : item=3D2
name=3D/lib64/ld-linux-x86-64.so.2 inode=3D263996 dev=3D08:01 mode=3Dfile,7=
55
ouid=3Droot ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:ld_so_t:s0
nametype=3DNORMAL cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
cap_frootid=3D0
type=3DPATH msg=3Daudit(11/05/19 19:45:44.915:29) : item=3D1 name=3D/bin/ba=
sh
inode=3D263600 dev=3D08:01 mode=3Dfile,755 ouid=3Droot ogid=3Droot rdev=3D0=
0:00
obj=3Dsystem_u:object_r:shell_exec_t:s0 nametype=3DNORMAL cap_fp=3Dnone
cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
type=3DPATH msg=3Daudit(11/05/19 19:45:44.915:29) : item=3D0
name=3D/sbin/e2scrub_all inode=3D263379 dev=3D08:01 mode=3Dfile,755 ouid=3D=
root
ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:fsadm_exec_t:s0
nametype=3DNORMAL cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
cap_frootid=3D0
type=3DCWD msg=3Daudit(11/05/19 19:45:44.915:29) : cwd=3D/
type=3DEXECVE msg=3Daudit(11/05/19 19:45:44.915:29) : argc=3D4 a0=3D/bin/ba=
sh
a1=3D/sbin/e2scrub_all a2=3D-A a3=3D-r
type=3DSYSCALL msg=3Daudit(11/05/19 19:45:44.915:29) : arch=3Dx86_64
syscall=3Dexecve success=3Dyes exit=3D0 a0=3D0x55e784f70b40 a1=3D0x55e78504=
dde0
a2=3D0x55e78502a200 a3=3D0x55e784f71240 items=3D3 ppid=3D1 pid=3D475 auid=
=3Dunset
uid=3Droot gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=
=3Droot
fsgid=3Droot tty=3D(none) ses=3Dunset comm=3De2scrub_all exe=3D/usr/bin/bas=
h
subj=3Dsystem_u:system_r:fsadm_t:s0 key=3D(null)
type=3DAVC msg=3Daudit(11/05/19 19:45:44.915:29) : avc:  granted  {
nnp_transition } for  pid=3D475 comm=3D(crub_all)
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:system_r:fsadm_t:s0 tclass=3Dprocess2
----
type=3DPROCTITLE msg=3Daudit(11/05/19 19:45:44.935:31) : proctitle=3D(d-log=
ind)
type=3DPATH msg=3Daudit(11/05/19 19:45:44.935:31) : item=3D1
name=3D/run/systemd/inhibit inode=3D14807 dev=3D00:15 mode=3Ddir,755 ouid=
=3Droot
ogid=3Droot rdev=3D00:00
obj=3Dsystem_u:object_r:systemd_logind_inhibit_runtime_t:s0
nametype=3DCREATE cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
cap_frootid=3D0
type=3DPATH msg=3Daudit(11/05/19 19:45:44.935:31) : item=3D0
name=3D/run/systemd/ inode=3D11588 dev=3D00:15 mode=3Ddir,755 ouid=3Droot
ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:systemd_runtime_t:s0
nametype=3DPARENT cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
cap_frootid=3D0
type=3DCWD msg=3Daudit(11/05/19 19:45:44.935:31) : cwd=3D/
type=3DSYSCALL msg=3Daudit(11/05/19 19:45:44.935:31) : arch=3Dx86_64
syscall=3Dmkdir success=3Dyes exit=3D0 a0=3D0x55e784f6aeb0 a1=3D0755 a2=3D0=
x0
a3=3D0x7 items=3D2 ppid=3D1 pid=3D481 auid=3Dunset uid=3Droot gid=3Droot eu=
id=3Droot
suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tty=3D(none)
ses=3Dunset comm=3D(d-logind) exe=3D/usr/lib/systemd/systemd
subj=3Dsystem_u:system_r:systemd_t:s0 key=3D(null)
type=3DAVC msg=3Daudit(11/05/19 19:45:44.935:31) : avc:  denied  { create
} for  pid=3D481 comm=3D(d-logind) name=3Dinhibit
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:object_r:systemd_logind_inhibit_runtime_t:s0
tclass=3Ddir permissive=3D1
----
type=3DPROCTITLE msg=3Daudit(11/05/19 19:45:44.959:35) :
proctitle=3D/usr/sbin/vnstatd -n
type=3DPATH msg=3Daudit(11/05/19 19:45:44.959:35) : item=3D1
name=3D/lib64/ld-linux-x86-64.so.2 inode=3D263996 dev=3D08:01 mode=3Dfile,7=
55
ouid=3Droot ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:ld_so_t:s0
nametype=3DNORMAL cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
cap_frootid=3D0
type=3DPATH msg=3Daudit(11/05/19 19:45:44.959:35) : item=3D0
name=3D/usr/sbin/vnstatd inode=3D262216 dev=3D08:01 mode=3Dfile,755 ouid=3D=
root
ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:vnstatd_exec_t:s0
nametype=3DNORMAL cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
cap_frootid=3D0
type=3DCWD msg=3Daudit(11/05/19 19:45:44.959:35) : cwd=3D/
type=3DEXECVE msg=3Daudit(11/05/19 19:45:44.959:35) : argc=3D2
a0=3D/usr/sbin/vnstatd a1=3D-n
type=3DSYSCALL msg=3Daudit(11/05/19 19:45:44.959:35) : arch=3Dx86_64
syscall=3Dexecve success=3Dyes exit=3D0 a0=3D0x55e784fe5500 a1=3D0x55e78500=
df40
a2=3D0x55e78501ae70 a3=3D0x55e784fe5580 items=3D2 ppid=3D1 pid=3D476 auid=
=3Dunset
uid=3Dvnstat gid=3Dvnstat euid=3Dvnstat suid=3Dvnstat fsuid=3Dvnstat egid=
=3Dvnstat
sgid=3Dvnstat fsgid=3Dvnstat tty=3D(none) ses=3Dunset comm=3Dvnstatd
exe=3D/usr/sbin/vnstatd subj=3Dsystem_u:system_r:vnstatd_t:s0 key=3D(null)
type=3DAVC msg=3Daudit(11/05/19 19:45:44.959:35) : avc:  granted  {
nnp_transition } for  pid=3D476 comm=3D(vnstatd)
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:system_r:vnstatd_t:s0 tclass=3Dprocess2
----
type=3DPROCTITLE msg=3Daudit(11/05/19 19:45:45.099:37) : proctitle=3D(d-log=
ind)
type=3DPATH msg=3Daudit(11/05/19 19:45:45.099:37) : item=3D1
name=3D/lib64/ld-linux-x86-64.so.2 inode=3D263996 dev=3D08:01 mode=3Dfile,7=
55
ouid=3Droot ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:ld_so_t:s0
nametype=3DNORMAL cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
cap_frootid=3D0
type=3DPATH msg=3Daudit(11/05/19 19:45:45.099:37) : item=3D0
name=3D/lib/systemd/systemd-logind inode=3D268205 dev=3D08:01 mode=3Dfile,7=
55
ouid=3Droot ogid=3Droot rdev=3D00:00
obj=3Dsystem_u:object_r:systemd_logind_exec_t:s0 nametype=3DNORMAL
cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
type=3DCWD msg=3Daudit(11/05/19 19:45:45.099:37) : cwd=3D/
type=3DEXECVE msg=3Daudit(11/05/19 19:45:45.099:37) : argc=3D1
a0=3D/lib/systemd/systemd-logind
type=3DBPRM_FCAPS msg=3Daudit(11/05/19 19:45:45.099:37) : fver=3D0 fp=3Dnon=
e
fi=3Dnone fe=3D0 old_pp=3Dchown,dac_override,dac_read_search,fowner,fsetid,=
kill,setgid,setuid,setpcap,linux_immutable,net_bind_service,net_broadcast,n=
et_admin,net_raw,ipc_lock,ipc_owner,sys_module,sys_rawio,sys_chroot,sys_ptr=
ace,sys_pacct,sys_admin,sys_boot,sys_nice,sys_resource,sys_time,sys_tty_con=
fig,mknod,lease,audit_write,audit_control,setfcap,mac_override,mac_admin,sy=
slog,wake_alarm,block_suspend,audit_read
old_pi=3Dnone old_pe=3Dchown,dac_override,dac_read_search,fowner,fsetid,kil=
l,setgid,setuid,setpcap,linux_immutable,net_bind_service,net_broadcast,net_=
admin,net_raw,ipc_lock,ipc_owner,sys_module,sys_rawio,sys_chroot,sys_ptrace=
,sys_pacct,sys_admin,sys_boot,sys_nice,sys_resource,sys_time,sys_tty_config=
,mknod,lease,audit_write,audit_control,setfcap,mac_override,mac_admin,syslo=
g,wake_alarm,block_suspend,audit_read
old_pa=3Dnone pp=3Dchown,dac_override,dac_read_search,fowner,linux_immutabl=
e,sys_admin,sys_tty_config,audit_control,mac_admin
pi=3Dnone pe=3Dchown,dac_override,dac_read_search,fowner,linux_immutable,sy=
s_admin,sys_tty_config,audit_control,mac_admin
pa=3Dnone frootid=3D0
type=3DSYSCALL msg=3Daudit(11/05/19 19:45:45.099:37) : arch=3Dx86_64
syscall=3Dexecve success=3Dyes exit=3D0 a0=3D0x55e784fb9a40 a1=3D0x55e78505=
0a20
a2=3D0x55e78502e650 a3=3D0x55e784fb9840 items=3D2 ppid=3D1 pid=3D481 auid=
=3Dunset
uid=3Droot gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=
=3Droot
fsgid=3Droot tty=3D(none) ses=3Dunset comm=3Dsystemd-logind
exe=3D/usr/lib/systemd/systemd-logind
subj=3Dsystem_u:system_r:systemd_logind_t:s0 key=3D(null)
type=3DAVC msg=3Daudit(11/05/19 19:45:45.099:37) : avc:  granted  {
nnp_transition } for  pid=3D481 comm=3D(d-logind)
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:system_r:systemd_logind_t:s0 tclass=3Dprocess2

>>>>>>>> log snippets


Somehow the source context is systemd_t, while the pid is not 1 (and
the proctitle is not systemd).
Is maybe the context transition in the `nnp_transition` case delayed?
