Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477BB2594BD;
	Thu, 13 Aug 2026 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584319; cv=none; b=GzQObVJdOv/SudMOOCS4UzFXGTuKjbcOJptXz8F5FJHw7k37NOxcB1/i5mQto8OL3Llz5dqmGM8dea5KrzSY6QG9xTJ0OYh08ghzX/q4M/UGmxAqW5ww3w4PYq3AsS1irEvxXkFaxOuUbAaZ+bJeBUSGDry8f3MrXR4jzoE1f3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584319; c=relaxed/simple;
	bh=ffjzIM4VOUuxg2z0BX8xbj/e/suPdRb4/b32lXRqYXE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hZLHScQViu5Gi+/yez2PAb2FKaDBUid4fCCm1c3xw4vRpkg/6YZ2baw2CL5cLJmkB8DK1+QHDlTy9btBrDHT/SYwFki90azdjfT9qgUc46UGsj45nPpIqbSmKQBH9PT9kzppIU1OyR/FKxzB33NwFmcyb3OIvcOnfBqfKDc6qew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAFKszN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAFKszN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFCA1F000E9;
	Thu, 13 Aug 2026 01:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786584318;
	bh=bH58GWkEgLcNVmwDwoe+hqYS/apmOia5ySQkkhB4t/A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gAFKszN5a11yeBavCmrodH0rYwhUTrObyxUVUOsx3VdOeSzoHW3DL1SZrlwsUzFCc
	 z2smcYe/S8kPYnvTgvVAqmXyrhFPwRG4OFcGbC6S4SSpQIs5gP0HOAxXhJRbSLsrC9
	 kSs0A7qBWZBtkq6CGW+pMlUyGi6wpF7fEy2Cz05Zg/+QJrbKi5G40k51/HFi4PSczp
	 3KDHWwoIUH2DahXmGe62zCgot+hZbMsArgpEMX1A5nrAgjE3QN9WTyq68VPkgwBzgo
	 S0FKuYmCDNfumFU2sulg8CWmLy50v+PVLNQnr096Q6SxN0mBv+jxRT+2c1UkQ+o63K
	 aeLziEgkBB/9g==
Content-Type: multipart/mixed; boundary="===============0888297971716850754=="
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <07102b1e6c5c45285463c936dd651626c381b2fea32726dc8d4fc76385e83db4@mail.kernel.org>
In-Reply-To: <20260813002618.3755631-2-tweek@google.com>
References: <20260813002618.3755631-2-tweek@google.com>
Subject: Re: [PATCH bpf-next 1/5] fs/kernel_read_file,selinux: Add BPF_LOADER constant
From: bot+bpf-ci@kernel.org
To: tweek@google.com,paul@paul-moore.com,stephen.smalley.work@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,jeffv@google.com
Cc: tweek@google.com,omosnace@redhat.com,ericsu@linux.microsoft.com,bboscaccy@linux.microsoft.com,sidnayyar@google.com,nkapron@google.com,ebiggers@google.com,gregkh@linuxfoundation.org,kpsingh@kernel.org,bpf@vger.kernel.org,selinux@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 01:25:16 +0000 (UTC)

--===============0888297971716850754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
> index d613a7b4dd35a..fbcaf41c1b734 100644
> --- a/include/linux/kernel_read_file.h
> +++ b/include/linux/kernel_read_file.h
> @@ -15,6 +15,7 @@
>  	id(POLICY, security-policy)		\
>  	id(X509_CERTIFICATE, x509-certificate)	\
>  	id(MODULE_COMPRESSED, kernel-module-compressed) \
> +	id(BPF_LOADER, bpf-loader) \
>  	id(MAX_ID, )

[ ... ]

> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 90cb61b164256..453522ca87df8 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -65,7 +65,7 @@ const struct security_class_mapping secclass_map[] = {
>  	  { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
>  	    "module_request", "module_load", "firmware_load",
>  	    "kexec_image_load", "kexec_initramfs_load", "policy_load",
> -	    "x509_certificate_load", NULL } },
> +	    "x509_certificate_load", "bpf_load", NULL } },
>  	{ "capability", { COMMON_CAP_PERMS, NULL } },

Does "bpf_load" match the pattern the rest of class 'system' follows?

Every other kernel_read_file-derived permission follows the pattern
<lowercase_id>_load:

  id(MODULE, ...)           -> "module_load"
  id(FIRMWARE, ...)         -> "firmware_load"
  id(KEXEC_IMAGE, ...)      -> "kexec_image_load"
  id(KEXEC_INITRAMFS, ...)  -> "kexec_initramfs_load"
  id(POLICY, ...)           -> "policy_load"
  id(X509_CERTIFICATE, ...) -> "x509_certificate_load"
  id(BPF_LOADER, ...)       -> "bpf_load"  <-- drops "loader"

Following that pattern, wouldn't "bpf_loader_load" read more consistently
here - especially since the 'bpf' class separately gains "loader_load_fd"
later in the series (commit f0d1e716f1dc8)?

The shortened name is also ambiguous: the 'bpf' class already has
"prog_load" for loading BPF programs, and this permission specifically
gates kernel_read_file() operations on loader ELF files, not BPF in
general. SELinux permission names become policy ABI once merged.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31655295294
--===============0888297971716850754==--
