Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505DE2E6CAB;
	Thu, 10 Sep 2026 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026659; cv=none; b=Sowpqw3EbGRtBYGP6dzDG1unozGJhGiMcVxp8kayEPIIlkC+VBsW2cjOwojeuHaWrJKpOZHJNm/j/XMokBWnpvqB3/LTejopMR/gLm/0D7aSdtQLg/O7MbNThQQ/6y6YSz8e/y6RL7+CPXFaNMrAl2a3o8by8bGgqnthSmOVHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026659; c=relaxed/simple;
	bh=KP/TVT990Jk6qSqTonW4zGEnqjZVXeEhG7kgWM7rpbU=;
	h=From:To:Cc:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D2aNrzb8VhIbNrFFeM4oxanrPfLoIEZF2BLzA2WZ2k3xxHxtw5kCIS/egOeEC/zZ5Iu+9eKTn7LCyK8E/PkprNDBchv8xX8FoOWZR3QvXKs8dehkr1PEJJa4ytXnFqGy6so4wC0F+PC3Olw7t/ht7ku68vshPm6MSt1NGgV3tQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC0ozvcu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC0ozvcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDE81F000FF;
	Thu, 10 Sep 2026 07:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789026657;
	bh=bo4Zc2Vjjp0eoQaA5SCGx0fk3myt9u8dxHPEF5jd53w=;
	h=From:To:Cc:Cc:In-Reply-To:References:Subject:Date;
	b=WC0ozvcumClM2Zk72IpUYM3ax15/lEjWizeh5ueYU8QJVQpFYoF8upF8QiDNXxZdL
	 LPXTNV1dDBIvAiW5qxLP/z0ZbDj6F1hkELjHf6bMI0GSNNsCtHDvhWx2UEYv/q7wvJ
	 B5PDaMntpjp/SxArHyAM5I6sHxlk8oBKkXS7T5obb+rlZR8OM0O1uMj7pcpjWb7jrn
	 uS84sKPWB0nsiHqG7yLViksMDLestWT1IBn/Dus0NJoAsL0DwXnSaq3WeJP18N0xQa
	 pnf3wozyZeD8YJn2xXgv2ArJNSs8Y4wfmhrcHqHXfluyZxANoHfBMFDgMu6nW7jZlV
	 H7/EsrpdaXZEg==
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
In-Reply-To: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
Subject: Re: [PATCH v3 0/3] proc,security,selinux: let SELinux block
 FOLL_FORCE for /proc/self/mem
Message-Id: <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
Date: Thu, 10 Sep 2026 09:48:34 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KP/TVT990Jk6qSqTonW4zGEnqjZVXeEhG7kgWM7rpbU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtSowq4HP7sexZeNLbJRtXzZ06ueXsvVkW0cmHdMWzH
 tk3bfg3o6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiRrsY/nDEvtj2yNPmyULZ
 HUuMevjq9vsWsBZybVM59aCX60vFVz1GhmVnVpful2MS3/Ao9j+3p+fSJUozH4nX6xUqpWtXr34
 Xww4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 07 Sep 2026 23:00:15 +0200, Jann Horn wrote:
> proc,security,selinux: let SELinux block FOLL_FORCE for /proc/self/mem
> 
> The goal of this series is to let SELinux prevent the use of FOLL_FORCE
> when a process writes into /proc/self/mem and the system is configured
> with PROC_MEM_FORCE_ALWAYS (which used to be the default behavior, and
> is still used by current Android devices).
> 
> [...]

Let's move this on a shared branch that both the vfs tree and the lsm
tree pull. That's the standard way of handling dependencies between two
subsystems that want to route code that touches both of them. Branch is
stable.

---

Applied to the vfs-7.4.shared.lsm.foll_force branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.shared.lsm.foll_force branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.shared.lsm.foll_force

[1/3] proc: refactor /proc/$pid/mem to use struct as private_data
      https://git.kernel.org/vfs/vfs/c/d5662602d178
[2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
      https://git.kernel.org/vfs/vfs/c/9f90f96af73d
[3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE introspection
      https://git.kernel.org/vfs/vfs/c/5dac8c291d9b

