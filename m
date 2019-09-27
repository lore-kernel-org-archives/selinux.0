Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86EEC4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 13:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7052B217D7
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 13:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXgv/ZNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfI0N5v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:57:51 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43005 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0N5v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 09:57:51 -0400
Received: by mail-ed1-f47.google.com with SMTP id y91so2387836ede.9
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TU3DUxR4arfKtdiT7wWJmygTftL+e43m43btzv0qzuI=;
        b=FXgv/ZNdHBBxwgwXRsy5IVXSfTBwq8HGVACsy689yBTGzM/NYr/mdCasbnJV2yP/CT
         Hhdmk61uYQsJGFcbUvCh6O0aWk4Fdi/j9pUJD9W4RcdDzdKcgWfBRt32QIOHZicfZcgP
         DI23cNsSPBiNKAbqWtBumOMT9D/h7A92wnJIaoEud4ITqQjsAhZOeg1EkDdboHAKPP4I
         2bE8NuYDmNkMox6sOWzGIHn5Eu3brZweU4QKJV2mSO+1OJu9R55HuhSIFEjcomPcv9pG
         +IPXhSWC2W7J6MjXioGFfbCds6mTusdlFnSC3bAlb0Bi3qWBeZu6O/lKzvmg0nr5vpmb
         t+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TU3DUxR4arfKtdiT7wWJmygTftL+e43m43btzv0qzuI=;
        b=QvuLDolRfn5opuZFHCS/3ZhfJAJG3NYCgJgbIt6QMKzYQtYEpYTItUfTLGHHiYo7rn
         9+eaAwlj1jSM8WPrDMdx9sxA9NQFQwW2ooQvbLSsnopZwNiOngA8AZg9i+cASMUnGAXi
         /eF+9rdnRfWPVVn1Vog5jfyoOxrvLPX9+BlCoVWTJOZOzlLMzJTIqX9d6PDGVbNn2iK2
         N+Rdd7GEF0Hug0mVZSEU5JFQF2gRtH8o4sBDhunCRcXcFAKjY+itgZ8UcxAAlmgCazb1
         I4prb20LdhYRVIX0Ns/5FQWHbTvoXolzsvta5D3DrqAuYVcJvlQbuUc/21r7WR3PS4lR
         85nQ==
X-Gm-Message-State: APjAAAV7EgHdLxiH+NqGYvjDM35FYHgMlMRdT9+zgiy7D8ne+MVMNVI3
        7yl7Po4ABn32o/M8vrLC+CsnVAts
X-Google-Smtp-Source: APXvYqwtCtp6PXYgjCk0RFq6P7KSw/GwOddikcJu1xJMJhj6vWnJMFS/Wz34m+g0py1sgE1A10sfdA==
X-Received: by 2002:a17:906:7d13:: with SMTP id u19mr1479021ejo.311.1569592667827;
        Fri, 27 Sep 2019 06:57:47 -0700 (PDT)
Received: from seamus.lan ([2001:985:d55d:0:6257:18ff:fe75:6e8f])
        by smtp.gmail.com with ESMTPSA id 60sm550031edg.10.2019.09.27.06.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:57:46 -0700 (PDT)
Date:   Fri, 27 Sep 2019 15:57:45 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
Message-ID: <20190927135745.GC22281@seamus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20190927075507.GA20555@seamus.lan>
 <0fb7bf1f-f13b-3bec-7b91-53460dfbe265@tycho.nsa.gov>
 <20190927130805.GA22281@seamus.lan>
 <1aefe0bf-ab82-3b41-7f49-5a540ab8f7f9@tycho.nsa.gov>
 <20190927134908.GB22281@seamus.lan>
 <caf2c1c0-682b-1ff6-aee9-cc91dd6ad8a6@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <caf2c1c0-682b-1ff6-aee9-cc91dd6ad8a6@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 09:51:26AM -0400, Stephen Smalley wrote:
> On 9/27/19 9:49 AM, Dominick Grift wrote:
> > On Fri, Sep 27, 2019 at 09:33:06AM -0400, Stephen Smalley wrote:
> > > On 9/27/19 9:08 AM, Dominick Grift wrote:
> > > > On Fri, Sep 27, 2019 at 08:59:26AM -0400, Stephen Smalley wrote:
> > > > > On 9/27/19 3:55 AM, Dominick Grift wrote:
> > > > > > sudo does not reset the role of my tty properly [1], and i was =
wondering if anyone is able to determine what is causing this [2]
> > > > > >=20
> > > > > > [1] https://bugzilla.sudo.ws/show_bug.cgi?id=3D898
> > > > > > [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c
> > > > >=20
> > > > > Are you sure sudo is calling selinux_restore_tty()?
> > > > >=20
> > > > >=20
> > > >=20
> > > > running sudo with:
> > > >=20
> > > > Debug sudo /var/log/sudo_debug all@debug
> > > > Debug sudoers.so /var/log/sudo_debug all@debug
> > > >=20
> > > > Yields:
> > > >=20
> > > > grep selinux /var/log/sudo_debug
> > > > Sep 27 15:06:29 sudo[3417] <- sudo_new_key_val_v1 @ ../../../lib/ut=
il/key_val.c:61 :=3D selinux_role=3Dsysadm.role
> > > > Sep 27 15:06:29 sudo[3417]     7: selinux_role=3Dsysadm.role
> > > > Sep 27 15:06:29 sudo[3447] -> selinux_setup @ ../../src/selinux.c:3=
49
> > > > Sep 27 15:06:29 sudo[3447] -> get_exec_context @ ../../src/selinux.=
c:274
> > > > Sep 27 15:06:29 sudo[3447] <- get_exec_context @ ../../src/selinux.=
c:328 :=3D 0x564eed3621b0
> > > > Sep 27 15:06:29 sudo[3447] -> relabel_tty @ ../../src/selinux.c:160
> > > > Sep 27 15:06:29 sudo[3447] <- relabel_tty @ ../../src/selinux.c:253=
 :=3D 0
> > > > Sep 27 15:06:29 sudo[3447] -> audit_role_change @ ../../src/selinux=
=2Ec:76
> > > > Sep 27 15:06:29 sudo[3447] <- audit_role_change @ ../../src/selinux=
=2Ec:98 :=3D 6
> > > > Sep 27 15:06:29 sudo[3447] <- selinux_setup @ ../../src/selinux.c:3=
95 :=3D 0
> > > > Sep 27 15:06:29 sudo[3447] -> selinux_execve @ ../../src/selinux.c:=
405
> > > > Sep 27 15:06:29 sudo[3417] -> selinux_restore_tty @ ../../src/selin=
ux.c:114
> > > > Sep 27 15:06:29 sudo[3417] <- selinux_restore_tty @ ../../src/selin=
ux.c:142 :=3D 0
> > >=20
> > > Ok, so you entered and exited selinux_restore_tty() without error. No
> > > warning messages of any kind in any of the sudo logs? Not sure where
> > > sudo_warn() and sudo_warnx() messages go.
> >=20
> > No warnings or any other clues. I guess it must be this then:
> >=20
> >      if (se_state.ttyfd =3D=3D -1 || se_state.new_tty_context =3D=3D NU=
LL)
> > 	goto skip_relabel;
>=20
> That should only occur if there was no tty or security_compute_relabel()
> didn't provide a new context to set in the first place. Not if it actually
> relabeled the tty earlier.
>=20
> Does newrole work correctly with your policy?

Yes:

kcinimod@seamus:~$ id -Z
wheel.id:wheel.role:wheel.subj:s0
kcinimod@seamus:~$ ls -alZ `tty`
crw--w----. 1 kcinimod tty wheel.id:wheel.role:users.terminals.pty.pty_file=
:s0 136, 10 Sep 27 15:55 /dev/pts/10
kcinimod@seamus:~$ newrole -r sysadm.role
Password:=20
newrole: incorrect password for kcinimod
kcinimod@seamus:~$ ls -alZ `tty`
crw--w----. 1 kcinimod tty wheel.id:wheel.role:users.terminals.pty.pty_file=
:s0 136, 10 Sep 27 15:56 /dev/pts/10
kcinimod@seamus:~$ newrole -r sysadm.role
Password:=20
kcinimod@seamus:~$ id -Z
wheel.id:sysadm.role:sysadm.subj:s0
kcinimod@seamus:~$ ls -alZ `tty`
crw--w----. 1 kcinimod tty wheel.id:sysadm.role:users.terminals.pty.pty_fil=
e:s0 136, 10 Sep 27 15:56 /dev/pts/10
kcinimod@seamus:~$ exit
logout
kcinimod@seamus:~$ ls -alZ `tty`
crw--w----. 1 kcinimod tty wheel.id:wheel.role:users.terminals.pty.pty_file=
:s0 136, 10 Sep 27 15:56 /dev/pts/10

>=20
> >=20
> > >=20
> > > selinux_restore_tty() does a goto skip_relabel in multiple cases:
> > > - if there was no tty (ttyfd =3D=3D -1),
> > > - if we didn't set a new tty context (new_tty_context),
> > > - if the context on the tty was changed from the value set by sudo
> > > (strcmp...) e.g. some other process changed it in the interim, but th=
is
> > > should have logged a warning,
> > >=20
>=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2OFVQACgkQJXSOVTf5
R2lEHwv/Uj7AhPbNaMFfipOeJgKLwlfji0nJEwITJNvgrVU6ho6o7iUtMK26i1HK
iB3nQb+xnn27hJsdEjJbitLg65lidFlhKkaQRLnazw+Y/RTcRZYNlQ3ZKixGwfsq
kVaSun5DHolIA8SH2e9mxEaDd+Z3HZqHipBWmsC9XQI0IoNDkkKJSpMrjpo5f+EL
/8q5jq0m79mJVFo6bVlRbKjjaOtm4qWaJyuOvKZhbODCwliIaC0Czhy3/H7eo7dE
xK7CNaxLhKhzBhYUsqBqQI/peoBaJvBL3ZahyF6y1Yh1ZrlozWR45c3rhxrxgbIR
6zZ5OMmCfckx/YpXPZDtALO4KfKOpQp2hGxW1G/iK3iPlfqH29UnAUUoyy1CocCU
XbNbNxKRzN5TU03JY0eSXLRM4KVbKwnHpgf7ymDS4oJPKEGnVPsSn+mwIQIHMHNr
BGOOlaY1SKP7OJXJL292U64TA03TgIM8NVjCvPJ4h0wVf5vhLw/nd/RXItcMsISi
miH/OYZa
=lPwn
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
