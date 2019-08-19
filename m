Return-Path: <SRS0=MkDT=WP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E2C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 19 Aug 2019 19:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26239214DA
	for <selinux@archiver.kernel.org>; Mon, 19 Aug 2019 19:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2JLf5L1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfHSTt3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:49:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41552 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSTt3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Aug 2019 15:49:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id w5so3079908edl.8
        for <selinux@vger.kernel.org>; Mon, 19 Aug 2019 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wbyxj29OKrjaEK4qsS9QsNmUgzqj9KpxSr0I2FHAUFk=;
        b=k2JLf5L1LiTY+7SD2a/Wnrv0mTohM5djzl7MHwdMCGvGcMXCnquoL00n6DpZ60HZBr
         MkbxiLwa3B7FSht/puFgawyvusCKCaY9awwOlS6INJVtp7XS3ASSbvnql4WuDs9SptQ6
         hdYk+pW5juZNHVIB8re97snkLf+4t4amQK9+wGYgiTQ6+7YErAl+3OZl4ScbIFnBu4Ac
         meli2uXu/8PSD66/s51QjdRUn5yztTJp/sZE5Z1vAvbF+xxWhk1wmMv08u5L7TKOFyyw
         cXiSL8b5jEWHRlBbjwYxrsTqMtyJPPC2XdI8bcrVGOaDaHan7Gbm7VCkJKrqiUxwvuZC
         uXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Wbyxj29OKrjaEK4qsS9QsNmUgzqj9KpxSr0I2FHAUFk=;
        b=PGz09c2MUJDd9ZHps0gquUvsoOb1ecA/Ioez3RaDCOj0WkL0l+4brfybmw4FAC24si
         TReZTvOMtMC0wsWaL5M5EwEkgBzomBrsUhcB4vz+FN9NG5MhFpqrRF3XMCBjWHgCSvTs
         OkzqW/OFUuw+jKcSkcm8iBAfrz/tsiXtEoCVBc2mVHyiXQydiYPgrASQ7VDc/paeNBlv
         TaZrrIMAo9WIqj4NdF8YT3/C8eK/g6dPWhbIy0lYiK2YNJ9tSHOXrije+J6OFEtUPqB5
         muyCl4rKBAPV1FmUTqLZlGxuxg36NV+1/iQqmgBmS6a7S6V22nsRa2bBHw/06bMQOip9
         eTxA==
X-Gm-Message-State: APjAAAUBCxiAPGTYPtTNrEbQ/8OgcEDdbfZMjgRkQquyquOFH8c3of2r
        2TbMJcAjttz9BKvRwy+WXvc=
X-Google-Smtp-Source: APXvYqwNeAyTTNjTpVJ9WrsXUhBIbdC552kWCZ8DvRLWP+mnWtBzOUUFVwMZZTuTr/tGzoQJ5qB0+A==
X-Received: by 2002:a50:9053:: with SMTP id z19mr26559680edz.99.1566244166883;
        Mon, 19 Aug 2019 12:49:26 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id q17sm3003591edr.94.2019.08.19.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:49:25 -0700 (PDT)
Date:   Mon, 19 Aug 2019 21:49:24 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     selinux@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>
Subject: Re: [PATCH] selinux: allow labeling before policy is loaded
Message-ID: <20190819194924.GA749746@brutus.lan>
Mail-Followup-To: Jonathan Lebon <jlebon@redhat.com>,
        selinux@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>
References: <20190819193032.848-1-jlebon@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20190819193032.848-1-jlebon@redhat.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2019 at 03:30:32PM -0400, Jonathan Lebon wrote:
> Currently, the SELinux LSM prevents one from setting the
> `security.selinux` xattr on an inode without a policy first being
> loaded. However, this restriction is problematic: it makes it impossible
> to have newly created files with the correct label before actually
> loading the policy.
>=20
> This is relevant in distributions like Fedora, where the policy is
> loaded by systemd shortly after pivoting out of the initrd. In such
> instances, all files created prior to pivoting will be unlabeled. One
> then has to relabel them after pivoting, an operation which inherently
> races with other processes trying to access those same files.
>=20
> Going further, there are use cases for creating the entire root
> filesystem on first boot from the initrd (e.g. Container Linux supports
> this today[1], and we'd like to support it in Fedora CoreOS as well[2]).
> One can imagine doing this in two ways: at the block device level (e.g.
> laying down a disk image), or at the filesystem level. In the former,
> labeling can simply be part of the image. But even in the latter
> scenario, one still really wants to be able to set the right labels when
> populating the new filesystem.

Does `echo "/" > /run/systemd/relabel-extra.d/foo.relabel` not address this?

https://github.com/fedora-selinux/selinux-policy/issues/270

If that does not do what it should do then this functionality should probab=
ly be removed?

>=20
> This patch enables this by changing behaviour in the following two ways:
> 1. allow `setxattr` on mounts without `SBLABEL_MNT` (which is all of
>    them if no policy is loaded yet)
> 2. don't try to set the in-core inode SID if we're not initialized;
>    instead leave it as `LABEL_INVALID` so that revalidation may be
>    attempted at a later time
>=20
> Note the first hunk of this patch is functionally the same as a
> previously discussed one[3], though it was part of a larger series which
> wasn't accepted.
>=20
> Co-developed-by: Victor Kamensky <kamensky@cisco.com>
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
>=20
> [1] https://coreos.com/os/docs/latest/root-filesystem-placement.html
> [2] https://github.com/coreos/fedora-coreos-tracker/issues/94
> [3] https://www.spinics.net/lists/linux-initramfs/msg04593.html
> ---
>  security/selinux/hooks.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 94de51628..faf93e9f8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3143,7 +3143,7 @@ static int selinux_inode_setxattr(struct dentry *de=
ntry, const char *name,
>  	}
> =20
>  	sbsec =3D inode->i_sb->s_security;
> -	if (!(sbsec->flags & SBLABEL_MNT))
> +	if (!(sbsec->flags & SBLABEL_MNT) && selinux_state.initialized)
>  		return -EOPNOTSUPP;
> =20
>  	if (!inode_owner_or_capable(inode))
> @@ -3225,6 +3225,15 @@ static void selinux_inode_post_setxattr(struct den=
try *dentry, const char *name,
>  		return;
>  	}
> =20
> +	if (!selinux_state.initialized) {
> +		/* If we haven't even been initialized, then we can't validate
> +		 * against a policy, so leave the label as invalid. It may
> +		 * resolve to a valid label on the next revalidation try if
> +		 * we've since initialized.
> +		 */
> +		return;
> +	}
> +
>  	rc =3D security_context_to_sid_force(&selinux_state, value, size,
>  					   &newsid);
>  	if (rc) {
> --=20
> 2.21.0
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl1a/T4ACgkQJXSOVTf5
R2ly1Qv/X1KPTk728TICxhgy086gfFjBEuUi3JuKagvO0K4VlumgBwHob9v5R7j1
+gSgkAqKAls9IeQJewnG3evxzBHuomygEWCTIf32HGhSrcXLChn8p02BXOrn/0yN
wnuJ+sTEpKttTjjhmMa/f9Sv0wDREE8qfCvwIZTpwQhAAjyDUTDcENrntD6sBE/D
QkpziiZHCH66kF1Dtj7ghKyQkLbIYdrBtIZirqRnmkbFcvV99v1c+CFFUG1wjB0A
VOvsT3QfkhOekhoyFnhXJmV98evUAA8pEPmbzX87qRbI91pegGcaB2+VpT5+vrkH
22sQCaJDbd5GSuDBYXamP+u1KCZhz7N8u/yQpXF3gJY0+ZHCqO9bNy7Foz7Uhsy1
+ptO/yd2lE51QeFLRXxqwIKUCAP9VA7JaMpJ3OBD+Qp9F9AZK+zTf64KFld3WxMH
FfxKk0rdFzvKtZpyqhdvSdqnOQr2bMTs6buhFK3yV447vYH5C2xHmhfQGCNqYJ6H
wqh4PbYK
=ppGt
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
