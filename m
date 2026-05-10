Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A27318EDC;
	Sun, 10 May 2026 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448255; cv=none; b=VmF5THk7F8wkqQKhZDuw/4RwIt4JGTl5viaq3+uL8CpYjHqbjDB8si+Fh5d1r6nx6DVe/VSiaVep6AUeMrkNGPNBzY3lvKDnyFg3ixhreiyCqsGhMM+SiJxQ0lDDM9HzRxzsS/QHLOzYVQS4EOoT5no3Jruqjk6iTelOLwIz4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448255; c=relaxed/simple;
	bh=CfqG1HDz554gP6Ehyw1aqEQGiKBXaSvv3zzpuKbIOds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gtrd1lIdWOQ7C+rBx/FKdeTbuCqfaSCuw6YJTTMxJQ05J0D9KCdqPACIa+//dHwuDU9fnnjSjX/RDkMx6w42gPK80SgsbE47AEVAwBtrDsgtr90PgCeAXnlM4pegxdSLJsrdZgiKVMBULICjyTsb2huzbuLZpWQXx1v4+B+jGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 4E0D372C8CC;
	Mon, 11 May 2026 00:17:15 +0300 (MSK)
Received: from altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 3722E36D016E;
	Mon, 11 May 2026 00:17:15 +0300 (MSK)
Date: Mon, 11 May 2026 00:17:15 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: [BUG] lsm= with bpf before selinux breaks fscreate with EINVAL
Message-ID: <agDuCdGIeM-6z-j-@altlinux.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hi,

We have boot failure when CONFIG_LSM has "bpf" listed before "selinux"
(without bpf lsm scripts loaded). (This also happens with a boot with
"security=selinux" if selinux was not in LSM= list but bpf is.)

systemd reports on the failing boot attempt:

  Failed to set SELinux security context generic_u:object_r:device:s0 for /dev/shm: Invalid argument
  Mounting tmpfs to /dev/shm of type tmpfs with options mode=01777.
  Mounting tmpfs (tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATIME "mode=01777")...
  Failed to mount tmpfs (type tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATIME "mode=01777"): No such file or directory
  Failed to set SELinux security context generic_u:object_r:device:s0 for /dev/pts: Invalid argument
  Mounting devpts to /dev/pts of type devpts with options mode=0620,gid=5.
  Mounting devpts (devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=0620,gid=5")...
  Failed to mount devpts (type devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=0620,gid=5"): No such file or directory
  No filesystem is currently mounted on /sys/fs/cgroup.
  Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/cgroup: Invalid argument
  Mounting cgroup2 to /sys/fs/cgroup of type cgroup2 with options nsdelegate,memory_recursiveprot.
  Mounting cgroup2 (cgroup2) on /sys/fs/cgroup (MS_NOSUID|MS_NODEV|MS_NOEXEC "nsdelegate,memory_recursiveprot")...
  Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/pstore: Invalid argument
  Mounting pstore to /sys/fs/pstore of type pstore with options n/a.
  Mounting pstore (pstore) on /sys/fs/pstore (MS_NOSUID|MS_NODEV|MS_NOEXEC "")...
  Failed to set SELinux security context generic_u:object_r:def_t:s0 for /sys/fs/bpf: Invalid argument
  Mounting bpf to /sys/fs/bpf of type bpf with options mode=0700.
  Mounting bpf (bpf) on /sys/fs/bpf (MS_NOSUID|MS_NODEV|MS_NOEXEC "mode=0700")...
  [!!!!!!] Failed to mount API filesystems.
  Freezing execution

'Invalid arguments' seems from setfscreatecon_raw.

Reproducer:

  Boot with lsm=lockdown,capability,landlock,yama,safesetid,bpf,selinux,ima,evm

  (none):~# cat /proc/thread-self/attr/current
  cat: /proc/thread-self/attr/current: Invalid argument
  (none):~# echo > /proc/thread-self/attr/fscreate
  bash: echo: write error: Invalid argument

This appears to be caused by security_getprocattr / security_setprocattr
iterating until the first hook defined (which is bpf) and returning with
default value -EINVAL before selinux even sees them.

Perhaps, bpf LSM should avoid registering getprocattr/setprocattr hooks
that it does not implement, or the legacy LSM_ID_UNDEF procattr dispatch
should skip LSMs that cannot handle the requested attribute and continue
to seLinux (or whatever).

Thanks,

