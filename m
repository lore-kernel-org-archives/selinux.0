Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F31A298994
	for <selinux@vger.kernel.org>; Tue, 22 Apr 2025 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343607; cv=none; b=UEJYaeNTgs1HJ62A093XrkBp7G4Qz4MrnJeTFjLZR74bqvWqAJTTRCEKDQ3PfeFyVBDFnQVokWXbhDhbedNkHSnPT5ugioII9x63H4uSb9z70WfYfNYsIPKvew5nBwM22LwjkVZRx8+L50XA4MUHhmOi8yn4S3s2Cj6XMq4nQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343607; c=relaxed/simple;
	bh=ohkX5v/wn6TdBVl1olLZNul+eUljQBWuAXYiumEprzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=esqXGoBD0H/GZEDWsh0BWP7kBq7h6It9wCyiPGopfc0SZ5cLY865YuKdhOXaK2gNvY62f92T6LYPIXTirguhKoUWo3K2EJzppXYLRB1w0aj7rYIrMBvpGGtuSGiifVQY9+R17C82MXikEYC/NpzUYhiovO5o/zWQ7EwH9GOPlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=IBsxDEcK; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="IBsxDEcK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1745343323;
	bh=ohkX5v/wn6TdBVl1olLZNul+eUljQBWuAXYiumEprzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IBsxDEcKPmbt3oVXEqY1aJJaretOYWQKLPg3/ylAzdYEonH2cub1F00FkCdaWG53s
	 XsqDcs1zYnJEZcgrQBxwPRbYBUNq4T+tn0WdxOO0zLhYs0jn83qcXeXYeUlws77ir4
	 knfu6cBnW7NZx89ShQlasq8NhGZJH8bddIn01iQs=
Received: from debian (debian.lan [IPv6:2a10:3781:2099::988])
	by markus.defensec.nl (Postfix) with ESMTPSA id 10C53176491;
	Tue, 22 Apr 2025 19:35:23 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Rahul Sandhu <nvraxn@gmail.com>,  paul@paul-moore.com,
  omosnace@redhat.com,  selinux@vger.kernel.org
Subject: Re: ls from coreutils 9.6 doesn't show labels of some files
In-Reply-To: <CAEjxPJ5GVOrX8-MhQqMJ6U+1TSYJ=mPyL1GxMitetkovgh1O8w@mail.gmail.com>
	(Stephen Smalley's message of "Tue, 22 Apr 2025 13:28:46 -0400")
References: <CAHC9VhRj4CWBbSCEiznjNh_WaHr2vEGB-_Xem=VqRyptR=MtGw@mail.gmail.com>
	<D9DB7KSD01JE.1LSPBCYV65C6Y@gmail.com>
	<CAEjxPJ5GVOrX8-MhQqMJ6U+1TSYJ=mPyL1GxMitetkovgh1O8w@mail.gmail.com>
Date: Tue, 22 Apr 2025 19:35:22 +0200
Message-ID: <87fri014md.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Tue, Apr 22, 2025 at 12:31=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> =
wrote:
>>
>> Hey,
>>
>> > I can't think of a good reason why we would ever want the *listxattr()
>> > syscalls to not provide security.selinux, if there is an individual
>> > filesystem that is different/broken in this regard it should be
>> > treated as a BUG and fixed.
>>
>> I've spoken to coreutils upstream[1], and they also seem to see this as
>> something which should be fixed in the kernel too[2][3], and appear to
>> want a solution in the kernel rather than working around it in ls(1).
>
> So I assume this was introduced when tmpfs/shmem grew its own xattr
> handlers, since previously it would just fall back to the LSM
> security_inode_listsecurity() hook and return the SELinux ones
> unconditionally. shmem_mknod() calls security_inode_init_security(),
> so inodes created after policy is loaded get their security.selinux
> xattrs set and returned via listxattr. Root directory of tmpfs mount
> and any tmpfs mount that precedes policy load (e.g. initramfs) would
> be the exceptions. Could modify shmem_listxattr() to call
> security_inode_listsecurity() and combine with its own list before
> returning.
>

This also happens when you mount an unlabeled fs:

mkdir /media/foo && mount /dev/sda1 /media/foo && ls -alZ /media

when you label it the issue goes away:

chcon sys.id:sys.role:media.file:s0 /media/foo && ls -alZ /media

>>
>> Thanks,
>> Rahul
>>
>> [1] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00011.ht=
ml
>> [2] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00025.ht=
ml
>> [3] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00031.ht=
ml
>

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
