Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D534B1AD;
	Mon, 12 Oct 2026 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815914; cv=none; b=ljxzC5nH8U9z+BflMBFOCipCPmPce1I9+jCxJu+AXJ1z9fhWBOxre5ucxmy3Ed9pYVuS+9wGy/rLhU9hXsxY93frfVj+m9JlZAunnomuPExWXBAFfHctbkJMlHy+RNGUNQQ5rdBOwGIHQUgz7dM7472fXF5hXrSXKZ2dB3zh4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815914; c=relaxed/simple;
	bh=fJT2LAsI+66sPFPMBf1dktBnPkHklTuThSGYqJPWSjE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=sM+BkrmCdOWULKSA3m5kfiRNpvBtK4QCjFpOZLz9JX4J9fb9QRgEXL92R0obFo76NclQSXD/n5xFe+Q1/QpUznPl6iYTB6m28QCg7UJ5o4w0e+e6CursR5GunB6GF/cMBQCbXlklZKrbrQOPUw2I2aGNEDuyb8YdtmisoiYKFTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AlYcDTV/; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AlYcDTV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791815907; bh=LNKxzpmjCEP+a7Nq3MoOesUompTT9/8E11oGyH877mw=;
	h=From:To:Cc:Subject:Date;
	b=AlYcDTV/ZJGc7tH9shlyHISH2a2ej7jSMRs4n0K7oDzrA1FoykBJv7TAkKdA6uHel
	 hsfiW0bAwX1kNzihTAuhUTKwZ0r2Byk4qd4UsvQp63kMPiparYH29nIkcVsiEvFtpK
	 JnpdfSF+iM7JFERnsvleMXHyF2iqHT4xADctI4S0=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 998A66E1; Mon, 12 Oct 2026 22:38:24 +0800
X-QQ-mid: xmsmtpt1791815906tn2pvg8za
Message-ID: <tencent_96F9E846FDA4A67FF38C7C393D985A44690A@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0CMd58NaO3KRHK5Me+Ff/PQx2OUdIRQGbYr0iTDfhHMoVzJesUVW
	 YJDax+US8HQK/uWcO2/knzxf0Ueudc9AnOmYNmjrKq7JEPV7ixSNhulbssAhFG7ov2ibB3KGk8S4
	 BnSkXmKmxWEawPDaZICN4wTqjMZz1HRHpn04btjfWverex5r1DBmfja7yy9tHH9VGoJjO8QHxIY1
	 2jH5I1BNtfj+EGoVYAWNCdpyWpfnkaiIOFh5HX0wcWhA/f+wEfk+Pmj03ByQEyl2biBxeaNQA5Uu
	 XeG11SSsBv7yEGFD28746ZNpTRn3IgwE/g9OU02N6fFl4bNtDRbyKGTpyLOR+Hx/9IvxuSe7KsBN
	 JHIX9WpyI7VSNJqNOlce+vVf16rlkZVd+K+2fPxHeOUFTjwFzYwKIW0SzNeZ8MmPrYXHN7gyE6ka
	 bXjHMrQImGHGgZKGggly0gCXrdjcNtxogIrZoBWwX9YdxpibYuyf6MaQ7N40C3cUWTKRIupHHvOQ
	 F0UvgrCdPeAaRVg5ChUHoGCjFFdqMok0z6BzGyqavKywYYLHutTDItzDN40+pxcAZdK69ZIoWsXi
	 biKTi1xfRNZ5kX6FJpL8/QO2rf6ZEkiVSrx7yO5ygOTqLI2ys/ZtlsgxiL2uf7AckY864TQdYIA2
	 9Yt3v8D/+C0D5pUY17EUZLOE4DdGkCE9bdKxMurkyLRz0YEnFHDlETYQpmJ385GKGx+kxvpupFhD
	 CTAuyXMektDavDUCOy8eroqMM/va+qOf4pVfyMayxCsn9r3MUNGzfyREfIgkXDFQhQYERBnLI3s2
	 UX64Hgq9SS5E2dOnsUXLt4sqWxbBshUQJS8wdIunrOEHAYuA49Te5uCiP4yYWyt6+VqsgpuBKnyw
	 IqaYXbIfdSFWkm5l92uwpwKqo8NwB9k5Hie8yIhzLnZwXv0rV0y8rQV4J/N2pNajqfUQxRkU2q/X
	 jZVnrWQ7TUV6/PBnnwLi3mRByNSv83b0ZJBXL3d0L9Ig35vYRzhk5wk/QPz9RZcWeLc87t/I3Seo
	 YlDdAx3im3j+cqe68peBzOCm3VOVdvoXo5K7wbaPTO09Qn1f/A
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: 1sh1ro <yangguikun19@qq.com>
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnacek@gmail.com>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG REPORT] selinux: general protection fault in avtab_search_node() during an AVC lookup
Date: Mon, 12 Oct 2026 22:38:24 +0800
X-OQ-MSGID: <20261012223824.41804-2-selinux-avtab@yangguikun19.qq.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Paul, Stephen,

fuzzing with syzkaller on a 7.3.0-rc5 KASAN kernel (SELinux enabled,
permissive) produced a general protection fault in avtab_search_node() from
the AVC lookup path.  The policy's avtab appears to contain garbage: the
first fault reads a non-canonical address, and it is followed by thousands
of further Oopses (8850 in this run) as later lookups keep hitting the
broken structure.

The crash
---------

Oops: general protection fault, probably for non-canonical address 0xe06f3dc280000000: 0000 [#1] SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x037a0e1400000000-0x037a0e1400000007]
CPU: 1 UID: 0 PID: 14271 Comm: systemd-udevd Not tainted 7.3.0-rc5 #2 PREEMPT(lazy)
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:avtab_search_node+0x24d/0x4d0
Call Trace:
 <TASK>
 cond_compute_av+0x59/0x340
 context_struct_compute_av+0x7f2/0x11f0
 security_compute_av+0x558/0xd60
 avc_compute_av+0x86/0x820
 avc_perm_nonode+0x9b/0x170
 avc_has_perm+0x27b/0x2f0
 selinux_inode_follow_link+0x226/0x380
 security_inode_follow_link+0x96/0xe0
 pick_link+0x447/0x1570
 step_into_slowpath+0x928/0xdd0
 link_path_walk+0xdae/0x1b20
 path_lookupat+0x70/0xb80
 filename_lookup+0x213/0x5e0
 filename_setxattr+0x89/0x1b0
 path_setxattrat+0x1cc/0x2a0
 __x64_sys_setxattr+0xc6/0x140
 do_syscall_64+0xec/0x4e0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Context
-------

- The task is systemd-udevd (uid 0) in setxattr() (ORIG_RAX 0xbc), which
  follows a symlink while walking the path; the first AVC decision for the
  symlink hits the corrupt avtab.
- The same crash appeared on three runs of this fuzzing instance:
  2026-10-08 23:39 UTC, 2026-10-12 04:50 UTC and 2026-10-12 10:48 UTC.
- The kernel log of the crashing run shows only avc denials
  (permissive=1) and no policy (re)load, so the avtab was already corrupt
  when this lookup happened.  From this run alone I cannot tell whether the
  corruption originates in SELinux or comes from an unrelated memory
  corruption bug in the same fuzzing session (that instance also produced
  unrelated memory-safety crashes around the same time).
- No reproducer: the instance ran with syzkaller's reproduce disabled.  I
  can rerun it with reproduce enabled if you would like one.

7.3-rc5 already contains the recent policy-load validation fixes (class and
permission counts, level category sets, boolean values), so this looks like
a separate instance of the avtab-corruption family rather than one of those.

Thanks,
1sh1ro

