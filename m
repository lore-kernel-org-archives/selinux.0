Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4953E2FC
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191919; cv=pass; b=o37vE5TJh8lQanmuv9WpAXtBE0Nnx2iFk6naBBcv3Pbk6ajnzn8FBOcsVLuGmVfY7TkmyL8wpJyekq/myE6NInk64N6JcH/0CBL4tcTRl6e9UuJ88fJDeBV343+1GgnYM5WXmomnmvoa1Mx5gJQS5HoKpdf49Faz6hufRjcHWIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191919; c=relaxed/simple;
	bh=/DNIFWcjtuouHSaeA/JNYdwTzI6jvMMdtjjAkJh4jLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MST16Wt5+03qx3teyGMsXcKHDe4yoEF5fP+nQDj7q0P95PLe05d5uOd6E+LEAW1Up4J7zPudcZI52kcDHlr6TCZ4aMPuEygnWhbMDxRBznsD2UFy5GQxJq3uW+h/P4FqfNbYg0SZWURtg9krAW36IkLR3oDxxgJS5u4u4PtamIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWC8bNOf; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWC8bNOf"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d45ae011aso18110277b3.0
        for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 12:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790191915; cv=none;
        d=google.com; s=arc-20260327;
        b=lfAqcxByjNUm+flKsCEnDT+U1xRC4gieqpC36Hz384sZrZmohZ9egryWYYmtyEkl83
         S/1X4KJ9MPW0wU7lULbkK8S6Q7VxlSQGUiYU1GdmRXr6VlcPw0OwDVV/Vo0rRiq2yhrp
         iWA/WGfW8WiQP4ZuZZLUFZkm3pqLeuPJfjsa5Iwd7RMIY1ix5z5sZmH13D/cHzXQsBZg
         Vc4wJNpvYA9IKuJl+47VYdUpqhqS4uqk0oz2RqrYgERS/gPgwF6m0DljTfaFPUTuWfjb
         7oD/1MhYW9ubMFlw/0+/9J3pzUA9p0pajn+P5GRt3aHz6h/THpIUmtDmLOXP7ZBUJ2uA
         ECRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/DNIFWcjtuouHSaeA/JNYdwTzI6jvMMdtjjAkJh4jLc=;
        fh=KcNbqYfh5/rp+3O/oy/Rn1Jlbpp64wJ640nU1xb/jaw=;
        b=VAev523asD72MY/Ubm/ccnaKcUC5Rms3QfjPiOt4EIJBNyenqOchc4/3L04ju0eucb
         SbfVg9IbCCRvO8GqD/leSvSnbx1Wskyuz7vmOnncibdSnRD2ELX9awg3D8PZI2WmE0ze
         vyupCWAH/M/khs3g5+eB2KMH+Z+CBY6EqbtC8F441s4dVq2v0Y+yVyTPf8/muyZTgsVD
         dXpPEueRREBaxYs4iAJfDYLPv8fvJdM/XTKJw6c54mZhCrqimgp42fL5P8KQDjst2ghy
         yOT+kbqigZ9echn/qCTXnSR7H52yB7tJMyKcRIpZtMHF4c2v1oRLgBDHucR5AvbeLxtl
         ocOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191915; x=1790796715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/DNIFWcjtuouHSaeA/JNYdwTzI6jvMMdtjjAkJh4jLc=;
        b=VWC8bNOf71ID72REjBUzQ4clSD2YXctJBIrFevFhP5uLFbLoO2q/qWIsOAmu+Hsbfi
         0KvEhlfaBNzSHFntxcUkzyTFtl0BpyPSno2uZ6FTe95kLVrqfb4QxZ3b5ArTa+b2wIPK
         ExgvbYKBUr0iB+mcn1sN2ie8PLsSA308c35dnf/EphZBI+p+HIrgKwHE+jZtbDiuMf6I
         xvhvk/KxzTWBdEVfCngKy3g1Eozs12/0UeeaPXzs5VFT9SkSImDusQHBGWPp08cnFLWv
         tRr0129+3J6al2X07ArtK7xNmSfgF4HpkUrFKDmICZGEznzua4gkxwU6dN9cruYcXMCx
         20Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191915; x=1790796715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/DNIFWcjtuouHSaeA/JNYdwTzI6jvMMdtjjAkJh4jLc=;
        b=dJioe8OqRcJcg0BgbU8AyQmRoNUXukfDvZUMEXH3bLddEvGUFw5VUR/OuLRBAdUJWS
         HsJCCkl1kfsdeDKhEMErPIQGHYmXPrmwQxFiwTCuIYhL6qqaKT4mrLDnDLMlSVGDWSWH
         +AxVJje0qbpjDN1I8b7CejZqNK7b7g5v9Tt36ncMd5gAah4BiOySs/6SC93sBpBsz4Ck
         U6KGA2OOlYuDUa3aZ6gAMr+RoX8+oZV9ue+rH+OyAMPPjALchUyBObPuuIuPSFjWiEh7
         nOJF/9N5UKMiOiFMWKXpCG6IAF7UfldYutS+5lmrLvJxr3V5Z8bx1Rp8K/F1kdiVYTBv
         iEdw==
X-Gm-Message-State: AFuF++l5STxleRdCPFjeH4TxR9lkx4hS7QpPVU4tqyLnk1/b5kbxSqd1
	da12fZ0nbYwulUCMfdd0svr+cQqbZ5J1reCcMlN1DxNkLC6tCLNP+AAtSZz70nAt/QX/w+TX2+p
	fWM4wljaw+ifS1CekPAAV3tFoE294PMQ8SmD+
X-Gm-Gg: AYBFou2ySHi7XuCsSG3D73Ngnz5p1R78Fh7tT1ezA395Q4+VqBXY0m8V99T+y2ms9lt
	PUlHLor7H3jRJYd9LEga5zXSLEX9RGBlQPPlKI16Cb+Bb2Scge2/oBag2c+one2JuvS/dTr/nYS
	W7zRhg6Vut7CRyHVm1zGeSjnMxd+3SMyZe1NRBwpM72p5D3Fwd1RAZMD6wfe0W+VVgx5K5PwulM
	AAGqRG0cxLzNurvpGrjs/bdtJzz+mIPybhBMDjDzaXzMBUg38MvGz34xpFxXtGgAWXQS7IsfgMQ
	mGzaKa4Y/CvjJg4bNty7jXPl/2zzovZjh4q/Ww7E/exTSO80BiXDEduKlPXIGxi9Yg==
X-Received: by 2002:a05:690c:e20e:20b0:89a:63bc:8d3 with SMTP id
 00721157ae682-8a64e5e5312mr833967b3.93.1790191915527; Wed, 23 Sep 2026
 12:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923155617.56593-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260923155617.56593-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 23 Sep 2026 15:31:44 -0400
X-Gm-Features: AclHuK_n0tp3MIpRM11Vz3kY7h96bQctqaB0F9sE22wJ_v01UfD3UrxizUFPTVE
Message-ID: <CAEjxPJ7hDTgHOGZ-OK=9Vu3Tuy6iEFO7JnFSwSA8iCVvcYi0dQ@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/scripts/fixfiles: search fallback
 configuration roots
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:56=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> fixfiles reads /etc/selinux/config,
> /etc/selinux/fixfiles_exclude_dirs, and constructs
> FC=3D/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts
> directly. On a system where the SELinux configuration is shipped under
> /usr/lib/selinux and /etc/selinux is empty, config is not found so
> SELINUXTYPE defaults to "targeted" regardless of what the vendor
> shipped, and FC points at a non-existent path. setfiles takes an
> explicit SELABEL_OPT_PATH literally (only the no-path-given case in
> label_file.c goes through the search list), so the setfiles
> invocations fail.
>
> Add a small selinux_resolve() that mirrors the /etc/selinux then
> /usr/lib/selinux search that libselinux applies, and use it for
> config, fixfiles_exclude_dirs, and FC. FC is resolved independently of
> config: a vendor config under /usr/lib can still be paired with a
> libsemanage-written file_contexts under /etc.
>
> While here, move the two mktemp calls in diff_filecontext() to $TMPDIR
> instead of alongside FC/PREFC. The scratch files are diff
> intermediates whose location does not matter, and when FC resolves
> under /usr/lib the directory is read-only. Creating and using the
> intermediate files in $TMPDIR is safe because the caller of fixfiles
> is trusted, mktemp usage is race-free by construction and creates the
> new file with mode 0600, and the sticky bit on /tmp (plus
> fs.protected_regular=3D1 on systems that enable it) prevents an attacker
> from replacing the file between mktemp and the shell redirections.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.

Known residual references to /etc/selinux that do not have a fallback still=
:
- mcstrans setrans.conf Include=3D targets (literal string is passed to
glob; if you care, the vendor-supplied setrans.conf should specify
/usr/lib/selinux prefixes in its setrans.conf and any child configs).
- python/sepolgen /etc/selinux/sepolgen.conf passed to PathChooser()
by src/sepolgen/defaults.py but degrades gracefully to hardcoded
SELINUX_DEVEL_PATH.
- python/chcat/chcat direct open of
selinux.selinux_translations_path(); needs a SWIG wrapper for
selinux_policy_open() to fix and only fails for chcat -L on a
vendor-only setrans.conf.
- gui/statusPage.py does os.listdir("/etc/selinux/") to provide GUI
dropdown of available policy types. Vendor-only policy -> empty list.

None of these seem like blockers to me to move forward with
vendor-shipped policy under /usr/lib/selinux but I'm also happy to
take patches addressing any of these if someone cares enough.
