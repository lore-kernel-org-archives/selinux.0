Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261266;
	b=D+aKn2aLD/hduLz6VykadKfE9jaTVVYobMvQI5/z+YVtY6pChvBnd2fn5bq/WB1kfc1i
	 xAPfTOrFX3ES+Zyqepk6ErTCz17jCRtsBOy5oe1BXWSobHGgDEynLXCN9C9LI4FNzs/Pq
	 6Ux2uJUmZHwaScT3TBE+SyY9n7nAlR2SeP0cHq8xJ5kmOBj01hDAWEoe/br7tyR3532zg
	 S08a2t1LXS1XG3mrS3ETNSUe1+1xInTddlHC+hBnNMZgBwzm/XY/U46fDfpKHoeNcbhoO
	 vxmHf63uNt9aZ309hOkcAgPuEa0Ub1oHa7uSCBGkAXkWRx853Ka8Z67+Bvm+8HESS8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261266;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0/5uRqJy/VgEhejne3xSc6gn5mfLQb/Op0B9UDn9Dv4=;
	b=RXGdEQIVNYD/ndt3ummabEny34Bt9DEJJaTdMhSt1OGaj9ll2argr4djn0uZYxvV5RkY
	 Sb9wMSz+oX932CqqKzuXg2A46Kjky6kEGEZqzpUYEsjzOAwrKAgFnJ1AkPYouLyxaeOeG
	 3YubA3EqKPzb3lCR1Mlj9QWFTQJ16HKuWtgnPo2Yq3OaW8ex3LW84mqIHyB6Bi9oYAADG
	 MrhM55LF2Aqi+6yhz0KCM/ijNiZfgM6G7obJx0cjF34lkPTXg63OSjLlDasrYwLwWI4SR
	 bjJlpgcpYX/QBNcEH9We/4LRm1lF3+BqXF/0K3gxYFdAA64kgWuUNsP7MHeG+G1O9dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGmzUw0h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C79606A31C;
	Thu, 29 Oct 2026 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGmzUw0h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D42B1F01825;
	Thu, 29 Oct 2026 08:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793261265;
	bh=0/5uRqJy/VgEhejne3xSc6gn5mfLQb/Op0B9UDn9Dv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGmzUw0hxqQB5Jq7K0ZmE8qi79Qh6q/FwJOCvyVhuK7bYNkKkjDFg7534wmT5brvs
	 R0PXvM2ulEtAq4iCNIerACIRHsXPOSAtUVxeEG1CmR+Xn1k4TU5Id+LxPC+eWgUxXN
	 9FApgWS5HSHxCcH0kStuEJbBSRGwq6uLCra3Zfgj7QxRnCcrnRvM3SnYOYQ7Thk6ZI
	 2VaWoduewMiSMIE2jaCqh9vxB7nFdNZco1bjLrXd9xzt77p9AcghmjlJCWrMzaitN+
	 /yJN0+twezwW2pILyIesGTCtPXmNGM5v9Z8qax3+IUH9eWF7JfWJpE6kjE5EmW9uuV
	 9AkBlLloGxKkQ==
Message-ID: <sashiko-outbox-188948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] mm: call the security_mmap_file() LSM hook in
 remap_file_pages()
Reply-To: sashiko-reviews@lists.linux.dev
To: "yao zhang1" <yao.zhang1@amlogic.com>
Cc: gregkh@linuxfoundation.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, ebpqwerty472123@gmail.com, paul@paul-moore.com, stephen.smalley.work@gmail.com
In-Reply-To: <20261028080719.1821-1-yao.zhang1@amlogic.com>
References: <20261028080719.1821-1-yao.zhang1@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:07:44 +0000
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

commit 78749fa17008059030caa915f2db592fbe2d9fa2
Author: Shu Han <ebpqwerty472123@gmail.com>

mm: call the security_mmap_file() LSM hook in remap_file_pages()

This commit adds a call to security_mmap_file() in remap_file_pages() before
invoking do_mmap() so that LSM policies such as SELinux W^X checks cannot be
bypassed when READ_IMPLIES_EXEC is set in the process personality.

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
Does calling security_mmap_file() here while holding mm->mmap_lock introduc=
e a
lock inversion with inode->i_rwsem?

In mm/mmap.c, SYSCALL_DEFINE5(remap_file_pages) acquires mm->mmap_lock for
write before looking up the VMA and holds it across this call:

mm/mmap.c:SYSCALL_DEFINE5(remap_file_pages) {
	if (mmap_write_lock_killable(mm))
		return -EINTR;
	...
	file =3D get_file(vma->vm_file);
	ret =3D security_mmap_file(vma->vm_file, prot, flags);
}

However, security_mmap_file() in security/security.c computes the adjusted
protection flags (which includes PROT_EXEC when VM_EXEC is present or when
VM_READ is present with READ_IMPLIES_EXEC set in current->personality) and
calls ima_file_mmap() -> process_measurement() in
security/integrity/ima/ima_main.c:

security/security.c:security_mmap_file()
  -> security/integrity/ima/ima_main.c:ima_file_mmap()
    -> security/integrity/ima/ima_main.c:process_measurement() {
	...
	inode_lock(inode);
    }

When an IMA measurement or appraisal policy applies to the file,
process_measurement() acquires inode->i_rwsem (as well as iint->mutex) while
mm->mmap_lock is already held.

As documented in the lock ordering comment in mm/rmap.c, inode->i_rwsem ran=
ks
outside mm->mmap_lock (for example, generic_file_write_iter() ->
generic_perform_write() in mm/filemap.c holds inode_lock(inode) while fault=
ing
in user pages under mm->mmap_lock). Other callers such as vm_mmap_pgoff() in
mm/util.c and do_shmat() in ipc/shm.c invoke security_mmap_file() outside
mm->mmap_lock for this reason (see commit 8b3ec6814c83).

Can a concurrent buffered write or truncate on the same file deadlock again=
st
remap_file_pages() when IMA is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028080719.1821=
-1-yao.zhang1@amlogic.com?part=3D1
