Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDEF1468E8
	for <selinux@vger.kernel.org>; Fri,  2 Feb 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887929; cv=none; b=R6esXzFHTkx8RcKoK4IWLD1yyy2NPjR2Je7YHmQiWvL0wl4Vz+LK9kKZ0aC9IHXJnR6sGujn32jJLIPa5+7DxDTNCwc9HvOyTTG6ftXX+iRzP46Y7GshNZXiX3fccFMSOgLUnL++6BGp5BtpnuWZHpbwsnUAVBD4CR2kUPRitEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887929; c=relaxed/simple;
	bh=LB2tM7M/vojvvD9pvT8qCxaHqoBfTDEqvLcRwrwirJ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JqT9hhq3SolIU4+IKaS3pORqHm19pyz9pyIVR4oolMjDjeaiyuf6KA3fL1aUD+H06N2fox8SOpJdAcOcSLPLhTBHAs/6a+iiWoDRctBMgcXp7YB68ZZ8iVhauGpZuBnWBzzjTkKH6+gBYhrZIrvpCuCN52IE8qItv1d+1PK70H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHremUk/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHremUk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706887926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=IM5ZcaZa7yAGe/RxsbA0xm4coNhAXOwcBQuiu+U+L9A=;
	b=BHremUk/pC1rgp7l97kqqOvvgd9VtYx8AWzbGE1FkEB9PkJI+hSzUX2XrUt/nFSIZ0D+1g
	XyfWTkqxEeopVLZHszwcCPl8AktYzFel/nSSlbLnxqEtGBoficbrBjMf6syMAUQwsgEtJg
	rg8cKZebEK0iVNUPTCI2yy/VsaiWcZw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-UVTLm3R3MLu36DK62gPQSA-1; Fri, 02 Feb 2024 10:32:05 -0500
X-MC-Unique: UVTLm3R3MLu36DK62gPQSA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2964d402267so391692a91.2
        for <selinux@vger.kernel.org>; Fri, 02 Feb 2024 07:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887924; x=1707492724;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IM5ZcaZa7yAGe/RxsbA0xm4coNhAXOwcBQuiu+U+L9A=;
        b=JRy8UOsYSalq7S1dIUg52oQIWDPgbg6WmnelAsQr95V5LhRh+VeiLvJdrM0/05Ja8S
         qjN3grLDKLWL5uw+VXT4cLxbnDNbbaibzuACsEs6TFckLUlf/bAy1yZ5/A7uD7VeojNY
         HlONzrkg3WWjL0QlQvpA8C5qK78aOEicQRZ85uTwvbf9qMPSIZc4Ce0Phr7Z5yBEMY3b
         c+mkwf6pb7RPJ4DJr0yg+LKGJVH0in/pmTT63gLB7BE8wApeXEcD6p66ielY5ZjRbqfw
         67JdO+pQ7CXDNanBGCOzw5w2hj0Rp9etK6ZrxMGqp3TvY+qhmA/50qtceAPjTdNiQUNR
         c+Zw==
X-Gm-Message-State: AOJu0YyznVzb3hpOp/Rhvdo4R1eSAvo8NC37wpWnCSEd+CuVHeLYg02X
	yvgv93vuYhtki/U6hJA4d2RL9i/Eu/HKRnCWTPHENvXjrUMeBuhPy1y843lLAlsc9/2/4bRVsIX
	oXc2JQjP1P0HTJ3HLpOEqvAEStTmLCYh3l9+jqJ+ecrlvdudTgE47CvMHbCcK1zOLsAON/W5RVi
	qSGKUWMDzdNNOdkkacabq1gQpayxmvF7PX0KKQYBlR
X-Received: by 2002:a17:90a:744e:b0:295:e24b:62e with SMTP id o14-20020a17090a744e00b00295e24b062emr7819864pjk.6.1706887923812;
        Fri, 02 Feb 2024 07:32:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF03sJR3jRWqPFscANuSc2fRI9wXu+W40DwRQn5GP605LFjRa33EKNRS0ysXmGh0QHmT1WpDp6Hp9YV+m8zQC4=
X-Received: by 2002:a17:90a:744e:b0:295:e24b:62e with SMTP id
 o14-20020a17090a744e00b00295e24b062emr7819845pjk.6.1706887923501; Fri, 02 Feb
 2024 07:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 2 Feb 2024 16:31:51 +0100
Message-ID: <CAFqZXNu2V-zV2UHk5006mw8mjURdFmD-74edBeo-7ZX5LJNXag@mail.gmail.com>
Subject: Calls to vfs_setlease() from NFSD code cause unnecessary CAP_LEASE
 security checks
To: linux-nfs <linux-nfs@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

In [1] a user reports seeing SELinux denials from NFSD when it writes
into /proc/fs/nfsd/threads with the following kernel backtrace:
 => trace_event_raw_event_selinux_audited
 => avc_audit_post_callback
 => common_lsm_audit
 => slow_avc_audit
 => cred_has_capability.isra.0
 => security_capable
 => capable
 => generic_setlease
 => destroy_unhashed_deleg
 => __destroy_client
 => nfs4_state_shutdown_net
 => nfsd_shutdown_net
 => nfsd_last_thread
 => nfsd_svc
 => write_threads
 => nfsctl_transaction_write
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

It seems to me that the security checks in generic_setlease() should
be skipped (at least) when called through this codepath, since the
userspace process merely writes into /proc/fs/nfsd/threads and it's
just the kernel's internal code that releases the lease as a side
effect. For example, for vfs_write() there is kernel_write(), which
provides a no-security-check equivalent. Should there be something
similar for vfs_setlease() that could be utilized for this purpose?

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2248830

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

