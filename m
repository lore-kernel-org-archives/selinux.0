Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259832;
	b=KGqAlR3b30B26o7ex5XynM4oRcvNAY5ZWoAGS0APHkhO0t3jaPE20qVqQ/0xqh9vr7p8
	 3ofy0NSlwi4pWl8XC+NqfJXiCeh1gWHRjFxgEP+gXDUIZEJLyaKgN+dX9fnPG4JL76EC7
	 WDxsk8jmNEWYOmGz9zxg2CXVas27XDqVoYiwJF6pkD+HdXI/oNsiwjTVcWHbbNRXyVg8u
	 jyNs2ypeHCUkzIFbBJuwHJz16JrasyGMOviKkKVljanfGUAoxzUyAklfoaBou3N14YM8l
	 SzIXB+FLRYuv8xs23Fx0G+2z0nWtAMXDAcM2RuMBaXRBaZIHSUbZ9/cT4Ix3y3HLCIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=njjkZYJyqK98tAp78SKwIUi3lpd2OxnQLHE7CyLOajg=;
	b=Vbn0Ndt0EpVtGpZbhYUoGFG4K63nM90EEi0MPWhGpSeiFl0VFuhUIIaVcH0DTIOmGlcw
	 KXSob2Lzp4F8fpb8Jtyte/Jg+TcPYicXIO3djxL6eoPqK8l+2of9aF+XvzY94KGyeaP/B
	 21WghU+Rz3+XrsAx3EAlo153H8R25hebcvI0YWEIbuQCADkPv9OC+zy9K8RiACF0D7tIa
	 +1I3u+cBFejS9/uYVMjvYw51KBj8VenLA4XAySekLCYTKMhJcpvmW4nnRE46F5JE0+idp
	 2hmSrbEAi2LVt9KbrcYWDZNsoI1tIjs6gEUnGYJjiZeyiwY/iqpBbkmVL4Kzd/prtIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7uYHMCO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C452E606A31A;
	Thu, 29 Oct 2026 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7uYHMCO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20801F01825;
	Thu, 29 Oct 2026 07:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259831;
	bh=njjkZYJyqK98tAp78SKwIUi3lpd2OxnQLHE7CyLOajg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7uYHMCO4Op0o65e+C4O1vUCEIdSALNmdj8KY7Z64T7dy9i5ddLds5cf7nTUO1rRH
	 McZGlyuEVoccntgtTYeb19AyFCGkU4QSxmSuWIXZlzRwL3Z+Yi0eAasS9ZzbMnpuUS
	 oPMMndrU2NydLSRI6Fo+w/Yk/rLkRinAtWdU/Piii1CvOzwX/vPliQnewfADc1kFre
	 mxEsLWa27M2PSntvN2sm/5rpBioMk4burxhZBqDFX6wUi5mm7sfdU42ivVMcItZ++A
	 wnCYhu8TNfUexiv04ajeBrCpMpElNSGmqQCmEr6W8Lp55UUO8Jzhw7IsMRPvsRjIEp
	 c6QifSF/qKP4w==
Message-ID: <sashiko-outbox-188895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] mm: call the security_mmap_file() LSM hook in
 remap_file_pages()
Reply-To: sashiko-reviews@lists.linux.dev
To: "yao zhang1" <yao.zhang1@amlogic.com>
Cc: gregkh@linuxfoundation.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, ebpqwerty472123@gmail.com, paul@paul-moore.com, stephen.smalley.work@gmail.com
In-Reply-To: <20261028074251.1695-1-yao.zhang1@amlogic.com>
References: <20261028074251.1695-1-yao.zhang1@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:43:49 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: lock inversion in remap_file_pages() calling security_mmap_fil=
e()
--

commit 5a07ec5e983287a566c335be52d6b9bab2cb5e44
Author: Shu Han <ebpqwerty472123@gmail.com>

mm: call the security_mmap_file() LSM hook in remap_file_pages()

This commit adds a call to security_mmap_file() in remap_file_pages() before
invoking do_mmap(). This prevents processes with the READ_IMPLIES_EXEC
personality set from remapping writable file pages as executable and
bypassing SELinux W^X restrictions.

Link: https://project-zero.issues.chromium.org/issues/42452389 [1]

> diff --git a/mm/mmap.c b/mm/mmap.c
> index 273e06dad3c6f..7f357de8f4d68 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3047,8 +3047,12 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
>  		flags |=3D MAP_LOCKED;
> =20
>  	file =3D get_file(vma->vm_file);
> +	ret =3D security_mmap_file(vma->vm_file, prot, flags);
> +	if (ret)
> +		goto out_fput;

[Severity: High]
Could calling security_mmap_file() here while holding mm->mmap_lock for
write introduce a lock ordering inversion against inode->i_rwsem?

In SYSCALL_DEFINE5(remap_file_pages) in mm/mmap.c, mm->mmap_lock is acquired
exclusively before reaching this call:

mm/mmap.c:SYSCALL_DEFINE5(remap_file_pages) {
	if (mmap_write_lock_killable(mm))
		return -EINTR;
	...
	file =3D get_file(vma->vm_file);
	ret =3D security_mmap_file(vma->vm_file, prot, flags);
}

When remap_file_pages() is called on a file mapping where the VMA is
executable, or where the VMA is readable and the task has READ_IMPLIES_EXEC
set in current->personality, security_mmap_file() in security/security.c
computes prot_adj with PROT_EXEC set and calls ima_file_mmap():

security_mmap_file()
  -> ima_file_mmap()
    -> process_measurement()

In security/integrity/ima/ima_main.c, when an IMA policy applies to the
regular file, process_measurement() acquires inode_lock(inode)
(inode->i_rwsem) as well as iint->mutex:

security/integrity/ima/ima_main.c:process_measurement() {
	...
	inode_lock(inode);

	if (action) {
		iint =3D integrity_inode_get(inode);
		if (!iint)
			rc =3D -ENOMEM;
	}
}

However, the lock ordering documented in mm/rmap.c requires inode->i_rwsem =
to
nest outside mm->mmap_lock:

 * Lock ordering in mm:
 *
 * inode->i_rwsem	(while writing or truncating, not reading or faulting)
 *   mm->mmap_lock

Other callers such as vm_mmap_pgoff() in mm/util.c and do_shmat() in
ipc/shm.c invoke security_mmap_file() before acquiring
mmap_write_lock_killable(mm). Can calling security_mmap_file() under
mmap_write_lock() cause a deadlock against concurrent buffered writes or
truncates on the same file that take inode_lock(inode) before faulting pages
under mm->mmap_lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028074251.1695=
-1-yao.zhang1@amlogic.com?part=3D1
