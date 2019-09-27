Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F55C4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC982146E
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf16hiuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfI0O2m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:28:42 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42530 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0O2m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 10:28:42 -0400
Received: by mail-ed1-f52.google.com with SMTP id y91so2482749ede.9
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Sh1FTJ+D4NidNnvQCgbtd5fSEY+Uh2QCqbpHNYJMv4=;
        b=nf16hiuPfIUWRcffhKx7+Okhy8SuS+GBiQUnGGXthb8FhMm54BY2k+Wnkbw9DnIRze
         hfQDu5yBOeNZcuLbwipLoKEmEhSL7dnI7JB4uf3K/rD4iCaDftbIeIa7LLzzXlH3ElCe
         6IKyAHUAfDZKTDU3TxZRSPbfNgEJDA5N5KudFBYAZDsZjE8KtPM5pJHusLqG0+0FwG8c
         /f6OYo1WbpAepZvasfnbqNFfPc907tia04nW1bjcWkBfApcOtQHqXYIBbnrujMWVZutQ
         V/4VYW7vgqCXPN6E//muksJHHxGIZB0Vw17Qp0/h/nv1Un5QfLA+Sfkd9Vu5kUQUyw/n
         xD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5Sh1FTJ+D4NidNnvQCgbtd5fSEY+Uh2QCqbpHNYJMv4=;
        b=XD+L7pqTTwwEkvXTBq0SsmlXWwzV/7ThfjKMHCLNkdex3QhvOP0kxaPY0y2ElH2sCK
         mk9q2KP3GVVjylLgofALTRlzzsd0z3dUexeojhPQZ/B5uwfd0okJGayfwLNVws0PKRIa
         799+1c+nr4IhOdIca4QQtoNqBfzHDTU7vSQfgJkH44IZEwRkzdlr6/ee3TLLC3RW79Hs
         vIwPN+xeFJfLlsFe91CH3uly6y1MC21YCzjQmKDpp5UavVdJsQkDXmohH/9hClcyJ/Lo
         WJf/EMcVDRT0SVnF+FsOzn3XjvY41U9pXlBBXtaLtC/XiF0SbvLGk9psUQe+b5Zgr7Zm
         xUMA==
X-Gm-Message-State: APjAAAWjspr1U/vAI0dLqC1M/AA6Euhlz7nzenW4vKXP2Zopb1aSN62G
        GYSHY/ViKerYDSmmAM1C9iE=
X-Google-Smtp-Source: APXvYqyvYfvfGzWxqfS03CItiJ8ZJUFh62Rxg53sBkZnGj5fRu1bExIwSkolTU01AfrCQfEZRvQ9lQ==
X-Received: by 2002:a05:6402:6c6:: with SMTP id n6mr4769144edy.162.1569594518523;
        Fri, 27 Sep 2019 07:28:38 -0700 (PDT)
Received: from seamus.lan ([2001:985:d55d:0:6257:18ff:fe75:6e8f])
        by smtp.gmail.com with ESMTPSA id b16sm603107eju.74.2019.09.27.07.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 07:28:37 -0700 (PDT)
Date:   Fri, 27 Sep 2019 16:28:35 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
Message-ID: <20190927142835.GD22281@seamus.lan>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <62b05709-3e3c-e333-5f2e-a18defb2b8cd@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 10:17:16AM -0400, Stephen Smalley wrote:
> On 9/27/19 10:01 AM, Stephen Smalley wrote:
> > On 9/27/19 9:57 AM, Dominick Grift wrote:
> > > On Fri, Sep 27, 2019 at 09:51:26AM -0400, Stephen Smalley wrote:
> > > > On 9/27/19 9:49 AM, Dominick Grift wrote:
> > > > > On Fri, Sep 27, 2019 at 09:33:06AM -0400, Stephen Smalley wrote:
> > > > > > On 9/27/19 9:08 AM, Dominick Grift wrote:
> > > > > > > On Fri, Sep 27, 2019 at 08:59:26AM -0400, Stephen Smalley wro=
te:
> > > > > > > > On 9/27/19 3:55 AM, Dominick Grift wrote:
> > > > > > > > > sudo does not reset the role of my tty
> > > > > > > > > properly [1], and i was wondering if anyone
> > > > > > > > > is able to determine what is causing this
> > > > > > > > > [2]
> > > > > > > > >=20
> > > > > > > > > [1] https://bugzilla.sudo.ws/show_bug.cgi?id=3D898
> > > > > > > > > [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c
> > > > > > > >=20
> > > > > > > > Are you sure sudo is calling selinux_restore_tty()?
> > > > > > > >=20
> > > > > > > >=20
> > > > > > >=20
> > > > > > > running sudo with:
> > > > > > >=20
> > > > > > > Debug sudo /var/log/sudo_debug all@debug
> > > > > > > Debug sudoers.so /var/log/sudo_debug all@debug
> > > > > > >=20
> > > > > > > Yields:
> > > > > > >=20
> > > > > > > grep selinux /var/log/sudo_debug
> > > > > > > Sep 27 15:06:29 sudo[3417] <- sudo_new_key_val_v1 @
> > > > > > > ../../../lib/util/key_val.c:61 :=3D
> > > > > > > selinux_role=3Dsysadm.role
> > > > > > > Sep 27 15:06:29 sudo[3417]=A0=A0=A0=A0 7: selinux_role=3Dsysa=
dm.role
> > > > > > > Sep 27 15:06:29 sudo[3447] -> selinux_setup @ ../../src/selin=
ux.c:349
> > > > > > > Sep 27 15:06:29 sudo[3447] -> get_exec_context @
> > > > > > > ../../src/selinux.c:274
> > > > > > > Sep 27 15:06:29 sudo[3447] <- get_exec_context @
> > > > > > > ../../src/selinux.c:328 :=3D 0x564eed3621b0
> > > > > > > Sep 27 15:06:29 sudo[3447] -> relabel_tty @ ../../src/selinux=
=2Ec:160
> > > > > > > Sep 27 15:06:29 sudo[3447] <- relabel_tty @
> > > > > > > ../../src/selinux.c:253 :=3D 0
> > > > > > > Sep 27 15:06:29 sudo[3447] -> audit_role_change @
> > > > > > > ../../src/selinux.c:76
> > > > > > > Sep 27 15:06:29 sudo[3447] <- audit_role_change @
> > > > > > > ../../src/selinux.c:98 :=3D 6
> > > > > > > Sep 27 15:06:29 sudo[3447] <- selinux_setup @
> > > > > > > ../../src/selinux.c:395 :=3D 0
> > > > > > > Sep 27 15:06:29 sudo[3447] -> selinux_execve @
> > > > > > > ../../src/selinux.c:405
> > > > > > > Sep 27 15:06:29 sudo[3417] -> selinux_restore_tty @
> > > > > > > ../../src/selinux.c:114
> > > > > > > Sep 27 15:06:29 sudo[3417] <- selinux_restore_tty @
> > > > > > > ../../src/selinux.c:142 :=3D 0
> > > > > >=20
> > > > > > Ok, so you entered and exited selinux_restore_tty() without err=
or. No
> > > > > > warning messages of any kind in any of the sudo logs? Not sure =
where
> > > > > > sudo_warn() and sudo_warnx() messages go.
> > > > >=20
> > > > > No warnings or any other clues. I guess it must be this then:
> > > > >=20
> > > > > =A0=A0=A0=A0=A0 if (se_state.ttyfd =3D=3D -1 || se_state.new_tty_=
context =3D=3D NULL)
> > > > > =A0=A0=A0=A0goto skip_relabel;
> > > >=20
> > > > That should only occur if there was no tty or security_compute_rela=
bel()
> > > > didn't provide a new context to set in the first place. Not if
> > > > it actually
> > > > relabeled the tty earlier.
> > > >=20
> > > > Does newrole work correctly with your policy?
> > >=20
> > > Yes:
> > >=20
> > > kcinimod@seamus:~$ id -Z
> > > wheel.id:wheel.role:wheel.subj:s0
> > > kcinimod@seamus:~$ ls -alZ `tty`
> > > crw--w----. 1 kcinimod tty
> > > wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
> > > 15:55 /dev/pts/10
> > > kcinimod@seamus:~$ newrole -r sysadm.role
> > > Password:
> > > newrole: incorrect password for kcinimod
> > > kcinimod@seamus:~$ ls -alZ `tty`
> > > crw--w----. 1 kcinimod tty
> > > wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
> > > 15:56 /dev/pts/10
> > > kcinimod@seamus:~$ newrole -r sysadm.role
> > > Password:
> > > kcinimod@seamus:~$ id -Z
> > > wheel.id:sysadm.role:sysadm.subj:s0
> > > kcinimod@seamus:~$ ls -alZ `tty`
> > > crw--w----. 1 kcinimod tty
> > > wheel.id:sysadm.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
> > > 15:56 /dev/pts/10
> > > kcinimod@seamus:~$ exit
> > > logout
> > > kcinimod@seamus:~$ ls -alZ `tty`
> > > crw--w----. 1 kcinimod tty
> > > wheel.id:wheel.role:users.terminals.pty.pty_file:s0 136, 10 Sep 27
> > > 15:56 /dev/pts/10
> >=20
> > Ok, so at least we know it is a bug in the sudo code somewhere.=A0 I'd
> > assume that for some reason ttyfd or new_tty_context are either not
> > being set in the first place or are being unset somewhere?
>=20
> Can you provide your sudo package version so I can be sure I'm looking at
> the right sources?  The line numbers in your debug output don't quite ali=
gn
> with the current upstream.

root@seamus:~# apt info sudo
Package: sudo
Version: 1.8.27-1+b1
Priority: optional
Section: admin
Source: sudo (1.8.27-1)
Maintainer: Bdale Garbee <bdale@gag.com>
Installed-Size: 3,879 kB
Depends: libaudit1 (>=3D 1:2.2.1), libc6 (>=3D 2.27), libpam0g (>=3D 0.99.7=
=2E1), libselinux1 (>=3D 1.32), libpam-modules, lsb-base
Conflicts: sudo-ldap
Replaces: sudo-ldap
Homepage: http://www.sudo.ws/
Tag: admin::login, admin::user-management, implemented-in::c,
 interface::commandline, role::program, scope::utility,
 security::authentication, use::login
Download-Size: 1,244 kB
APT-Manual-Installed: yes
APT-Sources: http://mirror.nl.leaseweb.net/debian sid/main amd64 Packages
Description: Provide limited super user privileges to specific users
 Sudo is a program designed to allow a sysadmin to give limited root
 privileges to users and log root activity.  The basic philosophy is to give
 as few privileges as possible but still allow people to get their work don=
e.
 .
 This version is built with minimal shared library dependencies, use the
 sudo-ldap package instead if you need LDAP support for sudoers.

>=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2OHI8ACgkQJXSOVTf5
R2lPIwwAtkW/uXXZbe1icpTuXRyyIhS1Jl1aFp6g/iaB7fufDrwj9LC9AJrxh+jw
VHb1sHOyM5b77wSVBhkoOQQAB+96sTxLkyyU/ofOZ0QYuvUc925uRHUmhsGAP+Hm
DoKv76crDhmCDhqT7a8pGslsB7P2/EjI1aH9GOeEaOOVkGCwMoyZn0v+3todOvE3
kyAf/gRt334euLRjxB2iDX/aipaJMgVEUcqtJodSWmhGAqjQXMEJOw8aWZX+d+vw
dj9XPYGY2Qa6pStpSPj+QQKy139YCIX6DgAH9sEUH05YvkTSk8s8n61wW1JUt3aK
+w09pqKPuVbGREmlO3NH7PHQOpl5GHT50DvrDolsHGuOuzWKZDLte6II6+1+Ujip
mCarUx0w8/SUp39X7HCd8o4AfUvTKQZbQXnYJL6b3yg9CtaD7TDVbr/CexADJovH
bqJHaTrtRu2AKVn1apdBsTG/szoEhCoCmj6mrQHLeIkZchDsHGEdM/qcvxFdiAF0
vNR15OxB
=6K4U
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
