Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8E344CAF5;
	Mon, 11 May 2026 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533423; cv=none; b=lsOUdsmSmbLSkEmmhlsh7RkiMzMhhdtOGW+F5GFjbaDzlf+bQtii42Lcs9n0Ilw6g3MmDoJhY30f8nIIYIHCulqLkiOPxADVd1i0vGmeZEODiQOlW0Hj61qK8jKzquhkOc7hUKrWMKvj2XZ9RAOn5O9kuPlJtVx8JDGIj7uOSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533423; c=relaxed/simple;
	bh=zJR7QUF62fOMwGKwP0yZMjVddXtveyN2DucV9GaUjVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH7udsFJM0LQtNshnlkh6QC6ptrOECjZkjVJvJto8KSJK/ahlMUneJCDsMvsonOlDTFQSHVcyHTJtkfvJN7CtfcPXh6cREikHN3pKgHNPH4xrd35lCn4rlPWB/euiTgRmnzjFgaRUnGZzxerh0fa7iBEmwyJaEF09ZCgq2tT2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id A1F1272C8CC;
	Tue, 12 May 2026 00:03:38 +0300 (MSK)
Received: from altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 8B92836D016E;
	Tue, 12 May 2026 00:03:38 +0300 (MSK)
Date: Tue, 12 May 2026 00:03:38 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] lsm= with bpf before selinux breaks fscreate with EINVAL
Message-ID: <agI9Rdi-72f8dNbB@altlinux.org>
References: <agDuCdGIeM-6z-j-@altlinux.org>
 <CAHC9VhQ4VyAvG-z2h2NFpPx9PcJP4Ot2Ap=MPbCRk2TosJWOTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ4VyAvG-z2h2NFpPx9PcJP4Ot2Ap=MPbCRk2TosJWOTA@mail.gmail.com>

Paul,

On Mon, May 11, 2026 at 04:19:34PM -0400, Paul Moore wrote:
> On Sun, May 10, 2026 at 5:17 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> >
> > Hi,
> >
> > We have boot failure when CONFIG_LSM has "bpf" listed before "selinux"
> > (without bpf lsm scripts loaded). (This also happens with a boot with
> > "security=selinux" if selinux was not in LSM= list but bpf is.)
> >
> > systemd reports on the failing boot attempt:
> >
> >   Failed to set SELinux security context generic_u:object_r:device:s0 for /dev/shm: Invalid argument
> >   Mounting tmpfs to /dev/shm of type tmpfs with options mode=01777.
> >   Mounting tmpfs (tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATIME "mode=01777")...
> >   Failed to mount tmpfs (type tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATIME "mode=01777"): No such file or directory
> >   Failed to set SELinux security context generic_u:object_r:device:s0 for /dev/pts: Invalid argument
> >   Mounting devpts to /dev/pts of type devpts with options mode=0620,gid=5.
> >   Mounting devpts (devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=0620,gid=5")...
> >   Failed to mount devpts (type devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=0620,gid=5"): No such file or directory
> >   No filesystem is currently mounted on /sys/fs/cgroup.
> >   Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/cgroup: Invalid argument
> >   Mounting cgroup2 to /sys/fs/cgroup of type cgroup2 with options nsdelegate,memory_recursiveprot.
> >   Mounting cgroup2 (cgroup2) on /sys/fs/cgroup (MS_NOSUID|MS_NODEV|MS_NOEXEC "nsdelegate,memory_recursiveprot")...
> >   Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/pstore: Invalid argument
> >   Mounting pstore to /sys/fs/pstore of type pstore with options n/a.
> >   Mounting pstore (pstore) on /sys/fs/pstore (MS_NOSUID|MS_NODEV|MS_NOEXEC "")...
> >   Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/bpf: Invalid argument
> >   Mounting bpf to /sys/fs/bpf of type bpf with options mode=0700.
> >   Mounting bpf (bpf) on /sys/fs/bpf (MS_NOSUID|MS_NODEV|MS_NOEXEC "mode=0700")...
> >   [!!!!!!] Failed to mount API filesystems.
> >   Freezing execution
> >
> > 'Invalid arguments' seems from setfscreatecon_raw.
> >
> > Reproducer:
> >
> >   Boot with lsm=lockdown,capability,landlock,yama,safesetid,bpf,selinux,ima,evm
> >
> >   (none):~# cat /proc/thread-self/attr/current
> >   cat: /proc/thread-self/attr/current: Invalid argument
> >   (none):~# echo > /proc/thread-self/attr/fscreate
> >   bash: echo: write error: Invalid argument
> >
> > This appears to be caused by security_getprocattr / security_setprocattr
> > iterating until the first hook defined (which is bpf) and returning with
> > default value -EINVAL before selinux even sees them.
> 
> Thanks for the problem report, the general recommendation is to place
> the BPF LSM towards the end of the list (see the CONFIG_LSM Kconfig
> help text), but we're trying to ensure that the BPF LSM works properly
> when placed anywhere in that list.

I think if the order is important it should be handled in the code like
for capabilities and ima/evm LSMs, not by forcing the user to discover
the correct order with trial and error.

> 
> My apologies if you're abilities are well beyond this, but if you are
> familiar with patching and building your own kernel, have you tried
> changing the LSM_RET_DEFAULT value for those functions to zero/0?
> Assuming userspace is happy with that, I believe it may solve this
> problem.

I can patch and test if this is useful to find the correct solution, but
the description is a bit vague. Did you mean

  include/linux/lsm_hook_defs.h:301:LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
  include/linux/lsm_hook_defs.h:303:LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)

In these lines to replace -EINVAL with 0?

I would never try this on my own, because it looks like -EINVAL is a
meaningful value, and I would never claim to understand all the
intricacies of LSMs.

  3892 int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
  3893 {
  3894         struct lsm_static_call *scall;
  3895
  3896         lsm_for_each_hook(scall, setprocattr) {
  3897                 if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
  3898                         continue;
  3899                 return scall->hl->hook.setprocattr(name, value, size);
  3900         }
  3901         return LSM_RET_DEFAULT(setprocattr);
  3902 }

If my first hypothesis is correct, and the lsm_for_each_hook goes into
bpf before selinux, setting the default to 0 will make selinux hook
unreachable.

With all this, I conclude that I perhaps misunderstood your request.

Thanks,

> 
> -- 
> paul-moore.com
