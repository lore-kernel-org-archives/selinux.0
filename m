Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928263;
	b=d4COk1woc8ZS/lJIxgazhPHyrtFDW4YTCehEjDZXpmB03r+HSr8B+naW5lF6bxeP6s37
	 l3euD09Sguo2Jxv6yB8k6b/hJhGUwLSSHDyHr+UJ8mMpeH9iukjwKgOOqER1i4CX3A5mb
	 ACH5csz9OZ5aOEzKviXCWqAP7cRmknqVYXVMufIL45oo6O+9qk2xD8E5bZgeDLA9yEfSx
	 DMtvtTvEHHxfIXV1FHPuUhgSwYqBAWHn6EYt2Vq8OsaKyBJDjJwe/Q0fKxfGHbImScjan
	 9GtMCWHRQjqZeBxjCTrmNVC8tPDXK5fFehMeDDVAi6Q7b61CYZvASfHtfmrDhuQ4oYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928263;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JKtfIpUwJjMPuaMfshwYWU+JAF3+7U25pVtA6amrrUU=;
	b=bh4tEqHN5RtytWII1BsirAWytqnUmQTqk2L6E4Xejzg1ksWYXdkCzc+01FWONZwehOr5
	 34VJbrfWsvwJqA2ZnhL9EiXsXFX2rRrOcMBdGYA7YZfe8Mv3ckpKmx7KopT1hNDgXRvEc
	 6442mTVHp01MjDcHNAGad27IYkcQI2No+1I9A729141upRL+jP3mRHoHiSs1pqZGu1k02
	 Y4E5HwVdAClWJOaqCTxV9VbAo1OCnMQ4ripsD2Fw3yJC7C0+Mivxr9AWFF57u0qDSjdrk
	 ZgX17TFxkO6t/og+1Vo0A8NSZS98lAC2qqZxiywE9hto+vj/UnUvdw73+AdFcTIvdRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3q8EneM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFFD606A32A;
	Tue, 17 Nov 2026 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3q8EneM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCF41F000C4;
	Tue, 17 Nov 2026 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794928263;
	bh=JKtfIpUwJjMPuaMfshwYWU+JAF3+7U25pVtA6amrrUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3q8EneMEtp/d9xtALDj4No2l5AqtcHEPVYqcfIih541WJ5wq+Oc3NQhGxHN7f1I6
	 4YKpC6M0xdERpdSwi+C8eJqzThXJWwTUuUsSuBLJPGtpoWKCN7FvEa0AQxghHpd3Oc
	 v2dWt1IqJfPJwcumWicEql4qLMF86Bjwcye0OXsE6LsxWmjHANdqrpDAYM5u7UtU/d
	 WWy+0pS/YQbFscdkzhd3L8FzKws5vZ5ij3f6mcTWr5YJUG9ZlmcCH/J+1RnMRy4XaX
	 kWmUGKbbFd+IgO1cQTpjDYbZfKFolPKPN4FxJ8dk6vMCJOoSF8aIVc7dIzws+4NASq
	 GyeWxPDIRA/cg==
Message-ID: <sashiko-outbox-219031@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 08/17] LSM: rename inode_setattr to
 path_setattr and pass struct path and file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117150542.1169451-9-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-9-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:11:02 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] fs: missing struct file propagation to notify_change_target()
--

commit 283fceee103640c180b1123a9a7934aad545e43c
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: rename inode_setattr to path_setattr and pass struct path and file

This commit renames the inode_setattr LSM hook to path_setattr and passes
the caller's struct path, target dentry, and optional struct file through
notify_change() and notify_change_target().

> diff --git a/fs/ntfs/named_stream.c b/fs/ntfs/named_stream.c
> index 1c55588df5ba0..05cac62fca1d2 100644
> --- a/fs/ntfs/named_stream.c
> +++ b/fs/ntfs/named_stream.c
> @@ -901,7 +901,8 @@ static int ntfs_stream_setattr_common(const struct mn=
t_idmap *idmap,
>  				err =3D -EINVAL;
>  			} else {
>  				err =3D notify_change_target(idmap, attr->ia_path,
> -							   base_dentry, &base_attr, NULL);
> +							   base_dentry, &base_attr,
> +							   NULL, NULL);
>  			}
>  		} else {
>  			err =3D 0;

[Severity: Medium]
Does forwarding an attribute change from an NTFS named stream to its base
inode drop the caller's struct file?

do_notify_change() stashes path in attr->ia_path before calling
->setattr(), but does not record file, and ntfs_stream_setattr_common()
passes NULL for file to notify_change_target().  When fchmod(), fchown(),
or futimens() is called on an open named stream fd, the second
security_path_setattr() call on base_dentry runs with file =3D=3D NULL, so
LSMs and BPF LSM programs treat the forwarded check as a path-based
operation evaluated against current rather than the open file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D8
