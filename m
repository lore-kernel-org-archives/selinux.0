Return-Path: <SRS0=yfq3=WM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A93C3A59C
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 16:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0632077C
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 16:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOVt7adg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfHPQxz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:53:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34471 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfHPQxz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Aug 2019 12:53:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so5710238edb.1
        for <selinux@vger.kernel.org>; Fri, 16 Aug 2019 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A3vQCVw0daJ3HspY1cK5JFq6zJ3CP/JouGUggD3wzn8=;
        b=YOVt7adgJbAOHWMv1D9kBI0yARmEmwjbXtVVWA2RRduLlKdPoJygiCECUbd4+m/uA+
         i6BSuKYTtNpINnDiUbdJM+WknvjIhuc//KELtHFWAbcAqkO5s5KNxW4w4JFIOFnpzUif
         W/gr8JADbFIMBpY3KmazULf9XKweva5EsdHJgQTRoLeY/ojY7gF7aw2RYeM2kyl4k0AC
         197GebFSm5608AQ/0VB36vEp9tt4TOdheHU36cAMBlmH52OS8ovY7QDUNUE1WpJ43P9s
         G4h1ep2nEGk05HCLYh4n3Bi4RhgfQ76s4LrtCVpAe0XHK/edN0kF8xK7yfsBlXNkAfvl
         eGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=A3vQCVw0daJ3HspY1cK5JFq6zJ3CP/JouGUggD3wzn8=;
        b=K/TkVMZZslHC7NXohC4shunJ57GgtWQz2G9pVTeTWlviYALSpYhfFqaGdFSpMY+ly2
         MrVe9F/3Ep1Oz2UD/5dCy69TZdVIyhMYXKv066zkpSSeyzAmKjpUTrFLj/QMPCmaHu1v
         jMWVFwbkRqeB8EeLgB/+hboInU0yWOwBHLXynZGWnIOHVCJVSVdXIR40uIeqHdJHes2a
         W/dfaX73ouL5ZsbKvr/S8JDq9b5FMPR0oaUgWiUdAT3sTbWMO0SPkh2BkDmnn23M5p3c
         jyhfRIIFpVJq/kkDhKz+4pbHA3DHzpi2PIx9J3YyGObig02LKKjFsiIxKH5HUoGmKXyf
         eG4w==
X-Gm-Message-State: APjAAAUMGenKNY1doUqppsUdkPas0VDqfXDsd3ZLe7MFEewcY4xHBS15
        VlgFZrX635NmOMwdP8iMn7dGPGSl
X-Google-Smtp-Source: APXvYqwBqRWL51FIHwSyviP9SIkXLCD7CTetpnzKnpxg7MSBxcDwkfKmVTFuEAr13UTZ9ZVGt/JoZQ==
X-Received: by 2002:aa7:d799:: with SMTP id s25mr12268922edq.172.1565974433794;
        Fri, 16 Aug 2019 09:53:53 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id m26sm1200183edd.19.2019.08.16.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 09:53:52 -0700 (PDT)
Date:   Fri, 16 Aug 2019 18:53:51 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: Question about BPF acccess checks
Message-ID: <20190816165351.GA700733@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20190816072744.GA520884@brutus.lan>
 <79283dc7-fcce-259e-e16e-a78eef87256d@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <79283dc7-fcce-259e-e16e-a78eef87256d@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2019 at 12:35:09PM -0400, Stephen Smalley wrote:
> On 8/16/19 3:27 AM, Dominick Grift wrote:
> > As of systemd v243rc1 I have been noticing bpf prog_load and prog_run a=
ccess checks for systemd --user instances (only if secure boot is disabled)
> > I suspect that this is for IPAddressAllow/Deny=3D functionality.
> > So i tried it out and I was not allowed to use the above due to lack of=
 root-access.
> >=20
> > Then i read this:
> > https://lore.kernel.org/linux-security-module/4F52274A-CD70-4261-A255-2=
C4A7E818141@fb.com/T/#t
> >=20
> > My question is: Is it expected that BPF prog_load and prog_run is check=
ed when an *unprivileged* process, i suppose, tries to load and run bpf pro=
gs?
> >=20
> > Are prog_load and prog_run unprivileged operations?
>=20
> They can be checked for processes that do not have CAP_SYS_ADMIN if that =
is
> what you are asking.  This can occur either during bpf(2) system call

Yes I suppose that was what I was asking. According to an LWN article today=
 unprivileged bpf is not going to happen.
Thus i dontaudited these two since it does not work presently, and it is no=
t going to work in the future.

https://defensec.nl/gitweb/?p=3Ddssp2.git;a=3Dcommitdiff;h=3D1ef329b09a3bee=
549cd08640663ba5e8ed9d3f56

Thanks

> processing if unprivileged_bpf_disabled is 0 (for prog_load and/or
> prog_run), or upon receiving a bpf prog fd from another process (for
> prog_run). It is possible that the specific operation will nonetheless fa=
il
> due to a later CAP_SYS_ADMIN check applied for specific kinds of bpf
> programs.  So it depends on the specifics.
>=20
> Android policy appears to have changed over time, with netd originally
> allowed both prog_load and prog_run (but not sys_admin), and then later b=
pf
> program loading was migrated into a separate bpfloader process (with
> prog_load but not sys_admin) and netd was reduced to prog_run, and still
> later sys_admin was added to bpfloader to enable loading bpf programs with
> tracepoints. Similarly there has been an evolution in the handling of bpf
> maps.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl1W35oACgkQJXSOVTf5
R2kEwwv/eQVlDLNvVSOxzUDqM3wOtQUYRPHifJLBbtIoFpWPFCdBJBoDsygHMKBa
/3z1yUFGLCAXvI41kkKSvLkiVMMExMAiQ4xd8AkfBHTZigq0/VTmAz22lOspSErH
CXKq+T0m968MJV/JzrcRZOAg/DEwXob/aF0kWpJb2bYP7ktG9C/RsteA2hSr68gw
Dn8JGgllmwEZrE7XkVN+cqyp9K4A7FWOmqORdV597KJkJIklrhe768kW+fvcROZt
O7olPOyLj+x9pg2E/yQ1vdf+1gRrPXbL//DPWbycpdBKeVt0AHhTNxaoC/hNhEYG
dsd6G3GZcE77dAuzbKMjyAEpAlteNUXwFmMsk/LDt6app5gFKkzQhA9xhVvr2Zwy
f1LonOscDjEDXVCzcSTAovzkBRGUVodlgj3DjEhs3BW8WXPZwYa9knkWmgFpzdP5
FbKcegMcu69rZiFwR8kQrTnt1ua6Xgt6pfHrMbxrFWUdL+DEEdsRjG2NQsFVA7rk
Zz2v6BnE
=f7Az
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
