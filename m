Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F713DA5B7
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356056; cv=pass; b=M5Bw9RJaEuydWIkxcfUCq9kLykOJsU40no6tueTXu0DdgWHEBvw043Jh5mVG9sZBwTIpf5PaVDXjJDFHGKqFULmQW3z7w8H32o9K4BqFRT/R3DrT57rlc8zJ+1AThcUrf3jeQDFNl9rGurgzwGJEKtyJ+MEvg+m1+ji/fHEAiiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356056; c=relaxed/simple;
	bh=Z/QlDjEqmTsvd8hmVsRhjPJAPZKduCsAshcn9SEcHsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSqAq1YzJOwhK9jI1NMFXeh+09KGnHeupi0JBfgokPtEpS2OWR0ViVaet8eUiRWSK4vDmBoydngZVvRcMPLHfVpuNZNhxMVwMmtdeRhAOOfA/HTvbopT3o5Gu4kwgJj+ses6UBx/Dw8XHudCk9FQp/+o1G8I8s8FkcQ6oDgIhlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JQ7vBslB; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JQ7vBslB"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f05ffcso5102875ad.0
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 10:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790356042; cv=none;
        d=google.com; s=arc-20260327;
        b=WcHjCKR1LcsIChrybv1KCivNIjk15s1raGqthU4c0jZng4hd9j1NxTgV/DJ22FzBuA
         JVycEPUHCRW9pCxlv0LfMxkvwpSrab90xY+Tr/IWva7QZZIhwSPMa9TjQouKm8Y7C1VB
         jzIBElz7y85TdwouKuaMUMZyOZqm9pCMfbLIwLTj9nBS+wo0aTHWwWipNiXrBVm74Fe4
         Izm799r9riAucr3n796T3KEWJcf5qyAgxTEUmalgTpmvS62/VG1NNk9Un5bBepM7r1jW
         AxIetWaox7JKxnPCxHg7wwVyScYXeD4OigMHBZVTVYHGOJS7OYUI7gyWP7BiRwIaca4U
         UaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        fh=YoLUb0sk+JXf82UH6YkjromlbbBx1VzZ2EUoGwQspuw=;
        b=ataTgaEfTUwfLxvvSDoJLuvBl4QUMcdjQ0na+JqDeLVXjgGPJIzUkJRSccJI//5ZEL
         2U5EfcOm8hHuDFEIdO+3sM7nGafuWSZrS95wsFMRrjC6zS/aUqNfNfEtP00i7vdyoa/O
         e00PxydgRRCrKEsTtPemILevOsMVH2BNjILesZ2pkbK13DsXwuceNzD3FVUou/Wgtb/S
         +eWuFdkLNprVBO5o3aKzNUuaGBDWmgFJ11U1tpM/6+pqueXsnjVzA/X+iaEtAtDTF5Lt
         LweCZG3P6VxCa/0VONIzRsdIhNta6eW9fQR6PAwBcdJOKAGVUC39npj0e+yV6uzOXRcP
         giHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790356042; x=1790960842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=JQ7vBslBA75Oz3vhccuiegu2ZSCVFqSF0HyjC/3/vNzOkrP+yD6f4D4JjYMSYAoFrr
         wlg7Wmn6oEu7SXRotz0a67VZfHRO6XibZ9ZQ2iaB3D1nQj3Xnbu+DnvAmLPuwuabcTJk
         PXz37aU1zp89S9iK0/x3WEyWrQZ8hNLRiSYpSLIsFe52Q0ZtYHr08wUrk94pc3ENWlQd
         J+Tedgfpmw+/PX5h3yjumGEOqc+s3rcWYPx4Hn4luwZxasnr3NVcHxFxvCE/jfitgeBw
         +jOt/CmP2fD13Y486VYHbVYAPN3U4OMa+qtVuZhbWJD5jm5g1hu0o/Zq9FL93oXYU7V4
         vv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790356042; x=1790960842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=XCgFv2q3qipOtTvexLv+WzCj1DrSCll61XBrDXDgjn/OUhq2Ie1lpdWe6IzOjYqqKh
         MC9RyRpfoT8GEzvYnKubcl/IRacrejtHnTJXvDhI9rsxFup6LLM4FjFEANnZ+U58dBL1
         A98Yaq3rvOXKvTp1EeLRwCn7JQ4V8id/4YHiJCA0tSfO0R2Q+U6ds2etbxEWWUf2gjIJ
         2BElmxWgQuqU6f1vG/TuGL2+MrAsW+9zwOyO+l8+AxGq9nFf4YRvTKzKbRYQHYv/c725
         RwgSltML7uwlLqJJDWx/A9DbSO6s7KVSLUY9VgmyvM/wkSj7k+RolpJngDF6+3TI8jKY
         fyOg==
X-Forwarded-Encrypted: i=1; AKwUvBy7/5qxm6Q1/CrzTprKBAjhyWEzL2ldTheyJjP4JwRyO0CFGBtMh7T/ZFMLNaa8ucON8CfAxT8I@vger.kernel.org
X-Gm-Message-State: AFuF++n5a9QcAmMz1h8NKU2rcvllj20/RH9mk/furLSiKG3nTSZmnBpG
	LiJ53jzgGFB+bXLVBI/koewy12IadYzkSffWzmqaPZfx6m9m9wp4/gEF45Udr/FMWJPH4eculFk
	kZ1Puvzjrf3xU1ivZyQw2VpsSHNKeENZ/w0L0vfu3
X-Gm-Gg: AYBFou15HRa9LgHbLWsXJp2jYgRtf6nzgF39vn9Ctdb2HsSRwWB4k7/72dUa123AnFc
	U4AOvcbYUXKIYf7uEzWAdieJN4eg4aO+87GpJ1upsjiu3adT2sDkE0RacBk1nG1dL5qM+Wk+tYj
	3xA0jgpByiGaPHzEAT4YxhyH94jN0RXUz0A7Y6VcYqf5L6Htb4YVmMoaGYMXy5ubTXUxxYYcDxd
	wgOj4R5vOqYEFf2TdGdoHPW0sQn06hVsM1AiPoMv7jYt0215H8cesV6vjvS/dB46JxPKCgM2HwO
	NaL3FHnJF+Pq2cj/E73LezEaYIz0KZBlwv99xa1uUjkLkH+C73jR01Izz3q805sJi/7Zy9WVqHl
	JG/Pejq8ewaiZy7vA9UjU3A==
X-Received: by 2002:a17:902:d48d:b0:2df:99e6:9448 with SMTP id
 d9443c01a7336-2df99e695bbmr12902675ad.61.1790356042370; Fri, 25 Sep 2026
 10:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924104831.1081137-1-caixinchen1@huawei.com> <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
In-Reply-To: <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Sep 2026 13:07:08 -0400
X-Gm-Features: AclHuK-PYyMWIn_xv6i13K6lF_3RP26uUOO_mtAnUMGHNcMrV5ydBitx8qn_ri0
Message-ID: <CAHC9VhSeXmOHvioZ12aVmnOtpP52-G=K_jS3K0fTSiCrDHStPw@mail.gmail.com>
Subject: Re: [PATCH RFC -next 00/12] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
To: Christian Brauner <brauner@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Cai Xinchen <caixinchen1@huawei.com>, gnoack@google.com, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dlemoal@kernel.org, hch@lst.de, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, jack@suse.cz, dhowells@redhat.com, code@tyhicks.com, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org, 
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	miklos@szeredi.hu, amir73il@gmail.com, senozhatsky@chromium.org, 
	chenxiaosong@chenxiaosong.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnacek@gmail.com, casey@schaufler-ca.com, 
	nanx95726@gmail.com, djwong@kernel.org, daniel@iogearbox.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	xiujianfeng@huawei.com, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:33=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, Sep 24, 2026 at 06:48:19PM +0800, Cai Xinchen wrote:
> > This series adds two new Landlock filesystem access rights,
> > LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA,
> > which control access to file and directory metadata such as inode
> > attributes (mode, ownership, timestamps), extended attributes and POSIX
> > ACLs.  It picks up the work from the "landlock: add chmod and chown
> > support" series [1] and follows the coarse-grained grouping discussed i=
n
> > that thread [2]: instead of separate chmod/chown rights, metadata
> > operations are grouped into one read and one write right.
>
> This is mostly fine for me. @Michael, for the fs side of things I would
> give you a stable branch vfs-7.*.shared.landlock.path that you can pull
> once this is ready.

This is in my queue, but I haven't reviewed the changes yet.

@Christian, I'm guessing you will merge patches 1/12, 3/13, and 4/12
since those are the VFS changes?  Once you have a branch for that, and
we have all the necessary ACKs, I'll merge the LSM changes in 2/12,
5/12, 6/12, and 7/12 and then Micka=C3=ABl can merge the Landlock patches.

Are we all okay with that?

--
paul-moore.com
