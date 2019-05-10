Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CA7C04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 07:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA47217D6
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 07:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsylkBud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfEJHMO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 03:12:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34237 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfEJHMO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 03:12:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so4221171eda.1
        for <selinux@vger.kernel.org>; Fri, 10 May 2019 00:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6LrcGLey62RFBAOE8sJC4PUAa49ES7w20nSFSQVVrkg=;
        b=ZsylkBudZYKSb6p4/kPFI/XR09eRg9lRNhxkg2OPpNB/Ol0nwNdsNKGcNGm5AtzKDx
         gWh70fRxcE1SOCGd4PACA9yTbY4G+7pA4c3U21NlVhdKH6l2wP4Clh9BZYBIn5ysFa0R
         m0vQiM0hkxLKJp90Ej9fPmlMQ525uLszBzJqeOnrENPGz9qmrFXCIol8DemkrP1IzYxn
         ta2ziNh9EK6plPCxYIhbc9aovvgNrmsZ+xmLpyofinNkvJbh0xFBoOQ2IP6EfTTPyKyv
         IxXx0oJymops/Ija0oGxGsbm1/jCIkp4Sn4niV56pfv++gfmJNzpKmWgqmPptXMFzo5J
         FeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=6LrcGLey62RFBAOE8sJC4PUAa49ES7w20nSFSQVVrkg=;
        b=iktL0utvzOizjVCnryDjJcFsasmmvBO4qlnKnUvXka6wxcCtL9QpR9ZHsUt2zZvLFu
         0FReNy1h5n/F7SuxkeGkyYs1BAOTOC2Ms3jQ03L2aZOQwZmyNojw9wUaF065MVwxQvKm
         vo9dBVhok23u/eiYrND5SCu3CvH1Vd/4M20ozg8Fyyw55xTolc+BXEQy4WyRt62Pm2dZ
         bMx7L8vzpcqQBITBjMVMy0whrCNSdKlQxr+5gv+zqz0IAiFjxhg4J286DrjuDPKeCxc5
         q8n5eP3/SheQD83Y9sXBXpng8L6gGT/ZHxkOsIPqqwQg+6Rd0kPNzqk0AiaeBiJuAfoh
         9SIg==
X-Gm-Message-State: APjAAAVrNHcm0vdCw+3e4fTiaCo7/9dTzpWlKKV/oV93ZHMm7Fa3yaXV
        T9djY1tHKPH4VJ46pktLMN0=
X-Google-Smtp-Source: APXvYqzv7YQSyd+raenGfD9d0HFbdmNjIeWXA3kkLJ12Q+r5XxFFEhTJ+tr2elX4Gnzg4hnImemkRA==
X-Received: by 2002:a17:906:c456:: with SMTP id ck22mr7056832ejb.113.1557472331829;
        Fri, 10 May 2019 00:12:11 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id w10sm635889eja.30.2019.05.10.00.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 00:12:10 -0700 (PDT)
Date:   Fri, 10 May 2019 09:12:08 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Jeffrey Vander Stoep <jeffv@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Joel Galenson <jgalenson@google.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: Re: Mislabeled /proc/<pid>/ns/mnt files?
Message-ID: <20190510071208.GA14283@brutus.lan>
Mail-Followup-To: Jeffrey Vander Stoep <jeffv@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Joel Galenson <jgalenson@google.com>,
        Petr Lautrbach <plautrba@redhat.com>
References: <CABXk95D-4v2aT=sZk9NoeGJBGTy=7NTQ8+yKv5E4RvaODJgWLA@mail.gmail.com>
 <fdcf1946-2151-4502-9755-3a10d0646399@tycho.nsa.gov>
 <CABXk95Au_UVdghpHGuu39mHJkSYA2=7YS__vtx8sxGEH4CuSgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <CABXk95Au_UVdghpHGuu39mHJkSYA2=7YS__vtx8sxGEH4CuSgg@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 02:47:30PM -0700, Jeffrey Vander Stoep wrote:
> From: Stephen Smalley <sds@tycho.nsa.gov>
> Date: Thu, May 9, 2019 at 2:17 PM
> To: Jeffrey Vander Stoep, <selinux@vger.kernel.org>, Joel Galenson,
> Petr Lautrbach
>=20
> > On 5/9/19 3:56 PM, Jeffrey Vander Stoep wrote:
> > > I expected files here would have the process's context, but they
> > > don't. The files are actually all symlinks so it's entirely possible
> > > that the they shouldn't have the process's context. If that's the
> > > case, how can I provide different labels for them? Neither "proc" nor
> > > "unlabeled" are appropriate.
> > >
> > > On a device with a 3.18 kernel they have the "proc" context:
> > > sailfish:/ # ls -LZ1 /proc/1/ns
> > > u:object_r:proc:s0 mnt
> > > u:object_r:proc:s0 net
> > >
> > > On a device with the 4.9 kernel the have the "unlabeled" context:
> > > blueline:/ # ls -LZ1 /proc/1/ns
> > > u:object_r:unlabeled:s0 cgroup
> > > u:object_r:unlabeled:s0 mnt
> > > u:object_r:unlabeled:s0 net
> >
> > First, ls -L dereferences symlinks so you are going to get the context
> > of the object referenced by the symlink, not the context of the symlink
> > itself.
>=20
> I'm seeing a denial on the object not the symlink, so -L is what I want.
>=20
> >
> > Second, the task context is only assigned to proc inodes created via
> > proc_pid_make_inode(), which has never been the case of /proc/pid/ns
> > inodes - those have their own implementations and operations.
> >
> > Third, /proc/pid/ns migrated from proc to its own pseudo filesystem,
> > nsfs, which requires a corresponding fs_use or genfscon rule in policy
> > or they will be unlabeled.  refpolicy has a genfscon rule. Confusingly
> > there appears to be both in Fedora policy, a fs_use_task and a genfscon
> > rule, and it appears that fs_use_task is being applied here.  I don't
> > know why or what exactly that means.  It won't be the task context for
> > the task associated with that /proc/pid directory but instead would be
> > whichever task context instantiates the inode.
> >
>=20
> So, how do I label these files in genfs_contexts?
>=20
> "mount | grep nsfs" returns nothing.

# seinfo --genfs | grep nsfs
   genfscon nsfs /  sys.id:sys.role:fs.nsfs.fs:s0

Yes, i think this is a step backwards. In the past we got a nice list of ob=
jects that have no context associated when policy is loaded.
That list was removed. So sometimes its hard to determine whether something=
 needs a genfscon if its not listen with `mount.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlzVJEMACgkQJXSOVTf5
R2lckAwAvU84alT3FLpZt7lCah71fmCBx6UYdJgKCAeBBMMtyhWb3pufRGjeVgb1
+XUcekZ1PCeUnlyF0TylsDR4iF3ZY0sTTpJ9+sKuA/t9Ml1n2ce9u3vVEAdNMShQ
Ys8priMh2KWRi/DTbwsazxPnkRdna8TcpHAhG0jnz1W4p+9czbuNx8LoG7QCMDAd
MIDl+foPL9b0PD/w2XefobkxZ9SVD17Cj1653L6/a5e4PHdfgYxawTjD22uhG8aV
qOxXFBo8tW7IWYloE8d15d+M29+OxHCmGDe0YynhWoTsmJ09T+4TUOeNml6w3XAe
uQjAQVA0YPtUWXuWjvsjpiz+12mziKTRj2p2KAuL3x92YbClaqkvNMcqBw+1HoYT
O5ry4Ri86eOeaPM6Ue3gW3t+qJdJwje1NS9jtclklDo7OSFL3LkRw3U2A8XhIlRi
O2VCAS3v1nxB3Ox3l7UpdmV29h3BgGOyNrBhCCjMiSn9mIOq0on1sMFzIpOax4GG
b7cVhl/N
=LAYg
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
