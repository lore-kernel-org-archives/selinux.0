Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793364240;
	b=cFL589wpIGNjROUw9UCKoESHom1fSCnLtVQcdwY3kb8nbBYSzxxzVQfGL4XHjPUKtfad
	 rQroRQN7M4q55j/gPbaiA5GZs7rguCwuMQcQ93SBy/ELePS47Yer+8P5i5HLxT28T82hp
	 vbH8EIlftIpJtpOxGFrZ0NFcBl9xXENrXLYaFk0hukO0DDyMpHO+th+xFZWKTx/E+GTLt
	 q/7Ky+qgEZ+v7N4SBAjgV6G6Poi88pdkrWMkd9b9C4MYRa4S4Yy0CNFqd+ghTxEp0P8tw
	 IS4Q/8vH3w9TBrGKVIxmn04a+mqYXRNQm5Et7f46Y9x2dV7Qc+lLxv2HhxWzd/HACbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=cLdJG2N/zgLsxjYC7GO/7yAMaY1FF1qLnz+aCKN5WMQ=;
	b=L/pDZBXjcbsyKqCGiDfmUKqe1yx5agmUXYfBhXEcXIyX+SdmZEB9CPxQWyVfajYGL68X
	 iyg8jn1IsD7hIbfu8p8G/OI+NyfTRLlftfMxxcj/idrG0Q/Lf5twHEGZRhzC0VBiJU1wk
	 00kefKaSPNDNZ2G1TqPKe5R7x8qHFOIxp4ucLlxllX+k9WSrVWgg7XLTRnX1yeNyoMMkU
	 6Y0fe74XLSDjHQj7gH/I9gWGK8pMSXEMqFTL74tp7/mxn5NUNwtTL7xr6uH7qnHnKPmPk
	 xTOQfTm/OErgmSDmCRWAioCFinsb9nSkjEa1J44eIysvgde9HlRmJr3br1gq2eG9ceQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="j/CqHmZR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750DE606A31A
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 750DE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j/CqHmZR
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8ab3d3c5761so6194427b3.1
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 05:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793364239; cv=none;
        d=google.com; s=arc-20260327;
        b=CKPiKtRqGTDE0MCCl5kmy7i6xxRslwChtyTmBgzwCcI4t4iM/p7zA5B/y6e/rfuxWh
         Z1ht82j8RhQXM7hbvpYXX5Rv2RLqFdWfV74v+Jj8CAGI1o+8A6oc5Ua5N8wFJGZJKW/f
         5PdgZnJqlq7VvvIB4+gzPkVprnbbjOzrN/D5NdefYcDV8onBmiv/D8uuZdCku9zIxHqU
         HFewrpG/LhWCsL6VLtCBvUExa8Yp56zxDDGz5KF7KYfBPUXPRDW3qCeNeKCxloeDIJ60
         aQL2yfBTDA31eHfSrKFzDvqIKTUbYJ3uEZk/D7dgzwkelLAQkrRdav6ruO54jv0Sbd+G
         rsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLdJG2N/zgLsxjYC7GO/7yAMaY1FF1qLnz+aCKN5WMQ=;
        fh=q08H+4X8i7EaC7BesAm/d8L4xwnPrnWz+43sBtlpBQc=;
        b=PGqpuXii3rh6xhnQBGrokXvVvRlkpcqd5hfWlDx7IIsBBCh5534AuBedKJMAWALatf
         wQiwZ8OgdNgDyMNSLSzKHkWAL3sD5NzRf4ezOImlKZQ1JIFNEAg1nbOrVG6tbpuDpwK7
         ZCh7aIGxaXWmcf6ElqzryxjKNiuMT7egVQP/attlD1HhUPZbQ4DutGuQqbW3fWs8brbg
         sfzxgfyn+WHA2Ze96Hrt4GUVDFfrNyMXx9oSfAVlZwcs7uLGveZZ2mVkIKlnIamknzi0
         INBIyNCt+VUODdTYb8FzTq6PklA73XiQE6F3E/2n83gkcHv5m72d2ZFdXElg0zrlxmDW
         74hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793364239; x=1793969039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cLdJG2N/zgLsxjYC7GO/7yAMaY1FF1qLnz+aCKN5WMQ=;
        b=j/CqHmZRV2DFtJTiODMhhAG/5Nl5Ju6byHE82oO+9KaXqy74Fz55vg/YSNeUBR9ble
         FLayPCT/VvPm/fjj2sC3oAQUavgORxkmzO7b/W5Xx22Jsk7J3ueXAdvfE6aUBkodSMaU
         P257iuuWnfSKeTyRaqb1sADajeDgKF0aLHEYy6GuP5+Gsg+d1SyYHAoDQ9eEIyxFns5/
         fk4oVOEu0wZ6TRQTydCABCuS0qOxDDktfSKZxHrWgrq1x/XrKI5aZX3RyadWyOXZa2Vn
         SBLwuRmkz3jK2nyiD0RQgAK3wU+HhKWGdsW22QOTM9Fyyn10ldgK4M2NkXfOeP03z9TU
         3w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364239; x=1793969039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLdJG2N/zgLsxjYC7GO/7yAMaY1FF1qLnz+aCKN5WMQ=;
        b=FI9a802qgy7GFA+mZRmGubLJqWEDSuYf207+x1taeaxpcsXF8kT5HQVr2cMOaQ5mO+
         zP3gGiHZV+fu2+D2tgl4l8CcOEsAEqBQEQN+vH1TJ8lUPD4Pzl2FkagOiiqaSKtwWUIM
         w0X1Sw0537wQfPCOrni/TUmBiQtFypgTj29yrZ5Wsq8uQNGE76qZsLzj0+0OhVQ1PyJr
         HvC5jUyqxaEw4FMimjMnhM2Vkr81PpnhKZTIWOLI/HVsQ5PLdT2/w2mDXD+6sLvnm7y3
         7RE8PfnY7JTEOOdOyp5vtFCLTCq1Rx93rkX6BPwnajr1ITgTj24XS3SlAmuVPTKrAyFu
         74ew==
X-Gm-Message-State: AFq9FYLzJjkrUxafKQieWhTlzSp+y5MtfbbIisKhk8viVpLBHu4S3fQ9
	zX5XjaAB+Emgca9M7PtnGzKHVcjsxOkOn/aVzcHPTvUeL2vnEAYhfmQioq4ee591WfilfQu+DI4
	u6P1VSN/YlpvgZqHVLmnXbsP5YpuDmFAvvPkK7k0=
X-Gm-Gg: AYBFou2VvNaG/pId6RkNDXwqiyV1NmxXDErcoOmS8+I9Z0a1WDYj1Xug00+v4nauiwR
	VJr3nm+otlwPR3igfaAo1Dcts29MU47l0X4OcmnCqXNnKPCiNVoG6iIpcyerxVqdTaRMkhDHmEp
	IHZA2MMgFtw9pCSYJNe3/wNgEgx5Zigp5aPvscUMoU81usXNriCekDjhJ6VbUv1Jnx55PF0tF+w
	zOAy9cBiadJtB6z87evVdb+374CAXhHVFq/qNkZpNFP18NJZqhAgqcB1GpNmS0Myw38H0ir27iV
	v+pSU6r39FJVY95QrdQwg6QP8Xg4617JFFLwT4IwjawnIl9QsQPtUbASO5J139S2UKYfJW3ZohM
	Jw2ydchxQCu+9V0iVGa0X+yq6HsrYHITy9ldGGpWYTQhdAfHBfBsNtsIe98ACNH+HSiziujVs4C
	QRDkdl5nwEJkoHi1VKYv7CqmJSiYCmjKK7WdaWqzKcl5mILadtlZfHMD3PmA==
X-Received: by 2002:a05:690e:12c8:b0:679:a650:a083 with SMTP id
 956f58d0204a3-67ba4edd86emr1641886d50.21.1793364239292; Fri, 30 Oct 2026
 05:43:59 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029190309.138027-1-stephen.smalley.work@gmail.com> <20261029190309.138027-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20261029190309.138027-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 30 Oct 2026 08:43:48 -0400
X-Gm-Features: AclHuK97egTzGgOjVD6GtE0m10O21rhE5vlmHKzKv_31roptbPOBuBlr2MYmcN4
Message-ID: <CAEjxPJ7regez0egn+JB0OaUprHVXewqLvRWAPai_XeDXKVRN1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libsemanage/genhomedircon: apply path substitution
 rules to home directories
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com, 
	Eugenij Safonov <ja.safonau@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:03=E2=80=AFPM Stephen Smalley
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
> directory first and then across the libselinux configuration roots,
> so that a vendor-only file_contexts.subs_dist is honored as well.
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

I have commented on this patch in the GitHub pull request from which
it originated, requesting changes:
https://github.com/SELinuxProject/selinux/pull/548#discussion_r4423641227
