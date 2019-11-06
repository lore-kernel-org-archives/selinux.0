Return-Path: <SRS0=VC3m=Y6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EF1C5DF63
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 16:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F093A207FA
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 16:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VID82FFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfKFQmt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:42:49 -0500
Received: from mail-vk1-f170.google.com ([209.85.221.170]:44731 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfKFQmt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Nov 2019 11:42:49 -0500
Received: by mail-vk1-f170.google.com with SMTP id o198so5769474vko.11
        for <selinux@vger.kernel.org>; Wed, 06 Nov 2019 08:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ammZCAn1GUtDmbEKbm0tTB4ROYXHy+Eu0GhSjuokXWo=;
        b=VID82FFXLa+9jpv5fMPM1r3WLGj2kjW7qHlWfFqVwinkSSDJ4GjgrAzQtQrTyXLaww
         TUjOIzfTO80Qj/9PqDysG0nwDUhN1brGaZC65u6WAs0kSLlALUppWesbgc6wrqFVNhPZ
         oMFZJquusZ/EP9IfQOGylHY1r+yHIFkP95B7qRhimIlxDkg3hHeKja959Jjb8ruXLroE
         QKIClUfAvHjzn0y1vziyVXeEJOmEXYEqKPmJV+WzP9Mw930rd8yC19/X8q/f44MChqet
         4FZfOzhsOCuMikHYOS82GEQJaXb6bF292pwGB/r4jR5e2wt1Toxb4+oAGt+M9wQNxsqk
         47gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ammZCAn1GUtDmbEKbm0tTB4ROYXHy+Eu0GhSjuokXWo=;
        b=Tidlv4vgVZs565kMogmZSdYmmoaSPMB3FBpfj1bgyrFgCIReoiW7wTKhyJSKvaDGG3
         wkv5k89kEMY0nLIUVnSCTePnrJyc6Hkw4A7x7DyRKIZ+8LmPZMrHNuwSHCQNWUN9Pdym
         2zS7GaqZLHdOCfiPVlPitBoGPoZCpK2xRcS8/zVUBj5kFtWJ/KJCTWyZqUanr54mAFAX
         Qdz1bogWu7KVN70lB7d9OLrvsZ4xuzyRrp+gqWEY1Yq9ZeOUPyk1nezDX3jSp9YaVyv0
         0vq7l1T5X4Y/BrLfesXm8/2R9RR/z9Kxs0nuI+LZh4PdQIQyPdd7DvET/R1CCxvESKR8
         sKxQ==
X-Gm-Message-State: APjAAAVEgnRXkt+iy/6G/iDw/hlN8Uqnz12qYPVWwKRDR7/+Top9uvOB
        ThyNIQMl4YWZak8/ZgHyqPToRTQqxo03PoaR/tXWQlJDa/g=
X-Google-Smtp-Source: APXvYqwfgN72W/jEytwR1GQftIp0FMLYFZ873AZiuLnjG8REclGqNBiJ8mzQLQweoDELn5rRYaYU2iifP4LI9xSB+Cs=
X-Received: by 2002:a1f:7c01:: with SMTP id x1mr1788863vkc.15.1573058566318;
 Wed, 06 Nov 2019 08:42:46 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_Df4Mwf8eiatG92fywoCoEDpozYGz+jvPLRN8vcXy2a70g@mail.gmail.com>
 <57bbaee4-4338-30f2-3d12-bbf6a6aaabe6@tycho.nsa.gov>
In-Reply-To: <57bbaee4-4338-30f2-3d12-bbf6a6aaabe6@tycho.nsa.gov>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 6 Nov 2019 17:42:35 +0100
Message-ID: <CAJ2a_Dc9mxQzuhxrbhq90LMfDVx0i-33GPegrhxVeRgXg2A4zA@mail.gmail.com>
Subject: Re: Odd systemd source context for non pid 1 process
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> No.  Not sure what it is that you are seeing.  Maybe auditallow
> execute_no_trans or double check that your policy isn't allowing it
> (e.g. sesearch -A -s systemd_t -p execute_no_trans)

No execute_no_trans are logged (with an auditallow rule).
There is actually one execute_no_trans over itself (systemd_exec_t --
/usr/lib/systemd/systemd).
So systemd might re-exec or fork to get another pid.
But the pid in the denials is, in the case of systemd-logind, the
final pid of that daemon.

Also in the audit logs, the odd denial (e.g. 11/06/19 17:31:39.298:30)
is prior to the nnp_transition info (e.g. 11/06/19 17:31:39.466:35).


<<<<<<<< log snippets

$ ps -efZ | grep logind
system_u:system_r:systemd_logind_t:s0 root 478     1  0 17:31 ?
00:00:00 /lib/systemd/systemd-logind

type=3DPROCTITLE msg=3Daudit(11/06/19 17:31:39.298:30) : proctitle=3D(d-log=
ind)
type=3DPATH msg=3Daudit(11/06/19 17:31:39.298:30) : item=3D1
name=3D/run/systemd/inhibit inode=3D14431 dev=3D00:15 mode=3Ddir,755 ouid=
=3Droot
ogid=3Droot rdev=3D00:00
obj=3Dsystem_u:object_r:systemd_logind_inhibit_runtime_t:s0
nametype=3DCREATE cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
cap_frootid=3D0
type=3DPATH msg=3Daudit(11/06/19 17:31:39.298:30) : item=3D0
name=3D/run/systemd/ inode=3D10008 dev=3D00:15 mode=3Ddir,755 ouid=3Droot
ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:systemd_runtime_t:s0
nametype=3DPARENT cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
cap_frootid=3D0
type=3DCWD msg=3Daudit(11/06/19 17:31:39.298:30) : cwd=3D/
type=3DSYSCALL msg=3Daudit(11/06/19 17:31:39.298:30) : arch=3Dx86_64
syscall=3Dmkdir success=3Dyes exit=3D0 a0=3D0x559af6611a00 a1=3D0755 a2=3D0=
x0
a3=3D0x7 items=3D2 ppid=3D1 pid=3D478 auid=3Dunset uid=3Droot gid=3Droot eu=
id=3Droot
suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tty=3D(none)
ses=3Dunset comm=3D(d-logind) exe=3D/usr/lib/systemd/systemd
subj=3Dsystem_u:system_r:systemd_t:s0 key=3D(null)
type=3DAVC msg=3Daudit(11/06/19 17:31:39.298:30) : avc:  denied  { create
} for  pid=3D478 comm=3D(d-logind) name=3Dinhibit
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:object_r:systemd_logind_inhibit_runtime_t:s0
tclass=3Ddir permissive=3D1

.. later...

type=3DPROCTITLE msg=3Daudit(11/06/19 17:31:39.466:35) : proctitle=3D(d-log=
ind)
type=3DPATH msg=3Daudit(11/06/19 17:31:39.466:35) : item=3D1
name=3D/lib64/ld-linux-x86-64.so.2 inode=3D263996 dev=3D08:01 mode=3Dfile,7=
55
ouid=3Droot ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:ld_so_t:s0
nametype=3DNORMAL cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
cap_frootid=3D0
type=3DPATH msg=3Daudit(11/06/19 17:31:39.466:35) : item=3D0
name=3D/lib/systemd/systemd-logind inode=3D268205 dev=3D08:01 mode=3Dfile,7=
55
ouid=3Droot ogid=3Droot rdev=3D00:00
obj=3Dsystem_u:object_r:systemd_logind_exec_t:s0 nametype=3DNORMAL
cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
type=3DCWD msg=3Daudit(11/06/19 17:31:39.466:35) : cwd=3D/
type=3DEXECVE msg=3Daudit(11/06/19 17:31:39.466:35) : argc=3D1
a0=3D/lib/systemd/systemd-logind
type=3DBPRM_FCAPS msg=3Daudit(11/06/19 17:31:39.466:35) : fver=3D0 fp=3Dnon=
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
type=3DSYSCALL msg=3Daudit(11/06/19 17:31:39.466:35) : arch=3Dx86_64
syscall=3Dexecve success=3Dyes exit=3D0 a0=3D0x559af6603750 a1=3D0x559af66a=
d680
a2=3D0x559af6690250 a3=3D0x559af66035c0 items=3D2 ppid=3D1 pid=3D478 auid=
=3Dunset
uid=3Droot gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=
=3Droot
fsgid=3Droot tty=3D(none) ses=3Dunset comm=3Dsystemd-logind
exe=3D/usr/lib/systemd/systemd-logind
subj=3Dsystem_u:system_r:systemd_logind_t:s0 key=3D(null)
type=3DAVC msg=3Daudit(11/06/19 17:31:39.466:35) : avc:  granted  {
nnp_transition } for  pid=3D478 comm=3D(d-logind)
scontext=3Dsystem_u:system_r:systemd_t:s0
tcontext=3Dsystem_u:system_r:systemd_logind_t:s0 tclass=3Dprocess2


>>>>>>>> log snippets
