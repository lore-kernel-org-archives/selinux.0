Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41026C43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 15:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0978F2054F
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 15:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBDxHotW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfLLPAD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:00:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43683 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfLLPAD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 10:00:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so3045042wre.10
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2019 07:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tLm1jUL+F+w/wXeKYWsX6w7Za2kk/tC+MWSXuMwCoJU=;
        b=JBDxHotWb0tiuAC4gXl39Rtws5e2rF+kAff0UWC8dTDI++rjKpXWZX1ojz6Db5azTM
         wkSSw/9IFNMIvlCvVbRQrcygZN3OebBaDJxJVzR+vGGi5hNrmxlmdz/kugYnd4BnScCr
         T31SmGJ/GJM3p4MEypB2DjKNk66/3JltJ9KiVM5Qq1JNDbxI03Q7x/V7qH9IOzTpG1cA
         AbxkYV2TGKuiGmihimrUYW7BVQty8V8DKhXrUGRVNqYOl5ZOb7ZZbaL/s2WN6hvatTFd
         v5j82co94PPBzrNlYGJTLcUeEJGXVDBEgFzx9q3eTl71/DPlvmsntSj5lRsRyYBdt5G2
         B2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=tLm1jUL+F+w/wXeKYWsX6w7Za2kk/tC+MWSXuMwCoJU=;
        b=BxGs7nmlTIUns4NI5jA7vChFFnBuJDPLM0GDiiTImQF8And9EqTATgEQHrXWP9poFo
         sPjW01FDh/TILcjHDbEgKPtnKL3/SU/QNYG8KhigG0Xq8ow1hskAwHH9lrqMbFkxNdMB
         3m02TAVD3Oj6CiXixwxpU5yUdIXKh8dXx0KgrbNxAJ1AzFigdiCIIagr58IbLMuHOonf
         HccU7TFgeHJSktdkvXg9ybq8uns+GjW1CeaIc81c4P/d6iqUOpAkdLv093e4uXOitDz/
         oyUIrSsseKGsqmVL7Fg4UVna6Sm9dRcYo2MZ/SYl9VC4iSBW9o/fJnVlRZaFHpNNxST6
         3OkQ==
X-Gm-Message-State: APjAAAVzIQFKohzLBK3Mmk/et6DSpDtmMJGmEDOcLg6EL9x/QEdOB+jv
        5Uew/0McKtg3JoAc9iANCsnM5T5G
X-Google-Smtp-Source: APXvYqxUwg/IofYaxTwxSdqpQkOllY4+DBDviNDrBEon6kb8Vn+UK3QnGXpZKLRdyj+1dk4MwnK0tg==
X-Received: by 2002:a5d:620b:: with SMTP id y11mr6722473wru.230.1576162800438;
        Thu, 12 Dec 2019 07:00:00 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id f17sm6465188wmc.8.2019.12.12.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 06:59:59 -0800 (PST)
Date:   Thu, 12 Dec 2019 15:59:57 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH v2] mcstrans: start early and stop late
Message-ID: <20191212145957.GC2670272@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20191211134423.2357254-1-dac.override@gmail.com>
 <20191211142124.GB2233813@brutus.lan>
 <d992aba5-77a3-bd47-6cae-95fc5ecf10dd@tycho.nsa.gov>
 <20191212142436.GA2670272@brutus.lan>
 <c961712f-a084-e421-a919-41d5a86ee5bc@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <c961712f-a084-e421-a919-41d5a86ee5bc@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 09:36:19AM -0500, Stephen Smalley wrote:
> On 12/12/19 9:24 AM, Dominick Grift wrote:
> > On Thu, Dec 12, 2019 at 08:45:29AM -0500, Stephen Smalley wrote:
> > > On 12/11/19 9:21 AM, Dominick Grift wrote:
> > > > On Wed, Dec 11, 2019 at 02:44:23PM +0100, Dominick Grift wrote:
> > > > > It stopped too early, exposing a bug in sudo selinux_restore_tty(=
):
> > > > >=20
> > > > > SELINUX_ERR op=3Dsetxattr invalid_context=3D"wheel.id:wheel.role:=
users.terminals.pty.pty_file:SystemLow"
> > > > > avc:  denied  { mac_admin } for  pid=3D859 comm=3D"sudo" capabili=
ty=3D33 scontext=3Dwheel.id:wheel.role:sudo.wheel.subj:s0 tcontext=3Dwheel.=
id:wheel.role:sudo.wheel.subj:s0 tclass=3Dcapability2 permissive=3D0
> > > > >=20
> > > > > If we want to be able to reference human readable contexts in SEL=
inuxContext=3D and nspawn -Z and -L then we need mcstrans ASAP
> > > >=20
> > > > Unfortunately it does not quite seem to address this challenge, at =
least currently, but still
> > > > I think systemd would need to refresh its label cache when mcstrans=
 is started, as per systemd v245 that should be a little less painful than =
it is today
> > > > Something like a: ExecStartPost=3D/bin/systemctl daemon-reload woul=
d do that then
> > >=20
> > > I'm a little unclear on where the bug lies - you show a sudo denial, =
but
> > > refer to systemd as the culprit?
> >=20
> > The sudo bug is fixed here: https://github.com/sudo-project/sudo/commit=
/718e6997fcaae6ea065ce74d08dd4aae5917df5e
> >=20
> > >=20
> > > If we don't care about being able to use translated contexts in syste=
md unit
> > > files or options, it could always use the _raw interfaces to ensure t=
hat it
> > > is always dealing with the raw kernel contexts.  The translated conte=
xts are
> > > mostly for display purposes for MLS labels/policies.
> >=20
> > The thing with systemd is that since systemd runs before mcstrans is st=
arted it doesnt use mcstrans.
> > So if you try to reference translated contexts using systemd then it wi=
ll refuse.
> > Running a systemctl daemon-reexec after mcstrans is started fixes that =
issue but that is not really an option.
> >=20
> > I am wondering what causes this behavior, i suppose this is some libsel=
inux thing.
>=20
> Yes, libselinux checks for the existence of the mcstrans socket exactly o=
nce
> on the first attempted translation, and if it does not exist at that time,
> it never tries again.  That is to avoid overhead on systems that are not
> running mcstrans, which is the majority of systems. mcstrans is only real=
ly
> needed for MLS policies and those are a minority of SELinux systems.
>=20
> > Regardless of all the above though, i think it makes sense for mcstrans=
 to start early and stop late.
>=20
> Perhaps; I'll defer to the distro maintainers on that.  I don't really
> recommend using mcstrans unless you truly need it.

Me neither. There was a request for support on IRC. So i looked into it.
I certainly think I made it clear to stay away from it if possible.

>=20
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > v2: stop late, but do stop
> > > > > Signed-off-by: Dominick Grift <dac.override@gmail.com>
> > > > > ---
> > > > >    mcstrans/src/mcstrans.service | 3 +++
> > > > >    1 file changed, 3 insertions(+)
> > > > >=20
> > > > > diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstran=
s.service
> > > > > index 09529432..c13cd09a 100644
> > > > > --- a/mcstrans/src/mcstrans.service
> > > > > +++ b/mcstrans/src/mcstrans.service
> > > > > @@ -2,6 +2,9 @@
> > > > >    Description=3DTranslates SELinux MCS/MLS labels to human reada=
ble form
> > > > >    Documentation=3Dman:mcstransd(8)
> > > > >    ConditionSecurity=3Dselinux
> > > > > +DefaultDependencies=3Dno
> > > > > +Before=3Dshutdown.target sysinit.target
> > > > > +Conflicts=3Dshutdown.target
> > > > >    [Service]
> > > > >    ExecStart=3D/sbin/mcstransd -f
> > > > > --=20
> > > > > 2.24.0
> > > > >=20
> > > >=20
> > >=20
> >=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3yVegACgkQJXSOVTf5
R2lVzQv/eumNjlfLLsJj2Sg0IYlaG7XmzffeBPLys2K2MjUjyj/3m06nN40mNPqA
cS4yNDkBrzcDZ/4N12EnQPyuLJRQ1unwdtnHt805BKVW3B/hEk8HEbkz7MzoCHPE
UZjBTIT/KApfouFrLCkBw3y4yErAJkYbIhxKos+quBhM9hBok2GFTZrXifExchua
4ySk2K6aOieYGed9FRI9BHTHlqpZnQuhxsDzo8xti55TXj6E+0wJZcH35ibNy3x2
fUqgN3ypSTgBqFXyYJDJQ9rkQ8VlyUQpBBwVuR+OiTG+xc4hQarX1d3PpsSkK5WH
IR5S3odDR05AndGxkr3DHuNBrac3P8BZW4PK5SIaXQz8rArvt6q8QN9qg5Tgmfko
yF8haJCjJZFR459EqkYkPWxUD60KOkIOwkFdCZseuuXvEW78xVZVr/NW3TG3DrRp
nXIFnqNEiZIQmF/y5g3B09kAntLdjXACNZ0/zybkz5j/TsxOc93f4hJq/FXlRaXO
5V8fZcrQ
=NDHX
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
