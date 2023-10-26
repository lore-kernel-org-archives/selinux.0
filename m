Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7E2C0032E
	for <selinux@archiver.kernel.org>; Thu, 26 Oct 2023 01:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjJZBZR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Oct 2023 21:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJZBZQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Oct 2023 21:25:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3184E18C;
        Wed, 25 Oct 2023 18:25:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fb85afef4so328896b3a.1;
        Wed, 25 Oct 2023 18:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698283513; x=1698888313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCX2BfR40dPR6z0Di3/E+Zm7hQ9vmshlYentRsEniNQ=;
        b=UrrHOjL24lUGT3vYjeTRYav362eLoQ1A6f2SRdsrVzI9aXLvpZnhnJQHlKTRQ3moHT
         fE8i2zztWEqc9Gd9ofAouWClq0dKMsq8sD4JiRK9J7YgSi8QKf/5TTLxAui9FLEacWVH
         LdPQCqmIHbyn58FhOy8AeDBiNWTykbng0vzx6cJU9FFO2sioK0wou6tq23U/oZreRNq+
         1ioti1JYYrzKltuvwpTjV9NiUOvxkhIjGMLaFiQC/03MTD5TeUOTYXIGPjpC8k2uXg5w
         J2VbRSxvyCqv3nngUHATfAOgvg4eOK1IAdIqAH2woRj9QqRBbR0thdCDoLeuSDSUI4EZ
         zLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698283513; x=1698888313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCX2BfR40dPR6z0Di3/E+Zm7hQ9vmshlYentRsEniNQ=;
        b=ioyz5yG3zk6V42m/fBf/QMSQgmZT6dqu7VUJYxL4NnA1M11qIYNjIRl4qphcvA0gdi
         zO1GTQDUwd+bnovcr9QexINAnFgZ68fgeRed837hd8oAGeCXJKJYDVYxGr6jOkmRZbDN
         /otjaQoITGSu+179/VJPqZCciq89UfENMQusClUcxz2cilxTIOZ+qfsvP1p4fBQX6184
         3+o8Og3mnTHIsrZnqk/oGdpWhxoOZXU5MoiSPNjvueu5L+YxqXR5Lwj4RLIkS39hegFD
         laq17Tz+j8CsePdbpBe63rCPVu0Q+SfkIJORAMaednd4khkrxEC7rzMOmB8+ZB6kU1kC
         m7ig==
X-Gm-Message-State: AOJu0YzmViizaianxXvMLI0tlqZVmN9jeghIuFEa0iSHL1hSI1LSR6do
        E7+IAjMRmUOuJo5XKsOqG2wcMBy59cM=
X-Google-Smtp-Source: AGHT+IH3wdHiv+twqgOwRF4T86HuDGc1AHw+6OJZmh2T33NU5PGoI3RJfxxrAQsZNttSyNPlkEqJ+A==
X-Received: by 2002:a05:6a21:164a:b0:151:7d4c:899c with SMTP id no10-20020a056a21164a00b001517d4c899cmr6820387pzb.25.1698283513355;
        Wed, 25 Oct 2023 18:25:13 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id iw22-20020a170903045600b001bc930d4517sm9833186plb.42.2023.10.25.18.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 18:25:12 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C22CF90405E7; Thu, 26 Oct 2023 08:25:08 +0700 (WIB)
Date:   Thu, 26 Oct 2023 08:25:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Linux Security Module Subsystem 
        <linux-security-module@vger.kernel.org>,
        SELinux Mailing List <selinux@vger.kernel.org>,
        Linux Kernel Audit <audit@vger.kernel.org>
Subject: Re: ANN: kernel git branches and process changes
Message-ID: <ZTm_9Bj1XYTzL0Za@debian.me>
References: <CAHC9VhS1wwgH6NNd+cJz4MYogPiRV8NyPDd1yj5SpaxeUB4UVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jNNTzeV9Wl5NI3rC"
Content-Disposition: inline
In-Reply-To: <CAHC9VhS1wwgH6NNd+cJz4MYogPiRV8NyPDd1yj5SpaxeUB4UVg@mail.gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--jNNTzeV9Wl5NI3rC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 05:11:51PM -0400, Paul Moore wrote:
> #### stable-X.Y branch
>=20
> The stable-X.Y branch is intended for stable kernel patches and is based =
on
> Linus' X.Y-rc1 tag, or a later X.Y.Z stable kernel release tag as needed.
> If serious problems are identified and a patch is developed during the ke=
rnel's
> release candidate cycle, it may be a candidate for stable kernel marking =
and
> inclusion into the stable-X.Y branch.  The main Linux kernel's documentat=
ion
> on stable kernel patches has more information both on what patches may be
> stable kernel candidates, and how to mark those patches appropriately; up=
stream
> mailing list discussions on the merits of marking the patch for stable ca=
n also
> be expected.  Once a patch has been merged into the stable-X.Y branch and=
 spent
> a day or two in the next branch (see the next branch notes), it will be s=
ent to
> Linus for merging into the next release candidate or final kernel release=
 (see
> the notes on pull requests in this document).  If the patch has been prop=
erly
> marked for stable, the other stable kernel trees will attempt to backport=
 the
> patch as soon as it is present in Linus' tree, see the main Linux kernel
> documentation for more details.
>=20
> Unless specifically requested, developers should not base their patches o=
n the
> stable-X.Y branch.  Any merge conflicts that arise from merging patches
> submitted upstream will be handled by the maintainer, although help and/o=
r may
> be requested in extreme cases.
>=20
> #### dev branch
>=20
> The dev branch is intended for development patches targeting the upcoming=
 merge
> window, and is based on Linus' latest X.Y-rc1 tag, or a later rc tag as n=
eeded
> to avoid serious bugs, merge conflicts, or other significant problems.  T=
his
> branch is the primary development branch where the majority of patches are
> merged during the normal kernel development cycle.  Patches merged into t=
he
> dev branch will be present in the next branch (see the next branch notes)=
 and
> will be sent to Linus during the next merge window.
>=20
> Developers should use the dev branch a stable basis for their own develop=
ment
> work, only under extreme circumstances will the dev branch be rebased dur=
ing
> the X.Y-rc cycle and the maintainer will be responsible for resolving any
> merge conflicts, although help and/or may be requested in extreme cases.
>=20

If I have patches targetting current (not next) release cycle, either for
stabilizing that cycle or for stable backports, I have to base it on dev
branch (not stable-X.Y), right?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--jNNTzeV9Wl5NI3rC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTm/7wAKCRD2uYlJVVFO
o4nnAQDaCea9De+zP5o4fq6lLWaUgO2beGdbsMmenlgFyWqHLwD8C6wjKW5U5ETq
Q9LVCkWxuIUBt1O4MPy6CnB/u4vfjAs=
=ZQeB
-----END PGP SIGNATURE-----

--jNNTzeV9Wl5NI3rC--
