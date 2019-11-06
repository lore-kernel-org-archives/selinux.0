Return-Path: <SRS0=VC3m=Y6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2437AC5DF65
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 16:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28E72166E
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 16:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjgsQl2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbfKFQsR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:48:17 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:37427 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731934AbfKFQsR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Nov 2019 11:48:17 -0500
Received: by mail-wm1-f53.google.com with SMTP id q130so4194309wme.2
        for <selinux@vger.kernel.org>; Wed, 06 Nov 2019 08:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cUIFudIPdO9vuSRHq7HqmWNQHe0dPH4stgt8FIBTOhE=;
        b=XjgsQl2WLETJ0niAFNvC1MnDdiWNNwmscMfXOOhsFTW8D/iB4coMBdFchkseudQAmm
         7+QrlL4bVRLleD6fk2GxV6J8dZvpm3x98OhthCN489H0n/nqoItUSczmz19BGiBa7o+M
         UwJUFM04WgQ7JxaHNJ7r+XsETGGqf+d39uDA3E84770cAYypv4EQsL/SSKITEIEDrpTZ
         iul9hFs51zNLHMxHHvo2vOwlJ9zZ4wRdWRpZ96XQywCYeYhXLKYZDzzsFJJ8eUCjBw3q
         /WetbR/NBVFZ2bFhvM1tsJX3TUjhR11TffcTtoD6v0NiFzg5Dt/U8ykNEzTBWBQZ00UR
         OVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=cUIFudIPdO9vuSRHq7HqmWNQHe0dPH4stgt8FIBTOhE=;
        b=PxoBfbVL3gKxYvkM2D4j00ak333BX6p6NKISeVL468x6Xsa9MR2vGaOs5pdTciTI5U
         XGnMQ1eeYzS1ogKA/IFk51+XrGgu2SDXlfmf/OfOcX2EELMw05d+ca2ro6MNj2f/m+/O
         5Ch/FD5KX9ZMnvp1gTxU+b9Ej3PpLaoI4egSxyfS5CtmgP+xCV9TXuGbjtUYbEoXouZ5
         EY9ojOsiTAJr/Ox6Qjdc3f5HWt5ZR5cB2XyenyNF4A3flTYZ7Y1BCvqlUsEwt7hWGLT6
         z5IYNiW55Sbz5d0CfNfy8reLb4ZXxUoXja4IhJ7YLTeL6a7bYpwyYmqnlc0q7JHLtLm1
         YjfA==
X-Gm-Message-State: APjAAAW7spTa1sP/9WmNN7XeOSzUDAAkKG8IGl9DSUgdoq1PAUtOtoPn
        K8C8YpYGK+htOh5ornA6Oudyjagz
X-Google-Smtp-Source: APXvYqxV//3HFjyy2HJ+c2yds0ofxXHzePWIlMB15NqKHmmH8MeEDi7gqAEf4AB6pWJgcj1rQnkQcw==
X-Received: by 2002:a05:600c:21c4:: with SMTP id x4mr3292523wmj.172.1573058893793;
        Wed, 06 Nov 2019 08:48:13 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id d20sm39674731wra.4.2019.11.06.08.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 08:48:12 -0800 (PST)
Date:   Wed, 6 Nov 2019 17:48:11 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Subject: Re: Odd systemd source context for non pid 1 process
Message-ID: <20191106164811.GB1528184@brutus.lan>
Mail-Followup-To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
References: <CAJ2a_Df4Mwf8eiatG92fywoCoEDpozYGz+jvPLRN8vcXy2a70g@mail.gmail.com>
 <57bbaee4-4338-30f2-3d12-bbf6a6aaabe6@tycho.nsa.gov>
 <CAJ2a_Dc9mxQzuhxrbhq90LMfDVx0i-33GPegrhxVeRgXg2A4zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <CAJ2a_Dc9mxQzuhxrbhq90LMfDVx0i-33GPegrhxVeRgXg2A4zA@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2019 at 05:42:35PM +0100, Christian G=F6ttsche wrote:
> > No.  Not sure what it is that you are seeing.  Maybe auditallow
> > execute_no_trans or double check that your policy isn't allowing it
> > (e.g. sesearch -A -s systemd_t -p execute_no_trans)
>=20
> No execute_no_trans are logged (with an auditallow rule).
> There is actually one execute_no_trans over itself (systemd_exec_t --
> /usr/lib/systemd/systemd).
> So systemd might re-exec or fork to get another pid.
> But the pid in the denials is, in the case of systemd-logind, the
> final pid of that daemon.
>=20
> Also in the audit logs, the odd denial (e.g. 11/06/19 17:31:39.298:30)
> is prior to the nnp_transition info (e.g. 11/06/19 17:31:39.466:35).
>=20

There is a "RuntimeDirectory=3Dsystemd/sessions systemd/seats systemd/users=
 systemd/inhibit systemd/shutdown" in systemd-logind.service
That means that systemd will create /run/systemd/inhibit on behalf of syste=
md-logind

>=20
> <<<<<<<< log snippets
>=20
> $ ps -efZ | grep logind
> system_u:system_r:systemd_logind_t:s0 root 478     1  0 17:31 ?
> 00:00:00 /lib/systemd/systemd-logind
>=20
> type=3DPROCTITLE msg=3Daudit(11/06/19 17:31:39.298:30) : proctitle=3D(d-l=
ogind)
> type=3DPATH msg=3Daudit(11/06/19 17:31:39.298:30) : item=3D1
> name=3D/run/systemd/inhibit inode=3D14431 dev=3D00:15 mode=3Ddir,755 ouid=
=3Droot
> ogid=3Droot rdev=3D00:00
> obj=3Dsystem_u:object_r:systemd_logind_inhibit_runtime_t:s0
> nametype=3DCREATE cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
> cap_frootid=3D0
> type=3DPATH msg=3Daudit(11/06/19 17:31:39.298:30) : item=3D0
> name=3D/run/systemd/ inode=3D10008 dev=3D00:15 mode=3Ddir,755 ouid=3Droot
> ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:systemd_runtime_t:s0
> nametype=3DPARENT cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
> cap_frootid=3D0
> type=3DCWD msg=3Daudit(11/06/19 17:31:39.298:30) : cwd=3D/
> type=3DSYSCALL msg=3Daudit(11/06/19 17:31:39.298:30) : arch=3Dx86_64
> syscall=3Dmkdir success=3Dyes exit=3D0 a0=3D0x559af6611a00 a1=3D0755 a2=
=3D0x0
> a3=3D0x7 items=3D2 ppid=3D1 pid=3D478 auid=3Dunset uid=3Droot gid=3Droot =
euid=3Droot
> suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tty=3D(none)
> ses=3Dunset comm=3D(d-logind) exe=3D/usr/lib/systemd/systemd
> subj=3Dsystem_u:system_r:systemd_t:s0 key=3D(null)
> type=3DAVC msg=3Daudit(11/06/19 17:31:39.298:30) : avc:  denied  { create
> } for  pid=3D478 comm=3D(d-logind) name=3Dinhibit
> scontext=3Dsystem_u:system_r:systemd_t:s0
> tcontext=3Dsystem_u:object_r:systemd_logind_inhibit_runtime_t:s0
> tclass=3Ddir permissive=3D1
>=20
> .. later...
>=20
> type=3DPROCTITLE msg=3Daudit(11/06/19 17:31:39.466:35) : proctitle=3D(d-l=
ogind)
> type=3DPATH msg=3Daudit(11/06/19 17:31:39.466:35) : item=3D1
> name=3D/lib64/ld-linux-x86-64.so.2 inode=3D263996 dev=3D08:01 mode=3Dfile=
,755
> ouid=3Droot ogid=3Droot rdev=3D00:00 obj=3Dsystem_u:object_r:ld_so_t:s0
> nametype=3DNORMAL cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0
> cap_frootid=3D0
> type=3DPATH msg=3Daudit(11/06/19 17:31:39.466:35) : item=3D0
> name=3D/lib/systemd/systemd-logind inode=3D268205 dev=3D08:01 mode=3Dfile=
,755
> ouid=3Droot ogid=3Droot rdev=3D00:00
> obj=3Dsystem_u:object_r:systemd_logind_exec_t:s0 nametype=3DNORMAL
> cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
> type=3DCWD msg=3Daudit(11/06/19 17:31:39.466:35) : cwd=3D/
> type=3DEXECVE msg=3Daudit(11/06/19 17:31:39.466:35) : argc=3D1
> a0=3D/lib/systemd/systemd-logind
> type=3DBPRM_FCAPS msg=3Daudit(11/06/19 17:31:39.466:35) : fver=3D0 fp=3Dn=
one
> fi=3Dnone fe=3D0 old_pp=3Dchown,dac_override,dac_read_search,fowner,fseti=
d,kill,setgid,setuid,setpcap,linux_immutable,net_bind_service,net_broadcast=
,net_admin,net_raw,ipc_lock,ipc_owner,sys_module,sys_rawio,sys_chroot,sys_p=
trace,sys_pacct,sys_admin,sys_boot,sys_nice,sys_resource,sys_time,sys_tty_c=
onfig,mknod,lease,audit_write,audit_control,setfcap,mac_override,mac_admin,=
syslog,wake_alarm,block_suspend,audit_read
> old_pi=3Dnone old_pe=3Dchown,dac_override,dac_read_search,fowner,fsetid,k=
ill,setgid,setuid,setpcap,linux_immutable,net_bind_service,net_broadcast,ne=
t_admin,net_raw,ipc_lock,ipc_owner,sys_module,sys_rawio,sys_chroot,sys_ptra=
ce,sys_pacct,sys_admin,sys_boot,sys_nice,sys_resource,sys_time,sys_tty_conf=
ig,mknod,lease,audit_write,audit_control,setfcap,mac_override,mac_admin,sys=
log,wake_alarm,block_suspend,audit_read
> old_pa=3Dnone pp=3Dchown,dac_override,dac_read_search,fowner,linux_immuta=
ble,sys_admin,sys_tty_config,audit_control,mac_admin
> pi=3Dnone pe=3Dchown,dac_override,dac_read_search,fowner,linux_immutable,=
sys_admin,sys_tty_config,audit_control,mac_admin
> pa=3Dnone frootid=3D0
> type=3DSYSCALL msg=3Daudit(11/06/19 17:31:39.466:35) : arch=3Dx86_64
> syscall=3Dexecve success=3Dyes exit=3D0 a0=3D0x559af6603750 a1=3D0x559af6=
6ad680
> a2=3D0x559af6690250 a3=3D0x559af66035c0 items=3D2 ppid=3D1 pid=3D478 auid=
=3Dunset
> uid=3Droot gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sg=
id=3Droot
> fsgid=3Droot tty=3D(none) ses=3Dunset comm=3Dsystemd-logind
> exe=3D/usr/lib/systemd/systemd-logind
> subj=3Dsystem_u:system_r:systemd_logind_t:s0 key=3D(null)
> type=3DAVC msg=3Daudit(11/06/19 17:31:39.466:35) : avc:  granted  {
> nnp_transition } for  pid=3D478 comm=3D(d-logind)
> scontext=3Dsystem_u:system_r:systemd_t:s0
> tcontext=3Dsystem_u:system_r:systemd_logind_t:s0 tclass=3Dprocess2
>=20
>=20
> >>>>>>>> log snippets

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3C+UYACgkQJXSOVTf5
R2l41Qv/SwRJ0Uhjwyjw0d8msREqIIeYgMXCQLDmr2DcJeJhJK3V13RBfg/vasZa
PwZ6GZ/U0v+WphHzMZYhxq1NG9SI4oY8GCmaiQM9R9uhNbkcuzs5INMkFGZi2z9W
EXPRdTz4pOjmkOKZrbKSAAvy1oKO/3ZcEZvW1WEOi8EuAzGMuutDQLtWOwarwqCB
SBc70AB0gw+Kvhu26CtHGA00T1cIYcsCWoFG3JOmtUfNjZuSlPVpWQPuq3KExTRw
RErOHNrTSv1TQImRmO0woeju4iK0yO6CzeXAZL5oUIZczR/9eUp+gWYetzOFGHW5
y3AE8BS7+iy38tb5Ny4X5gH47QSqBdpM3PAvSdYz6DogGQyZNYSTRrLsAUUiUcaq
68xWmi5v0JlwT4KM+Ntz8JEYHNciVixSb7Pyb555i421KCQxP+1eF9d0+WaFcHSU
uPlqwnVQOvyla/trLFyari007ZNsNxdm4DKzfrBdLq6Gg27aK658eSe7mqDD3C5/
51sK6iiX
=4pJc
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
