Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FFC4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0513F2146E
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amHme4tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfI0Ocs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:32:48 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:46262 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfI0Ocs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 10:32:48 -0400
Received: by mail-ed1-f41.google.com with SMTP id t3so2481992edw.13
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0EzJmLXHSH+rVdCQhTMGvpgSz++X9qC71hLIjJfQIPI=;
        b=amHme4tkqsbpiRO6eMaE0X7/vxFpNLjtPcaaVaRUEY9/V2Rp9h291eQDOFUv4qLWFi
         dDcnBqjFhUp2ChBUyVIS+VRCvH/mU7t8BvmBJArd9WURD68AI+Lhs5h/VWQHvGkidQBP
         BPR7gB1aRs018a+0yRiXwXoZcBwvhd5gg3Tlo7CPMkRtILE/Ldv9Tunl0T7FswUNURqt
         Vl3ALHToSFAaWMT3Dg9RCv4VHYEfeMj5mwPhakvIPnEB8g5PB+j3rthv7rjmeXBUYXQW
         kH+/WUbd2KDOxD7aZ/CrK+5rglJrb6gAbuehGbH4chx42/xJEQQ9wc7/YJ5urntqCR1u
         PlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0EzJmLXHSH+rVdCQhTMGvpgSz++X9qC71hLIjJfQIPI=;
        b=Lqu2UlHG18GmORDeKeV5fBf6owMT0QJ/b2Yuj4IGGz7EXQlJQgXbmM7PGp4hzNBoLW
         dbxx1Kl1MgcypcO/8Kxmi5eDJ/VQDukJLq9uB6NP6C2ezBHn8g+95PYbysdKkjkygsPK
         xKuCxPULVpINYaFIqZ/0tliCJExZxa0XjWx0bKIJRQ+fsXad4H578GP+3UhCZpOtrELV
         SB+C1H9w4ZYismqNYE6ujLsBB9u04GTiwbKBdFk/0/sU4/ehxF7W2s8fzHQxQyMluYW9
         WGhW6Us9BMF00bK8PLiV7zwXwX6+4aYjl4PBR+fFBMejVu4h6ho5zT2/TvozFtDdrICo
         vkqg==
X-Gm-Message-State: APjAAAVOnKZGQhK8DX00uCbe1xOsnTPbEQTcB2DgDg60B3/vJqmTMLmq
        iez9LplQ4OssXqU+MC6cIsF9kf6q
X-Google-Smtp-Source: APXvYqw8/gzK3HvaxLFCMq6ndxHCnw7hDSWCKSr/KughHnFyAMVTzPHUpg/846c3szHgQIMunoeTjw==
X-Received: by 2002:aa7:d386:: with SMTP id x6mr4862183edq.264.1569594764965;
        Fri, 27 Sep 2019 07:32:44 -0700 (PDT)
Received: from seamus.lan ([2001:985:d55d:0:6257:18ff:fe75:6e8f])
        by smtp.gmail.com with ESMTPSA id p4sm566627edc.38.2019.09.27.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 07:32:44 -0700 (PDT)
Date:   Fri, 27 Sep 2019 16:32:42 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
Message-ID: <20190927143242.GE22281@seamus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <20190927142835.GD22281@seamus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 04:28:35PM +0200, Dominick Grift wrote:
> On Fri, Sep 27, 2019 at 10:17:16AM -0400, Stephen Smalley wrote:
> > On 9/27/19 10:01 AM, Stephen Smalley wrote:
> > > On 9/27/19 9:57 AM, Dominick Grift wrote:
> > > > On Fri, Sep 27, 2019 at 09:51:26AM -0400, Stephen Smalley wrote:
> > > > > On 9/27/19 9:49 AM, Dominick Grift wrote:
> > > > > > On Fri, Sep 27, 2019 at 09:33:06AM -0400, Stephen Smalley wrote:
> > > > > > > On 9/27/19 9:08 AM, Dominick Grift wrote:
> > > > > > > > On Fri, Sep 27, 2019 at 08:59:26AM -0400, Stephen Smalley w=
rote:
> > > > > > > > > On 9/27/19 3:55 AM, Dominick Grift wrote:
> > > > > > > > > > sudo does not reset the role of my tty
> > > > > > > > > > properly [1], and i was wondering if anyone
> > > > > > > > > > is able to determine what is causing this
> > > > > > > > > > [2]
> > > > > > > > > >=20
> > > > > > > > > > [1] https://bugzilla.sudo.ws/show_bug.cgi?id=3D898
> > > > > > > > > > [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux=
=2Ec
> > > > > > > > >=20
> > > > > > > > > Are you sure sudo is calling selinux_restore_tty()?
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > running sudo with:
> > > > > > > >=20
> > > > > > > > Debug sudo /var/log/sudo_debug all@debug
> > > > > > > > Debug sudoers.so /var/log/sudo_debug all@debug
> > > > > > > >=20
> > > > > > > > Yields:
> > > > > > > >=20
> > > > > > > > grep selinux /var/log/sudo_debug
> > > > > > > > Sep 27 15:06:29 sudo[3417] <- sudo_new_key_val_v1 @
> > > > > > > > ../../../lib/util/key_val.c:61 :=3D
> > > > > > > > selinux_role=3Dsysadm.role
> > > > > > > > Sep 27 15:06:29 sudo[3417]=A0=A0=A0=A0 7: selinux_role=3Dsy=
sadm.role
> > > > > > > > Sep 27 15:06:29 sudo[3447] -> selinux_setup @ ../../src/sel=
inux.c:349
> > > > > > > > Sep 27 15:06:29 sudo[3447] -> get_exec_context @
> > > > > > > > ../../src/selinux.c:274
> > > > > > > > Sep 27 15:06:29 sudo[3447] <- get_exec_context @
> > > > > > > > ../../src/selinux.c:328 :=3D 0x564eed3621b0
> > > > > > > > Sep 27 15:06:29 sudo[3447] -> relabel_tty @ ../../src/selin=
ux.c:160
> > > > > > > > Sep 27 15:06:29 sudo[3447] <- relabel_tty @
> > > > > > > > ../../src/selinux.c:253 :=3D 0
> > > > > > > > Sep 27 15:06:29 sudo[3447] -> audit_role_change @
> > > > > > > > ../../src/selinux.c:76
> > > > > > > > Sep 27 15:06:29 sudo[3447] <- audit_role_change @
> > > > > > > > ../../src/selinux.c:98 :=3D 6
> > > > > > > > Sep 27 15:06:29 sudo[3447] <- selinux_setup @
> > > > > > > > ../../src/selinux.c:395 :=3D 0
> > > > > > > > Sep 27 15:06:29 sudo[3447] -> selinux_execve @
> > > > > > > > ../../src/selinux.c:405
> > > > > > > > Sep 27 15:06:29 sudo[3417] -> selinux_restore_tty @
> > > > > > > > ../../src/selinux.c:114
> > > > > > > > Sep 27 15:06:29 sudo[3417] <- selinux_restore_tty @
> > > > > > > > ../../src/selinux.c:142 :=3D 0
> > > > > > >=20
> > > > > > > Ok, so you entered and exited selinux_restore_tty() without e=
rror. No
> > > > > > > warning messages of any kind in any of the sudo logs? Not sur=
e where
> > > > > > > sudo_warn() and sudo_warnx() messages go.
> > > > > >=20
> > > > > > No warnings or any other clues. I guess it must be this then:
> > > > > >=20
> > > > > > =A0=A0=A0=A0=A0 if (se_state.ttyfd =3D=3D -1 || se_state.new_tt=
y_context =3D=3D NULL)
> > > > > > =A0=A0=A0=A0goto skip_relabel;
> > > > >=20
> > > > > That should only occur if there was no tty or security_compute_re=
label()
> > > > > didn't provide a new context to set in the first place. Not if
> > > > > it actually
> > > > > relabeled the tty earlier.
> > > > >=20
> > > > > Does newrole work correctly with your policy?
> > > >=20
> > > > Yes:
> > > >=20
> > > > kcinimod@seamus:~$ id -Z
> > > > wheel.id:wheel.role:wheel.subj:s0
> > > > kcinimod@seamus:~$ ls -alZ `tty`
> > > > crw--w----. 1 kcinimod tty
> > > > wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
> > > > 15:55 /dev/pts/10
> > > > kcinimod@seamus:~$ newrole -r sysadm.role
> > > > Password:
> > > > newrole: incorrect password for kcinimod
> > > > kcinimod@seamus:~$ ls -alZ `tty`
> > > > crw--w----. 1 kcinimod tty
> > > > wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
> > > > 15:56 /dev/pts/10
> > > > kcinimod@seamus:~$ newrole -r sysadm.role
> > > > Password:
> > > > kcinimod@seamus:~$ id -Z
> > > > wheel.id:sysadm.role:sysadm.subj:s0
> > > > kcinimod@seamus:~$ ls -alZ `tty`
> > > > crw--w----. 1 kcinimod tty
> > > > wheel.id:sysadm.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
> > > > 15:56 /dev/pts/10
> > > > kcinimod@seamus:~$ exit
> > > > logout
> > > > kcinimod@seamus:~$ ls -alZ `tty`
> > > > crw--w----. 1 kcinimod tty
> > > > wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
> > > > 15:56 /dev/pts/10
> > >=20
> > > Ok, so at least we know it is a bug in the sudo code somewhere.=A0 I'd
> > > assume that for some reason ttyfd or new_tty_context are either not
> > > being set in the first place or are being unset somewhere?
> >=20
> > Can you provide your sudo package version so I can be sure I'm looking =
at
> > the right sources?  The line numbers in your debug output don't quite a=
lign
> > with the current upstream.
>=20
> root@seamus:~# apt info sudo
> Package: sudo
> Version: 1.8.27-1+b1
> Priority: optional
> Section: admin
> Source: sudo (1.8.27-1)
> Maintainer: Bdale Garbee <bdale@gag.com>
> Installed-Size: 3,879 kB
> Depends: libaudit1 (>=3D 1:2.2.1), libc6 (>=3D 2.27), libpam0g (>=3D 0.99=
=2E7.1), libselinux1 (>=3D 1.32), libpam-modules, lsb-base
> Conflicts: sudo-ldap
> Replaces: sudo-ldap
> Homepage: http://www.sudo.ws/
> Tag: admin::login, admin::user-management, implemented-in::c,
>  interface::commandline, role::program, scope::utility,
>  security::authentication, use::login
> Download-Size: 1,244 kB
> APT-Manual-Installed: yes
> APT-Sources: http://mirror.nl.leaseweb.net/debian sid/main amd64 Packages
> Description: Provide limited super user privileges to specific users
>  Sudo is a program designed to allow a sysadmin to give limited root
>  privileges to users and log root activity.  The basic philosophy is to g=
ive
>  as few privileges as possible but still allow people to get their work d=
one.
>  .
>  This version is built with minimal shared library dependencies, use the
>  sudo-ldap package instead if you need LDAP support for sudoers.
>=20
> >=20
> >=20


this is on fedora:

sudo-1.8.27-3.fc31.x86_64

[kcinimod@agnus ~]$ id -Z
wheel.id:wheel.role:wheel.subj:s0
[kcinimod@agnus ~]$ ls -alZ `tty`
crw--w----. 1 kcinimod tty wheel.id:wheel.role:users.terminals.pty.pty_file=
:s0 136, 0 Sep 27 16:30 /dev/pts/0
[kcinimod@agnus ~]$ sudo id -Z
wheel.id:sysadm.role:sysadm.subj:s0
[kcinimod@agnus ~]$ ls -alZ `tty`
crw--w----. 1 kcinimod tty wheel.id:sysadm.role:users.terminals.pty.pty_fil=
e:s0 136, 0 Sep 27 16:31 /dev/pts/0
[kcinimod@agnus ~]$ sudo grep selinux /var/lib/sudo_debug
/usr/bin/grep: /var/lib/sudo_debug: No such file or directory
[kcinimod@agnus ~]$ sudo grep selinux /var/log/sudo_debug
Sep 27 16:31:06 sudo[68151] <- sudo_new_key_val_v1 @ ./key_val.c:61 :=3D se=
linux_role=3Dsysadm.role
Sep 27 16:31:06 sudo[68151]     7: selinux_role=3Dsysadm.role
Sep 27 16:31:06 sudo[68158] -> selinux_setup @ ./selinux.c:349
Sep 27 16:31:06 sudo[68158] -> get_exec_context @ ./selinux.c:274
Sep 27 16:31:06 sudo[68158] <- get_exec_context @ ./selinux.c:328 :=3D 0x56=
1fecaca550
Sep 27 16:31:06 sudo[68158] -> relabel_tty @ ./selinux.c:160
Sep 27 16:31:06 sudo[68158] <- relabel_tty @ ./selinux.c:253 :=3D 0
Sep 27 16:31:06 sudo[68158] -> audit_role_change @ ./selinux.c:76
Sep 27 16:31:06 sudo[68158] <- audit_role_change @ ./selinux.c:98 :=3D 6
Sep 27 16:31:06 sudo[68158] <- selinux_setup @ ./selinux.c:395 :=3D 0
Sep 27 16:31:06 sudo[68158] -> selinux_execve @ ./selinux.c:405
Sep 27 16:31:06 sudo[68151] -> selinux_restore_tty @ ./selinux.c:114
Sep 27 16:31:06 sudo[68151] <- selinux_restore_tty @ ./selinux.c:142 :=3D 0
Sep 27 16:31:23 sudo[68191] sudo_putenv: SUDO_COMMAND=3D/usr/bin/grep selin=
ux /var/lib/sudo_debug
Sep 27 16:31:23 sudo[68191] <- new_logline @ ./logging.c:1034 :=3D TTY=3Dpt=
s/0 ; PWD=3D/home/kcinimod ; USER=3Droot ; COMMAND=3D/usr/bin/grep selinux =
/var/lib/sudo_debug
Sep 27 16:31:23 sudo[68191] <- sudo_new_key_val_v1 @ ./key_val.c:61 :=3D se=
linux_role=3Dsysadm.role
Sep 27 16:31:23 sudo[68191]     7: selinux_role=3Dsysadm.role
Sep 27 16:31:23 sudo[68194] -> selinux_setup @ ./selinux.c:349
Sep 27 16:31:23 sudo[68194] -> get_exec_context @ ./selinux.c:274
Sep 27 16:31:23 sudo[68194] <- get_exec_context @ ./selinux.c:328 :=3D 0x55=
ec736b3430
Sep 27 16:31:23 sudo[68194] -> relabel_tty @ ./selinux.c:160
Sep 27 16:31:23 sudo[68194] <- relabel_tty @ ./selinux.c:253 :=3D 0
Sep 27 16:31:23 sudo[68194] -> audit_role_change @ ./selinux.c:76
Sep 27 16:31:23 sudo[68194] <- audit_role_change @ ./selinux.c:98 :=3D 5
Sep 27 16:31:23 sudo[68194] <- selinux_setup @ ./selinux.c:395 :=3D 0
Sep 27 16:31:23 sudo[68194] -> selinux_execve @ ./selinux.c:405
Sep 27 16:31:23 sudo[68194] exec /usr/libexec/sudo/sesh [sesh /usr/bin/grep=
 selinux /var/lib/sudo_debug] [HISTSIZE=3D1000 HOSTNAME=3Dagnus SSH_AUTH_SO=
CK=3D/run/user/9999/gnupg/S.gpg-agent.ssh LANG=3Den_US.UTF-8 LS_COLORS=3Ddi=
=3D38;5;33:ln=3D38;5;14:pi=3D38;5;11;40:so=3D38;5;13:bd=3D38;5;11;48;5;232:=
cd=3D33;48;5;232:or=3D38;5;196;48;5;232:mi=3D1;5;37;41:su=3D38;5;231;48;5;1=
96:sg=3D38;5;16;48;5;226:ca=3D38;5;226;48;5;196:tw=3D38;5;16;48;5;40:ow=3D3=
8;5;21;48;5;40:st=3D38;5;231;48;5;21:ex=3D38;5;40:*.nuv=3D38;5;13:*.m4v=3D3=
8;5;13:*.ogv=3D38;5;13:*.rpm=3D38;5;9:*.tz=3D38;5;9:*.pbm=3D38;5;13:*.rm=3D=
38;5;13:*.svg=3D38;5;13:*.tiff=3D38;5;13:*.xpm=3D38;5;13:*.m4a=3D38;5;45:*.=
cab=3D38;5;9:*.ogm=3D38;5;13:*.arj=3D38;5;9:*.mpg=3D38;5;13:*.ppm=3D38;5;13=
:*.zip=3D38;5;9:*.rz=3D38;5;9:*.ogx=3D38;5;13:*.fli=3D38;5;13:*.rar=3D38;5;=
9:*.pgm=3D38;5;13:*.deb=3D38;5;9:*.dwm=3D38;5;9:*.bz2=3D38;5;9:*.mid=3D38;5=
;45:*.alz=3D38;5;9:*.xspf=3D38;5;45:*.tgz=3D38;5;9:*.t7z=3D38;5;9:*.taz=3D3=
8;5;9:*.zst=3D38;5;9:*.lz=3D38;5;9:*.avi=3D38;5;13:*.webm=3D38;5;13:*.au=3D=
38;5;45:*.bz=3D38;5;9:*.flac=3D38;5;45:*.lz4=3D38;5;9:*.tzo=3D38;5;9:*.ogg=
=3D38;5;45:*.yuv=3D38;5;13:*.lzo=3D38;5;9:*.xbm=3D38;5;13:*.mng=3D38;5;13:*=
=2Excf=3D38;5;13:*.z=3D38;5;9:*.mjpeg=3D38;5;13:*.ace=3D38;5;9:*.midi=3D38;=
5;45:*.lha=3D38;5;9:*.war=3D38;5;9:*.mpeg=3D38;5;13:*.Z=3D38;5;9:*.dz=3D38;=
5;9:*.aac=3D38;5;45:*.mp4v=3D38;5;13:*.tif=3D38;5;13:*.wim=3D38;5;9:*.lzma=
=3D38;5;9:*.opus=3D38;5;45:*.oga=3D38;5;45:*.wav=3D38;5;45:*.tzst=3D38;5;9:=
*.arc=3D38;5;9:*.tlz=3D38;5;9:*.zoo=3D38;5;9:*.esd=3D38;5;9:*.rmvb=3D38;5;1=
3:*.tar=3D38;5;9:*.mp4=3D38;5;13:*.mka=3D38;5;45:*.tga=3D38;5;13:*.spx=3D38=
;5;45:*.jar=3D38;5;9:*.7z=3D38;5;9:*.flc=3D38;5;13:*.sar=3D38;5;9:*.png=3D3=
8;5;13:*.dl=3D38;5;13:*.gz=3D38;5;9:*.cpio=3D38;5;9:*.mjpg=3D38;5;13:*.gif=
=3D38;5;13:*.emf=3D38;5;13:*.asf=3D38;5;13:*.qt=3D38;5;13:*.xwd=3D38;5;13:*=
=2Empc=3D38;5;45:*.lzh=3D38;5;9:*.ear=3D38;5;9:*.m2v=3D38;5;13:*.vob=3D38;5=
;13:*.flv=3D38;5;13:*.ra=3D38;5;45:*.mkv=3D38;5;13:*.svgz=3D38;5;13:*.mov=
=3D38;5;13:*.swm=3D38;5;9:*.txz=3D38;5;9:*.pcx=3D38;5;13:*.gl=3D38;5;13:*.l=
rz=3D38;5;9:*.wmv=3D38;5;13:*.bmp=3D38;5;13:*.cgm=3D38;5;13:*.tbz2=3D38;5;9=
:*.xz=3D38;5;9:*.jpg=3D38;5;13:*.jpeg=3D38;5;13:*.mp3=3D38;5;45:*.tbz=3D38;=
5;9: TERM=3Dxterm-256color PS1=3D[\u@\h \W$(__git_ps1 " (%s)")]\$  MAIL=3D/=
var/spool/mail/kcinimod PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/us=
r/bin:/sbin:/bin LOGNAME=3Droot USER=3Droot HOME=3D/root SHELL=3D/bin/bash =
SUDO_COMMAND=3D/usr/bin/grep selinux /var/lib/sudo_debug SUDO_USER=3Dkcinim=
od SUDO_UID=3D9999 SUDO_GID=3D9999]
Sep 27 16:31:23 sudo[68191] -> selinux_restore_tty @ ./selinux.c:114
Sep 27 16:31:23 sudo[68191] <- selinux_restore_tty @ ./selinux.c:142 :=3D 0
Sep 27 16:31:29 sudo[68211] sudo_putenv: SUDO_COMMAND=3D/usr/bin/grep selin=
ux /var/log/sudo_debug
Sep 27 16:31:29 sudo[68211] <- new_logline @ ./logging.c:1034 :=3D TTY=3Dpt=
s/0 ; PWD=3D/home/kcinimod ; USER=3Droot ; COMMAND=3D/usr/bin/grep selinux =
/var/log/sudo_debug
Sep 27 16:31:29 sudo[68211] <- sudo_new_key_val_v1 @ ./key_val.c:61 :=3D se=
linux_role=3Dsysadm.role
Sep 27 16:31:29 sudo[68211]     7: selinux_role=3Dsysadm.role
Sep 27 16:31:29 sudo[68214] -> selinux_setup @ ./selinux.c:349
Sep 27 16:31:29 sudo[68214] -> get_exec_context @ ./selinux.c:274
Sep 27 16:31:29 sudo[68214] <- get_exec_context @ ./selinux.c:328 :=3D 0x55=
99c6ea8430
Sep 27 16:31:29 sudo[68214] -> relabel_tty @ ./selinux.c:160
Sep 27 16:31:29 sudo[68214] <- relabel_tty @ ./selinux.c:253 :=3D 0
Sep 27 16:31:29 sudo[68214] -> audit_role_change @ ./selinux.c:76
Sep 27 16:31:29 sudo[68214] <- audit_role_change @ ./selinux.c:98 :=3D 5
Sep 27 16:31:29 sudo[68214] <- selinux_setup @ ./selinux.c:395 :=3D 0
Sep 27 16:31:29 sudo[68214] -> selinux_execve @ ./selinux.c:405
Sep 27 16:31:29 sudo[68214] exec /usr/libexec/sudo/sesh [sesh /usr/bin/grep=
 selinux /var/log/sudo_debug] [HISTSIZE=3D1000 HOSTNAME=3Dagnus SSH_AUTH_SO=
CK=3D/run/user/9999/gnupg/S.gpg-agent.ssh LANG=3Den_US.UTF-8 LS_COLORS=3Ddi=
=3D38;5;33:ln=3D38;5;14:pi=3D38;5;11;40:so=3D38;5;13:bd=3D38;5;11;48;5;232:=
cd=3D33;48;5;232:or=3D38;5;196;48;5;232:mi=3D1;5;37;41:su=3D38;5;231;48;5;1=
96:sg=3D38;5;16;48;5;226:ca=3D38;5;226;48;5;196:tw=3D38;5;16;48;5;40:ow=3D3=
8;5;21;48;5;40:st=3D38;5;231;48;5;21:ex=3D38;5;40:*.nuv=3D38;5;13:*.m4v=3D3=
8;5;13:*.ogv=3D38;5;13:*.rpm=3D38;5;9:*.tz=3D38;5;9:*.pbm=3D38;5;13:*.rm=3D=
38;5;13:*.svg=3D38;5;13:*.tiff=3D38;5;13:*.xpm=3D38;5;13:*.m4a=3D38;5;45:*.=
cab=3D38;5;9:*.ogm=3D38;5;13:*.arj=3D38;5;9:*.mpg=3D38;5;13:*.ppm=3D38;5;13=
:*.zip=3D38;5;9:*.rz=3D38;5;9:*.ogx=3D38;5;13:*.fli=3D38;5;13:*.rar=3D38;5;=
9:*.pgm=3D38;5;13:*.deb=3D38;5;9:*.dwm=3D38;5;9:*.bz2=3D38;5;9:*.mid=3D38;5=
;45:*.alz=3D38;5;9:*.xspf=3D38;5;45:*.tgz=3D38;5;9:*.t7z=3D38;5;9:*.taz=3D3=
8;5;9:*.zst=3D38;5;9:*.lz=3D38;5;9:*.avi=3D38;5;13:*.webm=3D38;5;13:*.au=3D=
38;5;45:*.bz=3D38;5;9:*.flac=3D38;5;45:*.lz4=3D38;5;9:*.tzo=3D38;5;9:*.ogg=
=3D38;5;45:*.yuv=3D38;5;13:*.lzo=3D38;5;9:*.xbm=3D38;5;13:*.mng=3D38;5;13:*=
=2Excf=3D38;5;13:*.z=3D38;5;9:*.mjpeg=3D38;5;13:*.ace=3D38;5;9:*.midi=3D38;=
5;45:*.lha=3D38;5;9:*.war=3D38;5;9:*.mpeg=3D38;5;13:*.Z=3D38;5;9:*.dz=3D38;=
5;9:*.aac=3D38;5;45:*.mp4v=3D38;5;13:*.tif=3D38;5;13:*.wim=3D38;5;9:*.lzma=
=3D38;5;9:*.opus=3D38;5;45:*.oga=3D38;5;45:*.wav=3D38;5;45:*.tzst=3D38;5;9:=
*.arc=3D38;5;9:*.tlz=3D38;5;9:*.zoo=3D38;5;9:*.esd=3D38;5;9:*.rmvb=3D38;5;1=
3:*.tar=3D38;5;9:*.mp4=3D38;5;13:*.mka=3D38;5;45:*.tga=3D38;5;13:*.spx=3D38=
;5;45:*.jar=3D38;5;9:*.7z=3D38;5;9:*.flc=3D38;5;13:*.sar=3D38;5;9:*.png=3D3=
8;5;13:*.dl=3D38;5;13:*.gz=3D38;5;9:*.cpio=3D38;5;9:*.mjpg=3D38;5;13:*.gif=
=3D38;5;13:*.emf=3D38;5;13:*.asf=3D38;5;13:*.qt=3D38;5;13:*.xwd=3D38;5;13:*=
=2Empc=3D38;5;45:*.lzh=3D38;5;9:*.ear=3D38;5;9:*.m2v=3D38;5;13:*.vob=3D38;5=
;13:*.flv=3D38;5;13:*.ra=3D38;5;45:*.mkv=3D38;5;13:*.svgz=3D38;5;13:*.mov=
=3D38;5;13:*.swm=3D38;5;9:*.txz=3D38;5;9:*.pcx=3D38;5;13:*.gl=3D38;5;13:*.l=
rz=3D38;5;9:*.wmv=3D38;5;13:*.bmp=3D38;5;13:*.cgm=3D38;5;13:*.tbz2=3D38;5;9=
:*.xz=3D38;5;9:*.jpg=3D38;5;13:*.jpeg=3D38;5;13:*.mp3=3D38;5;45:*.tbz=3D38;=
5;9: TERM=3Dxterm-256color PS1=3D[\u@\h \W$(__git_ps1 " (%s)")]\$  MAIL=3D/=
var/spool/mail/kcinimod PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/us=
r/bin:/sbin:/bin LOGNAME=3Droot USER=3Droot HOME=3D/root SHELL=3D/bin/bash =
SUDO_COMMAND=3D/usr/bin/grep selinux /var/log/sudo_debug SUDO_USER=3Dkcinim=
od SUDO_UID=3D9999 SUDO_GID=3D9999]

>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2OHYUACgkQJXSOVTf5
R2lWxAv/TjbTK3vm7KHjm0GhVCzWnXuUTEE5LHWFT9PeADTK7lLohN0SS240GMGI
qGVdLYPU4r6027oszeRVAIkfV/6UZSd5FTNcZncWuli2xbglYdzwsGl+r/8c1TzA
x7oQUr2X3Mblp42c+dZwqW1Ks2rjlKOtfSWZH3/kiYbWo53hs9xotUbWMOjO9NvD
t+ZZQiS32UWKnSB2QR37hppf1ML5KUrT+gTPk4ABEcTg76XmwsPsNpNtgUNvfc/V
hQXWLkmfR9dEq3BHMZ1sNYx1ljqRQT4dol+fCxX0BAUwfV3weR2XPVpz8BCtXEg9
h8qkMwcz3jxc+nigg64AXdXQWkUcV1XGW1gVcFb7HjC46cWwKseJBqIyXXo/kPs+
AjOfrxG1OuYp7G4TB1jM3sReEa0oaBFMmyLwMNDduLqg9KgPhcHMtynQICtIDRg+
h0paMtYOe+YhguGCV8BiR5ZOZfxv3UIYPtNY/vTJhjndrWb1bIHr3qR4v5N9h2ex
Y4GzUnbv
=AIgl
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
