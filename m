Return-Path: <SRS0=OEgM=P3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB81C5AE5E
	for <selinux@archiver.kernel.org>; Sat, 19 Jan 2019 00:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B6F2086A
	for <selinux@archiver.kernel.org>; Sat, 19 Jan 2019 00:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KYRU/ore"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfASAV7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:21:59 -0500
Received: from ozlabs.org ([203.11.71.1]:44155 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730114AbfASAV7 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 18 Jan 2019 19:21:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43hJQp28KCz9s9G;
        Sat, 19 Jan 2019 11:21:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547857316;
        bh=rU7IeK61lzTcDvPgMNkmWlEqMlNpjHKydR6pW2YjHlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KYRU/oregwxZsHyNEKLbAmIcbXJGLMouLbreynjkeQQiMreHFr+nJ7I9sJgm2++/+
         o1FQMtqDw54paRnuejpDkMlYzCrrmKIkGofKBKDhz4ls4ZdLLexy8nNw/4SjcPPeuO
         RPDQHBzT7Hd5pl70OQgY66vEvlEP60chTFC45zKbqLNRflVmXZnQhO2TJ4kiTsxGfB
         z1YRz/MdcDbQv7CWIkHv9iXzRlcl9DgoVZtAHzWkzIdQChQtyUrVvVCCUmYABJHYP1
         7h+HXXGxa62X9n9R19f6VBNHD8Nw+MJ2nLSYwfRaZA55qkfI+E/mCn5lEJ/AUfB+aI
         qrKS8gvoQVMAQ==
Date:   Sat, 19 Jan 2019 11:21:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        peter enderborg <peter.enderborg@sony.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        selinux@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] selinux: Fix error return code in policydb_read()
Message-ID: <20190119112148.375edf4c@canb.auug.org.au>
In-Reply-To: <CAHC9VhSbtqhiMQdNJ_6yeX5+ggwVNyGYXe-E=bMj2V2z2MmAsA@mail.gmail.com>
References: <1547821427-157169-1-git-send-email-weiyongjun1@huawei.com>
        <CAHC9VhSbtqhiMQdNJ_6yeX5+ggwVNyGYXe-E=bMj2V2z2MmAsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gJMqX_JE6fFGnAWox8.kY=v"; protocol="application/pgp-signature"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--Sig_/gJMqX_JE6fFGnAWox8.kY=v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Fri, 18 Jan 2019 16:28:07 -0500 Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Jan 18, 2019 at 9:18 AM Wei Yongjun <weiyongjun1@huawei.com> wrot=
e:
> >
> > Fix to return a negative error code -ENOMEM from the error handling
> > case instead of 0, as done elsewhere in this function.
> >
> > Fixes: 31696241e96e ("selinux: convert to kvmalloc") =20
>=20
> Unfortunately this commit isn't to be found in any of the SELinux
> branches, or Linus' master branch; based on the subject line I'm
> guessing the original patch is in a -next branch somewhere.  Please
> find whoever pushed this patch to linux-next and have them apply the
> fix.

Yeah, Kent has a series doing conversions that is in Andrew Morton's
mmotm patch series.
--=20
Cheers,
Stephen Rothwell

--Sig_/gJMqX_JE6fFGnAWox8.kY=v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxCbZwACgkQAVBC80lX
0Gxvuwf/YOlqbpyIQythZbyTUStxs0jyEpMdah/xAtwgi0NcMzuyPpzjmobJxtrL
ra/V6iwHuvW3Uolci5HXGWJgBYyOt254ukCD6swbWo+L/3R+wXsLyxgGW4ABQ7Wp
Z8h+z4TJA7VN1oaIJjxgpiwd4z2AlhVIctk4UN7uZuDSFdZtHq7A5ZJ5UZv9XYBt
cNg/9hQsZe7EUNw0BRoJj4n1XDFXP+SPx+AU6bqDlCqOiUc1H/61PaGwfKUx/H2m
7jsIX4nKJLUPLRyyBHsYVy0fgISwkY4QRBJD7S6NRUVFpL7M0xIsgxpmotX2mVLG
FSXueEpf1dmEeDHJPpeDGegvBs0cBA==
=S/Wr
-----END PGP SIGNATURE-----

--Sig_/gJMqX_JE6fFGnAWox8.kY=v--
