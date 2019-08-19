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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F221C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 19 Aug 2019 20:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5F02087E
	for <selinux@archiver.kernel.org>; Mon, 19 Aug 2019 20:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUiHdbU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfHSUF5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:05:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39484 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfHSUF5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Aug 2019 16:05:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id g8so3140777edm.6
        for <selinux@vger.kernel.org>; Mon, 19 Aug 2019 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DcUQd9Lo3zWBfcI4JeksP735gK+ThybY/75x4LGAdqs=;
        b=lUiHdbU4yIxjlHeQOZpPxsM/L2e49x+sGma4d8HN9P69oe3vhBC/W0pEW2OYcaSP7j
         GcmrCSS26siCXJZqEDFHzDTPXhRnARTiFOBUFDzgdc8cTgYvRsDZga8QZFmwjpUaHqId
         nfPyjtUgBG/FGT4YB2xXU0zWpDFc+3Q8K636PPEFTYv6zh6JXFnk2bbN8SrIOwpgaP9E
         kRZAI1cdsFahTwKxk1qTLdPUmWqEq5Wx647PaUHDk+IeUn96w8XCGILBCUBO8xIl2Btq
         tNmhv2MzG/YHIK2tXQdpkMHymFrWCIv1CfPFtV0yyX9lpTIXOL42xwFcC3TLExsz0YMw
         q+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DcUQd9Lo3zWBfcI4JeksP735gK+ThybY/75x4LGAdqs=;
        b=Bb9IgNJRJ3x76jJH//eT6NfUjS/aDEZTQyVVk57JON2OuPuscemtmiJkZtL7kaWzNI
         9jfVevn7ftTXFwxRkVYr6G7upBJC3j8Fjmcq6at1vQV4cDuFTn497yy+Bp/c5A7uPUL6
         btKFbgyEEtVHya/x5vtibHKf7pbVLpbS3/pW797EyMv9BhSiJbairaT/s86NGmPfG/ur
         qH7K+NNlebG0gKh9aJLhVEIKMLOSWGpOD33ZOIXnEMb9ATYWNwjM9APBCtlbd0Gxwl4z
         sbqZ5R4VwkGDquVuhNPWhSznX9JHX3Hh5WZzIU6d+iFYOgftMltqw13xRCNpSKuQE/aM
         bM5A==
X-Gm-Message-State: APjAAAXC7L1O6273m8qSegpnYld4zONfrA2nyZ9/I365KTzIWciPBfAP
        R2l2VxMzzwRY+YE2lXXx0uc=
X-Google-Smtp-Source: APXvYqztTzAsFtCbZgUwo48nqZt0AFnGdL+qZvQA0Kr2pia7iC60tH6Fh+1qwOmo8YwJUfNQHi0lKA==
X-Received: by 2002:aa7:c899:: with SMTP id p25mr26930929eds.41.1566245155318;
        Mon, 19 Aug 2019 13:05:55 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id l9sm2992584eds.96.2019.08.19.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 13:05:54 -0700 (PDT)
Date:   Mon, 19 Aug 2019 22:05:52 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     selinux@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>
Subject: Re: [PATCH] selinux: allow labeling before policy is loaded
Message-ID: <20190819200552.GB749746@brutus.lan>
Mail-Followup-To: Jonathan Lebon <jlebon@redhat.com>,
        selinux@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>
References: <20190819193032.848-1-jlebon@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20190819193032.848-1-jlebon@redhat.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--pvezYHf7grwyp3Bc
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

If you cannot validate against a policy, then how do you know what labels t=
o associate?

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

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl1bARsACgkQJXSOVTf5
R2loMAv8CrEygvfrMZu/r9uW15ipiNnFAFYLKdZzV19zzol95vjcS71xgaJZ2olg
PoeXICZLh+APBpALNPaLdAOg3LdE418zkZeLfjBXA7/oUOdFNTNbajXZ97htFgVG
Q14w4q3bMtNChYDBOw26r6jVp8mFaXhx7/J8VhAmn4gWflkHspw263jpajQeFXHz
zk7JZZcnXRg4AQTIsjO9Luln8NT4a2o1m532lInB2E8Tkn8us49GlSL25p0KV65b
pl5PlkA7vINJJJ6+p2z/af9m4+BheLaE+M702DlcVUow8HDdx8ejwHcVMS2+peDF
ULCnu8Co6ur/S4DAmBeQaNe0aiM2yZ6gnTAbWKbWO24gF1bgs+jHReMcnyhYzCTy
pXvUcor9pGN3mMCvMmD9ozNuTFQLKPr4x2nzpEY9sPkXUMfblZaC54sRqdJLSa4Q
v7D7SZVgwrM8Th5rD/lbQPz7vmRU52A3JoQfCUDCVE9tRMLyx2NO8ZN2ZIyeB3GT
ejLAcZ4N
=McPY
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
