Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA837A4AF;
	Mon, 11 May 2026 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536470; cv=none; b=i6LdXMvtg4cU4huAUfO7lbGR4tIqsDjXy1B+H8C3qf1fV2Tm31N16B7FkXZ+Y0Z/V3IHUeZr2gwSlwdLM8uh1NZowyuxLWvEkmtd8ropCP8JOb0ZUy/PF2PFC+gEUEvFK+9P6YYtwYZdNxZbTbM9rqSt231UlcfCL2Ut8YVFcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536470; c=relaxed/simple;
	bh=3AhKlNDDQ/HwUN5zPeQkcVNvZsfqn1q30zDMhfXnI2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS7tX/nXw2Xhgty0LRgAGbZfE7qq00qwHWGQ0evI3fcOvCEx5lVBOl16WuS6mmWYRpTgXRTpbu7O6nlR5JhWm/YAaeuuBCvKGEf7M3YkHZvyOoxuwzJipCUeES1CIUvIj+JzDxwu44P8k+gYb2CdmuYap+EsiDcdPiI85w0d54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id AF6A972C8CC;
	Tue, 12 May 2026 00:54:21 +0300 (MSK)
Received: from altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 988CE36D016E;
	Tue, 12 May 2026 00:54:21 +0300 (MSK)
Date: Tue, 12 May 2026 00:54:21 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] lsm= with bpf before selinux breaks fscreate with EINVAL
Message-ID: <agJPqiSKvHrrg6Qn@altlinux.org>
References: <agDuCdGIeM-6z-j-@altlinux.org>
 <CAHC9VhQ4VyAvG-z2h2NFpPx9PcJP4Ot2Ap=MPbCRk2TosJWOTA@mail.gmail.com>
 <agI9Rdi-72f8dNbB@altlinux.org>
 <CAHC9VhRWNEzYx3Xxtxv_0BBkM7skisVdnKXx3CGn3S=aoBCiyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRWNEzYx3Xxtxv_0BBkM7skisVdnKXx3CGn3S=aoBCiyQ@mail.gmail.com>

Paul,

On Mon, May 11, 2026 at 05:49:39PM -0400, Paul Moore wrote:
> On Mon, May 11, 2026 at 5:03 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> > On Mon, May 11, 2026 at 04:19:34PM -0400, Paul Moore wrote:
> > > On Sun, May 10, 2026 at 5:17 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > We have boot failure when CONFIG_LSM has "bpf" listed before "selinux"
> > > > (without bpf lsm scripts loaded). (This also happens with a boot with
> > > > "security=selinux" if selinux was not in LSM= list but bpf is.)
> > > >
> > > > systemd reports on the failing boot attempt:
> > > >
> > > >   Failed to set SELinux security context generic_u:object_r:device:s0 for /dev/shm: Invalid argument
> > > >   Mounting tmpfs to /dev/shm of type tmpfs with options mode=01777.
> > > >   Mounting tmpfs (tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATIME "mode=01777")...
> > > >   Failed to mount tmpfs (type tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATIME "mode=01777"): No such file or directory
> > > >   Failed to set SELinux security context generic_u:object_r:device:s0 for /dev/pts: Invalid argument
> > > >   Mounting devpts to /dev/pts of type devpts with options mode=0620,gid=5.
> > > >   Mounting devpts (devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=0620,gid=5")...
> > > >   Failed to mount devpts (type devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=0620,gid=5"): No such file or directory
> > > >   No filesystem is currently mounted on /sys/fs/cgroup.
> > > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/cgroup: Invalid argument
> > > >   Mounting cgroup2 to /sys/fs/cgroup of type cgroup2 with options nsdelegate,memory_recursiveprot.
> > > >   Mounting cgroup2 (cgroup2) on /sys/fs/cgroup (MS_NOSUID|MS_NODEV|MS_NOEXEC "nsdelegate,memory_recursiveprot")...
> > > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/pstore: Invalid argument
> > > >   Mounting pstore to /sys/fs/pstore of type pstore with options n/a.
> > > >   Mounting pstore (pstore) on /sys/fs/pstore (MS_NOSUID|MS_NODEV|MS_NOEXEC "")...
> > > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/bpf: Invalid argument
> > > >   Mounting bpf to /sys/fs/bpf of type bpf with options mode=0700.
> > > >   Mounting bpf (bpf) on /sys/fs/bpf (MS_NOSUID|MS_NODEV|MS_NOEXEC "mode=0700")...
> > > >   [!!!!!!] Failed to mount API filesystems.
> > > >   Freezing execution
> > > >
> > > > 'Invalid arguments' seems from setfscreatecon_raw.
> > > >
> > > > Reproducer:
> > > >
> > > >   Boot with lsm=lockdown,capability,landlock,yama,safesetid,bpf,selinux,ima,evm
> > > >
> > > >   (none):~# cat /proc/thread-self/attr/current
> > > >   cat: /proc/thread-self/attr/current: Invalid argument
> > > >   (none):~# echo > /proc/thread-self/attr/fscreate
> > > >   bash: echo: write error: Invalid argument
> > > >
> > > > This appears to be caused by security_getprocattr / security_setprocattr
> > > > iterating until the first hook defined (which is bpf) and returning with
> > > > default value -EINVAL before selinux even sees them.
> > >
> > > Thanks for the problem report, the general recommendation is to place
> > > the BPF LSM towards the end of the list (see the CONFIG_LSM Kconfig
> > > help text), but we're trying to ensure that the BPF LSM works properly
> > > when placed anywhere in that list.
> >
> > I think if the order is important it should be handled in the code like
> > for capabilities and ima/evm LSMs, not by forcing the user to discover
> > the correct order with trial and error.
> 
> Patches are always welcome, although as I mentioned to you previously
> we are working towards supporting arbitrary ordering for BPF LSMs.
> 
> > > My apologies if you're abilities are well beyond this, but if you are
> > > familiar with patching and building your own kernel, have you tried
> > > changing the LSM_RET_DEFAULT value for those functions to zero/0?
> > > Assuming userspace is happy with that, I believe it may solve this
> > > problem.
> >
> > I can patch and test if this is useful to find the correct solution, but
> > the description is a bit vague. Did you mean
> >
> >   include/linux/lsm_hook_defs.h:301:LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
> >   include/linux/lsm_hook_defs.h:303:LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
> >
> > In these lines to replace -EINVAL with 0?
> 
> The patch below is what I had in mind (although be warned that was
> just a cut-n-paste into this email so it is likely whitespace
> damaged).  If you are able to give that a test it would be great, if
> not, I can throw it on the todo pile.
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 2b8dfb35caed..12724e259900 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -298,9 +298,9 @@ LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
>         struct lsm_ctx __user *ctx, u32 *size, u32 flags)
> LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
>         struct lsm_ctx *ctx, u32 size, u32 flags)
> -LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
> +LSM_HOOK(int, 0, getprocattr, struct task_struct *p, const char *name,
>         char **value)
> -LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
> +LSM_HOOK(int, 0, setprocattr, const char *name, void *value, size_t size)
> LSM_HOOK(int, 0, ismaclabel, const char *name)
> LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, struct lsm_context *cp)
> LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,

We will test it and report, but this may take some time.

Thanks,

> 
> -- 
> paul-moore.com
