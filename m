Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0635675E;
	Mon, 11 May 2026 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539412; cv=none; b=XH+C5Y5YCbQGJQ5kw0mRN/WuwYm2/qlQcjXAzyRVdXob6C1l0BplOsd7ix5+sg8VYKDPcQF/Y9A4f4X4BjV6Qm+JH/aIZVmby3Vou7mg2fTELJma4KM9Zn747mjsHjBJ8NB3mnC6iipdIJRUI3KvoaW2CeAEqCPvVO65pR2lr5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539412; c=relaxed/simple;
	bh=vdQIJIYlf56t9ak7ABaKlG7aKUUD3JExwr5e4ZpbG3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6aa0/n2bvSISyP/5ruWoM/0yMd64ep57pYkRwAy641HR368EjLHa/xR98a9nRBRAdq7j+L7TTbO8DlGLHeAWq1rBhs21gw3nVd7bgDHYh0D40SmVZn38n4p+YSLyT8ne28KnFIs+IJoJrSHr2dWdOGhG7H5yjK6J0zPf3XPFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 8AA0F72C8CC;
	Tue, 12 May 2026 01:43:28 +0300 (MSK)
Received: from altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 755B636D016E;
	Tue, 12 May 2026 01:43:28 +0300 (MSK)
Date: Tue, 12 May 2026 01:43:28 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] lsm= with bpf before selinux breaks fscreate with EINVAL
Message-ID: <agJajS11YK1XGB-y@altlinux.org>
References: <agDuCdGIeM-6z-j-@altlinux.org>
 <CAHC9VhQ4VyAvG-z2h2NFpPx9PcJP4Ot2Ap=MPbCRk2TosJWOTA@mail.gmail.com>
 <agI9Rdi-72f8dNbB@altlinux.org>
 <CAHC9VhRWNEzYx3Xxtxv_0BBkM7skisVdnKXx3CGn3S=aoBCiyQ@mail.gmail.com>
 <agJPqiSKvHrrg6Qn@altlinux.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agJPqiSKvHrrg6Qn@altlinux.org>

Paul,

On Tue, May 12, 2026 at 12:54:21AM +0300, Vitaly Chikunov wrote:
> On Mon, May 11, 2026 at 05:49:39PM -0400, Paul Moore wrote:
> > On Mon, May 11, 2026 at 5:03 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> > > On Mon, May 11, 2026 at 04:19:34PM -0400, Paul Moore wrote:
> > > > On Sun, May 10, 2026 at 5:17 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > We have boot failure when CONFIG_LSM has "bpf" listed before "selinux"
> > > > > (without bpf lsm scripts loaded). (This also happens with a boot with
> > > > > "security=selinux" if selinux was not in LSM= list but bpf is.)
> > > > >
> > > > > systemd reports on the failing boot attempt:
> > > > >
> > > > >   Failed to set SELinux security context generic_u:object_r:device:s0 for /dev/shm: Invalid argument
> > > > >   Mounting tmpfs to /dev/shm of type tmpfs with options mode=01777.
> > > > >   Mounting tmpfs (tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATIME "mode=01777")...
> > > > >   Failed to mount tmpfs (type tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATIME "mode=01777"): No such file or directory
> > > > >   Failed to set SELinux security context generic_u:object_r:device:s0 for /dev/pts: Invalid argument
> > > > >   Mounting devpts to /dev/pts of type devpts with options mode=0620,gid=5.
> > > > >   Mounting devpts (devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=0620,gid=5")...
> > > > >   Failed to mount devpts (type devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=0620,gid=5"): No such file or directory
> > > > >   No filesystem is currently mounted on /sys/fs/cgroup.
> > > > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/cgroup: Invalid argument
> > > > >   Mounting cgroup2 to /sys/fs/cgroup of type cgroup2 with options nsdelegate,memory_recursiveprot.
> > > > >   Mounting cgroup2 (cgroup2) on /sys/fs/cgroup (MS_NOSUID|MS_NODEV|MS_NOEXEC "nsdelegate,memory_recursiveprot")...
> > > > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/pstore: Invalid argument
> > > > >   Mounting pstore to /sys/fs/pstore of type pstore with options n/a.
> > > > >   Mounting pstore (pstore) on /sys/fs/pstore (MS_NOSUID|MS_NODEV|MS_NOEXEC "")...
> > > > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/bpf: Invalid argument
> > > > >   Mounting bpf to /sys/fs/bpf of type bpf with options mode=0700.
> > > > >   Mounting bpf (bpf) on /sys/fs/bpf (MS_NOSUID|MS_NODEV|MS_NOEXEC "mode=0700")...
> > > > >   [!!!!!!] Failed to mount API filesystems.
> > > > >   Freezing execution
> > > > >
> > > > > 'Invalid arguments' seems from setfscreatecon_raw.
> > > > >
> > > > > Reproducer:
> > > > >
> > > > >   Boot with lsm=lockdown,capability,landlock,yama,safesetid,bpf,selinux,ima,evm
> > > > >
> > > > >   (none):~# cat /proc/thread-self/attr/current
> > > > >   cat: /proc/thread-self/attr/current: Invalid argument
> > > > >   (none):~# echo > /proc/thread-self/attr/fscreate
> > > > >   bash: echo: write error: Invalid argument
> > > > >
> > > > > This appears to be caused by security_getprocattr / security_setprocattr
> > > > > iterating until the first hook defined (which is bpf) and returning with
> > > > > default value -EINVAL before selinux even sees them.
> > > >
> > > > Thanks for the problem report, the general recommendation is to place
> > > > the BPF LSM towards the end of the list (see the CONFIG_LSM Kconfig
> > > > help text), but we're trying to ensure that the BPF LSM works properly
> > > > when placed anywhere in that list.
> > >
> > > I think if the order is important it should be handled in the code like
> > > for capabilities and ima/evm LSMs, not by forcing the user to discover
> > > the correct order with trial and error.
> > 
> > Patches are always welcome, although as I mentioned to you previously
> > we are working towards supporting arbitrary ordering for BPF LSMs.
> > 
> > > > My apologies if you're abilities are well beyond this, but if you are
> > > > familiar with patching and building your own kernel, have you tried
> > > > changing the LSM_RET_DEFAULT value for those functions to zero/0?
> > > > Assuming userspace is happy with that, I believe it may solve this
> > > > problem.
> > >
> > > I can patch and test if this is useful to find the correct solution, but
> > > the description is a bit vague. Did you mean
> > >
> > >   include/linux/lsm_hook_defs.h:301:LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
> > >   include/linux/lsm_hook_defs.h:303:LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
> > >
> > > In these lines to replace -EINVAL with 0?
> > 
> > The patch below is what I had in mind (although be warned that was
> > just a cut-n-paste into this email so it is likely whitespace
> > damaged).  If you are able to give that a test it would be great, if
> > not, I can throw it on the todo pile.
> > 
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 2b8dfb35caed..12724e259900 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -298,9 +298,9 @@ LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
> >         struct lsm_ctx __user *ctx, u32 *size, u32 flags)
> > LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
> >         struct lsm_ctx *ctx, u32 size, u32 flags)
> > -LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
> > +LSM_HOOK(int, 0, getprocattr, struct task_struct *p, const char *name,
> >         char **value)
> > -LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
> > +LSM_HOOK(int, 0, setprocattr, const char *name, void *value, size_t size)
> > LSM_HOOK(int, 0, ismaclabel, const char *name)
> > LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, struct lsm_context *cp)
> > LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,
> 
> We will test it and report, but this may take some time.

Before trying the full system boot test, I tried to reproducer I posted
before. With this patch applied (just ensure it's correct) over v6.12.87:

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9eca013aa5e1..b38f6194699b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -288,9 +288,9 @@ LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
          struct lsm_ctx __user *ctx, u32 *size, u32 flags)
 LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
          struct lsm_ctx *ctx, u32 size, u32 flags)
-LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
+LSM_HOOK(int, 0, getprocattr, struct task_struct *p, const char *name,
          char **value)
-LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
+LSM_HOOK(int, 0, setprocattr, const char *name, void *value, size_t size)
 LSM_HOOK(int, 0, ismaclabel, const char *name)
 LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
          u32 *seclen)

1. `cat /proc/thread-self/attr/current` does not report `kernel` as before.
2. `echo > /proc/thread-self/attr/fscreate` process hangs in R state, with strace
showing infinite loop of
  write(1, "\n", 1)                       = 0
  write(1, "\n", 1)                       = 0
  write(1, "\n", 1)                       = 0

Thanks,

> 
> Thanks,
> 
> > 
> > -- 
> > paul-moore.com
