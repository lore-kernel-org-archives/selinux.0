Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793646896;
	b=CJqCbkMD0dEe8GdZgZyl6VEeTyi3g0AG/NKRrQOHFvlvL/PhgTT+5q19URXEmiffZ9hJ
	 xb4jxQlyQqMBj9Zr+MzywktnPUEOM4YnESoGgRjy4lWbnE26u+HfaP95/Zs8RUIgoah0U
	 7lXbts8WVQDhEZWIn21oeyTJ4vgIvfgzjpJmG15U4xJzy/h8LaXFzq2KWVdH1C1a2ks+8
	 kYayG7g1tCM+FcTLGOBpSEyhuAWC4hWH+0RwRdbUKuIK6VS/9O8AUtY2zY0Aba+7Nbca0
	 PZR+IIQxb01eIL2tKNRU7upsQs9ZBkI0JlnvpWUFnlfS+McHQamuBz75w/2Meup3tyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=bgu8PSI0Lkokg9QhwzLyscKvNyg1a50aQhBdGZkR4FU=;
	b=WmX7x1GbQEKDB1D4HzANBWEeSZ+JI7tZOsR6teDWbLbGw0EONEjU/0/vvY4RGQw6JB1G
	 KouOw47vt+gWYBucJ4X0ywKZ9tZhp072eslDxiIzEWdkbms09n2/3m9o43rIBmoQOfUzL
	 t/BKW5XTKElKOLUw65eTZ/0mYRB0UfdDt16p1d3Tk5nT2L9hAg5kLgAUc/KLU6J0dFMsw
	 aOIpnB9QiI7xAwnAlRLdHsTpjOqt1O9QGqLzdCdq/WcNrT6GTStYGrKO1kYNb91DZxavu
	 28ZGcbTTS95kCMXa+oAYkawnUF4PxFfR8Xe6dtCK74tolZnk8B1QaLjH5kOxTCT+ENw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XC01FadA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0C606EE9B
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 19:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69E0C606EE9B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XC01FadA
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67992884b02so2046574d50.3
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 11:14:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793646895; cv=none;
        d=google.com; s=arc-20260327;
        b=Wsem2aJezbyKO9geAzNDYHPlcg1wmcvskWMDdeF4HKpAeRmTQKS8je5Lw7aW0FllXE
         pLtMgYmIDg+jk2kyDJ1XgF8+4W5F4MDUZDRbsyvsk8ZAxD4sPc8N0ujlDR2Utb/9AqgL
         u6Jxy6cIDvhDUxDnGtNKcdQgqzyceHmbzho4E4l1fReW07vx7fNBIt5eznDpxtjC37h/
         srneiXkvAhBM+e169Lk78+O1zflzeKy4YAXsS9Wg87ldyKtR9U9hp2M7bVsTxK9zkN//
         xPN7jO1DD9E301dv1sOJWCdRg6iCyBZuusAzzehvIvCd427MxjeW1QlxXzjIIwN7XVR8
         s3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bgu8PSI0Lkokg9QhwzLyscKvNyg1a50aQhBdGZkR4FU=;
        fh=q08H+4X8i7EaC7BesAm/d8L4xwnPrnWz+43sBtlpBQc=;
        b=QfS2AdXz5xsiwJHDg36WqCZs0wwDQSQuehiHb7P4lJ2jYeAfIitCVLTl19Ymktgxvc
         PdRHnHCw+smPXrOg6Iwqj6/ZDgeIWJ4nR5sHbTF9gwWobt/v9oQts0G6Pljb2uwsijFq
         ljOOl3gZHdktKDHi6dUOkKeoeLKAocTIKxy5Shwm/6+uyo8aJ1Ihb5coLO4JiaP73o6e
         gJSBFV09GCgejGFERDtfm2BNy9GBu1tq1zYYgViBwVIK3IFAHlflE+dnkgtk5aaviunS
         BmiocT+V4ULFd9Uu9KNb6KqbPXKBvY0BGN+zttYu2wXRfBvKv2d22zV1ta0nSqCMaA4P
         DtcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646895; x=1794251695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bgu8PSI0Lkokg9QhwzLyscKvNyg1a50aQhBdGZkR4FU=;
        b=XC01FadAVTfgbliO0aJzU6cCavSh1auahsmJ8QGBQjRvAs0GbObuVy055ROD81F8oe
         Typ7GL5gVZ8op716iqmmYM/ERMStl1lPVCIkWCdsCPMhJvNwOpqEzODZiKD0AW24AbKR
         BJraT/96V2Zn1zrqv3HRrxSSpIQpRWGYYLyJPjSySFDlGnQDskwLO/nvQC5sKTHFZUVN
         ktqzSZJkdDC83kaGjWrmAdK1aatkbF5AlQZrHGbxwzlUc/+A04e3IpFMos9M1CbfcEqK
         fxJc/PFk/Wqy3Vx0Pf1FlOc9zLIJceNTZzU0y/bGc7/iNE929ck5nZjAI6kc5DTprvNk
         oCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646895; x=1794251695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bgu8PSI0Lkokg9QhwzLyscKvNyg1a50aQhBdGZkR4FU=;
        b=wNaVOQeqKkXin15zTKEIU0/3BeUurbZ1Q7gupF83xQWaTmSwpbCfy4RTjG7kVqfmrU
         0mzN49g/jukUgzPRrdSyv014VK7+1PO82g/fAHlaFGVKTua9NBdWiMSwsGNBF3AvylKQ
         Y8Hc/PiuEkKDbBl1wqwSpCNQCX3r22ocGeY15DFD6mDF4LSLePI+MeLFDN2c5h5JIwas
         OD26Y8auTo3c8Gc6v3i8+Er+tS4hT8fdw3VeNMopz6n+17nOMEfVG6i73UzDedCpuDjV
         Z+Aw/UGoZx1w0DKKxcZblIejd0RycpYdLOJSDa4/D1BAkmKeoct/m4VXAePq8hpMEyL9
         Np7w==
X-Gm-Message-State: APuU4Z9vTEN3bb2h4CvAK/ScIjBgRhmimTxzrR/NNNedgaI+kpp1WEJR
	x3CKq8trzTEbJ0dS6T03bOk3OGhRNY9BhHa205MYctAtw2pUCphGjSjhiH6+W+49SsXxMZ7T7nb
	6iHlixXrm7QLGbV4Ypo3WySrnog5sr6tcjy6g+Hw=
X-Gm-Gg: AYBFou1Q7YKLuRf3x73AJSEhXdcBF6JaQnMoCy5/LIzuYj8glcADdE/VDg8gNQt5Yz8
	mz88xHr2+BnDN2H5SFZ/vsXLXBGQ0tubxK11GW7B538d3X2sV5qHxwHMTli/PC2hFtK0rWVCiLO
	aNGT9xC6zB74eq8PSfVnNKFnkAsq4XD8S/ix44zXY3S48qfMv9UAtzm+nvd/zzaFtZBgBBS9VWM
	MrokHbrTQMp6XVVyOUNCwJjIuNneRUSDbr93+gpZ70RKXVx5af3LfCcM0aGgxEZ20wMuL7P7j/E
	ekgkLU12jtxB35jsMhjpILl7Flhsfb8iXSBSa70N0ddOQ6SpqquV8XOW4/zaRWO9zfkcWJNvF25
	IzhSqTFryj4jbAUMoMcZCbHpuIL/LnT2k4MWeApMXliBUUSnqPqDJLYG/9oc/vudw9SIsnwTPhQ
	Slw+YxFXN7h2xGgXTE6SahKZwbPddL5jrr0jLE3Tx3tzEubiTFCTfBZHQrNQ==
X-Received: by 2002:a05:690e:803:20b0:679:a4a5:10c1 with SMTP id
 956f58d0204a3-67ba4fa9d57mr4078177d50.22.1793646895354; Mon, 02 Nov 2026
 11:14:55 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102134718.1825-1-stephen.smalley.work@gmail.com> <20261102134718.1825-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20261102134718.1825-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 2 Nov 2026 14:14:44 -0500
X-Gm-Features: AclHuK8l9hHJ0ozBBXQqAHTxJijPN8aU_Ug3sOpaEOvwJdTrl-17lqSmnWCwt3s
Message-ID: <CAEjxPJ7OFBrzm4WNz-aJ4t8BzsEUHrHuGQinM8mybvKTn5YBNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libsemanage/genhomedircon: apply path substitution
 rules to home directories
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com, 
	Eugenij Safonov <ja.safonau@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:47=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Eugenij Safonov <ja.safonau@protonmail.com>
>
> genhomedircon derives the home directory prefixes for the generated
> file_contexts.homedirs patterns from /etc/default/useradd (HOME=3D),
> /etc/libuser.conf (LU_HOMEDIRECTORY) and the passwd database, without
> taking path substitution rules (file_contexts.subs(5)) into account.
>
> On systems where /home is an alias for another location (e.g. bootc and
> ostree based systems with HOME=3D/var/home in /etc/default/useradd and a
> "/var/home /home" equivalency rule in file_contexts.subs_dist), the
> generated patterns therefore use the aliased prefix, while libselinux
> canonicalizes lookup paths to the original path before matching.  None
> of the generated patterns can ever match, so any relabel of user home
> directories produces default_t, which breaks confined services reading
> user files - most visibly sshd, which cannot read authorized_keys and
> silently falls back to password authentication.
>
> Fix this by loading the local and distribution path substitution files
> and canonicalizing every home directory prefix (useradd and libuser
> defaults, the /home and /export/home fallbacks, and per-user home
> directories from the passwd database) through them before generating
> patterns, using the helpers added in the previous commit.  The
> substitution files are resolved below the final SELinux policy
> directory or, failing that, below the vendor configuration root of
> the selected store, both below the semanage root, so that a
> vendor-only file_contexts.subs_dist is honored without reading the
> host configuration.
>
> A side effect is that the existing check for password file entries
> conflicting with a file context now checks the canonical path, which
> makes it catch conflicts it previously missed, as file context rules
> always use original paths (semanage rejects aliased file specs).
>
> Verified in a container against the Fedora targeted policy:
>
> - HOME=3D/var/home together with the stock "/var/home /home" subs_dist
>   rule now generates /home/[^/]+ patterns, and matchpathcon resolves
>   /var/home/<user>/.ssh/authorized_keys to ssh_home_t again
> - a subs_dist file available only below the vendor configuration
>   root (/usr/lib/selinux) is honored as well
> - with the semanage root set to a target image, a subs_dist only
>   below the vendor configuration root inside the image is honored,
>   and a missing file in the image does not read the host's rules
> - chained local (/srv/homes -> /var/home) and distribution
>   (/var/home -> /home) rules resolve to /home
> - a wildcard source (/*/varhome) and duplicate rules behave as at
>   runtime lookup
> - per-user patterns generated from SELinux user mappings are
>   canonicalized as well
> - with no matching substitution rules the generated file is
>   byte-identical to the unpatched output
>
> Reference: https://github.com/SELinuxProject/selinux/issues/547
> Signed-off-by: Eugenij Safonov <ja.safonau@protonmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
