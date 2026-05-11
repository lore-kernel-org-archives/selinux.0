Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5E43DA5D
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536196; cv=pass; b=bwoZVLJyiG7rSYCnxzK6m+OzVHGV5qEDjv6fK3JrscXuELgfemjLgPezihY+nLcAUZPKscKG0utqatgjEoT2gwBnMX4h2ROJVWFfkYSZq7WOpfXn28f7YunvCBEh0n0QQgdW594G/13es28Tu+FshBww2hBd+cO2KkBtDXIR/kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536196; c=relaxed/simple;
	bh=XdHPTUaon4qMKhfV+GkVLIq6iUv15qkFI3hbCXwnh+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvPtP39KIGVPFgrXqMgSHVgDF73yRQ3C8hb6s6Ce86uLMI0uKu/u3naSyCS23MXGlx9LEmYV1glPQhmmzljsHOxs0EKR7kGCbCX87vhX6IdjV1oGeypdDc1ajJduWtLcb+9Vwb7Ks0cYchoxxXehuqiwsBXwg44dI+p0ssH7BdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d+piT+16; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d+piT+16"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aaed195901so23496055ad.0
        for <selinux@vger.kernel.org>; Mon, 11 May 2026 14:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778536193; cv=none;
        d=google.com; s=arc-20240605;
        b=bXoUw5t5Cit5/vVGr2jE323laEy9c9yvq2BHPAKX4tBWJ/1dUvn43kd9sLaK+cNZbd
         0HuZNNhK7/BAgJgzP7pw0SIXVv0PVIR274CNRZpGdfYyRWv7fZmyNbyfovfdkKlvlXuA
         jtH70ZByvgeJTv+DuRnHAqexE8NvKk8vmsu93d+QcaRNsamBUv+wjDeqhWzw1bZGUliJ
         cLyROxDrl5h6whLZcXBzwQI0eTkHJ6KL1iqaIaXJer8o/unUB5BM1mhihZBXxgyyBH0X
         p6AasGR2FOWiHmtBaZOkWdxvH3JDqnuQ2SVkek8sZSHvsj8VWvC5tN49o039lK7C7ITA
         Udpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OUo4L4WIPQHPOig8wBsHK8psuw6OsB6Z+20wUPEg6uQ=;
        fh=QHFLCnmk+lvZufLynxwJ+/UqCx0TRqb3ImSB+wU+ZuA=;
        b=Y0q22KBFgedfaO2d5qVhZcAjOxKIwc90eAJeCqWbIrMJSjBxh5YgL+jnU7meBsc3Am
         Lj/K6IsUvZLRs07yrnPH+4uQtxcwUg6RWXwUsCv4LKAaf35OC09yqgIEspwhjJWIl9oy
         uaQJ/r/V/3KvDcV6ZK2UDnorm2StGgzNPZxPe/8eikjndxo+5EI+W+bpjQd0Io+BCZKR
         AkkYhHCO2LeW6rE0+jrjlrT7xtlggfPa+OxerRDIbBWIVD6t1Xc/eBtr1NAFyp6AXMz+
         9D0Ob+iX10ovVQrMoCnsZLe8agw4YVm0DELOhpJgFXw8XPpI9AkEquyOt507nK9mNF4i
         cl/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778536193; x=1779140993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUo4L4WIPQHPOig8wBsHK8psuw6OsB6Z+20wUPEg6uQ=;
        b=d+piT+166KTh11CzzCnG4+5N0K1/YavckPMcdG0/S8KtpHSbON7V6L4eoGSh4qD+PX
         YoNUUB9z2E0pGUkerB28PTeKlQ6meewUicg/zD3ki9YbReVMhqvVOCFhnFy+8xx7wSMI
         sLDJ62VH9XJe1d+X77hq8gWJdzKxgGA9rImJekiRzc7PanVPEYRJ3nLjEqcMlLnr8w/8
         My9JxF/5OWQIhxXO12yXmeEq780AL7wts3SezHWhuY1IkuWJ+QtqgpbYw2Txlip+5z6x
         dws6Hoiql7JeYTmtAX50YOD43V/ZjanRCH3lozV4HfDk+bEi+tFJrcd/xbaGxq3IVJT+
         uYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778536193; x=1779140993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUo4L4WIPQHPOig8wBsHK8psuw6OsB6Z+20wUPEg6uQ=;
        b=By2CXxRcTtPGDj+KL11tkU4FLtk1x4ZrWBdOu10qzGY6d8qNChK+818qGkczqamDti
         4x9LS5uoWR3TaGnbrk7jAAEaCmGZptxZc+8q9I8niwf3AhYMWLl10OS6EFh1dadjDPmV
         0ijHPGnWqwvrS9R4x4MHve8EfUiAfAiSPbRU6y4hwMk//zoEvWJcL+ZIhJ9qC++NZo4W
         iWi1k4KIl5zVXKuI+UGAdUDjER3XiAmtEPDU9XiJ6C/5pHBYPuiF7yPlfBobKlvlgu55
         5iOzRg+R9ASzQQHvtnS2B7z0vMvObBrr0StaAJRFw17oTF8jBLsFMAdwqkySR4UiuukP
         De5w==
X-Forwarded-Encrypted: i=1; AFNElJ+Jg1eKVDns/WFCbQQYHt3voj+g3zdwovG8EgPzqpfzSK4vPIQtyFj/kZuiOrIQ/XAPa2JhxguC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fgLHBceDsi0tLzZ71yvxxQNz10HYdzxuqGzzFyahDMKBX1Mi
	sTLsiwZI15XKqNbOm97ZjGF98oLC6IbhhONH1YiykTznwxJEAszJoA2s7naE+0dxHAMckly9LHV
	VDZ1AJ9F70D2ER5n30aonJ2r61wD+YJRjHFflY4lX
X-Gm-Gg: Acq92OF3Txg0esUW4ivjw438imFGl+pEzluVibXXVZ8gQrlRGUroSES1oiWCyy4gerx
	Fdghqqz1SjTM6S3jCcva0jrVRTeTfjYaMC4IYIivAOEo/sT8oTIdY+oSmi5eU/Ah9dmK7t24vLN
	55BZxV9vn20TwXYpm2RMGU/cnB0Uafj00jlr+iVPIwxAK5QP5baW7WrJhAEI6Gfal0DO7QvNiPd
	noFKizVKCTGxxPkneTki9sRM61xfS+UtbNboF0q1yht+4kIF8lkCAzG1p/1YeAbuH3JYz5GIWLD
	0NUWBgEhK6cSgNdcYQ==
X-Received: by 2002:a17:902:7c82:b0:2b9:fb9a:1103 with SMTP id
 d9443c01a7336-2bc7ac8b06amr80747045ad.38.1778536193220; Mon, 11 May 2026
 14:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agDuCdGIeM-6z-j-@altlinux.org> <CAHC9VhQ4VyAvG-z2h2NFpPx9PcJP4Ot2Ap=MPbCRk2TosJWOTA@mail.gmail.com>
 <agI9Rdi-72f8dNbB@altlinux.org>
In-Reply-To: <agI9Rdi-72f8dNbB@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 May 2026 17:49:39 -0400
X-Gm-Features: AVHnY4Ja7h2T0iiBovZjmBZ_dd3oYXhTgK2-VnHqO-CqDAWECmhpgQlAIJ5QMl0
Message-ID: <CAHC9VhRWNEzYx3Xxtxv_0BBkM7skisVdnKXx3CGn3S=aoBCiyQ@mail.gmail.com>
Subject: Re: [BUG] lsm= with bpf before selinux breaks fscreate with EINVAL
To: Vitaly Chikunov <vt@altlinux.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 5:03=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
> On Mon, May 11, 2026 at 04:19:34PM -0400, Paul Moore wrote:
> > On Sun, May 10, 2026 at 5:17=E2=80=AFPM Vitaly Chikunov <vt@altlinux.or=
g> wrote:
> > >
> > > Hi,
> > >
> > > We have boot failure when CONFIG_LSM has "bpf" listed before "selinux=
"
> > > (without bpf lsm scripts loaded). (This also happens with a boot with
> > > "security=3Dselinux" if selinux was not in LSM=3D list but bpf is.)
> > >
> > > systemd reports on the failing boot attempt:
> > >
> > >   Failed to set SELinux security context generic_u:object_r:device:s0=
 for /dev/shm: Invalid argument
> > >   Mounting tmpfs to /dev/shm of type tmpfs with options mode=3D01777.
> > >   Mounting tmpfs (tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATI=
ME "mode=3D01777")...
> > >   Failed to mount tmpfs (type tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|=
MS_STRICTATIME "mode=3D01777"): No such file or directory
> > >   Failed to set SELinux security context generic_u:object_r:device:s0=
 for /dev/pts: Invalid argument
> > >   Mounting devpts to /dev/pts of type devpts with options mode=3D0620=
,gid=3D5.
> > >   Mounting devpts (devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=3D0=
620,gid=3D5")...
> > >   Failed to mount devpts (type devpts) on /dev/pts (MS_NOSUID|MS_NOEX=
EC "mode=3D0620,gid=3D5"): No such file or directory
> > >   No filesystem is currently mounted on /sys/fs/cgroup.
> > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 =
for /sys/fs/cgroup: Invalid argument
> > >   Mounting cgroup2 to /sys/fs/cgroup of type cgroup2 with options nsd=
elegate,memory_recursiveprot.
> > >   Mounting cgroup2 (cgroup2) on /sys/fs/cgroup (MS_NOSUID|MS_NODEV|MS=
_NOEXEC "nsdelegate,memory_recursiveprot")...
> > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 =
for /sys/fs/pstore: Invalid argument
> > >   Mounting pstore to /sys/fs/pstore of type pstore with options n/a.
> > >   Mounting pstore (pstore) on /sys/fs/pstore (MS_NOSUID|MS_NODEV|MS_N=
OEXEC "")...
> > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 =
for /sys/fs/bpf: Invalid argument
> > >   Mounting bpf to /sys/fs/bpf of type bpf with options mode=3D0700.
> > >   Mounting bpf (bpf) on /sys/fs/bpf (MS_NOSUID|MS_NODEV|MS_NOEXEC "mo=
de=3D0700")...
> > >   [!!!!!!] Failed to mount API filesystems.
> > >   Freezing execution
> > >
> > > 'Invalid arguments' seems from setfscreatecon_raw.
> > >
> > > Reproducer:
> > >
> > >   Boot with lsm=3Dlockdown,capability,landlock,yama,safesetid,bpf,sel=
inux,ima,evm
> > >
> > >   (none):~# cat /proc/thread-self/attr/current
> > >   cat: /proc/thread-self/attr/current: Invalid argument
> > >   (none):~# echo > /proc/thread-self/attr/fscreate
> > >   bash: echo: write error: Invalid argument
> > >
> > > This appears to be caused by security_getprocattr / security_setproca=
ttr
> > > iterating until the first hook defined (which is bpf) and returning w=
ith
> > > default value -EINVAL before selinux even sees them.
> >
> > Thanks for the problem report, the general recommendation is to place
> > the BPF LSM towards the end of the list (see the CONFIG_LSM Kconfig
> > help text), but we're trying to ensure that the BPF LSM works properly
> > when placed anywhere in that list.
>
> I think if the order is important it should be handled in the code like
> for capabilities and ima/evm LSMs, not by forcing the user to discover
> the correct order with trial and error.

Patches are always welcome, although as I mentioned to you previously
we are working towards supporting arbitrary ordering for BPF LSMs.

> > My apologies if you're abilities are well beyond this, but if you are
> > familiar with patching and building your own kernel, have you tried
> > changing the LSM_RET_DEFAULT value for those functions to zero/0?
> > Assuming userspace is happy with that, I believe it may solve this
> > problem.
>
> I can patch and test if this is useful to find the correct solution, but
> the description is a bit vague. Did you mean
>
>   include/linux/lsm_hook_defs.h:301:LSM_HOOK(int, -EINVAL, getprocattr, s=
truct task_struct *p, const char *name,
>   include/linux/lsm_hook_defs.h:303:LSM_HOOK(int, -EINVAL, setprocattr, c=
onst char *name, void *value, size_t size)
>
> In these lines to replace -EINVAL with 0?

The patch below is what I had in mind (although be warned that was
just a cut-n-paste into this email so it is likely whitespace
damaged).  If you are able to give that a test it would be great, if
not, I can throw it on the todo pile.

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2b8dfb35caed..12724e259900 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -298,9 +298,9 @@ LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int at=
tr,
        struct lsm_ctx __user *ctx, u32 *size, u32 flags)
LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
        struct lsm_ctx *ctx, u32 size, u32 flags)
-LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *nam=
e,
+LSM_HOOK(int, 0, getprocattr, struct task_struct *p, const char *name,
        char **value)
-LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t =
size)
+LSM_HOOK(int, 0, setprocattr, const char *name, void *value, size_t size)
LSM_HOOK(int, 0, ismaclabel, const char *name)
LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, struct lsm_context *=
cp)
LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,

--=20
paul-moore.com
