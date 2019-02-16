Return-Path: <SRS0=de3E=QX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB9C43381
	for <selinux@archiver.kernel.org>; Sat, 16 Feb 2019 12:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C0D2192D
	for <selinux@archiver.kernel.org>; Sat, 16 Feb 2019 12:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz9GkQ3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfBPMER (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 16 Feb 2019 07:04:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39269 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfBPMER (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 16 Feb 2019 07:04:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so2478122edc.6
        for <selinux@vger.kernel.org>; Sat, 16 Feb 2019 04:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CdU1ikKrqXmQAwXncXPGjsUzUOT4NftRpn63Jnet2XY=;
        b=Kz9GkQ3MV2jmeZefmjxKV5+Jk0PPLXeL2X6c/KG9IJc/MfC/+j1yjiU1LG8ZN4WYYE
         odzlT76h876Kc1g7xjthC77EjPR9P+bt7Lu35BJ8xUbMRdyOwFsbFV8CqaSZcRGDGjQe
         j6HlFVfOY6jPnhS1vTHsycFqVgfkZACR8xsFsgllk0F6KB34BCTGDrtQdEtDvN64Y1B8
         gi+muUuSFle4IOCgAJlvR5ptioRVCv1kVDQ+JwXMZHIYOkH129Ov6ZsybBkR9h4OPfGx
         0VslOKXnLE7kgtLR4I5nNjsea3sc0FbJfUZUPlHQmlVcsxcCAPPl4XqNWcZXSMvl0ltr
         7pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=CdU1ikKrqXmQAwXncXPGjsUzUOT4NftRpn63Jnet2XY=;
        b=UMk3vO7R3x0uq97hBon3ibAPKIIJ0RrDP7F6Uw4j+AKdGLwdAx3zk5N7KXweyKcdL1
         GXd5zdgcSXGU8S5aU1u/94l9DxbdT6ThD7/8CxqCSfWbB+MoTMVMk5w5k19NoNQN4Pfv
         AjrNfbFEF3PqIL74E+lxgxpGo6qUq6cZSIhJuAP1NbY5+ar4PklGULrDevwLZ/qKTt4I
         b82SaDdZUahslMeZ0AugchfOaYUH5WFbcLhOpaYcblXNVemEMrnMUIyS958wV8ZMHRmT
         WJpKYVcN6n5o6XHNyubh+TpXPSSE9XeIHxVOL4QWrPWs1IC+1yiW4V4HnWWgW0LbfWcN
         Ed3A==
X-Gm-Message-State: AHQUAuamA/+IjT7BS4bxXhdM4GT5/dpjacu0znM4xt4PYFP+/bHwJdv+
        kVg3H76CiKwOV18XBt04OobMe+Nl
X-Google-Smtp-Source: AHgI3IYtlV1Mh5ccbp8v9MOJ7p3h73xFnwXTR57Gyt1O23tqDmh4E0j07wlScmpMX/SDjEFqGlDH6A==
X-Received: by 2002:a50:b7d6:: with SMTP id i22mr11154361ede.27.1550318655580;
        Sat, 16 Feb 2019 04:04:15 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id g18sm2320428edh.39.2019.02.16.04.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 04:04:14 -0800 (PST)
Date:   Sat, 16 Feb 2019 13:04:12 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
Message-ID: <20190216120412.GA11908@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <3f279367-2c4f-5b26-e31b-58eb037b687b@tycho.nsa.gov>
 <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
 <0e556b37-90fa-7f3a-f60f-fa77acce6f5b@tycho.nsa.gov>
 <87zhqxkn8a.fsf@gmail.com>
 <87r2c9klrh.fsf@gmail.com>
 <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com>
 <87lg2g97sr.fsf@gmail.com>
 <98436a4a-0048-2839-acff-b1bc38075a8c@tycho.nsa.gov>
 <87h8d4974p.fsf@gmail.com>
 <27efd865-7d08-fc61-e004-0a07f27e165e@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <27efd865-7d08-fc61-e004-0a07f27e165e@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 02:48:45PM -0500, Stephen Smalley wrote:
<snip>

>=20
> Oh, I see: scripts/selinux/install_policy.sh just invokes checkpolicy
> without specifying -U / --handle-unknown, so the policy defaults to deny,
> and that would indeed render dbus-daemon and systemd broken with that
> policy.  Might be as simple to fix as passing -U allow.

I have looked a litte into this and here are some observations:

1. You can boot mdp as-is in permissive mode if you use `checkpolicy` with =
`-U allow`

2. You need *at least* an `/etc/selinux/dummy/seusers` with `__default__:us=
er_u` and an accompanying `/etc/selinux/dummy/contexts/failsafe_context` wi=
th `base_r:base_t` to boot mdp in enforcing

3. There is an issue with checkpolicy and object_r:

PAM libselinux clients such as `login` try to associate `object_r` with the=
 tty and fail.

if you try to append: `role object_r; role object_r types base_t;` to polic=
y.conf and compile that with `checkpolicy` then the `roletype-rule` does *n=
ot* end up in the compiled policy for some reason.

thus, you cannot log in because object_r:base_t is not valid.

To hack around this add `default_role * source` rules to policy.conf and re=
compile.

This will allow you to log into the system locally in enforcing mode.

4. I also noticed that fedoras' ssh seems to hardcode `sshd_net_t` for its =
"privsep" functionality so, while untested, you probably need an `openssh_c=
ontexts` with `privsep_preauth=3Dbase_t`

>=20
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > Besides, haven't you always wanted to get a patch accepted into t=
he
> > > > > kernel Dominick? ;)
> > > >=20
> > > > Not particularly, no.
> > > >=20
> > >=20
> >=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlxn/DgACgkQJXSOVTf5
R2kJEwv6AyRpIAke0ry4ISmdSmFrdCdHPn+E8sY5F3VxgXEJGH2Px074rcRYJxRz
6VAchFym6GTTpACR5OPq0XOQrZP9BSAEdIJz3tpveiJs/6KXxFGk3XGAOD/hd7pm
agrqDAK0of4xziIUM+8M5f8GKWI5iUp82OFNEpDS1LzihmTSgH3Lgvf40DcJ43aA
sT1cn4EIUmBLmODC6nUrFNSFPstuoAsBSyGPJ+gSjIFG8eg2BPaChH0d30dXQjyq
uV7KnHAXs9uRJg3M3jG9Teew3bddbqeJVW+a4niz2/vHzLR48sNl54RB4PEdIZtU
HL3uUcrms+FKuGQwhc1cc7c9QsBTvTdQVnXd/jRBmFVFhHdfISHwrnpxRXOwwcNa
/ovQKDdhyRACCAenQGBd7nzkxJLg2CIIE/rMsx7PjE0AqeopYyVYozJYVoZ4KHyc
TK4RAdVDbDBnAlm23cgIRuSYNppk15j8uwqHRNkbZziaSAobd/NSF64H4SaQniZz
ilA61JOy
=1qzi
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
