Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0535742AA3
	for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077115; cv=none; b=nFluAow7UMOnyYFq0hP48IafvHiiuDLaW+Kdbfa21VZE5CxrG+7UJzc4wauco39nRLsU86aKR7/y0o5XmZa1DP8ZciC1uzPB2de2iJ43bPPpi54eVfNTN94eQfJWtqFjucSw2lzrvO9coxsIRJeyVRUGkLxTRe6l/TVOyGcGUVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077115; c=relaxed/simple;
	bh=U19G9rYas4O7o6akb2ZeMMsqjbJm5q6So25IGH3ve4I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Nw8AUxX7GvqTBv9cw1U4xcHNY2uY+yxDTYJI7OtxDuSIhY7R6wq8mtM1rdJ+5/NnQGpoiDbTd3TIzKaC5DlM0RrAKQ+XJ253iMvrjOqc2Ob/E3/SvFbZjCL+WemkpmMkDNhWrWtbaRey/Q8bXv8TKrUs+RtoL4RUlAmmMGWO8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfZuUE99; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfZuUE99"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738077112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=PmEnc8aZMvudVyRuXVLEdlDFEJU60rJysidCyVa3v6g=;
	b=bfZuUE99L5SzCX33v04XG2SJoE0g2om/AeVDoVcjdq52wG1lU0G01FebkSD+0dMj32Uq8/
	7hG7Vogl9AdYVuHCWG+h6fJ/4jr5GRwIZeEk8W+6O2i4XnZkd1wHF4UtNQg/HpnfFkhCAU
	gU7TVntSvsZOIXJDffKbnWEeaodawaU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-UWW1p_17PA-W4qJ9wrX_jw-1; Tue, 28 Jan 2025 10:11:51 -0500
X-MC-Unique: UWW1p_17PA-W4qJ9wrX_jw-1
X-Mimecast-MFC-AGG-ID: UWW1p_17PA-W4qJ9wrX_jw
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef9da03117so16146022a91.1
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 07:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738077109; x=1738681909;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmEnc8aZMvudVyRuXVLEdlDFEJU60rJysidCyVa3v6g=;
        b=naEMiDdu4omX7Ns27zyV+Ed5CR/Ask6amkKTisbydAZE+kYfi1Em1c6TAq6L4lXOID
         A6wo7s/ekSHdayUlh3E9vsA2S800UEFmlQVZ5wu3HcnM9gt5MRo1tGxgx9FbVsrYYSlg
         8pag7Jg29kdQzfv65Q49YD7CmmfgvQZaRbrsE2g0aHW1aEkBHy+gogHWClkMJpjWsXS4
         YtsYOvkbUOTrtwvbTBmHCFCrAxwi81TFXdfso0G5K8paxoxTVYKAz25++mcVw8nmpXga
         RD556NresbcvP2FHUdxnjkAH2UglxaQBOcGmoVprpJDZFedfmekfiP+q6aZ0walAbAM/
         R50A==
X-Gm-Message-State: AOJu0Yz7cKhDkMmOmF73E1L0pN0jZCwRbWp/WyqgbHsHxaItCIfBygNm
	q5bUYptlmSdXwzM0/xwGM8d9b3RfYiKSoMnrMueK5UZfPjUcAcmtrFqbTSgGIG6Ni57mgvbYNLZ
	9OKrSpcP+Ly2hxV5PzOJIOAmteY4ewzLhD7kZ9H6eyE+i+Qr6tuDI+tu4MCN3mL6kZjRdYECKLf
	yzFLVu86HewQ6C3G6rh8T9Ni/Q2fjsF657IyA+hBvn
X-Gm-Gg: ASbGncsvyQ2kfLvvqoY9kjJVCW7qGlntT4PZB1Ni6lvztoOoSFYn0IHjQ+mBg4FBsP4
	QYsvMtsWNABA2CHv1BFjveZEaGzvAZjdPbdmNA6mOIf+AGlC5AkShiTWTeWqW8g==
X-Received: by 2002:a17:90b:54cb:b0:2ee:dcf6:1c8f with SMTP id 98e67ed59e1d1-2f782cb4d3fmr73933535a91.16.1738077109042;
        Tue, 28 Jan 2025 07:11:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVuAqid8l261AvcewaaJyrZCq5pAK/HLABrN8g/gy3qUhi4orarE+P7kB2Sn69rSVs+sjeKfRF35gX9FFFip4=
X-Received: by 2002:a17:90b:54cb:b0:2ee:dcf6:1c8f with SMTP id
 98e67ed59e1d1-2f782cb4d3fmr73933495a91.16.1738077108725; Tue, 28 Jan 2025
 07:11:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 28 Jan 2025 16:11:37 +0100
X-Gm-Features: AWEUYZl3dxWVFkNUJi2YPa30o-HV49eK32n-VcwiJ1GnbBVAnp90ALmoYAgeQzA
Message-ID: <CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com>
Subject: ls from coreutils 9.6 doesn't show labels of some files
To: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

In a recent commit [1] that has already made it into the coreutils
package in Fedora Rawhide, ls changed the way it retrieves security
labels from files, which causes the SELinux label not to be displayed
with -Z for some files. It seems that the key difference is that it
now relies on the result of llistxattr(2) to determine if the label
should be retrieved and if security.selinux is not listed, it just
prints ? as if the file had no label. On some inodes on some
filesystems (e.g. the root inode on tmpfs or most sysfs inodes),
however, security.selinux is not currently returned in *listxattr(2),
so the labels are not shown even though they are there (and would be
returned in a *getxattr(2) call).

We can of course ask coreutils to go back to fetching the label
unconditionally, but perhaps we should also/instead fix the
*listxattr(2) output to be correct? IIUC, in some cases it's a matter
of adding a security_inode_init_security() call, while other ones may
need a hook for listxattr that would inject the security.selinux entry
when it's not returned by the filesystem already.

[1] https://git.savannah.gnu.org/cgit/coreutils.git/commit/?id=4ce432ad8738387f1b2e80e883dc7080df3afabe

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

